module("hero.HeroFlagManager", Class.impl(Manager))

-- 所有节点更新统一触发
FLAG_UPDATE = "FLAG_UPDATE"

--------------------------------------------------------- 根节点 ---------------------------------------------------------
-- 每个英雄的id根节点
FLAG_HERO_ID_ROOT = "FLAG_HERO_ID_ROOT"
--------------------------------------------------------- 子节点 ---------------------------------------------------------
-- 英雄是否有时装可激活
FLAG_BTN_FASHION_CLOTHES = "FLAG_BTN_FASHION_CLOTHES"
-- 英雄亲密度按钮入口
FLAG_BTN_FAVORABLE = "FLAG_BTN_FAVORABLE"

-- 英雄剧情
FLAG_BTN_STORY = "FLAG_BTN_STORY"
-- 英雄培养按钮入口
FLAG_BTN_DEVELOP = "FLAG_BTN_DEVELOP"
-- 英雄装备切卡
FLAG_BTN_EQUIP = "FLAG_BTN_EQUIP"
-- 英雄手环切卡
FLAG_BTN_BRACELETS = "FLAG_BTN_BRACELETS"

-- 英雄升级切卡
FLAG_TAB_LVL_UP = "FLAG_TAB_LVL_UP"
-- 英雄升品切卡
--FLAG_TAB_COLOR_UP = "FLAG_TAB_COLOR_UP"
-- 英雄进化切卡
FLAG_TAB_STAR_UP = "FLAG_TAB_STAR_UP"
-- 英雄军阶切卡
FLAG_TAB_RANK_UP = "FLAG_TAB_RANK_UP"
-- 英雄技能切卡
FLAG_TAB_SKILL_UP = "FLAG_TAB_SKILL_UP"

--增幅切卡
FLAG_TAB_GROW = "FLAG_TAB_GROW"
-------------------------------------------------------- 叶子节点 --------------------------------------------------------
-- 英雄是否可升级
FLAG_CAN_LVL_UP = "FLAG_CAN_LVL_UP"
-- 英雄是否可准备升阶
FLAG_CAN_READY_MILITARY_RANK_UP = "FLAG_CAN_READY_MILITARY_RANK_UP"
-- 英雄是否可升阶
FLAG_CAN_MILITARY_RANK_UP = "FLAG_CAN_MILITARY_RANK_UP"
-- 英雄是否技能可升级
FLAG_CAN_SKILL_UP = "FLAG_CAN_SKILL_UP"
-- 英雄是否可领取等级目标奖励
FLAG_CAN_LVL_TARGET_LIST = "FLAG_CAN_LVL_TARGET_LIST"
-- 英雄是否可培养DNA蛋功能
FLAG_CAN_DNA = "FLAG_CAN_DNA"
-- 英雄是否可升品
--FLAG_CAN_COLOR_UP = "FLAG_CAN_COLOR_UP"
-- 英雄是否可进化
FLAG_CAN_STAR_UP = "FLAG_CAN_STAR_UP"
-- 英雄是否有空槽部位且有装备可镶嵌
FLAG_CAN_WEAR_EQUIP = "FLAG_CAN_WEAR_EQUIP"
-- 英雄手环是否有空槽部位且有手环可镶嵌
FLAG_CAN_WEAR_BRACELETS = "FLAG_CAN_WEAR_BRACELETS"
-- 英雄是否可以增幅
FLAG_CAN_GROW = "FLAG_CAN_GROW"
-- 英雄是否可碎片激活
FLAG_CAN_FRAGMENT_COMPOSE = "FLAG_CAN_FRAGMENT_COMPOSE"
--------------------------------------------------------------------------------------------------------------------------

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    -- 是否存在有标识的英雄
    self.m_isExistFlagHero = false
    self.m_heroFlagDic = {}
    self.m_tree = {}
end

--------------------------------------------------------------------------------------------------------------------------

