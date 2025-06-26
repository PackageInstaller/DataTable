--[[ 
-----------------------------------------------------
@filename       : OrderFactoryConfigVo
@Description    : 序列物加工厂
@date           : 2021-06-24 14:39:25
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.orderFactory.manager.vo.OrderFactoryConfigVo', Class.impl())

function parseConfigData(self, key, cusData)
    self.id = key
    self.productDes = cusData.product_des
    self.color = cusData.color
    self.posList = cusData.pos_list
    self.materialColor = cusData.material_color
    self.materialNum = cusData.material_num
    self.materialDes = cusData.material_des
    self.payType = cusData.pay_coin
    self.payNum = cusData.pay_coin_num
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
