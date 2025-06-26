module("hero.HeroFlagController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:__init()
end

function __init(self)
    self.m_isHeroDataOk = false
    self.m_isBagDataOk = false
    self.m_isFormationDataOk = false
    self.m_isMoneyataOk = false
    self.m_isUseCodeDataOk = false
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.__onMoneyUpdateHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_LVL, self.__onPlayerLvlUpdateHandler, self)

    bag.BagManager:addEventListener(bag.BagManager.BAG_INIT, self.__onBagUpdateHandler, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.__onBagUpdateHandler, self)
    hero.HeroLvlTargetManager:addEventListener(hero.HeroLvlTargetManager.UPDATE_LVL_TARGET_lIST, self.onHeroLvlTargetUpdateHandler, self)

    formation.FormationManager:addEventListener(formation.FormationManager.UPDATE_TEAM_FORMATION_DATA, self.__onFormationUpdateHandler, self)
    formation.FormationManager:addEventListener(formation.FormationManager.UPDATE_FIGHT_TEAM_ID, self.__onFormationUpdateFightTeamHandler, self)

    hero.HeroUseCodeManager:addEventListener(hero.HeroUseCodeManager.UPDATE_HERO_USECODE, self.__onHeroUseCodeUpdateHandler, self)

    GameDispatcher:addEventListener(EventName.HERO_LIST_INIT, self.__onHeroListInitHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_LIST_UPDATE, self.__onHeroListUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.__onHeroDetailUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SKILL_UP_PANEL, self.__onHeroDetailUpdateHandler, self)

    -- 英雄数据字段更新
    hero.HeroManager:addEventListener(hero.HeroManager.UPDATE_FIELD, self.__onHeroDataFieldUpdateHandler, self)

    GameDispatcher:addEventListener(EventName.UPDATE_FAVORABLE, self.onUpdateFavorable, self)
    GameDispatcher:addEventListener(EventName.FAVORABLE_REWARD_GAIN_UPDATE, self.onUpdateFavorable, self)

    --程序手动检查战员红点
    GameDispatcher:addEventListener(EventName.CHECK_ALL_HERO_RED, self.onCheckAllHeroRedHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end

function __isDataOk(self)
    --可删除战员列表功能后端已屏蔽 
    self.m_isUseCodeDataOk = true
    return self.m_isHeroDataOk and self.m_isBagDataOk and self.m_isMoneyataOk and self.m_isUseCodeDataOk and self.m_isFormationDataOk
end

-- 货币更新
function __onMoneyUpdateHandler(self)
    self.m_isMoneyataOk = true
    self:__checkAllHasGetHeroFlag()
end

-- 玩家等级更新
function __onPlayerLvlUpdateHandler(self)
    self:__checkAllHasGetHeroFlag()
end

function __updateGrowAttrHanlder(self)
    self:__checkAllHasGetHeroFlag()
end

-- 背包更新
function __onBagUpdateHandler(self)
    self.m_isBagDataOk = true
    self:__checkAllHasGetHeroFlag()
    self:__checkAllUnGetHeroFlag()
end

-- 英雄等级目标管理更新
function onHeroLvlTargetUpdateHandler(self)
    self:__checkAllHasGetHeroFlag()
end

-- 阵型更新
function __onFormationUpdateHandler(self)
    self.m_isFormationDataOk = true
    self:__checkAllHasGetHeroFlag()
end

-- 出战id更新
function __onFormationUpdateFightTeamHandler(self)
    self:__checkAllHasGetHeroFlag()
end

-- 英雄使用码更新
function __onHeroUseCodeUpdateHandler(self)
    self.m_isUseCodeDataOk = true
    self:__checkAllHasGetHeroFlag()
end

-- 英雄列表初始化
function __onHeroListInitHandler(self, args)
    self.m_isHeroDataOk = true
    self:__checkAllHasGetHeroFlag()
    self:__checkAllUnGetHeroFlag()
end

function onUpdateFavorable(self)
    self:__checkAllHasGetHeroFlag()
end

function onCheckAllHeroRedHandler(self)
    self:__checkAllHasGetHeroFlag()
end

-- 英雄列表更新
function __onHeroListUpdateHandler(self, args)
    for i = 1, #args.delList do
        hero.HeroFlagManager:delFlagTree(args.delList[i])
    end
    -- 新增的英雄直接删除未获得英雄的相关红点
    for i = 1, #args.addList do
        local heroVo = hero.HeroManager:getHeroVo(args.addList[i])
        local heroId = hero.HeroFlagManager:getConfigId(heroVo.tid)
        hero.HeroFlagManager:delFlagTree(heroId)
    end
    -- 这里需要全部刷新
    self:__checkAllHasGetHeroFlag()
end

-- 英雄详细数据更新
function __onHeroDetailUpdateHandler(self, args)

    local heroId = args.heroId
    self:__checkHasGetHeroFlag(hero.HeroManager:getHeroVo(heroId))
end

-- 英雄数据指定字段更新
function __onHeroDataFieldUpdateHandler(self, args)
    local heroId = args.heroId
    local fieldType = args.fieldType
    if (fieldType == hero.DataFieldKey.HERO_EVOLUTION_LVL
    or fieldType == hero.DataFieldKey.HERO_MILITARY_RANK
    or fieldType == hero.DataFieldKey.HERO_GROW_LV
    ) then
        -- 只影响英雄自身
        self:__checkHasGetHeroFlag(hero.HeroManager:getHeroVo(heroId))
    elseif (fieldType == hero.DataFieldKey.HERO_LEVEL
    or fieldType == hero.DataFieldKey.HERO_EXP
    or fieldType == hero.DataFieldKey.HERO_MAX_EXP
    or fieldType == hero.DataFieldKey.HERO_COLOR
    ) then
        -- 可能影响包括其他所有英雄（比如其他英雄升级或进化需要吃对应等级或品质的材料英雄）
        self:__checkAllHasGetHeroFlag()
    end
end

-- 检查所有英雄
function __checkAllHasGetHeroFlag(self)
    if (not self:__isDataOk()) then
        return
    end
    local heroDic = hero.HeroManager:getHeroDic()
    for heroId, heroVo in pairs(heroDic) do
        self:__checkHasGetHeroFlag(heroVo)
    end
end

-- 检查指定英雄
function __checkHasGetHeroFlag(self, heroVo)
    if (not self:__isDataOk()) then
        return
    end

    -- 是否英雄相关培养功能开启
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_CULTURE, false) == false then
        return
    end

    -- 所有英雄都检测升品红点
    hero.HeroFlagManager:addFlagTree(heroVo.id)
    --if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_COLOR_UP, false) then
    --    -- 能否升品
    --    local isCanColorUp = hero.HeroFlagManager:isHeroCanColorUp(heroVo)
    --    hero.HeroFlagManager:setFlag(heroVo.id, hero.HeroFlagManager.FLAG_CAN_COLOR_UP, (isCanColorUp and hero.HeroUseCodeManager:isOnUseCode(heroVo.id) ~= false))
    --    -- print(string.format("英雄%s%s升品", heroVo.id, isCanColorUp and "能" or "不能"))
    --end

    -- 只判断进攻队列中或者防守队列中的英雄
    if (not hero.HeroUseCodeManager:isInUse(heroVo.id, hero.HeroUseCodeManager.IN_TEAM_FORMATION) and not hero.HeroUseCodeManager:isInUse(heroVo.id, hero.HeroUseCodeManager.IN_ARENA_DEFENSE)) then
        hero.HeroFlagManager:delFlagTree(heroVo.id)
        return
        --else
        -- hero.HeroFlagManager:addFlagTree(heroVo.id)
    end

    -- print(string.format("\n开始检测英雄%s", heroVo.id))
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_LV_UP, false) then
        -- 能否升级
        local isCanLvlUp = hero.HeroFlagManager:isHeroCanLvlUp(heroVo)
        hero.HeroFlagManager:setFlag(heroVo.id, hero.HeroFlagManager.FLAG_CAN_LVL_UP, hero.HeroUseCodeManager:isOnUseCode(heroVo.id, isCanLvlUp))
        -- print(string.format("英雄%s%s升级", heroVo.id, isCanLvlUp and "能" or "不能"))

        -- 能否升阶
        local isCanMilitaryUp = hero.HeroFlagManager:isHeroCanMilitaryUp(heroVo)
        hero.HeroFlagManager:setFlag(heroVo.id, hero.HeroFlagManager.FLAG_CAN_MILITARY_RANK_UP, hero.HeroUseCodeManager:isOnUseCode(heroVo.id, isCanMilitaryUp))
        -- print(string.format("英雄%s%s升阶", heroVo.id, isCanMilitaryUp and "能" or "不能"))

        -- 能否领取等级目标奖励
        local isCanRecLvlTargetList = hero.HeroFlagManager:isHeroCanRecLvlTarget(heroVo)
        hero.HeroFlagManager:setFlag(heroVo.id, hero.HeroFlagManager.FLAG_CAN_LVL_TARGET_LIST, isCanRecLvlTargetList)
        -- print(heroVo.id, hero.HeroFlagManager:getFlag(heroVo.id), "+++++++++++++++++++")

        -- 英雄是否可培养DNA蛋功能
        -- local isCanCultureDna = hero.HeroFlagManager:isCanCultureDna(heroVo)
        local idRead = dna.DnaManager:getReadModelRed(heroVo)
        hero.HeroFlagManager:setFlag(heroVo.id, hero.HeroFlagManager.FLAG_CAN_DNA, idRead)
    end


    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_STAR, false) then
        -- 能否进化
        local isCanStarUp = hero.HeroFlagManager:isHeroCanStarUp(heroVo)
        hero.HeroFlagManager:setFlag(heroVo.id, hero.HeroFlagManager.FLAG_CAN_STAR_UP, isCanStarUp)
    end

    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_SKILL, false) then
        -- 能否技能升级
        local isCanSkillUp = hero.HeroFlagManager:isHeroCanSkillUp(heroVo)
        hero.HeroFlagManager:setFlag(heroVo.id, hero.HeroFlagManager.FLAG_CAN_SKILL_UP, hero.HeroUseCodeManager:isOnUseCode(heroVo.id, isCanSkillUp))
    end
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_GROW, false) then
        -- 能否增幅
        local isCanGrow = hero.HeroFlagManager:isHeroCanGrow(heroVo)
        hero.HeroFlagManager:setFlag(heroVo.id, hero.HeroFlagManager.FLAG_CAN_GROW, hero.HeroUseCodeManager:isOnUseCode(heroVo.id, isCanGrow))
    end
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_BRACELETS, false) then
        -- 是否有装备可以穿戴在空装备槽
        local isCanWearBracelets = hero.HeroFlagManager:isHeroCanWearBracelets(heroVo)
        hero.HeroFlagManager:setFlag(heroVo.id, hero.HeroFlagManager.FLAG_CAN_WEAR_BRACELETS, hero.HeroUseCodeManager:isOnUseCode(heroVo.id, isCanWearBracelets))
    end
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP, false) then
        -- 是否有装备可以穿戴在空装备槽
        local isCanWearEquip = hero.HeroFlagManager:isHeroCanWearEquip(heroVo)
        hero.HeroFlagManager:setFlag(heroVo.id, hero.HeroFlagManager.FLAG_CAN_WEAR_EQUIP, hero.HeroUseCodeManager:isOnUseCode(heroVo.id, isCanWearEquip))
    end


    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FAVORABLE, false) then
        --战员好感
        local hasCaseReward = favorable.FavorableManager:getCaseRewardHasRed(heroVo.id)
        hero.HeroFlagManager:setFlag(heroVo.id, hero.HeroFlagManager.FLAG_BTN_FAVORABLE, hasCaseReward)
    end

    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FAVORABLE, false) then
        --战员好感剧情
        local hasCaseReward = favorable.FavorableManager:getStoryRewardHasRed(heroVo.id)
        hero.HeroFlagManager:setFlag(heroVo.id, hero.HeroFlagManager.FLAG_BTN_STORY, hasCaseReward)
    end

    if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_FASHION, false) and fashion.FashionManager:getFashionEnable(heroVo.tid)) then
        --战员时装—服饰
        local ishasFashion = fashion.FashionManager:isHeroFashionBubble(heroVo.id)
        hero.HeroFlagManager:setFlag(heroVo.id, hero.HeroFlagManager.FLAG_BTN_FASHION_CLOTHES, ishasFashion)
    end
