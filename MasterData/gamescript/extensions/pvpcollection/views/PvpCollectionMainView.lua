local PVPCollectionType = CommonDefine.PVPCollectionType
local PVPCollectionDetailTab = CommonDefine.PVPCollectionDetailTab
local Tab2SubPageInfoDict = {
  [PVPCollectionDetailTab.Detail] = {
    res = UI_Pvp_Panel_Collection_DetailResource,
    cls = UICompPvpCollectionDetailPage
  },
  [PVPCollectionDetailTab.Comment] = {
    res = UI_Pvp_Panel_Collection_CommentResource,
    cls = UICompPvpCollectionCommentPage
  },
  [PVPCollectionDetailTab.Rank] = {
    res = UI_Pvp_Panel_Collection_RankResource,
    cls = UICompPvpCollectionRankPage
  }
}
local PvpCollectionMainView, Super = NewClass("PvpCollectionMainView", BaseView)
PvpCollectionMainView.uiResCls = UI_Pvp_Panel_Collection_MainResource

function PvpCollectionMainView:ctor(viewData)
  Super.ctor(self)
  self:_InitViewData(viewData)
end

function PvpCollectionMainView:OnBuildView()
  self:_CreateTableView()
end

function PvpCollectionMainView:OnEnterView()
  self:_RefreshView()
end

function PvpCollectionMainView:RegisterEvents()
  self:AddViewComponent(self.ui.UI_Common_Btn_Back2, UICompBtnCloseItem, System.fn(self, self.Close))
  self:AddZ1ToggleValueChangedListener(self.ui.Grope_Container_1, System.fn(self, self._OnToggleDetailTab))
  self:AddZ1ToggleValueChangedListener(self.ui.Grope_Container_2, System.fn(self, self._OnToggleRankTab))
  self:AddZ1ToggleValueChangedListener(self.ui.Grope_Container_3, System.fn(self, self._OnToggleCommentTab))
  self:AddButtonClickListener(self.ui.TemporaryUnLock, System.fn(self, self._OnClickTemporaryUnLock))
  self:BindEvent(EventMgr.Instance.PvpCollectionSelect, System.fn(self, self._OnPvpCollectionSelect))
end

function PvpCollectionMainView:_OnPvpCollectionSelect(targetCollectionTid)
  self:_RefreshCollectionList()
  self:_RefreshSelectCollection()
end

function PvpCollectionMainView:_OnClickTemporaryUnLock()
  BattlePassDataUtils.OpenBuyCore()
end

function PvpCollectionMainView:_OnToggleDetailTab(isOn)
  if isOn then
    self:_SetSelectTab(PVPCollectionDetailTab.Detail)
  end
end

function PvpCollectionMainView:_OnToggleRankTab(isOn)
  if isOn then
    self:_SetSelectTab(PVPCollectionDetailTab.Rank)
  end
end

function PvpCollectionMainView:_OnToggleCommentTab(isOn)
  if isOn then
    self:_SetSelectTab(PVPCollectionDetailTab.Comment)
  end
end

function PvpCollectionMainView:_OnClickCollectionCell(targetCollectTid)
  self:_SetSelectCollectionTid(targetCollectTid)
end

function PvpCollectionMainView:_InitViewData(viewData)
  self._selectTab = viewData.targetTab or PVPCollectionDetailTab.Detail
  self._showCollectionTidList = viewData.showList or {}
  self._pageCompDict = {}
end

function PvpCollectionMainView:_SetSelectTab(tab)
  self._selectTab = tab
  self:_RefreshSubPage()
  EventMgr.Instance.PvpCollectionPageChanged:Dispatch(tab)
end

function PvpCollectionMainView:_SetSelectCollectionTid(targetCollectTid)
  local selectCollectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  if selectCollectionTid == targetCollectTid then
    return
  end
  PvpCollectionModel.Instance:SetSelectCollectionTid(targetCollectTid)
end

function PvpCollectionMainView:_RefreshView()
  self:_RefreshSubPage()
  self:_RefreshTabRedPoint()
  self:_RefreshCollectionList()
  self:_RefreshSelectCollection()
  self:_RefreshBpState()
  self:_TableViewDefaultJump()
end

function PvpCollectionMainView:_RefreshSelectCollection()
  local selectCollectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  local collectionType = PvpCollectCfgUtils.GetCollectionType(selectCollectionTid)
  local isAwaker = collectionType == PVPCollectionType.Awaker
  local isWeapon = collectionType == PVPCollectionType.Weapon
  local isKeeperSkill = collectionType == PVPCollectionType.KeeperSkill
  self:SetActive(self.ui.Text_C_Awaker_Name, isAwaker)
  self:SetActive(self.ui.Image_Awaker, isAwaker)
  self:SetActive(self.ui.Image_Weapon, isWeapon)
  self:SetActive(self.ui.Text_C_Weapon_Name, isWeapon)
  self:SetActive(self.ui.Key_Order, isKeeperSkill)
  self:SetActive(self.ui.Text_C_KeeperSkill_Name, isKeeperSkill)
  if isAwaker then
    self:_RefreshAwakerCollection(selectCollectionTid)
  elseif isWeapon then
    self:_RefreshWeaponCollection(selectCollectionTid)
  elseif isKeeperSkill then
    self:_RefreshKeeperSkillCollection(selectCollectionTid)
  end
