module('drop.DropTaskDataVo', Class.impl())

-- 解析建造小游戏任务配置，缓存任务类型、目标值、奖励和描述
function parseData(self, key, cusData)
    self.id = key 
    self.type = cusData.type
    self.subType = cusData.sub_type
    self.reward = cusData.reward
    self.des = cusData.des
end

return _M