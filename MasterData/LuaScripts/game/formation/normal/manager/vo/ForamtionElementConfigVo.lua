
module("formation.ForamtionElementConfigVo", Class.impl())

function parseData(self,id,data)
    -- 助战位置
    self.id = id
    -- 需要的玩家等级
    self.data = data
end

return _M
 