local DungeonBattleBaseCtrl = class("DungeonBattleBaseCtrl")
local CS_BattleManager_Ins = CS.BattleManager.Instance
local util = require("XLua.Common.xlua_util")
local ExclusiveWeaponEffectUtil = require("Game.ExclusiveWeaponEffect.ExclusiveWeaponEffectUtil")
local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
local CS_CameraController = CS.CameraController
local CS_WaitForSeconds = CS.UnityEngine.WaitForSeconds
local CS_ResLoader = CS.ResLoader
DungeonBattleBaseCtrl.eBattleEndType = {
  Victory = 0,
  Failure = 1,
  Retreat = 2,
  Restart = 3,
  Sneak = 5
}

function DungeonBattleBaseCtrl:GetHeroObjectDic()
end

function DungeonBattleBaseCtrl:OnBattleStateChange(battleCtrl, stateId, isDeployRoom)
end

function DungeonBattleBaseCtrl:GetRoleAppearEffect()
end

function DungeonBattleBaseCtrl:GetRoleDisappearEffect()
end

function DungeonBattleBaseCtrl:BattleLoadReady(battleController)
  if self.__OnDragTileChanged == nil then
    self.__OnDragTileChanged = BindCallback(self, self.OnDragTileChanged)
    CS.MsgDispatcher.AddListener(eCsMsgEventType.OnDeployDragTileChanged, self.__OnDragTileChanged)
  end
end

function DungeonBattleBaseCtrl:OnDragTileChanged(targetTile, isPlayer, draggingRole)
  CS_AnimationEffectController_Ins:KillRoleEffect(draggingRole.lsObject.gameObject)
  CS_AnimationEffectController_Ins:RecycleRoleEffect(draggingRole.lsObject.gameObject)
end

function DungeonBattleBaseCtrl:OnBattleStart(battleCtrl)
  UIManager:ShowWindowAsync(UIWindowTypeID.BattleCrazyMode, function(window)
    if window == nil then
      return
    end
    window:InjectCrazyTime(battleCtrl.CrazyTime)
    window:OnBattleStartCrazyMode(battleCtrl)
  end)
end

function DungeonBattleBaseCtrl:ReqStartBattle(battleRoomData, originRoleList, battleAction)
  local uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
  if uiBattle ~= nil and uiBattle.active then
    uiBattle:HideRetreatAndCampBondBtn()
  end
  local uiTDBattle = UIManager:GetWindow(UIWindowTypeID.TDBattle)
  if uiTDBattle ~= nil then
    uiTDBattle:OnTdBattleStart()
  end
end

function DungeonBattleBaseCtrl:OnBattleEnd(battleEndState, evenId, dealBattleEndEvent)
  dealBattleEndEvent(evenId)
end

function DungeonBattleBaseCtrl:ReqBattleSettle(battleEndState, requestData)
end

function DungeonBattleBaseCtrl:CreateBattleSettleMisc(battleCtrl)
  local battlePlayerController = battleCtrl.PlayerController
  local misc = {}
  misc.totalFrame = battleCtrl.frame
  misc.inputData = self:StoreInputCmdToSettleMsg(battlePlayerController)
  return misc
end

function DungeonBattleBaseCtrl:CreateBattleSettleValid(battleCtrl, requestData)
  local battlePlayerController = battleCtrl.PlayerController
  local valid = {}
  local score = {}
  for k, v in pairs(requestData.gameScore) do
    score[k] = v
  end
  valid.score = score
  valid.activeAlgConsume = self:GetBattleConsumeSkillChipUseTimeDic(battlePlayerController)
  return valid
end

function DungeonBattleBaseCtrl:StoreInputCmdToSettleMsg(csbattlePlayerController)
  local inputData = {}
  if csbattlePlayerController ~= nil then
    local inputs = csbattlePlayerController:GetInputCmd()
    if inputs ~= nil and inputs.Count > 0 then
      for i = 0, inputs.Count - 1 do
        local inputModel = self:PackInputModel(inputs[i])
        table.insert(inputData, inputModel)
      end
    end
  end
  if 0 < #inputData then
    return inputData
  end
  return nil
end

function DungeonBattleBaseCtrl:__UpdatePlayerPosOnTDSettle(roleDataId, x, y)
  if x >= ConfigData.buildinConfig.BenchX then
    y = 0
  end
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  if dynPlayer == nil then
    return
  end
  local dynHero = dynPlayer.heroDic[roleDataId]
  if dynHero ~= nil then
    dynHero:SetCoordXY(x, y, ConfigData.buildinConfig.BenchX)
    return dynHero.coord
  end
  return nil
end

