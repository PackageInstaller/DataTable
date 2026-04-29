require("auto_test_svc")
AutoTestDirType = {
  [1] = Vector2(0, 1),
  [2] = Vector2(1, 1),
  [3] = Vector2(1, 0),
  [4] = Vector2(1, -1),
  [5] = Vector2(0, -1),
  [6] = Vector2(-1, -1),
  [7] = Vector2(-1, 0),
  [8] = Vector2(-1, 1)
}
_class("AutoTestCheat", Object)
AutoTestCheat = AutoTestCheat

function AutoTestCheat:Constructor(world, svc)
  self._world = world
  self._svc = svc
end

function AutoTestCheat:FakeInputDoubleClick_Test(TT, args)
  local chainPath = {}
  chainPath[#chainPath + 1] = self._world:Player():GetLocalTeamEntity():GetGridPosition()
  local cmd = MovePathDoneCommand:New()
  cmd:SetChainPath(chainPath)
  cmd:SetElementType(PieceType.None)
  self._world:Player():SendCommand(cmd)
  local gameFsmCmpt = self._world:GameFSM()
  while gameFsmCmpt:CurStateID() == GameStateID.WaitInput do
    YIELD(TT, 100)
  end
end

function AutoTestCheat:FakeInputChain_Test(TT, args)
  local canMoveArrowService = self._world:GetService("CanMoveArrow")
  if canMoveArrowService then
    canMoveArrowService:ShowCanMoveArrow(false)
  end
  local pieceType = args.pieceType
  local chainPath = {}
  for i, v in ipairs(args.chainPath) do
    chainPath[#chainPath + 1] = Vector2.Index2Pos(v)
  end
  if #chainPath == 1 then
    local cmd = MovePathDoneCommand:New()
    cmd:SetChainPath(chainPath)
    cmd:SetElementType(PieceType.None)
    self._world:Player():SendCommand(cmd)
    local gameFsmCmpt = self._world:GameFSM()
    while gameFsmCmpt:CurStateID() == GameStateID.WaitInput do
      YIELD(TT, 100)
    end
    return
  end
  local previewEntity = self._world:GetPreviewEntity()
  local linklineService = self._world:GetService("LinkLine")
  local linkageRenderService = self._world:GetService("LinkageRender")
  local showPath = {}
  for _, pos in ipairs(chainPath) do
    table.insert(showPath, pos)
    linklineService:_OnPieceInsertIntoChain(showPath)
    previewEntity:ReplacePreviewChainPath(showPath, pieceType, PieceType.None)
    linkageRenderService:ShowLinkageInfo(showPath, pieceType)
    YIELD(TT, 100)
  end
  local isLocal = self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn
  self._world:EventDispatcher():Dispatch(GameEventType.FlushPetChainSkillItem, isLocal, #chainPath, pieceType)
  linklineService:ShowChainPathCancelArea(false)
  local pieceService = self._world:GetService("Piece")
  local boardService = self._world:GetService("BoardLogic")
  pieceService:RefreshPieceAnim()
  local cmd = MovePathDoneCommand:New()
  cmd:SetChainPath(chainPath)
  cmd:SetElementType(pieceType)
  self._world:Player():SendCommand(cmd)
  local linkageRenderService = self._world:GetService("LinkageRender")
  linkageRenderService:ClearLinkRender()
  local gameFsmCmpt = self._world:GameFSM()
  while gameFsmCmpt:CurStateID() == GameStateID.WaitInput do
    YIELD(TT, 100)
  end
end

function AutoTestCheat:FakeCastSkill_Test(TT, args)
  local e = self._svc:GetEntityByName_Test(args.name)
  local petID = e:PetPstID():GetPstID()
  local skillInfoCmpt = e:SkillInfo()
  local skillID = skillInfoCmpt:GetActiveSkillID()
  if args.skillIndex and args.skillIndex > 1 then
    local extraSkillID
    local extraSkillIndex = args.skillIndex - 1
    local extraSkillIDList = skillInfoCmpt:GetExtraActiveSkillIDList()
    if extraSkillIDList and 0 < #extraSkillIDList then
      extraSkillID = extraSkillIDList[extraSkillIndex]
    end
    if extraSkillID then
      skillID = extraSkillID
    else
      local variantSkillID
      local variantSkillIndex = args.skillIndex - 1
      local variantSkillInfo = skillInfoCmpt:GetVariantActiveSkillInfo()
      if variantSkillInfo then
        local variantSkillList = variantSkillInfo[skillID]
        if variantSkillList and 0 < #variantSkillList then
          variantSkillID = variantSkillList[variantSkillIndex]
        end
        if variantSkillID then
          skillID = variantSkillID
        end
      end
    end
  end
  self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 3)
  while GameStateID.PreviewActiveSkill ~= self._world:GameFSM():CurStateID() do
    YIELD(TT, 100)
  end
  YIELD(TT, 500)
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(skillID)
  local condition = skillConfigData:GetAutoFightCondition()
  local pickUpType = skillConfigData:GetSkillPickType()
  if pickUpType == SkillPickUpType.None then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AutoFightCastSkill, skillID, pickUpType, petID)
  elseif pickUpType == SkillPickUpType.PickUpUIAndTrap then
    local pickUpGridPos = {}
    local selectTeamPosUiid = {}
    local firstParam = args.pickUpPos[1]
    if firstParam < 100 then
      for i, v in ipairs(args.pickUpPos) do
        selectTeamPosUiid[#selectTeamPosUiid + 1] = v
      end
    end
    for i, v in ipairs(args.pickUpPos) do
      pickUpGridPos[#pickUpGridPos + 1] = Vector2.Index2Pos(v)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetBattlePet",
      uiid = self._world:GetPetData(petID).uiid,
      input = "OnUp",
      args = {}
    })
    YIELD(TT, 1000)
    local isMultiSkill, skillIndex = self:_CheckIsMultiActiveSkill(petEntity, skillID)
    if not isMultiSkill then
      isMultiSkill, skillIndex = self:_CheckIsVariantActiveSkill(petEntity, skillID)
    end
    if isMultiSkill then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetPetMultiActiveSkill",
        input = "SubSkillOnClick",
        args = {skillIndex}
      })
      YIELD(TT, 1000)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetPetMultiActiveSkill",
        input = "BtnGoOnClick",
        args = {}
      })
      YIELD(TT, 1000)
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetPetSkill",
        input = "btnGoOnClick",
        args = {skillIndex}
      })
      YIELD(TT, 1000)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetBattlePet",
      uiid = selectTeamPosUiid[1],
      input = "OnUp",
      args = {}
    })
    YIELD(TT, 1000)
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetChooseTarget",
      input = "HandleActiveSkillConfirm",
      args = {}
    })
  else
    local pickUpGridPos = {}
    for i, v in ipairs(args.pickUpPos) do
      pickUpGridPos[#pickUpGridPos + 1] = Vector2.Index2Pos(v)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetBattlePet",
      uiid = self._world:GetPetData(petID).uiid,
      input = "OnUp",
      args = {}
    })
    YIELD(TT, 500)
    local isMultiSkill, skillIndex = self:_CheckIsMultiActiveSkill(e, skillID)
    if isMultiSkill then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetPetMultiActiveSkill",
        input = "SubSkillOnClick",
        args = {skillIndex}
      })
      YIELD(TT, 1000)
    end
    for i, pos in ipairs(pickUpGridPos) do
      self:SetPickUpGrid_Test(skillID, petID, pos)
      YIELD(TT, 500)
    end
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetChooseTarget",
      input = "HandleActiveSkillConfirm",
      args = {}
    })
  end
  while GameStateID.ActiveSkill ~= self._world:GameFSM():CurStateID() do
    YIELD(TT, 100)
  end
