--[[ 
-----------------------------------------------------
@Description    : 联盟团战主界面
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("guild.GuildWarMainPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(149186))
    self:setSize(0, 0)
    self:setBg("guild_bg.jpg", false, "guild")
    self:setUICode(LinkCode.GuildWar)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mBuildItemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtWarId = self:getChildGO("mTxtWarId"):GetComponent(ty.Text)
    self.mTxtWarTime = self:getChildGO("mTxtWarTime"):GetComponent(ty.Text)
    self.mTxtWarEndTime = self:getChildGO("mTxtWarEndTime"):GetComponent(ty.Text)
    self.mBuildPos = {}
    table.insert(self.mBuildPos, self:getChildGO("mBuildMainPos"))
    for i = 1, 3 do
        table.insert(self.mBuildPos, self:getChildGO("mBuildChildPos" .. i))
    end

    self.mBuildEnemyPos = {}
    table.insert(self.mBuildEnemyPos, self:getChildGO("mBuildMainPosEnemy"))
    for i = 1, 3 do
        table.insert(self.mBuildEnemyPos, self:getChildGO("mBuildChildPosEnemy" .. i))
    end

    self.mStateBuildInfo = self:getChildGO("mStateBuildInfo")
    self.mStateNoInit = self:getChildGO("mStateNoInit")
    self.mTxtStep = self:getChildGO("mTxtStep"):GetComponent(ty.Text)
    self.mTxtInfo = self:getChildGO("mTxtInfo"):GetComponent(ty.Text)
    self.mImgStateSliderBg = self:getChildGO("mImgStateSliderBg"):GetComponent(ty.RectTransform)
    self.mImgStateSlider = self:getChildGO("mImgStateSlider"):GetComponent(ty.RectTransform)
    self.mTxtStateSlider = self:getChildGO("mTxtStateSlider"):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)

    self.mBuildMainItem = self:getChildGO("mBuildMainItem")
    self.mBuildChildItem = self:getChildGO("mBuildChildItem")

    self.mImgGuildIcon = self:getChildGO("mImgGuildIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtGuildName = self:getChildGO("mTxtGuildName"):GetComponent(ty.Text)
    self.mTxtGuildLv = self:getChildGO("mTxtGuildLv"):GetComponent(ty.Text)

    self.mStartInfo = self:getChildGO("mStartInfo")
    self.mTxtGuildCount = self:getChildGO("mTxtGuildCount"):GetComponent(ty.Text)
    self.mTxtGuildScore = self:getChildGO("mTxtGuildScore"):GetComponent(ty.Text)

    self.mImgSliderBg = self:getChildGO("mImgSliderBg"):GetComponent(ty.RectTransform)
    self.mImgSlider = self:getChildGO("mImgSlider"):GetComponent(ty.RectTransform)
    self.mTxtSlider = self:getChildGO("mTxtSlider"):GetComponent(ty.Text)

    self.mEnemyNull = self:getChildGO("mEnemyNull")
    self.mEnemyInfo = self:getChildGO("mEnemyInfo")
    self.mImgGuildIconEnemy = self:getChildGO("mImgGuildIconEnemy"):GetComponent(ty.AutoRefImage)
    self.mTxtGuildNameEnemy = self:getChildGO("mTxtGuildNameEnemy"):GetComponent(ty.Text)
    self.mTxtGuildLvEnemy = self:getChildGO("mTxtGuildLvEnemy"):GetComponent(ty.Text)

    self.mStartInfoEnemy = self:getChildGO("mStartInfoEnemy")
    self.mTxtGuildCountEnemy = self:getChildGO("mTxtGuildCountEnemy"):GetComponent(ty.Text)
    self.mTxtGuildScoreEnemy = self:getChildGO("mTxtGuildScoreEnemy"):GetComponent(ty.Text)

    self.mImgSliderBgEnemy = self:getChildGO("mImgSliderBgEnemy"):GetComponent(ty.RectTransform)
    self.mImgSliderEnemy = self:getChildGO("mImgSliderEnemy"):GetComponent(ty.RectTransform)
    self.mTxtSliderEnemy = self:getChildGO("mTxtSliderEnemy"):GetComponent(ty.Text)

    self.mBtnAtk = self:getChildGO("mBtnAtk")
    self.mBtnDef = self:getChildGO("mBtnDef")
    self.mBtnLog = self:getChildGO("mBtnLog")
    self.mBtnRank = self:getChildGO("mBtnRank")

    self.mBtnHero = self:getChildGO("mBtnHero")
    self.mBtnGuildLog = self:getChildGO("mBtnGuildLog")

    self.mBtnAuto = self:getChildGO("mBtnAuto")
    self.mTxtAuto = self:getChildGO("mTxtAuto"):GetComponent(ty.Text)

    self.mTxtGuildLog = self:getChildGO("mTxtGuildLog"):GetComponent(ty.Text)
    self.mTxtHero = self:getChildGO("mTxtHero"):GetComponent(ty.Text)
    self.mTxtLog = self:getChildGO("mTxtLog"):GetComponent(ty.Text)
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtDef = self:getChildGO("mTxtDef"):GetComponent(ty.Text)
    self.mTxtAtk = self:getChildGO("mTxtAtk"):GetComponent(ty.Text)

    self:setGuideTrans("functips_guild_info", self:getChildTrans("functips_guild_info"))
    self:setGuideTrans("functips_guild_auto", self.mBtnAuto.transform)
    self:setGuideTrans("functips_guild_guildLog", self.mBtnGuildLog.transform)
    self:setGuideTrans("functips_guild_hero", self.mBtnHero.transform)
    self:setGuideTrans("functips_guild_def", self.mBtnDef.transform)
    self:setGuideTrans("functips_guild_atk", self.mBtnAtk.transform)

    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")

    self.mTxtEnemyNull = self:getChildGO("mTxtEnemyNull"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTxtInfo.text = _TT(149164)
    self.mTxtTips.text = _TT(149165)
    self.mTxtAuto.text = _TT(149166)

    self.mTxtGuildLog.text = _TT(149150)
    self.mTxtHero.text = _TT(149181)
    self.mTxtLog.text = _TT(149162)
    self.mTxtRank.text = _TT(149120)
    self.mTxtDef.text = _TT(149189)
    self.mTxtAtk.text = _TT(149190)

    self.mTxtEnemyNull.text = _TT(149210)
end

-- 激活
function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_AUTO, self.showPanel, self)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_ENEMY_PANEL, self.updateInfo, self)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_STATE, self.showPanel, self)

    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_MAIN_PANEL, self.showPanel, self)

    MoneyManager:setMoneyTidList({})
    self:showPanel()
