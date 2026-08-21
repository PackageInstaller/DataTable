local var_0_0 = class("HeroAttributeView", ReduxView)
local var_0_1 = {
	BASE = {
		1,
		2,
		3,
		81,
		82
	},
	ELEMENT = {
		151,
		153,
		155,
		154,
		158,
		152,
		157,
		156
	},
	TARGET = {
		201,
		202,
		203,
		221,
		222,
		421
	},
	SKILL = {
		301,
		302,
		303,
		315
	}
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_arrt/HeroArrtPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.attributeItemList_ = {}

	for iter_3_0, iter_3_1 in pairs(var_0_1.BASE) do
		arg_3_0.attributeItemList_[iter_3_1] = HeroAttributeItemView.New(arg_3_0.goAttributeItem_, arg_3_0.goBaseAttribute_, iter_3_0, iter_3_1)
	end

	for iter_3_2, iter_3_3 in pairs(var_0_1.ELEMENT) do
		arg_3_0.attributeItemList_[iter_3_3] = HeroAttributeItemView.New(arg_3_0.goAttributeItem_, arg_3_0.goElementAttribute_, iter_3_2, iter_3_3)
	end

	for iter_3_4, iter_3_5 in pairs(var_0_1.TARGET) do
		arg_3_0.attributeItemList_[iter_3_5] = HeroAttributeItemView.New(arg_3_0.goAttributeItem_, arg_3_0.goTargetAttribute_, iter_3_4, iter_3_5)
	end

	for iter_3_6, iter_3_7 in pairs(var_0_1.SKILL) do
		arg_3_0.attributeItemList_[iter_3_7] = HeroAttributeItemView.New(arg_3_0.goAttributeItem_, arg_3_0.goSkillAttribute_, iter_3_6, iter_3_7)
	end
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.heroID_ = arg_4_0.params_.heroID
	arg_4_0.heroViewProxy_ = arg_4_0.params_.proxy
	arg_4_0.attribute_ = arg_4_0.heroViewProxy_:GetHeroAllAttribute(arg_4_0.heroID_)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.attributeItemList_) do
		iter_4_1:SetData(arg_4_0.attribute_[iter_4_0] or 0)
	end

	arg_4_0.scrollView_.verticalNormalizedPosition = 1
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.attributeItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.attributeItemList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buttonClose_, nil, function()
		arg_7_0:Back()
	end)
end

return var_0_0