end

function AutoTestCheat:_CheckIsMultiActiveSkill(petEntity, skillId)
  local isMultiSkill = false
  local skillIndex = 1
  local skillInfoCmpt = petEntity:SkillInfo()
  local activeSkillID = skillInfoCmpt:GetActiveSkillID()
  local extraSkillList = skillInfoCmpt:GetExtraActiveSkillIDList()
  if extraSkillList and 0 < #extraSkillList then
    isMultiSkill = true
    if skillId == activeSkillID then
      skillIndex = 1
    else
      for index, extraSkillId in ipairs(extraSkillList) do
        if skillId == extraSkillId then
          skillIndex = index + 1
          break
        end
      end
    end
  end
  return isMultiSkill, skillIndex
end

function AutoTestCheat:FakeCancelChainSkillCast_Test(TT, args)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideUIPreviewChain, false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveUIPreviewChainBtnOK, false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CancelChainSkillCast)
end

function AutoTestCheat:SetPickUpGrid_Test(skillID, petPstID, gridPos)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local activeSkillPickUpType = skillConfigData:GetSkillPickType()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  pickUpTargetCmpt:SetPickUpTargetType(activeSkillPickUpType)
  pickUpTargetCmpt:SetPickUpGridPos(gridPos)
  pickUpTargetCmpt:SetCurActiveSkillInfo(skillID, petPstID)
  renderBoardEntity:ReplacePickUpTarget()