-- 增加对应英雄id的伪多叉树查询字典，不处理环路（手动填写规避）
function addFlagTree(self, heroId)
    if (not self.m_tree[heroId]) then
        self.m_tree[heroId] = {}

        -- 每个英雄都为独立树（单独一个字典，多一个根节点），所有英雄的根节点通过遍历每个独立树根节点获取
        local heroIdTree = self.m_tree[heroId]
        -- 英雄id根节点
        heroIdTree[self.FLAG_HERO_ID_ROOT] = { parent = nil }

        -- 时装按钮入口
        heroIdTree[self.FLAG_BTN_FASHION_CLOTHES] = { parent = self.FLAG_HERO_ID_ROOT }
        -- 培养按钮入口
        heroIdTree[self.FLAG_BTN_DEVELOP] = { parent = self.FLAG_HERO_ID_ROOT }
        -- 英雄是否可碎片激活入口
        heroIdTree[self.FLAG_CAN_FRAGMENT_COMPOSE] = { parent = self.FLAG_HERO_ID_ROOT }

        -- 等级切卡
        heroIdTree[self.FLAG_TAB_LVL_UP] = { parent = self.FLAG_BTN_DEVELOP }
        heroIdTree[self.FLAG_CAN_LVL_UP] = { parent = self.FLAG_TAB_LVL_UP }
        -- 好感度按钮入口
        heroIdTree[self.FLAG_BTN_FAVORABLE] = { parent = self.FLAG_TAB_LVL_UP }

        heroIdTree[self.FLAG_BTN_STORY] = { parent = self.FLAG_TAB_LVL_UP }

        heroIdTree[self.FLAG_CAN_LVL_TARGET_LIST] = { parent = self.FLAG_BTN_DEVELOP }
        heroIdTree[self.FLAG_CAN_DNA] = { parent = self.FLAG_BTN_DEVELOP }
        -- 升品切卡
        --heroIdTree[self.FLAG_TAB_COLOR_UP] = { parent = self.FLAG_BTN_DEVELOP }
        --heroIdTree[self.FLAG_CAN_COLOR_UP] = { parent = self.FLAG_TAB_COLOR_UP }
        -- 进化切卡
        heroIdTree[self.FLAG_TAB_STAR_UP] = { parent = self.FLAG_BTN_DEVELOP }
        heroIdTree[self.FLAG_CAN_STAR_UP] = { parent = self.FLAG_TAB_STAR_UP }
        --军阶切卡
        heroIdTree[self.FLAG_TAB_RANK_UP] = { parent = self.FLAG_BTN_DEVELOP }
        heroIdTree[self.FLAG_CAN_MILITARY_RANK_UP] = { parent = self.FLAG_TAB_RANK_UP }
        --技能切卡
        heroIdTree[self.FLAG_TAB_SKILL_UP] = { parent = self.FLAG_BTN_DEVELOP }
        heroIdTree[self.FLAG_CAN_SKILL_UP] = { parent = self.FLAG_TAB_SKILL_UP }
        -- 装备按钮入口
        heroIdTree[self.FLAG_BTN_EQUIP] = { parent = self.FLAG_HERO_ID_ROOT }
        heroIdTree[self.FLAG_CAN_WEAR_EQUIP] = { parent = self.FLAG_BTN_EQUIP }

        -- 手环按钮入口
        heroIdTree[self.FLAG_BTN_BRACELETS] = { parent = self.FLAG_HERO_ID_ROOT }
        heroIdTree[self.FLAG_CAN_WEAR_BRACELETS] = { parent = self.FLAG_BTN_BRACELETS }

        --英雄增幅
        heroIdTree[self.FLAG_TAB_GROW] = { parent = self.FLAG_BTN_DEVELOP }
        heroIdTree[self.FLAG_CAN_GROW] = { parent = self.FLAG_TAB_GROW }

        for flagType, dic in pairs(heroIdTree) do
            for _flagType, _dic in pairs(heroIdTree) do
                if (_flagType ~= flagType) then
                    if (_dic.parent == flagType) then
                        if (not dic.childList) then
                            dic.childList = {}
                        end
                        table.insert(dic.childList, _flagType)
                    end
                end
            end
        end
    end
end

