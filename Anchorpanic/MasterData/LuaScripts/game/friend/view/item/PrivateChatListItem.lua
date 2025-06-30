--[[ 
-----------------------------------------------------
@filename       : PrivateChatListItem
@Description    : 私聊玩家列表
@date           : 2020-08-03 10:55:44
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.friend.view.item.PrivateChatListItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
end

function setData(self, param)
    super.setData(self, param)

    self.mBtnClick = self:getChildGO('mBtnClick')
    self.mHeadGroup = self:getChildTrans('mHeadGroup')
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mTxtTalk = self:getChildGO('mTxtTalk'):GetComponent(ty.Text)
    self.mImgCount = self:getChildGO('mImgCount')
    -- self.mImgRed = self:getChildGO('mImgRed')
    self.mTxtCount = self:getChildGO('mTxtCount'):GetComponent(ty.Text)
    self.mImgSelect = self:getChildGO('mImgSelect')

    self:updateData()
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClick, self.onClickSelectHandler)
end

function updateData(self)
    local friendVo = self.data
    if friendVo == nil then return end

    if not self.mPlayerHeadGrid then
        self.mPlayerHeadGrid = PlayerHeadGrid:create(self.mHeadGroup, friendVo.playerAvatarId, 0.5)
    end
    self.mPlayerHeadGrid:setHeadFrame(friendVo.frameId)
    self.mPlayerHeadGrid:setClickEnable(false)
    self.mPlayerHeadGrid:setLvl(friendVo.lvl)
    self.mTxtName.text = friendVo:getMarks()

    if friendVo.lastTalkType == chat.ContentType.JUST_TEXT then
        local talk = string.omit(friendVo.lastTalk, 7)
        self.mTxtTalk.text = FilterWordUtil:filter(talk)
    elseif friendVo.lastTalk ~= "" then
        self.mTxtTalk.text = _TT(25127)--"[表情]"
    else
        -- 如果之前本地缓存有聊天消息，删除后又加回来，看看本地有无缓存消息
        local list = friend.FriendManager:getFriendChatData(friendVo.id)
        if(list)then
            local lastChatData = list[#list]
            if(lastChatData)then
                if(lastChatData.contentType == chat.ContentType.JUST_TEXT)then
                    self.mTxtTalk.text = lastChatData.content
                elseif(lastChatData.contentType == chat.ContentType.STATIC_EMOJI or lastChatData.contentType == chat.ContentType.DYNAMIC_EMOJI)then
                    self.mTxtTalk.text = _TT(25127)--"[表情]"
                elseif(lastChatData.contentType == chat.ContentType.VOICE_TEXT)then
                    self.mTxtTalk.text = "[语音]"
                end
            else
                self.mTxtTalk.text = ""
            end
        else
            self.mTxtTalk.text = ""
        end
    end

    if friendVo.newMessge > 0 then
        self.mImgCount:SetActive(true)
        -- self.mImgRed:SetActive(true)
        self.mTxtCount.text = friendVo.newMessge
    else
        -- self.mImgRed:SetActive(false)
        self.mImgCount:SetActive(false)
    end

    if self.data.isSelect then
        self.mImgSelect:SetActive(true)
        -- self.mTxtName.color = gs.ColorUtil.GetColor("ffffffff")
        -- self.mTxtTalk.color = gs.ColorUtil.GetColor("ffffffff")
    else
        self.mImgSelect:SetActive(false)
        -- self.mTxtName.color = gs.ColorUtil.GetColor("595959ff")
        -- self.mTxtTalk.color = gs.ColorUtil.GetColor("595959ff")
    end
end

function onClickSelectHandler(self)
    if not self.data then
        return
    end
    GameDispatcher:dispatchEvent(EventName.SHOW_PRIVATE_CHAT_INFO, self.data.id)
end

function setSelect(self, cusSelect)
    self.mImgSelect:SetActive(cusSelect)
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