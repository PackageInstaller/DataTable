local var_0_0 = import(".ChapterChallengeItemView")
local var_0_1 = class("ChapterChallengeSoloHeartDemonItemView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	var_0_1.super.InitUI(arg_1_0)
end

function var_0_1.ClickItem(arg_2_0, arg_2_1)
	if arg_2_0:CheckLock() then
		return
	end

	JumpTools.GoToSystem("/soloHeartDemonMain", {})
end

function var_0_1.GetLostTime(arg_3_0)
	return SoloHeartDemonData:GetDataByPara("remainTime")
end

return var_0_1
