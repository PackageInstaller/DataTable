-- @FileName:   GuildBossMainUI.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-03 16:55:02
-- @Copyright:   (LY) 2023 雷焰网络

module("guild.GuildBossMainUI", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildBossMainUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(94517))
    self:setSize(0, 0)
    self:setUICode(LinkCode.GuildBoss)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

-- 设置货币栏
function setMoneyBar(self)

end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.bossItem = self:getChildGO("bossItem")

    self.mTextStage = self:getChildGO("mTextStage"):GetComponent(ty.Text)
    self.mTextFightTimes = self:getChildGO("mTextFightTimes"):GetComponent(ty.Text)
    self.mTextRank = self:getChildGO("mTextRank"):GetComponent(ty.Text)
    self.mText_Rank = self:getChildGO("mText_Rank"):GetComponent(ty.Text)
    self.mText_Time = self:getChildGO("mText_Time"):GetComponent(ty.Text)

    self.btnFightRecord = self:getChildGO("btnFightRecord")
    self.btnMemberInfo = self:getChildGO("btnMemberInfo")
    self.btnRank = self:getChildGO("btnRank")

    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")
    self.mGroupInfo = self:getChildTrans("mGroupInfo")

    self:setGuideTrans("guide_guildeBoss_tips_1", self:getChildTrans("guide_tips_1"))
    self:setGuideTrans("guide_guildeBoss_tips_2", self:getChildTrans("curStage"))
    self:setGuideTrans("guide_guildeBoss_tips_3", self:getChildTrans("surplusBattleTimes"))
    self:setGuideTrans("guide_guildeBoss_tips_4", self:getChildTrans("btnFightRecord"))
end

--[[    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTextRank.text = _TT(94550)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.btnFightRecord, self.onOpenFightRecord)
    self:addUIEvent(self.btnMemberInfo, self.onOpenMemberFightInfo)

    self:addUIEvent(self.btnRank, self.onOpenRankPanel)
    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
end

-- 适应全面屏，刘海缩进
function setAdapta(self)
    local notchHeight = systemSetting.SystemSettingManager:getNotchH()
    if notchHeight ~= nil and self:getAdaptaTrans() then
        local minV = self:getAdaptaTrans().offsetMin;
        minV.x = notchHeight;
        self:getAdaptaTrans().offsetMin = minV;

        local maxV = self:getAdaptaTrans().offsetMax;
        maxV.x = -notchHeight;
        self:getAdaptaTrans().offsetMax = maxV;
    end
    if notchHeight ~= nil and self.mGroupInfo then
        local minV = self.mGroupInfo.offsetMin;
        minV.x = notchHeight;
        self.mGroupInfo.offsetMin = minV;

        local maxV = self.mGroupInfo.offsetMax;
        maxV.x = -notchHeight;
        self.mGroupInfo.offsetMax = maxV;
    end
end

function getAdaptaTrans(self)
    return self.base_childTrans["mGroupTop"]
end

-- 激活
function active(self, args)
    super.active(self, args)

    if args then
        self.mLateBattleDupId = args.lateBattleDupId
    end

    GameDispatcher:addEventListener(EventName.ONRECEIVE_GUILDBOSST_INFO, self.refreshView, self)
    GameDispatcher:dispatchEvent(EventName.ONREQ_GUILDBOSS_INFO)

    self:refreshView()

    local bossOpenDt, bossEndDt = guild.GuildManager:getGuildBossOpenEndTimeDt()
    self.mBossEndDt = bossEndDt
    self.mBossOpenDt = bossOpenDt
    self:refreshGuildBossTime()

    if self.mBossEndDt ~= nil then
        self:clearRefreshGuildBossTimer()
        self.mRefreshBossTimer = self:addTimer(1, 0, self.refreshGuildBossTime)
    end
end

function onOpenRankPanel(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSS_RANKPANEL)
end

function onOpenFightRecord(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSS_FIGHTLOG_PANEL)
end

function onOpenMemberFightInfo(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSS_MEMBERFIGHTINFO)
end

function refreshView(self)
    local guildBossInfo = guild.GuildManager:getGuildBossAllInfo()
    if not guildBossInfo then
        return
    end

    local maxBattleCount = sysParam.SysParamManager:getValue(SysParamType.GUILDBOSS_MAXBATTLECOUNT)
    if guildBossInfo.challenge_time > 0 then
        self.mTextFightTimes.text = string.format("%s<color=#ffffff>%s/%s</color>", _TT(94552), guildBossInfo.challenge_time, maxBattleCount)
    elseif guildBossInfo.challenge_time == 0 then
        self.mTextFightTimes.text = string.format("%s<color=#fa3a2b>%s</color><color=#ffffff>/%s</color>", _TT(94552), guildBossInfo.challenge_time, maxBattleCount)
    else
        self.mTextFightTimes.text = string.format("%s<color=#fa3a2b>%s</color><color=#ffffff>/%s</color>", _TT(94552), "-", maxBattleCount)
    end

    if guildBossInfo.guild_rank > 0 then
        if guildBossInfo.guild_rank < 1000 then
            self.mText_Rank.text = guildBossInfo.guild_rank
        else
            self.mText_Rank.text = "999+"
        end
    else
        self.mText_Rank.text = _TT(62220)
    end

    self:clearItem()

    local stage = guildBossInfo.round
    if stage ~= 0 then
        self.mTextStage.text = string.format("%s<color=#ffffff>%s</color>", _TT(94551), stage)

        self.mBossItemList = {}
        self.mWeaknessGrid = {}
        local str = {"Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ", "Ⅶ", "Ⅷ", "Ⅸ", "Ⅹ"}

        local maxStage = guild.GuildManager:getGuildBossMaxStage()
        stage = stage > maxStage and maxStage or stage

        local dupStageConfig = guild.GuildManager:getGuildBossStageConfig(stage)
        for i = 1, 5 do
            local line = self:getChildGO(string.format("line (%s)", i))
            local config = dupStageConfig[i]
            if config then
                if line and not gs.GoUtil.IsGoNull(line) then
                    line:SetActive(true)
                end

                local bossItem = SimpleInsItem:create(self.bossItem, self:getChildTrans(string.format("pos (%s)", i)), "GuildBossMainUI_BossItem")
                self.mBossItemList[i] = bossItem

                local strPath = string.format("arts/ui/bg/guild/%s.png", config.boss_img)
                bossItem:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(strPath, false)

                local bossId = config.boss_id
                local vo = monster.MonsterManager:getMonsterVo(bossId)
                local monsterVo = monster.MonsterManager:getMonsterVo01(vo.tid)

                bossItem:getChildGO("mTextName"):GetComponent(ty.Text).text = monsterVo.name
                bossItem:getChildGO("mTextNum"):GetComponent(ty.Text).text = str[i]

                local suggestEle = config.suggestEle
                for i = 1, #suggestEle do
                    local item = SimpleInsItem:create(bossItem:getChildGO("mImgEleTypeItem"), bossItem:getChildTrans("mEleTypeLayout"), "GuildBossItem_EleItem")
                    local type = item.m_go:GetComponent(ty.AutoRefImage)
                    type:SetImg(UrlManager:getHeroEleTypeIconUrl(suggestEle[i]), false)
                    table.insert(self.mWeaknessGrid, item)
                end

                local anLine = self:getChildGO(string.format("line_an (%s)", i))

                local bossInfo = guildBossInfo.boss_list[config.dupId]
                if bossInfo.now_hp <= 0 or bossInfo.can_fight then
                    bossItem:getChildGO("mLock"):SetActive(false)
                    bossItem:getChildGO("mEffect"):SetActive(true)

                    local val = bossInfo.now_hp / bossInfo.max_hp
                    bossItem:getChildGO("mTextProgress"):GetComponent(ty.Text).text = math.ceil(val * 100) .. "%"
                    bossItem:getChildGO("mImgProgress"):GetComponent(ty.Image).fillAmount = val

                    bossItem:getChildGO("mImgoKill"):SetActive(bossInfo.now_hp <= 0)

                    if anLine and not gs.GoUtil.IsGoNull(anLine) then
                        anLine:SetActive(false)
                    end
                else
                    bossItem:getChildGO("mLock"):SetActive(true)
                    bossItem:getChildGO("mEffect"):SetActive(false)

                    bossItem:getChildGO("mTextProgress"):GetComponent(ty.Text).text = "100%"
                    bossItem:getChildGO("mImgProgress"):GetComponent(ty.Image).fillAmount = 1
                    bossItem:getChildGO("mImgoKill"):SetActive(false)

                    if anLine and not gs.GoUtil.IsGoNull(anLine) then
                        anLine:SetActive(true)
                    end
                end

                self:addUIEvent(bossItem.m_go, function()
                    GameDispatcher:dispatchEvent(EventName.ONREQ_GUILDBOSS_INFO)
                    self:onOpenBossInfoPanel(config)
                end)
            end
        end
    else
        self.mTextStage.text = string.format("%s<color=#ffffff>%s</color>", _TT(94551), _TT(77836))
    end
end

function onOpenBossInfoPanel(self, dupConfig)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILDBOSS_DUPINFO_PANEL, dupConfig)
end

