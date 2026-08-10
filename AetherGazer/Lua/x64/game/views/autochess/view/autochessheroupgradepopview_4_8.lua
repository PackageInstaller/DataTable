local var_0_0 = require("game.views.autoChess.view.AutoChessHeroUpgradePopView")
local var_0_1 = class("AutoChessHeroUpgradePopView_4_8", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_Xihe/Activity_Xihe_UpgradePopUI"
end

function var_0_1.InitUI(arg_2_0)
	var_0_1.super.InitUI(arg_2_0)

	arg_2_0.autoChessCountDownView_ = AutoChessCountDownView.New(arg_2_0.timerGo_)
end

function var_0_1.OnEnter(arg_3_0)
	var_0_1.super.OnEnter(arg_3_0)

	arg_3_0.attrSelectText_.text = "(0/1)"
	arg_3_0.skillSelectText_.text = "(0/1)"

	arg_3_0.autoChessCountDownView_:UpdateCountDownTime()
end

function var_0_1.OnExit(arg_4_0)
	arg_4_0.super.OnExit(arg_4_0)
end

function var_0_1.ClickFunc(arg_5_0, arg_5_1)
	var_0_1.super.ClickFunc(arg_5_0, arg_5_1)

	local var_5_0 = arg_5_0.selectedAttrItem and 1 or 0
	local var_5_1 = arg_5_0.selectedBuffItem and 1 or 0

	arg_5_0.attrSelectText_.text = string.format("(%d/1)", var_5_0)
	arg_5_0.skillSelectText_.text = string.format("(%d/1)", var_5_1)
end

function var_0_1.OnUpgradeHero(arg_6_0)
	if arg_6_0.params_.upgradeBackCb then
		arg_6_0.params_.upgradeBackCb()
	end

	if arg_6_0.selectedAttrItem and arg_6_0.selectedBuffItem then
		AutoChessTools.PlayerCheesUpgrade(arg_6_0.params_.gameType, arg_6_0.selectedAttrItem.index_, arg_6_0.selectedBuffItem.index_)
	end
end

function var_0_1.Dispose(arg_7_0)
	if arg_7_0.autoChessCountDownView_ then
		arg_7_0.autoChessCountDownView_:Dispose()

		arg_7_0.autoChessCountDownView_ = nil
	end

	var_0_1.super.Dispose(arg_7_0)
end

return var_0_1
