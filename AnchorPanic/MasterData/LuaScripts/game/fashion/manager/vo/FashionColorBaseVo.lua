module("fashion.FashionColorBaseVo", Class.impl())

function parseData(self, cusId, cusData)
    self.id = cusId

    self.heroTid = cusData.tid
    self.fashionId = cusData.fashion_id
    self.modelId = cusData.model_id
    self.cameraType = cusData.camera_type
    self.colorList = {}

    for i, v in ipairs(cusData.fashion_color_data) do
        local vo = fashion.FashionColorVo.new()
        vo:parseData(i, v)
        table.insert(self.colorList, vo)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]