end

-- 检查所有未获得英雄
function __checkAllUnGetHeroFlag(self)
    if (not self.m_isHeroDataOk or not self.m_isBagDataOk) then
        return
    end

    local unGetCanComposeList, unGetUnComposeList = hero.HeroManager:getUnGetHeroList()
    for i = 1, #unGetCanComposeList do
        self:__checkUnGetHeroFlag(unGetCanComposeList[i])
    end
    for i = 1, #unGetUnComposeList do
        self:__checkUnGetHeroFlag(unGetUnComposeList[i])
    end
end

-- 检查指定未获得英雄
function __checkUnGetHeroFlag(self, heroConfigVo)
    if (not self.m_isHeroDataOk or not self.m_isBagDataOk) then
        return
    end

    -- 是否英雄相关培养功能开启
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_CULTURE, false) == false then
        return
    end

    local heroId = hero.HeroFlagManager:getConfigId(heroConfigVo.tid)
    hero.HeroFlagManager:addFlagTree(heroId)
    -- 能否解锁
    local isCanUnLock = hero.HeroFlagManager:isHeroCanUnLock(heroConfigVo)
    hero.HeroFlagManager:setFlag(heroId, hero.HeroFlagManager.FLAG_CAN_FRAGMENT_COMPOSE, isCanUnLock)
    -- print(string.format("英雄%s%s解锁", heroConfigVo.tid, isCanUnLock and "能" or "不能"))
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]