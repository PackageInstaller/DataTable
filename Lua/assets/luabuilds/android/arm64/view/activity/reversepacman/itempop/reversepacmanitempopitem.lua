local ReversePacmanItemPopItem = class("ReversePacmanItemPopItem", import("view.base.BasePanel"))

ReversePacmanItemPopItem.SKIP_TYPE_SCENE = 2
ReversePacmanItemPopItem.SKIP_TYPE_ACTIVITY = 3

function ReversePacmanItemPopItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	ReversePacmanItemPopItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function ReversePacmanItemPopItem:Init()
	setText(self.uiGoText, i18n("task_go"))
	onButton(self, self.uiGoBtn, function()
		if self.data[1] == ReversePacmanItemPopItem.SKIP_TYPE_SCENE then
			pg.m02:sendNotification(GAME.GO_SCENE, self.data[2][1], self.data[2][2] or {})
		elseif self.data[1] == ReversePacmanItemPopItem.SKIP_TYPE_ACTIVITY then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
				id = self.data[2]
			})
		end

		return
	end, SFX_PANEL)

	return
end

function ReversePacmanItemPopItem:didEnter(arg_4_1)
	self.data = arg_4_1

	setScrollText(self.uiTitleText, arg_4_1[3])
	self:Show(true)

	return
end

function ReversePacmanItemPopItem:Show(arg_5_1)
	setActive(self._go, arg_5_1)

	return
end

function ReversePacmanItemPopItem:willExit()
	self:detach()
	Object.Destroy(self._go)

	self._tf = nil
	self._go = nil

	return
end

return ReversePacmanItemPopItem
