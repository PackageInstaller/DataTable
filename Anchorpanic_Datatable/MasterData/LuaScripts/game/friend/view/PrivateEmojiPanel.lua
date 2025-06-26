--[[ 
-----------------------------------------------------
@filename       : PrivateChatTalkItem
@Description    : 私聊表情面板
@date           : 2020-08-07 11:00:18
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("game.friend.view.PrivateEmojiPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("friend/PrivateEmojiPanel.prefab")


destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setInnerOffset(0, 0, 0, 0)
    -- self:setTxtTitle("")
end

-- 初始化数据
function initData(self)
    self.mDefaultTabType = nil
    self.mCusSelectType = nil
    self.itemsData = {}
end

-- function getAdaptaTrans(self)
--     return self:getChildTrans("AdaptaGroup")
-- end

function configUI(self)
    self.mImgToucher = self:getChildGO("ImgToucher")
    self.mGroupTrans = self:getChildTrans("Group")
    self.mContent = self:getChildTrans("Content")
    self.mStateItem = self:getChildGO("StateButton")

    self.scrollerGo = self:getChildGO("LyScroller")
    self.mScroller = self.scrollerGo:GetComponent(ty.LyScroller)
    self.mScroller:SetMask()
    self.mScroller:SetItemRender(chat.EmojiItem)

    -- self.mHandle = self:getChildGO("Handle"):GetComponent(ty.Image)

    self:configTabBar()
end

function configTabBar(self)
    self.itemsData = {}
    local dic = chat.ChatManager:getEmojiConfigDic()
    for type, subList in pairs(dic) do
        --屏蔽动图表情包
        if type > 1 then
            break
        end
        for subType, _ in pairs(subList) do
            if (self.mDefaultTabType == nil) then
                self.mDefaultTabType = subType
            end
            if (self.mCusSelectType == nil) then
                self.mCusSelectType = self.mDefaultTabType
            end
            local item = SimpleInsItem:create(self.mStateItem, self.mContent, "EmojiType")
            local function onClickTypeHandler()
                if self.mCusSelectType ~= subType then
                    self.mCusSelectType = subType
                    self:updateView()
                end
            end
            item:getChildGO("m_imgTip"):GetComponent(ty.AutoRefImage):SetImg(chat.getTabIconUrl(subType), true)
            item:addUIEvent(nil, onClickTypeHandler)
            table.insert(self.itemsData, { index = subType, item = item })
        end
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addOnClick(self.mImgToucher, self.onClickCloseHandler, self:getCloseSoundPath())

    -- local function _onValueChange()
    --     LoopManager:removeTimerByIndex(self.mLoopSn)
    --     -- self.mHandle:DOFade(1, 0.3)
    --     self.mLoopSn = LoopManager:addTimer(1, 1, self, function() self.mHandle:DOFade(0, 0.5) end)
    -- end
    -- self.scrollerGo:GetComponent(ty.ScrollRect).onValueChanged:AddListener(_onValueChange)
end

function active(self, args)
    self:updateView(true)
    if args then
        self:setOffest(args.posX, args.posY)
    end
end

function deActive(self)
    -- self.scrollerGo:GetComponent(ty.ScrollRect).onValueChanged:RemoveAllListeners()
    if (self.mLoopSn) then
        LoopManager:removeTimerByIndex(self.mLoopSn)
    end
end

function onClickCloseHandler(self)
    self:close()
end

-- 点击菜单
-- function onClickTypeHandler(self, cusTabType)
--     self:updateView(true)
-- end

function updateView(self, cusIsInit)
    for i = 1, #self.itemsData do
        local select = self.itemsData[i].item:getChildGO("m_imgSelect")
        select:SetActive(self.itemsData[i].index == self.mCusSelectType)
    end
    local list = chat.ChatManager:getEmojiConfigList(chat.ContentType.STATIC_EMOJI, self.mCusSelectType)
    if (cusIsInit) then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end
end

function setOffest(self, posX, posY)
    gs.TransQuick:LPosOffsetXY(self.mGroupTrans, posX, posY)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]