module("arenaHall.arena.view.ArenaLogAttackTabView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("arenaHall/arena/ArenaLogTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mItemDic = {}
    self.mFlagDic = {}
    self.mHeadDic = {}
    self.mTeamDic = {}
    self.onValueChanged = false
    self.charIndex = 0
    self.charIndex2 = 20
    self.tweenTimeSn = {}
end

function configUI(self)
    super.configUI(self)
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mImgHanlde = self.m_childGos["Handle"]:GetComponent(ty.CanvasGroup)
    self.mImgHanlde.alpha = 0
    self.mUIMouseEvent = self:getChildGO("Scroll View"):GetComponent(ty.LongPressOrClickEventTrigger)
    self.mEmptyHero = self:getChildGO("mEmptyHero")
    self.mUIMouseEvent.onBeginDrag:AddListener(function()
        self:OnMouseEnter()
    end)
    self.mUIMouseEvent.onEndDrag:AddListener(function()
        self:OnMouseOut()
    end)
end

function OnMouseEnter(self)
    self.mSn = LoopManager:addTimer(0, -1, self, function()
        self.charIndex = self.charIndex + 1
        if self.charIndex <= 20 then
            self.mImgHanlde.alpha = self.charIndex / 20
        else
            if self.mSn then
                LoopManager:removeTimerByIndex(self.mSn)
                self.mSn = nil
                self.charIndex = 1
            end
        end
    end)
end

function OnMouseOut(self)
    self.mSn2 = LoopManager:addTimer(0, -1, self, function()
        self.charIndex2 = self.charIndex2 - 1
        if self.charIndex2 >= 0 then
            self.mImgHanlde.alpha = self.charIndex2 / 20
        else
            if self.mSn2 then
                LoopManager:removeTimerByIndex(self.mSn2)
                self.mSn2 = nil
                self.charIndex2 = 20
            end
        end
    end)
end

function active(self)
    super.active(self)
    self.charIndex = 0
    self.charIndex2 = 20
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.SERVER_BATTLEREPLAY_RES, self.onOpenFightDataPre, self)
    -- 请求竞技场日志
    self.m_childGos["Content"]:GetComponent(ty.RectTransform).localPosition = gs.VEC3_ZERO

    arena.ArenaManager.IsSelfAttack = self.getOpenType() == arena.TabViewType.TypeAttack
    
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    self.mUIMouseEvent.onBeginDrag:RemoveAllListeners()
    self.mUIMouseEvent.onEndDrag:RemoveAllListeners()
    GameDispatcher:removeEventListener(EventName.SERVER_BATTLEREPLAY_RES, self.onOpenFightDataPre, self)
    self:closeAllOpenSubPanel()
    self:recoverAllItems()
    self:recoverAllHeadGrid()
    self:recoverAllTeam()
    for _, Sn in pairs(self.tweenTimeSn) do
        LoopManager:removeFrameByIndex(Sn)
    end
    if self.mSn2 then
        LoopManager:removeTimerByIndex(self.mSn2)
        self.mSn2 = nil
    end
    if self.mSn then
        LoopManager:removeTimerByIndex(self.mSn)
        self.mSn = nil
    end

end

function addAllUIEvent(self)
    self:addUIEvent(self.m_childGos["mBtnClickAll"], function()
        if not self.mClickShowAll then
            self.mClickShowAll = false
        end
        self.mClickShowAll = not self.mClickShowAll
        self.m_childGos["mBtnGou"]:SetActive(self.mClickShowAll)
        self:ShowAllItem()
    end)
end


--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtEmptyTip.text = _TT(175)
end

--收到服务端数据打开伤害统计面板
function onOpenFightDataPre(self, args)
    GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_RESULT, args)
end


