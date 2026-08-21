ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")

local var_0_0 = class("SpringFestivalGreetingSubmoduleItem", ActivitySubmoduleItem)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)

	arg_1_0.updateModelHandler_ = handler(arg_1_0, arg_1_0.LoadModel)
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)
	manager.notify:RegistListener(SPRING_FESTIVAL_GREETING_UPDATE, arg_2_0.updateModelHandler_)
	arg_2_0:LoadModel()
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(SPRING_FESTIVAL_GREETING_UPDATE, arg_3_0.updateModelHandler_)
	var_0_0.super.OnExit(arg_3_0)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	arg_4_0.updateModelHandler_ = nil

	arg_4_0:UnLoadModel()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		if manager.time:GetServerTime() >= arg_5_0.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		ActivityTools.JumpToSubmodulePage(arg_5_0.activityId_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.greetingBtn_, nil, function()
		JumpTools.OpenPageByJump("springFestivalGreetingLetter")
	end)
end

function var_0_0.BindRedPoint(arg_8_0)
	manager.redPoint:bindUIandKey(arg_8_0.iconTf_, string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, arg_8_0.activityId_))
end

function var_0_0.UnBindRedPoint(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.iconTf_, string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, arg_9_0.activityId_))
end

function var_0_0.LoadModel(arg_10_0)
	local var_10_0 = arg_10_0.activityId_
	local var_10_1 = SpringFestivalGreetingData:GetUnlockCnt(var_10_0)
	local var_10_2 = ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[var_10_0]

	if var_10_1 > #var_10_2 then
		var_10_1 = #var_10_2
	end

	local var_10_3 = var_10_2[var_10_1]
	local var_10_4 = ActivitySpringFestivalGreetingCfg[var_10_3]
	local var_10_5 = SkinCfg[var_10_4.story_name].picture_id

	if arg_10_0.lastModelID_ ~= var_10_5 then
		if arg_10_0.model_ then
			arg_10_0:UnLoadModel()
		end

		arg_10_0.lastModelID_ = var_10_5
		arg_10_0.model_ = Object.Instantiate(Asset.Load("UIChar/" .. var_10_5), arg_10_0.charTf_)
	end
end

function var_0_0.UnLoadModel(arg_11_0)
	if arg_11_0.model_ then
		Object.Destroy(arg_11_0.model_)

		arg_11_0.model_ = nil
		arg_11_0.lastModelID_ = nil
	end
end

return var_0_0