end

function AutoTestCheat:WaitGameFsm_Test(TT, args)
  local gameFsmCmpt = self._world:GameFSM()
  while gameFsmCmpt:CurStateID() ~= args.id do
    YIELD(TT, 100)
  end
end

function AutoTestCheat:WaitGameOver_Test(TT, args)
  while not self._svc:IsGameOver_Test() do
    YIELD(TT, 1000)
  end
end

function AutoTestCheat:SetEntityPosition_Test(TT, args)
  local targetEntity = self._svc:GetEntityByName_Test(args.name)
  local posOld = targetEntity:GetGridPosition()
  local posNew = Vector2.Index2Pos(args.pos)
  if posOld == posNew then
    return
  end
  local targetDir = Vector2.up
  local sBoard = self._world:GetService("BoardLogic")
  local boardServiceRender = self._world:GetService("BoardRender")
  local teamEntity
  if targetEntity:HasTeam() then
    teamEntity = targetEntity
  elseif targetEntity:HasPet() then
    teamEntity = targetEntity:Pet():GetOwnerTeamEntity()
  end
  if targetEntity:HasTeam() or targetEntity:HasPetPstID() then
    for _, entity in ipairs(teamEntity:Team():GetTeamPetEntities()) do
      entity:SetGridLocation(posNew, targetDir)
      entity:GridLocation():SetMoveLastPosition(posNew)
    end
    teamEntity:SetGridLocation(posNew, targetDir)
    teamEntity:GridLocation():SetMoveLastPosition(posNew)
    local boardEntity = self._world:GetBoardEntity()
    sBoard:SetPieceTypeLogic(PieceType.Any, posOld)
    if sBoard:GetCanConvertGridElement(posNew) then
      sBoard:SetPieceTypeLogic(PieceType.None, posNew)
    end
    sBoard:UpdateEntityBlockFlag(teamEntity, posOld, posNew)
    if TT then
      boardServiceRender:ReCreateGridEntity(PieceType.Any, posOld)
      boardServiceRender:ReCreateGridEntity(PieceType.None, posNew)
      teamEntity:SetLocation(posNew, targetDir)
      for _, entity in ipairs(teamEntity:Team():GetTeamPetEntities()) do
        entity:SetLocation(posNew, targetDir)
      end
    end
  else
    if posNew then
      sBoard:UpdateEntityBlockFlag(targetEntity, posOld, posNew)
    else
      sBoard:RemoveEntityBlockFlag(targetEntity, posOld)
    end
    targetEntity:SetGridLocation(posNew, targetDir)
    if TT then
      targetEntity:SetLocation(posNew, targetDir)
    end
  end
end

function AutoTestCheat:SetTeamPosition_Test(TT, args)
  args.name = "team"
  self:SetEntityPosition_Test(TT, args)
end

function AutoTestCheat:SetTeamPowerFull_Test(TT, args)
  local teamEntity = self._svc:GetEntityByName_Test(args.name)
  self._world:GetGMCheat():BattleCheatTeamPowerFull(teamEntity)
end

function AutoTestCheat:SetEntityHP_Test(TT, args)
  local e = self._svc:GetEntityByName_Test(args.name)
  if not e then
    return
  end
  local maxhp = args.hp
  e:Attributes():Modify("MaxHP", maxhp, AttrModifyType.Cheat)
  e:Attributes():Modify("HP", maxhp, AttrModifyType.Cheat)
  if TT then
    e:ReplaceRedAndMaxHP(maxhp, maxhp)
  end
end

