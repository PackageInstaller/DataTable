local DragGesture = CS.Z1Client.General.DragGesture
local UIAnimationController = CS.Z1Client.UIAnimationController
local TYPEOF_Z1Button = typeof(CS.Z1Client.Z1Button)
local PvPBattleMainPanel, Super = System.NewClass("PvPBattleMainPanel", UIBasePanel, IBattlePanel)
PvPBattleMainPanel.uiResCls = UI_Pvp_Panel_BattleResource

function PvPBattleMainPanel:ctor()
  Super.ctor(self)
  self.isUIVisible = Vue.ref(true)
  self.tentacleItems = {}
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
  self:InitCamp()
end

function PvPBattleMainPanel:InitCamp()
  self.myCamp = bg.battleDataCenter:GetMyCamp()
  self.enemyCamp = bg.battleDataCenter:GetEnemyCamp()
end

function PvPBattleMainPanel:GetMyCamp()
  return self.myCamp
end

function PvPBattleMainPanel:GetEnemyCamp()
  return self.enemyCamp
end

function PvPBattleMainPanel:OnBind(binder)
  self.binder = binder
  binder:LoadAllLangFont(self.ui.Text_Name_1)
  binder:LoadAllLangFont(self.ui.Text_Name_2)
  bg.battlePanel = self
  self.uiAnimCtr = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.myEmojiCtrl = self.ui.Myself_Expression:GetComponent(typeof(UIAnimationController))
  self.enemyEmojiCtrl = self.ui.Enemy_Expression:GetComponent(typeof(UIAnimationController))
  self:InitBoutAnimUI()
  self:InitBattleCardUI()
  self:InitComp()
  self:BindBtnEndTurn()
  self:BindCampGlowEffect()
  self:RegisterMgrEvent()
  self:BindEnergyBoutEndVisble()
  self:BindSettingBtn()
  self:BindHistory()
  self:BindDraftRelic()
  self:_PlayEnterMusic()
  binder:BindTimer(0.1, 0, nil, System.fn(self, self.BindTentacleItem))
  bg.battleRender:OnBattleBegin()
  AudioManager.Instance:PostSoundEvent("Set_State_Ingame_DoubleSpeed_150Percent")
  binder:BindEvent(EventMgr.Instance.BattleResult, System.fn(self, self.OnBattleResult))
  binder:BindEvent(EventMgr.Instance.PVPViewChange, System.fn(self, self.OnPVPViewChange))
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.InsertHistory, self.OnInsertHistory, self)
  if bg.battleDataCenter.isRecover then
    bg.battleRender:PerformWithDelay(0.1, function()
      self:OnBattleRecover()
    end, self)
  end
end

function PvPBattleMainPanel:_PlayEnterMusic()
  local pvptype = BattleDataCenterClient:IsInPvpDraft() and PvpDefine.PvpType.Draft or PvpDefine.PvpType.PreBuilt
  local eventList = PvpDefine.WWiseEventList[pvptype]
  for _, sEvent in pairs(eventList) do
    AudioManager.Instance:PostSoundEvent(sEvent)
  end
end

function PvPBattleMainPanel:IsReady()
  return true
end

function PvPBattleMainPanel:Tick(deltaTime)
end

function PvPBattleMainPanel:SetRendered(isRendering)
end

function PvPBattleMainPanel:OnPVPViewChange(viewCamp)
  if self:GetMyCamp() == viewCamp then
    Super.SetRendered(self, true)
  else
    Super.SetRendered(self, false)
  end
end

