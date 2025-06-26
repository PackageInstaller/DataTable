--[[ 
-----------------------------------------------------
@filename       : FriendApplyItem
@Description    : 好友申请
@date           : 2020-08-03 10:55:44
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.friend.view.item.FriendApplyItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
end

function setData(self, param)
    super.setData(self, param)
    self.mHeadGroup = self:getChildTrans('mHeadGroup')
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mImgState = self:getChildGO("mImgState"):GetComponent(ty.AutoRefImage)
    self.mTxtUID = self:getChildGO("mTxtUID"):GetComponent(ty.Text)
    self:addOnClick(self:getChildGO('mBtnAdd'), self.onClickAddHandler)
    self:addOnClick(self:getChildGO('mBtnDel'), self.onClickDelHandler)
    self:updateData()
end

function updateData(self)
    local friendVo = self.data
    if friendVo == nil then return end

    if not self.mPlayerHeadGrid then
        self.mPlayerHeadGrid = PlayerHeadGrid:create(self.mHeadGroup, friendVo.playerAvatarId, 1)
    end
    self.mPlayerHeadGrid:setHeadFrame(friendVo.frameId)
    self.mPlayerHeadGrid:setClickEnable(true)
    self.mPlayerHeadGrid:setCallBack(self, self.onClickHeadHandler)
    self.mPlayerHeadGrid:setLvl(friendVo.lvl)
    self.mTxtName.text = friendVo.name
    self.mTxtUID.text = friendVo.showId
    self.mTxtLv.text = _TT(45003, friendVo.lvl)
    local offlineTime = friendVo.offlineTime
    local stateImg = friendVo.onlineState == 1 and UrlManager:getPackPath("friend/friend_30.png") or UrlManager:getPackPath("friend/friend_31.png")
    self.mImgState:SetImg(stateImg, false)
end
function onClickHeadHandler(self)
    if self.data then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = self.data.id })
    end
end
function onClickAddHandler(self)
    if self.data then
        local idList = friend.FriendManager:getApplyIdList()
        if #idList <= 0 then
            gs.Message.Show(_TT(25133))
            return
        end
        local list = {}
        local pt_friend_apply_reply = { friend_id = self.data.id, result = 1 }
        table.insert(list, pt_friend_apply_reply)
        GameDispatcher:dispatchEvent(EventName.FRIEND_APPLY_REPLY, list)
        friend.FriendManager:setIsOperation(true)
    end
end

function onClickDelHandler(self)
    local idList = friend.FriendManager:getApplyIdList()
    if #idList <= 0 then
        gs.Message.Show(_TT(25133))
        return
    end
    local list = {}
    local pt_friend_apply_reply = { friend_id = self.data.id, result = 0 }
    table.insert(list, pt_friend_apply_reply)
    GameDispatcher:dispatchEvent(EventName.FRIEND_APPLY_REPLY, list)
    GameDispatcher:dispatchEvent(EventName.UPDATE_FRIEND_APPLY_RED)
    friend.FriendManager:setIsOperation(true)
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]