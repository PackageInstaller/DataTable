module("hero.HeroConfigVo", Class.impl("lib.event.EventDispatcher"))

function ctor(self)
end

function getOrgData(self)
    return self.m_orgData
end

function parseConfigData(self, cusTid, cusData)
    self.m_orgData = cusData
    self.tid = cusTid
    -- 名称
    self.name = cusData.name
    -- 英文名称
    self.englishName = cusData.english
    -- 中配音名
    self.zhCVName = cusData.chn_voice
    -- 日配音名
    self.jpCVName = cusData.jp_voice
    -- 中配音试听id
    self.zhCVId = cusData.chn_cvid
    -- 日配音试听id
    self.jpCVId = cusData.jp_cvid
    -- 身世
    self.life = cusData.life
    -- 血型
    self.blood = _TT(cusData.blood)
    -- 身高
    self.stature = cusData.stature
    -- 体重
    self.weight = cusData.weight
    -- 生日
    self.birthday = cusData.birthday
    -- 所属国家/阵营
    self.camp = cusData.camp
    -- 职业
    --1  - 坦克
    --2  - 战士
    --3  - 输出
    --4  - 辅助
    self.professionType = cusData.hero_type
    -- 品质
    self.color = cusData.hero_color
    -- 定位
    self.defineType = cusData.location
    -- 模型id
    self.model = cusData.model
    -- 展示模型id
    self.showModel = cusData.show_model
    -- 头像图
    self.head = cusData.head
    -- 原画
    self.painting = cusData.img_painting
    -- 半身图
    self.bodyImg = cusData.img_body
    -- 阴影头像
    self.shadowHead = cusData.shadow_head
    -- 能力属性列表
    self.abilityList = cusData.ability
    --星级
    self.star = cusData.star

    --Q版模型Id
    self.showQ_model = cusData.showQ_model

    --指定战员属性类型
    --0-物理/无属性
    --1-电属性
    --2-火属性
    --3-冰属性
    self.eleType = cusData.ele_type

    -- 合成该英雄需要的道具
    self.needFragment = cusData.need_fragment

    -- 属性权重字典
    self.abilityWeightDic = {}
    for i = 1, #cusData.attr_ability do
        self.abilityWeightDic[cusData.attr_ability[i][1]] = cusData.attr_ability[i][2]
    end
    -- 配置的技能id列表，第一个默认为普攻
    self.baseSkillIdList = cusData.skill_list
    --配置的技能顺序
    self.initskilllist = cusData.init_skill_list
    --天赋技能
    self.inBornSkill = cusData.inborn_skill

    -- 被动技能列表(升星配置表拿)
    self.basePassiveSkillList = {}
    local starUpDic = hero.HeroStarManager:getHeroStarDic(self.tid)
    if (starUpDic) then
        for star, starConfigVo in pairs(starUpDic) do
            table.insert(self.basePassiveSkillList, starConfigVo.passiveSkillId)
        end
    end
    -- 基础属性
    self.basicAttrDic = {}
    for k, v in pairs(cusData.basic_attr) do
        self.basicAttrDic[v.key] = v.value
    end
    self.warshipSkill = cusData.warship_skill

    --招募立绘语音CV
    self.recruit_voice = cusData.recruit_voice

    -- 涉及到的有特效的buff id列表
    self.involveBuff = cusData.involve_buff

    --是否是限定
    self.isLimit = cusData.is_limit
end

--判断角色是否限定
function getHeroIsLimit(self)
    return self.isLimit == 1
end

-- 战员基础模型或对应时装的模型
function getHeroModel(self, fashionId)
    fashionId = (fashionId and fashionId > 0) and fashionId or 1
    local fashionConfigVo = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, self.tid, fashionId)
    if fashionConfigVo then
        return fashionConfigVo.model
    end
    return self.model
end

-- 战员基础模型或对应时装的高模Id
function getHeroHighModel(self, fashionId)
    fashionId = (fashionId and fashionId > 0) and fashionId or 1
    local fashionConfigVo = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, self.tid, fashionId)
    if fashionConfigVo then
        return fashionConfigVo.highModel
    end
    return nil
end

-- 获取UI上的模型id（优先使用高模）
function getUIModel(self, fashionId)
    if self:getHeroHighModel(fashionId) and self:getHeroHighModel(fashionId) ~= "" then
        return self:getHeroHighModel(fashionId)
    end
    return self:getHeroModel(fashionId)
end

-- 模型预制体路径
function getPrefabName(self)
    if (self.m_prefabName == nil) then
        self.m_prefabName = UrlManager:getRolePath01(self:getHeroModel())
    end
    return self.m_prefabName
end

function getShowPrefabName(self)
    if (self.m_showPrefabName == nil) then
        self.m_showPrefabName = UrlManager:getRolePath01(self.showModel)
    end
    return self.m_showPrefabName
end

function getProfessionName(self)
    return hero.getProfessionName(self.professionType)
end

function getDefineName(self)
    return hero.getDefineName(self.defineType)
end

function getStarName(self)
    return hero.getStarName(self.color - 1)
end

function getCountryName(self)
    return hero.getCountryName(self.camp)
end

function getColorName(self)
    return hero.getColorName(self.color)
end
function getStar(self)
    return self.star
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]