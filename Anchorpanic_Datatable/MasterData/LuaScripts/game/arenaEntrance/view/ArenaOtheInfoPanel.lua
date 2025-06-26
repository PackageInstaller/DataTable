--[[
-----------------------------------------------------
@filename       : ArenaOtheInfoPanel
@Description    : 敌方信息面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("arenaEntrance.ArenaOtheInfoPanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("arenaEntrance/ArenaOtheInfoPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    self:setTxtTitle("对战信息")
end

-- 适应全面屏，刘海缩进
function setAdapta(self)

end

function initData(self)
    self.mTeamList = {}
    self.mHeroList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtID = self:getChildGO("mTxtID"):GetComponent(ty.Text)

    self.mBtnFormation = self:getChildGO("mBtnFormation")
    self.mBtnFight = self:getChildGO("mBtnFight")

    self.mBtnRound1 = self:getChildGO("mBtnRound1")
    self.mBtnRound2 = self:getChildGO("mBtnRound2")
    self.mBtnRound3 = self:getChildGO("mBtnRound3")
    self.mRoundList = {}
    table.insert(self.mRoundList, self.mBtnRound1)
    table.insert(self.mRoundList, self.mBtnRound2)
    table.insert(self.mRoundList, self.mBtnRound3)

    self.mTeamItem = self:getChildGO("mTeamItem")
    self.mHeroContent = self:getChildTrans("mHeroContent")
    self.mOtherHeroContent = self:getChildTrans("mOtherHeroContent")

    self.mToggleSkip = self:getChildGO('mToggleSkip'):GetComponent(ty.Toggle)
end

function initViewText(self)
    --self.mScoreTitle.text = _TT(44657) --"EMAIL LIST"
    self:setBtnLabel(self.mBtnFight, nil, "开始战斗")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFormation, self.onBtnFormationClick)
    self:addUIEvent(self.mBtnFight, self.onBtnFightClick)
    self:addUIEvent(self.mBtnRound1, self.onBtnRound1Click)
    self:addUIEvent(self.mBtnRound2, self.onBtnRound2Click)
    self:addUIEvent(self.mBtnRound3, self.onBtnRound3Click)
end

--激活
function active(self, args)
    super.active(self, args)

    self.mData = args.data
    self.defIndex = 1
    -- self.mTxtID.text = "player_id：" .. args.data.player_id

    self.mToggleSkip.isOn = StorageUtil:getNumber1(gstor.ARENA_HELL_SKIP) == 1

    for i = 1, #self.mRoundList do
        self.mRoundList[i].transform:Find("Text"):GetComponent(ty.Text).text = "队伍" .. i
    end

    self:updateClickRound(self.defIndex)
    GameDispatcher:addEventListener(EventName.FIGHT_OUTSIDE_SKIP_RESULT, self.onFightSkipResultHandler, self)
end

function deActive(self)
    super.deActive(self)
    if self.mGroupSkipGO then
        gs.GameObject.Destroy(self.mGroupSkipGO)
        self.mGroupSkipGO = nil
    end
    GameDispatcher:removeEventListener(EventName.FIGHT_OUTSIDE_SKIP_RESULT, self.onFightSkipResultHandler, self)

    StorageUtil:saveNumber1(gstor.ARENA_HELL_SKIP, self.mToggleSkip.isOn and 1 or 0)
    arenaEntrance.ArenaEntranceManager.isSkipFighting = false
    self:clearHero()
    self:clearTeam()
end

function onClickClose(self)
    super.onClickClose(self)
    arenaEntrance.ArenaEntranceManager.selectEnemyData = nil
end

function onBtnFormationClick(self)
    -- gs.Message.Show("变更编队 TODO")
    self:close()
    formation.openFormation(formation.TYPE.ARENA_PEAK_ATTACK, nil, self.defIndex, nil)
end

-- 跳过返回
function onFightSkipResultHandler(self)
    arenaEntrance.ArenaEntranceManager.isSkipFighting = false
    self:onClickClose()
end

function onBtnFightClick(self)
    -- gs.Message.Show("进入战斗 TODO")
    local listAtt = formation.FormationArenaPeakAttackManager:getSelectFormationHeroList(12000 + self.defIndex)
    local listDef = formation.FormationArenaPeakDefenseManager:getSelectFormationHeroList(13000 + self.defIndex)

    if #listAtt == 0 or #listDef == 0 then
        gs.Message.Show("没有配置进攻或防守队列")
        return
    end

    if arenaEntrance.ArenaEntranceManager.isSkipFighting == true then
        return
    end

    if self.mToggleSkip.isOn then
        arenaEntrance.ArenaEntranceManager.isSkipFighting = true
        fight.FightController:reqBattleOutsideSkip(PreFightBattleType.Arena_Peak_Pvp, self.mData.player_id)

        if self.mGroupSkipGO then
            gs.GameObject.Destroy(self.mGroupSkipGO)
            self.mGroupSkipGO = nil
        end
        -- 跳过战斗
        self.mGroupSkipGO = gs.ResMgr:LoadGO(UrlManager:getUIPrefabPath("arenaEntrance/ArenaHellSkipView.prefab"))
        gs.TransQuick:SetParentOrg01(self.mGroupSkipGO, GameView.subPop)
        self:setTimeout(10, function()
            self:onClickClose()
            arenaEntrance.ArenaEntranceManager:setLastClickRefresh(GameManager:getClientTime())
            GameDispatcher:dispatchEvent(EventName.REQ_ARENA_HELL_PANEL_INFO)
        end)
        return
    end

    arenaEntrance.ArenaEntranceManager:setLastClickPlayerData(self.mData)
    fight.FightManager:reqBattleEnter(PreFightBattleType.Arena_Peak_Pvp, self.mData.player_id)
    arenaEntrance.ArenaEntranceManager.selectEnemyData = nil
end

function onBtnRound1Click(self)
    self:updateClickRound(1)
end

function onBtnRound2Click(self)
    self:updateClickRound(2)
end
function onBtnRound3Click(self)
    self:updateClickRound(3)
end

function updateClickRound(self, index)
    self.defIndex = index
    for i = 1, #self.mRoundList do
        if i ~= index then
            self.mRoundList[i]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("2d3646FF")
            self.mRoundList[i].transform:Find("Text"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("ddddddFF")
        else
            self.mRoundList[i]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("FFFFFFFF")
            self.mRoundList[i].transform:Find("Text"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("40484bFF")
        end
    end

    self:showTeam()
end

function showTeam(self)
    self:clearHero()
    self:clearTeam()

    local list = formation.FormationArenaPeakAttackManager:getSelectFormationHeroList(12000 + self.defIndex)
    for i = 1, 5 do
        local item = SimpleInsItem:create(self.mTeamItem, self.mHeroContent, "myTeamItem")
        item:getChildGO("mIsHidden"):SetActive(false)
        item:getChildGO("mIsNull"):SetActive(not (list[i] and list[i].heroId))

        if list[i] and list[i].heroId then
            local grid = HeroHeadGrid:poolGet()
            local heroVo = hero.HeroManager:getHeroVo(list[i].heroId)
            grid:setData(hero.HeroManager:getHeroConfigVo(heroVo.tid))
            grid:setStarLvl(heroVo.evolutionLvl)
            grid:setLvl(heroVo.lvl)
            grid:setType(true)
            grid:setEleType(true)
            grid:setParent(item:getChildTrans("mHeroHeadContent"))
            grid:setScale(0.75)
            grid:setRes(true)

            table.insert(self.mHeroList, grid)
        end
        table.insert(self.mTeamList, item)
    end

    local robotVo = arenaEntrance.ArenaEntranceManager:getRobotData(self.mData.player_id)
    local isHidden = self.mData.team_list[self.defIndex].is_hidden == 1
    for i = 1, 5 do
        local item = SimpleInsItem:create(self.mTeamItem, self.mOtherHeroContent, "otherTeamItem")
        item:getChildGO("mIsHidden"):SetActive(isHidden)
        item:getChildGO("mIsNull"):SetActive(false)
        if isHidden == false then
            local grid = HeroHeadGrid:poolGet()
            --是机器人
            if self.mData.is_robot == 1 then
                local array = robotVo:getBattleArray(self.defIndex)
                item:getChildGO("mIsNull"):SetActive(array[i] == nil)
                if array[i] ~= nil then
                    local vo = monster.MonsterManager:getMonsterVo(array[i])
                    grid:setData(hero.HeroManager:getHeroConfigVo(vo.tid))
                    grid:setStarLvl(vo.evolutionLvl)
                    grid:setLvl(vo.lvl)
                end
            else
                local heroList = self.mData.team_list[self.defIndex].hero_list
                item:getChildGO("mIsNull"):SetActive(heroList[i] == nil)
                if heroList[i] ~= nil then
                    local data = heroList[i]
                    grid:setData(hero.HeroManager:getHeroConfigVo(data.hero_tid))
                    grid:setStarLvl(data.evolution)
                    grid:setLvl(data.lv)
                end
            end
            grid:setType(true)
            grid:setEleType(true)
            grid:setParent(item:getChildTrans("mHeroHeadContent"))
            grid:setScale(0.75)
            grid:setRes(true)

            table.insert(self.mHeroList, grid)
        end
        table.insert(self.mTeamList, item)
    end
end

function clearTeam(self)
    for i = 1, #self.mTeamList do
        self.mTeamList[i]:poolRecover()
    end
    self.mTeamList = {}
end

function clearHero(self)
    for i = 1, #self.mHeroList do
        self.mHeroList[i]:poolRecover()
    end
    self.mHeroList = {}
end

return _M
