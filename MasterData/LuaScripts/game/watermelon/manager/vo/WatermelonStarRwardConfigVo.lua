module('watermelon.WatermelonStarRwardConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.star_num = cusData.star_num
    self.reward = cusData.reward
    self.des = cusData.des

end

function getDesc(self)
    return _TT(self.des)
end

return _M