function PvPBattleMainPanel:RegisterMgrEvent()
  local eventMgr = bg.battleRender.eventMgr
  eventMgr:RegisterEvent(BattleRenderEvent.SelectTargets, self.OnSelectTargets, self)
  eventMgr:RegisterEvent(BattleRenderEvent.TurnCountDown, self.OnTurnCountDown, self)
  eventMgr:RegisterEvent(BattleRenderEvent.ChangeBoutPhase, self.OnChangeBoutPhase, self)
  eventMgr:RegisterEvent(BattleRenderEvent.ShowEmoji, self.ShowEmoji, self)
  local deadModeBout = DT.GetConstant("DeadModeBout")
  self.binder:BindToRaw(function(_, boutNum)
    if deadModeBout == boutNum then
      AudioManager.Instance:PostSoundEvent("Set_State_E_Death_Duel")
    end
  end, function()
    do return bg.battleRender.boutMgr.GetBoutNum end
    return bg.battleRender.boutMgr.GetBoutNum, bg.battleRender.boutMgr
  end)
  local recoverLeftTime = bg.battleDataCenter.recoverBoutLeftTime
  if recoverLeftTime and recoverLeftTime <= bg.DT.GetConstant("PVPTurnCountdown", 0) and recoverLeftTime > 1 then
    local data = {}
    data.isShow = true
    data.duration = recoverLeftTime
    self:OnTurnCountDown(data)
  end
end

function PvPBattleMainPanel:OnUnbind()
  if self._relicGesture then
    self._relicGesture:onPointerEnter("-", System.fn(self, self._OnRelicPointerEnter))
    self._relicGesture:onPointerExit("-", System.fn(self, self._OnRelicPointerExit))
    self._relicGesture:onPointerDown("-", System.fn(self, self._OnRelicPointerDown))
    self._relicGesture:onPointerUp("-", System.fn(self, self._OnRelicPointerUp))
    self._relicGesture = nil
  end
  bg.battlePanel = nil
  Super.OnUnbind(self)
  if bg.battleRender then
    if bg.battleRender.eventMgr then
      bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
    end
    bg.battleRender:UnperformWithAllDelaysByTarget(self)
  end
  self.tentacleItems = nil
  if self.countTimer then
    TimerManager.Instance:StopTimer(self.countTimer)
  end
  CS.UnityEngine.GameObject.Destroy(self.ui.Group_CountDown)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function PvPBattleMainPanel:InitComp()
  self:InitPlayerInfo()
  self:InitEnemyInfo()
end

function PvPBattleMainPanel:BindBtnEndTurn()
  local boutData = bg.battleDataCenter.boutData
  if boutData.camp == self:GetMyCamp() and boutData.phase == bc.BoutPhase.Action then
    self:ShowBtnEndTurnAnim()
  else
    self:HideBtnEndTurnAnim()
  end
  self.binder:BindButtonClick(self.ui.Btn_Battle_EndOfTurn, System.fn(self, self.OnBtnEndTurn))
  local uName = "KeyEndTurn"
  self.binder:BindComponent(ShortCutComp(self.ui.Text_EndTurnShortCut, uName, function()
    self:OnBtnEndTurn()
  end))
  self.binder:BindToRaw(function(_, isShow)
    if isShow then
      self:ShowBtnEndTurnAnim()
    else
      self:HideBtnEndTurnAnim()
    end
  end, function()
    local isBoutAction = boutData.phase == bc.BoutPhase.Begin or boutData.phase == bc.BoutPhase.Action
    if boutData.camp == self:GetMyCamp() and isBoutAction then
      return true
    end
  end, true)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.CommandResult, function(_, msgData)
    if msgData.msgId == BattleCommand.lg_BoutEnd and not msgData.ret then
      self:OnEndTurnFail()
    end
  end, self)
end

