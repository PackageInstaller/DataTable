local var_0_0 = class("ChessMenu", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/WarChess_Battle/WarChessMenu"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BindCfgUI(arg_4_0.summercontextTrs_)

	arg_4_0.themeCon_ = ControllerUtil.GetController(arg_4_0.transform_, "name")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelbtnBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("CONFIRM_TO_QUIT_CHESS"),
			OkCallback = function()
				OnExitChessScene(true)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.okbtnBtn_, nil, function()
		OnExitChessScene(false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		arg_5_0:Back()

		if arg_5_0.callback_ then
			arg_5_0.callback_()
		end
	end)
end

function var_0_0.OnEnter(arg_11_0)
	local var_11_0 = WarchessLevelCfg[manager.ChessManager.ChapterID].extra_gameplay

	arg_11_0.callback_ = arg_11_0.params_.callback

	if table.indexof(var_11_0, 3) then
		arg_11_0.themeCon_:SetSelectedState("summer")
		arg_11_0:RefreshSummerUI()
	else
		arg_11_0.themeCon_:SetSelectedState("normal")
		arg_11_0:RefreshUI()
	end
end

function var_0_0.RefreshUI(arg_12_0)
	local var_12_0 = manager.ChessManager.ChapterID
	local var_12_1 = WarChessData:GetBoxNum(var_12_0, ChessConst.BOX.SMALL)
	local var_12_2 = WarChessData:GetBoxNum(var_12_0, ChessConst.BOX.BIG)
	local var_12_3 = var_12_1 * WarchessLevelCfg[var_12_0].sbox_progress
	local var_12_4 = var_12_2 * WarchessLevelCfg[var_12_0].lbox_progress

	arg_12_0.progressText_.text = (var_12_3 + var_12_4 > 100 and 100 or var_12_3 + var_12_4) .. "%"
	arg_12_0.box1Text_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", var_12_1, WarchessLevelCfg[var_12_0].sbox_num)
	arg_12_0.box2Text_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", var_12_2, WarchessLevelCfg[var_12_0].lbox_num)

	local var_12_5 = (var_12_3 + var_12_4) / 100

	arg_12_0.progressimgImg_.fillAmount = var_12_5

	local var_12_6 = arg_12_0.progressimgImg_.transform.rect.width / 2
	local var_12_7 = WarchessLevelCfg[var_12_0].success_progress / 100 * 2 * math.pi
	local var_12_8 = math.sin(var_12_7)
	local var_12_9 = math.cos(var_12_7)

	arg_12_0.progressmarkerTrs_.localPosition = Vector2(var_12_8, var_12_9) * var_12_6
	arg_12_0.chapternameText_.text = ChapterClientCfg[var_12_0] and GetI18NText(ChapterClientCfg[var_12_0].name) or GetI18NText(WarchessLevelCfg[var_12_0].name_level)
end

function var_0_0.RefreshSummerUI(arg_13_0)
	local var_13_0 = manager.ChessManager.ChapterID
	local var_13_1 = WarChessData:GetBoxNum(var_13_0, ChessConst.BOX.SMALL)
	local var_13_2 = WarChessData:GetBoxNum(var_13_0, ChessConst.BOX.BIG)
	local var_13_3 = WarChessData:GetItemData()[ChessConst.BOX.CLUE] or 0
	local var_13_4 = var_13_1 * WarchessLevelCfg[var_13_0].sbox_progress
	local var_13_5 = var_13_2 * WarchessLevelCfg[var_13_0].lbox_progress
	local var_13_6 = var_13_3 * (100 / WarchessLevelCfg[var_13_0].clue_sum)

	arg_13_0.progressleftText_.text = var_13_4 + var_13_5 > 100 and 100 or var_13_4 + var_13_5
	arg_13_0.boxupText_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", var_13_1, WarchessLevelCfg[var_13_0].sbox_num)
	arg_13_0.boxdownText_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", var_13_2, WarchessLevelCfg[var_13_0].lbox_num)
	arg_13_0.progressrightText_.text = string.format("%d", var_13_6)
	arg_13_0.clueText_.text = string.format("%d<size=36><color=#b5b5b5>/%d</color></size>", var_13_3, WarchessLevelCfg[var_13_0].clue_sum)

	local var_13_7 = (var_13_4 + var_13_5) / 100

	arg_13_0.progressleftImg_.fillAmount = var_13_7

	local var_13_8 = var_13_6 / 100

	arg_13_0.progressrightImg_.fillAmount = var_13_8
	arg_13_0.chaptername2Text_.text = ChapterClientCfg[var_13_0] and ChapterClientCfg[var_13_0].name or WarchessLevelCfg[var_13_0].name_level
end

function var_0_0.OnExit(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
