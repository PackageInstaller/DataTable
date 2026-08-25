local MaxTeamAwakerCount = 4
local MaxTeamWeaponCount = 4
local MaxTeamKeeperSkillCount = 2
local PvpDraftAdjustTeamView, _ = NewClass("PvpDraftAdjustTeamView", BaseView)
PvpDraftAdjustTeamView.uiResCls = UI_PVP_Panel_Rotation_AdjustResource

function PvpDraftAdjustTeamView:OnBuildView()
  self._playerTeamComp = self:AddViewComponentOnce(self.ui.Group_My_TeamInfo, UICompPvpDraftPlayerTeam)
  self._enemyTeamComp = self:AddViewComponentOnce(self.ui.Group_Other_TeamInfo, UICompPvpDraftEnemyTeam)
end

function PvpDraftAdjustTeamView:OnEnterView()
  AudioManager.Instance:PostSoundEvent("Set_State_Aa_Interface_PVP")
  AudioManager.Instance:PostSoundEvent("Set_State_B_PVP_MatchOn")
  self._portraitCompDict = {}
  self:_UpdateViewData()
  self:_RefreshView()
  self:_RefreshAntiAccidentalTouchBtn()
  self:_InitAwakerPortrait()
  self:_RefreshEnemyTeamInfo()
end

function PvpDraftAdjustTeamView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
  self:BindEvent(EventMgr.Instance.PvpDraftDataUpdate, System.fn(self, self._OnPvpDraftDataUpdate))
end

function PvpDraftAdjustTeamView:_OnPvpDraftDataUpdate()
  self:_UpdateViewData()
  self:_RefreshView()
end

function PvpDraftAdjustTeamView:_OnClickConfirm()
  if self._isAntiAccidentalTouch then
    return
  end
  local isAdjustReady = PvpDraftModel.Instance:GetPlayerAdjustReady()
  if isAdjustReady then
    return
  end
  PvpController.Instance:ReqDraftAdjustTeam("", 0, 0, true, System.fn(self, self._OnConfirmAdjust))
end

function PvpDraftAdjustTeamView:_OnConfirmAdjust()
  PvpDraftModel.Instance:SetAdjustCollectionTid(nil)
end

function PvpDraftAdjustTeamView:_UpdateViewData()
  self._playerTeamData = PvpDraftModel.Instance:GetPlayerTeamData()
end

function PvpDraftAdjustTeamView:SetSelectCollectionTid(newTid)
  local isAdjustReady = PvpDraftModel.Instance:GetPlayerAdjustReady()
  if isAdjustReady then
    return
  end
  local selectCollectionTid = PvpDraftModel.Instance:GetAdjustCollectionTid()
  if not selectCollectionTid then
    PvpDraftModel.Instance:SetAdjustCollectionTid(newTid)
    return
  end
  local newCollectionType = PvpCollectCfgUtils.GetCollectionType(newTid)
  local oldCollectionType = PvpCollectCfgUtils.GetCollectionType(selectCollectionTid)
  if newCollectionType ~= oldCollectionType then
    PvpDraftModel.Instance:SetAdjustCollectionTid(newTid)
    return
  end
  PvpController.Instance:ReqDraftAdjustTeam(self:_GetAdjustFieldName(newCollectionType), self:_GetAdjustItemIdxByTid(newTid), self:_GetAdjustItemIdxByTid(selectCollectionTid), false, function()
    PvpDraftModel.Instance:SetAdjustCollectionTid(nil)
  end)
end

function PvpDraftAdjustTeamView:_GetAdjustFieldName(collectionType)
  if collectionType == CommonDefine.PVPCollectionType.Awaker then
    return "awakerList"
  elseif collectionType == CommonDefine.PVPCollectionType.Weapon then
    return "weaponList"
  elseif collectionType == CommonDefine.PVPCollectionType.KeeperSkill then
    return "keeperSkillList"
  end