function PvPBattleMainPanel:BindCampGlowEffect()
  local binder = self.binder
  self.playerEffectGo = binder:Instantiate(binder:LoadAsset(CommonRes.PVPGlow.Player), self.ui.uiNode.transform)
  self.playerEffectGo.transform:SetAsFirstSibling()
  self.playerEffectGo:SetActive(false)
  self.enemyEffectGo = binder:Instantiate(binder:LoadAsset(CommonRes.PVPGlow.Enemy), self.ui.uiNode.transform)
  self.enemyEffectGo.transform:SetAsFirstSibling()
  self.enemyEffectGo:SetActive(false)
  self.binder:BindToRaw(function(cbinder, camp)
    local isMyCamp = self:GetMyCamp() == camp
    local effectGo = isMyCamp and self.playerEffectGo or self.enemyEffectGo
    local voiceObj = CS.Framework.GameObjectUtil.FindChildByPath(effectGo, "PlayCard_voice")
    local uiAnimCtrl = effectGo:GetComponent(typeof(UIAnimationController))
    local openAnim = isMyCamp and "UI_Pvp_VX_Battle_PlayCard_Glow01_Open" or "UI_Pvp_VX_Battle_PlayCard_Glow02_Open"
    local loopAnim = isMyCamp and "UI_Pvp_VX_Battle_PlayCard_Glow01" or "UI_Pvp_VX_Battle_PlayCard_Glow02"
    local closeAnim = isMyCamp and "UI_Pvp_VX_Battle_PlayCard_Glow01_Close" or "UI_Pvp_VX_Battle_PlayCard_Glow02_Close"
    cbinder:BindToRaw(function(c_cBinder, phase, oldPhase)
      if phase == bc.BattlePhase.Ready then
        effectGo:SetActive(true)
        uiAnimCtrl:PlayState(openAnim, function()
          uiAnimCtrl:LoopPlayState(loopAnim)
        end)
        if voiceObj then
          c_cBinder:SetCanvasGroup(voiceObj, 1)
        end
      elseif oldPhase == bc.BattlePhase.Battle then
        uiAnimCtrl:StopPlayableGraph()
        uiAnimCtrl:PlayState(closeAnim, function()
          effectGo:SetActive(false)
        end)
        if voiceObj then
          c_cBinder:SetCanvasGroup(voiceObj, 0)
        end
      end
    end, function()
      return bg.battleDataCenter.boutData.phase
    end)
  end, function()
    return bg.battleDataCenter.boutData.camp
  end)
end

function PvPBattleMainPanel:InitPlayerInfo()
  local playerRoleModel = bg.battleDataCenter:GetPlayerRoleDataModel(self:GetMyCamp())
  self.binder:BindToImage(self.ui.Image_Avatar_1, function()
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, playerRoleModel.icon
  end)
  self.binder:BindToText(self.ui.Text_Cost01, function()
    do return playerRoleModel.GetProperty, playerRoleModel end
    return playerRoleModel.GetProperty, playerRoleModel, bc.RoleProperty.energy
  end)
  self.binder:BindToText(self.ui.Text_Cost02, function()
    do return playerRoleModel.GetProperty, playerRoleModel end
    return playerRoleModel.GetProperty, playerRoleModel, bc.RoleProperty.max_energy
  end)
  self.binder:BindToText(self.ui.Text_Name_1, function()
    do return LT.Text end
    return LT.Text, playerRoleModel.playerName
  end)
  self.binder:BindButtonClick(self.ui.Btn_Click_Myself, System.fn(self, self.OnClickMySelf))
  self.binder:BindButtonClick(self.ui.Btn_Click_Enemy, function()
    if bg.isReplay then
      return
    end
    self.ui.Enemy_Expression:SetActive(false)
    self.ui.Image_Interactive:SetActive(true)
    self.ui.Set_Bg:SetActive(false)
    local curState = EmojiController.Instance:GetEnemyEmojiState()
    local str = true == curState and LT.Text("CloseExpression_PVP") or LT.Text("OpenExpression_PVP")
    local ButtonComp = self.ui.Btn_Interactive:GetComponent(TYPEOF_Z1Button)
    self.binder:SetText(ButtonComp.buttonTextComp, str)
  end)
  self.binder:BindZ1Button(self.ui.Btn_Interactive, function()
    if bg.isReplay then
      return
    end
    local curState = EmojiController.Instance:GetEnemyEmojiState()
    EmojiController.Instance:SetEnemyEmojiState(not curState)
    self.ui.Image_Interactive:SetActive(false)
  end)
  self.binder:BindButtonClick(self.ui.Btn_Mask_Enemy, function()
    self.ui.Image_Interactive:SetActive(false)
  end)
  local uName = "KeyKeeperSkill"
  self.binder:BindComponent(ShortCutComp(self.ui.Text_MySelfShortCut, uName, System.fn(self, self.OnClickMySelf)))
