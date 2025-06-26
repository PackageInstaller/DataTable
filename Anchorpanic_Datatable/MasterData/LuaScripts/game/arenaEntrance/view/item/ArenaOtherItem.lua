module("arenaEntrance.ArenaOtherItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mOtherHeadContent = self:getChildTrans("mOtherHeadContent")

    self.mTxtOtherRank = self:getChildGO("mTxtOtherRank"):GetComponent(ty.Text)
    self.mTxtOtherName = self:getChildGO("mTxtOtherName"):GetComponent(ty.Text)
    self.mTxtOtherScore = self:getChildGO("mTxtOtherScore"):GetComponent(ty.Text)
    self.mTxtOtherWin = self:getChildGO("mTxtOtherWin"):GetComponent(ty.Text)

    --self.mBg = self:getChildGO("bg")

    self.mTeamItem = self:getChildGO("mTeamItem")
    self.mFormationContent = self:getChildTrans("mFormationContent")

    self:addOnClick(self:getChildGO("mBtnClick"), self.onClickCheckHandler)

    self.mTeamList = {}
    self.mHeadList = {}
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)

    if (self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
    self:clearGridList()
    self:clearTeamList()
end

function clearTeamList(self)
    for i = 1, #self.mTeamList do
        self.mTeamList[i]:poolRecover()
    end
    self.mTeamList = {}
end

function clearGridList(self)
    for i = 1, #self.mHeadList do
        self.mHeadList[i]:poolRecover()
    end
    self.mHeadList = {}
end

function setData(self, param)
    super.setData(self, param)

    local hideRank = 20

    self.mTxtOtherRank.text = param.rank <= hideRank and "???" or _TT(194, param.rank)
    self.mTxtOtherName.text = param.rank <= hideRank and _TT(92020) .. "???" or (_TT(92020) .. param.player_name)
    self.mTxtOtherScore.text = param.rank <= hideRank and _TT(92021) .. "???" or _TT(92021) .. param.score
    self.mTxtOtherWin.text = "胜利数:" .. param.win_count

    if param.is_robot == 1 then
        local robotVo = arenaEntrance.ArenaEntranceManager:getRobotData(param.player_id)
        param.avatar = robotVo:getHeadIcon()
    else
        param.avatar = param.avatar_id
    end

    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end

    if param.rank > hideRank then
        self.mPlayerHeadGrid = PlayerHeadGrid:create(self.mOtherHeadContent, param.avatar, 1, false)
        self.mPlayerHeadGrid:setHeadFrame(param.avatar_frame)
        self.mPlayerHeadGrid:setLvl(param.lv)
        self.mPlayerHeadGrid:setScale(0.7)
        self.mPlayerHeadGrid:setClickRay(false)
    end

    self:clearGridList()
    self:clearTeamList()

    for i = 1, 3 do
        local item = SimpleInsItem:create(self.mTeamItem, self.mFormationContent, "teamItem")
        item:getChildGO("mTxtTeam"):GetComponent(ty.Text).text = "队伍" .. i

        local heroInfo = param.team_list[i]
        local grid = HeroHeadGrid:poolGet()

        local vo = heroInfo.hero_list[1]
        local isHidden = heroInfo.is_hidden == 1
        item:getChildGO("mIsHidden"):SetActive(isHidden)

        if isHidden == false then
            -- 是机器人
            if param.is_robot == 1 then --
                local robotVo = arenaEntrance.ArenaEntranceManager:getRobotData(param.player_id)
                vo = monster.MonsterManager:getMonsterVo(robotVo:getBattleArray(i)[1])
                grid:setData(hero.HeroManager:getHeroConfigVo(vo.tid))
                grid:setStarLvl(vo.evolutionLvl)
                grid:setLvl(vo.lvl)
                grid:setRes(true)
            else
                grid:setData(hero.HeroManager:getHeroConfigVo(vo.hero_tid))
                grid:setFashionId(vo.body_fashion_id)
                grid:setStarLvl(vo.evolution)
                grid:setLvl(vo.lv)
                grid:setRes(true)
            end

            grid:setScale(0.6)
            grid:setParent(item:getChildTrans("mHeroContent"))

            table.insert(self.mHeadList, grid)
        end
        table.insert(self.mTeamList, item)
    end
end

function onClickCheckHandler(self)
    local remainTimes = arenaEntrance.ArenaEntranceManager:getMyRemainTimes()
    local buyTimes = arenaEntrance.ArenaEntranceManager:getBuyTimes()
    local boughtTimes = arenaEntrance.ArenaEntranceManager:getBoughtTimes()

    local maxBuyTimes = sysParam.SysParamManager:getValue(SysParamType.PVP_HELL_MAX)

    if remainTimes == 0 and buyTimes == 0 then
        if boughtTimes >= maxBuyTimes then
            -- 不可再购买
            gs.Message.Show(_TT(92019))
        else
            -- 可购买
            UIFactory:alertMessge(_TT(92018, maxBuyTimes - boughtTimes), true, function()
                local tid = sysParam.SysParamManager:getValue(SysParamType.PVP_HELL_BUY_TID)
                local num = sysParam.SysParamManager:getValue(SysParamType.PVP_HELL_BUY_NUM)

                local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(tid, num, true, true)
                if tips == "" and result == true then
                    GameDispatcher:dispatchEvent(EventName.REQ_ARENA_HELL_TIMES)
                    -- GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HELL_OTHER_PANEL, { data = self.data })
                    arenaEntrance.ArenaEntranceManager.selectEnemyData = self.data
                else
                    MoneyUtil.judgeNeedMoneyCountByTidTips(tid, num, nil, nil, nil)
                end
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
        end
    else
        arenaEntrance.ArenaEntranceManager.selectEnemyData = self.data
        GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_HELL_OTHER_PANEL, {data = self.data})
    end

end

return _M
