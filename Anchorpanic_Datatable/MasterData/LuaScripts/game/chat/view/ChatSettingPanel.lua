-- @FileName:   ChatSettingPanel.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-06-11 11:24:36
-- @Copyright:   (LY) 2024 锚点降临

module('chat.ChatSettingPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('chat/ChatSettingPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 519)
    self:setTxtTitle(_TT(523))
end

-- 初始化数据
function initData(self)

end

-- 初始化
function configUI(self)
    self.mTxt_1 = self:getChildGO("mTxt_1"):GetComponent(ty.Text)
    self.LyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.LyScroller:SetItemRender(chat.ChatSettingBubbleItem)

    self.mSelectInfo = self:getChildGO("mSelectInfo")
    self.mImgSelectIcon = self:getChildGO("mImgSelectIcon"):GetComponent(ty.AutoRefImage)
    self.mTextSelectName = self:getChildGO("mTextSelectName"):GetComponent(ty.Text)

    self.mBtn_Sure = self:getChildGO("mBtn_Sure")
end

-- 激活
function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.SELECT_CHATBUBBLE, self.onSelectItem, self)
    GameDispatcher:addEventListener(EventName.RES_CHATBUBBLE_LIST, self.refreshView, self)

    GameDispatcher:dispatchEvent(EventName.REQ_CHATBUBBLE_LIST)

    self.mSelectInfo:SetActive(false)

    local roleVo = role.RoleManager:getRoleVo()
    self.mUseTid = roleVo:getChatBubbleTid()
    self.mSelectTid = self.mUseTid

    self:refreshView()
end

-- 非激活
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.SELECT_CHATBUBBLE, self.onSelectItem, self)
    GameDispatcher:removeEventListener(EventName.RES_CHATBUBBLE_LIST, self.refreshView, self)

end

function initViewText(self)
    self.mTxt_1.text = _TT(524)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtn_Sure, self.onClickSure)
end

function refreshView(self)
    local bubbleList = decorate.DecorateManager:getChatBubbleDic()
    local list = {}
    for chatBubble_tid, bubbleInfo in pairs(bubbleList) do
        local useing = self.mUseTid == chatBubble_tid
        local bubbleConfig = decorate.DecorateManager:getChatBubbleConfig(chatBubble_tid)
        table.insert(list, {config = bubbleConfig, useing = useing})
    end

    table.sort(list, function (a, b)
        return a.config.sort < b.config.sort
    end)

    self.LyScroller.DataProvider = list

    for i = 1, #list do
        if list[i].config.tid == self.mSelectTid then
            GameDispatcher:dispatchEvent(EventName.SELECT_CHATBUBBLE, list[i].config)
            break
        end
    end
end

function onClickSure(self)
    if self.mSelectTid ~= role.RoleManager:getRoleVo():getChatBubbleTid() then
        GameDispatcher:dispatchEvent(EventName.REQ_SET_DECORATE, {moduleType = decorate.ModuleType.CHATBUBLLE, id = self.mSelectTid})
    end
    self:close()
end

function onSelectItem(self, configVo)
    self.mSelectInfo:SetActive(true)

    self.mSelectConfigVo = configVo
    self.mSelectTid = self.mSelectConfigVo.tid

    self.mImgSelectIcon:SetImg(self.mSelectConfigVo:getIcon(), true)
    self.mTextSelectName.text = self.mSelectConfigVo:getName()
end

return _M