function DungeonBattleBaseCtrl:PackInputModel(csInputCmd)
  local inputModel = {}
  inputModel.frame = csInputCmd.frameId
  inputModel.skillId = csInputCmd.skillId
  inputModel.casterId = csInputCmd.casterId
  inputModel.ultimateSkill = csInputCmd.isUltSkill
  inputModel.inputType = csInputCmd.inputType
  local selectTiles = csInputCmd.selectTiles
  inputModel.select_role_coords = {}
  if selectTiles ~= nil and selectTiles.Count > 0 then
    for i = 0, selectTiles.Count - 1 do
      table.insert(inputModel.select_role_coords, selectTiles[i])
    end
  end
  inputModel.inputcoord = csInputCmd.selectCoord
  return inputModel
end

function DungeonBattleBaseCtrl:VictoryBattleEndCoroutine(battleEndState)
end

function DungeonBattleBaseCtrl:ReqBattleFreshFormation(battleController)
end

function DungeonBattleBaseCtrl:ReqGiveUpBattle(battleController)
end

function DungeonBattleBaseCtrl:ReqRestartBattle(battleController)
  battleController:RestartBattle()
end

function DungeonBattleBaseCtrl:ReqRestartBattleForSkill(battleController, buffs, mp, hmp)
  local dynPlayer = BattleUtil.GetCurDynPlayer()
  if dynPlayer ~= nil then
    dynPlayer:UpdatePlayerDyncForRestartSkill(mp, hmp, buffs)
  end
  battleController:RestartBattleForSkill()
end

function DungeonBattleBaseCtrl:OnDeployCoordChanged(battleController, entity)
  MsgCenter:Broadcast(eMsgEventId.OnDeployCoordChanged, entity)
end

function DungeonBattleBaseCtrl:OnDeployEndDragRole(battleController, entity)
  ExclusiveWeaponEffectUtil:BattleRoleEntityPlayEWEffect(entity)
end

function DungeonBattleBaseCtrl:OnBattleEffectClicked(battleController, battleEffectGrid)
  local worldPos
  if battleEffectGrid.onBench then
    worldPos = battleController.battleFieldData:GetBenchUnityPos(battleEffectGrid.y)
  else
    worldPos = battleController.battleFieldData:GetGridUnityPos(battleEffectGrid.x, battleEffectGrid.y)
  end
  UIManager:ShowWindow(UIWindowTypeID.BattleEffectGirdInfo):InitBattleGridInfo(battleEffectGrid.gridData, worldPos)
  AudioManager:PlayAudioById(1079)
end

function DungeonBattleBaseCtrl:OnBattleObjectLoadComplete(battleController)
  MsgCenter:Broadcast(eMsgEventId.OnBattleReady)
end

function DungeonBattleBaseCtrl:GetBattleConsumeSkillChipUseTimeDic(battlePlayerController)
  local activeAlgConsume = {}
  local skillList = battlePlayerController:GetPlayerSkillList()
  if skillList == nil then
    return nil
  end
  for i = 0, skillList.Count - 1 do
    local battleSkill = skillList[i]
    if battleSkill.skillType == eBattleSkillLogicType.ChipConsume and 0 < battleSkill.curUseTime then
      activeAlgConsume[battleSkill.itemId] = battleSkill.curUseTime
    end
  end
  return activeAlgConsume
end

function DungeonBattleBaseCtrl:PlayRoleWinActionAndEffect(playerRoleList, mvpRole)
  for key, role in pairs(playerRoleList) do
    if not role.roleOnBench then
      local heroCfg = ConfigData.resource_model[role.resSrcId]
      if heroCfg ~= nil then
        local playEffect = false
        if role == mvpRole then
          playEffect = true
        else
          playEffect = heroCfg.non_mvp_effect
        end
        if playEffect then
          for _, effectId in ipairs(heroCfg.win_effect_id) do
            role:PlayWinEffect(effectId)
          end
        end
      end
      role:BreakActionLayerWithEmptyAction(ConfigData.buildinConfig.ExtraAtionEmptyAction)
      role.lsObject:ResetGameObjectPosition()
      role.lsObject.localRotation = CS.TrueSync.TSQuaternion.identity
      role:PlayWinAction()
    end
  end
end

function DungeonBattleBaseCtrl:GetRoleMvpCameraOffset(role)
  if role == nil then
    return
  end
  if role.character == nil then
    return
  end
  if role.character.heroData == nil then
    return
  end
  local heroId = role.roleDataId
  local skinId = role.character.heroData.skinId
  local mvpCfg = ConfigData.battle_mvp[skinId]
  if mvpCfg == nil then
    local heroCfg = ConfigData.hero_data[heroId]
    if heroCfg == nil then
      return
    end
    skinId = heroCfg.default_skin
    mvpCfg = ConfigData.battle_mvp[skinId]
  end
  if mvpCfg == nil then
    return
  end
  local offset = ConfigData.battle_mvp[skinId].camera_offset_vector3
  if #offset == 3 then
    return Vector3.New(offset[1], offset[2], offset[3])
  end
end

function DungeonBattleBaseCtrl:BeforeCreateStageBoss(battleController, sourceMonsterEntity, newBoss)
end