end

function PvpDraftAdjustTeamView:_GetAdjustItemIdxByTid(tid)
  local collectionType = PvpCollectCfgUtils.GetCollectionType(tid)
  if collectionType == CommonDefine.PVPCollectionType.Awaker then
    do return self._GetTeamAwakerIdxByTid, self end
    return self._GetTeamAwakerIdxByTid, self, tid
  elseif collectionType == CommonDefine.PVPCollectionType.Weapon then
    do return self._GetTeamWeaponIdxByTid, self end
    return self._GetTeamWeaponIdxByTid, self, tid
  elseif collectionType == CommonDefine.PVPCollectionType.KeeperSkill then
    do return self._GetTeamKeeperSkillIdxByTid, self end
    return self._GetTeamKeeperSkillIdxByTid, self, tid
  end
end

function PvpDraftAdjustTeamView:_GetTeamAwakerIdxByTid(tid)
  for i, awakerInfo in ipairs(self._playerTeamData.awakerList) do
    if awakerInfo.tid == tid then
      return i
    end
  end
  return nil
end

function PvpDraftAdjustTeamView:_GetTeamWeaponIdxByTid(tid)
  for i, weaponInfo in ipairs(self._playerTeamData.weaponList) do
    if weaponInfo.tid == tid then
      return i
    end
  end
  return nil
end

function PvpDraftAdjustTeamView:_GetTeamKeeperSkillIdxByTid(tid)
  for i, keeperSkillInfo in ipairs(self._playerTeamData.keeperSkillList) do
    if keeperSkillInfo.tid == tid then
      return i
    end
  end
  return nil
end

function PvpDraftAdjustTeamView:_GetTeamAwakerTidByIdx(idx)
  local awakerInfo = self._playerTeamData.awakerList[idx]
  return awakerInfo and awakerInfo.tid
end

function PvpDraftAdjustTeamView:_GetTeamWeaponTidByIdx(idx)
  local weaponInfo = self._playerTeamData.weaponList[idx]
  return weaponInfo and weaponInfo.tid
end

function PvpDraftAdjustTeamView:_GetTeamKeeperSkillTidByIdx(idx)
  local keeperSkillInfo = self._playerTeamData.keeperSkillList[idx]
  return keeperSkillInfo and keeperSkillInfo.tid
end

function PvpDraftAdjustTeamView:_RefreshView()
  self:_RefreshMyTeamInfo()
  self:_RefreshStandByState()
  self:_RefreshRelic()
  self:_RefreshTeamAdjust()
  self:_RefreshBtnState()
end

function PvpDraftAdjustTeamView:_RefreshAntiAccidentalTouchBtn()
  self._isAntiAccidentalTouch = true
  self:SetButtonState(self.ui.Btn_Confirm, CommonDefine.BtnType.Unclickable)
  self:SetButtonText(self.ui.Btn_Confirm, "1s")
  self:BindTimer(1, 0, nil, function()
    self._isAntiAccidentalTouch = false
    self:_RefreshBtnState()
  end)
end

function PvpDraftAdjustTeamView:_RefreshBtnState()
  if self._isAntiAccidentalTouch then
    return
  end
  self:SetButtonText(self.ui.Btn_Confirm, LT.Text("PvpDraftAdjustPosReady"))
  local isAdjustReady = PvpDraftModel.Instance:GetPlayerAdjustReady()
  self:SetButtonState(self.ui.Btn_Confirm, isAdjustReady and CommonDefine.BtnType.Unclickable or CommonDefine.BtnType.High)
end

function PvpDraftAdjustTeamView:_RefreshEnemyTeamInfo()
  self._enemyTeamComp:RefreshPlayerTeamByTeamData()
end

function PvpDraftAdjustTeamView:_RefreshMyTeamInfo()
  self._playerTeamComp:RefreshPlayerTeamByTeamData()
end

