--[[ 
-----------------------------------------------------
@filename       : ManualMonsterConfigVo
@Description    : 图鉴怪物配置数据vo
@date           : 2022-2-22 10:25:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualMonsterConfigVo", Class.impl())

function parseData(self, id, cusData)
    self.id = id
    self.type = cusData.type
    self.model = cusData.model
    self.name = cusData.name
    self.enName = cusData.english
    self.story = cusData.story
    self.dangerous = cusData.dangerous
    self.skillList = cusData.skill_list
    self.manualId = cusData.manual_id
    self.stature = cusData.stature
    self.defense = cusData.def
    self.weight = cusData.weight
    self.atk = cusData.atk
    self.special = cusData.special
    self.range = cusData.range
    self.speed = cusData.speed
    self.element = cusData.element[1]
    self.weekPoint = cusData.weak_point
    -- 职业
    --1  - 坦克
    --2  - 战士
    --3  - 输出
    --4  - 辅助
    self.professionType = cusData.hero_type
    self.unlockshadow = cusData.shadow
    self.lockshadow = cusData.shadow_unlock
    self.painting = cusData.painting
end

function getPrefabName(self)
    if (self.mPrefabName == nil) then
        self.mPrefabName = UrlManager:getRolePath01(self.model)
    end
    return self.mPrefabName
end
--获取危险等级
function getDangerousrating(self)
    return self.dangerous
end
--获取防御系数
function getDefense(self)
    return self.defense
end
--获取伤害系数
function getAtk(self)
    return self.atk
end

--获取攻击范围
function getAttRange(self)
    return self.range
end

--获取名称
function getName(self)
    return self.name
end
--获取弱点
function getWeekPoint(self)
    return self.weekPoint
end
--获取元素属性
function getElement(self)
    return self.element
end
--获取图片Url
function getImgUrl(self)
    local shadowUrl = UrlManager:getIconPath("monsterArchives/" .. self.unlockshadow)
    return shadowUrl
end
--获取是否未读
function getIsNew(self)
    return read.ReadManager:isModuleRead(ReadConst.MANUAL_MONSTER, self.id)
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]