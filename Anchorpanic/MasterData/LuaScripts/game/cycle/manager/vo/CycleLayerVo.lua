module("cycle.CycleLayerVo", Class.impl())

function parseLayerVo(self,id,data)
    --id
    self.id = id 

    self.difficulty = data.difficulty
    self.layer = data.layer_id 
    self.lines = data.lines
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
