local MainWordBtn = class("MainWordBtn", import(".MainBaseBtn"))

function MainWordBtn:Ctor(arg_1_1, arg_1_2)
	MainWordBtn.super.Ctor(self, arg_1_1, arg_1_2)

	self.wordOpen = findTF(arg_1_1, "open"):GetComponent(typeof(CanvasGroup))
	self.wordClose = findTF(arg_1_1, "close"):GetComponent(typeof(CanvasGroup))
	self.wordFlag = getProxy(SettingsProxy):ShouldShipMainSceneWord()

	return
end

function MainWordBtn:OnClick()
	self.wordFlag = not self.wordFlag

	getProxy(SettingsProxy):SaveMainSceneWordFlag(self.wordFlag)
	pg.TipsMgr.GetInstance():ShowTips(self.wordFlag and i18n("game_openwords") or i18n("game_stopwords"))
	self:emit(NewMainScene.CHAT_STATE_CHANGE, self.wordFlag)
	self:UpdateWordBtn(self.wordFlag)

	return
end

function MainWordBtn:Flush(arg_3_1)
	self:UpdateWordBtn(self.wordFlag)

	return
end

function MainWordBtn:UpdateWordBtn(arg_4_1)
	self.wordOpen.alpha = 1 - (arg_4_1 and 1 or 0)
	self.wordClose.alpha = arg_4_1 and 1 or 0

	return
end

return MainWordBtn