function AutoTestCheat:SetEntityHPPercent_Test(TT, args)
  local e = self._svc:GetEntityByName_Test(args.name)
  local percent = args.percent
  local attributeCmpt = e:Attributes()
  if attributeCmpt then
    local maxHP = attributeCmpt:CalcMaxHp()
    local newHP = math.floor(maxHP * percent)
    e:Attributes():Modify("HP", newHP)
    if TT then
      e:ReplaceRedHPAndWhitHP(newHP)
    end
  end
end

function AutoTestCheat:SetEntityAttack_Test(TT, args)
  local e = self._svc:GetEntityByName_Test(args.name)
  local attack = args.attack
  e:Attributes():Modify("AttackConstantFix", attack, AttrModifyType.Cheat)
end

function AutoTestCheat:SetEntityDefense_Test(TT, args)
  local e = self._svc:GetEntityByName_Test(args.name)
  local defense = args.defense
  e:Attributes():Modify("DefenceConstantFix", defense, AttrModifyType.Cheat)
end

function AutoTestCheat:SetEntityAttribute_Test(TT, args)
  local e = self._svc:GetEntityByName_Test(args.name)
  local attr = args.attr
  local val = args.val
  e:Attributes():Modify(attr, val, AttrModifyType.Cheat)
  if attr == "ChangeTeamLeaderCount" then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIChangeTeamLeaderLeftCount, val)
  end
end

function AutoTestCheat:AddBuff_Test(TT, args)
  local e = self._svc:GetEntityByName_Test(args.name)
  local buffID = args.buffID
  local buffLogicService = self._world:GetService("BuffLogic")
  local buff = buffLogicService:AddBuff(buffID, e)
  if TT then
    local player = self._world:GetService("PlayBuff")
    player:PlayAutoAddBuff(TT)
  end
end

function AutoTestCheat:RemoveBuff_Test(TT, args)
  local e = self._svc:GetEntityByName_Test(args.name)
  local buffID = args.buffID
  local svc = self._world:GetService("BuffLogic")
  local buffComponent = e:BuffComponent()
  local player = self._world:GetService("PlayBuff")
  local buffArray = buffComponent:GetBuffArray()
  if buffArray then
    for i, buff in ipairs(buffArray) do
      if buff:BuffID() == buffID and player and buff then
        buff:Unload()
        if TT then
          player:PlayBuffView(TT)
        end
      end
    end
  end
end

function AutoTestCheat:KillAllMonsters_Test(TT, args)
  self._world:GetGMCheat():BattleKillMonsters()
  while self._world:GameFSM():CurStateID() == GameStateID.WaitInput do
    YIELD(TT, 100)
  end
end

function AutoTestCheat:SetAllMonstersHPPercent_Test(TT, args)
  local percent = args.percent
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for i, e in ipairs(group:GetEntities()) do
    local attributeCmpt = e:Attributes()
    if attributeCmpt then
      local maxHP = attributeCmpt:CalcMaxHp()
      local newHP = math.floor(maxHP * percent)
      e:Attributes():Modify("HP", newHP)
      e:ReplaceRedHPAndWhitHP(newHP)
    end
  end
end

function AutoTestCheat:SetAllMonstersHP_Test(TT, args)
  local value = args.value
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for i, e in ipairs(group:GetEntities()) do
    local attributeCmpt = e:Attributes()
    if attributeCmpt then
      local newHP = math.floor(value)
      e:Attributes():Modify("HP", newHP)
      e:Attributes():Modify("MaxHP", newHP)
      e:ReplaceRedAndMaxHP(newHP, newHP)
    end
  end
end

function AutoTestCheat:AddBuffToEntity_Test(TT, args)
  local buffID = args.buffID
  local e = self._svc:GetEntityByName_Test(args.name)
  local buffLogicService = self._world:GetService("BuffLogic")
  local buff = buffLogicService:AddBuff(buffID, e)
  local player = self._world:GetService("PlayBuff")
  if player and buff and self._world:RunAtClient() then
    TaskManager:GetInstance():CoreGameStartTask(player.PlayAutoAddBuff, player)
  end
end

