local PlayRoomInfoViewerItem = class("PlayRoomInfoViewerItem", import("view.base.BasePanel"))

function PlayRoomInfoViewerItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	PlayRoomInfoViewerItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function PlayRoomInfoViewerItem:Init()
	return
end

function PlayRoomInfoViewerItem:didEnter(arg_3_1, arg_3_2)
	setText(self.uiNameText, arg_3_1.name)
	setText(self.uiPtCntText, arg_3_1.ptCnt)
	setText(self.uiServeText, "区服")
	setActive(self.uiKickBtn, arg_3_2)
	onButton(self, self.uiKickBtn, function()
		self:emit(PlayRoomInfoViewerMediator.ON_CLICK_KICK, {
			id = arg_3_1.id
		})

		return
	end, SFX_PANEL)
	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = arg_3_1.displayicon
	}):getPrefab(), function(arg_5_0)
		self.uiIcon.sprite = arg_5_0

		return
	end)

	return
end

function PlayRoomInfoViewerItem:willExit()
	self:detach()

	return
end

return PlayRoomInfoViewerItem
