--[[ 
-----------------------------------------------------
@Description    : 联盟团战子建筑界面
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("guild.GuildWarChildPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarChildPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(149185))
    self:setSize(0, 0)
    -- self:setBg("guild_bg.jpg", false, "guild")
    -- self:setUICode(LinkCode.Guild)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mBuildItemList = {}
    self.mPlayerHeadList = {}
    self.mMembersItemList = {}

    self.mHeroGridList = {}

    self.mLogPlayerHeadList = {}
    self.mBattleItemList = {}

    self.mLogList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mPosInfo = self:getChildTrans("mPosInfo")

    self.mChildItem = self:getChildGO("mChildItem")
    self.mChildPos = {}
    for i = 1, 6 do
        table.insert(self.mChildPos, self:getChildGO("mChildPos" .. i))
    end

    self.mJoinInfo = self:getChildGO("mJoinInfo")
    self.mBtnHideJoinInfo = self:getChildGO("mBtnHideJoinInfo")
    self.mTxtMembersInfo = self:getChildGO("mTxtMembersInfo"):GetComponent(ty.Text)
    self.mMembersScroll = self:getChildGO("mMembersScroll"):GetComponent(ty.ScrollRect)
    self.mMemberItem = self:getChildGO("mMemberItem")

    self.mJoinInfo:SetActive(false)

    self.mEnemyInfo = self:getChildGO("mEnemyInfo")
    self.mBtnHideEnemyInfo = self:getChildGO("mBtnHideEnemyInfo")
    self.mTxtDefInfo = self:getChildGO("mTxtDefInfo"):GetComponent(ty.Text)
    self.mEnemyHeadPos = self:getChildTrans("mEnemyHeadPos")
    self.mTxtEnemyName = self:getChildGO("mTxtEnemyName"):GetComponent(ty.Text)
    self.mTxtEnemyLv = self:getChildGO("mTxtEnemyLv"):GetComponent(ty.Text)
    self.mTxtEnemyHP = self:getChildGO("mTxtEnemyHP"):GetComponent(ty.Text)
    self.mImgEnemyHpBg = self:getChildGO("mImgEnemyHpBg"):GetComponent(ty.RectTransform)
    self.mImgEnemyHp = self:getChildGO("mImgEnemyHp"):GetComponent(ty.RectTransform)

    self.mTxtEnemyWin = self:getChildGO("mTxtEnemyWin"):GetComponent(ty.Text)
    self.mTxtEnemyLose = self:getChildGO("mTxtEnemyLose"):GetComponent(ty.Text)
    self.mTxtEnemyDraw = self:getChildGO("mTxtEnemyDraw"):GetComponent(ty.Text)

    self.mTxtDef1 = self:getChildGO("mTxtDef1"):GetComponent(ty.Text)
    self.mTxtDef2 = self:getChildGO("mTxtDef2"):GetComponent(ty.Text)

    self.mEnemyHeroContent1 = self:getChildTrans("mEnemyHeroContent1")
    self.mEnemyHeroContent2 = self:getChildTrans("mEnemyHeroContent2")

    self.mTxtEnemyLog = self:getChildGO("mTxtEnemyLog"):GetComponent(ty.Text)

    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mTxtFight = self:getChildGO("mTxtFight"):GetComponent(ty.Text)
    self.mTxtFightCount = self:getChildGO("mTxtFightCount"):GetComponent(ty.Text)

    self.mBtnFightLogItem = self:getChildGO("mBtnFightLogItem")
    self.mLogScroll = self:getChildGO("mLogScroll"):GetComponent(ty.ScrollRect)
    self.mLogItem = self:getChildGO("mLogItem")

    self.mEnemyInfo:SetActive(false)
end

function initViewText(self)
    self.mTxtDefInfo.text = _TT(149136)
    self.mTxtDef1.text =  _TT(149137)
    self.mTxtDef2.text =  _TT(149138)
    self.mTxtEnemyLog.text =  _TT(149139)
    self.mTxtFight.text =  _TT(149140)
end

-- 激活
function active(self, args)
    super.active(self, args)

    self.regionId = args.posId
    self.isEnemy = args.isEnemy
    self.lastShowBuild = args.lastShowBuild and args.lastShowBuild or 0

    local isRep = guildWar.GuildWarManager:getIsRep()
    if self.isReshow then
        self.lastShowBuild,self.playerId,self.enemyFormation = guildWar.GuildWarManager:getLastShowBuildIdAndPlayerId()
        if isRep then
            
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_FIGHT_INFO_PANEL,{
                playerId =self.playerId,
                buildId = self.lastShowBuild,
                enemyFormation = self.enemyFormation
            })
        end
    end

    local url = ""
    if self.isEnemy then
        url = "guildWar/bg_05.jpg"
    else
        url = "guildWar/bg_04.jpg"
    end

    self.mImgBg:SetImg(UrlManager:getBgPath(url), false)
    self:getChildGO("mEffect_01"):SetActive(not self.isEnemy)
    self:getChildGO("mEffect_01_e"):SetActive(self.isEnemy)

    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_ENEMY_PANEL, self.showPanel, self)
    
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_MAIN_PANEL, self.showPanel, self)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_SINGUP, self.showPanel, self)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_ENEMY_PLAYER_INFO, self.updateEnemyFormation, self)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_BATTLE_LOG, self.updateLogInfo, self)
    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_STATE, self.updateState, self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_ENEMY_PANEL, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_MAIN_PANEL, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_SINGUP, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_ENEMY_PLAYER_INFO, self.updateEnemyFormation, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_BATTLE_LOG, self.updateLogInfo, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_STATE, self.updateState, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    self:clearPlayerHeadList()
    self:clearMembersItemList()
    self:clearBuildItemList()
    self:clearHeroGridList()
    self:clearBattleItemList()
    self:clearLogPlayerHeadList()