end

function PvPBattleMainPanel:OnClickMySelf()
  if bg.isPVP_TRAIN or bg.isReplay then
    return
  end
  if UIManager.Instance:GetWindow(Urls.EmojiShowView) == nil then
    UIManager.Instance:Reopen(Urls.EmojiShowView, self.ui.Btn_Click_Myself)
  end
end

function PvPBattleMainPanel:InitEnemyInfo()
  local playerRoleModel = bg.battleDataCenter:GetPlayerRoleDataModel(self:GetEnemyCamp())
  self.binder:BindToImage(self.ui.Image_Avatar_2, function()
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, playerRoleModel.icon
  end)
  self.binder:BindToText(self.ui.Text_Cost03, function()
    do return playerRoleModel.GetProperty, playerRoleModel end
    return playerRoleModel.GetProperty, playerRoleModel, bc.RoleProperty.energy
  end)
  self.binder:BindToText(self.ui.Text_Cost04, function()
    do return playerRoleModel.GetProperty, playerRoleModel end
    return playerRoleModel.GetProperty, playerRoleModel, bc.RoleProperty.max_energy
  end)
  self.binder:BindToText(self.ui.Text_Name_2, function()
    do return LT.Text end
    return LT.Text, playerRoleModel.playerName
  end)
end

function PvPBattleMainPanel:OnTurnCountDown(data)
  if bg.isReplay then
    return
  end
  if self.countTimer then
    TimerManager.Instance:StopTimer(self.countTimer)
  end
  local isShow = data.isShow
  local dura = data.duration
  local countDownAnimCtr = self.ui.Group_CountDown:GetComponent(typeof(UIAnimationController))
  self.ui.Text_CountDown:SetActive(true == isShow)
  self.ui.Group_CountDown:SetActive(true == isShow)
  if isShow and dura then
    BattleVoiceController.Instance:OnPvpVoiceCountingStart()
    if 20 == dura then
      AudioManager.Instance:PostSoundEvent("Play_NTC_PVP_Countdown_20s")
    end
    self.countTimer = TimerManager.Instance:CreateCountDown(dura - 1, function(leftSecond)
      if 10 == leftSecond then
        AudioManager.Instance:PostSoundEvent("Play_NTC_PVP_Countdown_10s")
      elseif 15 == leftSecond then
        AudioManager.Instance:PostSoundEvent("Play_NTC_PVP_Countdown_15s")
      elseif 20 == leftSecond then
        AudioManager.Instance:PostSoundEvent("Play_NTC_PVP_Countdown_20s")
      elseif 0 == leftSecond then
        AudioManager.Instance:PostSoundEvent("Play_NTC_PVP_Countdown_0s")
      elseif leftSecond < 10 then
        AudioManager.Instance:PostSoundEvent("Play_NTC_PVP_Countdown_10to1s")
      end
      self.binder:SetText(self.ui.Text_CountDown, leftSecond)
      countDownAnimCtr:PlayState("UI_Pvp_Panel_Battle_Group_CountDown01")
    end, function()
      self.ui.Text_CountDown:SetActive(false)
      self.ui.Group_CountDown:SetActive(false)
    end, 0.05)
  end
  local topRoot = CS.UnityEngine.GameObject.Find("TopRoot")
  if IsNil(topRoot) then
    return
  end
  local topTf = topRoot.transform
  self.ui.Group_CountDown.transform:SetParent(topTf, true)
end

