
module("props.ItemRuleVo", Class.impl())

function parseData(self,tid,cusData)
    self.id = tid 
    self.tid = tid 

    self.ruleDic = {}
    for k, v in pairs(cusData.rule_data) do
        local vo = LuaPoolMgr:poolGet(props.ItemChildRuleVo)
        vo:parseData(k, v)
        self.ruleDic[k] = vo
    end
end

return _M