-- @FileName:   ChatSettingBubbleItem.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-06-11 16:31:40
-- @Copyright:   (LY) 2024 锚点降临

module("chat.ChatSettingBubbleItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mSelect = self:getChildGO("mSelect")
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.RectTransform)
    self.mTextTips = self:getChildGO("mTextTips"):GetComponent(ty.Text)
    self.mTextUseing = self:getChildGO("mTextUseing"):GetComponent(ty.Text)

    self.mUseing = self:getChildGO("mUseing")

    self.redPoint = self:getChildGO("redPoint")
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.UIObject, function()
        GameDispatcher:dispatchEvent(EventName.SELECT_CHATBUBBLE, self.data.config)
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {type = ReadConst.CHAT_BUBBLE, id = self.data.config.tid})
    end)
end

function active(self)
    super.active(self)

    GameDispatcher:addEventListener(EventName.SELECT_CHATBUBBLE, self.onSelect, self)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.refreshRedState, self)

    self.mTextTips.text = self.data.config:getColorContent(_TT(525))
    self.mTextUseing.text = _TT(25194)

    self.mSelect:SetActive(false)
    self:refreshRedState()

    self.mUseing:SetActive(self.data.useing)
end

-- override 虚拟列表被非激活时自动调用
function deActive(self)
    super.deActive(self)

    if (self.mChatBubbleTrans and not gs.GoUtil.IsTransNull(self.mChatBubbleTrans)) then
        gs.GOPoolMgr:Recover(self.mChatBubbleTrans.gameObject, self.mBubblePath)
        self.mChatBubbleTrans = nil
    end

    GameDispatcher:removeEventListener(EventName.SELECT_CHATBUBBLE, self.onSelect, self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.refreshRedState, self)
end

function setData(self, data)
    super.setData(self, data)

    self.mBubblePath = self.data.config:getPrefabPath()
    local chatBubbleGo = gs.GOPoolMgr:Get(self.mBubblePath)
    self.mChatBubbleTrans = chatBubbleGo.transform
    gs.TransQuick:SetParentOrg(self.mChatBubbleTrans, self.mImgIcon)
    gs.TransQuick:UIPos(self.mChatBubbleTrans:GetComponent(ty.RectTransform), 0, 0)
end

function onSelect(self, configVo)
    self.mSelect:SetActive(configVo.tid == self.data.config.tid)
end

function refreshRedState(self)
    self.redPoint:SetActive(read.ReadManager:isModuleRead(ReadConst.CHAT_BUBBLE, self.data.config.tid))
end

return _M
