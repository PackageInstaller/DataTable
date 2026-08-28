--
-- Author:luqucheng
-- Date: 2019-11-09 16:45:08
--

local AICardEstimate = import('Game.Battle.Script.AICardEstimate')

---@class AI
local AI = {}

--辨识技能的大致类型选择ai
local SkillType = {
    Damage = 1,
    Heal = 2,
    Other = 3,
}

local AIStarParams = {
    [Constants.RoleClass.Creep] = {50, 30, 20},
    [Constants.RoleClass.Elite] = {20, 35, 45},
    [Constants.RoleClass.Boss] = {20, 20, 60},
}
local AIActionCount = {
    [Constants.RoleClass.Creep] = 1,
    [Constants.RoleClass.Elite] = 1,
    [Constants.RoleClass.Boss] = 2,
}

--@levelData: [Game.Setting.Vo.WaveVo#WaveVo<>]
function AI:GetRoundActionData( levelData )
    --@RefType[Game.Setting.Vo.WaveVo#WaveVo]
    local waveData = levelData[BattleMgr.nowWave]
    if not waveData then
        return nil
    end
    --看看是循环行为还是初始化行为
    local round = BattleMgr.turnCount

    if waveData.hasInitAction and round <= waveData.initRoundNum then
        --初始化回合
        return waveData.initActions[round]
    end

    if waveData.hasloopAction and round > waveData.initRoundNum then
        --循环回合
        --确定index
        local index = (round - waveData.initRoundNum - 1) % waveData.loopRoundNum + 1
        return waveData.loopActions[index]
    end
end

function AI:AIChooseSkillCard(cardMgr)
    local slotIndex = #cardMgr.nowTurnUsedCards + 1
    local pos = self:AIChooseSkillCardPos(slotIndex, cardMgr)
    if isNull(pos) then
        return
    end
    local skillCardData, card = cardMgr:GetCardSkillByPos(pos)
    local role = Core:FindRole(card.roleId)
    return pos, self:ChooseSkillTarget(role, skillCardData, true), self:GetCardBehaviorParams(pos, cardMgr)
end

function AI:AIChooseSkillCardPos(slotIndex, cardMgr)
    if cardMgr:AiCanUseCatCard(slotIndex) then
        -- 猫卡可用时，优先计算猫卡的效能
        local catPos = cardMgr:GetCatSkillCardPos()
        local skillCardData, card = cardMgr:GetCardSkillByPos(catPos)
        local role = Core:FindRole(card.roleId)
        local catScore = AICardEstimate:Estimate(skillCardData, card.star, role, {})
        if catScore >= Core:GetBattleParamNum("normalAbandon") and catPos then
            return catPos
        end
        print("[猫卡] ai转让出牌,当前效能 ", catScore)
    end

      --根据位置顺序找寻优先出牌角色
      local role = self:FindRoleWithSlotIndex(slotIndex, cardMgr)
  
      --评估该角色的卡，剔除被禁止或在ai cd中的牌，若释放迫切度大于50%，则直接使用
      local maxCardPos, maxScore = self:FindMostValuableCard(role.id, cardMgr, false)
      if maxScore >= Core:GetBattleParamNum("normalAbandon") and maxCardPos then
          return maxCardPos
      end
  
      --若小于等50%，则进入转让逻辑
      --找寻所有人中迫切度最高的牌
      local allMaxCardPos, allMaxScore = self:FindMostValuableCard(0, cardMgr, false)
  
      --其他人的牌只有大于等于1的迫切度，才可以转让
      if (allMaxScore >= 1 or maxScore <= Core:GetBattleParamNum("absoluteAbandon")) and allMaxCardPos then
          return allMaxCardPos
      end
  
      --不转移且自己有可出的牌，则直接出
      if maxCardPos then
          return maxCardPos
      end
  
      --其他牌都在cd内，则强制找一张价值最高的，无视cd
      allMaxCardPos, allMaxScore = self:FindMostValuableCard(0, cardMgr, true)
      if not allMaxCardPos then
          --报错
        --   printError(string.format("%d_%s_%d", role.typeId,'找不到可以ai使用的技能:', slotIndex))
        -- 最新的版本中，如果当前队伍中只剩下 158008 佐伊 自己，佐伊可能因为释放大招而导致牌库清空，遭遇无牌可出的尴尬境地
        -- 所以这里做个保底，允许不出牌
          return
      end
  
      return allMaxCardPos
end

function AI:GetCardBehaviorParams(pos, cardMgr)
    local camp = cardMgr.camp
    local skillCardData, card = cardMgr:GetCardSkillByPos(pos)
    -- local role = Core:FindRole(card.roleId)
    local switch = {
        [Constants.CardBehavior.Swallow] = function ()
            --选择当前牌中除自己之外迫切度最低的
            local leastPos, leastScore = self:FindValuableCard(cardMgr, 
                function (s1, s2)
                    s1 = s1 or 1
                    return s2 <= s1
                end,
                true,
                nil,
                function (c, p)
                    return (p[1] == pos[1] and p[2] == pos[2]) or c.isUltra
                end
            )
            return leastPos
        end,
        [Constants.CardBehavior.Search] = function ()
            --选择备选卡中迫切度最高的
            -- AICardEstimate:Estimate(skillCardData, card.star, role, {})

            local star = skillCardData.cardBehaviorParam[1]
            star = Tools.isNullKey(skillCardData.cardBehaviorParam[1]) and card.star or star
            local cardInfos = {}
            local rs = BattleMgr:GetAliveRolesWithoutSpecialSummon(camp)
            for i,r in ipairs(rs) do
                --不能发现自己的卡
                if r.id ~= card.roleId then
                    local card1 = r:GetSkillCardDataByIndex(1)
                    if card1 and card1.cardBehavior ~= Constants.CardBehavior.Search then
                        table.insert(cardInfos, {card = card1, role = r, skillIndex = 1})
                    end

                    local card2 = r:GetSkillCardDataByIndex(2)
                    if card2 and card2.cardBehavior ~= Constants.CardBehavior.Search then
                        table.insert(cardInfos, {card = card2, role = r, skillIndex = 2})
                    end
                end
            end

            if #cardInfos <= 0 then
                return nil
            end

            table.inPlaceBubbleSort(cardInfos, function (cardInfo1, cardInfo2)
                local scord1 = AICardEstimate:Estimate(cardInfo1.card, star, cardInfo1.role, {})
                local scord2 = AICardEstimate:Estimate(cardInfo2.card, star, cardInfo2.role, {})
                return scord1 > scord2
            end)
        
            return {roleId = cardInfos[1].role.id, star = star, skillIndex = cardInfos[1].skillIndex }
        end,

        [Constants.CardBehavior.Choose] = function ()
            local star = card.star
            local r = Core:FindRole(card.roleId)

            local cardIndexes = skillCardData.cardBehaviorParam
            local cardInfos = {}
            for i,index in ipairs(cardIndexes) do
                local card = r:GetSkillCardDataByIndex(index)
                if card then
                    table.insert(cardInfos, {card = card, role = r, skillIndex = index})
                end
            end

            if #cardInfos <= 0 then
                return nil
            end

            table.inPlaceBubbleSort(cardInfos, function (cardInfo1, cardInfo2)
                local scord1 = AICardEstimate:Estimate(cardInfo1.card, star, cardInfo1.role, {})
                local scord2 = AICardEstimate:Estimate(cardInfo2.card, star, cardInfo2.role, {})
                return scord1 > scord2
            end)
        
            return {roleId = cardInfos[1].role.id, star = star, skillIndex = cardInfos[1].skillIndex }
        end,
        [Constants.CardBehavior.Upgrade] = function ()
            --选择当前牌中除自己之外迫切度最高的
            local leastPos, leastScore = self:FindValuableCard(cardMgr, 
                function (s1, s2)
                    s1 = s1 or 0
                    return s2 >= s1
                end,
                true,
                nil,
                function (c, p)
                    return (p[1] == pos[1] and p[2] == pos[2]) or c.isUltra
                end
            )
            return leastPos
        end,
    }

    local func = switch[skillCardData.cardBehavior]

    if func then
        return func()
    end
end

function AI:CardCanBeSwallow()
    --大招卡不能被吞噬
end


--roleId为0则表示找所有该阵营的所有卡, isForce表示无视cd
function AI:FindMostValuableCard(roleId, cardMgr, isForce)
    -- local player = BattleMgr:GetPlayer(camp)

    -- local maxScore = 0
    -- local maxCardPos = nil
    -- local len1 = #player.cardMgr.row1
    -- local len2 = #player.cardMgr.row2
    -- for i=1,len1 + len2 do
    --     local pos = {i <= len1 and i or i - len1, i <= len1 and 1 or 2}
    --     local card = player.cardMgr:FindCard(pos)
    --     if roleId == 0 or card.roleId == roleId then
    --         local score = self:EstimateCardScore(pos, camp, isForce)
    --         if score > maxScore then
    --             maxScore = score
    --             maxCardPos = pos
    --         end
    --     end
    -- end

    -- return maxCardPos, maxScore
    return self:FindValuableCard(cardMgr, 
        function (s1, s2)
            s1 = s1 or -2
            return s2 > s1
        end,
        isForce,
        function (card, pos)
            return roleId == 0 or card.roleId == roleId
        end
    )
end

--roleId为0则表示找所有该阵营的所有卡, isForce表示无视cd
function AI:FindValuableCard(cardMgr, comparer, isForce, includeFunc, excludeFunc)
    local camp = cardMgr.camp
    local finalScore = nil
    local finalCardPos = nil
    local len1 = #cardMgr.row1
    local len2 = #cardMgr.row2
    for i=1,len1 + len2 do
        local pos = {i <= len1 and i or i - len1, i <= len1 and 1 or 2}
        local card = cardMgr:FindCard(pos)
        if (not includeFunc or includeFunc(card, pos)) and (not excludeFunc or not excludeFunc(card, pos)) then
            local score = self:EstimateCardScore(pos, cardMgr, isForce)
            if comparer(finalScore, score) then
                finalScore = score
                finalCardPos = pos
            end
        end
    end

    return finalCardPos, finalScore or 0
end

function AI:EstimateCardScore(pos, cardMgr, isForce)
    if not cardMgr then
        return -100
    end
    
    local skillCardData, card = cardMgr:GetCardSkillByPos(pos)
    local role = Core:FindRole(card.roleId)
    local offense = role:GetOffenseAbilityEstimateValue()
    if not skillCardData:CanDischarge(role) then
        return -1
    end

    --使用次数限制
    local useCount = 0
    for i,v in ipairs(cardMgr.nowTurnUsedCards) do
        if v.roleId == card.roleId and v.skillIndex == card.skillIndex then
            --相同卡计算使用次数
            useCount  = useCount + 1
        end
    end
    if useCount >= skillCardData.cdAI and not isForce then
        return -1
    end

    --计算迫切度
    return AICardEstimate:Estimate(skillCardData, card.star, role, {})
end

function AI:FindRoleWithSlotIndex(slotIndex, cardMgr)
    local rs = cardMgr:GetRoles()
    if #rs <= 0 then
        return
    end
    if slotIndex > #rs then
        return rs[1]
    end
    
    return rs[slotIndex]
end

function AI:GetChoosableCardNum( cardMgr )
    local total = 0
    for i,v in ipairs(cardMgr.row1) do
        local card = cardMgr:FindCard({i, 1})
        local role = Core:FindRole(card.roleId)
        if role:CanSkillCardBeUsed(card.skillIndex) then
            total = total + 1
        end
    end
    for i,v in ipairs(cardMgr.row2) do
        local card = cardMgr:FindCard({i, 2})
        local role = Core:FindRole(card.roleId)
        if role:CanSkillCardBeUsed(card.skillIndex) then
            total = total + 1
        end
    end

    return total
end

--@return [Game.Battle.Entity.Role#Role]
function AI:ChooseSkillTarget( role, skillCard, useSelectedTarget )
    local target = nil
    local switch = {
        [Constants.SkillLabel.Attack] = function ()
            if not role:IsMonster() then
                target = self:PVEPlayerGetAttackFitTarget(role, skillCard, useSelectedTarget)
            else
                target = self:PVECreepGetAttackFitTarget(role, skillCard)
            end
        end,
        [Constants.SkillLabel.Heal] = function (  )
            target = self:GetHealFitTarget(role, skillCard)
        end,
        [Constants.SkillLabel.Debuff] = function (  )
            if not role:IsMonster() then
                target = self:PVEPlayerGetAttackFitTarget(role, skillCard, useSelectedTarget)
            else
                target = self:PVECreepGetAttackFitTarget(role, skillCard)
            end
        end,
        [Constants.SkillLabel.Buff] = function (  )
            target = self:GetOtherFitTarget(role, skillCard)
        end,
    }
    local label = skillCard.autoLabel > 0 and skillCard.autoLabel or skillCard.label
    -- local target = self:GetFitTarget(role, skill)
    local func = switch[label]
    if not func then 
        func = switch[Constants.SkillLabel.Attack]
    end
    func()
    return target
end

--@target: [Game.Battle.Entity.Role#Role]
function AI:CheckTaunt( role, target, skillCardData, star )


    if target == nil then
        return
    end
    if skillCardData.clickType ~= Constants.TargetCamp.Enemy then
        return target
    end
    local Special = Constants.BuffType.Special
    local Taunt = Constants.SpecialBuffType.Taunt
    local Angry = Constants.SpecialBuffType.Angry
    local Expose = Constants.SpecialBuffType.Expose


    --如果自身带有单嘲效果,单嘲优先
    if role.buffMgr:HasBuffByType(Special, Angry, 0) then
        local ts = {}
        role.buffMgr:WalkAllBuffEffects(function ( buffEffect )
            if buffEffect.data.mainEffectType == Special and buffEffect.data.subEffectType == Angry then
                --检测是否是当前目标，是的话直接选择就可以
                local t = buffEffect.buff.attacker
                if t and t:CanBeClicked(role) then
                    if t == target then
                        return target
                    end
                    table.insert(ts, t)
                end
            end
        end)

        --随机一个目标
        local randomTarget = Core:RandomSelect(ts)

        --有可能存在有嘲讽，但是嘲讽的发起者已经无法被选择了, 那就需要继续往下看
        if randomTarget then
            return randomTarget
        end
    end

    --如果目标自带嘲讽,也直接返回
    if target.buffMgr:HasBuffByType(Special, Taunt, 0) and target:CanBeClicked(role) then
        return target
    end

    --自身带有暴露效果，就无视后面的群嘲
    if target.buffMgr:HasBuffByType(Special, Expose, 0) and target:CanBeClicked(role) then
        return target
    end

    --目标选择范围内有敌方的嘲讽单位，且跟选择的单位不一致
    local camp = skillCardData.clickType
    local roles = BattleMgr.roles
    local l = Core:GetCampTargets(role, roles, camp)
    --过滤掉所有不能选择的目标
    for i,v in ipairs(l) do
        if v:CanBeClicked(role) 
            and v.id ~= target.id
            and v.buffMgr:HasBuffByType(Special, Taunt, 0) then
            --身上有没有嘲讽buff
            return v
        end
    end

    -- 针对指定skillTag的暴露
    for i,v in ipairs(l) do
        if v:CanBeClicked(role) and v.id ~= target.id then
            -- 先假设要打这个目标，看看应该会触发那个skill
            local skillId = Core:GetOverwirteSkill(skillCardData, role, v, star)
            if Tools.isNullKey(skillId) then
                --找不到技能
                printError('找不到技能卡对应的技能, skillCardId:'..skillCardData.id .. "  star:" .. star)
            end
            local skill = role:GetSkill(skillId, star)
            if not skill then
                --找不到技能
                printError('找不到技能, skillId:'..skillId)
            end
            -- 检查目标是否对这个技能的skillTag有暴露
            if v.buffMgr:MarkForSkillTag(skill.skillTags) then
                -- 恰好目标对这个技能有暴露，那么暴露效果生效
                return v
            end
        end
    end

    return target
end

function AI:GetHealFitTarget( role, skillCard )
    --默认治疗当前血量绝对值最少的单位
    local camp = skillCard.clickType
    local roles = BattleMgr.roles
    local l = Core:GetCampTargets(role, roles, camp)
    local rs = {}
    --过滤掉所有不能选择的目标
    for i,v in ipairs(l) do
        if v:CanBeSelected() then
            table.insert(rs, v)
        end
    end

    --处理友方不可选中单位问题，这边直接做排序
    local sort = function ( t1, t2 )
         --目标如果不可被点击，优先级最低
         if not t1:CanBeClicked(role) then
            return false
        end

        if not t2:CanBeClicked(role) then
            return true
        end
        return t1:GetNowHPPercent() < t2:GetNowHPPercent() 
    end
    table.inPlaceBubbleSort(rs, sort)
    return rs[1]
end

function AI:GetOtherFitTarget( role, skillCard )
    --释放目标为初始战斗力*血量百分比最高的单位
    local camp = skillCard.clickType
    local roles = BattleMgr.roles
    local l = Core:GetCampTargets(role, roles, camp)
    local rs = {}
    --过滤掉所有不能选择的目标
    for i,v in ipairs(l) do
        if v:CanBeSelected() then
            table.insert(rs, v)
        end
    end

    --处理友方不可选中单位问题，这边直接做排序
    local sort = function ( t1, t2 )
         --目标如果不可被点击，优先级最低
         if not t1:CanBeClicked(role) then
            return false
        end

        if not t2:CanBeClicked(role) then
            return true
        end
        return t1:GetOffenseAbilityEstimateValue() > t2:GetOffenseAbilityEstimateValue() 
    end
    table.inPlaceBubbleSort(rs, sort)
    return rs[1]
end
--@role: [Game.Battle.Entity.Role#Role]
--@return [Game.Battle.Entity.Role#Role]
function AI:PVECreepGetAttackFitTarget( role, skillCard )
    -- PVE怪物AI基础逻辑
    -- 怪物攻击我方目标时，根据目标的仇恨值和位置系数的结果进行随机，随机到的目标进行攻击。
   
    -- 攻击方在非控制状态下(沉默，眩晕，魅惑等等)，能量点(回合数)达到可以释放大招时，则必然释放大招。
    -- 在攻击方被沉默的状态下，则只能释放普通攻击
    -- 在攻击方多个拥有CD的技能在可释放状态，并且不可释放大招时，则必然释放原始CD最长的技能(不论是否该技能被减少CD的效果影响)
    -- 怪物攻击在无连击，反击BUFF状态/技能状态下，无法进行连击和反击
    local camp = skillCard.clickType
    local roles = BattleMgr.roles
    local rs = {}
    local l = Core:GetCampTargets(role, roles, camp)
    local rates = {}
    local totalRate = 0
    --站位信息
    -- for i,v in ipairs(l) do
    --     if v:CanBeSelected() then
    --         table.insert(rs, v)
    --         --仇恨等于站位修正*角色仇恨值
    --         local hate = setting:Get(v.standPosition).hatred * v:GetAttr(Constants.AttrTypeId.Hate)
    --         totalRate = totalRate + hate
    --         table.insert(rates, hate)
    --     end
    -- end

    -- assert(#rs>0, '技能目标的选择范围里没有目标 skillid:'.. skill.skillId)

    -- -- 若我方可攻击的目标为1个时，则每次攻击均为该目标
    -- if #rs == 1 then
    --     return rs[1]
    -- end

    -- --根据仇恨权重随机
    -- local r = Core.Random() * totalRate
    -- for i,v in ipairs(rates) do
    --     if r <= v then
    --         return rs[i]
    --     else
    --         r = r - v
    --     end
    -- end

    for i,v in ipairs(l) do
        if v:CanBeClicked(role) then
            table.insert(rs, v)
        end
    end
    if #rs <= 0 then
        --剩余的都是不可选择单位,把隐身单位也一起算上
        for i,v in ipairs(l) do
            if v:CanBeSelected() then
                table.insert(rs, v)
            end
        end
    end
    if #rs == 1 then
        return rs[1]
    end
    -- local r = math.random(#rs)
    local r = Core.Random(#rs, 1)
    return rs[r]

    -- assert(true, '没有找到合适的目标')
end

function AI:PVEPlayerGetAttackFitTarget( role, skillCard, useSelectedTarget )
    -- 当无BOSS/精英时，攻击顺序为属性克制>>属性克制并且当前血量少>>属性克制并且总血量少>>属性克制血量相同攻击%治疗-法师-射手-刺客-战士-坦克%>>若全部相同时，则随机一个目标攻击
    -- 当无BOSS/精英时，并且无属性克制的多个怪物存在时，则攻击顺序为非克制属性并且当前血量少>>非克制属性并且总血量少>>非克制属性血量相同攻击顺序为%治疗-法师-射手-刺客-战士-坦克%>>若全部相同时，则随机一个目标攻击
    -- 若只存在克制属性的怪物时，则攻击顺序和上述顺序相同
    -- 卡牌释放技能的顺序为大招>>小技能>>普通攻击
    local selectTarget = Core:FindSelectRole()
    local camp = skillCard.clickType

    -- 玩家手动选择的目标为最高攻击优先级。
    if useSelectedTarget and selectTarget and not selectTarget:IsDead() and selectTarget:CanBeClicked(role) then
        return selectTarget
    end
    local roles = BattleMgr.roles
    local l = Core:GetCampTargets(role, roles, camp)
    local rs = {}
    --过滤掉所有不能选择的目标
    for i,v in ipairs(l) do
        if v:CanBeSelected() then
            table.insert(rs, v)
        end
    end

    local sort = function (t1, t2)
        --目标如果不可被点击，优先级最低
        if not t1:CanBeClicked(role) then
            return false
        end

        if not t2:CanBeClicked(role) then
            return true
        end


        local hpPer1 = t1:GetNowHPPercent()
        local hpPer2 = t2:GetNowHPPercent()
        local edge = Core:GetBattleParamNum(Constants.BattleParam.FocusHPPer)

        --1.血量低于标准值时，血量越少优先级越高
        if hpPer1 <= edge or hpPer2 <= edge then
            return hpPer1 < hpPer2
        end


        --2.属性克制优先
        --获得属性克制伤害系数，大于0为克制，小于0位被克制
        local ratio1 = Core:GetElementCounteDamage(role.elementType, t1.elementType)
        local ratio2 = Core:GetElementCounteDamage(role.elementType, t2.elementType)
        if math.abs( ratio1 - ratio2 )  > 0.001 then
            return ratio1 > ratio2
        end

        if math.abs( hpPer1 - hpPer2 )  > 0.001 then
            return hpPer1 < hpPer2
        end

        local hp1 = t1:GetAttr(Constants.AttrTypeId.Hp)
        local hp2 = t2:GetAttr(Constants.AttrTypeId.Hp)
        if math.abs( hp1 - hp2)  > 0.001 then
            return hp1 < hp2
        end

        return false
    end
    --排序
    table.inPlaceBubbleSort(rs, sort)
    return rs[1]
end

-- function AI:GetFitTarget( role, skill )
--     --首先判断选择范围是地方还是我方
--     local camp = skill.clickType--点击类型其实对应的是点击的阵营
--     --根据阵营获得候选人
--     local rs = Core:GetCampTargets(role, BattleMgr.roles, camp)

--     assert(#rs>0, '技能目标的选择范围里没有目标 skillid:'.. skill.skillId)
--     --目前选择具体目标暂时随机选择,大概是用仇恨值权重来做的吧，不过没有确定
--     local r = Core.Random(#rs, 1)
--     --返回一个可以选择的目标
--     return rs[r]
-- end

function AI:ChooseSkill( role )
    --选择一个可以释放的技能
    local selectedSkill = nil
    local skills = {role.skill3, role.skill2, role.skill1}
    -- print(#skills)
    --从大招到小召判断是否可以释放
    for i,skill in pairs(skills) do
        -- print(i)
        -- print(table.toString(skill))
        if skill and skill:CanDischarge(role) then
            selectedSkill = skill
            break
        end
    end
    
    assert( selectedSkill, '所有技能都无法释放 roleid:'.. role.id)
    return selectedSkill
end

return  AI