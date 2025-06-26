module("ActivityTargetAwardVo",Class.impl())

function parseActivityTargetAwardVo(self,cusData)
    self.targetScore = cusData.target_score
    self.scoreData = cusData.score_reward

    -- self.propsList = {}
    -- for i = 1, #cusData.score_reward do
    --     local propsVo = props.PropsVo.new()
    --     propsVo:setPropsAwardMsgData(cusData.score_reward[i])
    --     table.insert(self.propsList, propsVo)
    -- end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
