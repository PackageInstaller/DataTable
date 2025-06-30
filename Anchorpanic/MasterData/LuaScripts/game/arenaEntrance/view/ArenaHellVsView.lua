--[[
-----------------------------------------------------
@filename       : ArenaHellVsView
@Description    : 综合对抗赛vs界面
@date           : 2023-10-13 10:36:39
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('arenaEntrance.ArenaHellVsView', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("arenaEntrance/ArenaHellVsView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isShowBlackBg = 0 -- 是否显示全屏纯黑防穿帮底图
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("")
end
-- 析构
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

-- 激活
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
    -- LoopManager:addTimer(2.5, 1, self, self.onEnd)
    GameDispatcher:addEventListener(EventName.ACCOUNT_RELOGIN_SUC, self.onRelogin, self)
end

-- 反激活（销毁工作）
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
    -- self.mTxtTopTitle.text = _TT(199)

end

-- 设置ui节点名称（ui通过节点名拿ui节点）
-- SCENE,MAIN_UI,POP,SUB_POP,GUIDE,LOADING,ALERT,MSG
function getUiNodeName(self)
    return "LOADING"
end

-- 动效结束
-- function onEnd(self)
--     self:close()
-- end

function updateView(self, cusIsInit)

    -- self.mTxtTopName.text = role.RoleManager:getRoleVo():getPlayerName()
    -- self.mTxtTopScore.text = arenaEntrance.ArenaEntranceManager:getMyScore() .. "积分"
    -- local rank = arenaEntrance.ArenaEntranceManager:getMySeasonRank()
    -- if rank == 0 then --
    --     self.mTxtTopRank.text = _TT(161)
    -- else
    --     self.mTxtTopRank.text = _TT(194, rank)
    -- end

    -- local info = arenaEntrance.ArenaEntranceManager:getLastClickEnemyInfo()

    -- self.mTxtBottomName.text = info.player_name
    -- self.mTxtBottomScore.text = info.score .. "积分"
    -- if info.rank <= 0 then
    --     self.mTxtBottomRank.text = _TT(161)
    -- else
    --     self.mTxtBottomRank.text = _TT(194, info.rank)
    -- end

    local roundTime = arenaEntrance.ArenaEntranceManager.roundTime
    if roundTime then
        self.mTxtTopTitle.text = _TT(52125, roundTime) --第一局
    end
    arenaEntrance.ArenaEntranceManager.roundTime = roundTime + 1

    self:fightHeroList()
end

-- 上阵战员
function fightHeroList(self)
    self:clearItemList()

    local randomeTable = {}
    local heroDic = fight.SceneManager:getSideThingIDs(1)
    for i, id in ipairs(heroDic) do
        -- local thingVo = fight.SceneManager:getThing(id)
        local heroData = fight.FightManager:getHero(id)
        local trans = self:getChildTrans("mLeftTrans_0" .. i)
        local heroVo = hero.HeroManager:getHeroConfigVo(heroData.tid)
        table.insert(randomeTable, heroVo:getHeroModel(heroData.body_fashion_id))
        local heroCard = HeroHeadGrid:poolGet()
        heroCard:setData(heroVo)
        heroCard:setFashionId(heroData.body_fashion_id)
        heroCard:setParent(trans)
        heroCard:setLvl(heroData.lv)
        heroCard:setStarLvl(heroData.evolution)
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

    -----------------------------
    randomeTable = {}
    local heroDic = fight.SceneManager:getSideThingIDs(2)
    for i, id in ipairs(heroDic) do
        -- local thingVo = fight.SceneManager:getThing(id)
        local heroData = fight.FightManager:getHero(id)
        local trans = self:getChildTrans("mRightTrans_0" .. i)
        local heroVo = hero.HeroManager:getHeroConfigVo(heroData.tid)
        local heroCard = HeroHeadGrid:poolGet()
        table.insert(randomeTable, heroVo:getHeroModel(heroData.body_fashion_id))
        heroCard:setData(heroVo)
        heroCard:setFashionId(heroData.body_fashion_id)
        heroCard:setParent(trans)
        heroCard:setLvl(heroData.lv)
        heroCard:setStarLvl(heroData.evolution)
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
