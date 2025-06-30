--[[
-----------------------------------------------------
@filename       : MainActivityTaskPanel
@Description    : 活动玩法限时任务面板
@date           : 2023/5/24 15:00
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------]]
--
module("mainActivity.MainActivityTaskPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("mainActivity/MainActivityTaskPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShowCloseAll = 0 --是否显示导航按钮

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(92003))
    self:setBg("activity_main_bg02.jpg", false, "mainActivity")
    self:setUICode(LinkCode.MainActivityTask)
end
-- 析构函数
function dtor(self)
    super.dtor(self)
end
-- 初始化数据
function initData(self)
    super.initData(self)
    self.mTaskList = {}
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(mainActivity.MainActivityTaskItem)
    self.mTextTImer = self:getChildGO("mTextTImer"):GetComponent(ty.Text)
    self.mAutoReceive = self:getChildGO("mAutoReceive")
    self.mScrollerRec = self.mScroller:GetComponent(ty.RectTransform)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mBtnGetAll"), function()
        mainActivity.MainActivityManager:receiveAllTaskAward()
    end)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:getChildGO("mTextTitle_02"):GetComponent(ty.Text).text = _TT(85014) --活动结束时间：
    self:getChildGO("mTxtTips"):GetComponent(ty.Text).text = _TT(92003)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({MoneyTid.ACTIVITY_COIN_TID})
    GameDispatcher:addEventListener(EventName.MAINACTIVITY_TASK_UPDATE, self.setScrollerData, self)
    self:updateTime()
    mainActivity.MainActivityManager.scrollHeight = self.mScrollerRec.sizeDelta.y
    self:setScrollerData()

    MoneyManager:setMoneyTidList({MoneyTid.ACTIVITY_COIN_TID})

end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_TASK_UPDATE, self.setScrollerData, self)
    MoneyManager:setMoneyTidList()
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end

    MoneyManager:setMoneyTidList()

end

function setScrollerData(self)
    if next(self.mTaskList) == nil then
        for _, vo in pairs(mainActivity.MainActivityManager:getTaskConfig()) do
            table.insert(self.mTaskList, vo)
        end
    end

    local msgList = mainActivity.MainActivityManager.mActivityTaskMsg

    if msgList and next(msgList) then
        local listHelper = {}
        for _, msgVo in pairs(msgList) do
            if msgVo.state == 2 then
                local configVo = mainActivity.MainActivityManager:getTaskConfigVo(msgVo.id)
                table.insert(listHelper, configVo)
                table.removebyvalue(self.mTaskList, configVo)
            end
        end

        for _, configVo in pairs(listHelper) do
            table.insert(self.mTaskList, configVo)
        end
    end

    table.sort(self.mTaskList, function (vo1, vo2)
        local vo1State = msgList[vo1.id].state
        local vo2State = msgList[vo2.id].state

        if vo1State ~= vo2State then
            return vo1State < vo2State
        else
            return vo1.id < vo2.id
        end
    end)

    --if self.mTaskList[1].tweenId == nil then
        for i = 1, #self.mTaskList do
            self.mTaskList[i].tweenId = i * 3
        end
    --end

    if self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = self.mTaskList
    else
        self.mScroller:ReplaceAllDataProvider(self.mTaskList)
    end
    self:updateView()
end

function updateView(self)

    self.mAutoReceive:SetActive(mainActivity.MainActivityManager:checkTaskAwardCanReceive())

    local height
    if self.mAutoReceive.activeSelf == true then
        height = mainActivity.MainActivityManager.scrollHeight - self.mAutoReceive:GetComponent(ty.RectTransform).rect.height
    else
        height = mainActivity.MainActivityManager.scrollHeight
    end
    gs.TransQuick:SizeDelta02(self.mScrollerRec.gameObject.transform, height)
end

function updateTime(self)
    local mainActivityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Task)
    local updateTime = function()
        self.mTextTImer.text = mainActivityVo:getRemainingTime()
    end
    updateTime()
    self:addTimer(1, 0, updateTime)

end

function __closeOpenAction(self)
    if self.isPop == 1 then
        self:close()
    end
end

function __playOpenAction(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