function updateView(self, tabType)
    local len = 1
    self:closeAllOpenSubPanel()
    local list = arena.ArenaManager.logList
    local defenseList = {}
    if list then
        for _, vo in pairs(list) do
            if vo.isSelfAttack == false then
                table.insert(defenseList, vo)
            end
        end
    end

    local isEmpty = #list < 1 or (#defenseList < 1 and self.getOpenType() == arena.TabViewType.TypeDefense) or list == nil or (#list == #defenseList and self.getOpenType() == arena.TabViewType.TypeAttack)
    self.m_childGos["mImgNo"]:SetActive(isEmpty)
    self.m_childGos["mBtnClickAll"]:SetActive(not isEmpty)
    self.m_childGos["Scroll View"]:SetActive(not isEmpty)
    self:recoverAllItems()
    self:recoverAllHeadGrid()
    self:recoverAllTeam()
    for idx, battleVo in pairs(list) do
        self.mFlagDic[idx] = false

        if battleVo.isSelfAttack == (self.getOpenType() == arena.TabViewType.TypeAttack) then
            --筛选对应页签相应的数据  
            local item = SimpleInsItem:create(self.m_childGos["ArenaLogItem"], self.m_childGos["Content"].transform, "mArenaLogItem")

            -- if len < 6 then
                item:getGo():SetActive(false)
            -- end
            -- len = len + 1
            item:addUIEvent("mBtnShowTeam",
            function()
                if battleVo.can_replay == 0 then gs.Message.Show(_TT(62226)) return end
                if self.mTeamDic[idx] == nil then
                    self.mTeamDic[idx] = {}
                end
                local m_teamDic_list = self.mTeamDic[idx]
                self.mFlagDic[idx] = not self.mFlagDic[idx]
                local isFlag = self.mFlagDic[idx]
                item:getChildGO("mTeamInfoGroup"):SetActive(isFlag)
                item:getChildGO("mBtn_03_up"):SetActive(isFlag)
                item:getChildGO("mBtn_03_down"):SetActive(not isFlag)
                if isFlag then
                    local formationHero
                    if battleVo.formationTid > 0 then
                        local formationVo = formation.FormationManager:getFormationConfigVo(battleVo.formationTid)
                        if formationVo then
                            formationHero = formationVo:getFormationList()
                        else
                            logError("编队信息配置错误，后端数据  编队Id：" .. battleVo.formationTid .. "  在前端配置表查询不到")
                        end
                    end
                    local hasHero = {}
                    for posIdx, posVo in pairs(battleVo.pos)
                    do
                        local teamPos = posVo.y * 4 - (posVo.x - 1)
                        local grid = HeroHeadGrid:poolGet()
                        grid:setData(hero.HeroManager:getHeroVoByTid(posVo.heroTid))
                        grid:setFashionId(posVo.fashionId)
                        grid:setScale(0.65)
                        grid:setStarLvl(posVo.evolution)
                        grid:setLvl(posVo.lv)
                        
                        grid:setScale(0.65)
                        grid:setParent(item:getChildTrans("mImgL" .. teamPos))

                        table.insert(m_teamDic_list, grid)
                        table.insert(hasHero, teamPos)
                    end
                    if formationHero then
                        for _, Vo in pairs(formationHero) do
                            local pos = Vo[2]
                            local teamPos = pos[2] * 4 - (pos[1] - 1)
                            if not table.indexof(hasHero, teamPos) then
                                local emptyImg = SimpleInsItem:create(self.mEmptyHero, item:getChildTrans("mImgL" .. teamPos), "mArenaLogEmptyHero")
                                gs.TransQuick:UIPos(emptyImg:getGo():GetComponent(ty.RectTransform), 0, 0)
                                table.insert(m_teamDic_list, emptyImg)
                            end
                        end
                    end
                    hasHero = nil
                    local hasMonster = {}
                    for enemyPosIdx, posVo in pairs(battleVo.enemyPos)
                    do
                        local teamPos = (posVo.y - 1) * 4 + posVo.x
                        local grid = HeroHeadGrid:poolGet()
                        ---要改
                        grid:setData(hero.HeroManager:getHeroConfigVo(posVo.heroTid))
                        grid:setFashionId(posVo.fashionId)
                        grid:setScale(0.65)
                        grid:setStarLvl(posVo.evolution)
                        grid:setLvl(posVo.lv)
                        grid:setParent(item:getChildTrans("mImgR" .. teamPos))

                        table.insert(m_teamDic_list, grid)
                        table.insert(hasMonster, teamPos)
                    end
                    local formationMons
                    if battleVo.enemyFormationTid > 0 then
                        if battleVo.isRobat then
                            formationMons = formation.FormationManager:getMonFormationConfigVo(battleVo.enemyFormationTid).m_formationList
                        else
                            formationMons = formation.FormationManager:getFormationConfigVo(battleVo.enemyFormationTid).m_formationList
                        end
                    end
                    --  
                    if formationMons then
                        for _, Vo in pairs(formationMons) do
                            local pos = Vo[2]
                            local teamPos = (pos[2] - 1) * 4 + pos[1]

                            if not table.indexof(hasMonster, teamPos) then
                                local emptyImg = SimpleInsItem:create(self.mEmptyHero, item:getChildTrans("mImgR" .. teamPos), "mArenaLogEmptyHero")
                                gs.TransQuick:UIPos(emptyImg:getGo():GetComponent(ty.RectTransform), 0, 0)
                                table.insert(m_teamDic_list, emptyImg)
                            end
                        end
                    end
                    hasMonster = nil
                else
                    self:recoverSingleTeam(idx)
                end
                self.mClickShowAll = self:checkIsAllOpen()
                self:getChildGO("mBtnGou"):SetActive(self.mClickShowAll)
            end)

            item:addUIEvent("mBtnReplay", function()
                if battleVo.can_replay ==0 then gs.Message.Show(_TT(198)) return end

                -- '是否查看本场斗录像？'
                UIFactory:alertMessge(_TT(178), true, function()
                    if battleVo.battleId ~= 0 then
                        fight.FightManager:reqReplay(PreFightBattleType.ArenaChallenge, battleVo.battleId)
                    else
                        -- gs.Message.Show("没有回放ID")
                        gs.Message.Show(_TT(179))
                    end
                    GameDispatcher:dispatchEvent(EventName.CLOSE_ARENA_LOG_PANEL, {})
                end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.ARENE_REPLAY
                )
            end)
            item:addUIEvent("mBtnFightData", function()
                if battleVo.can_replay ==0 then gs.Message.Show(_TT(62225)) return end
                fight.FightController:reqBattleRePlayDate(8, battleVo.battleId)
            end)
            item:addUIEvent("mBtnFightIdCopy", function()
                gs.SdkManager:Copy(battleVo.showId)
                local pasteResult = gs.SdkManager:Paste()
                if (pasteResult == "") then
                    gs.Message.Show(_TT(25104))--"复制失败"
                else
                    gs.Message.Show(string.format(_TT(25105), pasteResult)) -- "复制成功：%s"
                end
            end)
            item:getChildGO("mTxtFightId"):GetComponent(ty.Text).text = _TT(98005,battleVo.showId)
            item:getChildGO("mTxtEnemyNme"):GetComponent(ty.Text).text = battleVo.name
            item:getChildGO("mTxtScore_01"):GetComponent(ty.Text).text = battleVo.oddScore
            local mScore = battleVo.newScore - battleVo.oddScore
            if mScore > 0 then
                item:getChildGO("mTxtScore_02"):GetComponent(ty.Text).text = "+" .. mScore
                item:getChildGO("mTxtScore_02"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("0a9b10ff")
            else
                item:getChildGO("mTxtScore_02"):GetComponent(ty.Text).text = mScore
                item:getChildGO("mTxtScore_02"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("fa3a2bff")
            end
            item:getChildGO("mTipsWin"):SetActive(battleVo.isWin)
            item:getChildGO("mTipsLose"):SetActive(not battleVo.isWin)
            item:getChildGO("mTxtWin"):SetActive(battleVo.isWin)
            item:getChildGO("mTxtLose"):SetActive(not battleVo.isWin)
            item:getChildGO("mTxtPlayerNme"):GetComponent(ty.Text).text = role.RoleManager:getRoleVo():getPlayerName()
            item:getChildGO("mImgEnemyRank"):GetComponent(ty.AutoRefImage):SetImg(arena.ArenaManager:getSegmentVo(battleVo.enemySegment):getRankIcon(), false)
            item:getChildGO("mImgRankPlayer"):GetComponent(ty.AutoRefImage):SetImg(arena.ArenaManager:getSegmentVo(battleVo.segment):getRankIcon(), false)
            -- item:getChildGO("mImgPlayerFrame"):GetComponent(ty.AutoRefImage):SetImg(arena.ArenaManager:getSegmentVo(battleVo.enemySegment):getRankIcon(), false)
            -- item:getChildGO("mImgEnemyFrame"):GetComponent(ty.AutoRefImage):SetImg(arena.ArenaManager:getSegmentVo(battleVo.enemySegment):getRankIcon(), false)
            local mTxtTime, mTxtDate = item:getChildGO("mTxtTime"):GetComponent(ty.Text), item:getChildGO("mTxtDate"):GetComponent(ty.Text)
            mTxtTime.text, mTxtDate.text = TimeUtil.getMDHByTime2(battleVo.time)

            local avater = battleVo.avatar
            if battleVo.isRobat then
                local robotVo = arena.ArenaManager:getRobotData(battleVo.playerId)
                avater = robotVo:getHeadIcon()
            end

            local mEnemyHead = PlayerHeadGrid:poolGet()
            mEnemyHead:setData(avater, false)
            mEnemyHead:setScale(1)
            mEnemyHead:setHeadFrame(list[idx].frame)
            mEnemyHead:showHeadFrameAnim()
            mEnemyHead:setCallBack(mEnemyHead, function()
                if (not battleVo.isRobat and battleVo.playerId ~= role.RoleManager:getRoleVo().playerId) then
                    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = battleVo.playerId })
                end
            end)
            mEnemyHead:setParent(item:getChildTrans("mEnemyHeadNode"))

            local mPlayerHead = PlayerHeadGrid:poolGet()
            mPlayerHead:setData(role.RoleManager:getRoleVo():getAvatarId(), false)

            mPlayerHead:setScale(1)
            mPlayerHead:setHeadFrame(role.RoleManager:getRoleVo():getAvatarFrameId())
            mPlayerHead:showHeadFrameAnim()
            mPlayerHead:setParent(item:getChildTrans("mPlayerHeadNode"))
            table.insert(self.mHeadDic, mPlayerHead)
            table.insert(self.mHeadDic, mEnemyHead)
            gs.TransQuick:UIPosX(item:getGo():GetComponent(ty.RectTransform), 0)
            self.mItemDic[idx] = item

        end
    end

    len = 1
    for _, item in pairs(self.mItemDic) do
        -- if len > 7 then
        --     break
        -- end
        local tween = item:getGo():GetComponent(ty.UIDoTween)
        if not gs.GoUtil.IsCompNull(tween) and len then
            -- item:getGo():SetActive(false)
            local function callTween()
                if (not gs.GoUtil.IsCompNull(item:getGo():GetComponent(ty.UIDoTween))) then
                    item:getGo():SetActive(true)
                    item:getGo():GetComponent(ty.UIDoTween):BeginTween()
                end
            end
            table.insert(self.tweenTimeSn, LoopManager:addFrame(len, 1, self, callTween))
        end
        len = len + 1
    end
