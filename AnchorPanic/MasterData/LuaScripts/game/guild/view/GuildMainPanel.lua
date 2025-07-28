module("guild.GuildMainPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle("联盟")
    self:setSize(0, 0)
    self:setBg("guild_bg.jpg", false, "guild")
    --self:setUICode(LinkCode.Guild)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtGuildName = self:getChildGO("mTxtGuildName"):GetComponent(ty.Text)
    self.mTxtGuildID = self:getChildGO("mTxtGuildID"):GetComponent(ty.Text)
    self.mTxtGuildMasterName = self:getChildGO("mTxtGuildMasterName"):GetComponent(ty.Text)
    self.mTxtMemberCount = self:getChildGO("mTxtMemberCount"):GetComponent(ty.Text)
    self.mTxtGuildLv = self:getChildGO("mTxtGuildLv"):GetComponent(ty.Text)
    self.mTxtGuildExp = self:getChildGO("mTxtGuildExp"):GetComponent(ty.Text)

    self.mExpSliderRt = self:getChildGO("mExpSlider"):GetComponent(ty.RectTransform)
    self.mImgSliderRt = self:getChildGO("mImgSlider"):GetComponent(ty.RectTransform)

    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mBtnChangeName = self:getChildGO("mBtnChangeName")

    self.mBtnChangeNotice = self:getChildGO("mBtnChangeNotice")

    self.mBtnCopy = self:getChildGO("mBtnCopy")

    self.mBtnSupply = self:getChildGO("mBtnSupply")
    self.mBtnPreparation = self:getChildGO("mBtnPreparation")
    self.mBtnShop = self:getChildGO("mBtnShop")
    self.mBtnSkill = self:getChildGO("mBtnSkill")
    self.mBtnMember = self:getChildGO("mBtnMember")
    self.mBtnManager = self:getChildGO("mBtnManager")

    self.mTextBossTime = self:getChildGO("mTextBossTime"):GetComponent(ty.Text)
    self.mBtnBoss = self:getChildGO("mBtnBoss")

    self.mBtnSweep = self:getChildGO("mBtnSweep")
    self.mTextSweepTime = self:getChildGO("mTextSweepTime"):GetComponent(ty.Text)

    self.mBtnBossImitate = self:getChildGO("mBtnBossImitate")

    --self.mBtnSweep:SetActive(false)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({MoneyTid.GUILD_TID, MoneyTid.GUILD_FUND_TID})

    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_MAIN_PANEL, self.showPanel, self)
    GameDispatcher:addEventListener(EventName.ONRECEIVE_GUILDBOSSTIME, self.showGuildBossTime, self)
    GameDispatcher:addEventListener(EventName.ONRECEIVE_GUILDBOSST_INFO, self.updateGuildBossRed, self)

    --打开界面时都会重新请求数据 保证数据的最新
    GameDispatcher:dispatchEvent(EventName.REQ_GUILD_INFO)
    GameDispatcher:dispatchEvent(EventName.ONREQ_GUILDBOSSTIME)
    GameDispatcher:dispatchEvent(EventName.ONREQ_GUILDBOSS_INFO)

    self:showPanel()

end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})

    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_MAIN_PANEL, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.ONRECEIVE_GUILDBOSSTIME, self.showGuildBossTime, self)
    GameDispatcher:removeEventListener(EventName.ONRECEIVE_GUILDBOSST_INFO, self.updateGuildBossRed, self)

    if self.mSweepSn then
        LoopManager:removeTimerByIndex(self.mSweepSn)
        self.mSweepSn = nil
    end

    self:clearRefreshGuildBossTimer()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnChangeName, self.onBtnChangeNameClick)
    self:addUIEvent(self.mBtnChangeNotice, self.onBtnChangeNoticeClick)

    self:addUIEvent(self.mBtnCopy, self.onBtnCopyClick)
    self:addUIEvent(self.mBtnSupply, self.onBtnSupplyClick)
    self:addUIEvent(self.mBtnPreparation, self.onBtnPreparationClick)

    self:addUIEvent(self.mBtnShop, self.onBtnShopClick)
    self:addUIEvent(self.mBtnMember, self.onBtnMemberClick)
    self:addUIEvent(self.mBtnManager, self.onBtnManagerClick)
    self:addUIEvent(self.mBtnBoss, self.onOpenGuildBoss)

    self:addUIEvent(self.mBtnSweep, self.onOpenGuildSweepClick)

    self:addUIEvent(self.mBtnSkill, self.onBtnSkillClick)
    self:addUIEvent(self.mBtnBossImitate, self.onBtnGuildBossImitate)

