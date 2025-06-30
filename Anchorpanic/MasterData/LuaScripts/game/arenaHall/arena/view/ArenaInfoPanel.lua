--[[
-----------------------------------------------------
@filename       : ***
@Description    : ***
@date           : ***
@Author         : sllive
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('arena.ArenaInfoPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("arenaHall/arena/ArenaInfoPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")
end
--析构
function dtor(self)
end

function initData(self)
    self.mEnemyHeroList = {}
    self.mRoleHeroList = {}
end

-- 初始化
function configUI(self)
    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
    self.mTxtTopLv = self:getChildGO("mTxtTopLv"):GetComponent(ty.Text)
    self.mTxtTopRank = self:getChildGO("mTxtTopRank"):GetComponent(ty.Text)
    self.mTxtTopName = self:getChildGO("mTxtTopName"):GetComponent(ty.Text)
    self.mTxtTopScore = self:getChildGO("mTxtTopScore"):GetComponent(ty.Text)
    self.mTxtTopTitle = self:getChildGO("mTxtTopTitle"):GetComponent(ty.Text)
    self.mTxtBottomName = self:getChildGO("mTxtBottomName"):GetComponent(ty.Text)
    self.mTxtBottomRank = self:getChildGO("mTxtBottomRank"):GetComponent(ty.Text)
    self.mTxtBottomTitle = self:getChildGO("mTxtBottomTitle"):GetComponent(ty.Text)
    self.mTxtBottomScore = self:getChildGO("mTxtBottomScore"):GetComponent(ty.Text)
    self.mImgHeroL = self:getChildGO("mImgHeroL"):GetComponent(ty.AutoRefImage)
    self.mImgHeroR = self:getChildGO("mImgHeroR"):GetComponent(ty.AutoRefImage)
end

--激活
function active(self)
    super.active(self)
    self.mAnimator:Play("ArenaInfoPanel_Enter")
    self.mAnimator.enabled = false
    self.mAnimator:Update(0)
    gs.DT.DOTween:Sequence():AppendInterval(0):AppendCallback(function()
        self.mAnimator.enabled = true
    end):Play()
    self:updateView(true)
    self.base_childGos["mGroupTop"]:SetActive(false)
    LoopManager:addTimer(2.5, 1, self, self.onEnd)
    GameDispatcher:addEventListener(EventName.ACCOUNT_RELOGIN_SUC, self.onRelogin, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearItemList()
    GameDispatcher:removeEventListener(EventName.ACCOUNT_RELOGIN_SUC, self.onRelogin, self)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTopTitle.text = _TT(199)

end

function updateView(self, cusIsInit)
    -- local enemyVo = arena.ArenaManager.enemyList[1]
    local enemyVo = arena.ArenaManager.enemyList[1]
    local roleVo = role.RoleManager:getRoleVo()
    self.mTxtBottomName.text = enemyVo.name
    self.mTxtBottomScore.text = _TT(197, enemyVo.score)
    self.mTxtBottomRank.text = _TT(194, enemyVo.rank)
    self.mTxtTopLv.text = roleVo:getPlayerLvl()
    self.mTxtTopName.text = roleVo:getPlayerName()
    local rank = arena.ArenaManager.myDailyRank
    self.mTxtTopRank.text = rank == 0 and "--" or _TT(194, rank, 26)
    self.mTxtTopScore.text = _TT(197, arena.ArenaManager.myScore)
    self:fightHeroList()
end

-- 动效结束
function onEnd(self)
    -- self:close()
    self:enterFight()
end

-- 重连成功界面未关闭，证明未进入战斗，重新请求进入
function onRelogin(self)
    self:enterFight()
end

-- 请求进入战斗
function enterFight(self)
    local enemyVo = arena.ArenaManager.enemyList[1]
    fight.FightManager:reqBattleEnter(PreFightBattleType.ArenaChallenge, enemyVo.playerId)
end

-- 上阵战员
function fightHeroList(self)
    self:clearItemList()
    local roleVoList = arena.ArenaManager:getFormationHeroList()
    local enemyVo = arena.ArenaManager.enemyList[1]
    if enemyVo.isRobot then
        local robotVo = arena.ArenaManager:getRobotData(enemyVo.playerId)
        local randomeTable = {}
        for _, monsterUniqueTid in pairs(robotVo.m_battleArray) do
            local trans = self:getChildTrans("mRightTrans_0" .. _)
            local Vo = monster.MonsterManager:getMonsterVo(monsterUniqueTid)
            local monsterVo = monster.MonsterManager:getMonsterVoByUniqueTid(monsterUniqueTid)
            local robotGrid = HeroHeadGrid:poolGet()
            table.insert(randomeTable, monsterVo.model)
            robotGrid:setData(monsterVo)
            robotGrid:setParent(trans)
            robotGrid:setLvl(Vo.lvl)
            robotGrid:setStarLvl(Vo.evolutionLvl)
            robotGrid:setType(true)
            robotGrid:setEleType(true)
            robotGrid:setScale(0.95)
            robotGrid:setRes(true)

            table.insert(self.mEnemyHeroList, robotGrid)
        end
        if next(randomeTable) then
            local ran = math.random(1, #randomeTable)
            local mStrHelper = {"arenaInfoPanel/vs_pic_", randomeTable[ran], ".png"}
            self.mImgHeroR:SetImg(UrlManager:getBgPath(table.concat(mStrHelper)), false)
        end
    else
        local enemyheroList = enemyVo:getFightHeroList()
        if #enemyheroList > 0 then
            local randomeTable = {}
            for i, emenyHero in pairs(enemyheroList) do
                local trans = self:getChildTrans("mRightTrans_0" .. i)
                local heroVo = hero.HeroManager:getHeroConfigVo(emenyHero.tid)
                local heroCard = HeroHeadGrid:poolGet()
                table.insert(randomeTable, heroVo:getHeroModel(emenyHero.fashionId))
                heroCard:setData(heroVo)
                heroCard:setFashionId(emenyHero.fashionId)
                heroCard:setParent(trans)
                heroCard:setLvl(emenyHero.lvl)
                heroCard:setStarLvl(emenyHero.evolutionLvl)
                heroCard:setType(true)
                heroCard:setEleType(true)
                heroCard:setScale(0.95)
                heroCard:setRes(true)

                table.insert(self.mEnemyHeroList, heroCard)
            end
            if next(randomeTable) then
                local ran = math.random(1, #randomeTable)
                local mStrHelper = {"arenaInfoPanel/vs_pic_", randomeTable[ran], ".png"}
                self.mImgHeroR:SetImg(UrlManager:getBgPath(table.concat(mStrHelper)), false)
            end
        end
    end
    local randomeTable = {}
    for i, Vo in pairs(roleVoList) do
        local trans = self:getChildTrans("mLeftTrans_0" .. i)
        local heroVo = hero.HeroManager:getHeroVo(Vo.heroId)
        table.insert(randomeTable, heroVo:getHeroModel())
        local heroCard = HeroHeadGrid:poolGet()
        heroCard:setData(heroVo)
        heroCard:setParent(trans)
        heroCard:setLvl(heroVo.lvl)
        heroCard:setStarLvl(heroVo.evolutionLvl)
        heroCard:setType(true)
        heroCard:setEleType(true)
        heroCard:setScale(0.95)
        heroCard:setRes(true)

        table.insert(self.mRoleHeroList, heroCard)
    end
    if next(randomeTable) then
        local ran = math.random(1, #randomeTable)
        local mStrHelper = {"arenaInfoPanel/vs_pic_", randomeTable[ran], ".png"}
        self.mImgHeroL:SetImg(UrlManager:getBgPath(table.concat(mStrHelper)), false)
    end
end

function clearItemList(self)
    if next(self.mEnemyHeroList) then
        for i, item in pairs(self.mEnemyHeroList) do
            item:poolRecover()
        end
        self.mEnemyHeroList = {}
    end
    if next(self.mRoleHeroList) then
        for k, Heroitem in pairs(self.mRoleHeroList) do
            Heroitem:poolRecover()
        end
        self.mRoleHeroList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