end


function ShowAllItem(self)
    self:recoverAllTeam()
    if self.mClickShowAll then
        for idx, battleVo in pairs(arena.ArenaManager.logList) do
            if battleVo.can_replay ~= 0 and battleVo.isSelfAttack == (self.getOpenType() == arena.TabViewType.TypeAttack) then
                if not self.mTeamDic[idx] then
                    self.mTeamDic[idx] = {}
                end
                local m_teamDic_list = self.mTeamDic[idx]
                local item = self.mItemDic[idx]
                item:getChildGO("mTeamInfoGroup"):SetActive(self.mClickShowAll)
                item:getChildGO("mBtn_03_up"):SetActive(self.mClickShowAll)
                item:getChildGO("mBtn_03_down"):SetActive(not self.mClickShowAll)
                self.mFlagDic[idx] = self.mClickShowAll
                local hasHero = {}
                for heroTid, posVo in pairs(battleVo.pos)
                do
                    local teamPos = posVo.y * 4 - (posVo.x - 1)
                    local grid = HeroHeadGrid:poolGet()
                    grid:setData(hero.HeroManager:getHeroVoByTid(posVo.heroTid))
                    grid:setScale(0.65)
                    grid:setLvl(posVo.lv)
                    grid:setStarLvl(posVo.evolution)
                    grid:setParent(item:getChildTrans("mImgL" .. teamPos))

                    table.insert(m_teamDic_list, grid)
                    table.insert(hasHero, teamPos)
                    local formationHero
                    if battleVo.formationTid > 0 then
                        local formationVo = formation.FormationManager:getFormationConfigVo(battleVo.formationTid)
                        if formationVo then
                            formationHero = formationVo:getFormationList()
                        else
                            logError("编队信息配置错误，后端数据  编队Id：" .. battleVo.formationTid .. "  在前端配置表查询不到")
                        end
                    end
                    if formationHero then
                        for _, Vo in pairs(formationHero) do
                            local pos = Vo[2]
                            local teamPos = pos[2] * 4 - (pos[1] - 1)
                            if not table.indexof(hasHero, teamPos) then
                                local emptyImg = SimpleInsItem:create(self.mEmptyHero, item:getChildTrans("mImgL" .. teamPos), "mArenaLogEmptyHero")
                                gs.TransQuick:UIPos(emptyImg:getGo():GetComponent(ty.RectTransform), 0, 0)
                                table.insert(m_teamDic_list, emptyImg)
                            end
                        end
                    end

                end
                hasHero = nil
                local hasMonster = {}
                for heroTid, posVo in pairs(battleVo.enemyPos)
                do
                    local teamPos = (posVo.y - 1) * 4 + posVo.x
                    local grid = HeroHeadGrid:poolGet()
                    ---要改
                    grid:setData(hero.HeroManager:getHeroConfigVo(posVo.heroTid))
                    grid:setScale(0.65)
                    grid:setParent(item:getChildTrans("mImgR" .. teamPos))
                    grid:setLvl(posVo.lv)
                    grid:setStarLvl(posVo.evolution)
                    table.insert(m_teamDic_list, grid)
                    table.insert(hasMonster, teamPos)

                    local formationMons
                    if battleVo.enemyFormationTid > 0 then
                        if battleVo.isRobat then
                            local formationVo = formation.FormationManager:getMonFormationConfigVo(battleVo.enemyFormationTid)
                            if formationVo then
                                formationMons = formationVo:getFormationList()
                            else
                                logError("敌方怪物编队信息配置错误，后端数据  编队Id：" .. battleVo.enemyFormationTid .. "  在前端配置表查询不到")
                            end
                        else
                            local formationVo = formation.FormationManager:getFormationConfigVo(battleVo.enemyFormationTid)
                            if formationVo then
                                formationMons = formationVo:getFormationList()
                            else
                                logError("敌方编队信息配置错误，后端数据  编队Id：" .. battleVo.enemyFormationTid .. "  在前端配置表查询不到")
                            end
                        end
                    end
                    --
                    if formationMons then
                        for _, Vo in pairs(formationMons) do
                            local pos = Vo[2]
                            local teamPos = (pos[2] - 1) * 4 + pos[1]
                            if not table.indexof(hasMonster, teamPos) then
                                local emptyImg = SimpleInsItem:create(self.mEmptyHero, item:getChildTrans("mImgR" .. teamPos), "mArenaLogEmptyHero")
                                gs.TransQuick:UIPos(emptyImg:getGo():GetComponent(ty.RectTransform), 0, 0)
                                table.insert(m_teamDic_list, emptyImg)
                            end
                        end

                    end

                end
                hasMonster = nil
            end

        end
    else
        for idx, item in pairs(self.mItemDic) do
            item:getChildGO("mTeamInfoGroup"):SetActive(self.mClickShowAll)
            item:getChildGO("mBtn_03_up"):SetActive(self.mClickShowAll)
            item:getChildGO("mBtn_03_down"):SetActive(not self.mClickShowAll)
            self.mFlagDic[idx] = self.mClickShowAll
        end
        self:recoverAllTeam()
    end
