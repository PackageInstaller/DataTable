local MainTopPanel4Mellow = class("MainTopPanel4Mellow", import("...base.MainBasePanel"))

function MainTopPanel4Mellow:GetBtns()
	return {
		MainPlayerInfoBtn4Mellow.New(self._tf, self.event),
		MainMailBtn.New(findTF(self._tf, "btns/mail"), self.event),
		MainNoticeBtn.New(findTF(self._tf, "btns/noti"), self.event),
		MainSettingsBtn.New(findTF(self._tf, "btns/settings"), self.event)
	}
end

function MainTopPanel4Mellow:GetDirection()
	return Vector2(0, 1)
end

return MainTopPanel4Mellow
