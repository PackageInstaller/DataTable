local MedalGoods = class("MedalGoods", import("model.vo.BaseVO"))

function MedalGoods:Ctor(arg_1_1)
	self.configId = arg_1_1.id
	self.count = arg_1_1.count

	return
end

function MedalGoods:UpdateCnt(arg_2_1)
	self.count = self.count - arg_2_1

	return
end

function MedalGoods:bindConfigTable()
	return pg.honormedal_goods_list
end

function MedalGoods:CanPurchase()
	return self.count > 0
end

function MedalGoods:GetPrice()
	return self:getConfig("price")
end

function MedalGoods:Selectable()
	return self:getConfig("goods_type") == 2
end

function MedalGoods:GetFirstDropId()
	return self:getConfig("goods")
end

function MedalGoods:GetMaxCnt()
	return self.count
end

function MedalGoods:CanPurchaseCnt(arg_9_1)
	return arg_9_1 <= self.count
end

function MedalGoods:GetLimit()
	return self:getConfig("goods_purchase_limit")
end

function MedalGoods:GetDropInfo()
	return Drop.New({
		type = self:getConfig("type"),
		id = self:getConfig("goods")[1],
		count = self:getConfig("num")
	})
end

return MedalGoods
