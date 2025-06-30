--[[ 
-----------------------------------------------------
@filename       : ArenaEntrancePanel
@Description    : 竞技场入口界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("arenaEntrance.ArenaEntrancePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("arenaEntrance/ArenaEntrancePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(52002))
    self:setBg("arena_bg_01.jpg", true, "arena")
    self:setUICode(LinkCode.Pvp)
end

-- 析构
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBtnDef = self:getChildGO("mBtnDef")
    self.mBtnHell = self:getChildGO("mBtnHell")

    self.mTxtDefRemTime = self:getChildGO("mTxtDefRemTime"):GetComponent(ty.Text)
    self.mTxtHellRemTime = self:getChildGO("mTxtHellRemTime"):GetComponent(ty.Text)

    self.mTxtDefCount = self:getChildGO("mTxtDefCount"):GetComponent(ty.Text)
    self.mTxtHellCount = self:getChildGO("mTxtHellCount"):GetComponent(ty.Text)

    self.mDefIsLock = self:getChildGO("mDefIsLock")
    self.mHellIsLock = self:getChildGO("mHellIsLock")
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})

    GameDispatcher:addEventListener(EventName.UPDATE_ARENA_HALL_INFO, self.onGetEndTime, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ARENA_HELL_INFO, self.onGetHellEndTime, self)

    if arena.ArenaManager:getSeasonEndTime() == nil then
        GameDispatcher:dispatchEvent(EventName.REQ_ARENA_ALL_INFO)
    else
        self:onGetEndTime()
    end

    if arenaEntrance.ArenaEntranceManager:getSeasonEndTime() == nil then
        GameDispatcher:dispatchEvent(EventName.REQ_ARENA_HELL_INFO)
    else
        self:onGetHellEndTime()
    end
    self:showPanel()
    self:showRedPoint()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    GameDispatcher:removeEventListener(EventName.UPDATE_ARENA_HALL_INFO, self.onGetEndTime, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ARENA_HELL_INFO, self.onGetHellEndTime, self)
    LoopManager:removeTimerByIndex(self.endTimeSn)
    LoopManager:removeTimerByIndex(self.hellEndTime)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnDef, self.onBtnDefClick)
    self:addUIEvent(self.mBtnHell, self.onBtnHellClick)
end

function onBtnDefClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
        linkId = LinkCode.PvpArena
    })
end

function onBtnHellClick(self)
    -- 功能解放前用这条
    -- gs.Message.Show("第一赛季筹备中，将于10月25日正式开启")
    -- 未接协议前用这条
    --GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HELL_PANEL)
    -- 接协议后用这条
    --if arenaEntrance.ArenaEntranceManager:getSeasonEndTime() ~= nil then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.PvpArenaHell })
    --else
    --    gs.Message.Show("状态获取中")
    --end
end

function showPanel(self)
    if (arena.ArenaManager.remainChallengeTimes > 0) then
        self.mTxtDefCount.text = _TT(3531) .. arena.ArenaManager.remainChallengeTimes .. "/3"
    else
        local itemNum = sysParam.SysParamManager:getValue(18, 1)
        local strItemNum = bag.BagManager:getPropsCountByTid(MoneyTid.ARENA_CHALLENGE_TICKET_TID) >= itemNum and
        HtmlUtil:color(bag.BagManager:getPropsCountByTid(MoneyTid.ARENA_CHALLENGE_TICKET_TID),
        "25e8ffff") or
        HtmlUtil:color(bag.BagManager:getPropsCountByTid(MoneyTid.ARENA_CHALLENGE_TICKET_TID),
        "ed1941FF")
        self.mTxtDefCount.text = _TT(3531) .. strItemNum .. "/" .. itemNum
    end
    self:updateInfo()
end

function updateInfo(self)
    local clientTime = GameManager:getClientTime()
    self.mHellEndTime = arenaEntrance.ArenaEntranceManager:getSeasonEndTime()
    local remainTime = 0
    if self.mHellEndTime ~= nil then
        remainTime = self.mHellEndTime - clientTime
    end

    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PVP_ARENA_HELL, false) and arenaEntrance.ArenaEntranceManager:getSeasonEndTime() ~= nil) and remainTime > 0 then
        local times = arenaEntrance.ArenaEntranceManager:getRemainFreeTimes() + arenaEntrance.ArenaEntranceManager:getBuyTimes()

        local s = times > 0 and times or HtmlUtil:color(times,"ed1941FF")
        
        self.mTxtHellCount.text = _TT(3531) .. s .. "/" .. sysParam.SysParamManager:getValue(SysParamType.PVPHELL_TIMERS)
        self.mTxtHellCount.gameObject:SetActive(true)


    else
        self.mHellIsLock:SetActive(true)
        self.mTxtHellCount.gameObject:SetActive(false)
        self.mTxtHellRemTime.text = "未开启"
    end

end

function onGetEndTime(self)
    self.mDefEndTime = arena.ArenaManager:getSeasonEndTime()
    self:updateTime()
    self.endTimeSn = LoopManager:addTimer(1, 0, self, self.updateTime)
end

function onGetHellEndTime(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PVP_ARENA_HELL, false) then--
    
        self.mHellEndTime = arenaEntrance.ArenaEntranceManager:getSeasonEndTime()
        self:updateHellTime()
        self.hellEndTime = LoopManager:addTimer(1, 0, self, self.updateHellTime)
    end
    self:updateInfo()
end

function updateTime(self)
    local clientTime = GameManager:getClientTime()
    local remainTime = self.mDefEndTime - clientTime
    if remainTime > 0 then
        self.mTxtDefRemTime.text = TimeUtil.getFormatTimeBySeconds_1(remainTime)
       
    else
        self.mDefIsLock:SetActive(true)
        self.mTxtDefRemTime.text = "未开启"
        self.mTxtDefCount.gameObject:SetActive(false)
        LoopManager:removeTimerByIndex(self.endTimeSn)
    end
end

function updateHellTime(self)
    local clientTime = GameManager:getClientTime()
    local remainTime = self.mHellEndTime - clientTime
    if remainTime > 0 then
        self.mHellIsLock:SetActive(false)
        self.mTxtHellRemTime.text = TimeUtil.getFormatTimeBySeconds_1(remainTime)
    else
        self.mHellIsLock:SetActive(true)
        self.mTxtHellCount.gameObject:SetActive(false)
        self.mTxtHellRemTime.text = "未开启"
        LoopManager:removeTimerByIndex(self.hellEndTime)
    end
end

-- 入口红点提示
function showRedPoint(self)
    local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.ARENA_REDPOINT_TIPS)
    if not isNotRemind and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PVP_ARENA, false) and arena.ArenaManager.remainChallengeTimes > 0 and arena.ArenaManager.isReset ~= 1 then
        RedPointManager:add(self.mBtnDef.transform, UrlManager:getCommon5Path("common_0013_max.png"), 308, 170)
    else
        RedPointManager:remove(self.mBtnDef.transform)
    end

    local isNotRemindHell = remind.RemindManager:isTodayNotRemain(RemindConst.ARENA_HELL_REDPOINT_TIPS)
    if not isNotRemindHell and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PVP_ARENA_HELL, false) and arenaEntrance.ArenaEntranceManager:getRemainFreeTimes() > 0 and arenaEntrance.ArenaEntranceManager:getIsReset() ~= 1 then
        RedPointManager:add(self.mBtnHell.transform, UrlManager:getCommon5Path("common_0013_max.png"), 308, 170)
    else
        RedPointManager:remove(self.mBtnHell.transform)
    end
end

return _M