local SocialPlayerPvpDataviewComp, Super = System.NewComponent("SocialPlayerPvpDataviewComp")

function SocialPlayerPvpDataviewComp:ctor(res, model, viewNode)
  Super.ctor(self)
  self.ui = UIBaseResource(res)
  self.model = model
  self.viewNodeName = viewNode
  self.pvpRecordItemComps = {}
end

function SocialPlayerPvpDataviewComp:OnBind(binder)
  self.binder = binder
  self.binder:SetText(self.ui.Text_C_NoTask, LT.Text("PvPReplayTabNullDesc"))
  self:CreateTableView()
  self._targetUid = self.model:GetUid()
  self:OnGetPvpDetailsList()
  self._pvpDetailsPage = 1
  PvPSeasonDataUtils.GetGameDetailsListByUid(self._targetUid, 1, function()
    self:OnGetPvpDetailsList()
  end)
end

function SocialPlayerPvpDataviewComp:OnGetPvpDetailsList()
  local pvpDetailsList = PvPSeasonDataUtils.GetPvpDetailsList(self._targetUid)
  self.binder:SetActive(self.ui.Group_Null_Black, 0 == #pvpDetailsList)
  self.tableView:ReloadData()
end

function SocialPlayerPvpDataviewComp:LoadMorePvpDetails()
  if self._pvpDetailsLoading or PvPSeasonDataUtils.GetPvpDetailsNoMore(self._targetUid) then
    return
  end
  self._pvpDetailsLoading = true
  local nextPage = (self._pvpDetailsPage or 1) + 1
  PvPSeasonDataUtils.GetGameDetailsListByUid(self._targetUid, nextPage, function()
    self._pvpDetailsLoading = false
    self._pvpDetailsPage = nextPage
    self:OnGetPvpDetailsList()
  end)
end

function SocialPlayerPvpDataviewComp:CreateTableView()
  local baseGameObj = self.ui.UI_Social_Item_PvpRecord
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.tableView = self:CreateTableview(self.ui[self.viewNodeName], function()
    local pvpDetailsList = PvPSeasonDataUtils.GetPvpDetailsList(self._targetUid)
    return #pvpDetailsList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local pvpDetailsList = PvPSeasonDataUtils.GetPvpDetailsList(self._targetUid)
    local recordData = pvpDetailsList[index]
    itemComps[gameObj] = self.binder:BindComponent(SocialPvpRecordItem(gameObj, recordData, self.model.playerInfoData.facade))
    if index >= #pvpDetailsList - 2 and not PvPSeasonDataUtils.GetPvpDetailsNoMore(self._targetUid) then
      self:LoadMorePvpDetails()
    end
    return cell
  end, function(_, _)
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function SocialPlayerPvpDataviewComp:Show()
  if not self.ui or not self.ui.uiNode then
    return
  end
  self.ui.uiNode:SetActive(true)
end

function SocialPlayerPvpDataviewComp:Hide()
  if not self.ui or not self.ui.uiNode then
    return
  end
  self.ui.uiNode:SetActive(false)
end

function SocialPlayerPvpDataviewComp:OnUnbind()
end

return SocialPlayerPvpDataviewComp
