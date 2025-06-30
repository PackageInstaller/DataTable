
module('purchase.FashionSceneChildVo', Class.impl())

function parseData(self, id, heroTid, cusData)
    self.id = id
    self.heroTid = heroTid
    self.modelId = cusData.model_id
    self.icon = cusData.icon
    self.sceneId = cusData.scene_id
    self.img = cusData.img
    self.itemId = cusData.item_id
    self.loading_list = cusData.loading_list
end

function getRandomLoad(self)
    if table.empty(self.loading_list) then
        return nil
    end
    local random_index = math.random(1, #self.loading_list)
    return self.loading_list[random_index]
end

return _M
