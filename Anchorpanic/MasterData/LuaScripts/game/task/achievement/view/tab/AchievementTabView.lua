module("task.AchievementTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("achievement/AchievementTab.prefab")
--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
end

-- 关闭所有UI
function onCloseAllCall(self)
    self:playerClose()
    super.onCloseAllCall(self)
end

-- 玩家点击关闭
function onClickClose(self)
    self:playerClose()
    super.onClickClose(self)
end

function playerClose(self)
    self:initData()
end

function configUI(self)
    self.mBtnGetAll = self:getChildGO("mBtnGetAll")
    self.mGroupCanGet = self:getChildGO("mGroupCanGet")
    self.mAutoReceive = self:getChildGO("mAutoReceive")
    self.mTxtTopCanGet = self:getChildGO("mTxtTopCanGet"):GetComponent(ty.Text)
    self.mTextCanGetNum = self:getChildGO("mTextCanGetNum"):GetComponent(ty.Text)
    self.mTxtAutoReceive = self:getChildGO("mTxtAutoReceive"):GetComponent(ty.Text)
    self.mScrollerRect = self:getChildGO('LyScroller'):GetComponent(ty.RectTransform)

    self.mScroller = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(task.AchievementItem)
end

function setData(self)
end

function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_ACHIEVEMENT_LIST, self.onUpdateViewHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ACHIEVEMENT_AWARD, self.onUpdateRecScoreHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ALL_ACHIEVEMENT_AWARD, self.onUpdateViewHandler, self)
    self.mTabType = args.type
    task.AchievementManager:setShowType(self.mTabType)
    self:updateView(true)
end

function deActive(self)
    super.deActive(self)
    task.AchievementManager:setShowType(nil)
    GameDispatcher:removeEventListener(EventName.UPDATE_ACHIEVEMENT_LIST, self.onUpdateViewHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ACHIEVEMENT_AWARD, self.onUpdateRecScoreHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ALL_ACHIEVEMENT_AWARD, self.onUpdateViewHandler, self)

    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end

    if (self.mScroller) then
        self.mScroller:CleanAllItem()
    end
end

function initViewText(self)
    self:setBtnLabel(self.mBtnGetAll, 1176, "一键领取")
    self.mTxtAutoReceive.text = _TT(962, "多")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGetAll, self.onClickGetAllHandler)
end

function onUpdateRecScoreHandler(self, args)
    self:onUpdateViewHandler()
end

function onUpdateViewHandler(self, args)
    if (args == nil or self.mTabType == args.tabType) then
        self:updateView(false)
    end
end

function updateView(self, isInit)
    --将对虚拟列表拉伸操作放于虚拟列表之前 避免虚拟列表计算时重新计算内容填充内容
    if task.AchievementManager:getScrollHeight() == 0 then
        task.AchievementManager:setScrollHeight(self.mScrollerRect.sizeDelta.y)
    end
    self.mCanGetCount = task.AchievementManager:getCurCanResCountByType(self.mTabType)
    self.mAutoReceive:SetActive(self.mCanGetCount >= 1)
    local height = 0
    if self.mAutoReceive.activeSelf == true then
        height = task.AchievementManager:getScrollHeight() - self.mAutoReceive:GetComponent(ty.RectTransform).rect.height
    else
        height = task.AchievementManager:getScrollHeight()
    end
    gs.TransQuick:SizeDelta02(self.mScrollerRect.gameObject.transform, height)

    self.mTextCanGetNum.text = (self.mCanGetCount > 0) and self.mCanGetCount or 0
    self.mTxtTopCanGet.text = _TT(963, self.mCanGetCount)
    if self.mFrameSn then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
    self.mFrameSn = LoopManager:addFrame(3, 1, self, function()
        local list = task.AchievementManager:getTotalAchievementList(self.mTabType)
        for i = 1, #list do
            list[i].tweenId = 2 + (i - 1) * 4
        end
        if (self.mScroller.Count <= 0 or isInit) then
            self.mScroller.DataProvider = list
        else
            self.mScroller:ReplaceAllDataProvider(list)
        end
    end)

end

function onClickGetAllHandler(self)
    if self.mCanGetCount == 0 then
        gs.Message.Show(_TT(36517))
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_REC_ALL_ACHIEVEMENT_AWARD, { tabType = self.mTabType })
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]