local FriendMatchListPanel, Super = System.NewClass("FriendMatchListPanel", UIBasePanel)
FriendMatchListPanel.uiResCls = UI_Social_Popup_FriendlyInviteResource

function FriendMatchListPanel:ctor(playerList)
  Super.ctor(self)
end

function FriendMatchListPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  binder:BindEvent(EventMgr.Instance.FriendMatchNew, System.fn(self, self.OnFriendMatchNew))
  binder:BindEvent(EventMgr.Instance.FriendMatchFormation, System.fn(self, self.OnFriendMatchFormation))
  self:CreataInviteTable()
  self.inviteList = table.clone(FriendMatchMgr.Instance:GetInviteList())
  self.iniviteTable:ReloadData()
end

function FriendMatchListPanel:OnUnbind()
  Super.OnUnbind(self)
  FriendMatchMgr.Instance:OpenInvitePopBubble()
end

function FriendMatchListPanel:OnFriendMatchNew(inviteData)
  for i, info in ipairs(self.inviteList) do
    if info.friendRelateUid == inviteData.friendRelateUid then
      table.remove(self.inviteList, i)
      break
    end
  end
  table.insert(self.inviteList, 1, inviteData)
  self.iniviteTable:ReloadData()
end

function FriendMatchListPanel:OnFriendMatchFormation()
  self:Close()
end

function FriendMatchListPanel:CreataInviteTable()
  local baseGameObj = self.ui.UI_Social_Item_FriendlyInvite
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.iniviteTable = self:CreateTableview(self.ui.Scroll_InviteList, function()
    return #self.inviteList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local friendInfo = Vue.ref(self.inviteList[idx])
    itemComps[gameObj] = self.binder:BindComponent(FriendMatchItem(gameObj, friendInfo))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

return FriendMatchListPanel
