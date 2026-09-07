local ANTTFFStoryCollectionPage = class("ANTTFFStoryCollectionPage", import("view.activity.CorePage.Helena.HelenaPTPage"))

function ANTTFFStoryCollectionPage:OnInit()
	ANTTFFStoryCollectionPage.super.OnInit(self)

	self.scenario = ANTTFFScenarioPage.New(self._tf, self.event)

	self.scenario:SetCoreStoryPage(self)
	self.scenario:RegisterView(self.coreActivityUI)

	self.loader = AutoLoader.New()
	self.mapGroup = {}
	self.currentBG = nil

	return
end

return ANTTFFStoryCollectionPage
