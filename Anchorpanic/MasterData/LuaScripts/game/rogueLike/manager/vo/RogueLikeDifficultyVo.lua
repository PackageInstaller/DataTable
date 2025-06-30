module("rogueLike.RogueLikeDifficultyVo", Class.impl())

-- 难度信息
function parseData(self, cusData)
    self.name = cusData.difficulty_name
    self.award = cusData.difficulty_award
    self.roleLevel = cusData.role_level
    self.maxLayer = cusData.max_layer
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
