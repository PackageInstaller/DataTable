--[[ 
-----------------------------------------------------
@filename       : CycleTaskPanel
@Description    : 事影循回任务界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("cycle.CycleTaskPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleTaskPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(331))
    self:setBg("common_bg_008.jpg", false)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mTaskItemList = {}

end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtRemTime = self:getChildGO("mTxtRemTime"):GetComponent(ty.Text)
    self.mTxtRefreshTimer = self:getChildGO("mTxtRefreshTimer"):GetComponent(ty.Text)

    self.mTaskScroll = self:getChildGO("mTaskScroll"):GetComponent(ty.ScrollRect)
end

-- 激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_CYCLE_TASK_PANEL, self.onUpdateTaskHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_CYCLE_TASK_ALL_PANEL, self.showPanel, self)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    GameDispatcher:removeEventListener(EventName.UPDATE_CYCLE_TASK_PANEL, self.onUpdateTaskHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CYCLE_TASK_ALL_PANEL, self.showPanel, self)
    self:clearTaskItems()

    if self.mMonTimeloopSn then
        LoopManager:removeTimerByIndex(self.mMonTimeloopSn)
    end
end

-- 更新任务界面
function onUpdateTaskHandler(self, args)
    self.mTxtRefreshTimer.text = _TT(27584) .. cycle.CycleManager:getTaskRefreshTimes()
    self.lastIndex = cycle.CycleManager:getLastIndex()

    if self.lastIndex then
        for i = 1, #self.mTaskItemList do
            self.mTaskItemList[i]:updateView()
            if i == self.lastIndex + 1 then
                self.mTaskItemList[i]:showRef(args.info, i - 1)
            end
        end
    end
    
    -- self.mTaskItemList[self.lastIndex+1]:showRef(args.info)
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function onMonTimerLoop(self)
    local serverTime = GameManager:getClientTime()

    local resetTime = cycle.CycleManager:getResetTime()

    -- -- 如果是当月的1号 并且在5点前 使用当月的时间戳
    -- if tonumber(os.date("%d", serverTime)) == 1 and tonumber(os.date("%H", serverTime)) < 5 then
    --     self.lastMonTime = os.time({
    --         year = os.date("%Y", serverTime),
    --         month = os.date("%m", serverTime),
    --         day = 1,
    --         hour = 5
    --     })
    -- else
    --     self.lastMonTime = os.time({
    --         year = os.date("%Y", serverTime),
    --         month = os.date("%m", serverTime) + 1,
    --         day = 1,
    --         hour = 5
    --     })
    -- end

    local s = TimeUtil.getFormatTimeBySeconds_2(resetTime - serverTime)
    self.mTxtRemTime.text = _TT(27599, s) --"剩余重置时间:<color=#18ec68>" .. s .. "</color>"
end

function showPanel(self)

    if self.mMonTimeloopSn then
        LoopManager:removeTimerByIndex(self.mMonTimeloopSn)
    end

    self.mMonTimeloopSn = self:addTimer(1, 0, self.onMonTimerLoop)
    self:onMonTimerLoop()

    self.mTxtRefreshTimer.text = _TT(27584) .. cycle.CycleManager:getTaskRefreshTimes()
    self.mTaskList = {}
    self.mTaskDic = cycle.CycleManager:getServerTaskDic()

    for k, v in pairs(self.mTaskDic) do
        local taskVo = cycle.CycleManager:getCycleTaskData(v.id)
        v.icon = taskVo.icon
        table.insert(self.mTaskList, v)
    end

    table.sort(self.mTaskList, function(vo1, vo2)
        return vo1.icon < vo2.icon
    end)

    self:clearTaskItems()
    for i = 1, #self.mTaskList do
        local item = cycle.CycleTaskItem:poolGet()
        self.mTaskList[i].index = i - 1
        item:setData(self.mTaskScroll.content, self.mTaskList[i])
        table.insert(self.mTaskItemList, item)
    end
end

function clearTaskItems(self)
    for i = 1, #self.mTaskItemList do
        self.mTaskItemList[i]:poolRecover()
    end
    self.mTaskItemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27584):	"剩余刷新次数:"
	语言包: _TT(27584):	"剩余刷新次数:"
]]
