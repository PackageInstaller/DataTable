--[[ 
-----------------------------------------------------
@filename       : BuildBaseDroneSpView
@Description    : 派遣UI
@date           : 2023-02-25 11:40:02
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("buildBase.DispatchDockPanel ", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("buildBase/DispatchDockPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")
    self:setTxtTitle("派遣坞") --语言包
end
-- 析构  
function dtor(self)
    super.dtor(self)
end

function initData(self)
    super.initData(self)
    self.mSlotTransDic = {}
    self.mSlotsDic = {}
    self.mFxGo = {}
end

-- 初始化
function configUI(self)
    self.mTxtAvailableTimes = self:getChildGO("mTxtAvailableTimes"):GetComponent(ty.Text)
    self.mTxtNextTime = self:getChildGO("mTxtNextTime"):GetComponent(ty.Text)
    self.mTxtDispatchedTeam = self:getChildGO("mTxtDispatchedTeam"):GetComponent(ty.Text)

    self.mBtnKeyDock = self:getChildGO("mBtnKeyDock")
    self.mBtnKeyGet = self:getChildGO("mBtnKeyGet")
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.MsgInfo = args
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.onUpdatePanelInfo, self)
    GameDispatcher:addEventListener(EventName.DISPATCH_INFO_UPDATE, self.onUpdatePanelInfo, self)

    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_DISPATCH_HERO, self.onUpdateSlots, self)
    GameDispatcher:addEventListener(EventName.RESPONSE_DISPATCH_RECEIVE_REWARD, self.onUpdateSlots, self)
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_DISPATCH_RECALL, self.onUpdateSlots, self)
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_DISPATCH_SPEEDUP, self.onUpdateSlots, self)
    MoneyManager:setMoneyTidList({ MoneyTid.UAV_TID, MoneyTid.POWER_TID, MoneyTid.TITANITE_TID })
    self:initSlots()
    self:updateInfo()
    self:updateDispatchInfo()
    self:updateFx()
end

function onHeroSelectHandler(self, args)
    local selectHeroId = args.heroId
    -- explore.exploreManager:changeHeroList(selectHeroId)
    self:setData(args.data, false)
end

-- 销毁
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    --MoneyManager:setMoneyTidList({ MoneyTid.UAV_TID, MoneyTid.POWER_TID, MoneyTid.TITANITE_TID })
    self:clear()
    LoopManager:removeTimer(self, self.onUpdateDispatchTimerInfo)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.onUpdatePanelInfo, self)
    GameDispatcher:removeEventListener(EventName.DISPATCH_INFO_UPDATE, self.onUpdatePanelInfo, self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_DISPATCH_HERO, self.onUpdateSlots, self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_DISPATCH_HERO, self.onUpdateSlots, self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_DISPATCH_RECEIVE_REWARD, self.onUpdateSlots, self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_DISPATCH_RECALL, self.onUpdateSlots, self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_DISPATCH_SPEEDUP, self.onUpdateSlots, self)
    LoopManager:removeTimer(self, self.onUpdateChargeTimerInfo)
end


function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnKeyGet, self.onKeyGet)
    self:addUIEvent(self.mBtnKeyDock, self.onKeyDock)
end

function closeAll(self)
    super.closeAll(self)
    self:clear()
end

function closeAll(self)
    super.closeAll(self)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
end

function onKeyGet(self)
    GameDispatcher:dispatchEvent(EventName.DISPATCH_ONE_KEY_RECEIVE)
end

-- 一键派遣
function onKeyDock(self)
    local dispatchArea = {}
    for i = 1, buildBase.DispatchDockManager:getExploreAreaLength() do
        local slotId = i
        local helper = buildBase.DispatchDockManager:getAreaInfo(slotId)
        if helper then
            local taskId = helper.taskId
            local state = buildBase.DispatchDockManager:checkTaskState(slotId)
            if state == buildBase.TaskState.Available then
                dispatchArea[slotId] = taskId
            end
        end
    end
    local heroList = buildBase.DispatchDockManager:getAutoDispatchList(dispatchArea)
    GameDispatcher:dispatchEvent(EventName.DISPATCH_ONE_KEY_BEGIN, heroList)
end

