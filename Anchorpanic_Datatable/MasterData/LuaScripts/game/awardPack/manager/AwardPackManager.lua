-- 奖励包换个名字掉落包
module("AwardPackManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.m_awardDic = {}
end

-- 初始化配置表
function parseConfigData(self)
    self.m_awardDic = {}
    local baseData = RefMgr:getData("drop_data")
    for awardId, data in pairs(baseData) do
        if (not self.m_awardDic[awardId]) then
            self.m_awardDic[awardId] = {}
        end
        for i = 1, #data.drop_item do
            local configVo = LuaPoolMgr:poolGet(AwardPackConfigVo)
            configVo:parseConfigData(data.drop_item[i])
            table.insert(self.m_awardDic[awardId], configVo)
        end
        table.sort(self.m_awardDic[awardId], self.__sortAwardList)
    end
end

function __sortAwardList(awardPackConfigVo_1, awardPackConfigVo_2)
    if (awardPackConfigVo_1 and awardPackConfigVo_2) then
        local propsVo_1 = props.PropsManager:getPropsConfigVo(awardPackConfigVo_1.tid)
        local propsVo_2 = props.PropsManager:getPropsConfigVo(awardPackConfigVo_2.tid)
        if (propsVo_1 and propsVo_2) then
            -- 品质从大到小
            if (propsVo_1.color ~= propsVo_2.color) then
                return propsVo_1.color > propsVo_2.color
            elseif awardPackConfigVo_1.id and awardPackConfigVo_2.id then
                return awardPackConfigVo_1.id < awardPackConfigVo_2.id
            end
        end
    end
end

-- 获取奖励包
function getAwardListById(self, cusId)
    if (not self.m_awardDic) then
        self:parseConfigData()
    end
    if (self.m_awardDic[cusId]) then
        if GameManager.IS_DEBUG then
            for k, v in pairs(self.m_awardDic[cusId]) do
                if v.num == 0 then
                    logError("========搞什么，掉落道具数量配0，奖励个图标给玩家吗？策划来背锅 id: " .. cusId)
                end
            end
        end
        return self.m_awardDic[cusId]
    else
        return {}
    end
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]