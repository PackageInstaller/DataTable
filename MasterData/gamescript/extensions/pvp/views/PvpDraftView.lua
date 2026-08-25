local DOTween = CS.DG.Tweening.DOTween
local TransformUtil = CS.Framework.TransformUtil
local BtnType = CommonDefine.BtnType
local MaxPoolAwakerCount = 12
local MaxPoolWeaponCount = 10
local MaxPoolKeeperSkillCount = 5
local PvpDraftView, _ = NewClass("PvpDraftView", BaseView)
PvpDraftView.uiResCls = UI_PVP_Panel_TeamRotationResource

function PvpDraftView:OnBuildView()
  self._playerInfoComp = self:AddViewComponentOnce(self.ui.Group_My, UICompPvpDraftPlayerInfo)
  self._enemyInfoComp = self:AddViewComponentOnce(self.ui.Group_Other, UICompPvpDraftEnemyInfo)
  self._stageInfoComp = self:AddViewComponentOnce(self.ui.UI_PVP_Item_Rotation_StageInfo, UICompPvpDraftStageInfo)
end

function PvpDraftView:OnEnterView()
  AudioManager.Instance:PostSoundEvent("Set_State_Aa_Interface_PVP")
  AudioManager.Instance:PostSoundEvent("Set_State_B_PVP_MatchOn")
  PvpDraftModel.Instance:SetChoosingUid(PvpDraftModel.Instance:GetChoosingUid())
  self:_UpdateViewData()
  self:SetActive(self.ui.Group_UltiSkill_Detail, false)
  self:_PlayEnterMusic()
  self:_RefreshView()
end

function PvpDraftView:OnEnterViewFinished()
  self:_PlayEnterAnim()
end

function PvpDraftView:RegisterEvents()
  self:BindEvent(EventMgr.Instance.PvpDraftPlayerSelectChanged, System.fn(self, self._OnPvpDraftPlayerSelectChanged))
  self:BindEvent(EventMgr.Instance.PvpDraftEnemySelectChanged, System.fn(self, self._OnPvpDraftEnemySelectChanged))
  self:BindEvent(EventMgr.Instance.PvpDraftDataUpdate, System.fn(self, self._OnPvpDraftDataUpdate))
  self:BindEvent(EventMgr.Instance.PvpDraftClickOpenUltiSkill, System.fn(self, self._OnPvpDraftClickOpenUltiSkill))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnConfirmBtnClick))
  self:AddUICustomInputlistener(self.ui.Image_Detailed_Bg, function(hover)
    if GuidePanelUtils.IsViewAtTop(Urls.CommonCardKeyWorldDescPanel) then
      return
    end
    if not hover then
      self:SetActive(self.ui.Group_UltiSkill_Detail, false)
    end
  end)
end

function PvpDraftView:_PlayEnterMusic()
  AudioManager.Instance:PostSoundEvent("Set_State_A_Ingame")
  AudioManager.Instance:PostSoundEvent("Set_State_B_PVP_Runoff")
  AudioManager.Instance:PostSoundEvent("Set_State_E_Prepare")
end

function PvpDraftView:_OnPvpDraftClickOpenUltiSkill(ultiSkillTid, collectionTid)
  self:SetActive(self.ui.Group_UltiSkill_Detail, true)
  local skillName = SkillCfgUtils.GetCfgField("Name", ultiSkillTid)
  self:SetText(self.ui.Text_Ulti_Skill_Tag, LT.Text("UltlSkillName"))
  self:SetText(self.ui.Text_Skill_Name, skillName and LT.Text(skillName) or "")
  self:_RefreshAwakerUltiSkillDesc(ultiSkillTid, collectionTid)
end

function PvpDraftView:_OnConfirmBtnClick()
  local btnState = self:_GetConfirmBtnState()
  if btnState ~= BtnType.High then
    return
  end
  local myPlayerData = PvpDraftModel.Instance:GetMyPlayerData()
  local targetCollectionTid = PvpDraftModel.Instance:GetPlayerSelectCollectionTid()
  if table.contains(myPlayerData.collectList, targetCollectionTid) then
    Alert.ShowStr(LT.Text("PvpDraftClickConfirmWhenNotSelect"))
    return
  end
  PvpController.Instance:ReqDraftChooseCollect(targetCollectionTid, true)
end

function PvpDraftView:_OnPvpDraftPlayerSelectChanged()
  self:_RefreshPlayerSelect()
  self:_RefreshDraftAwakers()
  self:_RefreshDraftWeapons()
  self:_RefreshDraftKeeperSkills()
  self:_RefreshConfirmBtnState()
end

function PvpDraftView:_OnPvpDraftEnemySelectChanged()
  self:_RefreshEnemySelect()
  self:_RefreshDraftAwakers()
  self:_RefreshDraftWeapons()
  self:_RefreshDraftKeeperSkills()
end

function PvpDraftView:_OnPvpDraftDataUpdate()
  self:_RefreshView()
end

function PvpDraftView:_UpdateViewData()
  self._enterGoList = {}
end

function PvpDraftView:_GetConfirmBtnState()
  if not PvpDraftModel.Instance:IsPlayerSelectingPhase() then
    return BtnType.Unclickable
  end
  local playerSelectTid = PvpDraftModel.Instance:GetPlayerSelectCollectionTid()
  if not playerSelectTid then
    return BtnType.Unclickable
  end
  if PvpDraftModel.Instance:IsPlayerCollectionTypeFully(playerSelectTid) then
    return BtnType.Unclickable
  end
  return BtnType.High
end

