module("cycle.CycleStoryVo", Class.impl())

function parseStoryVo(self,id,data)
    self.id = id
    
    self.icon = data.icon
    self.title = data.title
    self.des = data.des
    self.storyId = data.story_id
    self.reward = data.reward
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