function PvpDraftAdjustTeamView:_RefreshStandByState()
  self:SetActive(self.ui.Group_My_StandBy, PvpDraftModel.Instance:GetPlayerAdjustReady())
  self:SetActive(self.ui.Group_Other_StandBy, PvpDraftModel.Instance:GetEnemyAdjustReady())
end

function PvpDraftAdjustTeamView:_InitAwakerPortrait()
  for i = 1, MaxTeamAwakerCount do
    local obj = self.ui["Team_" .. i]
    local collectionTid = self:_GetTeamAwakerTidByIdx(i)
    if collectionTid then
      self:AddViewComponentOnce(obj, UICompPvpDraftAdjustItemAwaker, self:_CreateAdjustItemData(collectionTid))
      local awakerId = PvpCollectCfgUtils.GetAwakerTidByCollectTid(collectionTid)
      if awakerId then
        local dressedSkinTid = AwakerSkinUtils.GetAwakerDressedSkin(awakerId)
        local skinRes = AwakerSkinUtils.GetSkinResNum(dressedSkinTid)
        local portraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui["Container_Awaker_" .. i], awakerId, skinRes, nil, CommonDefine.PortraitAlign.Center))
        self._portraitCompDict[i] = portraitComp
      end
    end
  end
end

function PvpDraftAdjustTeamView:_RefreshTeamAdjust()
  for i = 1, MaxTeamAwakerCount do
    local obj = self.ui["Team_" .. i]
    local collectionTid = self:_GetTeamAwakerTidByIdx(i)
    if collectionTid then
      self:AddViewComponentOnce(obj, UICompPvpDraftAdjustItemAwaker, self:_CreateAdjustItemData(collectionTid))
      local awakerId = PvpCollectCfgUtils.GetAwakerTidByCollectTid(collectionTid)
      if awakerId then
        local dressedSkinTid = AwakerSkinUtils.GetAwakerDressedSkin(awakerId)
        local skinRes = AwakerSkinUtils.GetSkinResNum(dressedSkinTid)
        local portraitComp = self._portraitCompDict[i]
        if portraitComp then
          portraitComp:ChangeAwakerWithResNum(awakerId, skinRes)
        end
      end
    end
  end
  for i = 1, MaxTeamWeaponCount do
    local obj = self.ui["Skill_" .. i]
    local collectionTid = self:_GetTeamWeaponTidByIdx(i)
    if collectionTid then
      self:AddViewComponentOnce(obj, UICompPvpDraftAdjustItemWeapon, self:_CreateAdjustItemData(collectionTid))
    end
  end
  for i = 1, MaxTeamKeeperSkillCount do
    local obj = self.ui["KeyToken_" .. i]
    local collectionTid = self:_GetTeamKeeperSkillTidByIdx(i)
    if collectionTid then
      self:AddViewComponentOnce(obj, UICompPvpDraftAdjustItemKeeperSkill, self:_CreateAdjustItemData(collectionTid))
    end
  end
end

function PvpDraftAdjustTeamView:_CreateAdjustItemData(collectionTid)
  return {
    collectionTid = collectionTid,
    clickCb = System.fn(self, self._OnClickAdjustItem)
  }
end

function PvpDraftAdjustTeamView:_OnClickAdjustItem(collectionTid)
  self:SetSelectCollectionTid(collectionTid)
end

function PvpDraftAdjustTeamView:_RefreshRelic()
  local stageInfoComp = self:AddViewComponentOnce(self.ui.UI_PVP_Item_Rotation_StageInfo, UICompPvpDraftStageInfo)
  local endTs = PvpDraftModel.Instance:GetDraftChangePositionEndTs()
  local totalTime = PvpDraftModel.Instance:GetDraftChangePositionTime()
  if endTs > TimeUtils.GetServerTime() then
    stageInfoComp:SetCountDownTimer(endTs, totalTime)
  end
end

return PvpDraftAdjustTeamView
