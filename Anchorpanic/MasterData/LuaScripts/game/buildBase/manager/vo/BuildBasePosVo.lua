module("buildBase.BuildBasePosVo", Class.impl())

function parseConfigData(self,id,data)
    self.id = id
    self.buildType = data.build_type
    self.level = data.level
    self.liveType = data.live_type
    self.sceneId = data.scene_id
    self.name = data.name
    self.icon = data.icon
end

return _M