end
-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_AUTO, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_ENEMY_PANEL, self.updateInfo, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_STATE, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_MAIN_PANEL, self.showPanel, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    self:clearBuildItemList()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAtk, self.onBtnAtkClick)
    self:addUIEvent(self.mBtnDef, self.onBtnDefClick)
    self:addUIEvent(self.mBtnLog, self.onBtnLogClick)
    self:addUIEvent(self.mBtnHero, self.onBtnHeroClick)
    self:addUIEvent(self.mBtnRank, self.onBtnRankClick)
    self:addUIEvent(self.mBtnGuildLog, self.onBtnGuildLogClick)

    self:addUIEvent(self.mBtnAuto, self.onBtnAutoClick)
    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
end

-- 打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, {
        id = LinkCode.GuildWar
    })
end

function onBtnAutoClick(self)

    local startTime = sysParam.SysParamManager:getValue(SysParamType.GUILDWAR_OPEN_START_TIMER)
    local clientTime = GameManager:getClientTime()
    if startTime and startTime ~= 0 and clientTime < startTime then
        gs.Message.Show(_TT(149216))
        return
    end

    if guildWar.GetSelfCanOpt() == false then
        gs.Message.Show(_TT(149143))
        return
    end

    UIFactory:alertMessge(_TT(149205), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_AUTO)
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
end

function onBtnRankClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_RANK_PANEL)
end

function onBtnGuildLogClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_GUILD_LOG_PANEL)
end

