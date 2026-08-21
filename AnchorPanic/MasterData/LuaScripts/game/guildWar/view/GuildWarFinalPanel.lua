--[[ 
-----------------------------------------------------
@Description    : 联盟团战决赛界面
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("guild.GuildWarFinalPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarFinalPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    -- self:setTxtTitle(_TT(149186))
    self:setTxtTitle(_TT(149219))
    self:setSize(0, 0)
    -- self:setBg("guild_bg.jpg", false, "guild")
    -- self:setUICode(LinkCode.GuildWar)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mDayItemList = {}
    self.tweenTimeSn = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mDayScroll = self:getChildGO("mDayScroll"):GetComponent(ty.ScrollRect)

    self.mDayItem = self:getChildGO("mDayItem")
    self.mTxtEndTimer = self:getChildGO("mTxtEndTimer"):GetComponent(ty.Text)

    self.mBtnShop = self:getChildGO("mBtnShop")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnShop, function()
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
            linkId = LinkCode.GuildWarTopShop
        })
    end)
end
-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_STATE, self.showPanel, self)
    MoneyManager:setMoneyTidList({})
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_STATE, self.showPanel, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    self:clearDayItemList()

    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    self:recoverSn()
end

function showPanel(self)

    self:clearDayItemList()
    self.curDay = guildWar.GuildWarManager:getTopDay()
    local startTimer, endTimer = guildWar.GuildWarManager:getWarTopBetTime()
    for i = 1, 6 do
        local item = SimpleInsItem:create(self.mDayItem, self.mDayScroll.content, "mFinalDayItem")
        item:getChildGO("mTxtDay"):GetComponent(ty.Text).text = _TT(136509, i)
        item:getChildGO("mImgMask"):SetActive(i > self.curDay)
        item:getChildGO("mImgCurr"):SetActive(i == self.curDay)

        local txt = ""
        item:getChildGO("mTxtTimer"):GetComponent(ty.Text).text = ""
        if self.curDay > i then
            txt = _TT(149229)
        elseif self.curDay == i then
            local clientTime = GameManager:getClientTime()
            if clientTime > startTimer and clientTime < endTimer then
                txt = _TT(149230)
                item:getChildGO("mTxtTimer"):GetComponent(ty.Text).text =
                    TimeUtil.getFormatTimeBySeconds_2(endTimer - clientTime)
            else
                item:getChildGO("mTxtTimer"):GetComponent(ty.Text).text = _TT(149231)
            end
        else
            txt = _TT(149253)
        end
        item:getChildGO("mTxtState"):GetComponent(ty.Text).text = txt
        local betRed = guildWar.GuildWarManager:getGuildBetRed()
        if betRed and i == self.curDay then
            RedPointManager:add(item:getChildTrans("main"), nil, 78.5, 230)
        else
            RedPointManager:remove(item:getChildTrans("main"))
        end
        item:addUIEvent(nil, function()
            if self.curDay == i and startTimer == 0 then
                gs.Message.Show(_TT(149252))
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_TOP_DAY_PANEL, i)
            end
        end)
        item:getGo():SetActive(false)
        local isRed = guildWar.GuildWarManager:getGuildBetAwarRed(i) 
        if isRed then
            RedPointManager:add(item:getChildTrans("main"), nil, 78.5, 230)
        else
            RedPointManager:remove(item:getChildTrans("main"))
        end
        table.insert(self.mDayItemList, item)
    end

    self:recoverSn()
    for i = 1, #self.mDayItemList do
        table.insert(self.tweenTimeSn, LoopManager:addFrame(2 * i, 1, self, function()
            if self.mDayItemList[i] ~= nil then
                self.mDayItemList[i]:getGo():SetActive(true)
            end
        end))
    end

    self:updateTime()
    self.updateTimeSn = self:addTimer(1, 0, self.updateTime)
end

function updateTime(self)
    local clientTime = GameManager:getClientTime()
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.GuildWarTopBet)
    local endTime = activityVo:getOverTimeDt()
    if endTime - clientTime > 0 then
        self.mTxtEndTimer.text = _TT(149204) .. TimeUtil.getFormatTimeBySeconds_2(endTime - clientTime)
    else
        self:close()
        return
    end

    for i = 1, #self.mDayItemList, 1 do
        local item = self.mDayItemList[i]
        local txt = ""
        item:getChildGO("mTxtTimer"):GetComponent(ty.Text).text = ""
        if self.curDay > i then
            txt = _TT(149229)
        elseif self.curDay == i then
            local startTimer, endTimer = guildWar.GuildWarManager:getWarTopBetTime()
            local clientTime = GameManager:getClientTime()

            if startTimer == 0 then
                item:getChildGO("mTxtTimer"):GetComponent(ty.Text).text = _TT(149252)
            else
                if clientTime > startTimer and clientTime < endTimer then
                    txt = _TT(149230)
                    item:getChildGO("mTxtTimer"):GetComponent(ty.Text).text =
                        TimeUtil.getFormatTimeBySeconds_2(endTimer - clientTime)
                else
                    item:getChildGO("mTxtTimer"):GetComponent(ty.Text).text = _TT(149231)
                end
            end
        else
            txt = _TT(149253)
        end
        item:getChildGO("mTxtState"):GetComponent(ty.Text).text = txt
        local betRed = guildWar.GuildWarManager:getGuildBetRed()
        if betRed and i == self.curDay then
            RedPointManager:add(item:getGo().transform, nil, 78.5, 230)
        else
            RedPointManager:remove(item:getGo().transform)
        end
        -- item:getGo():SetActive(false)
    end

end

function recoverSn(self)
    if next(self.tweenTimeSn) then
        for i = 1, #self.tweenTimeSn do
            LoopManager:removeFrameByIndex(self.tweenTimeSn[i])
        end
    end
end

function clearDayItemList(self)
    for i = 1, #self.mDayItemList do
        self.mDayItemList[i]:poolRecover()
    end
    self.mDayItemList = {}
end

return _M