function AutoTestCheat:AddBuffToAllMonsters_Test(TT, args)
  local buffID = args.buffID
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local buffLogicService = self._world:GetService("BuffLogic")
  for i, e in ipairs(group:GetEntities()) do
    local buff = buffLogicService:AddBuff(buffID, e)
  end
  local player = self._world:GetService("PlayBuff")
  if player and self._world:RunAtClient() then
    TaskManager:GetInstance():CoreGameStartTask(player.PlayAutoAddBuff, player)
  end
end

function AutoTestCheat:AddMonster_Test(TT, args)
  local id = args.id
  local pos = Vector2.Index2Pos(args.pos)
  local dir = AutoTestDirType[args.dir] or AutoTestDirType[1]
  local configService = self._world:GetService("Config")
  local monsterConfigData = configService:GetMonsterConfigData()
  local temp = monsterConfigData:GetMonsterObject(id)
  if not temp then
    Log.fatal("MonsterID Invalid ID:", id)
    return
  end
  local logic = self._world:GetService("MonsterCreationLogic")
  local render = self._world:GetService("MonsterShowRender")
  local monsterTransformParam = MonsterTransformParam:New(id)
  monsterTransformParam:SetPosition(pos)
  monsterTransformParam:SetForward(dir)
  monsterTransformParam:SetRotation(dir)
  local monsterEntity, _ = logic:CreateMonster(monsterTransformParam)
  if TT then
    render:CreateMonsterHPEntity(monsterEntity)
    render:ShowSummonMonster(TT, monsterEntity, monsterTransformParam)
  end
  if args.disableai then
    monsterEntity:ReplaceAI(AILogicPeriodType.Main, {10008})
  end
  self._svc:SetEntityName_Test(args.name, monsterEntity)
end

function AutoTestCheat:AddTrap_Test(TT, args)
  local id = args.id
  local pos = Vector2.Index2Pos(args.pos)
  local dir = AutoTestDirType[args.dir]
  local configService = self._world:GetService("Config")
  local trapConfigData = configService:GetTrapConfigData()
  local trapData = trapConfigData:GetTrapData(id)
  if not trapData then
    Log.fatal("TrapID Invalid ID:", id)
    return
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local trapServiceRender = self._world:GetService("TrapRender")
  local trap = trapServiceLogic:CreateTrap(id, pos, dir, false)
  if TT then
    trapServiceRender:CreateSingleTrapRender(TT, trap)
  end
  self._svc:SetEntityName_Test(args.name, trap)
end

function AutoTestCheat:SetMonsterAI_Test(TT, args)
  local e = self._svc:GetEntityByName_Test(args.name)
  e:ReplaceAI(AILogicPeriodType.Main, {
    args.ai
  })
end

function AutoTestCheat:FakeClickAutoFight_Test(TT, args)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIWidgetAutoFight",
    input = "BtnAutoFightOnClick",
    args = {}
  })
  local gameFsmCmpt = self._world:GameFSM()
  while gameFsmCmpt:CurStateID() == GameStateID.WaitInput do
    YIELD(TT, 100)
  end
end