function PvpDraftView:_RefreshView()
  self:_RefreshPlayerSelect()
  self:_RefreshEnemySelect()
  self:_RefreshRelic()
  self:_RefreshDraftAwakers()
  self:_RefreshDraftWeapons()
  self:_RefreshDraftKeeperSkills()
  self:_RefreshConfirmBtnState()
end

function PvpDraftView:_RefreshPlayerSelect()
  self._playerInfoComp:OnDraftDataUpdate()
end

function PvpDraftView:_RefreshEnemySelect()
  self._enemyInfoComp:OnDraftDataUpdate()
end

function PvpDraftView:_RefreshRelic()
  local endTs, totalTime
  local curPhase = PvpDraftModel.Instance:GetDraftPvpPhase()
  if curPhase == PvpDefine.PvpDraftPhase.Start then
    endTs = PvpDraftModel.Instance:GetDraftStartAnimationEndTs()
    totalTime = PvpDraftModel.Instance:GetDraftStartAnimationTime()
  else
    endTs = PvpDraftModel.Instance:GetDraftRotationEndTs()
    totalTime = PvpDraftModel.Instance:GetDraftRotationPickTime()
  end
  if endTs > TimeUtils.GetServerTime() then
    self._stageInfoComp:SetCountDownTimer(endTs, totalTime)
  end
end

function PvpDraftView:_RefreshDraftAwakers()
  local awakerPoolList = PvpDraftModel.Instance:GetAwakerPoolList()
  for i = 1, MaxPoolAwakerCount do
    local ui = self.ui["Item_Pool_Awaker_" .. i]
    self:AddViewComponentOnce(ui, UICompPvpDraftPoolAwaker, awakerPoolList[i])
  end
end

function PvpDraftView:_RefreshDraftWeapons()
  local weaponPoolList = PvpDraftModel.Instance:GetWeaponPoolList()
  for i = 1, MaxPoolWeaponCount do
    local ui = self.ui["Item_Pool_Trinket_" .. i]
    self:AddViewComponentOnce(ui, UICompPvpDraftPoolWeapon, weaponPoolList[i])
  end
end

function PvpDraftView:_RefreshDraftKeeperSkills()
  local keeperSkillPoolList = PvpDraftModel.Instance:GetKeeperSkillPoolList()
  for i = 1, MaxPoolKeeperSkillCount do
    local ui = self.ui["Item_Pool_KeyToken_" .. i]
    self:AddViewComponentOnce(ui, UICompPvpDraftPoolKeeperSkill, keeperSkillPoolList[i])
  end
end

function PvpDraftView:_RefreshConfirmBtnState()
  self:SetButtonState(self.ui.Btn_Confirm, self:_GetConfirmBtnState())
end

function PvpDraftView:_RefreshAwakerUltiSkillDesc(ultiSkillTid, collectionTid)
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(collectionTid)
  if not awakerTid then
    return
  end
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not AwakerDataUtils.HasOwnedAwaker(awakerData.tid) then
    local attrs = AwakerDataUtils.GetNotOwnAwakerAttrs(awakerTid)
    awakerData.attrs = attrs
  end
  self:SetText(self.ui.Text_Skill_Desc, SkillUtils.GetAwakerSkillDesc(awakerData, ultiSkillTid, 1))
end

function PvpDraftView:_PlayEnterAnim()
  if PvpDraftModel.Instance:GetDraftPvpPhase() ~= PvpDefine.PvpDraftPhase.Start then
    return
  end
  if self._enterDotSequence then
    self._enterDotSequence:Kill()
  end
  local countDown = PvpDraftModel.Instance:GetDraftStartAnimationCountDown()
  local enterGoList = self:_GetEnterGoList()
  local enterGoListLen = #enterGoList
  self._enterDotSequence = self._enterDotSequence or DOTween.Sequence(self)
  for _, targetGo in ipairs(enterGoList) do
    TransformUtil.SetLocalScale(targetGo.transform, 0, 0, 0)
  end
  for i = 1, enterGoListLen do
    local targetGo = enterGoList[i]
    self._enterDotSequence:Insert((i - 1) * (countDown / enterGoListLen), DOTween.To(function()
      return 0
    end, function(val)
      TransformUtil.SetLocalScale(targetGo.transform, val, val, val)
    end, 1, countDown / enterGoListLen, self))
  end
end

function PvpDraftView:_GetEnterGoList()
  if self._enterGoList and table.next(self._enterGoList) then
    return self._enterGoList
  end
  self._enterGoList = {
    self.ui.UI_PVP_Item_Rotation_StageInfo,
    self.ui.Item_Pool_Awaker_1,
    self.ui.Item_Pool_Awaker_4,
    self.ui.Item_Pool_Awaker_7,
    self.ui.Item_Pool_Awaker_10,
    self.ui.Item_Pool_Awaker_2,
    self.ui.Item_Pool_Awaker_5,
    self.ui.Item_Pool_Awaker_8,
    self.ui.Item_Pool_Awaker_11,
    self.ui.Item_Pool_Awaker_3,
    self.ui.Item_Pool_Awaker_6,
    self.ui.Item_Pool_Awaker_9,
    self.ui.Item_Pool_Awaker_12
  }
  for i = 1, MaxPoolWeaponCount do
    table.insert(self._enterGoList, self.ui["Item_Pool_Trinket_" .. i])
  end
  for i = 1, MaxPoolKeeperSkillCount do
    table.insert(self._enterGoList, self.ui["Item_Pool_KeyToken_" .. i])
  end
  return self._enterGoList
end

return PvpDraftView