end

function showGuildBossTime(self)
    self.mGuildBossSeasonState = guild.GuildManager:getSeasonState()

    self:refreshGuildBossTime()

    self:clearRefreshGuildBossTimer()
    self.mRefreshBossTimer = self:addTimer(1, 0, self.refreshGuildBossTime)
end

function refreshGuildBossTime(self)
    if self.mGuildBossSeasonState ~= guild.GuildBossSeasonState.Settlement then
        local bossOpenDt, bossEndDt = guild.GuildManager:getGuildBossOpenEndTimeDt()
        if bossOpenDt ~= nil and bossEndDt ~= nil then
            local curClientDt = GameManager:getClientTime()
            if curClientDt < bossOpenDt then
                self.mTextBossTime.text = _TT(94501) .. TimeUtil.getNewRoleShowTime(bossOpenDt - curClientDt)
            elseif curClientDt < bossEndDt then
                self.mTextBossTime.text = _TT(94502) .. TimeUtil.getNewRoleShowTime(bossEndDt - curClientDt)
            elseif curClientDt > bossEndDt then
                self.mTextBossTime.text = _TT(94503)
            end
        else
            self.mTextBossTime.text = _TT(94503)
        end
    else
        self.mTextBossTime.text = _TT(94519)
    end
end

function clearRefreshGuildBossTimer(self)
    if self.mRefreshBossTimer then
        self:removeTimerByIndex(self.mRefreshBossTimer)
        self.mRefreshBossTimer = nil
    end
end

function onOpenGuildBoss(self)
    if guild.GuildManager:getSeasonState() == guild.GuildBossSeasonState.Init then
        gs.Message.Show(_TT(94609))
        return
    end

    -- GameDispatcher:dispatchEvent(EventName.REQ_ADD_NOT_REMIND, {moduleId = RemindConst.GUILDBOSS_REDPOINT_TIPS})

    GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSS_MAINUI)
end

function onOpenGuildSweepClick(self)
    GameDispatcher:dispatchEvent(EventName.CAN_OPEN_SWEEP_PANEL)
end

function onBtnChangeNameClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_CHANGE_NAME_PANEL)

end

function onBtnChangeNoticeClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_CHANGE_NOTICE_PANEL)
end

function onBtnCopyClick(self)
    gs.SdkManager:Copy(self.showId)
    local pasteResult = gs.SdkManager:Paste()
    if (pasteResult == "") then
        gs.Message.Show(_TT(25104))--"复制失败"
    else
        gs.Message.Show(string.format(_TT(25105), pasteResult)) -- "复制成功：%s"
    end
end

function onBtnSupplyClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_SUPPLY_PANEL)
end

function onBtnPreparationClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_PREPARATION_PANEL)
end

function onBtnShopClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.ShopGuild})
end

function onBtnMemberClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_MEMBER_PANEL)
end

function onBtnManagerClick(self)
    if self.isChairman then
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_CHAIRMAN_MANAGER_PANEL)
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_MANAGER_PANEL)
    end

end

function onBtnSkillClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_SKILL_PANEL)
end

function onBtnGuildBossImitate(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSSIMITATE_STAGEPANEL)
end