end

function updateState(self)
    gs.Message.Show(_TT(149141))
    self:close()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnHideJoinInfo, self.onBtnHideJoinInfoClick)
    self:addUIEvent(self.mBtnHideEnemyInfo, self.onBtnHideEnemyInfoClick)

    self:addUIEvent(self.mBtnFight, self.onBtnFightClick)
end

function onBtnHideJoinInfoClick(self)
    self.lastShowBuild = 0
    self.mJoinInfo:SetActive(false)
    self:hideAni()
end

function onBtnHideEnemyInfoClick(self)
    self:clearBattleItemList()
    self:clearHeroGridList()
    self:clearLogPlayerHeadList()

    self.lastShowBuild = 0
    self.mEnemyInfo:SetActive(false)
    self:hideAni()
end

function showPanel(self)
    cusLog("刷新了子界面")

    self.canSignUp = guildWar.guildWarCanSignUp()
    self.canShowEnemy = guildWar.GuildWarCanReqEnemy()
    self.canShowSlider = guildWar.GuildWarCanShowSlider()

    self.membersList = guild.GuildManager:getGuildAllMembers() -- guild.GuildManager:getGuildInfo().members
    if self.isEnemy then
        self.membersList = guildWar.GuildWarManager:getGuildWarEnemyAllMembers()
    end
    self:clearBuildItemList()
    local buildVoList = guildWar.GuildWarManager:getBuildWardBuildDataListByRegionId(self.regionId)
    for i = 1, #buildVoList do
        local item = SimpleInsItem:create(self.mChildItem, self.mChildPos[i].transform, "mChildItem")

        local hpState = guildWar.GetDefHPState()

        local y = 90
        if buildVoList[i].type == 1 then
            y = 185
        elseif buildVoList[i].type == 2 then
            y = 110
        end
        gs.TransQuick:UIPos(item:getChildTrans("mImgHpBg"), 0, y)

        local hasMenber = self:getBuildHasMember(buildVoList[i].id)
        item:getChildGO("mMemberInfo"):SetActive(hasMenber)
        item:getChildGO("mBtnJoin"):SetActive(not hasMenber and not self.isEnemy)

        if hasMenber then
            local member = self:getMemberInfo(buildVoList[i].id)

            local pro = 0
            if self.canShowSlider then
                pro = member.build_info.now_hp / member.build_info.max_hp
            else
                pro = 1
            end

            if guildWar.GuildWarNotHpInfo() == false then
                hpState = guildWar.GetBuildHPState(member.build_info.now_hp, member.build_info.max_hp)
            end

            gs.TransQuick:SizeDelta01(item:getChildGO("mImgHp"):GetComponent(ty.RectTransform), (item:getChildGO(
                "mImgHpBg"):GetComponent(ty.RectTransform).sizeDelta.x - 2) * pro)
            item:getChildGO("mImgHpBg"):SetActive(true)

            local headConfigVo = decorate.DecorateManager:getPlayerHeadConfigVo(member.avatar_id)
            local iconSource = ""
            if (headConfigVo) then
                -- 目前都一样
                if (headConfigVo:getUnlockType() == decorate.HeadUnlockType.DEFAULT_UNLICK) then
                    iconSource = UrlManager:getIconPath(headConfigVo:getIcon())
                elseif (headConfigVo:getUnlockType() == decorate.HeadUnlockType.PROPS_UNLOCK) then
                    iconSource = UrlManager:getIconPath(headConfigVo:getIcon())
                elseif (headConfigVo:getUnlockType() == decorate.HeadUnlockType.HERO_UNLOCK) then
                    iconSource = UrlManager:getIconPath(headConfigVo:getIcon())
                elseif (headConfigVo:getUnlockType() == decorate.HeadUnlockType.HERO_FASHION_UNLOCK) then
                    iconSource = UrlManager:getIconPath(headConfigVo:getIcon())
                end
            end

            item:getChildGO("mImgMemberHead"):GetComponent(ty.AutoRefImage):SetImg(iconSource, false)
            item:getChildGO("mTxtMemberName"):GetComponent(ty.Text).text = member.player_name
            item:getChildGO("mMemberInfo"):SetActive(true)
        else
            item:getChildGO("mMemberInfo"):SetActive(false)

            item:getChildGO("mImgHpBg"):SetActive(false)
        end

        local url = self.isEnemy and "guildWar/child_type" .. buildVoList[i].type .. "_0" .. hpState .. "_e.png" or
                        "guildWar/child_type" .. buildVoList[i].type .. "_0" .. hpState .. ".png"

        for i = 1, 3 do
            for j = 1, 3 do
                local effName = "mEffect_"..i .."_0"..j
                local effNameE = "mEffect_"..i .."_0"..j.."_e"
                item:getChildGO(effName):SetActive(false)
                item:getChildGO(effNameE):SetActive(false)
            end
        end
        
        local effName = self.isEnemy and "mEffect_"..buildVoList[i].type .."_0"..hpState.."_e" or "mEffect_"..buildVoList[i].type.."_0"..hpState
        item:getChildGO(effName):SetActive(true)

        item:getChildGO("mImgBuildIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(url, true))
        gs.TransQuick:UIPos(item:getChildTrans("mImgBuildIcon"), 0, buildVoList[i].type == 3 and 0 or 35)

        item:addUIEvent("mBtnClick", function()
            if self.canShowEnemy then
                self.lastShowBuild = buildVoList[i].id
                self.mEnemyInfo:SetActive(true)
                self:updateFightingInfo()
            elseif self.canSignUp then
                self.lastShowBuild = buildVoList[i].id
                self.mJoinInfo:SetActive(true)
                self:updateSingUpInfo()
            else
                gs.Message.Show(_TT(149142))
                return
            end

            self:moveAni(i, self.canSignUp)

        end)
        table.insert(self.mBuildItemList, {item = item,id = buildVoList[i].id ,index = i})
    end
    local allFightCount = sysParam.SysParamManager:getValue(SysParamType.GUILDWAR_COUNT)
    self.mTxtFightCount.text = guildWar.GuildWarManager:getSelfPlayChallengeTimes() .. "/"..allFightCount

    self.mBtnFight:SetActive(self.isEnemy)

    if self.lastShowBuild ~= 0 then
        if self.canShowEnemy then
            self.mEnemyInfo:SetActive(true)
            self:updateFightingInfo()
        else
            self.mJoinInfo:SetActive(true)
            self:updateSingUpInfo()
        end

        local index = 0
        for i = 1,#self.mBuildItemList do
            if self.mBuildItemList[i].id == self.lastShowBuild then
                index = self.mBuildItemList[i].index
            end
        end
        self:moveAni(index, self.canSignUp)
        --self.mBuildItemList
    end
    self:updateBuildItemShow()
    --self:hideAni()
end

function moveAni(self, index, canSignUp)
    local trans = self.mChildPos[index].transform
    local w, h = ScreenUtil:getScreenSize(nil)
    local point = -w / 20 * 7 + 232
    if canSignUp then
        point = point - 200
    end

    TweenFactory:move2LPosX(self.mPosInfo, canSignUp and point - trans.localPosition.x or point - trans.localPosition.x,
        0.2)
    TweenFactory:move2LPosY(self.mPosInfo, -trans.localPosition.y, 0.2)

   self:updateBuildItemShow()
end

function updateBuildItemShow(self)
    for i = 1,#self.mBuildItemList do
        if self.lastShowBuild == 0 then
            self.mBuildItemList[i].item.m_go:SetActive(true) 
        else
            self.mBuildItemList[i].item.m_go:SetActive(self.mBuildItemList[i].id == self.lastShowBuild) 
        end
        
    end
end

function hideAni(self)
    TweenFactory:move2LPosX(self.mPosInfo, 0, 0.2)
    TweenFactory:move2LPosY(self.mPosInfo, 0, 0.2)

    self:updateBuildItemShow()
end

function updateSingUpInfo(self)
    self:clearPlayerHeadList()
    self:clearMembersItemList()

    local hasBuildCount = 0

    for i = 1, #self.membersList do
        if self.membersList[i].build_info.build_id > 0 then
            hasBuildCount = hasBuildCount + 1
        end
    end

    local curMem = {}
    local remMem = {}
    for i = 1, #self.membersList do
        if self.membersList[i].build_info.build_id == self.lastShowBuild then
            table.insert(curMem, self.membersList[i])
        else
            table.insert(remMem, self.membersList[i])
        end
    end
    
    table.sort(remMem,function (vo1,vo2)
        return vo1.build_info.build_id < vo2.build_info.build_id
    end)

    for i = 1,#remMem do
        table.insert(curMem, remMem[i])
    end

    self.membersList = curMem

    local allFightCount = sysParam.SysParamManager:getValue(SysParamType.GUILDWAR_COUNT)

   
    for i = 1, #self.membersList do
        local battleList = self.membersList[i].build_info.battle_result

        local item = SimpleInsItem:create(self.mMemberItem, self.mMembersScroll.content, "mMemberItem")
        local playerHead = PlayerHeadGrid:poolGet()
        playerHead:setData(self.membersList[i].avatar_id)
        playerHead:setHeadFrame(self.membersList[i].avatar_frame_id)
        playerHead:setParent(item:getChildTrans("mHeadPos"))
        table.insert(self.mPlayerHeadList, playerHead)

        local buildId = self.membersList[i].build_info.build_id
        if buildId == 0 then

            item:getChildGO("mIconBuild"):SetActive(false)
            item:getChildGO("mImgHpBg"):SetActive(false)
        else
            local buildVo = guildWar.GuildWarManager:getGuildWarBuildDataById(buildId)
            item:getChildGO("mIconBuild"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
                "guildWar/child_min_type_" .. buildVo.type .. ".png", false))
            item:getChildGO("mIconBuild"):SetActive(true)
            local pro = 0
            if self.canShowSlider then
                pro = self.membersList[i].build_info.now_hp / self.membersList[i].build_info.max_hp
            else
                pro = 1
            end

            gs.TransQuick:SizeDelta01(item:getChildGO("mImgHp"):GetComponent(ty.RectTransform), (item:getChildGO(
                "mImgHpBg"):GetComponent(ty.RectTransform).sizeDelta.x - 2) * pro)
            item:getChildGO("mImgHpBg"):SetActive(true)
        end

        if buildId == self.lastShowBuild then
            item:getChildGO("mBtnFall"):SetActive(true)
            item:getChildGO("mBtnJoin"):SetActive(false)
        else
            item:getChildGO("mBtnFall"):SetActive(false)
            item:getChildGO("mBtnJoin"):SetActive(true)
        end

        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = self.membersList[i].player_name
        item:getChildGO("mTxtLv"):GetComponent(ty.Text).text = _TT(1361).. self.membersList[i].player_lv
        item:getChildGO("mTxtPoint"):GetComponent(ty.Text).text = _TT(149107) ..
                                                                      self.membersList[i].build_info.point
        item:getChildGO("mTxtWin"):GetComponent(ty.Text).text = _TT(149108) ..
                                                                    self:getBattleResultTimes(battleList,
                guildWar.BattleType.ATK_WIN)
        item:getChildGO("mTxtLose"):GetComponent(ty.Text).text =_TT(149109) ..
                                                                     self:getBattleResultTimes(battleList,
                guildWar.BattleType.ATK_LOSE)
        item:getChildGO("mTxtDraw"):GetComponent(ty.Text).text = _TT(149110)..
                                                                     self:getBattleResultTimes(battleList,
                guildWar.BattleType.ATK_DRAW)
        item:getChildGO("mTxtCount"):GetComponent(ty.Text).text = self.membersList[i].build_info.challenge_times .. "/".. allFightCount

        item:getChildGO("mTxtFall"):GetComponent(ty.Text).text = _TT(149111)
        item:getChildGO("mTxtJoin"):GetComponent(ty.Text).text =  _TT(149112)
        item:getChildGO("mTxtInfo"):GetComponent(ty.Text).text =  _TT(149113)

        gs.TransQuick:SizeDelta01(item.m_go:GetComponent(ty.RectTransform), self.mMembersScroll.content.rect.width )

        local sign_up_info = {}
        item:addUIEvent("mBtnFall", function()
            if guildWar.GetSelfCanOpt() == false then
                gs.Message.Show(_TT(149143))
                return
            end

            UIFactory:alertMessge(_TT(149206), true, function()
                table.insert(sign_up_info, {
                    player_id = self.membersList[i].player_id,
                    build_id = 0
                })
                GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_SINGUP, {
                    info = sign_up_info
                })
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil,RemindConst.GUILDWAR_FALL)
        end)
        item:addUIEvent("mBtnJoin", function()
            if guildWar.GetSelfCanOpt() == false then
                gs.Message.Show(_TT(149143))
                return
            end

            if self.membersList[i].is_robot == 1 then
                gs.Message.Show(_TT(149215))
                return
            end

            local function joinCall()
                table.insert(sign_up_info, {
                    player_id = self.membersList[i].player_id,
                    build_id = self.lastShowBuild
                })
                GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_SINGUP, {
                    info = sign_up_info
                })
            end
            if buildId>0 then
                UIFactory:alertMessge(_TT(149207), true, function()
                    joinCall()
                end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil,RemindConst.GUILDWAR_CHANGE)
            else
                joinCall()
            end
        end)
        item:addUIEvent("mBtnInfo", function()
            guildWar.GuildWarManager:setLastClickPlayerIdAndState(self.membersList[i].player_id, self.isEnemy)

            GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_PLAYER_INFO, {
                playerId = self.membersList[i].player_id
            })
        end)
        table.insert(self.mMembersItemList, item)
    end

    local robotVo = guildWar.GuildWarManager:getGuildWarRobotDataByBuildId(self.lastShowBuild)
    local robotIsJoin = guild.GuildManager:getGuildRobotHas(self.lastShowBuild)
    
    if robotVo and robotIsJoin == false then
        local item = SimpleInsItem:create(self.mMemberItem, self.mMembersScroll.content, "mMemberItem")
        local playerHead = PlayerHeadGrid:poolGet()
        playerHead:setData(robotVo.avatarId)
        playerHead:setHeadFrame(robotVo.avatarFrameId)
        playerHead:setParent(item:getChildTrans("mHeadPos"))
        table.insert(self.mPlayerHeadList, playerHead)

        local buildId = 0 --robotVo.buildId
        --if buildId == 0 then
            item:getChildGO("mIconBuild"):SetActive(false)
            item:getChildGO("mImgHpBg"):SetActive(false)
        -- else
        --     local buildVo = guildWar.GuildWarManager:getGuildWarBuildDataById(buildId)
        --     item:getChildGO("mIconBuild"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
        --         "guildWar/child_min_type_" .. buildVo.type .. ".png", false))
        --     item:getChildGO("mIconBuild"):SetActive(true)
        --     local pro = 0
        --     if self.canShowSlider then
        --         pro = self.membersList[i].build_info.now_hp / self.membersList[i].build_info.max_hp
        --     else
        --         pro = 1
        --     end

        --     gs.TransQuick:SizeDelta01(item:getChildGO("mImgHp"):GetComponent(ty.RectTransform), (item:getChildGO(
        --         "mImgHpBg"):GetComponent(ty.RectTransform).sizeDelta.x - 2) * pro)
        --     item:getChildGO("mImgHpBg"):SetActive(true)
        -- end

        if buildId == self.lastShowBuild then
            item:getChildGO("mBtnFall"):SetActive(true)
            item:getChildGO("mBtnJoin"):SetActive(false)
        else
            item:getChildGO("mBtnFall"):SetActive(false)
            item:getChildGO("mBtnJoin"):SetActive(true)
        end

        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(robotVo.playerName)
        item:getChildGO("mTxtLv"):GetComponent(ty.Text).text = _TT(1361).. robotVo.playerLv
        -- item:getChildGO("mTxtPoint"):GetComponent(ty.Text).text = _TT(149107) ..
        --                                                               self.membersList[i].build_info.point
        -- item:getChildGO("mTxtWin"):GetComponent(ty.Text).text = _TT(149108) ..
        --                                                             self:getBattleResultTimes(battleList,
        --         guildWar.BattleType.ATK_WIN)
        -- item:getChildGO("mTxtLose"):GetComponent(ty.Text).text =_TT(149109) ..
        --                                                              self:getBattleResultTimes(battleList,
        --         guildWar.BattleType.ATK_LOSE)
        -- item:getChildGO("mTxtDraw"):GetComponent(ty.Text).text = _TT(149110)..
        --                                                              self:getBattleResultTimes(battleList,
        --         guildWar.BattleType.ATK_DRAW)
        -- item:getChildGO("mTxtCount"):GetComponent(ty.Text).text = self.membersList[i].build_info.challenge_times .. "/".. allFightCount

        item:getChildGO("mTxtFall"):GetComponent(ty.Text).text = _TT(149111)
        item:getChildGO("mTxtJoin"):GetComponent(ty.Text).text =  _TT(149112)
        item:getChildGO("mTxtInfo"):GetComponent(ty.Text).text =  _TT(149113)

        gs.TransQuick:SizeDelta01(item.m_go:GetComponent(ty.RectTransform), self.mMembersScroll.content.rect.width )

        local sign_up_info = {}
        item:addUIEvent("mBtnFall", function()
            if guildWar.GetSelfCanOpt() == false then
                gs.Message.Show(_TT(149143))
                return
            end

            UIFactory:alertMessge(_TT(149206), true, function()
                table.insert(sign_up_info, {
                    player_id = tostring(robotVo.id),
                    build_id = 0
                })
                GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_SINGUP, {
                    info = sign_up_info
                })
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil,RemindConst.GUILDWAR_FALL)
        end)
        item:addUIEvent("mBtnJoin", function()
            if guildWar.GetSelfCanOpt() == false then
                gs.Message.Show(_TT(149143))
                return
            end

            local function joinCall()
                table.insert(sign_up_info, {
                    player_id = tostring(robotVo.id),
                    build_id = self.lastShowBuild
                })
                GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_SINGUP, {
                    info = sign_up_info
                })
            end
            if buildId>0 then
                UIFactory:alertMessge(_TT(149207), true, function()
                    joinCall()
                end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil,RemindConst.GUILDWAR_CHANGE)
            else
                joinCall()
            end
        end)
        item:addUIEvent("mBtnInfo", function()
            guildWar.GuildWarManager:setLastClickPlayerIdAndState( robotVo.id, self.isEnemy)

            GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_PLAYER_INFO, {
                playerId =  tostring(robotVo.id)
            })
        end)
        table.insert(self.mMembersItemList, item)
    end

    local needCount = sysParam.SysParamManager:getValue(SysParamType.GUILDWAR_NEED_TYPE1_COUNT) +
    sysParam.SysParamManager:getValue(SysParamType.GUILDWAR_NEED_TYPE2_COUNT) +
    sysParam.SysParamManager:getValue(SysParamType.GUILDWAR_NEED_TYPE3_COUNT) 

    self.mTxtMembersInfo.text = _TT(149144,hasBuildCount,needCount)
