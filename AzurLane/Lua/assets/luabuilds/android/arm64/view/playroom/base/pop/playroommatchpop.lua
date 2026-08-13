class = var_0_10000

local var_0_0 = "PlayRoomMatchPop"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiCloseBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		IslandMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.PLAY_ROOM_MATCH_STOP)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	setText = var_1_10001

	local var_2_3 = arg_2_0.uiMatchText

	i18n = var_2_1

	var_1_10001(var_2_3, var_2_1("match_ui_matching_waiting2"))

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0.showState = false

	arg_4_0:Hide()
	arg_4_0:Show(false)

	return
end

function var_0_1.willExit(arg_5_0)
	arg_5_0:detach()

	Object = var_1

	var_1.Destroy(arg_5_0._go)

	arg_5_0._go = nil
	arg_5_0._tf = nil

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	if arg_6_0.showState == false and arg_6_1 == true then
		arg_6_0.showState = arg_6_1
		setActive = var_2

		var_2(arg_6_0._go, false)

		setActive = var_2

		var_2(arg_6_0._go, arg_6_1)

		local var_6_0 = arg_6_0.uiAnimation

		var_2.Play(var_6_0, "Anim_IslandCheatBarEntranceUI_invitePanel_in")

		local var_6_1 = arg_6_0.uiAnimation
		local var_6_2 = var_2.GetComponent(var_6_1, "DftAniEvent")

		var_2.SetEndEvent(var_6_2, function(arg_7_0)
			local var_7_0 = arg_6_0.uiAnimation

			var_1.Play(var_7_0, "Anim_IslandCheatBarEntranceUI_invitePanel_loop")

			return
		end)
	elseif arg_6_0.showState == true and arg_6_1 == false then
		arg_6_0.showState = arg_6_1

		local var_6_3 = arg_6_0.uiAnimation

		var_2.Play(var_6_3, "Anim_IslandCheatBarEntranceUI_invitePanel_out")

		local var_6_4 = arg_6_0.uiAnimation
		local var_6_5 = var_2.GetComponent(var_6_4, "DftAniEvent")

		var_2.SetEndEvent(var_6_5, function(arg_8_0)
			local var_8_0 = arg_6_0

			var_1.Hide(var_8_0)

			return
		end)
	end

	return
end

function var_0_1.Hide(arg_9_0)
	arg_9_0.showState = false
	setActive = var_1

	var_1(arg_9_0._go, false)

	return
end

function var_0_1.RefreshMatch(arg_10_0)
	getProxy = var_1_10001
	PlayRoomProxy = var_1_10003

	local var_10_0 = var_1_10001(var_1_10003)

	arg_10_0:Show(true)

	local var_10_1 = var_10_0
	local var_10_2 = var_10_0.GetMatchTime(var_10_1)
	local var_10_3 = var_10_0:GetMatchStarTime()

	pg = var_10_1

	local var_10_4 = var_10_1.TimeMgr.GetInstance()
	local var_10_5 = var_10_2 - var_4.GetServerTime(var_10_4)
	local var_10_6 = var_4 - var_10_3

	setText = var_1_10007

	local var_10_7 = arg_10_0.uiTipsText

	i18n = var_1_10010

	var_1_10007(var_10_7, var_1_10010("match_ui_matching_waiting1", var_10_6))

	if var_10_5 <= 0 then
		pg = var_7

		local var_10_8 = var_7.GameTrackerMgr.GetInstance()
		local var_10_9 = var_7.Record

		GameTrackerBuilder = var_10

		var_10_9(var_10_8, var_10.BuildPlayRoomMatch("bar", 2, 1, var_10_6, 0))

		pg = var_10_9

		local var_10_10 = var_10_9.TipsMgr.GetInstance()
		local var_10_11 = var_7.ShowTips

		i18n = var_10

		var_10_11(var_10_10, var_10("match_ui_matching_fail"))

		local var_10_12 = arg_10_0
		local var_10_13 = arg_10_0.emit

		IslandMediator = var_10

		var_10_13(var_10_12, var_10.PLAY_ROOM_MATCH_STOP)
	end

	return
end

return var_0_1