function onBtnAtkClick(self)
    formation.openFormation(formation.TYPE.GUILDWARATK, nil, nil, nil)
end

function onBtnDefClick(self)
    if self.state == guildWar.GuildWarState.GuildWarSignUp or self.state ==
        guildWar.GuildWarState.GuildWarMatchAndSettle then
        formation.openFormation(formation.TYPE.GUILDWARDEF, nil, nil, nil)
    else
        gs.Message.Show(_TT(149191))
    end
end

function onBtnLogClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_ALL_LOG_PANEL)
end

function onBtnHeroClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_MEMBER_PANEL)
end

function showPanel(self)
    self:clearBuildItemList()
    self.state = guildWar.GuildWarManager:getGuildWarState()
    GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_CURRENT_DAY_LOG)

    if guild.GuildManager:getIsJoinGuildWar() and guildWar.GuildWarCanReqEnemy() then
        GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_ENEMY_PANEL)
        return
    else
        self:updateInfo()
    end
end

function updateInfo(self)
    self:clearBuildItemList()
    -- self.isJoin = guild.GuildManager:getIsJoinGuildWar()
    self.state = guildWar.GuildWarManager:getGuildWarState()
    self.mBtnAuto:SetActive(self.state == guildWar.GuildWarState.GuildWarSignUp)
    self.mTxtWarEndTime.gameObject:SetActive(self.state ~= guildWar.GuildWarState.GuildWarSignUp)
    self.mStartInfo:SetActive(false)
    self.mTxtTips.text = _TT(149209)
    if self.state == guildWar.GuildWarState.GuildWarSignUp then
        self.mStateNoInit:SetActive(true)
        self.mTxtTips.text = _TT(149165)
        self.mTxtStep.text = _TT(149167)
    elseif self.state == guildWar.GuildWarState.GuildWarSignFail then
        self.mStateNoInit:SetActive(true)
        self.mTxtTips.text = _TT(149165)
        self.mTxtStep.text = _TT(149168)
    elseif self.state == guildWar.GuildWarState.GuildWarMatch then
        self.mStateNoInit:SetActive(true)
        self.mTxtStep.text = _TT(149169)
    elseif self.state == guildWar.GuildWarState.GuildWarStart then
        self.mStateNoInit:SetActive(false)
        self.mTxtStep.text = _TT(149170)
        self.mStartInfo:SetActive(true)
    elseif self.state == guildWar.GuildWarState.GuildWarMatchAndSettle then
        self.mStateNoInit:SetActive(true)
        self.mTxtStep.text = _TT(149171)
    elseif self.state == guildWar.GuildWarState.GuildWarSettle then
        self.mStateNoInit:SetActive(true)
        self.mTxtStep.text = _TT(149172)
    end

    self.mTxtWarId.text = _TT(149173, guildWar.GuildWarManager:getGuildWarSeasonId())

    local url = guild.GuildManager:getIconDataById(guild.GuildManager:getGuildIconId()).icon
    self.mImgGuildIcon:SetImg(UrlManager:getIconPath(url), false)
    self.mTxtGuildName.text = guild.GuildManager:getGuildName()
    self.mTxtGuildLv.text = _TT(1361) .. guild.GuildManager:getGuildLv()

    self.membersList = guild.GuildManager:getGuildAllMembers() -- guild.GuildManager:getGuildInfo().members

    local needCount = sysParam.SysParamManager:getValue(SysParamType.GUILDWAR_NEED_TYPE1_COUNT) +
                          sysParam.SysParamManager:getValue(SysParamType.GUILDWAR_NEED_TYPE2_COUNT) +
                          sysParam.SysParamManager:getValue(SysParamType.GUILDWAR_NEED_TYPE3_COUNT)

    local hasBuildList, hasCount, allScore, remBuild, allBuild = self:getSimOptCount(self.membersList)
    local canFightMembers = guild.GuildManager:getGuildInfo().members
    local allCount = #canFightMembers * sysParam.SysParamManager:getValue(SysParamType.GUILDWAR_COUNT)

    self.mTxtGuildCount.text = _TT(149118, hasCount, allCount)
    self.mTxtGuildScore.text = _TT(149119, allScore)

    local needCountPro = gs.Mathf.Clamp(remBuild / allBuild, 0, 1)
    gs.TransQuick:SizeDelta01(self.mImgSlider, (self.mImgSliderBg.sizeDelta.x - 2) * needCountPro)
    self.mTxtSlider.text = remBuild .. "/" .. allBuild

    local needAllPro = gs.Mathf.Clamp(remBuild / needCount, 0, 1)
    self.mTxtStateSlider.text = remBuild .. "/" .. needCount
    gs.TransQuick:SizeDelta01(self.mImgStateSlider, (self.mImgStateSliderBg.sizeDelta.x - 2) * needAllPro)

    self:clearBuildItemList()
    self:showMemberInfo(self.membersList, hasBuildList, false)

    local enemyGuildPanel = guildWar.GuildWarManager:getGuildWarEnemyPanelInfo()

    if enemyGuildPanel ~= nil and self.state == guildWar.GuildWarState.GuildWarStart then
        local url = guild.GuildManager:getIconDataById(enemyGuildPanel.icon).icon
        self.mImgGuildIconEnemy:SetImg(UrlManager:getIconPath(url), false)

        self.mTxtGuildNameEnemy.text = enemyGuildPanel.name
        self.mTxtGuildLvEnemy.text = _TT(1361) .. enemyGuildPanel.lv

        local members = guildWar.GuildWarManager:getGuildWarEnemyAllMembers()

        local hasBuildList, hasCount, allScore, remBuild, allBuild = self:getSimOptCount(members)
        local canFightMembers = guildWar.GuildWarManager:getGuildWarEnemyPanelInfo().members
        local allCount = #canFightMembers * sysParam.SysParamManager:getValue(SysParamType.GUILDWAR_COUNT)

        self.mTxtGuildCountEnemy.text = _TT(149118, hasCount, allCount)
        self.mTxtGuildScoreEnemy.text = _TT(149119, allScore)

        local allBuildPro = gs.Mathf.Clamp(remBuild / allBuild, 0, 1)
        gs.TransQuick:SizeDelta01(self.mImgSliderEnemy, (self.mImgSliderBgEnemy.sizeDelta.x - 2) * allBuildPro)
        self.mTxtSliderEnemy.text = remBuild .. "/" .. allBuild
        self:showMemberInfo(members, hasBuildList, true)

        -- self.mStartInfo:SetActive(true)
        self.mEnemyNull:SetActive(false)
        self.mEnemyInfo:SetActive(true)
    else
        -- self.mStartInfo:SetActive(false)
        self.mEnemyNull:SetActive(true)
        self.mEnemyInfo:SetActive(false)
    end

    if self.mWarSn then
        LoopManager:removeTimerByIndex(self.mWarSn)
        self.mWarSn = nil
    end

    self:refreshWarTime()
    self.mWarSn = self:addTimer(1, 0, self.refreshWarTime)

    self:updateDefFormationRed()
