require("main_world")
_class("GMCheat", Object)
GMCheat = GMCheat

function GMCheat:Constructor(world)
  self._world = world
end

function GMCheat:BattleCheatHeroMaxHP()
  local e = self._world:Player():GetLocalTeamEntity()
  local maxhp = 9999999
  e:Attributes():Modify("MaxHP", maxhp)
  e:Attributes():Modify("HP", maxhp)
  if self._world:RunAtClient() then
    e:ReplaceRedAndMaxHP(maxhp, maxhp)
  end
end

function GMCheat:BattleCheatTeamPowerFull(teamEntity)
  teamEntity = teamEntity or self._world:Player():GetLocalTeamEntity()
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  local buffLogicService = self._world:GetService("BuffLogic")
  local playBuffService = self._world:GetService("PlayBuff")
  local configService = self._world:GetService("Config")
  local utilData = self._world:GetService("UtilData")
  for _, e in ipairs(teamMembers) do
    local petPstIDComponent = e:PetPstID()
    local petPstID = petPstIDComponent:GetPstID()
    local activeSkillID = e:SkillInfo():GetActiveSkillID()
    local skillConfigData = configService:GetSkillConfigData(activeSkillID)
    if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
      local curLegendPower = e:Attributes():GetAttribute("LegendPower")
      local newLegendPower = curLegendPower + 10
      if newLegendPower > BattleConst.LegendPowerMax then
        newLegendPower = BattleConst.LegendPowerMax
      end
      e:Attributes():Modify("LegendPower", newLegendPower)
      self._world:EventDispatcher():Dispatch(GameEventType.PetLegendPowerChange, petPstID, newLegendPower)
    elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.AlchemyEnergy then
      local curAlchemyPower = e:Attributes():GetAttribute("AlchemyPower")
      local newAlchemyPower = curAlchemyPower + 10
      if newAlchemyPower > BattleConst.AlchemyPowerMax then
        newAlchemyPower = BattleConst.AlchemyPowerMax
      end
      e:Attributes():Modify("AlchemyPower", newAlchemyPower)
      self._world:EventDispatcher():Dispatch(GameEventType.PetAlchemyPowerChange, petPstID, newAlchemyPower, true, false, nil)
    elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.BuffLayer then
      local costLayer = skillConfigData:GetSkillTriggerParam()
      local extraParam = skillConfigData:GetSkillTriggerExtraParam()
      local buffEffectType = extraParam.buffEffectType
      local blsvc = self._world:GetService("BuffLogic")
      local currentVal = blsvc:GetBuffLayer(e, buffEffectType)
      blsvc:SetBuffLayer(e, buffEffectType, costLayer, true)
      self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, true)
    elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.ColorPalette then
      local colorPaletteComponent = e:ColorPalette()
      local pieceTypes = {}
      for _, pieceType in pairs(PieceType) do
        if pieceType > PieceType.None then
          table.insert(pieceTypes, pieceType)
        end
      end
      colorPaletteComponent:AddPieceTypes(pieceTypes)
      self._world:EventDispatcher():Dispatch(GameEventType.ColorPaletteRefresh, petPstID, colorPaletteComponent:GetPieceTypes())
    else
      e:Attributes():Modify("Power", 0)
      self._world:EventDispatcher():Dispatch(GameEventType.PetPowerChange, petPstID, 0)
    end
    e:Attributes():Modify("Ready", 1)
    self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, true, false)
    local extraSkillList = e:SkillInfo():GetExtraActiveSkillIDList()
    if extraSkillList then
      for _, extraSkillID in ipairs(extraSkillList) do
        local extraSkillConfigData = configService:GetSkillConfigData(extraSkillID)
        if extraSkillConfigData then
          if extraSkillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
            local curLegendPower = e:Attributes():GetAttribute("LegendPower")
            local newLegendPower = curLegendPower + 10
            if newLegendPower > BattleConst.LegendPowerMax then
              newLegendPower = BattleConst.LegendPowerMax
            end
            e:Attributes():Modify("LegendPower", newLegendPower)
            self._world:EventDispatcher():Dispatch(GameEventType.PetLegendPowerChange, petPstID, newLegendPower)
          else
            utilData:SetPetPowerAttr(e, 0, extraSkillID)
            self._world:EventDispatcher():Dispatch(GameEventType.PetExtraPowerChange, petPstID, extraSkillID, 0, true)
          end
          utilData:SetPetSkillReadyAttr(e, 1, extraSkillID)
          self._world:EventDispatcher():Dispatch(GameEventType.PetExtraActiveSkillGetReady, petPstID, extraSkillID, true, false)
        end
      end
    end
  end
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if lsvcFeature then
    self:_BattleCheatFeatureSkillFull(lsvcFeature, FeatureType.PersonaSkill)
    self:_BattleCheatFeatureSkillFull(lsvcFeature, FeatureType.MasterSkill)
    self:_BattleCheatFeatureSkillFull(lsvcFeature, FeatureType.MasterSkillRecover)
    self:_BattleCheatFeatureSkillFull(lsvcFeature, FeatureType.MasterSkillTeleport)
    local skillFeatureTypes = {
      FeatureType.PersonaSkill,
      FeatureType.MasterSkill,
      FeatureType.MasterSkillRecover,
      FeatureType.MasterSkillTeleport,
      FeatureType.TalentSkill1,
      FeatureType.TalentSkill2,
      FeatureType.TalentSkill3,
      FeatureType.TalentSkill4,
      FeatureType.TalentSkill5
    }
    for index, featureType in ipairs(skillFeatureTypes) do
      self:_BattleCheatFeatureSkillFull(lsvcFeature, featureType)
    end
  end
  if playBuffService and self._world:RunAtClient() then
    TaskManager:GetInstance():CoreGameStartTask(playBuffService.PlayAutoAddBuff, playBuffService)
  end
