local var_0_0 = class("OathConditionItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.stateController = arg_1_0.controllers_:GetController("lock")
	arg_1_0.showIconController = arg_1_0.controllers_:GetController("showIcon")
	arg_1_0.showJumpController = arg_1_0.controllers_:GetController("btn")

	arg_1_0:AddBtnListener(arg_1_0.jumpBtn_, nil, function()
		if arg_1_0.jumpLink then
			local var_2_0, var_2_1 = JumpTools.GetSystemLockedText(arg_1_0.jumpLink)

			if var_2_0 then
				ShowTips(var_2_1)

				return
			end

			DestroyLua()
			LuaExchangeHelper.GoToMain(CustomLoadingConst.Oath_Loading)
			manager.windowBar:ClearWhereTag()
			OpenPageUntilLoaded("/oathMainView", {
				selectHeroID = arg_1_0.heroID,
				enterCallback = function()
					JumpTools.JumpToPage(arg_1_0.jumpLink)
				end
			})
		end
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.conditionID = arg_4_1
	arg_4_0.jumpLink = arg_4_2
	arg_4_0.heroID = arg_4_3

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = ConditionCfg[arg_5_0.conditionID]

	arg_5_0.desc_.text = GetI18NText(var_5_0.desc)

	if var_5_0.type == 330001 then
		arg_5_0:SetShowIcon(true)

		local var_5_1 = var_5_0.params[1]
		local var_5_2 = ItemTools.getItemSprite(var_5_1, nil, true)

		arg_5_0.icon_.spriteSync = var_5_2
	else
		arg_5_0:SetShowIcon(false)
	end

	arg_5_0.stateController:SetSelectedState(IsConditionAchieved(arg_5_0.conditionID) and "unlock" or "lock")
	arg_5_0.showJumpController:SetSelectedState(IsConditionAchieved(arg_5_0.conditionID) and "off" or "on")
end

function var_0_0.SetShowIcon(arg_6_0, arg_6_1)
	arg_6_0.showIconController:SetSelectedState(arg_6_1 and "true" or "false")
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
