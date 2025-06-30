module('guildWar.GuildWarFightResultInfoPanel', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarFightResultInfoPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(149186))
    self:setSize(0, 0)
    self:setBg("guild_bg.jpg", false, "guild")

end

function initData(self)
    self.mResultItemDic = {}
    self.mTeamList = {}
    self.mHeroGridList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtId = self:getChildGO("mTxtId"):GetComponent(ty.Text)
    self.mBtnFightIdCopy = self:getChildGO("mBtnFightIdCopy")
    self.mResultScroll = self:getChildGO("mResultScroll"):GetComponent(ty.ScrollRect)
    self.mResultItem = self:getChildGO("mResultItem")

    self.mEmptyHero = self:getChildGO("mEmptyHero")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFightIdCopy, self.onClickFightIdCopy)
end

function onClickFightIdCopy(self)
    gs.SdkManager:Copy(self.log.show_id)
    local pasteResult = gs.SdkManager:Paste()
    if (pasteResult == "") then
        gs.Message.Show(_TT(25104)) -- "复制失败"
    else
        gs.Message.Show(string.format(_TT(25105), pasteResult)) -- "复制成功：%s"
    end
end

function initViewText(self)
end

function active(self, args)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    self.log = args.log
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    guildWar.GuildWarManager:setIsRepRet(true)
    super.deActive(self)
    self:clearItems()
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
end

function showPanel(self)

    self.mTxtId.text = _TT(98005, self.log.show_id)

    local isSelf = self.log.is_atk == 1
    local teamList = self.log.team_list
    table.sort(teamList, function(a, b)
        return a.team_id < b.team_id
    end)

    self:clearItems()

    for i = 1, 2 do
        local item = SimpleInsItem:create(self.mResultItem, self.mResultScroll.content, "guildWarFightResultItem")
        item:getChildGO("mTxtRound"):GetComponent(ty.Text).text = _TT(149161) .. i

        for j = 1, 3 do
            local r = 1
            if teamList[i].result == 1 or teamList[i].result == 4 then
                r = 1
            elseif teamList[i].result == 2 or teamList[i].result == 5 then
                r = 2
            elseif teamList[i].result == 3 or teamList[i].result == 6 then
                r = 3
            end
            item:getChildGO("mFight" .. j):SetActive(j == r)
        end

        local canReplay = teamList[i].can_replay == 1
        item:getChildGO("mBtnRep"):SetActive(canReplay)

        item:addUIEvent("mBtnRep", function()
            UIFactory:alertMessge(_TT(178), true, function()
                if self.log.battle_id ~= 0 then
                    fight.FightManager:reqReplay(PreFightBattleType.GuildWar, self.log.battle_id, i)
                else
                    gs.Message.Show(_TT(179))
                end
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.GUILDWAR_REPLAY)
        end)

        item:addUIEvent("mBtnInfo", function()
            guildWar.GuildWarManager:setLookIsSelf(isSelf)
            fight.FightController:reqBattleRePlayDate(PreFightBattleType.GuildWar, self.log.battle_id)
        end)

        self.mResultItemDic[i] = item
    end

    for i = 1, #teamList, 1 do
        local selfTid = isSelf and teamList[i].self_formation_tid or teamList[i].enemy_formation_tid
        local selfInfo = isSelf and teamList[i].self_pos or teamList[i].enemy_pos
        self:createTeamInfo(selfTid, selfInfo, teamList[i].team_id, isSelf)

        local enemyTid = isSelf and teamList[i].enemy_formation_tid or teamList[i].self_formation_tid
        local enemyInfo = isSelf and teamList[i].enemy_pos or teamList[i].self_pos
        self:createTeamInfo(enemyTid, enemyInfo, teamList[i].team_id, not isSelf)
    end

end

function createTeamInfo(self, tid, info, teamId, isSelf)
    local formationList = formation.FormationManager:getFormationConfigVo(tid):getFormationList()
    for _, vo in pairs(formationList) do
        local pos = vo[2]
        local teamPos = pos[2] * 4 - (pos[1] - 1)
        local p = isSelf and "L" or "R"

        local heroInfo = self:getPosHeroInfo(info, teamPos)

        if heroInfo ~= nil then
            local grid = HeroHeadGrid:poolGet()
            local heroVo = hero.HeroManager:getHeroConfigVo(heroInfo.hero_tid)
            grid:setData(heroVo)
            grid:setScale(0.62)
            grid:setStarLvl(heroInfo.evolution)
            grid:setLvl(heroInfo.lv)

            local parentItem = self.mResultItemDic[teamId]

            grid:setParent(parentItem:getChildTrans("mImg" .. p .. teamPos))
            table.insert(self.mHeroGridList, grid)

        else
            local parentItem = self.mResultItemDic[teamId]
            local emptyImg = SimpleInsItem:create(self.mEmptyHero, parentItem:getChildTrans("mImg" .. p .. teamPos),
                "guildWarFightResultEmptyItem")
            gs.TransQuick:UIPos(emptyImg:getGo():GetComponent(ty.RectTransform), 0, 0)
            table.insert(self.mTeamList, emptyImg)
        end
    end

end

function getPosHeroInfo(self, heroList, pos)
    for i = 1, #heroList do
        if heroList[i].pos.y * 4 - (heroList[i].pos.x - 1) == pos then
            return heroList[i]
        end
    end
    return nil
end

function clearItems(self)

    for i = 1, #self.mHeroGridList do
        self.mHeroGridList[i]:poolRecover()
    end
    self.mHeroGridList = {}

    for i = 1, #self.mTeamList do
        self.mTeamList[i]:poolRecover()
    end
    self.mTeamList = {}

    if self.mResultItemDic then
        for i = 1, #self.mResultItemDic, 1 do
            self.mResultItemDic[i]:poolRecover()
        end
    end
    self.mResultItemDic = {}

end

return _M
