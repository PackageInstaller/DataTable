--[[ 
-----------------------------------------------------
@filename       : FriendItem
@Description    : 好友黑名单列表
@date           : 2020-08-03 10:55:44
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.friend.view.item.FriendBlackItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
end

function setData(self, param)
    super.setData(self, param)
    self.mHeadGroup = self:getChildTrans('mHeadGroup')
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtUID = self:getChildGO("mTxtUID"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mImgState = self:getChildGO("mImgState"):GetComponent(ty.AutoRefImage)

    self:addOnClick(self:getChildGO('mBtnDel'), self.onClickDelHandler)
    self:updateData()
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
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
    self.mPlayerHeadGrid:setHeadFrame(friendVo.frameId)
    self.mPlayerHeadGrid:setLvl(friendVo.lvl)
    self.mPlayerHeadGrid:setClickEnable(true)
    self.mPlayerHeadGrid:setCallBack(self, self.onClickOpenInfoTipsHandler)
    self.mTxtName.text = friendVo.name
    self.mTxtUID.text = friendVo.showId
    self.mTxtLv.text = _TT(45003, friendVo.lvl)
    local strNote = friendVo.marks ~= "" and "（" .. friendVo.marks .. "）" or ""
    local offlineTime = friendVo.offlineTime
    local stateActive = friendVo.onlineState == 1 and true or false
    local stateUrl = friendVo.onlineState == 1 and UrlManager:getPackPath("friend/friend_30.png") or UrlManager:getPackPath("friend/friend_31.png")
    self.mImgState:SetImg(stateUrl)
end

function onClickDelHandler(self)
    if self.data then
        GameDispatcher:dispatchEvent(EventName.FRIEND_BLACK_DEL_REQ, self.data.id)
    end
end
--打开信息面板
function onClickOpenInfoTipsHandler(self)
    if self.data then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = self.data.id })
    end
end



return _M

--[[ 替换语言包自动生成，请勿修改！
]]