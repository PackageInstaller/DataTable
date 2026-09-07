local DreamTourMainPage = class("DreamTourMainPage", import("view.activity.CorePage.Helena.HelenaMainPage"))

function DreamTourMainPage:OnFirstFlush()
	DreamTourMainPage.super.OnFirstFlush(self)
	onButton(self, self.Manual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = DreamTourMedalAlbumView
		})))

		return
	end)

	return
end

return DreamTourMainPage
