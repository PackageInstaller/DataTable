local friendView = require("UI.View.Friend.BaseFriendItemView")
local PageListCtrl = BaseClass("PageListCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = PageListCtrl
local requestCount = 99

function M:Hide()
    self:HidePanel()
    self._data = {}
end

function M:OpenPanel()
    self:ShowPanel()
    FriendDataMgr:GetInstance():SendRequestFriendData(0, requestCount, Bind(self, self._OnResponseCallBack))
end

function M:UpdateItem(obj,index)
    local view = friendView.New(obj)
    local data = self._data[index]
    local levelStr = string.format("Lv.%d", data.BaseData.Level)
    local playerIconPath = FriendHelper.GetPlayerIcon(data.BaseData.PlayerIconId)
    local heroId = FriendHelper.GetShowGirlId(data.BaseData.Avatar)
    local logoutName = FriendHelper.GetLogoutName(data.BaseData.LogoutTime)

    view.openInfo:onClick(Bind(self, self._OnClickItem, data, index))
    view.levelText:SetText(levelStr)
    --view.headIcon:SetAvatarIcon(heroId, RoleType.ERT_Hero)
    view.headIcon:SetPic(playerIconPath)
    view.olineState:SetActive(data.BaseData.Online)
    view.pastState:SetActive(not data.BaseData.Online)
    view.addBtn:SetActive(false)
    view.applyBtns:SetActive(false)
    view.pastText:SetText(logoutName)
    self:_SetItemHero(view, data.DetailData.HeroList)
    if data.BaseData.Remark == "" or data.BaseData.Remark == nil then
        view.nameText:SetText(data.BaseData.Nickname)
    else
        local remark = string.format(" (%s)", data.BaseData.Remark)
        local nameStr = string.format("%s%s", data.BaseData.Nickname, remark)
        view.nameText:SetText(nameStr)
    end
end

function M:_SetItemHero(view, data)
    for i = 1, 5 do
        local name = string.format("heroItem%d", i)
        local item = view[name];
        local heroId = data[i] == nil and 0 or data[i].HeroId

        if heroId ~= 0 then
            item:SetHeroId(heroId, data[i].Level)
        end

        item.transform:SetActive(heroId ~= 0)
    end
end

function M:_RefreshText()
    local param = ConfigHelper.GetSystemParam(193)
    self._num = #self._data
    self._view.maxText:SetText("/" .. tostring(param))
    self._view.nullTip:SetActive(self._num <= 0)
    self._view.numText:SetText(tostring(FriendDataMgr:GetInstance():GetFriendNumMax()))
end

function M:Init()
    self._data = {}
    self._view.scrollView:Init(Bind(self, self.UpdateItem))
    self._AddFriendData = EventMgr:AddListener(UIMessageNames.FRIEND_REMOVE_UPDATE, Bind(self, self._OnUpdateRemoveFriend))
    self._UpdateFriendData = EventMgr:AddListener(UIMessageNames.FRIEND_DATA_UPDATE, Bind(self, self._OnRefreshFriendDataByIndex))
end

function M:_OnRefreshFriendDataByIndex(index, name)
    self._data[index].BaseData.Remark = name
    self._view.scrollView:UpdateCell(index)
end

function M:_OnUpdateRemoveFriend(id)
    local index = MapUtil.FindKey(self._data, function(v) return v.FriendId == id end)
    table.remove(self._data, index)
    local dataCount = #self._data
    self._view.scrollView:ShowList(#self._data)
    if dataCount>0 then
        self._view.scrollView:SetVerticalNormalizedPosition(1-((index-1)/#self._data))
    end
    self:_RefreshText()
end

function M:_OnResponseCallBack(data)
    if (#data <= 0) then
        self:_RefreshText()
        return
    end

    for _, v in ipairs(data) do
        table.insert(self._data, v)
    end

    self:_RefreshText()
    self._view.scrollView:ShowList(#self._data)
    self._view.scrollView:SetVerticalNormalizedPosition(1)
end

function M:_OnClickItem(data, index)
    -- 打开好友详情
    UIContextMgr:GetInstance():Show("FriendInfo", data, index)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.FRIEND_REMOVE_UPDATE, self._AddFriendData)
    EventMgr:RemoveListener(UIMessageNames.FRIEND_DATA_UPDATE, self._UpdateFriendData)

    self._AddFriendData = nil;
    self._UpdateFriendData = nil;
    self._view.scrollView:DisposeAll()
    M.super.OnDispose(self)
end

return PageListCtrl
