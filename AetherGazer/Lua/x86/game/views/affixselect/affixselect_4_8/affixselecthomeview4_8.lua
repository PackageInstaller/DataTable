local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("AffixSelectHomeView4_8", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "Widget/Version/Alone_AffixSelect/Alone_AffixSelect_MainUI"
end

function var_0_1.Init(arg_2_0)
	var_0_1.super.Init(arg_2_0)

	arg_2_0.itemDataList_ = {}

	if arg_2_0.btnControllerEx_ then
		arg_2_0.lockController = arg_2_0.btnControllerEx_:GetController("statelock01")
	end
end

function var_0_1.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.goBtn_, nil, function()
		JumpTools.GoToSystem("/affixSelectEnterView4_8", {
			activityID = arg_3_0.activityID_
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.lockBtn_, nil, function()
		local var_5_0, var_5_1 = arg_3_0:CheckAdvanceOpenTime()

		manager.tips:ShowTips(var_5_1)
	end)
	arg_3_0:AddBtnListener(nil, arg_3_0.descBtn_, function()
		JumpTools.OpenPageByJump("gameHelp", {
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_AFFIX_CHOOSE_4_8_GAMEPLAY_DESC")
		})
	end)
end

function var_0_1.OnEnter(arg_7_0)
	var_0_1.super.OnEnter(arg_7_0)
	ActivityAffixSelectAction.ReadUnPassRedPoint()

	local var_7_0 = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[arg_7_0.activityID_][1]]

	arg_7_0.titleTet_.text = GetI18NText(var_7_0.name)
	arg_7_0.descTxt_.text = GetI18NText(var_7_0.desc)
end

function var_0_1.OnExit(arg_8_0)
	var_0_1.super.OnExit(arg_8_0)
end

function var_0_1.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0.itemDataList_[arg_9_1] then
		arg_9_0.itemDataList_[arg_9_1] = clone(ItemTemplateData)
		arg_9_0.itemDataList_[arg_9_1].clickFun = function(arg_10_0)
			ShowPopItem(POP_ITEM, {
				arg_10_0.id
			})
		end
	end

	arg_9_0.itemDataList_[arg_9_1].id = arg_9_0.itemIDList_[arg_9_1]
	arg_9_0.itemDataList_[arg_9_1].number = nil

	arg_9_2:SetData(arg_9_0.itemDataList_[arg_9_1])
end

function var_0_1.Dispose(arg_11_0)
	var_0_1.super.Dispose(arg_11_0)
end

function var_0_1.RefreshAcvanceStatus(arg_12_0, arg_12_1)
	if arg_12_0.lockController then
		arg_12_0.lockController:SetSelectedState(arg_12_1 and "normal01" or "lock01")
	end
end

function var_0_1.RefreshTimeText(arg_13_0)
	if arg_13_0.timeText_ then
		if not arg_13_0:isHasLeftTimeDes() then
			local var_13_0, var_13_1 = arg_13_0:CheckAdvanceOpenTime()

			arg_13_0.timeText_.text = var_13_1

			arg_13_0:RefreshAcvanceStatus(not var_13_0)
		else
			arg_13_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_13_0.stopTime_, true)
		end
	end
end

return var_0_1
