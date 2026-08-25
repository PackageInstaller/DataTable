local MaxShowSkillNum = 4
local UICompPvpDraftPlayerInfo, Super = NewViewComponent("UICompPvpDraftPlayerInfo")

function UICompPvpDraftPlayerInfo:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_PVP_Item_RotationPlayerResource(uiNode)
end

function UICompPvpDraftPlayerInfo:OnBuildComponent()
  self._teamInfoComp = self:AddViewComponentOnce(self.ui.UI_PVP_Item_RotationTeamInfo, UICompPvpDraftPlayerTeam)
end

function UICompPvpDraftPlayerInfo:OnEnterComponent()
  self:_UpdateViewData()
  self:_RefreshView()
end

function UICompPvpDraftPlayerInfo:OnExitComponent()
  self:_ClearAwakerPortrait()
  self:_ClearCardItem()
  Super.OnExitComponent(self)
end

function UICompPvpDraftPlayerInfo:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Maniac, System.fn(self, self._OnClickManiac))
end

function UICompPvpDraftPlayerInfo:_OnClickManiac()
  local ultiSkillTid = PvpCollectCfgUtils.GetCollectAwakerUltiSkillTid(self._showCollectionTid)
  EventMgr.Instance.PvpDraftClickOpenUltiSkill:Dispatch(ultiSkillTid, self._showCollectionTid)
end

function UICompPvpDraftPlayerInfo:OnDraftDataUpdate()
  self:_UpdateViewData()
  self:_RefreshView()
end

function UICompPvpDraftPlayerInfo:_GetPlayerData()
  do return PvpDraftModel.Instance.GetMyPlayerData end
  return PvpDraftModel.Instance.GetMyPlayerData, PvpDraftModel.Instance
end

function UICompPvpDraftPlayerInfo:_GetShowCollectionTid()
  local rst = PvpDraftModel.Instance:GetPlayerSelectCollectionTid()
  if not rst or table.contains(self._playerData.collectList, rst) then
    rst = self:_GetLastCollectionTid()
  end
  return rst
end

function UICompPvpDraftPlayerInfo:_GetLastCollectionTid()
  if not self._playerData or not self._playerData.collectList then
    return nil
  end
  local len = #self._playerData.collectList
  return self._playerData.collectList[len]
end

function UICompPvpDraftPlayerInfo:_UpdateViewData()
  self._playerData = self:_GetPlayerData()
  self._showCollectionTid = self:_GetShowCollectionTid()
end

function UICompPvpDraftPlayerInfo:_RefreshView()
  self:_RefreshPlayerTeamInfo()
  self:_RefreshCollectionInfo()
  self:_RefreshEmptyState()
  self:_RefreshSelectingState()
end

function UICompPvpDraftPlayerInfo:_RefreshSelectingState()
  local isSelecting = PvpDraftModel.Instance:GetChoosingUid() == self._playerData.uid
  self:SetActive(self.ui.Group_Selecting, isSelecting)
end

function UICompPvpDraftPlayerInfo:_RefreshEmptyState()
  local isSelectCollection = self._showCollectionTid and 0 ~= self._showCollectionTid
  self:SetActive(self.ui.Group_Wait, not isSelectCollection)
end

function UICompPvpDraftPlayerInfo:_RefreshPlayerTeamInfo()
  self._teamInfoComp:RefreshPlayerTeamByCollectList()
end

function UICompPvpDraftPlayerInfo:_RefreshCollectionInfo()
  local collectionType = PvpCollectCfgUtils.GetCollectionType(self._showCollectionTid)
  if not collectionType then
    return
  end
  if collectionType == CommonDefine.PVPCollectionType.Awaker then
    self:_ClearCardItem()
    self:_RefreshSelectAwakerInfo()
  else
    self:_ClearAwakerPortrait()
    self:_RefreshSelectCardInfo()
  end
end

