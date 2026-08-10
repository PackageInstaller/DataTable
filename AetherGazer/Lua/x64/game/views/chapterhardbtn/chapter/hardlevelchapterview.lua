local var_0_0 = class("HardLevelChapterView", import("..HardLevelBaseView"))

function var_0_0.GetHardLevelItem(arg_1_0)
	return HardLevelChapterItem
end

function var_0_0.OnExit(arg_2_0)
	var_0_0.super.OnExit(arg_2_0)
	arg_2_0:ShowRedPoint(true)
end

function var_0_0.ShowDifficultPanel(arg_3_0, arg_3_1)
	var_0_0.super.ShowDifficultPanel(arg_3_0, arg_3_1)
	arg_3_0:ShowRedPoint(arg_3_1)
end

function var_0_0.ShowRedPoint(arg_4_0, arg_4_1)
	if not arg_4_1 then
		if not arg_4_0.isBind_ then
			manager.redPoint:bindUIandKey(arg_4_0.transform_, RedPointConst.COMBAT_PLOT)

			arg_4_0.isBind_ = true
		end
	elseif arg_4_0.isBind_ then
		manager.redPoint:unbindUIandKey(arg_4_0.transform_, RedPointConst.COMBAT_PLOT)

		arg_4_0.isBind_ = false
	end
end

return var_0_0