function AutoTestCheat:BlackFistFakeChainPath_Test(TT, args)
  local pieceType = args.pieceType
  local chainPath = {}
  for i, v in ipairs(args.chainPath) do
    chainPath[#chainPath + 1] = Vector2.Index2Pos(v)
  end
  local previewEntity = self._world:GetPreviewEntity()
  local linklineService = self._world:GetService("LinkLine")
  local linkageRenderService = self._world:GetService("LinkageRender")
  local showPath = {}
  for _, pos in ipairs(chainPath) do
    table.insert(showPath, pos)
    linklineService:_OnPieceInsertIntoChain(showPath)
    previewEntity:ReplacePreviewChainPath(showPath, pieceType, PieceType.None)
    linkageRenderService:ShowLinkageInfo(showPath, pieceType)
    YIELD(TT, 100)
  end
  local isLocal = self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn
  self._world:EventDispatcher():Dispatch(GameEventType.FlushPetChainSkillItem, isLocal, #chainPath, pieceType)
  linklineService:ShowChainPathCancelArea(false)
  local pieceService = self._world:GetService("Piece")
  local boardService = self._world:GetService("BoardLogic")
  pieceService:RefreshPieceAnim()
  local cmd = MovePathDoneCommand:New()
  cmd:SetChainPath(chainPath)
  cmd:SetElementType(pieceType)
  self._world:Player():SendCommand(cmd)
  local linkageRenderService = self._world:GetService("LinkageRender")
  linkageRenderService:ClearLinkRender()
  local gameFsmCmpt = self._world:GameFSM()
  while gameFsmCmpt:CurStateID() == GameStateID.WaitInput do
    YIELD(TT, 100)
  end
end

function AutoTestCheat:BlackFistCastSkill_Test(TT, args)
  local petEntity = self._svc:GetEntityByName_Test(args.name)
  local petPstID = petEntity:PetPstID():GetPstID()
  local skillID = petEntity:SkillInfo():GetActiveSkillID()
  local cfgsvc = self._world:GetService("Config")
  local skillConfigData = cfgsvc:GetSkillConfigData(skillID)
  local pickUpType = skillConfigData:GetSkillPickType()
  local localTeam = self._world:Player():GetLocalTeamEntity()
  if pickUpType == SkillPickUpType.None then
    local cmd = CastActiveSkillCommand:New()
    cmd:SetCmdActiveSkillID(skillID)
    cmd:SetCmdCasterPstID(petPstID)
    self._world:Player():SendCommand(cmd)
  else
    local previewPickUpComponent = petEntity:PreviewPickUpComponent()
    if not previewPickUpComponent then
      petEntity:AddPreviewPickUpComponent()
      previewPickUpComponent = petEntity:PreviewPickUpComponent()
    end
    local pickUpGridPos = {}
    for i, v in ipairs(args.pickUpPos) do
      pickUpGridPos[#pickUpGridPos + 1] = Vector2.Index2Pos(v)
    end
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
    for i, pos in ipairs(pickUpGridPos) do
      local direction = scopeCalculator:GetDirection(pos, localTeam:GetGridPosition())
      previewPickUpComponent:AddGridPos(pos)
      previewPickUpComponent:AddDirection(direction, pos)
    end
    local cmd = CastPickUpActiveSkillCommand:New()
    cmd:SetCmdActiveSkillID(skillID)
    cmd:SetCmdCasterPstID(petPstID)
    cmd:SetCmdPickUpResult(pickUpGridPos)
    cmd:SetPickUpDirectionResult(previewPickUpComponent:GetPickUpDirectionPos(), previewPickUpComponent:GetAllDirection(), previewPickUpComponent:GetLastPickUpDirection())
    cmd:SetReflectDir(previewPickUpComponent:GetReflectDir())
    self._world:Player():SendCommand(cmd)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.EnemyPetCastActiveSkill, petPstID)
end

function AutoTestCheat:FakeDimensionDoorPickUp_Test(TT, args)
  local gridPos = Vector2.Index2Pos(args.pickUpPos)
  local utilData = self._world:GetService("UtilData")
  if utilData:GetBoardIsPosNil(gridPos) then
    return
  end
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  pickUpTargetCmpt:SetPickUpTargetType(SkillPickUpType.ChainInstruction)
  pickUpTargetCmpt:SetPickUpGridPos(gridPos)
  if utilData:IsValidPiecePos(gridPos) and not utilData:IsPosBlock(gridPos, BlockFlag.LinkLine) and not utilData:IsPosDimensionDoor(gridPos) then
    pickUpTargetCmpt:SetPickUpGridSafePos(gridPos)
  else
    Log.fatal("GridPos:", tostring(gridPos), " Is Invalid ")
  end
  renderBoardEntity:ReplacePickUpTarget()
  local gameFsmCmpt = self._world:GameFSM()
  while gameFsmCmpt:CurStateID() ~= GameStateID.PickUpChainSkillTarget do
    YIELD(TT, 100)
  end
  YIELD(TT, 2000)
  self._world:EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIChainSkillPreview",
    input = "btnOKOnClick",
    args = {}
  })
  while gameFsmCmpt:CurStateID() == GameStateID.PickUpChainSkillTarget do
    YIELD(TT, 100)
  end
end

function AutoTestCheat:SetPieceType_Test(TT, args)
  self._world:GetGMCheat():BattleCheatSetBoardPiece(args.pieceType)
end

function AutoTestCheat:SetOnePieceType_Test(TT, args)
  local pos = Vector2.Index2Pos(args.pos)
  self._world:GetGMCheat():BattleCheatSetOnePiece(pos, args.pieceType)
end