end

function GMCheat:_BattleCheatFeatureSkillFull(lsvcFeature, featureType)
  if lsvcFeature and lsvcFeature:HasFeatureType(featureType) then
    lsvcFeature:SetFeatureSkillCurPower(featureType, 0, 1)
    self._world:EventDispatcher():Dispatch(GameEventType.PersonaPowerChange, featureType, 0, 1)
  end
end

function GMCheat:BattleCheatMonsterInvincible()
  local _group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local cheatHp = 9999999
  for _, e in ipairs(_group:GetEntities()) do
    e:Attributes():Modify("HP", cheatHp)
    e:Attributes():Modify("MaxHP", cheatHp)
    if self._world:RunAtClient() then
      e:ReplaceRedAndMaxHP(cheatHp, cheatHp)
    end
  end
  Log.fatal("使用作弊按钮怪满血！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！")
end

function GMCheat:BattleCheatAttackMax(nMaxAttack)
  local teamMembers = self._world:Player():GetLocalTeamEntity():Team():GetTeamPetEntities()
  for _, e in ipairs(teamMembers) do
    e:Attributes():Modify("Attack", nMaxAttack, 99999)
  end
  Log.fatal("使用作弊按钮人满攻击！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！")
end

function GMCheat:BattleCheatAddPet(createInfo)
  local mainWorld = self._world
  local lsvcPartner = mainWorld:GetService("PartnerLogic")
  local petEntity, petInfo, matchPet, petRes, hp, maxHP = lsvcPartner:CreateMiddleEnterPet(createInfo)
  if not petEntity then
    return
  end
  local svc = self._world:GetService("L2R")
  local fakePartnerID = 1
  svc:L2RAddPartnerData(fakePartnerID, petInfo, matchPet, petRes, hp, maxHP)
  Log.fatal("使用作弊按钮加光灵！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！")
end

function GMCheat:BattleCheatGetRight()
  local teamMembers = self._world:Player():GetLocalTeamEntity():Team():GetTeamPetEntities()
  for _, e in ipairs(teamMembers) do
    e:Attributes():RemoveModify("Attack", 99999)
  end
end

