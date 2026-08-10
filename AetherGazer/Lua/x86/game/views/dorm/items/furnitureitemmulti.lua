FurnitureItem = import("game.views.dorm.items.FurnitureItem")

local var_0_0 = class("FurnitureItemMulti", FurnitureItem)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.cancelBtn_, nil, function()
		if arg_1_0.cancelFunc_ then
			arg_1_0.cancelFunc_(arg_1_0.id)
		end
	end)
end

function var_0_0.RefreshCntText(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 and not arg_3_2 then
		arg_3_0.selectController:SetSelectedState("normal")
	else
		arg_3_0.cntText_.text = arg_3_1

		if arg_3_2 then
			if arg_3_1 == 0 then
				arg_3_0.selectController:SetSelectedState("selectNull")
			else
				arg_3_0.selectController:SetSelectedState("select")
			end
		else
			arg_3_0.selectController:SetSelectedState("selected")
		end

		arg_3_0.furNumController:SetSelectedState("two")
	end
end

function var_0_0.OnCancelDown(arg_4_0, arg_4_1)
	arg_4_0.cancelFunc_ = arg_4_1
end

return var_0_0
