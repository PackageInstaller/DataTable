local ShadowCityMainPage = class("ShadowCityMainPage", import("view.activity.CorePage.Helena.HelenaMainPage"))

function ShadowCityMainPage:OnInit()
	ShadowCityMainPage.super.OnInit(self)

	self.rpManual = self.Manual:Find("tip")

	return
end

function ShadowCityMainPage:OnFirstFlush()
	ShadowCityMainPage.super.OnFirstFlush(self)
	onButton(self, self.Manual, function()
		self:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = ShadowCityMedalAlbumView
		})))

		return
	end)

	return
end

function ShadowCityMainPage:OnUpdateFlush()
	ShadowCityMainPage.super.OnUpdateFlush(self)
	self:updateTip()

	return
end

function ShadowCityMainPage:updateTip()
	setActive(self.rpManual, (getProxy(ActivityProxy):getActivityById(self.activity:getConfig("config_client").medalGroupId):readyToAchieve()))

	return
end

return ShadowCityMainPage
