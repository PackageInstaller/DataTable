SectionBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local var_0_0 = class("BlisterChapterSectionInfoView", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0:InitUI()

	arg_1_0.nodeList = {}

	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockControl = arg_2_0.btnControllerexcollection_:GetController("lock")
	arg_2_0.sectionControl = arg_2_0.sububbleinfouiControllerexcollection_:GetController("section")
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.UIName(arg_4_0)
	return "Widget/System/Summer2024/Summer2024_Bubble/SUBubbleInfoUI"
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.battleBtn_, nil, function()
		arg_5_0:Back()
		arg_5_0:OnClickBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	return
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0.id = arg_9_0.params_.id

	arg_9_0:RefreshData()
end

function var_0_0.RefreshData(arg_10_0)
	local var_10_0 = arg_10_0.params_.id
	local var_10_1 = ActivityBubbleCfg[var_10_0]

	if var_10_1 then
		local var_10_2 = BlisterGameData:GetStageInfo(var_10_0)

		arg_10_0.textcheckpointnameText_.text = var_10_1.name

		for iter_10_0 = 1, 3 do
			if not arg_10_0.nodeList[iter_10_0] then
				arg_10_0.nodeList[iter_10_0] = BlisterGoalItem.New(arg_10_0[string.format("ndnum0%sGo_", iter_10_0)])
			end

			isGet = var_10_2 and iter_10_0 <= var_10_2.star or false

			arg_10_0.nodeList[iter_10_0]:SetData(isGet, var_10_1.score_level[iter_10_0] or 0)
		end

		arg_10_0.lockControl:SetSelectedState(BlisterGameData:GetStageIdIsOpen(var_10_0) and "false" or "true")

		local var_10_3 = BlisterGameTool.GetIsFirstSession(var_10_1.activity_id)
		local var_10_4 = BlisterGameData.activityID == ActivityConst.ACTIVITY_3_4_BLISTER_GAME and "down" or "down2"

		arg_10_0.textnum01Text_.text = var_10_2 and var_10_2.value or "-----------"

		arg_10_0.sectionControl:SetSelectedState(var_10_3 and "up" or var_10_4)
	end
end

function var_0_0.OnClickBtn(arg_11_0)
	local var_11_0 = ActivityBubbleCfg[arg_11_0.id]

	BlisterGameData:SavePassId(arg_11_0.id)
	BlisterGameAction.PlayGame(var_11_0.map)
end

function var_0_0.OnExit(arg_12_0)
	var_0_0.super.OnExit(arg_12_0)
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.nodeList) do
		iter_13_1:Dispose()
	end

	arg_13_0.nodeList = {}

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
