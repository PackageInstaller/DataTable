--[[ 
-----------------------------------------------------
@filename       : FriendRecommendItem
@Description    : 好友推荐列表
@date           : 2020-08-03 10:55:44
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.friend.view.item.FriendRecommendItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
end

function setData(self, param)
    super.setData(self, param)
    self.mHeadGroup = self:getChildTrans('mHeadGroup')
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mTxtMarks = self:getChildGO('mTxtMarks'):GetComponent(ty.Text)
    self.mTxtState = self:getChildGO('mTxtState'):GetComponent(ty.Text)
    self.mImgStateBg = self:getChildGO('mImgStateBg'):GetComponent(ty.AutoRefImage)
    self:addOnClick(self:getChildGO('mBtnAdd'), self.onClickAddHandler)

    self:updateData()
end

function updateData(self)
    local friendVo = self.data
    if friendVo == nil then return end

    if not self.mPlayerHeadGrid then
        self.mPlayerHeadGrid = PlayerHeadGrid:create(self.mHeadGroup, friendVo.playerAvatarId, 0.7)
    end
    self.mPlayerHeadGrid:setLvl(friendVo.lvl)
    self.mPlayerHeadGrid:setHeadFrame(friendVo.frameId)
    self.mPlayerHeadGrid:setClickEnable(true)
    self.mTxtLv.text = friendVo.lvl
    self.mTxtName.text = friendVo.name
    local strNote = friendVo.marks ~= "" and "（" .. friendVo.marks .. "）" or ""
    self.mTxtMarks.text = strNote
    local offlineTime = friendVo.offlineTime
    local stateTxt = friendVo.onlineState == 1 and _TT(25126) or TimeUtil.getTimeDescToDate(offlineTime)
    local stateBgColor = friendVo.onlineState == 1 and "3d70e3ff" or "6f6f6fff"
    self.mTxtState.text = stateTxt
    self.mImgStateBg.color = gs.ColorUtil.GetColor(stateBgColor)
    self.mTxtName.text = friendVo.name
end


function onClickAddHandler(self)
    if self.data then
        GameDispatcher:dispatchEvent(EventName.FRIEND_ADD_REQ, self.data.id)
    end
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