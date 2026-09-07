local PlayerVitaeEducateLockCard = class("PlayerVitaeEducateLockCard", import(".PlayerVitaeEducateBaseCard"))

function PlayerVitaeEducateLockCard:Ctor(arg_1_1, arg_1_2)
	PlayerVitaeEducateLockCard.super.Ctor(self, arg_1_1, arg_1_2)
	setText(arg_1_1:Find("desc/Text"), i18n("flagship_educate_slot_lock_tip"))
	onButton(self, arg_1_1:Find("go"), function()
		if LOCK_NEW_EDUCATE_SYSTEM then
			self:emit(PlayerVitaeMediator.GO_SCENE, SCENE.EDUCATE)
		else
			self:emit(PlayerVitaeMediator.GO_SCENE, SCENE.NEW_EDUCATE_SELECT)
		end

		return
	end, SFX_PANEL)

	return
end

return PlayerVitaeEducateLockCard