function PvPBattleMainPanel:ShowEmoji(data)
  local iconId = data.emoji
  local sendCamp = data.sendCamp
  local myCamp = self:GetMyCamp()
  if sendCamp == myCamp then
    self:ShowMyEmoji(iconId)
  else
    self:ShowEnemyEmoji(iconId)
  end
end

function PvPBattleMainPanel:ShowMyEmoji(iconId)
  local itemCfg = DT.Item[iconId]
  if itemCfg then
    self.binder:SetImage(self.ui.Image_Expression_01, itemCfg.Icon)
  end
  self.myEmojiCtrl:StopPlayableGraph()
  self.ui.Myself_Expression:SetActive(true)
  AudioManager.Instance:PostSoundEvent("Play_NTC_PVP_Emoji_Send")
  self.myEmojiCtrl:PlayState("UI_Pvp_Myself_Expression_Open", function()
    self.ui.Myself_Expression:SetActive(false)
  end)
end

function PvPBattleMainPanel:ShowEnemyEmoji(iconId)
  local curState = EmojiController.Instance:GetEnemyEmojiState()
  if false == curState then
    return
  end
  local itemCfg = DT.Item[iconId]
  if itemCfg then
    self.binder:SetImage(self.ui.Image_Expression_02, itemCfg.Icon)
  end
  self.enemyEmojiCtrl:StopPlayableGraph()
  self.ui.Enemy_Expression:SetActive(true)
  AudioManager.Instance:PostSoundEvent("Play_NTC_PVP_Emoji_Receive")
  self.enemyEmojiCtrl:PlayState("UI_Pvp_Myself_Expression_Open", function()
    self.ui.Enemy_Expression:SetActive(false)
  end)
end

function PvPBattleMainPanel:OnChangeBoutPhase(_)
  if self.countTimer then
    TimerManager.Instance:StopTimer(self.countTimer)
  end
  self.ui.Text_CountDown:SetActive(false)
  self.ui.Group_CountDown:SetActive(false)
end

function PvPBattleMainPanel:InitBoutAnimUI()
  self.boutAnimUI = self.binder:BindComponent(PVPBattleBoutAnimUI(self.ui.uiNode))
end

function PvPBattleMainPanel:InitBattleCardUI()
  self.cardUIMap = {}
  local pvpCardMgr = bg.battleRender.cardMgr
  local myCamp = self:GetMyCamp()
  local cardUI = self.binder:BindComponent(BattlePanelCardUI(PVPMysideCardUIDelegate(self.ui), pvpCardMgr:GetCardMgrByCamp(myCamp), myCamp, self))
  self.cardUIMap[myCamp] = cardUI
  local enemyCamp = self:GetEnemyCamp()
  cardUI = self.binder:BindComponent(BattlePanelCardUI(PVPEmemyCardUIDelegate(self.ui), pvpCardMgr:GetCardMgrByCamp(enemyCamp), myCamp, self))
  self.cardUIMap[enemyCamp] = cardUI
end

function PvPBattleMainPanel:BindEnergyBoutEndVisble()
  self.binder:BindToVisible(self.ui.Group_Cost, function()
    return bg.battleDataCenter.boutData.camp == self:GetMyCamp()
  end)
  self.binder:BindButtonClick(self.ui.Btn_Battle_Cost, function()
    local tipTid = 40009
    UIManager.Instance:Reopen(Urls.AlertToolTipsPanel, {
      tipTid = tipTid,
      desc = LT.Textf(DT.TipsType[tipTid].Desc, bg.battleDataCenter.boutData.boutNumber)
    }, self.ui.Group_Cost)
  end)
end

