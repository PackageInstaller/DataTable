local var_0_0 = class("PlayRoomMatchPop", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:emit(IslandMediator.PLAY_ROOM_MATCH_STOP)

		return
	end, SFX_PANEL)
	setText(arg_2_0.uiMatchText, i18n("match_ui_matching_waiting2"))

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0.showState = false

	arg_4_0:Hide()
	arg_4_0:Show(false)

	return
end

function var_0_0.willExit(arg_5_0)
	arg_5_0:detach()
	Object.Destroy(arg_5_0._go)

	arg_5_0._go = nil
	arg_5_0._tf = nil

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	if arg_6_0.showState == false and arg_6_1 == true then
		arg_6_0.showState = arg_6_1

		setActive(arg_6_0._go, false)
		setActive(arg_6_0._go, arg_6_1)
		arg_6_0.uiAnimation:Play("Anim_IslandCheatBarEntranceUI_invitePanel_in")
		arg_6_0.uiAnimation:GetComponent("DftAniEvent"):SetEndEvent(function(arg_7_0)
			arg_6_0.uiAnimation:Play("Anim_IslandCheatBarEntranceUI_invitePanel_loop")

			return
		end)
	elseif arg_6_0.showState == true and arg_6_1 == false then
		arg_6_0.showState = arg_6_1

		arg_6_0.uiAnimation:Play("Anim_IslandCheatBarEntranceUI_invitePanel_out")
		arg_6_0.uiAnimation:GetComponent("DftAniEvent"):SetEndEvent(function(arg_8_0)
			arg_6_0:Hide()

			return
		end)
	end

	return
end

function var_0_0.Hide(arg_9_0)
	arg_9_0.showState = false

	setActive(arg_9_0._go, false)

	return
end

function var_0_0.RefreshMatch(arg_10_0)
	local var_10_9000
	local var_10_0 = getProxy(PlayRoomProxy)

	arg_10_0:Show(true)

	local var_10_1 = pg.TimeMgr.GetInstance()
	local var_10_2 = var_10_1.GetServerTime(var_10_9000)

	setText(arg_10_0.uiTipsText, i18n("match_ui_matching_waiting1", var_10_1))

	if var_10_0:GetMatchTime() - var_10_2 <= 0 then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomMatch("bar", 2, 1, var_10_2 - var_10_0:GetMatchStarTime(), 0))
		pg.TipsMgr.GetInstance():ShowTips(i18n("match_ui_matching_fail"))
		arg_10_0:emit(IslandMediator.PLAY_ROOM_MATCH_STOP)
	end

	return
end

return var_0_0