-- 根据某一棵树的状态检测全部英雄树节点的状态
function checkAllTree(self, oneTreeFlag)
    -- 到达了指定英雄的id根节点
    local isFlag = self.m_isExistFlagHero
    -- print(string.format("4 更新id为%s的英雄的根节点（原本为%s）%s", heroId, isFlag, targetIsFlag))
    if (isFlag ~= oneTreeFlag) then
        -- 所有英雄树的根节点为ture，当前英雄树变更为false，需要判断下其他英雄数据是否都为false
        if (isFlag) then
            isFlag = self:getFlag()
        else
            isFlag = oneTreeFlag
        end
        -- print(string.format("5 所有英雄的根节点为%s", isFlag))
        if (self.m_isExistFlagHero ~= isFlag) then
            self.m_isExistFlagHero = isFlag
            -- 通知主UI红点
            mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_HERO, self.m_isExistFlagHero)
        end
    end
end

function delFlagTree(self, heroId)
    self:hideChildTree(heroId, self.FLAG_HERO_ID_ROOT)
    self:checkAllTree(false)
    self.m_tree[heroId] = nil
end

function hideChildTree(self, heroId, flagType)
    local heroIdTree = self.m_tree[heroId]
    if (heroIdTree) then
        local childList = heroIdTree[flagType].childList
        if (childList and #childList > 0) then
            for i = 1, #childList do
                self:hideChildTree(heroId, childList[i])
            end
        else
            self:setFlag(heroId, flagType, false)
        end
    end
end

function getFlag(self, heroId, flagType)
    if (not heroId) then
        -- 默认获取所有英雄根节点
        local isFlag = false
        for heroId, dic in pairs(self.m_heroFlagDic) do
            for flagType, dic in pairs(dic) do
                isFlag = self:getFlag(heroId, flagType)
                if (isFlag) then
                    break
                end
            end
            if (isFlag) then
                break
            end
        end
        return isFlag
    else
        if (flagType == nil) then
            -- 默认获取英雄id根节点
            flagType = self.FLAG_HERO_ID_ROOT
        end
        if (not self.m_heroFlagDic[heroId]) then
            self.m_heroFlagDic[heroId] = {}
        end
        local isFlag = self.m_heroFlagDic[heroId][flagType]
        return isFlag and true or false
    end
end

function setFlag(self, heroId, flagType, isFlag)
    isFlag = isFlag and true or false
    flagType = flagType or self.FLAG_HERO_ID_ROOT
    local _isFlag = self:getFlag(heroId, flagType)
    self.m_heroFlagDic[heroId][flagType] = isFlag
    if (_isFlag ~= isFlag) then
        -- print(string.format("1 id为%s的英雄的%s类型%s红点", heroId, flagType, isFlag and '显示' or '隐藏'))
        -- self:dispatchEvent(flagType, {heroId = heroId, flagType = flagType, isFlag = isFlag})
        self:dispatchEvent(self.FLAG_UPDATE, { heroId = heroId, flagType = flagType, isFlag = isFlag })

        self:checkParentFlag(heroId, flagType, isFlag)
    end
end

function checkParentFlag(self, heroId, flagType, targetIsFlag)
    local heroIdTree = self.m_tree[heroId]
    if (heroIdTree) then
        local selfNode = heroIdTree[flagType]
        if (selfNode) then
            local parentFlagType = selfNode.parent
            -- 非根节点，且父节点flag和目标flag状态不一致，则遍历检测更新所有父节点
            if (parentFlagType ~= nil) then
                local parentIsFlag = self:getFlag(heroId, parentFlagType)
                if (parentIsFlag ~= targetIsFlag) then
                    local parentNode = heroIdTree[parentFlagType]
                    if (parentIsFlag == false and targetIsFlag == true) then
                        -- print(string.format("2 更新id为%s的英雄的%s的父节点%s：%s", heroId, flagType, parentFlagType, targetIsFlag))
                        self:setFlag(heroId, parentFlagType, targetIsFlag)
                    elseif (parentIsFlag == true and targetIsFlag == false) then
                        local isParentHas = false
                        if (parentNode.childList) then
                            for i = 1, #parentNode.childList do
                                local childFlagType = parentNode.childList[i]
                                local _isFlag = self:getFlag(heroId, childFlagType)
                                if (_isFlag) then
                                    isParentHas = true
                                    break
                                end
                            end
                        end
                        if (isParentHas == false) then
                            -- print(string.format("3 更新id为%s的英雄的%s的父节点%s：%s", heroId, flagType, parentFlagType, targetIsFlag))
                            self:setFlag(heroId, parentFlagType, targetIsFlag)
                        end
                    end
                end
            else
                self:checkAllTree(targetIsFlag)
            end
        end
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- 英雄能否升级
function isHeroCanLvlUp(self, heroVo)
    if ((not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_LV_UP, false)) or (not self:getIsCanShowLvUpRed())) then
        return false
    end
    if (heroVo.lvl < heroVo:getMaxMilitaryLvl()) then
        local propsConfigVo, needCount = self:getLvlUpNeedPropsCount(heroVo)
        local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(propsConfigVo.tid, needCount, false, false)
        if (isEnough) then
            return true
        else
            return false
        end
    end
    return false
