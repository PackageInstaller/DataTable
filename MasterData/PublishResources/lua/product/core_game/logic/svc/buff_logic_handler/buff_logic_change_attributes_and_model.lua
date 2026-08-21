_class("BuffLogicChangeAttributesAndModel", BuffLogicBase)
BuffLogicChangeAttributesAndModel = BuffLogicChangeAttributesAndModel

function BuffLogicChangeAttributesAndModel:Constructor(buffInstance, logicParam)
  self._monsterClassIDArray = logicParam.monsterClassIDArray
  self._attributePercent = logicParam.attributePercent or 1
  self._attributeAttack = logicParam.attributeAttack or 0
  self._attributeDefense = logicParam.attributeDefense or 0
  self._attributeEvade = logicParam.attributeEvade or 0
  self._attributeHP = logicParam.attributeHP or 0
  self._usePetModel = logicParam.usePetModel
  self._posIndex = logicParam.posIndex
end

function BuffLogicChangeAttributesAndModel:DoLogic(notify)
  local targetMonsterID
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    local monsterID = monsterEntity:MonsterID():GetMonsterID()
    local monsterClassID = 0
    local cfg = Cfg.cfg_monster[monsterID]
    if cfg and cfg.ClassID then
      monsterClassID = cfg.ClassID
    end
    if table.intable(self._monsterClassIDArray, monsterClassID) then
      targetMonsterID = monsterID
      break
    end
  end
  if not targetMonsterID then
    return
  end
  local configService = self._world:GetService("Config")
  local monsterConfigData = configService:GetMonsterConfigData()
  local attack = monsterConfigData:GetMonsterAttack(targetMonsterID)
  local defense = monsterConfigData:GetMonsterDefense(targetMonsterID)
  local nEvade = monsterConfigData:GetMonsterEvade(targetMonsterID)
  local hp = monsterConfigData:GetMonsterHealth(targetMonsterID)
  local elementType = monsterConfigData:GetMonsterElementType(targetMonsterID)
  attack = math.floor(attack * (self._attributePercent + self._attributeAttack))
  defense = math.floor(defense * (self._attributePercent + self._attributeDefense))
  nEvade = math.floor(nEvade * (self._attributePercent + self._attributeEvade))
  hp = math.floor(hp * (self._attributePercent + self._attributeHP))
  local attributeCmpt = self._entity:Attributes()
  attributeCmpt:Modify("Attack", attack)
  attributeCmpt:Modify("Defense", defense)
  attributeCmpt:Modify("Evade", nEvade)
  attributeCmpt:Modify("HP", hp)
  attributeCmpt:Modify("MaxHP", hp)
  Log.debug("BuffLogicChangeAttributesAndModel ModifyHP =", hp, " defender=", self._entity:GetID())
  self._entity:ReplaceElement(elementType, nil)
  attributeCmpt:SetSimpleAttribute("Element", elementType)
  if self._usePetModel and self._usePetModel == 1 then
    local entityPos = self._entity:GridLocation():GetGridPos()
    local posIndex = 0
    for i = 1, #self._posIndex do
      local posX = self._posIndex[i][1]
      local posY = self._posIndex[i][2]
      if entityPos.x == posX and entityPos.y == posY then
        posIndex = i
        break
      end
    end
    local teamEntity = self._world:Player():GetLocalTeamEntity()
    local teamOrder = teamEntity:Team():GetTeamOrder()
    if posIndex > #teamOrder then
      posIndex = #teamOrder
    end
    if posIndex == 0 then
      local randomSvc = self._world:GetService("RandomLogic")
      posIndex = randomSvc:LogicRand(1, #teamOrder)
    end
    local petID = teamOrder[posIndex]
    local utilDataSvc = self._world:GetService("UtilData")
    local petEntityId = utilDataSvc:GetEntityIDByPstID(petID)
    self._world:EventDispatcher():Dispatch(GameEventType.DataBuffValue, self._entity:GetID(), "ChangeModelWithPetIndex", petEntityId)
  end
end
