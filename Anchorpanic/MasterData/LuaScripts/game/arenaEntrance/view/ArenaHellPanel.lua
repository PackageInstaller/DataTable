--[[ 
-----------------------------------------------------
@filename       : ArenaHellPanel
@Description    : 巅峰竞技场主界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]] module("arenaEntrance.ArenaHellPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("arenaEntrance/ArenaHellPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(52002))
    self:setBg("arena_bg_01.jpg", true, "arena")
    self:setUICode(LinkCode.PvpArenaHell)
end

-- 析构
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtRemTime = self:getChildGO("mTxtRemTime"):GetComponent(ty.Text)
    self.mTxtRefresh = self:getChildGO("mTxtRefresh"):GetComponent(ty.Text)

    self.mHeadContent = self:getChildTrans("mHeadContent")

    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mBtnRank = self:getChildGO("mBtnRank")

    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtRankPoint = self:getChildGO("mTxtRankPoint"):GetComponent(ty.Text)
    self.mTxtRankWin = self:getChildGO("mTxtRankWin"):GetComponent(ty.Text)
    self.mTxtRankCount = self:getChildGO("mTxtRankCount"):GetComponent(ty.Text)

    self.mBtnAct = self:getChildGO("mBtnAct")
    self.mBtnDef = self:getChildGO("mBtnDef")
    self.mBtnHis = self:getChildGO("mBtnHis")
    self.mBtnShop = self:getChildGO("mBtnShop")
    self.mBtnRefresh = self:getChildGO("mBtnRefresh")

    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(arenaEntrance.ArenaOtherItem)

    self.mEffect_01 = self:getChildGO("mEffect_01")

    self.mTxtWar = self:getChildGO("mTxtWar"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({MoneyTid.ITIANIUM_TID, MoneyTid.PVP_HELL_TID})
    GameDispatcher:addEventListener(EventName.UPDATE_ARENAHELL_PANELINFO, self.showPanel, self)
    if not self.isReshow then
        arenaEntrance.ArenaEntranceManager:setLastClickRefresh(GameManager:getClientTime())
        GameDispatcher:dispatchEvent(EventName.REQ_ARENA_HELL_PANEL_INFO)
    end

    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_ARENA_HELL_OTHER_PANEL)
    MoneyManager:setMoneyTidList({})
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ARENAHELL_PANELINFO, self.showPanel, self)
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end

    if self.mEndTimeSn then
        LoopManager:removeTimerByIndex(self.mEndTimeSn)
        self.mEndTimeSn = nil
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAct, self.onBtnActClick)
    self:addUIEvent(self.mBtnDef, self.onBtnDefClick)
    self:addUIEvent(self.mBtnHis, self.onBtnHisClick)
    self:addUIEvent(self.mBtnShop, self.onBtnShopClick)
    self:addUIEvent(self.mBtnRank, self.onBtnRankClick)

    self:addUIEvent(self.mBtnRefresh, self.onBtnRefershClick)
end

function onBtnRankClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HELL_AWARD_PANEL)
    -- gs.Message.Show("排行榜 TODO")
end

function onBtnActClick(self)
    formation.openFormation(formation.TYPE.ARENA_PEAK_ATTACK, nil, nil, nil)
end

function onBtnDefClick(self)
    formation.openFormation(formation.TYPE.ARENA_PEAK_DEFENSE, nil, nil, nil)
end

function onBtnHisClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HELL_HIS_PANEL)
    -- gs.Message.Show("历史信息 TODO")
end

function onBtnShopClick(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_STOP_ARENA_HELL, true) == false then
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
        linkId = LinkCode.ShopArenaHell
    })
end

function onBtnRefershClick(self)
    local needTime = sysParam.SysParamManager:getValue(SysParamType.PVPHELL_TIMERS)
    local lastTime = arenaEntrance.ArenaEntranceManager:getLstClickRefresh()
    if lastTime == 0 or GameManager:getClientTime() - arenaEntrance.ArenaEntranceManager:getLstClickRefresh() >=
        needTime then
        arenaEntrance.ArenaEntranceManager:setLastClickRefresh(GameManager:getClientTime())
        GameDispatcher:dispatchEvent(EventName.REQ_ARENA_HELL_PLAYER_REFRESH)
        gs.Message.Show(_TT(62229))
    else
        gs.Message.Show(_TT(62228, needTime - (GameManager:getClientTime() - lastTime)))
    end