function showPanel(self)

    self:refreshGuildBossTime()
    self:refreshGuildSweepTime()

    self.guildInfo = guild.GuildManager:getGuildInfo()

    self.localData = guild.GuildManager:getGuildData(self.guildInfo.lv)

    self.uid = self.guildInfo.uid
    self.showId = self.guildInfo.show_id
    self.mTxtGuildName.text = self.guildInfo.name
    self.mTxtGuildID.text = _TT(25161) .. self.guildInfo.show_id
    self.mTxtGuildMasterName.text = self.guildInfo.leader_name
    self.mTxtMemberCount.text = #self.guildInfo.members .. "/"..self.localData.peopleNum

    self.mTxtMemberCount.color = #self.guildInfo.members == self.localData.peopleNum and gs.ColorUtil.GetColor("FFB644FF") or gs.ColorUtil.GetColor("FFFFFFFF")

    self.mTxtGuildLv.text = _TT(1361)..self.guildInfo.lv
    local maxLv = guild.GuildManager:getMaxGuildLv()
    if maxLv == self.guildInfo.lv then
        self.mTxtGuildExp.text = _TT(29513)
        gs.TransQuick:SizeDelta01(self.mImgSliderRt, self.mExpSliderRt.sizeDelta.x)
    else
        self.mTxtGuildExp.text = self.guildInfo.exp .. "/"..self.localData.nextExp
        gs.TransQuick:SizeDelta01(self.mImgSliderRt, self.guildInfo.exp / self.localData.nextExp * self.mExpSliderRt.sizeDelta.x)
    end

    self.mTxtDes.text = self.guildInfo.notice

    self.isChairman = guild.GuildManager:getSelfIsChairman()

    self.mBtnManager:SetActive(guild.GuildManager:getSelfIsGuildLeader() or self.isChairman)
    self.mBtnMember:SetActive(not guild.GuildManager:getSelfIsGuildLeader() and self.isChairman == false)
    self.mBtnChangeName:SetActive(guild.GuildManager:getSelfIsGuildLeader())
    self.mBtnChangeNotice:SetActive(guild.GuildManager:getSelfIsGuildLeader())

    self:updateRed()
end

function updateGuildBossRed(self)
    if guild.GuildManager:isShowToDayGuildBossRed() then
        RedPointManager:add(self.mBtnBoss.transform, nil, -172.4, 46.1)
    else
        RedPointManager:remove(self.mBtnBoss.transform)
    end
end

function updateRed(self)
    if guild.GuildManager:canApplyRed() then
        RedPointManager:add(self.mBtnManager.transform, nil, 38, 14)
    else
        RedPointManager:remove(self.mBtnManager.transform)
    end

    if guild.GuildManager:canPreparationRed() then
        RedPointManager:add(self.mBtnPreparation.transform, nil, 38, 14)
    else
        RedPointManager:remove(self.mBtnPreparation.transform)
    end

    if guild.GuildManager:canOpenSupplyRed() or guild.GuildManager:canGetSupplyRed() then
        RedPointManager:add(self.mBtnSupply.transform, nil, 38, 14)
    else
        RedPointManager:remove(self.mBtnSupply.transform)
    end

    if guild.GuildManager:canUpSkillRed() then
        RedPointManager:add(self.mBtnSkill.transform, nil, 38, 14)
    else
        RedPointManager:remove(self.mBtnSkill.transform)
    end

    if guild.GuildManager:canGetSweepRewardRed() or guild.GuildManager:canChallengeSweepRed() then
        RedPointManager:add(self.mBtnSweep.transform, nil, -172.4, 46.1)
    else
        RedPointManager:remove(self.mBtnSweep.transform)
    end
end

function refreshGuildSweepTime(self)
    self.lastChangeTime = guild.GuildManager:getGuildSweepChangeTime()

    if self.mSweepSn then
        LoopManager:removeTimerByIndex(self.mSweepSn)
        self.mSweepSn = nil
    end
    self:refreshSweepTime()
    self.mSweepSn = self:addTimer(1, 0, self.refreshSweepTime)
end

function refreshSweepTime(self)
    local sweepState = guild.GuildManager:getGuildSweepState()
    if sweepState == 0 then
        local clientTime = GameManager:getClientTime()
        if self.lastChangeTime - clientTime > 0 then
            self.mTextSweepTime.text = _TT(100014) .. TimeUtil.getNewRoleShowTime(self.lastChangeTime - clientTime)
        else
            self.mTextSweepTime.text = "锁定中"
        end
    else
        self.mTextSweepTime.text = "锁定中"
    end
end

return _M
