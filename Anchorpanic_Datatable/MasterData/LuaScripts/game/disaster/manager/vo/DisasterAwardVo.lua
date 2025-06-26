module('disaster.DisasterAwardVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id 
    self.targetDamage = cusData.target_damage
    self.reward = cusData.reward
end

return _M