end

function onUpdateHellTime(self)
    local clientTime = GameManager:getClientTime()
    local remainTime = self.mHellEndTime - clientTime
    if remainTime > 0 then
        self.mTxtRemTime.text = _TT(48019) .. ":" .. TimeUtil.getFormatTimeBySeconds_1(remainTime)
    else
        gs.Message.Show(_TT(176))
        self:close()
        return
    end

    local refTime = self.mRefreshTime - clientTime
    if refTime > 0 then
        self.mTxtRefresh.text = _TT(25002) .. "<color=#18EC68>" .. TimeUtil.getHMSByTime_1(refTime) .. "</color>"
    else
        self.mTxtRefresh.text = ""
    end

    if refTime <= 0 and self.isRef == false then
        self.isRef = true
        GameDispatcher:dispatchEvent(EventName.CLOSE_ARENA_HELL_OTHER_PANEL)
        GameDispatcher:dispatchEvent(EventName.REQ_ARENA_HELL_PLAYER_REFRESH)
    end
end

function showPanel(self)

    self.mTxtWar.text = arenaEntrance.ArenaEntranceManager:getArenaWarTxt()

    GameDispatcher:dispatchEvent(EventName.CLOSE_ARENA_HELL_OTHER_PANEL)
    if arenaEntrance.ArenaEntranceManager.selectEnemyData then
        local enemyData = arenaEntrance.ArenaEntranceManager.selectEnemyData
        GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HELL_OTHER_PANEL, {
            data = enemyData
        })
    end

    self.isRef = false
    self.mHellEndTime = arenaEntrance.ArenaEntranceManager:getSeasonEndTime()
    self.mRefreshTime = arenaEntrance.ArenaEntranceManager:getRefeshTime()
    if self.mEndTimeSn then
        LoopManager:removeTimerByIndex(self.mEndTimeSn)
        self.mEndTimeSn = nil
    end

    local clientTime = GameManager:getClientTime()
    local remainTime = self.mHellEndTime - clientTime
    if remainTime > 0 then
        self:onUpdateHellTime()
        self.mEndTimeSn = LoopManager:addTimer(1, 0, self, self.onUpdateHellTime)
    else
        self:close()
        return
    end

    self:showMyInfo()

    local rank = arenaEntrance.ArenaEntranceManager:getMySeasonRank()
    local list = arenaEntrance.ArenaEntranceManager:getEnemyList()
    local disorder = true
    for i, v in ipairs(list) do
        if v.rank > 20 then
            disorder = false 
            break
        end
    end
    if disorder then
        -- 列表排名都是前20就打乱排序
        list = table.randomArray(list)
    end

    if list ~= nil then
        if (self.mLyScroller.Count <= 0) then
            self.mLyScroller.DataProvider = list
        else
            self.mLyScroller:ReplaceAllDataProvider(list)
        end
    end
end

function showMyInfo(self)
    local roleVo = role.RoleManager:getRoleVo()
    self.mTxtName.text = roleVo:getPlayerName()

    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end

    self.mPlayerHeadGrid = PlayerHeadGrid:create(self.mHeadContent, roleVo:getAvatarId(), 1, false)
    self.mPlayerHeadGrid:setHeadFrame(roleVo:getAvatarFrameId())
    self.mPlayerHeadGrid:setLvl(roleVo:getPlayerLvl())
    self.mPlayerHeadGrid:setScale(0.8)
    self.mPlayerHeadGrid:setClickEnable(false)

    local rank = arenaEntrance.ArenaEntranceManager:getMySeasonRank()
    if rank <= 0 then
        self.mTxtRank.text = _TT(161)
        self.mEffect_01:SetActive(false)
    else
        self.mTxtRank.text = _TT(194, rank)
        self.mEffect_01:SetActive(rank <= 3)
    end

    self.mTxtRankPoint.text = "当前积分：" .. arenaEntrance.ArenaEntranceManager:getMyScore()
    self.mTxtRankWin.text = "当前胜场：" .. arenaEntrance.ArenaEntranceManager:getMyWinCount()
    self.mTxtRankCount.text = "剩余次数：" .. arenaEntrance.ArenaEntranceManager:getMyRemainTimes() +
                                  arenaEntrance.ArenaEntranceManager:getBuyTimes() .. "/" ..
                                  sysParam.SysParamManager:getValue(SysParamType.PVPHELL_TIMERS)

end

return _M
