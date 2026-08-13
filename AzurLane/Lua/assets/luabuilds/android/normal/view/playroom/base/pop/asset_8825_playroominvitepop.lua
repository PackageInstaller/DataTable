class = var_0_10000

local var_0_0 = "PlayRoomInvitePop"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)
	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiAgreeBtn

	local function var_2_2()
		getProxy = var_2_10000
		PlayRoomProxy = var_2_10001

		local var_3_0 = var_2_10000(var_2_10001)

		if var_0.GetInviteList(var_3_0)[1] then
			local var_3_1 = var_0[1].roomData.id
			local var_3_2 = arg_2_0
			local var_3_3 = var_3.emit

			IslandMediator = var_2_10005

			var_3_3(var_3_2, var_2_10005.PLAY_ROOM_INVITE_AGREE, {
				id = var_1.id,
				gameType = var_1.gameType
			})

			pg = var_3_3

			local var_3_4 = var_3_3.GameTrackerMgr.GetInstance()
			local var_3_5 = var_3.Record

			GameTrackerBuilder = var_5

			var_3_5(var_3_4, var_5.BuildPlayRoomInvate("bar", var_1.id, 1))
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiCloseBtn

	local function var_2_5()
		getProxy = var_2_10000
		PlayRoomProxy = var_2_10001

		local var_4_0 = var_2_10000(var_2_10001)

		if var_0.GetInviteList(var_4_0)[1] then
			local var_4_1 = var_0[1].roomData.id
			local var_4_2 = arg_2_0
			local var_4_3 = var_2.emit

			IslandMediator = var_2_10004

			var_4_3(var_4_2, var_2_10004.PLAY_ROOM_INVITE_REFUSE, var_4_1)

			pg = var_4_3

			local var_4_4 = var_4_3.GameTrackerMgr.GetInstance()
			local var_4_5 = var_2.Record

			GameTrackerBuilder = var_4

			var_4_5(var_4_4, var_4.BuildPlayRoomInvate("bar", var_4_1, 0))
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	setText = var_1_10001

	local var_2_6 = arg_2_0.uiAgreeText

	i18n = var_2_4

	var_1_10001(var_2_6, var_2_4("match_ui_matching_consent"))

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0.showState = false

	arg_5_0:Hide()
	arg_5_0:Show(false)

	return
end

function var_0_1.willExit(arg_6_0)
	arg_6_0:StopLeanTween()
	arg_6_0:detach()

	Object = var_1

	var_1.Destroy(arg_6_0._go)

	arg_6_0._go = nil
	arg_6_0._tf = nil

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	if arg_7_0.showState == false and arg_7_1 == true then
		setActive = var_2

		var_2(arg_7_0._go, arg_7_1)

		arg_7_0.showState = arg_7_1

		local var_7_0 = arg_7_0.uiAnimation

		var_2.Play(var_7_0, "Anim_IslandCheatBarEntranceUI_invitePanel_in")

		local var_7_1 = arg_7_0.uiAnimation
		local var_7_2 = var_2.GetComponent(var_7_1, "DftAniEvent")

		var_2.SetEndEvent(var_7_2, function(arg_8_0)
			return
		end)
	elseif arg_7_0.showState == true and arg_7_1 == false then
		arg_7_0.showState = arg_7_1

		local var_7_3 = arg_7_0.uiAnimation

		var_2.Play(var_7_3, "Anim_IslandCheatBarEntranceUI_invitePanel_out")

		local var_7_4 = arg_7_0.uiAnimation
		local var_7_5 = var_2.GetComponent(var_7_4, "DftAniEvent")

		var_2.SetEndEvent(var_7_5, function(arg_9_0)
			local var_9_0 = arg_7_0

			var_1.Hide(var_9_0)

			return
		end)
	end

	return
end

function var_0_1.Hide(arg_10_0)
	arg_10_0.showState = false
	setActive = var_1

	var_1(arg_10_0._go, false)

	return
end

function var_0_1.RefreshInvite(arg_11_0)
	getProxy = var_1_10001
	PlayRoomProxy = var_1_10002

	local var_11_0 = var_1_10001(var_1_10002)
	local var_11_1 = var_1.GetInviteList(var_11_0)

	arg_11_0:Show(var_11_1[1] ~= nil)

	if var_11_1[1] and arg_11_0.endTime ~= var_11_1[1].timestamp then
		arg_11_0:RefreshUI(var_11_1[1])

		arg_11_0.endTime = var_11_1[1].timestamp
		pg = var_3

		local var_11_2 = var_3.gameset.match_refuseCD.key_value
		local var_11_3 = arg_11_0
		local var_11_4 = arg_11_0.StartLeanTween

		pg = var_1_10006

		local var_11_5 = var_1_10006.TimeMgr.GetInstance()

		var_11_4(var_11_3, var_6.GetServerTime(var_11_5), var_11_1[1].timestamp + var_11_2)
	end

	return
end

function var_0_1.RefreshUI(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.invitor
	local var_12_1 = arg_12_1.roomData

	setText = var_1_10004

	var_1_10004(arg_12_0.uiNameText, var_12_0.name)

	setText = var_1_10004

	local var_12_2 = arg_12_0.uiCntText

	string = var_6

	local var_12_3 = var_6.format
	local var_12_4 = "%s/%s"
	local var_12_5 = var_12_1.teamCnt

	PlayRoomTools = var_1_10009

	var_1_10004(var_12_2, var_12_3(var_12_4, var_12_5, var_1_10009.GetMaxPlayerCnt(var_12_1.gameType)))

	Ship = var_1_10004

	local var_12_6 = var_1_10004.New({
		configId = var_12_0.display.icon
	})

	LoadSpriteAsync = var_5

	var_5("qicon/" .. var_12_6:getPrefab(), function(arg_13_0)
		arg_12_0.uiIcon.sprite = arg_13_0

		return
	end)

	return
end

function var_0_1.StartLeanTween(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:StopLeanTween()

	if arg_14_2 <= arg_14_1 then
		return
	end

	LeanTween = var_3

	local var_14_0 = var_3.value
	local var_14_1 = arg_14_0._go
	local var_14_2 = arg_14_2 - arg_14_1

	pg = var_1_10006

	local var_14_3 = var_14_0(var_14_1, var_14_2 / var_1_10006.gameset.match_refuseCD.key_value, 0, arg_14_2 - arg_14_1)
	local var_14_4 = var_3.setOnUpdate

	System = var_5

	local var_14_5 = var_14_4(var_14_3, var_5.Action_float(function(arg_15_0)
		arg_14_0.uiSlider.fillAmount = arg_15_0

		return
	end))
	local var_14_6 = var_3.setOnComplete

	System = var_5

	var_14_6(var_14_5, var_5.Action(function()
		local var_16_0 = arg_14_0

		var_0.StopLeanTween(var_16_0)

		return
	end))

	return
end

function var_0_1.StopLeanTween(arg_17_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_17_0._go)

	return
end

return var_0_1
