local PlayerVitaeLockCard = class("PlayerVitaeLockCard", import(".PlayerVitaeBaseCard"))

function PlayerVitaeLockCard:OnInit()
	self.desc = self._tf:Find("Text")

	return
end

function PlayerVitaeLockCard:OnUpdate(arg_2_1, arg_2_2)
	setText(self.desc, i18n("secretary_unlock" .. arg_2_1))

	return
end

function PlayerVitaeLockCard:OnDispose()
	return
end

return PlayerVitaeLockCard
