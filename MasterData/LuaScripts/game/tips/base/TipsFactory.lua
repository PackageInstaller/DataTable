--[[ 
-----------------------------------------------------
@filename       : TipsFactory
@Description    : 游戏Tips工厂
@date           : 2020-12-22 14:46:04
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
TipsFactory = {}

--[[ 
    Boss特性Tips 
]]
function TipsFactory:showBossSkillTips()
    local destroyView = function()
        self.bossSkillTips:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.bossSkillTips = nil
    end
    if self.bossSkillTips == nil then
        self.bossSkillTips = tips.BossSkillTips.new()
        self.bossSkillTips:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    self.bossSkillTips:open()
    return self.bossSkillTips
end

function TipsFactory:closeBossSkillTips()
    if self.bossSkillTips then
        self.bossSkillTips:onClickClose()
    end
end


--[[ 
    道具tips
    @cusData tips数据
    @clickPosData 点击弹出区域信息
]]
function TipsFactory:propsTips(cusData, clickPosData)
    if cusData.propsVo.effectType == UseEffectType.USE_GET_HEROEGG then
        TipsFactory:heroEggTips(cusData, clickPosData)
        return
    end

    local destroyView = function()
        self.propsTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.propsTipsView = nil
    end
    if self.propsTipsView == nil then
        self.propsTipsView = tips.PropsTips.new()
        self.propsTipsView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    local data = { data = cusData, clickPos = clickPosData }
    self.propsTipsView:open(data)
    return self.propsTipsView
end

--[[ 
    战员蛋道具tips
    @cusData tips数据
    @clickPosData 点击弹出区域信息
]]
function TipsFactory:heroEggTips(cusData, clickPosData)
    local destroyView = function()
        self.heroEggTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.heroEggTipsView = nil
    end
    if self.heroEggTipsView == nil then
        self.heroEggTipsView = tips.HeroEggTips.new()
        self.heroEggTipsView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    local data = { data = cusData, clickPos = clickPosData }
    self.heroEggTipsView:open(data)
    return self.heroEggTipsView
end

--[[ 
    装备tips
    @cusData 数据vo
    @cusTypeList 按钮类型列表
    @clickPosData 点击弹出区域信息
]]
function TipsFactory:equipTips(cusData, cusTypeList, clickPosData, ableToCultivate)

    local destroyView = function()
        self.equipTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.equipTipsView = nil
    end
    if self.equipTipsView == nil then
        self.equipTipsView = tips.EquipTips.new()
        self.equipTipsView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    local data = { propsVo = cusData, typeList = cusTypeList, clickPos = clickPosData, ableToCultivate = ableToCultivate }
    self.equipTipsView:open(data)
    return self.equipTipsView
end

--[[ 
    非玩家本人装备tips
    @cusData 数据vo
    @cusTypeList 按钮类型列表
    @clickPosData 点击弹出区域信息
]]
function TipsFactory:otherEquipTips(cusData, cusTypeList, clickPosData, isMax)

    if isMax == nil then
        isMax = true
    end

    local destroyView = function()
        self.equipOtherTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.equipOtherTipsView = nil
    end
    if self.equipOtherTipsView == nil then
        if isMax then
            self.equipOtherTipsView = tips.EquipTips.new()
        else
            self.equipOtherTipsView = tips.EquipTipsOtherMin.new()
        end

        self.equipOtherTipsView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    local data = { propsVo = cusData, typeList = cusTypeList, clickPos = clickPosData }
    self.equipOtherTipsView:open(data)
    return self.equipOtherTipsView
end



-- 手环装备对比
function TipsFactory:equipContrastTips2(curData, targetData, closeFunc)
    local equipContrastTipsView2 = tips.EquipInfoContrastTips.new()

    local destroyView = function()
        equipContrastTipsView2:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        equipContrastTipsView2 = nil
    end
    equipContrastTipsView2:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    local data = { now = curData, target = targetData, closeFunc = closeFunc }
    equipContrastTipsView2:open(data)
    return equipContrastTipsView2
end

-- 战员职业与属性tis
function TipsFactory:heroEleAndOccTips(type, trans)
    local heroEleAndOccView = tips.HeroEleAndOccTips.new()
    local destroyView = function()
        heroEleAndOccView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        heroEleAndOccView = nil
    end
    heroEleAndOccView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    local data = { type = type, parent = trans }
    heroEleAndOccView:open(data)
    return heroEleAndOccView
end

--[[ 
    装备对比tips
    @cusData 当前数据vo
    @cusData 对比数据vo
    @clickPosData 点击弹出区域信息
]]
function TipsFactory:equipContrastTips(cusData, cusData2, clickPosData)
    local equipContrastTipsView = tips.HeroEquipContrastTips.new()

    local destroyView = function()
        equipContrastTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        equipContrastTipsView = nil
    end
    equipContrastTipsView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    local data = { propsVo = cusData, propsVo2 = cusData2, clickPos = clickPosData }
    equipContrastTipsView:open(data)
    return equipContrastTipsView
end
--[[ 
    没有遮罩（可穿透）装备tips
    @cusData 数据vo
    @cusTypeList 按钮类型列表
    @clickPosData 点击弹出区域信息
]]
function TipsFactory:noMaskEquipTips(cusData, cusTypeList, clickPosData)
    local destroyView = function()
        self.NoMaskEquipTips:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.NoMaskEquipTips = nil
    end
    if self.NoMaskEquipTips == nil then
        self.NoMaskEquipTips = tips.NoMaskEquipTips.new()
        self.NoMaskEquipTips:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    local data = { propsVo = cusData, typeList = cusTypeList, clickPos = clickPosData }
    self.NoMaskEquipTips:open(data)
    return self.NoMaskEquipTips
end

--[[ 
    没有遮罩（可穿透）手环tips
]]
function TipsFactory:openBraceletTips(args)
    if self.mBraceletTips then
        self.mBraceletTips:close()
    end
    local destroyView = function()
        if self.mBraceletTips then
            self.mBraceletTips:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
            self.mBraceletTips = nil
        end
    end
    if args.openType == BraceletTipConstOpenType.CurHeroSelf then
        self.mBraceletTips = tips.BraceletSelfTips.new()
    else
        self.mBraceletTips = tips.BraceletTips.new()
    end
    self.mBraceletTips:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    self.mBraceletTips:open(args)
    return self.mBraceletTips
end

function TipsFactory:closeBraceletTips()
    if self.mBraceletTips and self.mBraceletTips.isPop then
        self.mBraceletTips:close()
    end
end

--[[ 
    没有遮罩（可穿透）模组tips
]]
function TipsFactory:openEquipTips(args)
    if self.mEquipTips then
        self.mEquipTips:close()
    end
    local destroyView = function()
        if self.mEquipTips then
            self.mEquipTips:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
            self.mEquipTips = nil
        end
    end
    self.mEquipTips = tips.EquipInfoTips2.new()
    self.mEquipTips:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    self.mEquipTips:open(args)
    return self.mEquipTips
end

function TipsFactory:closeEquipTips()
    if self.mEquipTips and self.mEquipTips.isPop then
        self.mEquipTips:close()
    end
end

--[[ 
    技能tips
    @cusSkillIdList 所选战员技能列表
    @cusSkillId 当前选择技能id
    @cusHeroVo 所选战员
    @isMonster 是否为怪物技能
]]
function TipsFactory:skillTips(cusSkillIdList, cusSkillId, cusHeroVo, isMonster, skillData)
    local destroyView = function()
        self.skillTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.skillTipsView = nil
    end
    if self.skillTipsView == nil then
        local skillVo = fight.SkillManager:getSkillRo(cusSkillId)
        if isMonster then
            self.skillTipsView = tips.MonsterSkillTips.new()
            self.skillTipsView:setTxtTitle("<size=24>怪</size>物技能")
        else
            -- if (skillVo:getType() == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL or skillVo:getType() == fight.FightDef.SKILL_TYPE_FINAL_SKILL or skillVo:getType() == fight.FightDef.SKILL_TYPE_AOYI_SKILL) then
            --     self.skillTipsView = tips.SingleSkillTips.new()
            -- else
            self.skillTipsView = tips.SkillTipsNew.new()
            -- end
        end
        self.skillTipsView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end

    local skillIdList = {}
    if (cusSkillIdList ~= nil) then
        for k, v in pairs(cusSkillIdList) do
            table.insert(skillIdList, v)
        end
    end
    local isHas = false
    for k, v in pairs(skillIdList) do
        if (v == cusSkillId) then
            isHas = true
            break
        end
    end
    if (not isHas) then
        table.insert(skillIdList, cusSkillId)
    end
    local data = { skillIdList = skillIdList, skillId = cusSkillId, heroVo = cusHeroVo, skillData = skillData }
    self.skillTipsView:open(data)
    return self.skillTipsView
end

-- 普攻tips 则不显示下一级信息
-- function TipsFactory:normalSkillTips(skillId, preValue, nextValue, showNext, heroVo)
--     local destroyView = function()
--         self.normalSkillTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
--         self.normalSkillTipsView = nil
--     end

--     if self.normalSkillTipsView == nil then
--         self.normalSkillTipsView = tips.NormalSkillTipsNew.new()
--         self.normalSkillTipsView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
--     end
--     local data = {skillId = skillId, preValue = preValue, nextValue = nextValue, showNext = showNext, heroVo = heroVo}
--     self.normalSkillTipsView:open(data)
--     return self.normalSkillTipsView
-- end

--[[ 
    属性列表tips
    @cusData 数据vo
    @cusTypeList 按钮类型列表
    @clickPosData 点击弹出区域信息
]]
function TipsFactory:AttrListTips(attrVoList)
    local destroyView = function()
        self.attrListTips:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.attrListTips = nil
    end
    if self.attrListTips == nil then
        self.attrListTips = tips.AttrListTips.new()
        self.attrListTips:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    self.attrListTips:open({ attrVoList = attrVoList })
    return self.attrListTips
end

function TipsFactory:heroAssistTips(heroVo)
    local destroyView = function()
        self.heroAssistTip:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.heroAssistTip = nil
    end
    if self.heroAssistTip == nil then
        self.heroAssistTip = tips.HeroAssistTip.new()
        self.heroAssistTip:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    self.heroAssistTip:open({ heroVo = heroVo })
    return self.heroAssistTip
end

function TipsFactory:AssistSkillTips(heroVo, skillVo)
    local destroyView = function()
        self.assistSkillTips:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.assistSkillTips = nil
    end

    if self.assistSkillTips == nil then
        self.assistSkillTips = tips.AssistSkillTips.new()
        self.assistSkillTips:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    self.assistSkillTips:open({ heroVo = heroVo, skillVo = skillVo })
    return self.assistSkillTips
end

--[[ 
    技能说明属性tips
    @cusData tips数据
    @clickPosData 点击弹出区域信息
]]
function TipsFactory:SkillEffectTips(cusData)
    local destroyView = function()
        self.skillEffectTips:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.skillEffectTips = nil
    end
    if self.skillEffectTips == nil then
        self.skillEffectTips = tips.SkillEffectTips.new()
        self.skillEffectTips:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    self.skillEffectTips:open({ data = cusData })
    return self.skillEffectTips
end

--[[ 
    技能说明属性tips
    @cusData tips数据
    @clickPosData 点击弹出区域信息
]]
function TipsFactory:SpecialEffectTips(cusData)
    local destroyView = function()
        self.specialEffectTips:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.specialEffectTips = nil
    end
    if self.specialEffectTips == nil then
        self.specialEffectTips = tips.SpecialEffectTip.new()
        self.specialEffectTips:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    self.specialEffectTips:open(cusData)
    return self.specialEffectTips
end

function TipsFactory:ClimbTowerTips(cusData)
    local destroyView = function()
        self.climbTowerTips:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.climbTowerTips = nil
    end
    if self.climbTowerTips == nil then
        self.climbTowerTips = tips.ClimbTowerTips.new()
        self.climbTowerTips:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    self.climbTowerTips:open(cusData)
    return self.climbTowerTips
end

function TipsFactory:EnemyInfoTips(cusData)
    local destroyView = function()
        self.enemyInfoTips:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.enemyInfoTips = nil
    end
    if self.enemyInfoTips == nil then
        self.enemyInfoTips = tips.EnemyInfoTips.new()
        self.enemyInfoTips:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    self.enemyInfoTips:open(cusData)
    return self.enemyInfoTips
end

--[[ 
    UAVtips
    @cusData tips数据
    @clickPosData 点击弹出区域信息
]]
function TipsFactory:uavTips(cusData)
    local destroyView = function()
        self.uavTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.uavTipsView = nil
    end
    if self.uavTipsView == nil then
        self.uavTipsView = tips.UAVUseTips.new()
        self.uavTipsView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    self.uavTipsView:open(cusData)
    return self.uavTipsView
end

--[[ 
    Recommendtips
    @cusData tips数据
    @clickPosData 点击弹出区域信息
]]
function TipsFactory:RecommendTips(cusData)
    local destroyView = function()
        self.recommendTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.recommendTipsView = nil
    end
    if self.recommendTipsView == nil then
        self.recommendTipsView = tips.RecommandTip.new()
        self.recommendTipsView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    self.recommendTipsView:open(cusData)
    return self.recommendTipsView
end

--[[ 替换语言包自动生成，请勿修改！
]]