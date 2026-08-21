module('mole.MoleDupDataVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key 
    self.star = cusData.star
    self.point = cusData.point
    self.des = cusData.des
end

return _M