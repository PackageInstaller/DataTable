module('vision.VisionMirrorDupVo', Class.impl())

function parseMsg(self, msg)
    self.layer = msg.layer
    self.dupList = msg.dup_list or {}
end

return _M
