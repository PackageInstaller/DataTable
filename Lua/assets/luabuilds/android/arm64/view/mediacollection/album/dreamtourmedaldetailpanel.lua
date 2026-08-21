local var_0_0 = class("DreamTourMedalDetailPanel", import("view.mediaCollection.album.MedalDetailPanel"))

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)

	arg_1_0._stateBg = findTF(arg_1_0._tf, "state_bg")
	arg_1_0._progressLockText = findTF(arg_1_0._tf, "progress/lock/label")

	setText(arg_1_0._progressLockText, i18n("word_lock"))

	return
end

function var_0_0.UpdateMedal(arg_2_0)
	var_0_0.super.UpdateMedal(arg_2_0)
	SetActive(arg_2_0._stateBg, arg_2_0._medalGroup:GetMedalGroupState() ~= ActivityMedalGroup.STATE_ACTIVE)

	return
end

return var_0_0
