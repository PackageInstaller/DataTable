ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("XH1stMusicHomeView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicHomeUI"
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.m_enterBtn, nil, function()
		JumpTools.OpenPageByJump("/enternalMusicMain", {
			activity_id = arg_2_0.activityID_
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("enternalMusicReward", {
			activity_id = arg_2_0.activityID_
		})
	end)
end

function var_0_0.OnEnter(arg_5_0)
	var_0_0.super.OnEnter(arg_5_0)
	manager.redPoint:bindUIandKey(arg_5_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, arg_5_0.activityID_))
	manager.redPoint:bindUIandKey(arg_5_0.m_enterBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, arg_5_0.activityID_))
end

function var_0_0.OnExit(arg_6_0)
	var_0_0.super.OnExit(arg_6_0)
	manager.redPoint:unbindUIandKey(arg_6_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, arg_6_0.activityID_))
	manager.redPoint:unbindUIandKey(arg_6_0.m_enterBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, arg_6_0.activityID_))
end

return var_0_0