end

function updateDefFormationRed(self)
    local isRed = guildWar.GuildWarManager:getGuildWarDefFormationRed()
    if isRed then
        RedPointManager:add(self.mBtnDef.transform, nil, 71, 18)
    else
        RedPointManager:remove(self.mBtnDef.transform)
    end
end

function getSimOptCount(self, memberList)
    local hasBuildList = {}
    local hasCount = 0
    local allScore = 0
    local allBuild = 0
    local remBuild = 0
    for i = 1, #memberList do
        hasCount = hasCount + memberList[i].build_info.challenge_times
        allScore = allScore + memberList[i].build_info.point
        allBuild = allBuild + (memberList[i].build_info.build_id > 0 and 1 or 0)
        remBuild = remBuild + (memberList[i].build_info.build_id > 0 and memberList[i].build_info.now_hp > 0 and 1 or 0)

        if memberList[i].build_info.build_id > 0 then
            table.insert(hasBuildList, memberList[i].build_info.build_id)
        end
    end

    return hasBuildList, hasCount, allScore, remBuild, allBuild
end

function showMemberInfo(self, memberList, hasBuildList, isEnemy)

    -- local hasBuildList, hasCount, allScore, remBuild, allBuild = self:getSimOptCount(memberList)

    local list = guildWar.GuildWarManager:getGuildWarBuildData()
    local regionList = {}
    local regionChildDic = {}
    for i = 1, #list do
        if table.indexof01(regionList, list[i].regionId) == 0 then
            table.insert(regionList, list[i].regionId)
        end

        if regionChildDic[list[i].regionId] == nil then
            regionChildDic[list[i].regionId] = {
                hasCount = 0,
                allCount = 1
            }
        else
            regionChildDic[list[i].regionId].allCount = regionChildDic[list[i].regionId].allCount + 1
        end
    end

    for i = 1, #hasBuildList do
        local buildVo = guildWar.GuildWarManager:getGuildWarBuildDataById(hasBuildList[i])
        local rem = self:getRemBuildInfo(buildVo.id, memberList)
        regionChildDic[buildVo.regionId].hasCount = regionChildDic[buildVo.regionId].hasCount + rem
    end

    for i = 1, #regionList do
        local id = regionList[i]

        local item = nil

        local posList = isEnemy == true and self.mBuildEnemyPos or self.mBuildPos

        local url = ""
        local effName = ""
        local hpState = guildWar.GetDefHPState()
        if guildWar.GuildWarNotHpInfo() == false then
            local nowAll, maxAll = self:getPosAllHpInfo(id, memberList)
            hpState = guildWar.GetBuildHPState(nowAll, maxAll)
        end

        if id == 1 then
            item = SimpleInsItem:create(self.mBuildMainItem, posList[id].transform, "mBuildMainItem")
            if isEnemy then
                url = "guildWar/build_main_0" .. hpState .. "_e.png"
                effName = "mEffect_0" .. hpState .. "_e"
            else
                url = "guildWar/build_main_0" .. hpState .. ".png"
                effName = "mEffect_0" .. hpState

                self:setGuideTrans("functips_guild_main_item", item:getChildTrans("mBuildCilck"))
            end
        else
            item = SimpleInsItem:create(self.mBuildChildItem, posList[id].transform, "mBuildChildItem")
            if isEnemy then
                url = "guildWar/build_0" .. hpState .. "_e.png"
                effName = "mEffect_0" .. hpState .. "_e"
            else
                url = "guildWar/build_0" .. hpState .. ".png"
                effName = "mEffect_0" .. hpState
            end
            self:setGuideTrans("functips_guild_child_item_" .. id, item:getChildTrans("mBuildCilck"))
        end

        for i = 1, 3 do
            item:getChildGO("mEffect_0" .. i):SetActive(false)
            item:getChildGO("mEffect_0" .. i .. "_e"):SetActive(false)
        end

        item:getChildGO(effName):SetActive(true)
        item:getChildGO("mImgBuild"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(url), false)
        item:getChildGO("mTxtBuildName"):GetComponent(ty.Text).text = guildWar.GuildWarGetBuildName(id)
        item:getChildGO("mTxtRem"):GetComponent(ty.Text).text =
            regionChildDic[id].hasCount .. "/" .. regionChildDic[id].allCount

        local tipsUrl = isEnemy and "guildWar/nameTips_e.png" or "guildWar/nameTips.png"
        item:getChildGO("mBuildNameBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(tipsUrl), false)

        local pro = 0
        if guildWar.GuildWarCanShowSlider() == false then
            item:getChildGO("mImgHpBg"):SetActive(false)
            pro = regionChildDic[id].hasCount / regionChildDic[id].allCount
        else
            local nowAll, maxAll = self:getPosAllHpInfo(id, memberList)
            item:getChildGO("mImgHpBg"):SetActive(true)
            pro = nowAll / maxAll
        end
        gs.TransQuick:SizeDelta01(item:getChildGO("mImgHp"):GetComponent(ty.RectTransform),
            (item:getChildGO("mImgHpBg"):GetComponent(ty.RectTransform).sizeDelta.x - 2) * pro)

        item:addUIEvent("mBuildCilck", function()
            if self.state == guildWar.GuildWarState.GuildWarSignFail then
                gs.Message.Show(_TT(149174))
                return
            else
                local startTime = sysParam.SysParamManager:getValue(SysParamType.GUILDWAR_OPEN_START_TIMER)
                local clientTime = GameManager:getClientTime()
                if startTime and startTime ~= 0 and clientTime < startTime then
                    gs.Message.Show(_TT(149216))
                    return
                end

                GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_CHILD_PANEL, {
                    posId = id,
                    isEnemy = isEnemy
                })
            end
        end)

        local isRed = guildWar.GuildWarManager:getNeedNumberCount(id) and isEnemy == false
        if isRed then
            RedPointManager:add(item:getChildTrans("mBuildNameBg"),nil,72.3,4.1)
        else
            RedPointManager:remove(item:getChildTrans("mBuildNameBg"))
        end
        
        table.insert(self.mBuildItemList, item)
    end