function clearRefreshGuildBossTimer(self)
    if self.mRefreshBossTimer then
        self:removeTimerByIndex(self.mRefreshBossTimer)
        self.mRefreshBossTimer = nil
    end
end

function refreshGuildBossTime(self)
    if self.mBossOpenDt ~= nil and self.mBossEndDt ~= nil then
        local curClientDt = GameManager:getClientTime()
        if curClientDt < self.mBossOpenDt then
            self.mText_Time.text = _TT(94501) .. TimeUtil.getNewRoleShowTime(self.mBossOpenDt - curClientDt)
        elseif curClientDt < self.mBossEndDt then
            self.mText_Time.text = _TT(94502) .. TimeUtil.getNewRoleShowTime(self.mBossEndDt - curClientDt)
        elseif curClientDt > self.mBossEndDt then
            self.mText_Time.text = _TT(94503)
        end
    else
        self.mText_Time.text = _TT(94503)
    end
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, {id = LinkCode.GuildBoss})
end

function clearItem(self)
    if self.mBossItemList then
        for k, v in pairs(self.mBossItemList) do
            v:poolRecover()
        end
        self.mBossItemList = nil
    end
    if self.mWeaknessGrid then
        for k, v in pairs(self.mWeaknessGrid) do
            v:poolRecover()
        end
        self.mWeaknessGrid = nil
    end

    for i = 1, 5 do
        local line = self:getChildGO(string.format("line (%s)", i))
        if line and not gs.GoUtil.IsGoNull(line) then
            line:SetActive(false)
        end

        local anLine = self:getChildGO(string.format("line_an (%s)", i))
        if anLine and not gs.GoUtil.IsGoNull(anLine) then
            anLine:SetActive(false)
        end
    end
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearItem()
    GameDispatcher:removeEventListener(EventName.ONRECEIVE_GUILDBOSST_INFO, self.refreshView, self)
end

return _M
