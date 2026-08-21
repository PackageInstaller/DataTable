require("base_service")
_class("AutoBeadServiceLogic", BaseService)
AutoBeadServiceLogic = AutoBeadServiceLogic

function AutoBeadServiceLogic:InitAutoBeadHolder(teamEntity)
  local entityService = self._world:GetService("LogicEntity")
  local skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.AutoBeadSkillHolder)
  if skillHolder then
    local holderID = skillHolder:GetID()
    local cTeam = teamEntity:Team()
    cTeam:SetAutoBeadSkillHolderID(holderID)
    local firstElement = ElementType.ElementType_Green
    local secondElement = ElementType.ElementType_Green
    local attack = 50000
    local attributeCmpt = skillHolder:Attributes()
    attributeCmpt:SetSimpleAttribute("Element", firstElement)
    attributeCmpt:Modify("Attack", attack)
    skillHolder:ReplaceElement(firstElement, secondElement)
    local pos = teamEntity:GetGridPosition()
    local dir = teamEntity:GetGridDirection()
    skillHolder:SetGridLocation(pos, dir)
    local rideEntity = teamEntity
    local mountEntity = skillHolder
    local ridGridLocationCmpt = rideEntity:GridLocation()
    ridGridLocationCmpt:SetModifyLocationCallback(function(pos, dir)
      self:SetTargetLocation(pos, dir, mountEntity)
    end)
  end
end

function AutoBeadServiceLogic:InitAutoBead(teamEntity)
  local holderEntity = self:GetAutoBeadSkillHolder(teamEntity)
  if holderEntity then
    local createInfo = self._world.BW_WorldInfo:GetSeasonMazeCreateInfo()
    if createInfo then
      local autoBeadList = createInfo.autobead_list
      holderEntity:ReplaceLogicAutoBead(autoBeadList)
      local autoBeadInnerDataList = {}
      for index, data in ipairs(autoBeadList) do
        local createData = data
        local beadID = createData.bead_id
        if beadID == 0 then
        else
          local cfg = Cfg.cfg_component_season_maze_autobead[beadID]
          if cfg then
            local autoBeadInnerData = AutoBeadInnerData:New()
            autoBeadInnerData:InitByDataAndCfg(createData, cfg)
            table.insert(autoBeadInnerDataList, autoBeadInnerData)
          end
        end
      end
      local autoBeadCmpt = holderEntity:LogicAutoBead()
      if autoBeadCmpt then
        autoBeadCmpt:SetAttachTeamEntityID(teamEntity:GetID())
        autoBeadCmpt:SetAutoBeadInnerDataList(autoBeadInnerDataList)
      end
      self:CalcAutoBeadNeedEnergy(teamEntity)
      if autoBeadCmpt then
        local seasonMazeService = self._world:GetService("SeasonMaze")
        local outerEnergy = seasonMazeService:GetAutoBeadEnergy() or 0
        self:_SetAutoBeadPoint(teamEntity, outerEnergy)
      end
    end
  end
end

function AutoBeadServiceLogic:CalcAutoBeadNeedEnergy(teamEntity)
  local holderEntity = self:GetAutoBeadSkillHolder(teamEntity)
  if holderEntity then
    local autoBeadCmpt = holderEntity:LogicAutoBead()
    if autoBeadCmpt then
      local dataList = autoBeadCmpt:GetAutoBeadInnerDataList()
      local totalEnergy = 0
      for index, data in ipairs(dataList) do
        local innerData = data
        local needEnergy = innerData:GetAutoBeadAttr(ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Energy)
        totalEnergy = totalEnergy + needEnergy
      end
      local pointEachPower = totalEnergy
      pointEachPower = math.floor(pointEachPower)
      autoBeadCmpt:SetAutoBeadPointEachPower(pointEachPower)
    end
  end
end

function AutoBeadServiceLogic:InitAutoBeadBuff(GameStartBuffs)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local holderEntity = self:GetAutoBeadSkillHolder(teamEntity)
  if not holderEntity then
    return
  end
  local buffLogic = self._world:GetService("BuffLogic")
  local autoBeadCmpt = holderEntity:LogicAutoBead()
  if not autoBeadCmpt then
    return
  end
  local baseChargeBuffID = BattleConst.AutoBeadBaseChargeBuffID
  local baseBuffTargetType = BuffTargetType.AutoBeadHolder
  local baseBuffTargetParam = {}
  local ret = buffLogic:AddBuffByTargetType(baseChargeBuffID, baseBuffTargetType, baseBuffTargetParam)
  for _, inst in ipairs(ret) do
    GameStartBuffs[#GameStartBuffs + 1] = {
      inst:Entity(),
      inst:BuffSeq()
    }
  end
  local dataList = autoBeadCmpt:GetAutoBeadInnerDataList()
  for index, data in ipairs(dataList) do
    local innerData = data
    local buffIDList, targetType, targetParam = innerData:GetAutoBeadBuff()
    if buffIDList and 0 < #buffIDList then
      for index, buffID in ipairs(buffIDList) do
        local buffTargetType = targetType
        local buffTargetParam = targetParam
        local ret = buffLogic:AddBuffByTargetType(buffID, buffTargetType, buffTargetParam)
        for _, inst in ipairs(ret) do
          GameStartBuffs[#GameStartBuffs + 1] = {
            inst:Entity(),
            inst:BuffSeq()
          }
        end
      end
    end
  end
