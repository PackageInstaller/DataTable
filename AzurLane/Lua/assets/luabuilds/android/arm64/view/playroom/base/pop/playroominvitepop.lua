local var_0_0 = class("PlayRoomInvitePop", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)
	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiAgreeBtn, function()
		local var_3_0 = getProxy(PlayRoomProxy):GetInviteList()

		if var_3_0[1] then
			arg_2_0:emit(IslandMediator.PLAY_ROOM_INVITE_AGREE, {
				id = var_3_0[1].roomData.id,
				gameType = var_3_0[1].roomData.gameType
			})
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomInvate("bar", var_3_0[1].roomData.id, 1))
		end

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		local var_4_0 = getProxy(PlayRoomProxy):GetInviteList()

		if var_4_0[1] then
			arg_2_0:emit(IslandMediator.PLAY_ROOM_INVITE_REFUSE, var_4_0[1].roomData.id)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomInvate("bar", var_4_0[1].roomData.id, 0))
		end

		return
	end, SFX_PANEL)
	setText(arg_2_0.uiAgreeText, i18n("match_ui_matching_consent"))

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0.showState = false

	arg_5_0:Hide()
	arg_5_0:Show(false)

	return
end

function var_0_0.willExit(arg_6_0)
	arg_6_0:StopLeanTween()
	arg_6_0:detach()
	Object.Destroy(arg_6_0._go)

	arg_6_0._go = nil
	arg_6_0._tf = nil

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	if arg_7_0.showState == false and arg_7_1 == true then
		setActive(arg_7_0._go, arg_7_1)

		arg_7_0.showState = arg_7_1

		arg_7_0.uiAnimation:Play("Anim_IslandCheatBarEntranceUI_invitePanel_in")
		arg_7_0.uiAnimation:GetComponent("DftAniEvent"):SetEndEvent(function(arg_8_0)
			return
		end)
	elseif arg_7_0.showState == true and arg_7_1 == false then
		arg_7_0.showState = arg_7_1

		arg_7_0.uiAnimation:Play("Anim_IslandCheatBarEntranceUI_invitePanel_out")
		arg_7_0.uiAnimation:GetComponent("DftAniEvent"):SetEndEvent(function(arg_9_0)
			arg_7_0:Hide()

			return
		end)
	end

	return
end

function var_0_0.Hide(arg_10_0)
	arg_10_0.showState = false

	setActive(arg_10_0._go, false)

	return
end

function var_0_0.RefreshInvite(arg_11_0)
	local var_11_0 = getProxy(PlayRoomProxy):GetInviteList()

	arg_11_0:Show(var_11_0[1] ~= nil)

	if var_11_0[1] and arg_11_0.endTime ~= var_11_0[1].timestamp then
		arg_11_0:RefreshUI(var_11_0[1])

		arg_11_0.endTime = var_11_0[1].timestamp

		arg_11_0:StartLeanTween(pg.TimeMgr.GetInstance():GetServerTime(), var_11_0[1].timestamp + pg.gameset.match_refuseCD.key_value)
	end

	return
end

function var_0_0.RefreshUI(arg_12_0, arg_12_1)
	setText(arg_12_0.uiNameText, arg_12_1.invitor.name)
	setText(arg_12_0.uiCntText, string.format("%s/%s", arg_12_1.roomData.teamCnt, PlayRoomTools.GetMaxPlayerCnt(arg_12_1.roomData.gameType)))
	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = arg_12_1.invitor.display.icon
	}):getPrefab(), function(arg_13_0)
		arg_12_0.uiIcon.sprite = arg_13_0

		return
	end)

	return
end

function var_0_0.StartLeanTween(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:StopLeanTween()

	if arg_14_2 <= arg_14_1 then
		return
	end

	LeanTween.value(arg_14_0._go, (arg_14_2 - arg_14_1) / pg.gameset.match_refuseCD.key_value, 0, arg_14_2 - arg_14_1):setOnUpdate(System.Action_float(function(arg_15_0)
		arg_14_0.uiSlider.fillAmount = arg_15_0

		return
	end)):setOnComplete(System.Action(function()
		arg_14_0:StopLeanTween()

		return
	end))

	return
end

function var_0_0.StopLeanTween(arg_17_0)
	LeanTween.cancel(arg_17_0._go)

	return
end

return var_0_0
