local ChooseFoodMaterialItem = class("ChooseFoodMaterialItem", ReduxView)

function ChooseFoodMaterialItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChooseFoodMaterialItem:Init()
	self:InitUI()
end

function ChooseFoodMaterialItem:InitUI()
	self:BindCfgUI()
end

function ChooseFoodMaterialItem:RefreshUI(arg_4_1, arg_4_2)
	self.nameText_.text = ItemTools.getItemName(arg_4_1)

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(BackHomeCanteenFoodCfg[arg_4_2].ingredient_list) do
		if iter_4_1[1] == arg_4_1 then
			var_4_0 = iter_4_1[2]

			break
		end
	end

	local var_4_2 = CanteenFoodData:GetCateenIngredient()[arg_4_1]
end

function ChooseFoodMaterialItem:RegistCallBack(arg_5_1)
	self.changeListFun = arg_5_1
end

function ChooseFoodMaterialItem:Dispose()
	self:RemoveAllListeners()
	ChooseFoodMaterialItem.super.Dispose(self)
end

return ChooseFoodMaterialItem
