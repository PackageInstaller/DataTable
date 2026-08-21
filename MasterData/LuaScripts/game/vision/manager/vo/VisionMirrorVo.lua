module('vision.VisionMirrorVo', Class.impl())

function parseData(self, id, data)
    self.id = id
    self.stageId = id          -- 自身即为层数
    self.firstAwardId = data.first_award
    self.des = data.des
    self.limitPoint = 0
end

function getName(self)
    return self.id
end

function getFirstAwardId(self)
    return self.firstAwardId
end

return _M