end

function updateFightingInfo(self)
    self:clearPlayerHeadList()

    local member = self:getMemberInfo(self.lastShowBuild)
    if member == nil then
        gs.Message.Show("当前建筑不存在数据 现实不存在的情况 可忽略")
        --cusLog("数据不存在==================== 现实不存在的情况 可忽略")
        return
    end

    self.mTxtEnemyName.text = member.player_name
    self.mTxtEnemyLv.text = _TT(1361) .. member.player_lv

    local playerHead = PlayerHeadGrid:poolGet()
    playerHead:setData(member.avatar_id)
    playerHead:setHeadFrame(member.avatar_frame_id)
    playerHead:setParent(self.mEnemyHeadPos)
    table.insert(self.mPlayerHeadList, playerHead)

    self.mTxtEnemyHP.text = member.build_info.now_hp .. "/" .. member.build_info.max_hp
    gs.TransQuick:SizeDelta01(self.mImgEnemyHp, (self.mImgEnemyHpBg.sizeDelta.x - 2) * member.build_info.now_hp /
        member.build_info.max_hp)

    local battleList = member.build_info.battle_result
    self.mTxtEnemyWin.text = self:getBattleResultTimes(battleList, guildWar.BattleType.DEF_WIN) .. _TT(149145)
    self.mTxtEnemyLose.text = self:getBattleResultTimes(battleList, guildWar.BattleType.DEF_LOSE) .. _TT(149146)
    self.mTxtEnemyDraw.text = self:getBattleResultTimes(battleList, guildWar.BattleType.DEF_DRAW) .. _TT(149147)

    guildWar.GuildWarManager:setLastClickPlayerIdAndState(member.player_id, self.canShowEnemy)
    GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_PLAYER_INFO, {
        playerId = member.player_id
    })

    local isAtk = self.isEnemy and 1 or 0

    GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_BATTLE_LOG, {
        buildId = self.lastShowBuild,
        page = {1, 5},
        isAtk = isAtk
    })