function DungeonBattleBaseCtrl:OnCreateStageBoss(battleController, newMonsterEntity)
  if newMonsterEntity.parentRoleEntity == nil then
    error("parentRoleEntity == nil")
    return
  end
  local stageGroupId = newMonsterEntity.parentRoleEntity.character:GetDynMonsterStageGroup()
  local monsterStageGroupCfg = ConfigData.monster_stage[stageGroupId]
  local stage = newMonsterEntity.character.stage
  if monsterStageGroupCfg == nil or monsterStageGroupCfg[stage] == nil then
    error(string.format("Cant get monster_stage, stageGroupId:%s, monsterId:%s, stage:%s", stageGroupId, newMonsterEntity.roleDataId, stage))
    return
  end
  local monsterStageCfg = monsterStageGroupCfg[stage]
  if string.IsNullOrEmpty(monsterStageCfg.avg_name) and not monsterStageCfg.timeline_enable then
    return
  end
  if self._stageBossCo ~= nil then
    error("self._stageBossCo ~= nil")
    return
  end
  self._stageBossTab = self._stageBossTab or {}
  self._stageBossTab.battleController = battleController
  self._stageBossTab.newMonsterEntity = newMonsterEntity
  self._stageBossTab.monsterStageCfg = monsterStageCfg
  self._CoStageBossShowFunc = self._CoStageBossShowFunc or BindCallback(self, self._CoStageBossShow)
  self._stageBossCo = GR.StartCoroutine(util.cs_generator(self._CoStageBossShowFunc))
end

function DungeonBattleBaseCtrl:_CoStageBossShow()
  local battleController = self._stageBossTab.battleController
  local newMonsterEntity = self._stageBossTab.newMonsterEntity
  local monsterStageCfg = self._stageBossTab.monsterStageCfg
  battleController:SetFreeze(newMonsterEntity)
  local waitAvg = false
  if not string.IsNullOrEmpty(monsterStageCfg.avg_name) then
    waitAvg = true
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
    avgCtrl:ShowAvg(monsterStageCfg.avg_name, function()
      waitAvg = false
    end, false, false)
  end
  while waitAvg do
    coroutine.yield(nil)
  end
  local waitTimeline = false
  if monsterStageCfg.timeline_enable then
    waitTimeline = true
    local skillModle = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
    if skillModle ~= nil then
      skillModle:BattleHideAllUITween(true)
    end
    MsgCenter:Broadcast(eMsgEventId.OnMonsterStageShowStart)
    local newMonsterTransform = newMonsterEntity.lsObject.transform
    local showEffectGo
    if not string.IsNullOrEmpty(monsterStageCfg.action_effect) then
      local effectPath = monsterStageCfg.action_effect .. PathConsts.PrefabExtension
      self._monsterStageResloader = self._monsterStageResloader or CS_ResLoader.Create()
      local prefab = self._monsterStageResloader:LoadABAsset(effectPath)
      if not IsNull(prefab) then
        showEffectGo = prefab:Instantiate()
        showEffectGo.transform:SetPositionAndRotation(newMonsterTransform.position, newMonsterTransform.rotation)
      end
    end
    if monsterStageCfg.audio_id > 0 then
      AudioManager:PlayAudioById(monsterStageCfg.audio_id)
    end
    CS_CameraController.Instance:SetMonStageVcam(newMonsterTransform)
    TimelineUtil.Play(CS_CameraController.Instance.monsterStageTimeline, function()
      waitTimeline = false
    end)
    local actionComp = newMonsterEntity:GetActionComponent()
    if actionComp ~= nil then
      actionComp:SetAnimatorById(monsterStageCfg.action_id)
    end
    coroutine.yield(CS_WaitForSeconds(monsterStageCfg.action_time))
    while waitTimeline do
      coroutine.yield(nil)
    end
    CS_CameraController.Instance:EndMonsterStageTimeline()
    local skillModle = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
    if skillModle ~= nil then
      skillModle:BattleHideAllUITween(false)
    end
    DestroyUnityObject(showEffectGo)
    MsgCenter:Broadcast(eMsgEventId.OnMonsterStageShowEnd)
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnMonsterStageCreat, newMonsterEntity)
  end
  battleController:SetUnFreeze(newMonsterEntity)
  self._stageBossCo = nil
end

function DungeonBattleBaseCtrl:OnDelete()
  CS_BattleManager_Ins:ClearBattleCache()
  if self._stageBossCo ~= nil then
    GR.StopCoroutine(self._stageBossCo)
    self._stageBossCo = nil
  end
  if self._monsterStageResloader ~= nil then
    self._monsterStageResloader:Put2Pool()
    self._monsterStageResloader = nil
  end
  if self.__OnDragTileChanged ~= nil then
    CS.MsgDispatcher.RemoveListener(eCsMsgEventType.OnDeployDragTileChanged, self.__OnDragTileChanged)
    self.__OnDragTileChanged = nil
  end
end

return DungeonBattleBaseCtrl
