local SimBusinessSellGoodSmallItem = class("SimBusinessSellGoodSmallItem", ReduxView)

function SimBusinessSellGoodSmallItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:BindBg()
end

function SimBusinessSellGoodSmallItem:Dispose()
	SimBusinessSellGoodSmallItem.super:Dispose(self)

	self.gameObject_ = nil
	self.transform_ = nil
end

function SimBusinessSellGoodSmallItem:BindBg()
	self.bg = {}

	for iter_3_0 = 0, self.bgRoot_.childCount - 1 do
		local var_3_0 = self.bgRoot_:GetChild(iter_3_0)

		self.bg[var_3_0.gameObject.name] = var_3_0.gameObject
	end
end

local function var_0_1(arg_4_0, arg_4_1)
	if arg_4_1 == SimBusinessConst.ShowItmeType.shelf then
		return tostring(arg_4_0 + 1)
	end

	return tostring(arg_4_0)
end

function SimBusinessSellGoodSmallItem:RefreshView(arg_5_1, arg_5_2)
	self.id = arg_5_1

	local var_5_1
	local var_5_2 = var_0_1(arg_5_1, arg_5_2)

	if arg_5_2 == SimBusinessConst.ShowItmeType.good then
		var_5_1 = GetTips(SimBusinessConst.GoodTypeDesc[arg_5_1])
	elseif arg_5_2 == SimBusinessConst.ShowItmeType.shelf then
		var_5_1 = GetTips(SimBusinessConst.OrientationType[arg_5_1])
	elseif arg_5_2 == SimBusinessConst.ShowItmeType.effect then
		var_5_1 = ""
		var_5_2 = ""
	end

	self.name_.text = var_5_1

	for iter_5_0, iter_5_1 in pairs(self.bg) do
		SetActive(iter_5_1, iter_5_0 == var_5_2)
	end
end

function SimBusinessSellGoodSmallItem:Dispose()
	SimBusinessSellGoodSmallItem.super.Dispose(self)
end

return SimBusinessSellGoodSmallItem
