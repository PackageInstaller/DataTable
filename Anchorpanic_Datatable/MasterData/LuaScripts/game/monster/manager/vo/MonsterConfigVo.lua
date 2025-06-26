--[[    
    怪物基础配置
    @author Jacob
]]
module("monster.MonsterConfigVo", Class.impl())

function getOrgData(self)
    return self.m_orgData
end

function parseData(self, cusId, cusData)
    self.m_orgData = cusData
    self.tid = cusId
    self.name = cusData.name
    -- 职业
    --1  - 坦克
    --2  - 战士
    --3  - 输出
    --4  - 辅助
    self.professionType = cusData.hero_type
    self.color = cusData.color
    self.type = cusData.type
    self.skillList = cusData.skill_list
    self.passiveSkillList = cusData.passive_skill_list
    self.model = cusData.model
    self.head = cusData.head
    self.painting = cusData.painting
    self.shadowHead = cusData.shadow_head
    self.des = cusData.describe
    self.win_voice = cusData.win_voice
    self.fail_voice = cusData.fail_voice
    self.monType = cusData.mon_type
    self.record_head = cusData.record_head

    self.eleType = cusData.ele_type

    self.boss_head = cusData.boss_head
    self.attrList = {}
    self.weak = cusData.weak_point
    self.location = cusData.location
    self.skillShowList = cusData.skill_show_list
    self.hpSection = cusData.hp_section
    self.showModelld = cusData.show_Modelld
    self.heroTid = cusData.hero_tid
end

function getPrefabName(self)
    if (self.m_prefabName == nil) then
        self.m_prefabName = UrlManager:getRolePath01(self.model)
    end
    return self.m_prefabName
end
--获取图片展示模型id
function getShowModelld(self)
    return self.showModelld
end

function getModel(self)
    return self.model
end

function getActiveSkill(skill)
    return 1
end

function getExtraLv(skill)
    return 0
end

function getIsBoss(self)
    return self.type >= 5
end

function getIsElite(self)
    return self.type == 2
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]