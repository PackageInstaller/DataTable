local var_0_0 = class("FireWorkShowView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/Firework/FireworkUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.criMovie_ = arg_4_0.m_movie:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer_ = arg_4_0.criMovie_.player
	arg_4_0.criplayer_.statusChangeCallback = nil
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.OnTop(arg_6_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.CirMovieStatusChange(arg_7_0, arg_7_1)
	local var_7_0 = tostring(arg_7_1)

	if var_7_0 == "PlayEnd" or var_7_0 == "Stop" then
		arg_7_0:ShowOver()
	end
end

function var_0_0.ShowOver(arg_8_0)
	if arg_8_0.timer then
		arg_8_0.timer:Stop()

		arg_8_0.timer = nil
	end

	arg_8_0.criplayer_.statusChangeCallback = nil

	local var_8_0 = ActivityFireWorkCfg[arg_8_0.activity_id].story_id

	manager.story:StartStoryById(var_8_0, function(arg_9_0)
		JumpTools.OpenPageByJump("/fireWorkMain", {
			fire_activity_id = arg_8_0.activity_id
		})
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activity_id = arg_10_0.params_.fire_activity_id

	local var_10_0 = ActivityFireWorkCfg[arg_10_0.activity_id]
	local var_10_1 = 20

	arg_10_0.timer = Timer.New(function()
		arg_10_0:ShowOver()
	end, var_10_1, 1)

	arg_10_0.timer:Start()

	local var_10_2 = manager.audio:GetMusicVolume()

	arg_10_0.criplayer_:SetVolume(var_10_2)
	SetFile(arg_10_0.criplayer_, nil, var_10_0.fireworks)
	arg_10_0.criMovie_:Play()

	arg_10_0.criplayer_.statusChangeCallback = handler(arg_10_0, arg_10_0.CirMovieStatusChange)
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()

	if arg_12_0.timer then
		arg_12_0.timer:Stop()

		arg_12_0.timer = nil
	end

	arg_12_0.criplayer_.statusChangeCallback = nil
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
