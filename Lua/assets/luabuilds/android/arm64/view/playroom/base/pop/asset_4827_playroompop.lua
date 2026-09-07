local PlayRoomPop = class("PlayRoomPop", import("view.base.BasePanel"))

function PlayRoomPop:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	PlayRoomPop.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function PlayRoomPop:Init()
	self.playRoomInvitePop = PlayRoomInvitePop.New(self._tf:Find("invitePanel"), self._parentClass)
	self.playRoomMatchPop = PlayRoomMatchPop.New(self._tf:Find("matchPanel"), self._parentClass)

	return
end

function PlayRoomPop:didEnter()
	setParent(self._go, pg.UIMgr.GetInstance().OverlayToast)
	self.playRoomInvitePop:Hide()
	self.playRoomMatchPop:Hide()
	self:RefreshUI()

	self.timer = Timer.New(function()
		self:RefreshUI()

		return
	end, 0.5, -1)

	self.timer:Start()
	self.playRoomInvitePop:didEnter()
	self.playRoomMatchPop:didEnter()

	return
end

function PlayRoomPop:RefreshUI()
	if getProxy(PlayRoomProxy):GetMatchFlag() then
		self.playRoomMatchPop:RefreshMatch()
		self.playRoomInvitePop:Show(false)
	else
		self.playRoomInvitePop:RefreshInvite()
		self.playRoomMatchPop:Show(false)
	end

	return
end

function PlayRoomPop:willExit()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:detach()
	self.playRoomInvitePop:willExit()

	self.playRoomInvitePop = nil

	self.playRoomMatchPop:willExit()

	self.playRoomMatchPop = nil

	Object.Destroy(self._go)

	return
end

function PlayRoomPop:Show(arg_7_1)
	setActive(self._go, arg_7_1)
	self.playRoomInvitePop:Hide(false)
	self.playRoomMatchPop:Hide(false)

	return
end

return PlayRoomPop
