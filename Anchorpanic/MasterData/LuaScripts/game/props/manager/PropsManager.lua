module("props.PropsManager", Class.impl(Manager))

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
    self.m_propsConfigDic = {}
    self:__parseConfigData()
end

function parseItemRuleData(self)
    self.mItemRuleDic = {}
    local baseData = RefMgr:getData('item_rule_data')
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(props.ItemRuleVo)
        vo:parseData(key, data)
        self.mItemRuleDic[vo.id] = vo
    end
end

function getItemRuleData(self)
    if self.mItemRuleDic == nil then
        self:parseItemRuleData()
    end
    return self.mItemRuleDic
end

function getItemRuleDataByTid(self,tid)
    if self.mItemRuleDic == nil then
        self:parseItemRuleData()
    end
    return self.mItemRuleDic[tid]
end

-- 初始化配置表
function __parseConfigData(self)
    self.m_propsConfigDic = {}
    local baseData = RefMgr:getData('item_data')
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(props.PropsConfigVo)
        vo:parseConfigData(key, data)
        self.m_propsConfigDic[vo.tid] = vo
    end
end

function getPropsConfigDic(self)
    return self.m_propsConfigDic
end

-- 取配置数据
function getPropsConfigVo(self, cusTid)
    return self.m_propsConfigDic[cusTid]
end

--根据效果取道具表
function getPropsByEffect(self, effectId)
    local retList = {}
    for id, data in pairs(self.m_propsConfigDic) do
        if data.effectType == effectId then
            table.insert(retList, data)
        end
    end
    return retList
end

-- 根据道具tid获取对应类型的道具结构
function getTypePropsVoByTid(self, cusTid)
    local typePropsVo = nil
    local configVo = props.PropsManager:getPropsConfigVo(cusTid)
    if not configVo then
        logError(string.format('不存在道具tid:%s 的配置，请让策划哥检查配置表', cusTid), "PropsManager")
    end
    if (configVo.type == PropsType.EQUIP) then
        typePropsVo = props.EquipVo:poolGet()
    elseif configVo.type == PropsType.ORDER then
        typePropsVo = props.OrderVo:poolGet()
    else
        typePropsVo = props.PropsVo:poolGet()
    end
    typePropsVo:setTid(cusTid)
    return typePropsVo
end

-- 创建一个简单的道具vo
function getPropsVo(self, args)
    local configVo = self:getPropsConfigVo(args.tid)
    local propsVo = self:getTypePropsVoByTid(args.tid)
    propsVo:setConfigData(configVo)
    propsVo.count = args.num
    return propsVo
end

function getPropsVo2(self, args)
    local configVo = self:getPropsConfigVo(args[1])
    local propsVo = self:getTypePropsVoByTid(args[1])
    propsVo:setConfigData(configVo)
    propsVo.count = args[2]
    return propsVo
end

--根据道具Tid获得Name
function getName(self, propsTid)
    if next(self.m_propsConfigDic) then
        return self.m_propsConfigDic[propsTid].name
    end
end

--根据道具Tid获得Icon
function getPropsIconUrl(self, propsTid)
    if next(self.m_propsConfigDic) then
        return self.m_propsConfigDic[propsTid].icon
    end
end


-- 检查使用道具
function checkUseProps(self, cusPropsVo)
    local isJumpView = false
    return isJumpView
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]