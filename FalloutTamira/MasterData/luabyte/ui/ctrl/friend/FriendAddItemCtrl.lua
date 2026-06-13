local FriendAddItemCtrl = BaseClass("FriendAddItemCtrl")
local M = FriendAddItemCtrl


function M:UpdateItem(data)
    if data == nil then
        return
    end
    local iconPath = FriendHelper.GetPlayerIcon(data.PlayerIconId)
    --local heroId = FriendHelper.GetShowGirlId(data.Avatar)
    self._friendId = data.FriendId
    --self._view.headIcon:SetAvatarIcon(heroId, RoleType.ERT_Hero)
    self._view.headIcon:SetPic(iconPath)
    self._view.nameText:SetText(data.Nickname)
    self._view.levelText:SetText(tostring(data.Level))
    self._view.olineState:SetActive(data.Online)
    self._view.pastState:SetActive(not data.Online)
    self._view.addBtn:SetActive(true)
    self._view.applyBtns:SetActive(false)
end

function M:__init(view)
    self._view = view
    self._friendId = 0
    self._view.addBtn:onClick(Bind(self, self._OnClickItem))
end

function M:_OnClickItem()
    FriendDataMgr:GetInstance():SendRequestAddFriendShip(self._friendId, Bind(self, self.OnCallBack))
end

function M:OnCallBack()
    self._view.addBtn:SetActive(false)
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return FriendAddItemCtrl
