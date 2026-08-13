class = var_0_10000

local var_0_0 = "DreamTourMedalDetailPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.mediaCollection.album.MedalDetailPanel"))

function var_0_1.InitUI(arg_1_0)
	var_0_1.super.InitUI(arg_1_0)

	findTF = var_1
	arg_1_0._stateBg = var_1(arg_1_0._tf, "state_bg")
	findTF = var_1
	arg_1_0._progressLockText = var_1(arg_1_0._tf, "progress/lock/label")
	setText = var_1

	local var_1_0 = arg_1_0._progressLockText

	i18n = var_4

	var_1(var_1_0, var_4("word_lock"))

	return
end

function var_0_1.UpdateMedal(arg_2_0)
	var_0_1.super.UpdateMedal(arg_2_0)

	local var_2_0 = arg_2_0._medalGroup
	local var_2_1 = var_1.GetMedalGroupState(var_2_0)

	SetActive = var_1_10002

	local var_2_2 = arg_2_0._stateBg

	ActivityMedalGroup = var_1_10005

	var_1_10002(var_2_2, var_2_1 ~= var_1_10005.STATE_ACTIVE)

	return
end

return var_0_1
