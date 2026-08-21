--[[ 
-----------------------------------------------------
@Description    : 联盟下注界面
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("guild.GuildWarFinalDayPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarFinalDayPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(149251))
    self:setSize(0, 0)
    -- self:setBg("guild_bg.jpg", false, "guild")
    -- self:setUICode(LinkCode.GuildWar)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mFightItemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mFightItem = self:getChildGO("mFightItem")
    self.mFightItemType2 = self:getChildGO("mFightItemType2")

    self.mDayList = {}
    for i = 1, 6, 1 do
        table.insert(self.mDayList, self:getChildGO("day" .. i))
    end
    self.mTxtEndTimer = self:getChildGO("mTxtEndTimer"):GetComponent(ty.Text)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_TOP_INFO, self.showPanel, self)
    GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_TOP_INFO, args)
    -- GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_WAR_TOP_INFO, args)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_TOP_INFO, self.showPanel, self)
    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end
end

function showPanel(self)
    self:clearFightItemList()
    local day = guildWar.GuildWarManager:getGuildWarTopSelectDay()
    for i = 1, 6, 1 do
        self.mDayList[i]:SetActive(i == day)
    end

    if day == 1 then
        local list = guildWar.GuildWarManager:getFirstDayGroup()
        table.sort(list, function(a, b)
            return a.group_id < b.group_id
        end)
        list = self:checkNoData(list, day)
        for i = 1, #list, 1 do
            local pos = self:getChildTrans("mDay" .. day .. "Pos" .. i)
            local item = SimpleInsItem:create(self.mFightItem, pos, "mFightItem")
            self:createInfoOpt(item, list[i], day, true)
            table.insert(self.mFightItemList, item)
        end
    elseif day == 2 or day == 3 then
        --
        local winGroup = guildWar.GuildWarManager:getWinGroup()
        winGroup = self:checkNoData(winGroup, day, true)
        for i = 1, #winGroup, 1 do
            local pos = self:getChildTrans("mDay" .. day .. "Pos" .. i)
            local item = SimpleInsItem:create(self.mFightItem, pos, "mFightItem")
            self:createInfoOpt(item, winGroup[i], day, true)
            table.insert(self.mFightItemList, item)
        end
        local loseGroup = guildWar.GuildWarManager:getLoseGroup()
        loseGroup = self:checkNoData(loseGroup, day, false)
        for i = 1, #loseGroup, 1 do
            local pos = self:getChildTrans("mDay" .. day .. "Pos" .. (i + #winGroup))
            local item = SimpleInsItem:create(self.mFightItem, pos, "mFightItem")
            self:createInfoOpt(item, loseGroup[i], day, false)
            table.insert(self.mFightItemList, item)
        end
    elseif day == 4 or day == 5 then
        local loseGroup = guildWar.GuildWarManager:getLoseGroup()
        loseGroup = self:checkNoData(loseGroup, day, false)
        for i = 1, #loseGroup, 1 do
            local pos = self:getChildTrans("mDay" .. day .. "Pos" .. i)
            local item = SimpleInsItem:create(self.mFightItem, pos, "mFightItem")
            self:createInfoOpt(item, loseGroup[i], day, false)
            table.insert(self.mFightItemList, item)
        end
    else
        local winGroup = guildWar.GuildWarManager:getWinGroup()
        winGroup = self:checkNoData(winGroup, day, true)
        for i = 1, #winGroup, 1 do
            local pos = self:getChildTrans("mDay" .. day .. "Pos" .. i)
            local item = SimpleInsItem:create(self.mFightItem, pos, "mFightItem")
            self:createInfoOpt(item, winGroup[i], day, true)
            table.insert(self.mFightItemList, item)
        end
    end

    self:updateTime()
    self.updateTimeSn = self:addTimer(1, 0, self.updateTime)

    self.mTxtEndTimer.gameObject:SetActive(guildWar.GuildWarManager:getTopDay() == guildWar.GuildWarManager:getGuildWarTopSelectDay())
end

function updateTime(self)
    local clientTime = GameManager:getClientTime()
    local startTime, endTime = guildWar.GuildWarManager:getWarTopBetTime()
    local curDay = guildWar.GuildWarManager:getTopDay()
    local day = guildWar.GuildWarManager:getGuildWarTopSelectDay()
    local clientTime = GameManager:getClientTime()
    if curDay == day and clientTime < endTime then
        self.mTxtEndTimer.text = _TT(149249) .. TimeUtil.getNewRoleShowTime(endTime - clientTime)
    else
        -- self:showPanel()
        local nextTimer = guildWar.GuildWarManager:getGuildWarTopNextStartTime()
        self.mTxtEndTimer.text = _TT(149250) .. TimeUtil.getNewRoleShowTime(nextTimer - clientTime)
    end
end

function createInfoOpt(self, item, info, day, isWinGroup)
    local betInfo = guildWar.GuildWarManager:getBetInfo()
    gs.TransQuick:UIPos(item:getGo():GetComponent(ty.RectTransform), 0, 0)

    local hasData1 = info.team_1 ~= "0"
    local hasData2 = info.team_2 ~= "0"

    local url = isWinGroup and "guildWar/fight_win_group.png" or "guildWar/fight_lose_group.png"
    local url1 = guild.GuildManager:getIconDataById(info.team_1_icon).icon
    item:getChildGO("mItem1"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(url), false)
    item:getChildGO("mItem1Icon"):SetActive(hasData1)
    item:getChildGO("mItem1Icon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(url1), false)
    item:getChildGO("mItem1Name"):GetComponent(ty.Text).text =
        hasData1 and info.team_1_name or (hasData2 and _TT(149218) or _TT(149232))
    local selectBet = 0
    for j = 1, #betInfo do
        if betInfo[j].group_id == info.group_id then
            selectBet = betInfo[j].bet_uid
        end
    end

    item:getChildGO("mItem1Win"):SetActive(selectBet == info.team_1)

    local url2 = guild.GuildManager:getIconDataById(info.team_2_icon).icon
    item:getChildGO("mItem2"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(url), false)
    item:getChildGO("mItem2Icon"):SetActive(hasData2)
    item:getChildGO("mItem2Icon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(url2), false)
    item:getChildGO("mItem2Name"):GetComponent(ty.Text).text =
        hasData2 and info.team_2_name or (hasData1 and _TT(149218) or _TT(149232))
    item:getChildGO("mItem2Win"):SetActive(selectBet == info.team_2)

    local winIndex = 0
    if info.win_uid ~= "0" then
        if info.win_uid == info.team_1 then
            winIndex = 1
        elseif info.win_uid == info.team_2 then
            winIndex = 2
        end
    end

    item:getChildGO("mTopLine1"):SetActive(winIndex == 1)
    item:getChildGO("mTopLine2"):SetActive(winIndex == 2)

    local url = isWinGroup and "guildWar/fight_result_win.png" or "guildWar/fight_result_lose.png"
    item:getChildGO("mItem3"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(url), false)

    item:getChildGO("mItem3Icon"):SetActive(winIndex > 0)
    local url3 = winIndex == 1 and url or url2
    local winName = winIndex == 1 and info.team_1_name or info.team_2_name
    item:getChildGO("mItem3Name"):GetComponent(ty.Text).text = winName
    item:getChildGO("mItem3Win"):SetActive(winIndex > 0)
    item:getChildGO("mItem3Icon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(url3), false)

    item:getChildGO("mItem3Name"):GetComponent(ty.Text).text = winIndex == 0 and _TT(149232) or winName
    item:getChildGO("mItem3Win"):SetActive(winIndex > 0)

    local startTime, endTime = guildWar.GuildWarManager:getWarTopBetTime()
    local curDay = guildWar.GuildWarManager:getTopDay()
    local clientTime = GameManager:getClientTime()

    if selectBet == 0 and day == curDay and clientTime >= startTime and clientTime <= endTime then
        RedPointManager:add(item:getChildTrans("mItem3"), nil, 115, 44)
    else
        RedPointManager:remove(item:getChildTrans("mItem3"))
    end

     if day < curDay and info.is_gained == 0 then
        RedPointManager:add(item:getChildTrans("mItem3Win"), nil, 30, 12)
    else
        RedPointManager:remove(item:getChildTrans("mItem3Win"))
    end

    item:addUIEvent("mItem3", function()
        local startTime, endTime = guildWar.GuildWarManager:getWarTopBetTime()
        local curDay = guildWar.GuildWarManager:getTopDay()
        local clientTime = GameManager:getClientTime()
        if day == curDay then
            if clientTime >= startTime and clientTime <= endTime then
                GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_TOP_BET_PANEL, info)
            else
                GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_TOP_OB, {day = day,uid1 = info.team_1,uid2 = info.team_2})
            end
        elseif day < curDay and info.is_gained == 0 then
            GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_BET_AWARD, {day = day,groupId = info.group_id})
        else
            gs.Message.Show(_TT(149237))
        end
    end)
end

function checkNoData(self, list, day, isWin)
    local firstCount = 4
    local winCount = 2
    local loseCount = 2

    local noDataInfo = {
        group_id = 0,
        team_1 = "0",
        team_1_name = "",
        team_1_icon = 0,
        team_1_lv = 0,
        team_2 = "0",
        team_2_name = "",
        team_2_icon = 0,
        team_2_lv = 0,
        team_1_bet_count = 0,
        team_2_bet_count = 0,
        win_uid = "9999"
    }

    if day == 1 then
    elseif day == 2 then
        winCount = 2
        loseCount = 2
    elseif day == 3 then
        winCount = 1
        loseCount = 2
    elseif day == 4 then
        winCount = 0
        loseCount = 1
    elseif day == 5 then
        winCount = 0
        loseCount = 1
    elseif day == 6 then
        winCount = 1
        loseCount = 0
    end

    if isWin then
        if #list < winCount then
            for i = #list + 1, winCount, 1 do
                table.insert(list, noDataInfo)
            end
        end
    else
        if #list < loseCount then
            for i = #list + 1, loseCount, 1 do
                table.insert(list, noDataInfo)
            end
        end
    end
    return list
end

function clearFightItemList(self)
    for i = 1, #self.mFightItemList do
        self.mFightItemList[i]:poolRecover()
    end
    self.mFightItemList = {}
end

return _M