function PvPBattleMainPanel:BindSettingBtn()
  self.binder:BindButtonClick(self.ui.Btn_Setting, System.fn(self, self.OnBtnSetting))
  self.binder:BindButtonClick(self.ui.Btn_Mask, function()
    self.ui.Set_Bg:SetActive(not self.ui.Set_Bg.activeSelf)
    self.ui.Image_Interactive:SetActive(false)
  end)
  local giveUpStr = LT.Text("PvPGiveUp")
  if bg.isPVP_TRAIN then
    giveUpStr = LT.Text("PvPTrainGiveUp")
  elseif bg.isReplay then
    giveUpStr = LT.Text("PvPExitReplay")
  end
  local uName = "KeyCancelOrSetting"
  local settingUI = Btn_Battle_DbgResource(self.ui.Btn_Setting)
  self.binder:BindComponent(ShortCutComp(settingUI.Text_ShortCut, uName, function()
    self:OnBtnSetting()
  end))
  self.binder:BindZ1Button(self.ui.Btn_Surrender, function()
    if bg.isReplay then
      UIManager.Instance:CloseByUrl(Urls.PVPReplayBattlePanel)
      UIManager.Instance:CloseByUrl(Urls.PVEReplayBattlePanel)
      return
    end
    if bg.isPVP_TRAIN then
      bg.battleRender:SendCommand(BattleCommand.lg_Giveup, {
        playerId = bg.battleDataCenter:GetMyPlayerId()
      })
      return
    end
    Alert.Show("PVPSurrenderConfirm", nil, function()
      bg.battleRender:SendCommand(BattleCommand.lg_Giveup, {
        playerId = bg.battleDataCenter:GetMyPlayerId()
      })
    end)
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    return giveUpStr
  end)
end

function PvPBattleMainPanel:OnBtnSetting()
  self.ui.Set_Bg:SetActive(not self.ui.Set_Bg.activeSelf)
  self.ui.Image_Interactive:SetActive(false)
end

function PvPBattleMainPanel:BindHistory()
  self.binder:BindComponent(PvPCardRecordComp(self.ui.uiNode))
end

function PvPBattleMainPanel:BindDraftRelic()
  local relicTid = bg.battleDataCenter.draftRelicTid
  if relicTid then
    self.binder:SetActive(self.ui.Group_Relic, true)
    self.binder:SetImage(self.ui.Image_Relic, RelicCfgUtils.GetCfgField("Icon", relicTid))
    self._relicGesture = self.ui.Image_Relic:GetComponent(typeof(DragGesture))
    self._relicGesture.longPressTime = 0.066
    self._relicGesture:onPointerEnter("+", System.fn(self, self._OnRelicPointerEnter))
    self._relicGesture:onPointerExit("+", System.fn(self, self._OnRelicPointerExit))
    self._relicGesture:onPointerDown("+", System.fn(self, self._OnRelicPointerDown))
    self._relicGesture:onPointerUp("+", System.fn(self, self._OnRelicPointerUp))
  else
    self.binder:SetActive(self.ui.Group_Relic, false)
  end
end

function PvPBattleMainPanel:_OnRelicPointerEnter()
  if self._relicClickTipsComp then
    self._relicClickTipsComp:OnMaskClicked()
    self._relicClickTipsComp = nil
  end
  self._relicClickTipsComp = self.binder:BindNewComponent(CS.UnityEngine.GameObject.Find("UIRoot/SafeArea/TipPopRoot"), RelicClickTips, UI_Common_Popup_Tips_6Resource, nil, Vue.ref({
    relicTid = bg.battleDataCenter.draftRelicTid
  }), {
    stageId = DataCenter.playerData.DRole.level,
    isGrey = true,
    isBanKeywordMask = true
  })
  local targetImagePos = self.ui.Image_Relic.transform.position
  local pos = CS.UnityEngine.Vector3(targetImagePos.x, targetImagePos.y - 8, 0)
  self._relicClickTipsComp:HideMask()
  self._relicClickTipsComp:SetItemPos2(pos)
end

function PvPBattleMainPanel:_OnRelicPointerExit()
  UIManager.Instance:CloseByUrl(Urls.CommonCardKeyWorldDescPanel)
  if self._relicClickTipsComp then
    self._relicClickTipsComp:OnMaskClicked()
    self._relicClickTipsComp = nil
  end
end

function PvPBattleMainPanel:_OnRelicPointerDown()
  self:_OnRelicPointerEnter()