function AutoTestCheat:SetEveryPieceType_Test(TT, args)
  local s = args.pieceTypeArray
  local ss = string.split(s, "|")
  local t = {}
  for x, col in ipairs(ss) do
    t[x] = {}
    local cc = string.split(col, ",")
    for y, v in ipairs(cc) do
      t[x][y] = tonumber(v)
    end
  end
  self._world:GetGMCheat():BattleCheatSetEveryPiece(t)
end

function AutoTestCheat:CastTrapSkill_Test(TT, args)
  local pos = Vector2.Index2Pos(args.pos)
  local trapID = args.trapID
  local boardCmpt = self._world:GetBoardEntity():Board()
  local es = boardCmpt:GetPieceEntities(pos, function(e)
    return not e:HasDeadMark() and e:HasTrapID() and trapID == e:TrapID():GetTrapID()
  end)
  if #es == 0 then
    return
  end
  local caster = es[1]
  if 0 >= args.skillID then
    return false
  end
  local skillID = args.skillID
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UITrapSkillVisible, true, caster:GetID())
  local gameFsmCmpt = self._world:GameFSM()
  while GameStateID.PreviewActiveSkill ~= gameFsmCmpt:CurStateID() do
    YIELD(TT, 100)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIWidgetTrapSkill",
    input = "_OnShowSelectSkill",
    args = {
      args.skillID
    }
  })
  YIELD(TT, 500)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIWidgetTrapSkill",
    input = "btnGoOnClick",
    args = {}
  })
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(skillID)
  local pickUpType = skillConfigData:GetSkillPickType()
  if pickUpType == SkillPickUpType.None then
  elseif pickUpType == SkillPickUpType.Instruction or pickUpType == SkillPickUpType.PickAndDirectionInstruction then
    local pickUpGridPos = {}
    for i, v in ipairs(args.pickUpPos) do
      pickUpGridPos[#pickUpGridPos + 1] = Vector2.Index2Pos(v)
    end
    if pickUpGridPos then
      for i, pos in ipairs(pickUpGridPos) do
        Log.debug("pickup pos ", Vector2.Pos2Index(pos))
        pickUpTargetCmpt:SetPickUpTargetType(pickUpType)
        pickUpTargetCmpt:SetPickUpGridPos(pos)
        pickUpTargetCmpt:SetCurActiveSkillInfo(skillID, -1)
        renderBoardEntity:ReplacePickUpTarget()
        YIELD(TT, 500)
      end
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetChooseTarget",
      input = "HandleActiveSkillConfirm",
      args = {}
    })
  end
  YIELD(TT, 500)
  while GameStateID.ActiveSkill ~= gameFsmCmpt:CurStateID() do
    YIELD(TT, 100)
  end
end

function AutoTestCheat:ChangeTeamLeader_Test(TT, args)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIBattleTeamStateEnter",
    input = "ChangeTeamLeaderOnClick",
    args = {}
  })
  YIELD(TT, 500)
  local orderIndex = args.index - 1
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIBattleChangeTeamLeader",
    input = "ChangeTeamLeader",
    args = {orderIndex}
  })
  YIELD(TT, 500)
end

function AutoTestCheat:ModifySanValue_Test(TT, args)
  local featureSvc = self._world:GetService("FeatureLogic")
  local curSan, oldSan, realModifyValue, debtVal, modifyTimes = featureSvc:ModifySanValue(args.modifyValue)
  local nt = NTSanValueChange:New(curSan, oldSan, debtVal, modifyTimes)
  self._world:GetService("Trigger"):Notify(nt)
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    featureSvcRender:NotifySanValueChange(curSan, oldSan, realModifyValue)
    local svcPlayBuff = self._world:GetService("PlayBuff")
    svcPlayBuff:PlayBuffView(TT, nt)
  end
end

function AutoTestCheat:FakeCastFeaturePersonaSkill_Test(TT, args)
  self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 3)
  while GameStateID.PreviewActiveSkill ~= self._world:GameFSM():CurStateID() do
    YIELD(TT, 100)
  end
  YIELD(TT, 500)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AutoFightCastPersonaSkill)
  while GameStateID.PersonaSkill ~= self._world:GameFSM():CurStateID() do
    YIELD(TT, 100)
  end
end

