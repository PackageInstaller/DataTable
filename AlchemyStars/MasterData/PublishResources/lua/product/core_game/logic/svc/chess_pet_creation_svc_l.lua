_class("ChessPetCreationServiceLogic", BaseService)
ChessPetCreationServiceLogic = ChessPetCreationServiceLogic

function ChessPetCreationServiceLogic:GenerateChessPetCreationResult()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
  local chessPetList = group:GetEntities()
  local creationResultList = {}
  for _, v in ipairs(chessPetList) do
    local res = self:GenerateOneChessPetResult(v)
    creationResultList[#creationResultList + 1] = res
  end
  return creationResultList
end

function ChessPetCreationServiceLogic:GenerateOneChessPetResult(chessPetEntity)
  local cfgSvc = self._world:GetService("Config")
  local chessPetConfigData = cfgSvc:GetChessPetConfigData()
  local res = DataChessPetCreationResult:New()
  local eid = chessPetEntity:GetID()
  res:SetChessPetEntityID(eid)
  local elementCmpt = chessPetEntity:Element()
  local elementType = elementCmpt:GetPrimaryType()
  res:SetChessPetElement(elementType)
  local chessPetCmpt = chessPetEntity:ChessPet()
  local chessPetTemplateID = chessPetCmpt:GetChessPetClassID()
  local chessPetID = chessPetCmpt:GetChessPetID()
  res:SetChessPetTemplateID(chessPetTemplateID)
  local chessPetResPath = chessPetConfigData:GetChessPetResPath(chessPetID)
  res:SetChessPetResPath(chessPetResPath)
  local hpOffset = chessPetConfigData:GetChessPetHPHeightOffset(chessPetID)
  res:SetChessPetHPOffset(hpOffset)
  local attrCmpt = chessPetEntity:Attributes()
  local maxhp = attrCmpt:CalcMaxHp()
  res:SetChessPetMaxHP(maxhp)
  local curHp = attrCmpt:GetCurrentHP()
  res:SetChessPetHP(curHp)
  local gridLocRes = self:GetChessPetCreationGridLocResult(chessPetEntity)
  res:SetChessPetGridLocResult(gridLocRes)
  return res
end

function ChessPetCreationServiceLogic:GetChessPetCreationGridLocResult(chessPetEntity)
  local gridLocCmpt = chessPetEntity:GridLocation()
  local gridLocRes = DataGridLocationResult:New()
  gridLocRes:SetGridLocResultBornPos(gridLocCmpt:GetGridPos())
  gridLocRes:SetGridLocResultBornDir(gridLocCmpt:GetGridDir())
  gridLocRes:SetGridLocResultBornHeight(gridLocCmpt:GetGridLocHeight())
  gridLocRes:SetGridLocResultBornOffset(gridLocCmpt:GetGridOffset())
  gridLocRes:SetGridLocResultDamageOffset(gridLocCmpt:GetDamageOffset())
  return gridLocRes
end

function ChessPetCreationServiceLogic:GetCreateADH(monsterID)
  local cfgService = self._configService
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local attack = monsterConfigData:GetMonsterAttack(monsterID)
  local defense = monsterConfigData:GetMonsterDefense(monsterID)
  local hp = monsterConfigData:GetMonsterHealth(monsterID)
  return attack, defense, hp
end

function ChessPetCreationServiceLogic:CreateMonster(monsterTransform)
  return self:__createMonster(monsterTransform, nil)
end

function ChessPetCreationServiceLogic:CreateMonsterWithInitADH(monsterTransform, attack, defense, maxhp, curhp, airt, bindeff, buffrt)
  attack = attack ~= nil and math.floor(attack) or nil
  defense = defense ~= nil and math.floor(defense) or nil
  maxhp = maxhp ~= nil and math.floor(maxhp) or nil
  curhp = curhp ~= nil and math.floor(curhp) or nil
  return self:__createMonster(monsterTransform, {
    attack = attack,
    defense = defense,
    maxhp = maxhp,
    curhp = curhp,
    airt = airt,
    bindeff = bindeff,
    buffrt = buffrt
  })
end

function ChessPetCreationServiceLogic:__createMonster(monsterTransform, _InitMonsterAttributes)
  local cfgSvc = self._world:GetService("Config")
  local chessPetConfigData = cfgSvc:GetChessPetConfigData()
  local chessPetID = monsterTransform:GetMonsterID()
  local chessPetPosition = monsterTransform:GetPosition()
  local dir = monsterTransform:GetForward()
  local chessPetConfig = Cfg.cfg_chesspet[chessPetID]
  if not chessPetConfig then
    Log.fatal("Cfg chessPetConfig Not Find ID:", chessPetID)
    return
  end
  local chessPetClassID = chessPetConfigData:GetChessPetClassID(chessPetID)
  local areaArray = chessPetConfigData:GetChessPetArea(chessPetID)
  local positionOffset = chessPetConfigData:GetChessPetOffset(chessPetID)
  local damageOffset = chessPetConfigData:GetChessPetDamageOffset(chessPetID)
  local block = chessPetConfigData:Block(chessPetID)
  local chessPetRaceType = chessPetConfigData:GetChessPetRaceType(chessPetID)
  local chessPetSkillIDs = chessPetConfigData:GetSkillIDs(chessPetID)
  local attack = chessPetConfigData:GetChessPetAttack(chessPetID)
  local defense = chessPetConfigData:GetChessPetDefense(chessPetID)
  local maxhp = chessPetConfigData:GetChessPetHealth(chessPetID)
  local curhp = maxhp
  local elementType = chessPetConfigData:GetChessPetElementType(chessPetID)
  local sEntity = self._world:GetService("LogicEntity")
  local chessPetEntity = sEntity:CreateLogicEntity(EntityConfigIDConst.ChessPet)
  chessPetEntity:ReplaceChessPet(chessPetID, chessPetClassID, chessPetRaceType)
  local chessPetComponent = chessPetEntity:ChessPet()
  chessPetComponent:SetSkillID(chessPetSkillIDs)
  chessPetEntity:ReplaceBodyArea(areaArray)
  chessPetEntity:SetGridLocationAndOffset(chessPetPosition, dir, positionOffset, damageOffset)
  local boardService = self._world:GetService("BoardLogic")
  local blockFlag = boardService:GetBlockFlagByBlockId(block)
  chessPetEntity:ReplaceBlockFlag(blockFlag)
  boardService:UpdateEntityBlockFlag(chessPetEntity, chessPetPosition, chessPetPosition)
  if maxhp < curhp then
    curhp = maxhp
  end
  local attributeCmpt = chessPetEntity:Attributes()
  attributeCmpt:Modify("Attack", attack)
  attributeCmpt:Modify("HP", curhp)
  attributeCmpt:Modify("MaxHP", maxhp)
  chessPetEntity:ReplaceElement(elementType, nil)
  attributeCmpt:SetSimpleAttribute("Element", elementType)
  local monsterBornBuffContext = {isMonsterBornBuff = true}
  local buffList = chessPetConfigData:GetBornBuffList(chessPetID)
  if buffList and 0 < #buffList then
    local buffLogic = self._world:GetService("BuffLogic")
    if not chessPetEntity:HasBuff() then
      chessPetEntity:AddBuffComponent()
    end
    for _, buffId in ipairs(buffList) do
      buffLogic:AddBuff(buffId, chessPetEntity, monsterBornBuffContext)
    end
  end
  return chessPetEntity, chessPetID
end

function ChessPetCreationServiceLogic:CreateInternalRefreshMonsterLogic(monsterRefreshParamArray)
  local entityService = self._world:GetService("LogicEntity")
  local eMonsterList = {}
  for _, monsterRefreshParam in ipairs(monsterRefreshParamArray) do
    local monsterPosList = self:_CalcInternalRefreshMonsterPos(monsterRefreshParam)
    local eMonsters, monsterIds = self:CreateMonsters(monsterPosList)
    table.appendArray(eMonsterList, eMonsters)
  end
  return eMonsterList
end

function ChessPetCreationServiceLogic:_GetInternalRefreshConfigData()
  local levelConfigData = self._configService:GetLevelConfigData()
  local waveNum = self:_GetBattleStatComponent():GetCurWaveIndex()
  local monsterConfigDataArray = levelConfigData:GetLevelWaveInternalRefreshData(waveNum)
  return monsterConfigDataArray
end

function ChessPetCreationServiceLogic:_CalcInternalRefreshMonsterPos(monsterRefreshParam)
  local createMonsterPosService = self._world:GetService("CreateMonsterPos")
  local chessPetArray = {}
  local chessPetIDArray = monsterRefreshParam:GetChessPetIDArray()
  local chessPetPosArray = monsterRefreshParam:GetChessPetPosArray()
  local chessPetRotationArray = monsterRefreshParam:GetChessPetRotationArray()
  for i, monsterID in ipairs(chessPetIDArray) do
    local monsterPosition = chessPetPosArray[i]
    local monsterDir = Vector2(0, 0)
    if chessPetRotationArray then
    end
    local monsterTransformParam = MonsterTransformParam:New(monsterID)
    monsterTransformParam:SetPosition(monsterPosition)
    monsterTransformParam:SetRotation(monsterDir)
    monsterTransformParam:SetForward(monsterDir)
    chessPetArray[#chessPetArray + 1] = monsterTransformParam
  end
  return chessPetArray
end

function ChessPetCreationServiceLogic:CreateMonsters(monsterArray)
  local eMonsters = {}
  local monsterIds = {}
  for _, v in ipairs(monsterArray) do
    local eMonster, monsterId = self:CreateMonster(v)
    table.insert(eMonsters, eMonster)
    table.insert(monsterIds, monsterId)
    self._world:GetSyncLogger():Trace({
      key = "CreateInternalMonsters",
      monsterID = monsterId,
      entityID = eMonster:GetID(),
      pos = tostring(v:GetPosition())
    })
  end
  return eMonsters, monsterIds
end

function ChessPetCreationServiceLogic:CalcAppearSkill(e)
  local sSkillLogic = self._world:GetService("SkillLogic")
  local utilDataSvc = self._world:GetService("UtilData")
  local appearSkillId = utilDataSvc:GetAppearSkillId(e)
  if appearSkillId and 0 < appearSkillId then
    sSkillLogic:CalcSkillEffect(e, appearSkillId)
    sSkillLogic:UpdateRenderSkillRoutine(e)
  end
end

function ChessPetCreationServiceLogic:_DoRefreshBoardGapTiles(fillPieceList)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardServiceRender = self._world:GetService("BoardRender")
  local oldGapTiles = boardServiceLogic:GetGapTiles()
  local newGapTiles = {}
  for i = 1, #oldGapTiles do
    local bFind = false
    for j = 1, #fillPieceList do
      if fillPieceList[j][1] == oldGapTiles[i][1] and fillPieceList[j][2] == oldGapTiles[i][2] then
        bFind = true
      end
    end
    if bFind ~= true then
      table.insert(newGapTiles, {
        oldGapTiles[i][1],
        oldGapTiles[i][2]
      })
    end
  end
  boardServiceLogic:ChangeGapTiles(newGapTiles)
  local addPiecePos = {}
  for i = 1, #fillPieceList do
    table.insert(addPiecePos, Vector2(fillPieceList[i][1], fillPieceList[i][2]))
  end
  local boardEntity = self._world:GetBoardEntity()
  local pieceFillTable = boardServiceLogic:SupplyPieceList(addPiecePos)
  local boardCmpt = boardEntity:Board()
  boardCmpt:FillPieces(pieceFillTable)
  for i, grid in ipairs(pieceFillTable) do
    local gridPos = Vector2(grid.x, grid.y)
    boardServiceRender:CreateGridEntity(grid.color, gridPos, false)
  end
end

function ChessPetCreationServiceLogic:MakePhantomLogic(result)
  local monsterTransformParam = MonsterTransformParam:New(result:GetTargetID())
  monsterTransformParam:SetPosition(result:GetBornPos())
  monsterTransformParam:SetRotation(result:GetBornRot())
  local phantomEntity, id = self:CreateMonster(monsterTransformParam)
  phantomEntity:AddPhantomComponent(result:GetOwnerID())
  local attributeCmpt = phantomEntity:Attributes()
  local maxHp = attributeCmpt:CalcMaxHp()
  local hp = math.floor(maxHp * result:GetHPPercent())
  attributeCmpt:SetSimpleAttribute("MaxHP", hp)
  attributeCmpt:SetSimpleAttribute("HP", hp)
  return phantomEntity
end

function ChessPetCreationServiceLogic:InitWorldBossHPData(entity, monsterID)
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local stage = monsterConfigData:GetWorldBossConfig(monsterID)
  local monsterIDCmpt = entity:MonsterID()
  monsterIDCmpt:InitWorldBossStageData(stage)
  monsterIDCmpt:SetWorldBossState(true)
end