end

function AutoBeadServiceLogic:SetTargetLocation(pos, dir, targetEntity)
  if not targetEntity:HasGridLocation() then
    return
  end
  local gridLocCmpt = targetEntity:GridLocation()
  gridLocCmpt:CallBackModifyLocation(pos, dir)
end

function AutoBeadServiceLogic:GetAutoBeadSkillHolder(teamEntity)
  if teamEntity then
    local cTeam = teamEntity:Team()
    if cTeam then
      local holderID = cTeam:GetAutoBeadSkillHolderID()
      if holderID and 0 < holderID then
        local holderEntity = self._world:GetEntityByID(holderID)
        if holderEntity then
          return holderEntity
        end
      end
    end
  end
end

function AutoBeadServiceLogic:_DoLogicCalcAutoBeadSkill(teamEntity)
  if self._world:RunAtServer() then
    local holderEntity = self:GetAutoBeadSkillHolder(teamEntity)
    if holderEntity then
      local skillAutoBeadData = holderEntity:SkillAutoBeadAttackData()
      skillAutoBeadData:ClearAutoBeadAttackData()
    end
  end
  local holderEntity = self:GetAutoBeadSkillHolder(teamEntity)
  if not holderEntity then
    return
  end
  local skillLogicService = self._world:GetService("SkillLogic")
  local battleStatCmpt = self._world:BattleStat()
  if self:CanCalcAutoBeadSkill(teamEntity) then
    local skillCastPos = teamEntity:GridLocation():GetGridPos()
    holderEntity:SetGridPosition(skillCastPos)
    skillLogicService:CalcAutoBeadSkillDamage(teamEntity, skillCastPos)
  else
  end
end

function AutoBeadServiceLogic:CanCalcAutoBeadSkill(teamEntity)
  if teamEntity:HasTeamDeadMark() then
    return false
  end
  return true
end

function AutoBeadServiceLogic:GetAutoBeadCmpt(teamEntity)
  local holderEntity = self:GetAutoBeadSkillHolder(teamEntity)
  if holderEntity then
    local autoBeadCmpt = holderEntity:LogicAutoBead()
    if autoBeadCmpt then
      return autoBeadCmpt
    end
  end
end

function AutoBeadServiceLogic:_SetAutoBeadPoint(teamEntity, point)
  local autoBeadCmpt = self:GetAutoBeadCmpt(teamEntity)
  if autoBeadCmpt then
    autoBeadCmpt:SetAutoBeadPoint(point)
  end
end

function AutoBeadServiceLogic:GetAutoBeadPoint(teamEntity)
  local autoBeadCmpt = self:GetAutoBeadCmpt(teamEntity)
  if autoBeadCmpt then
    local curPoint = autoBeadCmpt:GetAutoBeadPoint()
    return curPoint
  end
end

function AutoBeadServiceLogic:AddAutoBeadPoint(teamEntity, point)
  local autoBeadCmpt = self:GetAutoBeadCmpt(teamEntity)
  if autoBeadCmpt then
    local oldPoint = autoBeadCmpt:GetAutoBeadPoint()
    local curPoint = oldPoint + point
    autoBeadCmpt:SetAutoBeadPoint(curPoint)
    local seasonMazeService = self._world:GetService("SeasonMaze")
    seasonMazeService:AddOuterAutoBeadEnergy(point)
  end
end

function AutoBeadServiceLogic:SubAutoBeadPoint(teamEntity, point)
  local autoBeadCmpt = self:GetAutoBeadCmpt(teamEntity)
  if autoBeadCmpt then
    local oldPoint = autoBeadCmpt:GetAutoBeadPoint()
    local curPoint = oldPoint - point
    curPoint = math.max(0, curPoint)
    local realCost = oldPoint - curPoint
    autoBeadCmpt:SetAutoBeadPoint(curPoint)
    local seasonMazeService = self._world:GetService("SeasonMaze")
    seasonMazeService:SubOuterAutoBeadEnergy(realCost)
  end
end

function AutoBeadServiceLogic:GetAutoBeadPointEachPower(teamEntity)
  local autoBeadCmpt = self:GetAutoBeadCmpt(teamEntity)
  if autoBeadCmpt then
    local point = autoBeadCmpt:GetAutoBeadPointEachPower()
    return point
  end
end

function AutoBeadServiceLogic:GetAutoBeadList(teamEntity)
  local autoBeadCmpt = self:GetAutoBeadCmpt(teamEntity)
  if autoBeadCmpt then
    local list = autoBeadCmpt:GetAutoBeadList()
    return list
  end
end
