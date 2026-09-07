local AEBCSStoryPage = class("AEBCSStoryPage", import("view.activity.CorePage.CoreStoryTemplatePage"))

function AEBCSStoryPage:OnInit()
	AEBCSStoryPage.super.OnInit(self)
	setActive(self.goBtn:Find("tip"), PlayerPrefs.GetInt("AEBCSStoryReminder", 0) == 0)

	return
end

function AEBCSStoryPage:IsShowReminder()
	return PlayerPrefs.GetInt("AEBCSStoryReminder", 0) == 0
end

function AEBCSStoryPage:ShowScenarioLayer(arg_3_1)
	AEBCSStoryPage.super.ShowScenarioLayer(self, arg_3_1)

	if arg_3_1 then
		PlayerPrefs.SetInt("AEBCSStoryReminder", 1)
	end

	return
end

return AEBCSStoryPage
