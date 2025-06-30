--[[ 
-----------------------------------------------------
@filename       : WeekTaskTabView
@Description    : 周常任务2.0
@date           : 2020-11-30 10:40:28
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("game.task.weekTask.view.WeekTaskTabView", Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("taskHall/weekTask/WeekTaskTabView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构
function dtor(self)
end

function initData(self)
    self.mType = task.TYPE_WEEK_TASK
    --记录滑动框初始宽度
    self.mScrollerHeight = 0
end

-- 初始化
function configUI(self)
    self.mAllBtn = self:getChildGO("mBtnAll")
    self.mAutoReceive = self:getChildGO("mAutoReceive")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtAutoReceive = self:getChildGO("mTxtAutoReceive"):GetComponent(ty.Text)
    self.mScrollerRect = self:getChildGO("mLyScroller"):GetComponent(ty.RectTransform)

    self.mScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(task.WeekTaskItem)
end

--激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_TASK_DATA, self.__onUpdateViewHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_TASK_LIST, self.__onUpdateViewHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_TASK_AWARD, self.__onGetAwardHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ALL_TASK_AWARD, self.__onUpdateViewHandler, self)
    self:updateTaskList(true)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TASK_DATA, self.__onUpdateViewHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TASK_LIST, self.__onUpdateViewHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TASK_AWARD, self.__onGetAwardHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ALL_TASK_AWARD, self.__onUpdateViewHandler, self)
    local height = self.mAutoReceive.activeSelf == true and (self.mScrollerHeight - self.mAutoReceive:GetComponent(ty.RectTransform).rect.height) or self.mScrollerHeight
    gs.TransQuick:SizeDelta02(self.mScrollerRect.gameObject.transform, height)
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    --string.sub 截取字符串汉字占用3个字符 数字、英文及符号占用1个字符
    self.mTxtTips.text = _TT(267) ----"每周一05:00重置"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mAllBtn, self.onClickAll)
end

function onClickAll(self)
    GameDispatcher:dispatchEvent(EventName.REQ_REC_ALL_TASK_AWARD, { type = task.TYPE_WEEK_TASK })
end

function __onUpdateViewHandler(self, args)
    if (not args or self.mType == args.type) then
        self:updateTaskList()
    end
end

function __onGetAwardHandler(self, args)
    if (self.mType == args.type) then
        self:updateTaskList()
    end
end

function updateTaskList(self, isInit)
    --将对虚拟列表拉伸操作放于虚拟列表之前 避免虚拟列表计算时重新计算内容填充内容
    if self.mScrollerHeight == 0 then
        self.mScrollerHeight = self.mScrollerRect.sizeDelta.y
    end
    self.mAutoReceive:SetActive(task.DailyTaskManager:getTaskCanRecList(self.mType) > 1)
    local height = self.mAutoReceive.activeSelf == true and (self.mScrollerHeight - self.mAutoReceive:GetComponent(ty.RectTransform).rect.height) or self.mScrollerHeight
    gs.TransQuick:SizeDelta02(self.mScrollerRect.gameObject.transform, height)
    self.mTxtAutoReceive.text = _TT(962, task.DailyTaskManager:getTaskCanRecList(self.mType))
    local list = task.DailyTaskManager:getTaskList(self.mType)
    for i = 1, #list do
        list[i].tweenId = 2 + (i - 1) * 4
    end
    if isInit or self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end

end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]