end

function PvPBattleMainPanel:_OnRelicPointerUp()
  self:_OnRelicPointerExit()
end

function PvPBattleMainPanel:BindTentacleItem()
  local binder = self.binder
  for _, roleDataModel in pairs(bg.battleDataCenter.roleDataModelMap) do
    if roleDataModel.roleType == bc.RoleType.Player then
      binder:BindToRaw(function(_, maxTentacleCount)
        if self.tentacleItems[roleDataModel.camp] then
          return
        end
        local isMyCamp = bg.battleDataCenter:IsMyCamp(roleDataModel.camp)
        local container = isMyCamp and self.ui.Group_Tentacle_My or self.ui.Group_Tentacle_Enemy
        if maxTentacleCount and maxTentacleCount > 0 then
          container:SetActive(true)
          local res = Item_Battle_GroupTentacleResource(container)
          local tentacleItem = binder:BindComponent(TentacleStatusUIItem(res.Group_First_Tentacle, res.Group_Other_Tentacle, roleDataModel))
          self.tentacleItems[roleDataModel.camp] = tentacleItem
          local gesture = res.Btn_Click_Tentacle:GetComponent(typeof(DragGesture))
          self.gesture = gesture
          self.gesture:onPointerUp("+", function()
            if self.tipsUrl then
              UIManager.Instance:CloseByUrl(self.tipsUrl)
              self.tipsUrl = nil
            end
          end)
        else
          container:SetActive(true)
        end
      end, function()
        do return roleDataModel.GetTentacleMaxCount end
        return roleDataModel.GetTentacleMaxCount, roleDataModel
      end)
    end
  end
end

function PvPBattleMainPanel:OnSelectTargets(data)
  if bg.isReplay then
    return
  end
  local myCamp = self:GetMyCamp()
  local castUid = data.castRoleUid
  local camp = bg.battleDataCenter:GetRoleCamp(castUid)
  if camp ~= myCamp then
    return
  end
  if data.targetSelectType == bc.TargetSelectType.Awaker then
    local cmdTargetMode = bg.battleRender.cmdTargetMgr and bg.battleRender.cmdTargetMgr:GetModel() or bc.PVPTargetModel.Server
    if cmdTargetMode == bc.PVPTargetModel.Server then
      bg.battleRender.cmdTargetMgr:OnOpenSkillCastSelectPanel(data)
    end
  elseif data.targetSelectType == bc.TargetSelectType.Card then
    local cardUI = self.cardUIMap[camp]
    cardUI:OnSelectCards(data)
  elseif data.targetSelectType == bc.TargetSelectType.CardDrop or data.targetSelectType == bc.TargetSelectType.KeeperSkillDrop then
    print("[CardDrop] PvPBattleMainPanel:OnSelectTargets packList:", table.tostring(data.packList), "selectMaxNum:", tostring(data.selectMaxNum), "selectMinNum:", tostring(data.selectMinNum))
    UIManager.Instance:Reopen(Urls.BattleCardDropSelectView, data, function(packIndexList)
      print("[CardDrop] PvPBattleMainPanel callback packIndexList:", table.tostring(packIndexList))
      local resp = {
        effectUid = data.effectUid,
        packIndexList = packIndexList,
        selectType = data.targetSelectType
      }
      bg.battleRender:SendCommand(BattleCommand.lg_SelectTargets, resp)
    end)
  end
end

function PvPBattleMainPanel:OnBtnEndTurn()
  if self.isClickedBtnBout then
    return
  end
  if bg.battleRender:IsInSelectCard() then
    return
  end
  self.isClickedBtnBout = true
  local camp = bg.battleDataCenter.boutData.camp
  self:HideBtnEndTurnAnim()
  bg.battleRender:SendCommand(BattleCommand.lg_BoutEnd, {
    boutNumber = bg.battleRender.boutMgr:GetBoutNum(),
    playerId = bg.battleDataCenter:GetPlayerIdByCamp(camp)
  })
  BattleVoiceController.Instance:StopAllPvpVoice()
