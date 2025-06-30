--[[ 
-----------------------------------------------------
@filename       : RogueLikeTaskPanel
@Description    : 肉鸽任务界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
--]]
module("rogueLike.RogueLikeTaskTabView", Class.impl(TabSubView))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/tab/RogueLikeTaskTabView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

taskFilterType = rogueLike.TaskType.Week

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mScoreItems = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTaskInfo = self:getChildGO("mTaskInfo")
    self.mTaskScroller = self:getChildGO("mTaskScroller"):GetComponent(ty.LyScroller)
    self.mTaskScroller:SetItemRender(rogueLike.RogueLikeTaskItem)

    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtTime.gameObject:SetActive(false)

    self.mGetAllBtn = self:getChildGO("mGetAllBtn")
end

-- 激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_ROGUELIKE_TASK_PANEL_TASK, self.updateTask, self)
    --GameDispatcher:addEventListener(EventName.UPDATE_ROGUELIKE_TASK_PANEL_SCORE, self.updateScore, self)
    self:updateTaskView(true)
    --self:updateEndTime()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    GameDispatcher:removeEventListener(EventName.UPDATE_ROGUELIKE_TASK_PANEL_TASK, self.updateTask, self)
    --GameDispatcher:removeEventListener(EventName.UPDATE_ROGUELIKE_TASK_PANEL_SCORE, self.updateScore, self)
    if self.mTaskScroller then
        self.mTaskScroller:CleanAllItem()
    end
end

function updateTask(self)
    self:updateTaskView(false)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mGetAllBtn, self.onClickGetAllClick)
end

function updateTaskView(self, isInit)

    self.taskData = rogueLike.RogueLikeManager:getTaskData()

    self.taskData = self:filterByTaskType()
    for i, _ in ipairs(self.taskData) do
        self.taskData[i].tweenId = i
    end

    if isInit then
        self.mTaskScroller.DataProvider = self.taskData
    else
        self.mTaskScroller:ReplaceAllDataProvider(self.taskData)
    end
end

function onClickGetAllClick(self)
    local list = {}
    for i = 1, #self.taskData do
        if self.taskData[i].serverVo.state == 0 then
            table.insert(list, self.taskData[i].taskVo.id)
        end
    end

    if #list > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_GAIN_TASK, list)
    else
        gs.Message.Show("没有可以领取的奖励")
    end
end

function filterByTaskType(self)
    local retList = {}
    for i = 1, #self.taskData do
        if self.taskData[i].taskVo.page == self.taskFilterType then
            table.insert(retList, self.taskData[i])
        end
    end
    return retList
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]