function GMCheat:BattleKillMonsters()
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local teamEntity = self._world:Player():GetRemoteTeamEntity()
    teamEntity:Attributes():Modify("HP", 0)
    teamEntity:AddTeamDeadMark()
  end
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local monster_entities = monster_group:GetEntities()
  for _, v in pairs(monster_entities) do
    v:Attributes():Modify("HP", 0)
    sMonsterShowLogic:AddMonsterDeadMark(v)
    if self._world:RunAtClient() then
      v:ReplaceRedHPAndWhitHP(0)
      v:AddDeadFlag()
    end
  end
  sMonsterShowLogic:DoAllMonsterDeadLogic()
  Log.fatal("使用作弊按钮杀死全部怪物！！！！！！！！！！")
  if self._world:RunAtServer() then
    self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 5)
  else
    TaskManager:GetInstance():CoreGameStartTask(function(TT)
      local sMonsterShowRender = self._world:GetService("MonsterShowRender")
      sMonsterShowRender:DoAllMonsterDeadRender(TT)
      self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 5)
    end)
  end
end

function GMCheat:BattleCheatAddBuffHero(buffID)
  local buffLogicService = self._world:GetService("BuffLogic")
  local team = self._world:Player():GetLocalTeamEntity()
  local buff = buffLogicService:AddBuff(buffID, team)
  local player = self._world:GetService("PlayBuff")
  if player and buff and self._world:RunAtClient() then
    TaskManager:GetInstance():CoreGameStartTask(player.PlayAutoAddBuff, player)
  end
end

function GMCheat:BattleCheatAddBuffAllMonsters(buffID)
  local buffLogicService = self._world:GetService("BuffLogic")
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for i, e in ipairs(group:GetEntities()) do
    local buff = buffLogicService:AddBuff(buffID, e)
    local player = self._world:GetService("PlayBuff")
    if player and buff and self._world:RunAtClient() then
      TaskManager:GetInstance():CoreGameStartTask(player.PlayAutoAddBuff, player)
    end
  end
end

function GMCheat:BattleCheatRemoveBuffHero(buffID)
  local svc = self._world:GetService("BuffLogic")
  local hero = self._world:Player():GetLocalTeamEntity()
  local buffComponent = hero:BuffComponent()
  local player = self._world:GetService("PlayBuff")
  local buffArray = buffComponent:GetBuffArray()
  if buffArray then
    local notify = NTBuffUnload:New()
    for i, buff in ipairs(buffArray) do
      if buff:BuffID() == buffID then
        buff:Unload(notify)
        if self._world:RunAtClient() then
          TaskManager:GetInstance():CoreGameStartTask(player.PlayBuffView, player, notify)
        end
      end
    end
  end
end

function GMCheat:BattleCheatChangeAllMonstersHPPercent(hpPercent)
  hpPercent = hpPercent or 100
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local teamEntity = self._world:Player():GetRemoteTeamEntity()
    local attributeCmpt = teamEntity:Attributes()
    local maxHp = attributeCmpt:CalcMaxHp()
    local newHP = math.floor(maxHp * hpPercent / 100)
    teamEntity:Attributes():Modify("HP", newHP)
    if self._world:RunAtClient() then
      teamEntity:ReplaceRedHPAndWhitHP(newHP)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossRedHp, teamEntity:GetID(), hpPercent / 100, newHP, maxHp)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossWhiteHp, teamEntity:GetID(), hpPercent / 100, newHP, maxHp)
    end
    return
  end
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(group:GetEntities()) do
    local attributeCmpt = e:Attributes()
    if attributeCmpt then
      local maxHP = attributeCmpt:CalcMaxHp()
      local newHP = math.floor(maxHP * hpPercent / 100)
      e:Attributes():Modify("HP", newHP)
      if self._world:RunAtClient() then
        e:ReplaceRedHPAndWhitHP(newHP)
      end
    end
  end
end

function GMCheat:BattleCheatCreateMonster(id, pos, dir)
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
  if self._world:RunAtClient() then
    GameGlobal.TaskManager():CoreGameStartTask(render.ShowSummonMonster, render, monsterEntity, monsterTransformParam)
  end
end

function GMCheat:BattleCheatCreateTrap(id, pos, dir)
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
  if self._world:RunAtClient() then
    local svc = self._world:GetService("L2R")
    svc:L2RBoardLogicData()
    GameGlobal.TaskManager():CoreGameStartTask(trapServiceRender.ShowTraps, trapServiceRender, {trap})
  end
end