end

-- 是否可以升级红点提示
function getIsCanShowLvUpRed(self)
    local exceedNum = 0
    local lvAstrictDic = sysParam.SysParamManager:getValue(SysParamType.HERO_LV_UP_RED_ASTRICT)
    local astrictLv = lvAstrictDic[2]
    local astrictNum = lvAstrictDic[1]
    for _, heroVo in pairs(hero.HeroManager:getHeroDic()) do
        if heroVo.lvl >= astrictLv then
            exceedNum = exceedNum + 1
        end
    end
    return exceedNum < astrictNum
end
-- 是否可以升级技能提示
function getIsCanShowSkillUpRed(self)
    local exceedNum = 0
    local lvAstrictDic = sysParam.SysParamManager:getValue(SysParamType.HERO_SKILL_UP_RED_ASTRICT)
    local astrictLv = lvAstrictDic[2]
    local astrictNum = lvAstrictDic[1]
    for _, heroVo in pairs(hero.HeroManager:getHeroDic()) do
        if heroVo.lvl >= astrictLv then
            exceedNum = exceedNum + 1
        end
    end
    return exceedNum < astrictNum
end

-- 英雄能否升级技能
function isHeroCanSkillUp(self, heroVo)
    if ((not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_SKILL, false)) or (not self:getIsCanShowSkillUpRed())) then
        return false
    end
    local canUp = false
    for i = 1, #heroVo.baseSkillIdList do
        canUp = true
        local skillPos = i
        local skillVo = fight.SkillManager:getSkillRo(heroVo.baseSkillIdList[i])
        if heroVo.fightSkillDic then
            if heroVo.activeSkillDic[skillPos] and heroVo.fightSkillDic[skillPos].isUnlock == 1 then
                skillVo = fight.SkillManager:getSkillRo(heroVo.fightSkillDic[skillPos].skillId)
            end
        end
        if not self:checkLvUpHandle(heroVo.baseSkillIdList[i], heroVo) then
            canUp = false
        else
            local extraLv = heroVo:getExtraLv(heroVo.baseSkillIdList[i]) --附加等级
            local activeSkillLv = heroVo:getActiveSkill(heroVo.baseSkillIdList[i]) --技能等级
            local upLv =  activeSkillLv --技能养成等级
            local tureSkillLv = upLv + extraLv --当前的实际等级
            -- 判断升级材料
            local skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(heroVo.tid, skillVo:getRefID(), tureSkillLv)
            local costMoneyTid = skillUpVo.cost[1]
            local costMoneyCount = skillUpVo.cost[2]
            local costItem = skillUpVo.costItem
            local mon = MoneyUtil.getMoneyCountByTid(costMoneyTid)
            if mon < costMoneyCount then
                canUp = false
            end
            local canUpNum = 0
            for i = 1, #costItem do
                local needNum = costItem[i][2]
                local hasNum = bag.BagManager:getPropsCountByTid(costItem[i][1])
                if hasNum >= needNum then
                    canUpNum = canUpNum + 1
                else
                    canUp = false
                end
            end
            if canUpNum >= #costItem then
                return true
            end
        end
    end
    -- local num = canUp and 1 or 0
    -- logInfo("战员" .. heroVo.name .. "技能是否可升级" .. num)
    return canUp
