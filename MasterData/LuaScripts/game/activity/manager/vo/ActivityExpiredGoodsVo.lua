module('game.activity.manager.vo.ActivityExpiredGoodsVo', Class.impl())

function parseData(self, id, data)
    self.id = id

    self.dropId = data.drop_id
    self.expiredFashion = data.expired_fashion
    self.price = data.price
    self.sort = data.sort
    self.rechargeName = data.recharge_name
    self.type = data.type
end


return _M