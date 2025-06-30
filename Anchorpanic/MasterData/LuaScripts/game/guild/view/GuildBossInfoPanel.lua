-- @FileName:   GuildBossInfoPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-09 19:55:52
-- @Copyright:   (LY) 2023 雷焰网络
-- @FileName:   FieldExplorationDupPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('guild.GuildBossInfoPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildBossInfoPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(1120, 540)
    self:setTxtTitle(_TT(94553))
end

--析构
function dtor(self)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.mText_Time = self:getChildGO("mText_Time"):GetComponent(ty.Text)
    self.mTextStage = self:getChildGO("mTextStage"):GetComponent(ty.Text)

    self.mTextName = self:getChildGO("mTextName"):GetComponent(ty.Text)
    self.mTextLv = self:getChildGO("mTextLv"):GetComponent(ty.Text)
    self.mTextHpValue = self:getChildGO("mTextHpValue"):GetComponent(ty.Text)
    self.mTextBattleCount = self:getChildGO("mTextBattleCount"):GetComponent(ty.Text)

    self.mImgProgress = self:getChildGO("mImgProgress"):GetComponent(ty.Image)

    self.mPropsContent = self:getChildTrans("mPropsContent")

    self.btnBossInfo = self:getChildGO("btnBossInfo")
    self.btnRank = self:getChildGO("btnRank")
    self.btnImitate = self:getChildGO("btnImitate")
    self.btnFight = self:getChildGO("btnFight")
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
end

function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.btnBossInfo, self.onOpenFormationPanel)
    self:addUIEvent(self.btnRank, self.onOpenDamageLogPanel)

    self:addUIEvent(self.btnImitate, self.onImitateFight)
    self:addUIEvent(self.btnFight, self.onFight)
end

--激活
function active(self, dupConfig)
    super.active(self)
    GameDispatcher:addEventListener(EventName.ONRECEIVE_GUILDBOSS_BATTLECOUNT, self.readyBattleReceive, self)
    GameDispatcher:addEventListener(EventName.ONRECEIVE_GUILDBOSST_INFO, self.refreshBossInfo, self)

    self.mDupConfigVo = dupConfig

    local bossOpenDt, bossEndDt = guild.GuildManager:getGuildBossOpenEndTimeDt()
    self.mBossEndDt = bossEndDt
    self:refreshGuildBossTime()

    if self.mBossEndDt ~= nil then
        self:clearRefreshGuildBossTimer()
        self.mRefreshBossTimer = self:addTimer(1, 0, self.refreshGuildBossTime)
    end

    local strPath = string.format("arts/ui/bg/guild/%s_01.png", self.mDupConfigVo.boss_img)
    self.mImgIcon:SetImg(strPath, false)

    local bossId = self.mDupConfigVo.boss_id
    local vo = monster.MonsterManager:getMonsterVo(bossId)
    local monsterVo = monster.MonsterManager:getMonsterVo01(vo.tid)

    self.mTextName.text = monsterVo.name
    self.mTextLv.text = "Lv." .. vo.lvl

    local awardList = self.mDupConfigVo:getKillAward()
    if awardList then
        self:clearProps()
        for _, vo in ipairs(awardList) do
            local propsGrid = PropsGrid:createByData({tid = vo.tid, num = vo.num, parent = self.mPropsContent, showUseInTip = true})
            table.insert(self.mPropsGrids, propsGrid)
        end
    end

    self:refreshBossInfo()
end

