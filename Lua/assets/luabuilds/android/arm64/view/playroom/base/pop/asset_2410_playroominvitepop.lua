local PlayRoomInvitePop = class("PlayRoomInvitePop", import("view.base.BasePanel"))

function PlayRoomInvitePop:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	PlayRoomInvitePop.super.Ctor(self, self._go)
	self:attach(arg_1_2)
	self:Init()

	return
end

function PlayRoomInvitePop:Init()
	onButton(self, self.uiAgreeBtn, function()
		local var_3_0 = getProxy(PlayRoomProxy):GetInviteList()

		if var_3_0[1] then
			self:emit(IslandMediator.PLAY_ROOM_INVITE_AGREE, {
				id = var_3_0[1].roomData.id,
				gameType = var_3_0[1].roomData.gameType
			})
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomInvate("bar", var_3_0[1].roomData.id, 1))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.uiCloseBtn, function()
		local var_4_0 = getProxy(PlayRoomProxy):GetInviteList()

		if var_4_0[1] then
			self:emit(IslandMediator.PLAY_ROOM_INVITE_REFUSE, var_4_0[1].roomData.id)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomInvate("bar", var_4_0[1].roomData.id, 0))
		end

		return
	end, SFX_PANEL)
	setText(self.uiAgreeText, i18n("match_ui_matching_consent"))

	return
end

function PlayRoomInvitePop:didEnter()
	self.showState = false

	self:Hide()
	self:Show(false)

	return
end

function PlayRoomInvitePop:willExit()
	self:StopLeanTween()
	self:detach()
	Object.Destroy(self._go)

	self._go = nil
	self._tf = nil

	return
end

function PlayRoomInvitePop:Show(arg_7_1)
	if self.showState == false and arg_7_1 == true then
		setActive(self._go, arg_7_1)

		self.showState = arg_7_1

		self.uiAnimation:Play("Anim_IslandCheatBarEntranceUI_invitePanel_in")
		self.uiAnimation:GetComponent("DftAniEvent"):SetEndEvent(function(arg_8_0)
			return
		end)
	elseif self.showState == true and arg_7_1 == false then
		self.showState = arg_7_1

		self.uiAnimation:Play("Anim_IslandCheatBarEntranceUI_invitePanel_out")
		self.uiAnimation:GetComponent("DftAniEvent"):SetEndEvent(function(arg_9_0)
			self:Hide()

			return
		end)
	end

	return
end

function PlayRoomInvitePop:Hide()
	self.showState = false

	setActive(self._go, false)

	return
end

function PlayRoomInvitePop:RefreshInvite()
	local var_11_0 = getProxy(PlayRoomProxy):GetInviteList()

	self:Show(var_11_0[1] ~= nil)

	if var_11_0[1] and self.endTime ~= var_11_0[1].timestamp then
		self:RefreshUI(var_11_0[1])

		self.endTime = var_11_0[1].timestamp

		self:StartLeanTween(pg.TimeMgr.GetInstance():GetServerTime(), var_11_0[1].timestamp + pg.gameset.match_refuseCD.key_value)
	end

	return
end

function PlayRoomInvitePop:RefreshUI(arg_12_1)
	setText(self.uiNameText, arg_12_1.invitor.name)
	setText(self.uiCntText, string.format("%s/%s", arg_12_1.roomData.teamCnt, PlayRoomTools.GetMaxPlayerCnt(arg_12_1.roomData.gameType)))
	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = arg_12_1.invitor.display.icon
	}):getPrefab(), function(arg_13_0)
		self.uiIcon.sprite = arg_13_0

		return
	end)

	return
end

function PlayRoomInvitePop:StartLeanTween(arg_14_1, arg_14_2)
	self:StopLeanTween()

	if arg_14_2 <= arg_14_1 then
		return
	end

	LeanTween.value(self._go, (arg_14_2 - arg_14_1) / pg.gameset.match_refuseCD.key_value, 0, arg_14_2 - arg_14_1):setOnUpdate(System.Action_float(function(arg_15_0)
		self.uiSlider.fillAmount = arg_15_0

		return
	end)):setOnComplete(System.Action(function()
		self:StopLeanTween()

		return
	end))

	return
end

function PlayRoomInvitePop:StopLeanTween()
	LeanTween.cancel(self._go)

	return
end

return PlayRoomInvitePop
