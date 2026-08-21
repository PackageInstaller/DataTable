ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("V210MusicHomeView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicHomeUI"
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.m_enterBtn, nil, function()
		JumpTools.OpenPageByJump("/V210MusicMain", {
			activity_id = arg_2_0.activityID_
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("V210MusicReward", {
			activity_id = arg_2_0.activityID_
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.descbtnBtn_, nil, function()
		local var_5_0 = GameSetting.v210_music_describe and GameSetting.v210_music_describe.value or {}

		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_5_0
		})
	end)
end

function var_0_0.OnEnter(arg_6_0)
	MusicData:SetPageActivityId(arg_6_0.activityID_)
	var_0_0.super.OnEnter(arg_6_0)
	manager.redPoint:bindUIandKey(arg_6_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, arg_6_0.activityID_))
	manager.redPoint:bindUIandKey(arg_6_0.m_enterBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, arg_6_0.activityID_))

	arg_6_0.textcontentText_.text = GetTips("ACTIVITY_MUSIC_2_10_CONTENT")
end

function var_0_0.OnExit(arg_7_0)
	var_0_0.super.OnExit(arg_7_0)
	manager.redPoint:unbindUIandKey(arg_7_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, arg_7_0.activityID_))
	manager.redPoint:unbindUIandKey(arg_7_0.m_enterBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, arg_7_0.activityID_))
end

return var_0_0