end

function getPosAllHpInfo(self, posId, list)
    if guildWar.GuildWarNotHpInfo() then
        return 100, 100
    end

    local buildVoList = guildWar.GuildWarManager:getBuildWardBuildDataListByRegionId(posId)

    local nowAll = 0
    local maxAll = 0
    for i = 1, #buildVoList do
        local buildId = buildVoList[i].id
        local nowHp, maxHp = self:getMemberInfoByList(buildId, list)
        nowAll = nowAll + nowHp
        maxAll = maxAll + maxHp
    end
    return nowAll, maxAll
end

function getMemberInfoByList(self, buildId, list)
    for i = 1, #list do
        if list[i].build_info.build_id == buildId then
            return list[i].build_info.now_hp, list[i].build_info.max_hp
        end
    end
    return 0, 0
end

function getRemBuildInfo(self, buildId, list)
    for i = 1, #list do
        if list[i].build_info.build_id == buildId then
            return list[i].build_info.now_hp > 0 and 1 or 0
        end
    end
    return 0
end

function refreshWarTime(self)
    local clientTime = GameManager:getClientTime()
    local nextStartTime = guildWar.GuildWarManager:getGuildWarNextStartTime()

    local endTime = guildWar.GuildWarManager:getGuildWarEndTime()
    local startTime = guildWar.GuildWarManager:getGuildStartTime()

    if self.state == guildWar.GuildWarState.GuildWarSignUp then
        self.mTxtWarTime.text = _TT(149175) .. TimeUtil.getNewRoleShowTime(nextStartTime - clientTime)
    elseif self.state == guildWar.GuildWarState.GuildWarSignFail then
        self.mTxtWarTime.text = _TT(149176) .. TimeUtil.getNewRoleShowTime(endTime - clientTime)
    elseif self.state == guildWar.GuildWarState.GuildWarMatch then
        self.mTxtWarTime.text = _TT(149177) .. TimeUtil.getNewRoleShowTime(nextStartTime - clientTime)
    elseif self.state == guildWar.GuildWarState.GuildWarStart then
        self.mTxtWarTime.text = _TT(149178) .. TimeUtil.getNewRoleShowTime(nextStartTime - clientTime)
    elseif self.state == guildWar.GuildWarState.GuildWarMatchAndSettle then
        self.mTxtWarTime.text = _TT(149179) .. TimeUtil.getNewRoleShowTime(nextStartTime - clientTime)
    elseif self.state == guildWar.GuildWarState.GuildWarSettle then
        self.mTxtWarTime.text = _TT(149180) .. TimeUtil.getNewRoleShowTime(nextStartTime - clientTime)
    end

    if clientTime < startTime then
        self.mTxtWarEndTime.text = _TT(94501) .. TimeUtil.getNewRoleShowTime(startTime - clientTime)
    else
        self.mTxtWarEndTime.text = _TT(149204) .. TimeUtil.getNewRoleShowTime(endTime - clientTime)
    end

end

function clearBuildItemList(self)
    for i = 1, #self.mBuildItemList do
        self.mBuildItemList[i]:poolRecover()
    end
    self.mBuildItemList = {}
end

return _M
