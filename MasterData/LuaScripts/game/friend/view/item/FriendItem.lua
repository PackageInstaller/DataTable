--[[ 
-----------------------------------------------------
@filename       : FriendItem
@Description    : 好友列表
@date           : 2020-08-03 10:55:44
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('friend.FriendItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
    self.mIsSelect = false
    self.mGroupBtn = self:getChildGO("mGroup")
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mHeadGroup = self:getChildTrans('mHeadGroup')
    self.mTxtLV = self:getChildGO("mTxtLV"):GetComponent(ty.Text)
    self.mTxtNote = self:getChildGO("mTxtNote"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mTxtState = self:getChildGO("mTxtState"):GetComponent(ty.Text)
end

function setData(self, param)
    super.setData(self, param)
    if friend.FriendManager:getCurFriendId() == self.data.id then
        GameDispatcher:dispatchEvent(EventName.SHOW_OTHER_ROLE_INFO, self.data.id)
        self:updateBtnState(self.data.id)
    end
    self:updateData()
end


function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.OPEN_FRIEND_SHOWID, self.updateBtnState, self)
    -- friend.FriendManager:addEventListener(friend.FriendManager.FRIEND_REMARSK, self.updateMarsk, self)
    friend.FriendManager:addEventListener(friend.FriendManager.FRIEND_CHECK_INFO, self.updateInfo, self)
    friend.FriendManager:addEventListener(friend.FriendManager.PRIVATE_CHAT_ADD, self.updateMessage, self)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.OPEN_FRIEND_SHOWID, self.updateBtnState, self)
    -- friend.FriendManager:removeEventListener(friend.FriendManager.FRIEND_REMARSK, self.updateMarsk, self)
    friend.FriendManager:removeEventListener(friend.FriendManager.FRIEND_CHECK_INFO, self.updateInfo, self)
    friend.FriendManager:removeEventListener(friend.FriendManager.PRIVATE_CHAT_ADD, self.updateMessage, self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mGroupBtn, self.onClickShowFriendCountHandler)
end

function updateData(self)
    if not self.data then
        self:close()
        return
    end
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
    self.mPlayerHeadGrid:setClickEnable(false)

    if friendVo.marks == "" then
        self.mTxtName.text = friendVo.name
    else
        self.mTxtName.text = friendVo.marks
    end

    self.mTxtLV.text = _TT(45003, friendVo.lvl)
    -- local strNeto = self.data.marks ~= "" and "(" .. self.data.marks .. ")" or ""
    -- self.mTxtNote.text = strNeto
    self.mImgSelect:SetActive(friend.FriendManager:getCurFriendId() == self.data.id)
    local offlineTime = friendVo.offlineTime
    local stateTxt = friendVo.onlineState == 1 and HtmlUtil:color(_TT(25126), "0a9b10ff") or HtmlUtil:color(friendVo:getOfflineTime(), "82898cff")
    self.mTxtState.text = stateTxt

    self:updateChatState()
end
--查看好友信息
function onClickShowFriendCountHandler(self)
    if self.data then
        friend.FriendManager:setIsOneClick(false)
        friend.FriendManager:setCurFriendId(self.data.id)
        GameDispatcher:dispatchEvent(EventName.SHOW_OTHER_ROLE_INFO, self.data.id)
        GameDispatcher:dispatchEvent(EventName.OPEN_FRIEND_SHOWID, self.data.id)
    end
end
--更新备注
function updateMarsk(self, vo)
    -- if vo.id == self.data.id then
    --     self.mTxtNote.text = "(" .. vo.marks .. ")"
    -- end
end
--更新数据
function updateInfo(self)
    local friendVo = role.RoleManager:getOtherInfo()
    if friendVo == nil then return end
    if self.data.id == friendVo.id then
        self.data.playerAvatarId = friendVo:getAvatarId()
        self.data.name = friendVo.name
        if self.mPlayerHeadGrid then
            self.mPlayerHeadGrid:poolRecover()
            self.mPlayerHeadGrid = nil
        end
        if not self.mPlayerHeadGrid then
            self.mPlayerHeadGrid = PlayerHeadGrid:create(self.mHeadGroup, friendVo:getAvatarId(), 1)
        end
        self.mPlayerHeadGrid:setLvl(friendVo:getPlayerLvl())
        self.mPlayerHeadGrid:setHeadFrame(friendVo:getAvatarFrameId())
        self.mPlayerHeadGrid:setClickEnable(false)
        --self.mTxtName.text = friendVo.name

        if friendVo.remarks == "" then
            self.mTxtName.text = friendVo.name
        else
            self.mTxtName.text = friendVo.remarks
        end
    end
end

--刷新按钮状态
function updateBtnState(self, id)
    self:updateData()
end

function updateMessage(self, id)
    if(self.data.id == id)then
        self:updateChatState()
    end
end

-- 更新聊天状态
function updateChatState(self)
    local friendVo = friend.FriendManager:getFriendVo(self.data.id)
    if friendVo and friendVo.newMessge > 0 then
        RedPointManager:add(self.UITrans, nil, 136, 45)
    else
        RedPointManager:remove(self.UITrans)
    end
end

function onDelete(self)
    super.onDelete(self)
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]