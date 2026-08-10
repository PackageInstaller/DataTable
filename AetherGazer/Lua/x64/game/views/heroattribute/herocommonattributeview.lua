local var_0_0 = class("HeroCommonAttributeView", HeroAttributeView)

function var_0_0.OnEnter(arg_1_0)
	arg_1_0.attribute_ = arg_1_0.params_.attribute

	for iter_1_0, iter_1_1 in pairs(arg_1_0.attributeItemList_) do
		iter_1_1:SetData(arg_1_0.attribute_[iter_1_0])
	end

	arg_1_0.scrollView_.verticalNormalizedPosition = 1
end

return var_0_0