function initSlots(self)
    self:clear()
    for i = 1, buildBase.DispatchDockManager:getExploreAreaLength() do
        local stringHelper = "mSlot_0" .. i
        if self.mSlotTransDic[stringHelper] == nil then
            local slotTrans = self:getChildTrans(stringHelper)
            self.mSlotTransDic[stringHelper] = slotTrans
        end
        local slot = buildBase.DisPatchTaskItem.new()
        slot:setParentTrans(self.mSlotTransDic[stringHelper])
        slot:setData(i) ------初始化data
        slot:addAllUIEvent()
        self.mSlotsDic[i] = slot
    end
end

function onUpdatePanelInfo(self)
    self:initSlots(self)
    self:updateInfo(self)
    for exploreId, Vo in pairs(self.mSlotsDic) do
        Vo:setData(exploreId)
    end
    self:updateDispatchInfo()
    self:updateFx()
end

function onUpdateSlots(self, exploreId)
    if self.mSlotsDic[exploreId] ~= nil then
        self.mSlotsDic[exploreId]:setData(exploreId)
    end
    self:updateDispatchInfo()
    self:updateFx()
end

function updateInfo(self)
    self.buildId = buildBase.BuildBaseManager:getNowBuildId()
    self.mBuildBaseInfo = buildBase.BuildBaseManager:getBuildBaseData(self.buildId)
end

function updateDispatchInfo(self)
    local AllTimes = sysParam.SysParamManager:getValue(SysParamType.MAXDISPATCHTIMES)
    AllTimes = AllTimes[self.mBuildBaseInfo.lv]
    local mStrHelper = {
        "<color=#fa3a2b>",
        self.mBuildBaseInfo.produce,
        "</color>",
        "/",
        buildBase.DispatchDockManager:getDispatchedLen(),
    }
    self.mTxtAvailableTimes.text = table.concat(mStrHelper)
    mStrHelper = {
        "<color=#18ec68>",
        buildBase.DispatchDockManager:getDispatchedTeam(),
        "</color>",
        "/",
        AllTimes
    }

    self.mTxtDispatchedTeam.text = table.concat(mStrHelper)
    self.mEndTime = self.mBuildBaseInfo.time
    if self.mEndTime > 0 then
        self:onUpdateDispatchTimerInfo()
        LoopManager:removeTimer(1, 0, self, self.onUpdateDispatchTimerInfo)
        LoopManager:addTimer(1, 0, self, self.onUpdateDispatchTimerInfo)
    else
        self.mTxtNextTime.text = "00:00:00"
    end

    local receiveState = false
    local dispatchState = false
    for i = 1, buildBase.DispatchDockManager:getExploreAreaLength() do
        local slotId = i
        local helper = buildBase.DispatchDockManager:getAreaInfo(slotId)
        if helper then
            local taskId = helper.taskId
            local state = buildBase.DispatchDockManager:checkTaskState(slotId)
            if state == buildBase.TaskState.Complete then
                receiveState = true
            end
            if state == buildBase.TaskState.Available then
                dispatchState = true
            end
        end
    end
    self.mBtnKeyGet:SetActive(receiveState)
    self.mBtnKeyDock:SetActive(dispatchState)
end


function updateFx(self)
    if next(self.mFxGo) == nil then
        for i = 1, 6 do
            self.mFxGo[i] = self:getChildGO("mLineEffect_0" .. i)
            self.mFxGo[i]:SetActive(false)
        end
    end
    for idx, slot in pairs(self.mSlotsDic) do
        if slot.mState == buildBase.TaskState.Available or slot.mState == buildBase.TaskState.Incomplete or slot.mState == buildBase.TaskState.Complete then
            if self.mFxGo[idx] then
                self.mFxGo[idx]:SetActive(true)
            end
        else
            if self.mFxGo[idx] then
                self.mFxGo[idx]:SetActive(false)
            end
        end
    end
end

function onUpdateDispatchTimerInfo(self)
    local reamainTime = self.mEndTime - GameManager:getClientTime()
    if (reamainTime < 0) then
    else
        self.mTxtNextTime.text = TimeUtil.getHMSByTime(reamainTime)
    end
end

function clear(self)
    if next(self.mSlotsDic) then
        for _, v in pairs(self.mSlotsDic) do
            v:destroy()
        end
        self.mSlotsDic = {}
    end
end
return _M


--[[ 替换语言包自动生成，请勿修改！
]]