function GMCheat:BattleCheatSetBoardPiece(pieceType)
  pieceType = pieceType or 1
  local component = self._world:GetBoardEntity():Board()
  local boardService = self._world:GetService("BoardLogic")
  local pieceTable = component:ClonePieceTable()
  local boardRenderSvc = self._world:GetService("BoardRender")
  for x, col in pairs(pieceTable) do
    for y, v in pairs(col) do
      local grid = Vector2(x, y)
      if boardService:GetCanConvertGridElement(grid) and v ~= PieceType.None then
        boardService:SetPieceTypeLogic(pieceType, grid)
      end
    end
  end
  for x, col in pairs(pieceTable) do
    for y, v in pairs(col) do
      local grid = Vector2(x, y)
      if boardRenderSvc and boardService:GetCanConvertGridElement(grid) and v ~= PieceType.None then
        boardRenderSvc:ReCreateGridEntity(pieceType, grid, false, true)
      end
    end
  end
  local svc = self._world:GetService("L2R")
  svc:L2RBoardLogicData()
end

function GMCheat:BattleCheatSetOnePiece(pos, pieceType)
  if not pos then
    return
  end
  pieceType = pieceType or 1
  local component = self._world:GetBoardEntity():Board()
  local boardService = self._world:GetService("BoardLogic")
  local pieceTable = component:ClonePieceTable()
  local boardRenderSvc = self._world:GetService("BoardRender")
  if boardService:GetCanConvertGridElement(pos) then
    boardService:SetPieceTypeLogic(pieceType, pos)
  end
  if boardRenderSvc then
    boardRenderSvc:ReCreateGridEntity(pieceType, pos, false, true)
  end
  local svc = self._world:GetService("L2R")
  svc:L2RBoardLogicData()
end

function GMCheat:BattleCheatSetEveryPiece(pieceTypeArray)
  if not pieceTypeArray then
    return
  end
  local component = self._world:GetBoardEntity():Board()
  local boardService = self._world:GetService("BoardLogic")
  local pieceTable = component:ClonePieceTable()
  local boardRenderSvc = self._world:GetService("BoardRender")
  for x, col in pairs(pieceTable) do
    for y, v in pairs(col) do
      local grid = Vector2(x, y)
      if boardService:GetCanConvertGridElement(grid) and v ~= PieceType.None then
        boardService:SetPieceTypeLogic(pieceTypeArray[x][y], grid)
      end
    end
  end
  for x, col in pairs(pieceTable) do
    for y, v in pairs(col) do
      local grid = Vector2(x, y)
      if boardRenderSvc and v ~= PieceType.None then
        boardRenderSvc:ReCreateGridEntity(pieceTypeArray[x][y], grid, false, true)
      end
    end
  end
  local svc = self._world:GetService("L2R")
  svc:L2RBoardLogicData()
end

function GMCheat:BattleCheatChangePetHPPercent(hpPercent)
  hpPercent = hpPercent or 100
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local attributeCmpt = teamEntity:Attributes()
  local maxHp = attributeCmpt:CalcMaxHp()
  local newHP = math.floor(maxHp * hpPercent / 100)
  teamEntity:Attributes():Modify("HP", newHP)
  if self._world:RunAtClient() then
    teamEntity:ReplaceRedHPAndWhitHP(newHP)
    local hpCmpt = teamEntity:HP()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamHPChange, {
      isLocalTeam = true,
      currentHP = hpCmpt:GetRedHP(),
      maxHP = hpCmpt:GetMaxHP(),
      hitpoint = hpCmpt:GetWhiteHP(),
      shield = hpCmpt:GetShieldValue(),
      entityID = teamEntity:GetID(),
      showCurseHp = hpCmpt:GetShowCurseHp(),
      curseHpVal = hpCmpt:GetCurseHpValue()
    })
  end
end

function GMCheat:BattleCheatSetAutoFightComplex(complex)
  local idx = BattleConst.AutoFightMoveEnhanced and 2 or 1
  BattleConst.AutoFightPathComplexity[idx] = complex
end

function GMCheat:BattleCheatSetSanVal(val)
  local mainWorld = self._world
  local lsvcFeature = mainWorld:GetService("FeatureLogic")
  local old = lsvcFeature:GetSanValue()
  local delta = val - old
  lsvcFeature:SetSanValue(val)
  if mainWorld:RunAtClient() then
    local rsvcFeature = mainWorld:GetService("FeatureRender")
    rsvcFeature:NotifySanValueChange(val, old, delta)
  end
end
