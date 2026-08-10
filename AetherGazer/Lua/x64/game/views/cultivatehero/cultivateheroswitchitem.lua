local var_0_0 = class("CultivateHeroSwitchItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_4_0.clickHandler_ then
			arg_4_0.clickHandler_(arg_4_0.groupID_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.groupID_ == nil then
		local var_6_0 = string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_6_1, arg_6_2)

		manager.redPoint:bindUIandKey(arg_6_0.transform_, var_6_0)
	elseif arg_6_0.groupID_ ~= arg_6_2 then
		local var_6_1 = string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_6_1, arg_6_0.groupID_)

		manager.redPoint:unbindUIandKey(arg_6_0.transform_, var_6_1)

		local var_6_2 = string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_6_1, arg_6_2)

		manager.redPoint:bindUIandKey(arg_6_0.transform_, var_6_2)
	end

	arg_6_0.groupID_ = arg_6_2
	arg_6_0.activityID_ = arg_6_1

	arg_6_0:RefreshUI()
end

function var_0_0.SetClickCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickHandler_ = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.clickHandler_ = nil

	local var_8_0 = string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_8_0.activityID_, arg_8_0.groupID_)

	manager.redPoint:unbindUIandKey(arg_8_0.transform_, var_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshImage()
end

function var_0_0.RefreshImage(arg_10_0)
	local var_10_0 = CultivateHeroTaskCfg.get_id_list_by_group_id[arg_10_0.groupID_]
	local var_10_1 = CultivateHeroTaskCfg[var_10_0[1]].hero

	arg_10_0.icon_.sprite = getSpriteViaConfig("HeroLittleIcon", var_10_1)
end

function var_0_0.RefreshSelect(arg_11_0, arg_11_1)
	SetActive(arg_11_0.selectGo_, arg_11_0.groupID_ == arg_11_1)
end

return var_0_0
