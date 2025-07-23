
module("props.ItemChildRuleVo", Class.impl())

function parseData(self,id,cusData)
    self.id = id 
    self.color = cusData.color 
    self.pr = cusData.pr
    self.itemList = cusData.item_list
    --self.ruleData = cusData.rule_data
end

return _M