end

function onBtnFightClick(self)

    -- if guildWar.GuildWarManager:getGuildWarAtkFormatioNot() then
    --     gs.Message.Show(_TT(149148))
    --     return
    -- end

    if guildWar.GuildWarManager:getSelfPlayChallengeTimes() <=0 then
        gs.Message.Show(_TT(149149))
        return
    end
    local member = self:getMemberInfo(self.lastShowBuild)
    local function reaFightCall()
        if self.isEnemy and member then
            local canFight = false
            if self.lastShowBuild == 1 then
                local needPro = sysParam.SysParamManager:getValue(SysParamType.GUILDFIGHT_NEED_PRO) / 100
                local members = guildWar.GuildWarManager:getGuildWarEnemyAllMembers()
    
                for i = 2, 4 do
                    local nowAll = 0
                    local maxAll = 0
                    local buildVoList = guildWar.GuildWarManager:getBuildWardBuildDataListByRegionId(i)
                    for j = 1, #buildVoList do
                        local nowHp, maxHp = self:getMemberInfoByList(buildVoList[j].id, members)
                        nowAll = nowAll + nowHp
                        maxAll = maxAll + maxHp
                    end
    
                    if nowAll / maxAll < needPro then
                        canFight = true
                        break
                    end
                end
            else
                canFight = true
            end
    
            if canFight then
                guildWar.GuildWarManager:setLastShowBuildIdAndPlayerId(self.lastShowBuild, member.player_id,self.enemyFormation)
                GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_FIGHT_INFO_PANEL,{
                    playerId = member.player_id,
                    buildId = self.lastShowBuild,
                    enemyFormation = self.enemyFormation
                })
            else
                gs.Message.Show(_TT(149114))
            end
        end
    end
    
    --血量为零时挑战提示
    if member.build_info.now_hp == 0 then
        UIFactory:alertMessge(_TT(149194), true, function()
            reaFightCall()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
    else
        reaFightCall()
    end
   
   
end

function getMemberInfoByList(self, buildId, list)
    for i = 1, #list do
        if list[i].build_info.build_id == buildId then
            return list[i].build_info.now_hp, list[i].build_info.max_hp
        end
    end
    return 0, 0
end

function updateEnemyFormation(self, args)

    self:clearHeroGridList()
    local defFormationList = args.formation
    table.sort(defFormationList, function(vo1, vo2)
        return vo1.team_id < vo2.team_id
    end)

    for i = 1, #defFormationList do
        local heroList = defFormationList[i].hero_list
        for j = 1, #heroList do
            local grid = HeroHeadGrid:poolGet()
            grid:setData(hero.HeroManager:getHeroConfigVo(heroList[j].tid))
            grid:setScale(0.5)
            grid:setStarLvl(heroList[j].evolution)
            grid:setLvl(heroList[j].lv)
            local tran = i == 1 and self.mEnemyHeroContent1 or self.mEnemyHeroContent2
            grid:setParent(tran)
            table.insert(self.mHeroGridList, grid)
        end
    end
    self.enemyFormation = defFormationList
end

function updateLogInfo(self, args)
    self.logList = args.logList
    self.logNum = args.logNum

    self:clearBattleItemList()
    self:clearLogPlayerHeadList()
    self:clearLogList()

    for i = 1, #self.logList do
        local item = SimpleInsItem:create(self.mLogItem, self.mLogScroll.content, "mLogItem")
        local playerHead = PlayerHeadGrid:poolGet()
        playerHead:setData(self.logList[i].atk_avatar)
        playerHead:setHeadFrame(self.logList[i].atk_avatar_frame)
        playerHead:setParent(item:getChildTrans("mLogHeadPos"))

        item:getChildGO("mTxtLogName"):GetComponent(ty.Text).text = self.logList[i].atk_name
        item:getChildGO("mTxtLogLv"):GetComponent(ty.Text).text = _TT(1361) .. self.logList[i].atk_lv
        item:getChildGO("mTxtLogTime"):GetComponent(ty.Text).text =
            TimeUtil.getFormatTimeBySeconds_13(self.logList[i].time)
        item:getChildGO("mTxtLogFight"):GetComponent(ty.Text).text = guildWar.GetBattleString(self.logList[i].result)

        for j = 1, #self.logList[i].team_list do
            local fightItem = SimpleInsItem:create(self.mBtnFightLogItem, item:getChildTrans("mLogFightContent"),
                "mBtnFightLogItemChild")
            local url = ""

            url = "guildWar/battle_pre_" .. self.logList[i].team_list[j].result .. ".png"
            fightItem:getChildGO("mBtnIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(url), false)

            fightItem:addUIEvent("mBtnIcon", function()
                guildWar.GuildWarManager:setLastShowBuildIdAndPlayerId(self.lastShowBuild, 0,{})
                GameDispatcher:dispatchEvent(EventName.OPEN_GUILD_WAR_FIGHT_RESULT_INFO_PANEL,{log = self.logList[i]})
                -- if self.logList[i].team_list[j].can_replay == 1 then
                --     UIFactory:alertMessge(_TT(178), true, function()
                --         if self.logList[i].battle_id ~= 0 then
                --             fight.FightManager:reqReplay(PreFightBattleType.GuildWar, self.logList[i].battle_id,
                --                 self.logList[i].team_list[j].team_id)
                --         else
                --             gs.Message.Show(_TT(179))
                --         end
                --     end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.GUILDWAR_REPLAY)
                -- end
            end)
            table.insert(self.mBattleItemList, fightItem)
        end

        table.insert(self.mLogPlayerHeadList, playerHead)

        table.insert(self.mLogList, item)
    end
end

function clearLogList(self)
    for i = 1, #self.mLogList do
        self.mLogList[i]:poolRecover()
    end
    self.mLogList = {}
end

function clearBattleItemList(self)
    for i = 1, #self.mBattleItemList do
        self.mBattleItemList[i]:poolRecover()
    end
    self.mBattleItemList = {}
end

function getBattleResultTimes(self, list, result)
    for i = 1, #list do
        if list[i].result == result then
            return list[i].times
        end
    end
    return 0
end

function clearLogPlayerHeadList(self)
    for i = 1, #self.mLogPlayerHeadList do
        self.mLogPlayerHeadList[i]:poolRecover()
    end
    self.mLogPlayerHeadList = {}
end

function clearPlayerHeadList(self)
    for i = 1, #self.mPlayerHeadList do
        self.mPlayerHeadList[i]:poolRecover()
    end
    self.mPlayerHeadList = {}
end

function clearMembersItemList(self)
    for i = 1, #self.mMembersItemList do
        self.mMembersItemList[i]:poolRecover()
    end
    self.mMembersItemList = {}
end

function getBuildHasMember(self, buildId)
    for i = 1, #self.membersList do
        if self.membersList[i].build_info.build_id == buildId then
            return true
        end
    end
    return false
end

function getMemberInfo(self, buildId)
    for i = 1, #self.membersList do
        if self.membersList[i].build_info.build_id == buildId then
            return self.membersList[i]
        end
    end
    return nil
end

function clearHeroGridList(self)
    for i = 1, #self.mHeroGridList do
        self.mHeroGridList[i]:poolRecover()
    end
    self.mHeroGridList = {}
end

function clearBuildItemList(self)
    for i = 1, #self.mBuildItemList do
        self.mBuildItemList[i].item:poolRecover()
    end
    self.mBuildItemList = {}
end

return _M