end


function checkLvUpHandle(self, skillId,heroVo)
    local canUp = false
    local CurSkillVo = fight.SkillManager:getSkillRo(skillId)
    local skillId = CurSkillVo:getRefID()
    local extraLv = heroVo:getExtraLv(skillId) --附加等级
    local realMax =  sysParam.SysParamManager:getValue(SysParamType.SKILLREALYCEILING) -- 所有技能的可养成最大等级
    local maxLvl = realMax --技能最大等级
    if CurSkillVo:getType() == fight.FightDef.SKILL_TYPE_NORMAL_ATTACK then --普工
        if heroVo.color == hero.HeroColorType.R_CARD then
            maxLvl = realMax + sysParam.SysParamManager:getValue(SysParamType.NORMALSKILLREALYCEILING)
        end
    elseif CurSkillVo:getType() ~= fight.FightDef.SKILL_TYPE_PASSIVE_SKILL then --除天赋普工外的技能
        maxLvl = sysParam.SysParamManager:getValue(SysParamType.SKILLCEILING)
    end
    local isLock = true
    local isLvEnough = false
    local activeSkillLv = heroVo:getActiveSkill(skillId) --技能等级
    local upLv =  activeSkillLv --技能养成等级
    local tureSkillLv = upLv + extraLv --当前的实际等级
    local skillUpVo = hero.HeroSkillUpManager:getSkillUpConfigVo(heroVo.tid, skillId, tureSkillLv)
    isLvEnough = skillUpVo ~= nil and heroVo.militaryRank >= skillUpVo.needHeroRank--星级
    isLock = skillUpVo ~= nil and heroVo.evolutionLvl < skillUpVo.needStar--等级
    local isMaxLvl = tureSkillLv >= maxLvl
    if (isMaxLvl or (upLv>=realMax)) then
        return false
    end
    if (not isLock and isLvEnough) then
        canUp = true
    end
    return canUp
end

function getLvlUpNeedPropsCount(self, heroVo)
    local costTid = MoneyTid.HERO_GLOBAL_EXP_TID
    local propsConfigVo = props.PropsManager:getPropsConfigVo(costTid)
    if (propsConfigVo.effectType == UseEffectType.CONVERT_HERO_EXP) then
        local convertExp = propsConfigVo.effectList[1]
        local needExp = heroVo.maxExp - heroVo.exp
        if (needExp < 0) then
            needExp = 0
        end
        local needCount = math.ceil(needExp / convertExp)
        return propsConfigVo, needCount
    end
    return nil, nil
end

-- 英雄能否升阶
function isHeroCanMilitaryUp(self, heroVo)
    if (not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_LV_UP, false)) then
        return false
    end
    if (heroVo.lvl >= heroVo:getMaxMilitaryLvl()) then
        local maxMilitaryRank = hero.HeroMilitaryRankManager:getMaxMilitaryRankLvl(heroVo.tid)
        if (heroVo.militaryRank < maxMilitaryRank) then
            local curMilitaryRankVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(heroVo.tid, heroVo.militaryRank)
            local roleLv = role.RoleManager:getRoleVo():getPlayerLvl()
            if (roleLv < curMilitaryRankVo.needPlayerLvl) then
                return false
            end

            local stagePass = battleMap.MainMapManager:isStagePass(curMilitaryRankVo.stageId)
            -- 通关检测
            if stagePass and not stagePass then
                return false
            end

            -- 改成消耗道具材料的逻辑
            for i = 1, #curMilitaryRankVo.costList do
                local costData = curMilitaryRankVo.costList[i]
                if (bag.BagManager:getPropsCountByTid(costData[1]) < costData[2]) then
                    return false
                end
            end

            local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(curMilitaryRankVo.cost[1], curMilitaryRankVo.cost[2], false, false)
            if (not isEnough) then
                return false
            end
            return true
        end
    end
    return false
