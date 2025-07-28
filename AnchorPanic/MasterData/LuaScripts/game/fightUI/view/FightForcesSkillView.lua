-- 战斗盟约技能
module('fightUI.FightForcesSkillView', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
    super.initData(self, rootGo)


    self.mSkillItem1 = fightUI.FightForcesSkillItem.new()
    self.mSkillItem1:setup(UrlManager:getUIPrefabPath("fight/FightForcesSkillItem.prefab"))
    self.mSkillItem1:setSkillCall(self, self.onSkillCall)
    self.mSkillItem1:addOnParent(self:getChildTrans("ForcesSkillItem1"))

    -- self.mSkillItem2 = fightUI.FightForcesSkillItem.new()
    -- self.mSkillItem2:setup(UrlManager:getUIPrefabPath("fight/FightForcesSkillItem.prefab"))
    -- self.mSkillItem2:setSkillCall(self, self.onSkillCall)
    -- self.mSkillItem2:addOnParent(self:getChildTrans("ForcesSkillItem2"))

    -- self.mSkillItem3 = fightUI.FightForcesSkillItem.new()
    -- self.mSkillItem3:setup(UrlManager:getUIPrefabPath("fight/FightForcesSkillItem.prefab"))
    -- self.mSkillItem3:setSkillCall(self, self.onSkillCall)
    -- self.mSkillItem3:addOnParent(self:getChildTrans("ForcesSkillItem3"))

    self.mPowerBar = self:getChildGO("ForcesPowerBar"):GetComponent(ty.Image)

    self.mItemList = {}
    table.insert(self.mItemList, self.mSkillItem1)
    -- table.insert(self.mItemList, self.mSkillItem2)
    -- table.insert(self.mItemList, self.mSkillItem3)
end

-- 设置盟约技能列表
function setForcesSkill(self, list)
    for i, skillRefID in ipairs(list) do
        local skillRo = fight.SkillManager:getSkillRo(skillRefID)
        local sItem = self.mItemList[i]

        sItem:setSkillData(skillRo)
        sItem:updateState()
    end
end

-- 技能释放回调处理
function onSkillCall(self, skillRo)
    if fight.FightManager:getForcesSkillEnergy() >= skillRo:getCost() then
        fight.FightManager:reqUseForcesSkill(skillRo:getRefID())
    else    
        gs.Message.Show(_TT(3048))
    end
end

-- 更新能量值
function udateForcesSkillEnergy(self)
    local curEnergy = fight.FightManager:getForcesSkillEnergy()
    local maxEnergy = 3
    self.mPowerBar.fillAmount = curEnergy / maxEnergy

    self.mSkillItem1:updateState()
    -- self.mSkillItem2:updateState()
    -- self.mSkillItem3:updateState()
end

function destroy(self, isAuto)
    for _, item in ipairs(self.mItemList) do
        item:destroy()
    end
    self.mItemList = {}
    super.destroy(self)
end

return _M
 
-- --[[ 替换语言包自动生成，请勿修改！
-- 	语言包: _TT(3048):	"能量不足"
-- ]]