function AutoTestCheat:AddCardByType_Test(TT, args)
  local featureSvc = self._world:GetService("FeatureLogic")
  local cardTypeList = args.cardTypeList
  for _, type in ipairs(cardTypeList) do
    featureSvc:AddCard(type)
  end
end

function AutoTestCheat:FakeCastFeatureCardSkill_Test(TT, args)
  self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 3)
  while GameStateID.PreviewActiveSkill ~= self._world:GameFSM():CurStateID() do
    YIELD(TT, 100)
  end
  YIELD(TT, 500)
  local featureSvc = self._world:GetService("FeatureLogic")
  local costList = featureSvc:GetCostCardListByType(args.cardCompositionType)
  if costList then
    for _, type in ipairs(costList) do
      featureSvc:AddCard(type)
    end
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetFeatureCard",
      input = "OnClickUI",
      args = {}
    })
    YIELD(TT, 1000)
    for _, cardType in ipairs(costList) do
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetFeatureCardInfo",
        input = "AutoCardImgOnClick",
        args = {cardType}
      })
      YIELD(TT, 500)
    end
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetFeatureCardInfo",
      input = "OnCastClick",
      args = {}
    })
  end
  while GameStateID.PersonaSkill ~= self._world:GameFSM():CurStateID() do
    YIELD(TT, 100)
  end
end

function AutoTestCheat:FakeCastFeatureScanTrap_Test(TT, args)
  YIELD(TT, 500)
  local featureSvc = self._world:GetService("FeatureLogic")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIWidgetFeatureScan",
    input = "UIWidgetFeatureScanButtonOnClick",
    args = {}
  })
  YIELD(TT, 1000)
  local chooseIndex = args.chooseIndex
  if chooseIndex == 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIFeatureScanController",
      input = "ButtonActiveSkill1OnClick",
      args = {nil}
    })
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIFeatureScanTrapElement",
      input = "AutoTestClick",
      args = {chooseIndex}
    })
  end
  YIELD(TT, 1000)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIFeatureScanController",
    input = "SafeAreaOnClick",
    args = {}
  })
  YIELD(TT, 1000)
end

function AutoTestCheat:WaitTime_Test(TT, args)
  YIELD(TT, args.timeMs)
end

function AutoTestCheat:FakeSwitchBulletWidget_Test(TT, args)
  local e = self._svc:GetEntityByName_Test(args.name)
  local petID = e:PetPstID():GetPstID()
  self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 3)
  while GameStateID.PreviewActiveSkill ~= self._world:GameFSM():CurStateID() do
    YIELD(TT, 100)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIWidgetBattlePet",
    uiid = self._world:GetPetData(petID).uiid,
    input = "OnUp",
    args = {}
  })
  YIELD(TT, 1000)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIWidgetPetEquipRefine",
    input = "BtnSwitchOnClick",
    args = {}
  })
  YIELD(TT, 1000)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIBattle",
    input = "CancelActiveSkillBtnOnClick",
    args = {nil}
  })
  while GameStateID.WaitInput ~= self._world:GameFSM():CurStateID() do
    YIELD(TT, 100)
  end
end

function AutoTestCheat:SetEntityBuffLayer_Test(TT, args)
  local buffID = args.buffID
  local e = self._svc:GetEntityByName_Test(args.name)
  local buffLogicService = self._world:GetService("BuffLogic")
  local layerCount = args.layer
  local layerType = args.layerType
  local bDisplay = args.display
  local curMarkLayer, buffInstance = buffLogicService:SetBuffLayer(e, layerType, layerCount)
  if buffInstance then
    local buffSeq = buffInstance:BuffSeq()
    TaskManager:GetInstance():CoreGameStartTask(self._PlayBuffLayerChange, self, e, curMarkLayer, buffSeq, bDisplay)
  end
end

function AutoTestCheat:_PlayBuffLayerChange(TT, entity, curMarkLayer, buffSeq, bDisplay)
  entity:BuffView()
  local buffView = entity:BuffView()
  local viewInstance = buffView:GetBuffViewInstance(buffSeq)
  if viewInstance then
    viewInstance:SetLayerCount(TT, curMarkLayer)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  if not bDisplay then
    return
  end
  if entity:HasPetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, entity:PetPstID():GetPstID(), curMarkLayer)
  end
end