end

-- 英雄是否可以领取目标等级奖励
function isHeroCanRecLvlTarget(self, heroVo)
    return hero.HeroLvlTargetManager:isHeroLvlTargetListBubble(heroVo)
end

-- 英雄是否有dna功能相关红点
function isCanCultureDna(self, heroVo)
    return dna.DnaManager:getHeroDnaFuncRedFlag(heroVo)
end

-- 英雄是否已领取完目标等级奖励
function isHeroAllRecLvlTarget(self, heroVo)
    return hero.HeroLvlTargetManager:isHeroLvlTargetListAllBubble(heroVo)
end

-- 英雄能否升品
function isHeroCanColorUp(self, heroVo)
    if (not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_COLOR_UP, false)) then
        return false
    end
    local isCanColorUp = hero.HeroColorUpManager:isCanColorUp(heroVo.tid)
    if (isCanColorUp) then
        local maxColor = hero.HeroColorUpManager:getHeroMaxColor(heroVo.tid)
        if (heroVo.color < maxColor) then
            local nextColorUpConfigVo = hero.HeroColorUpManager:getHeroColorUpConfigVo(heroVo.tid, heroVo.color + 1)
            local costTid = nextColorUpConfigVo.cost[1]
            local costCount = nextColorUpConfigVo.cost[2]
            local needHeroTid = nextColorUpConfigVo.needHeroTid
            local needHeroNum = nextColorUpConfigVo.needHeroNum
            local needHeroColor = nextColorUpConfigVo.needHeroColor

            local heroDic = hero.HeroManager:getHeroDic()
            for id, _heroVo in pairs(heroDic) do

                if ((needHeroTid <= 0 or _heroVo.tid == needHeroTid) and _heroVo.color == needHeroColor and _heroVo.id ~= heroVo.id) then
                    if (hero.HeroUseCodeManager:getIsCanUse(_heroVo.id, false)) then
                        needHeroNum = needHeroNum - 1
                        if (needHeroNum <= 0) then
                            break
                        end
                    end
                end
            end
            if (needHeroNum <= 0) then
                local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(costTid, costCount, false, false)
                if (isEnough) then
                    return true
                end
            end
        end
    end
    return false
end

-- 英雄是否有手环可穿戴
function isHeroCanWearBracelets(self, heroVo)
    if (not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_BRACELETS, false)) then
        return false
    end
    local equipList = heroVo.equipList
    if (equipList) then
        local equipVo = heroVo:getEquipByPos(PropsEquipSubType.SLOT_7)
        if (not equipVo and self:isHasEquipForPos(PropsEquipSubType.SLOT_7, heroVo)) then
            return true
        end
    else
        --还没有详细数据，直接用预览数据里的空格子判断
        local emptyPosList = heroVo.emptyEquipPosList

        for _, pos in pairs(emptyPosList) do
            if (pos == 7 and self:isHasEquipForPos(pos, heroVo)) then
                return true
            end
        end
    end
    return false
end

-- 英雄能否进化
function isHeroCanStarUp(self, heroVo)
    if (not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_STAR, false)) then
        return false
    end
    local isCanStarUp = hero.HeroStarManager:isCanStarUp(heroVo.tid, heroVo.evolutionLvl + 1, heroVo.color)
    if (isCanStarUp) then
        local maxStarLvl = hero.HeroStarManager:getHeroMaxStarLvl(heroVo.tid)
        if (heroVo.evolutionLvl < maxStarLvl) then
            local nextStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(heroVo.tid, heroVo.evolutionLvl + 1)
            local costTid = nextStarConfigVo.cost[1]
            local costCount = nextStarConfigVo.cost[2]
            -- local needHeroTid = nextStarConfigVo.needHeroTid
            -- local needHeroNum = nextStarConfigVo.needHeroNum
            -- local needHeroColor = nextStarConfigVo.needHeroColor
            -- local heroDic = hero.HeroManager:getHeroDic()
            -- for id, _heroVo in pairs(heroDic) do
            --     if ((needHeroTid <= 0 or _heroVo.tid == needHeroTid) and _heroVo.color == needHeroColor and _heroVo.id ~= heroVo.id) then
            --         if(hero.HeroUseCodeManager:getIsCanUse(_heroVo.id, false))then
            --             needHeroNum = needHeroNum - 1
            --             if(needHeroNum <= 0)then
            --                 break
            --             end
            --         end
            --     end
            -- end
            -- if(needHeroNum <= 0)then
            local needCostProps = nextStarConfigVo.needCostProps
            local hasCount = bag.BagManager:getPropsCountByTid(needCostProps[1])
            if (hasCount >= needCostProps[2]) then
                local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(costTid, costCount, false, false)
                if (isEnough) then
                    return true
                end
            end
            -- end
        end
    end
    return false