function UICompPvpDraftPlayerInfo:_RefreshSelectAwakerInfo()
  self:SetActive(self.ui.Group_Awaker_Info, true)
  self:SetActive(self.ui.Group_Skil, false)
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(self._showCollectionTid)
  if not awakerTid then
    return
  end
  local ultiSkillTid = PvpCollectCfgUtils.GetCollectAwakerUltiSkillTid(self._showCollectionTid)
  local skillName = SkillCfgUtils.GetCfgField("Name", ultiSkillTid)
  self:SetText(self.ui.Text_Maniac, skillName and LT.Text(skillName) or "")
  self:SetText(self.ui.Text_HP, PvpCollectCfgUtils.GetCollectAwakerHp(self._showCollectionTid))
  self:SetText(self.ui.Text_Awaker_Name, LT.Text(AwakerDataUtils.GetAwakerName(awakerTid)))
  self:_RefreshSelectAwakerPortrait(awakerTid)
  self:_RefreshSelectAwakerSkill()
end

function UICompPvpDraftPlayerInfo:_ClearAwakerPortrait()
  if self._awakerPortraitComp and self._awakerPortraitComp.binder then
    self._awakerPortraitComp.binder:teardown()
    self._awakerPortraitComp = nil
  end
end

function UICompPvpDraftPlayerInfo:_ClearCardItem()
  if self.cardItem and self.cardItem.binder then
    self.cardItem.binder:teardown()
    self.cardItem = nil
  end
end

function UICompPvpDraftPlayerInfo:_RefreshSelectAwakerPortrait(awakerTid)
  local resNum
  local dressedSkinTid = PvpDraftModel.Instance:GetPlayerDataCollectSkin(self._playerData, self._showCollectionTid)
  if dressedSkinTid and dressedSkinTid ~= CommonDefine.DefaultSkinTid then
    resNum = AwakerSkinUtils.GetSkinResNum(dressedSkinTid)
  end
  if not self._awakerPortraitComp then
    self._awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker_Half, awakerTid, resNum, nil, nil, {animationMode = true}))
  else
    self._awakerPortraitComp:ChangeAwakerWithResNum(awakerTid, resNum)
  end
end

function UICompPvpDraftPlayerInfo:_RefreshSelectAwakerSkill()
  local skillInfoList = PvpCollectCfgUtils.GetCollectAwakerSkillInfoList(self._showCollectionTid)
  if not skillInfoList then
    return
  end
  for i = 1, MaxShowSkillNum do
    local skillInfo = skillInfoList[i]
    local obj = self.ui["Btn_Card_" .. i]
    if not obj then
    else
      if skillInfo then
        local itemData = {
          skillTid = skillInfo.tid,
          num = skillInfo.num,
          clickCallback = System.bind(self._OnClickAwakerSkill, self, skillInfo.tid)
        }
        self.binder:BindComponent(PVPCollectionDetailSkillItem(obj, itemData))
      end
      self:SetActive(obj, nil ~= skillInfo)
    end
  end
end

function UICompPvpDraftPlayerInfo:_OnClickAwakerSkill(skillTid)
  local panelData = {cardUid = 0, cardTid = skillTid}
  UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, panelData)
end

function UICompPvpDraftPlayerInfo:_RefreshSelectCardInfo()
  self:SetActive(self.ui.Group_Skil, true)
  self:SetActive(self.ui.Group_Awaker_Info, false)
  local itemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(self._showCollectionTid)
  if not itemCfg or not itemCfg.PVPSkill then
    return
  end
  local skillId = itemCfg.PVPSkill[1]
  if not self.cardItem then
    self.cardItem = self.binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Skill, 0, skillId, nil, nil, nil, nil, nil, nil, {ignoreUnknowImage = true}))
  else
    self.cardItem:ResetCardId(skillId)
  end
  self.cardItem:SetSkipAutoKeywordTips(true)
  self.cardItem:SetClickCallback(function()
    local panelData = {
      cardUid = 0,
      cardTid = skillId,
      ignoreUnknowImage = true
    }
    UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, panelData)
  end)
end

return UICompPvpDraftPlayerInfo
