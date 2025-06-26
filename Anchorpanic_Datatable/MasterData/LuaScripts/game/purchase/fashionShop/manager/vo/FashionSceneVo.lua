
module('purchase.FashionSceneVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id
    self.mSceneDic = {}
    self:parseSceneData(cusData.scene_data)
    --self.sceneData = cusData.scene_data
end

function parseSceneData(self, sceneData)
    for k, v in pairs(sceneData) do
        local vo = purchase.FashionSceneChildVo.new()
        vo:parseData(k, self.id, v)
        self.mSceneDic[k] = vo
    end
end

function getInteractSceneDataByModelId(self, model_id)
    for id,vo in pairs(self.mSceneDic) do
        if vo.modelId == model_id then 
            return vo
        end
    end
end

function getSceneChildVo(self, id)
    return self.mSceneDic[id]
end

return _M