end

-- 英雄是否有装备可以穿戴在空装备槽
function isHeroCanWearEquip(self, heroVo)
    if (not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP, false)) then
        return false
    end
    local equipList = heroVo.equipList
    if (heroVo and equipList) then
        for pos = 1, 6 do
            local equipVo = nil
            for i = 1, #equipList do
                if (equipList[i].subType == pos) then
                    equipVo = equipList[i]
                    break
                end
            end
            if (not equipVo and self:isHasEquipForPos(pos, heroVo)) then
                return true
            end
        end
    else
        -- 还没有详细数据，直接用预览数据里的空格子判断
        local emptyPosList = heroVo.emptyEquipPosList
        for _, pos in pairs(emptyPosList) do
            if (pos <= 6 and self:isHasEquipForPos(pos, heroVo)) then
                return true
            end
        end
    end
    return false
end

-- 英雄指定空装备槽是否有装备可以穿戴
function isHasEquipForPos(self, pos, heroVo)
    local subType = pos
    local systemParam = sysParam.SysParamManager:getValue(921)[pos]
    if heroVo.militaryRank < systemParam then
        return false
    end
    local equipList = bag.BagManager:getPropsListByType(PropsType.EQUIP, subType)
    local verList = {}
    for i = 1, #equipList do
        if equipList[i].heroId == 0 then
            table.insert(verList, equipList[i])
        end
    end

    return #verList > 0
    --return #equipList > 0
end

-- 英雄是否可以增幅
function isHeroCanGrow(self, heroVo)
    if (not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_GROW, false)) then
        return false
    end

    local heroIncreases = hero.HeroManager:getHeroIncreaseData(heroVo.tid)
    local currentLv = heroVo.growLv
    local maxLv = sysParam.SysParamManager:getValue(821)
    if maxLv > currentLv then
        local ok = false
        local cusLvData = heroIncreases.increaseDic[currentLv]

        local needLv = cusLvData.needHeroLv
        if needLv > heroVo.lvl then
            return false
        end

        for i = 1, #cusLvData.const do
            local needNum = cusLvData.const[i][2]
            local hasNum = bag.BagManager:getPropsCountByTid(cusLvData.const[i][1])

            if hasNum < needNum then
                return false
            end
        end

        local mon = MoneyUtil.getMoneyCountByTid(cusLvData.payId)
        return mon >= cusLvData.payNum
    else
        return false
    end
end

-- 未获得的英雄是否可以解锁
function isHeroCanUnLock(self, heroConfigVo)
    return bag.BagManager:getPropsCountByTid(heroConfigVo.needFragment[1]) >= heroConfigVo.needFragment[2]
end

-- 根据英雄tid获取唯一id
function getConfigId(self, tid)
    return tid + 10000000
end

-- 获取所有英雄红点除了指定英雄不判断
function getAllFlagExceptHero(self, heroId, hideflagType, checkList)
    local heroDic = hero.HeroManager:getHeroDic()
    for _heroId, _ in pairs(heroDic) do
        if (_heroId ~= heroId) then
            if (checkList and table.keyof(checkList, _heroId)) then
                if self:getFlag(_heroId, hideflagType) then
                    return true
                end
            elseif not checkList then
                if self:getFlag(_heroId, hideflagType) then
                    return true
                end
            end
        end
    end
    return false
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]