end

function PvPBattleMainPanel:OnEndTurnFail()
  self.isClickedBtnBout = false
  if bg.battleDataCenter:IsMyCamp() then
    self:ShowBtnEndTurnAnim()
  end
end

function PvPBattleMainPanel:ShowBtnEndTurnAnim()
  if self._isShowBtnEnd then
    return
  end
  self._isShowBtnEnd = true
  self.ui.Btn_Finishes:SetActive(not bg.isReplay)
  self.uiAnimCtr:PlayState("UI_Pvp_Panel_Battle_Startofturn")
end

function PvPBattleMainPanel:HideBtnEndTurnAnim()
  if self._isShowBtnEnd == false then
    return
  end
  self._isShowBtnEnd = false
  self.ui.Btn_Finishes:SetActive(not bg.isReplay)
  self.uiAnimCtr:PlayState("UI_Pvp_Panel_Battle_Endofturn")
end

function PvPBattleMainPanel:OnBattleResult()
  self:OnTurnCountDown({isShow = false})
end

function PvPBattleMainPanel:ShowRespawn(isRespawning, callback)
end

function PvPBattleMainPanel:HideRespawn()
end

function PvPBattleMainPanel:OnBattleFinish(winCamp)
end

function PvPBattleMainPanel:HideUI(isHide)
  self.isUIVisible.value = not isHide
  self.ui.uiNode:SetActive(not isHide)
end

function PvPBattleMainPanel:GetUIVisible()
  return self.isUIVisible.value
end

function PvPBattleMainPanel:RefreshCardNum()
  for _, cardUI in pairs(self.cardUIMap) do
    cardUI:RefreshCardNum()
  end
end

function PvPBattleMainPanel:AddNewCard(newCards, camp)
  local cardUI = self.cardUIMap[camp]
  if cardUI then
    cardUI:DelayAddNewCard(newCards)
  end
end

function PvPBattleMainPanel:OnUseCard(cardUid, deck)
  local cardClient = bg.battleRender.cardMgr:GetCardByUid(cardUid)
  if not cardClient then
    return
  end
  local myCardUI = self:GetCardUI(cardClient.camp)
  myCardUI:OnUseCard(cardUid, deck)
  if cardClient.camp ~= self:GetMyCamp() then
    BattleVoiceModel.Instance:ResetPvpPlayerThinking()
    local otherCardUI = self:GetCardUI(bg.battleDataCenter:GetEnemyCamp(cardClient.camp))
    otherCardUI:DisplayUsingCard(cardClient)
  end
end

function PvPBattleMainPanel:OnInsertHistory(data)
  local cardClient = BattleCardClient(data)
  if cardClient.camp ~= self:GetMyCamp() and cardClient.configData.Slot == "Slot_Super" then
    BattleVoiceModel.Instance:ResetPvpPlayerThinking()
    local otherCardUI = self:GetCardUI(bg.battleDataCenter:GetEnemyCamp(cardClient.camp))
    otherCardUI:DisplayUsingCard(cardClient)
  end
end

function PvPBattleMainPanel:GetCardItemByUid(cardUid, createIfNone)
  for camp, carUi in pairs(self.cardUIMap) do
    local cardItem = carUi:GetCardItemByUid(cardUid, createIfNone)
    if cardItem then
      return cardItem, camp
    end
  end
end

function PvPBattleMainPanel:GetCardUI(camp)
  return self.cardUIMap[camp]
end

function PvPBattleMainPanel:ShowCardDetail(card)
end

function PvPBattleMainPanel:OnRelicEffect(relicUid)
end

function PvPBattleMainPanel:OnBattleRecover()
  bg.battleRender:PerformWithDelay(1, function()
    bg.battleRender.recordMgr:RecoverRecords()
  end, self)
  bg.battleDataCenter.isRecover = false
end

return PvPBattleMainPanel
