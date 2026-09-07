local EscapeManorMainPage = class("EscapeManorMainPage", import("view.activity.CorePage.Helena.HelenaMainPage"))

function EscapeManorMainPage:OnFirstFlush()
	EscapeManorMainPage.super.OnFirstFlush(self)
	onButton(self, self.Manual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = EscapeManorMedalAlbumView
		})))

		return
	end)

	return
end

function EscapeManorMainPage:updateUI()
	EscapeManorMainPage.super.updateUI(self)
	removeOnButton(self.fight)
	onButton(self, self.fight, function()
		self:emit(ActivityMediator.ON_BOSSRUSH_MAP)

		return
	end)

	return
end

return EscapeManorMainPage