function readyBattleReceive(self, msg)
    if msg.dup_id ~= self.mDupConfigVo.dupId then
        return
    end

    local battle = function ()
        self:onFightHandler(self.mClickBattleTye)
    end
    if msg.battleCount > 0 then
        UIFactory:alertMessge(_TT(94587), true, battle, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
        return
    end

    battle()
end

function clearProps(self)
    if self.mPropsGrids then
        for _, item in pairs(self.mPropsGrids) do
            item:poolRecover()
        end
    end

    self.mPropsGrids = {}
end

function refreshBossInfo(self)
    self.mBaseInfo = guild.GuildManager:getGuildBossAllInfo()
    if self.mBaseInfo then
        self.mTextStage.text = _TT(2912) .. " " .. self.mBaseInfo.round

        self.mBossInfo = self.mBaseInfo.boss_list[self.mDupConfigVo.dupId]
        if self.mBossInfo then
            local bossCurHp = self.mBossInfo.now_hp
            local bossMaxHp = self.mBossInfo.max_hp
            self.mImgProgress.fillAmount = bossCurHp / bossMaxHp
            self.mTextHpValue.text = string.format("%s/%s", bossCurHp, bossMaxHp)
        end
        local color = self.mBaseInfo.challenge_time <= 0 and "#fa3a2b" or "#202226"
        self.mTextBattleCount.text = string.format("%s<color=%s>%s</color>", _TT(94552), color, self.mBaseInfo.challenge_time)
    end
end

function clearRefreshGuildBossTimer(self)
    if self.mRefreshBossTimer then
        self:removeTimerByIndex(self.mRefreshBossTimer)
        self.mRefreshBossTimer = nil
    end
end

function refreshGuildBossTime(self)
    local curClientDt = GameManager:getClientTime()
    local time = self.mBossEndDt - curClientDt
    if time > 0 then
        self.mText_Time.text = string.format("%s<color=#fa3a2b>%s</color>", _TT(94557), TimeUtil.getNewRoleShowTime(time))
    else
        self.mText_Time.text = _TT(94503)
    end
end

function getIsCanFight(self)
    if not guild.GuildManager:getGuildBossIsOpen() then
        gs.Message.Show(_TT(94503))
        return false
    end

    if not self.mBaseInfo then
        return false
    end

    if self.mBossInfo and self.mBossInfo.now_hp <= 0 then
        gs.Message.Show(_TT(94589))
        return false
    end
    return true
end

function onFight(self)
    if not self:getIsCanFight() then
        return
    end

    if self.mBaseInfo.challenge_time <= 0 then
        gs.Message.Show(_TT(94584))
        return
    end

    if self.mBossInfo and not self.mBossInfo.can_fight then
        gs.Message.Show(_TT(94591))
        return
    end

    self.mClickBattleTye = PreFightBattleType.Guild_boss_war
    GameDispatcher:dispatchEvent(EventName.ONREQ_GUILDBOSS_BATTLECOUNT, self.mDupConfigVo.dupId)
end

function onImitateFight(self)
    if not self:getIsCanFight() then
        return
    end

    self:onFightHandler(PreFightBattleType.Guild_boss_imitate)
end

function onFightHandler(self, fightBattleType)
    local function callFun(callReason)
        if callReason == formation.CALL_FUN_REASON.CLOSE then
            fight.FightManager:reqBattleEnter(fightBattleType, self.mDupConfigVo.dupId)
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSS_DUPINFO_PANEL, self.mDupConfigVo)
        end
    end

    local maxBattleCount = sysParam.SysParamManager:getValue(SysParamType.GUILDBOSS_MAXBATTLECOUNT)
    local dataId = 4
    if fightBattleType == PreFightBattleType.Guild_boss_war then
        dataId = maxBattleCount - self.mBaseInfo.challenge_time + 1
    end

    local data = {data = {[1] = self.mBaseInfo.lock_hero_list}, battleType = fightBattleType, dupType = DupType.GuildBoss, dupId = self.mDupConfigVo.dupId}
    formation.openFormation(formation.TYPE.GUILD_BOSS_WAR, dataId, data, callFun)
    self:close()
end

function onOpenDamageLogPanel(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSS_DAMAGELOG_PANEL, self.mDupConfigVo.dupId)
end

function onOpenFormationPanel(self)
    local call = function ()
        GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSS_DUPINFO_PANEL, self.mDupConfigVo)
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, {dupVo = self.mDupConfigVo, closeCallBack = call})
    self:close()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.ONRECEIVE_GUILDBOSS_BATTLECOUNT, self.readyBattleReceive, self)
    GameDispatcher:removeEventListener(EventName.ONRECEIVE_GUILDBOSST_INFO, self.refreshBossInfo, self)

    self:clearProps()
end

return _M
