--[[ 
-----------------------------------------------------
@filename       : FriendQueryItem
@Description    : 好友查询列表
@date           : 2020-08-18 11:50:35
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.friend.view.item.FriendQueryItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
end

function setData(self, param)
    super.setData(self, param)
    self.mTxtLv = self:getChildGO('mTxtLv'):GetComponent(ty.Text)
    self.mHeadGroup = self:getChildTrans('mHeadGroup')
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mImgState = self:getChildGO("mImgState"):GetComponent(ty.AutoRefImage)
    self.mTxtUID = self:getChildGO("mTxtUID"):GetComponent(ty.Text)
    self:addOnClick(self:getChildGO('mBtnAdd'), self.onClickDelHandler)
    self:updateData()
end

function updateData(self)
    local friendVo = self.data
    if friendVo == nil then return end
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
    if not self.mPlayerHeadGrid then
        self.mPlayerHeadGrid = PlayerHeadGrid:create(self.mHeadGroup, friendVo.playerAvatarId, 1)
    end
    self.mTxtLv.text = _TT(45003, friendVo.lvl)
    self.mPlayerHeadGrid:setLvl(friendVo.lvl)
    self.mPlayerHeadGrid:setHeadFrame(friendVo.frameId)
    self.mPlayerHeadGrid:setClickEnable(true)
    self.mPlayerHeadGrid:setCallBack(self, self.onClickHeadHandler)
    self.mTxtUID.text = friendVo.showId
    local offlineTime = friendVo.offlineTime
    local stateUrl = friendVo.onlineState == 1 and UrlManager:getPackPath("friend/friend_30.png") or UrlManager:getPackPath("friend/friend_31.png")
    self.mImgState:SetImg(stateUrl, false)
    self.mTxtName.text = friendVo.name
end

function onClickHeadHandler(self)
    if self.data then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = self.data.id })
    end
end

function onClickDelHandler(self)
    if self.data then
        GameDispatcher:dispatchEvent(EventName.FRIEND_ADD_REQ, self.data.id)
    end
end


function deActive(self)
    super.deActive(self)
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]