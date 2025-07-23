

module('game.activity.manager.vo.ActivitySelectBuyVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id 
    self.normalItemTid = cusData.normal_reward_item
    self.normalItemNum = cusData.normal_reward_num

    self.selectList = {}
    self.price = cusData.price 
    self.name = cusData.name

    self.scale = cusData.value
    for id, childData in pairs(cusData.self_selected_grid) do
        local data = {}
        data.id = id 
        data.childList  = {}
        for k, v in pairs(childData.self_selected_reward) do
            local selectData = {}
            selectData.id = k 
            selectData.tid = v.item_id 
            selectData.num = v.item_num
            table.insert(data.childList,selectData)
        end

        table.sort(data.childList,function (vo1,vo2)
            return vo1.id < vo2.id
        end)

        table.insert(self.selectList,{id = id ,data = data})
    end

    table.sort(self.selectList,function (vo1,vo2)
        return vo1.id < vo2.id
    end)

    --self:parseSelectList(self.selectGrid)
end

return _M