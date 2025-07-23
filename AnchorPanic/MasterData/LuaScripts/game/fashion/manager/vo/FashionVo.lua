module("fashion.FashionVo", Class.impl())

function ctor(self)
end

function parseMsgData(self, cusHeroId, cusData)
    self.heroId = cusHeroId

    self.fashionId = cusData.fashion_id
    self.isWear = cusData.is_wear == 1 and true or false
    self.fashionType = fashion.getFashionTypeByMsg(cusData.fashion_type)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