end

function getOpenType()
    return arena.TabViewType.TypeAttack
end

function checkIsAllOpen(self)
    for _, flag in pairs(self.mFlagDic) do
        if not flag then
            return false
        end
    end
    return true
end

function closeAllOpenSubPanel(self)
    if next(self.mItemDic)
    then
        self:getChildGO("mBtnGou"):SetActive(false)
        self.mClickShowAll = false
        for _, item in pairs(self.mItemDic)
        do
            item.m_childGos["mTeamInfoGroup"]:SetActive(false)
            item.m_childGos["mBtn_03_up"]:SetActive(false)
            item.m_childGos["mBtn_03_down"]:SetActive(true)
        end
    end
end

function recoverAllItems(self)
    if next(self.mItemDic) then
        for _, item in pairs(self.mItemDic) do
            item:poolRecover()
        end
        self.mItemDic = {}
    end
end
function recoverAllHeadGrid(self)
    if next(self.mHeadDic) then
        for _, item in pairs(self.mHeadDic) do
            item:poolRecover()
        end
        self.mHeadDic = {}
    end
end

function recoverSingleTeam(self, idx)
    local m_tableHelper = self.mTeamDic[idx]
    if m_tableHelper then
        if next(m_tableHelper) then
            for _, item in pairs(m_tableHelper) do
                item:poolRecover()
            end
            self.mTeamDic[idx] = {}
        end
    end
end

function recoverAllTeam(self)
    if next(self.mTeamDic) then
        for _, list in pairs(self.mTeamDic) do
            if next(list) then
                for _, item in pairs(list) do
                    item:poolRecover()
                end
                list = {}
            end
        end
        self.mTeamDic = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]