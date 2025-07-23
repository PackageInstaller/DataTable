module("buildBase.BuildBaseHeroSkillVo", Class.impl())

function parseData(self, id, data)

    self.skillId = id
    -- 类型
    self.type = data.type
    -- 效果参数
    self.effectPara = data.effect_para
    -- 是否能与其他效果堆叠
    self.is_coincide = data.type_name
    -- 图标
    self.icon = data.icon
    -- 名称
    self.name = data.name
    -- 描述
    self.des = data.des
    -- 军阶限制
    self.rank = data.rank
    --属性
    self.attr = {}
    --解析属性
    self:parseSkillAttrConfig(data)
    --建筑等级
    self.buildType = data.build_type
    --技能影响产品种类 0为技能不在加工厂中生效
    self.produceType =  data.produce_type
end

--获取当前等级属性
function getCurLvAttr(self, lv)
    if self.attr then
        for _,v in pairs(self.attr) do 
            if v.skillLv == lv then 
                return v 
            end 
        end 
    end
end
function parseSkillAttrConfig(self,data)
    for k, v in pairs(data.skill_attr) do
        local vo = LuaPoolMgr:poolGet(buildBase.BuildBaseSkillAttrVo)
        vo:parseConfigData(k,v)
        self.attr[vo.skillLv] = vo
    end
end
return _M