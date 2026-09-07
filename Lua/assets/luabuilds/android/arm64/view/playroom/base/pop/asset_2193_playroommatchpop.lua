local PlayRoomMatchPop = class("PlayRoomMatchPop", import("view.base.BasePanel"))

function PlayRoomMatchPop:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	PlayRoomMatchPop.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function PlayRoomMatchPop:Init()
	onButton(self, self.uiCloseBtn, function()
		self:emit(IslandMediator.PLAY_ROOM_MATCH_STOP)

		return
	end, SFX_PANEL)
	setText(self.uiMatchText, i18n("match_ui_matching_waiting2"))

	return
end

function PlayRoomMatchPop:didEnter()
	self.showState = false

	self:Hide()
	self:Show(false)

	return
end

function PlayRoomMatchPop:willExit()
	self:detach()
	Object.Destroy(self._go)

	self._go = nil
	self._tf = nil

	return
end

function PlayRoomMatchPop:Show(arg_6_1)
	if self.showState == false and arg_6_1 == true then
		self.showState = arg_6_1

		setActive(self._go, false)
		setActive(self._go, arg_6_1)
		self.uiAnimation:Play("Anim_IslandCheatBarEntranceUI_invitePanel_in")
		self.uiAnimation:GetComponent("DftAniEvent"):SetEndEvent(function(arg_7_0)
			self.uiAnimation:Play("Anim_IslandCheatBarEntranceUI_invitePanel_loop")

			return
		end)
	elseif self.showState == true and arg_6_1 == false then
		self.showState = arg_6_1

		self.uiAnimation:Play("Anim_IslandCheatBarEntranceUI_invitePanel_out")
		self.uiAnimation:GetComponent("DftAniEvent"):SetEndEvent(function(arg_8_0)
			self:Hide()

			return
		end)
	end

	return
end

function PlayRoomMatchPop:Hide()
	self.showState = false

	setActive(self._go, false)

	return
end

function PlayRoomMatchPop:RefreshMatch()
	local var_10_0 = getProxy(PlayRoomProxy)

	self:Show(true)

	local var_10_1 = pg.TimeMgr.GetInstance()
	local var_10_2 = var_10_1:GetServerTime()

	setText(self.uiTipsText, i18n("match_ui_matching_waiting1", var_10_1))

	if var_10_0:GetMatchTime() - var_10_2 <= 0 then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomMatch("bar", 2, 1, var_10_2 - var_10_0:GetMatchStarTime(), 0))
		pg.TipsMgr.GetInstance():ShowTips(i18n("match_ui_matching_fail"))
		self:emit(IslandMediator.PLAY_ROOM_MATCH_STOP)
	end

	return
end

return PlayRoomMatchPop
