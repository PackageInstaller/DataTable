module("tips.TipsManager", Class.impl(Manager))

function parseRecommendConfigData(self)
    self.mRecommendCongigDic = {}
    local baseData = RefMgr:getData("game_rule_data")
    for k, v in pairs(baseData) do
        local Vo = LuaPoolMgr:poolGet(formation.FormationRecommendVo)
        Vo:parseData(k, v)
        self.mRecommendCongigDic[k] = Vo
    end
end

function getRecommandData(self)
    if not self.mRecommendCongigDic then 
        self:parseRecommendConfigData()
    end
    return self.mRecommendCongigDic
end


return _M
