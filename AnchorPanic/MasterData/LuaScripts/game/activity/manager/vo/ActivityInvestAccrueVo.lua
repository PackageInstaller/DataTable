module('game.activity.manager.vo.ActivityInvestAccrueVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id
    self.day = cusData.days
    self.dropId = cusData.drop_id
end

return _M