end

function PvpCollectionMainView:_RefreshAwakerCollection(selectCollectionTid)
  local positionTid = PvpCollectCfgUtils.GetCollectAwakerPvpPosition(selectCollectionTid)
  local icon = PVPPositionCfgUtils.GetCfgField("CollectDetailsPositionIcon", positionTid)
  local positionName = LT.Text(PVPPositionCfgUtils.GetCfgField("Name", positionTid))
  self:SetImage(self.ui.Image_Awaker_Career_Icon, icon)
  self:SetText(self.ui.Text_C_Awaker_Name, positionName)
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(selectCollectionTid)
  local resNum = AwakerDataUtils.GetAwakerResNum(awakerTid)
  self:AddViewComponentOnce(self.ui.Image_Awaker, UICompAwakerPortrait, {
    awakerTid = awakerTid,
    portraitNo = resNum,
    portraitAlign = CommonDefine.PortraitAlign.HorizontalCenter
  })
end

function PvpCollectionMainView:_RefreshWeaponCollection(selectCollectionTid)
  self:SetImage(self.ui.Image_Weapon_Large, PVPCollectionDataUtils.GetWeaponCollectionPortrait(selectCollectionTid))
end

function PvpCollectionMainView:_RefreshKeeperSkillCollection(selectCollectionTid)
  self:SetImage(self.ui.Image_Key, PVPCollectionDataUtils.GetKeeperSkillDetailsImage(selectCollectionTid))
end

function PvpCollectionMainView:_RefreshCollectionList()
  self._showCollectionListView:ReloadData()
end

function PvpCollectionMainView:_RefreshSubPage()
  for _, pageComp in pairs(self._pageCompDict) do
    self:SetActive(pageComp.ui.uiNode, false)
  end
  local targetPageComp = self._pageCompDict[self._selectTab]
  if not targetPageComp then
    local pageInfo = Tab2SubPageInfoDict[self._selectTab]
    targetPageComp = self:_CreateSubPageComp(pageInfo.res, pageInfo.cls)
    self._pageCompDict[self._selectTab] = targetPageComp
  else
    self:SetActive(targetPageComp.ui.uiNode, true)
  end
end

function PvpCollectionMainView:_RefreshBpState()
  self:SetActive(self.ui.TemporaryUnLock, not PVPCollectionDataUtils.IsOwnedAll())
  local showTxt = BattlePassDataUtils.IsCore() and LT.Text("PVPBPUnLockTxt") or LT.Text("PVPBPLockTxt")
  self:SetText(self.ui.Txt_TemporaryUnLock, showTxt)
end

function PvpCollectionMainView:_CreateSubPageComp(res, cls)
  local oriPrefab = self:LoadAsset(res.assetPath)
  local go = GameObject.Instantiate(oriPrefab, self.ui.SubPageCon.transform)
  local comp = self:AddViewComponentOnce(go, cls)
  return comp
end

function PvpCollectionMainView:_RefreshTabRedPoint()
  self:SetActive(self.ui.Com_RedDot_1, false)
  self:SetActive(self.ui.Com_RedDot_2, false)
  self:SetActive(self.ui.Com_RedDot_3, false)
end

function PvpCollectionMainView:_CreateTableView()
  local sizeDelta = self.ui.UI_Pvp_Item_List_2.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._showCollectionListView = self:CreateTableview(self.ui.ScrollView_Awaker_Head_List, function()
    return #self._showCollectionTidList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Pvp_Item_List_2)
    self:_FillCollectionCell(cell, index)
    return cell
  end, function()
    return w, h
  end)
end

function PvpCollectionMainView:_FillCollectionCell(cell, index)
  local collectionTid = self._showCollectionTidList[index]
  local viewData = {
    collectTid = collectionTid,
    clickCb = System.fn(self, self._OnClickCollectionCell)
  }
  self:AddViewComponentOnce(cell.gameObject, UICompPvpCollectionIcon, viewData)
end

function PvpCollectionMainView:_TableViewDefaultJump()
  local selectCollectionTid = PvpCollectionModel.Instance:GetSelectCollectionTid()
  local targetIdx = 1
  for index, collectionTid in ipairs(self._showCollectionTidList) do
    if collectionTid == selectCollectionTid then
      targetIdx = index
      break
    end
  end
  if self._showCollectionListView.isReady then
    local offset = self._showCollectionListView:GetOffsetByIndex(targetIdx - 1)
    self._showCollectionListView:SetOffset(offset, false)
  else
    function self._showCollectionListView.reloadFinishCallback()
      local offset = self._showCollectionListView:GetOffsetByIndex(targetIdx - 1)
      
      self._showCollectionListView:SetOffset(offset, false)
      self._showCollectionListView.reloadFinishCallback = nil
    end
  end
end

return PvpCollectionMainView
