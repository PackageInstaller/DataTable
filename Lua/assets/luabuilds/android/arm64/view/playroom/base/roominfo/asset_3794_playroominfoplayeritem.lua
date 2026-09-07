local PlayRoomInfoPlayerItem = class("PlayRoomInfoPlayerItem", import("view.base.BasePanel"))

function PlayRoomInfoPlayerItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	PlayRoomInfoPlayerItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function PlayRoomInfoPlayerItem:Init()
	onButton(self, self.uiBgTf, function()
		self:emit(PlayRoomInfoMediator.ON_CLICK_INVITE)

		return
	end, SFX_PANEL)
	onButton(self, self.uiKickTf, function()
		self:emit(PlayRoomInfoMediator.ON_CLICK_KICK, {
			id = self.playerData.id
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiSwitchCharacterBtn, function()
		self:emit(PlayRoomInfoMediator.ON_CLICK_CHANGE_CHARACTER)

		return
	end, SFX_PANEL)

	return
end

function PlayRoomInfoPlayerItem:didEnter(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	self.isSelf = false

	if arg_6_1 then
		self.playerData = arg_6_1

		local var_6_0 = getProxy(PlayerProxy):getPlayerId()
		local var_6_1 = var_6_0 == arg_6_1.id

		self.isSelf = var_6_0 == arg_6_1.id

		setActive(self.uiBgTf, false)
		setActive(self.uiMainTf, true)
		setText(self.uiNameText, arg_6_1.name)
		setActive(self.uiRoomOwnerGo, arg_6_2 == arg_6_1.id)
		setActive(self.uiKickTf, arg_6_2 == var_6_0 and not var_6_1)

		local var_6_2 = getProxy(PlayRoomProxy):GetRoomData()

		setActive(self.uiSwitchCharacterBtn, (arg_6_2 == var_6_0 or not arg_6_4) and var_6_1 and arg_6_3 ~= IslandCheaterTavernConst.SceneRoomType.MatchInfoRoom and not arg_6_5)
	else
		setActive(self.uiBgTf, true)
		setActive(self.uiMainTf, false)
	end

	if arg_6_5 then
		setActive(self.uiLoadProcessBg, true)

		self.uiLoadProcess.fillAmount = arg_6_5 / 100
	else
		setActive(self.uiLoadProcessBg, false)
	end

	setActive(self._go, true)

	return
end

function PlayRoomInfoPlayerItem:RefreshSelfLoad(arg_7_1)
	if self.isSelf then
		setActive(self.uiLoadProcessBg, true)

		self.uiLoadProcess.fillAmount = arg_7_1 / 100
	end

	return
end

function PlayRoomInfoPlayerItem:willExit()
	self:detach()
	Object.Destroy(self._go)

	self._go = nil
	self._tf = nil

	return
end

return PlayRoomInfoPlayerItem
