local NieRAutomataMainPage = class("NieRAutomataMainPage", import("view.activity.CorePage.CoreActivityPage"))

function NieRAutomataMainPage:OnFirstFlush()
	self.super.OnFirstFlush(self)

	local var_1_0 = self.activity:getConfig("config_client").intro_story

	if not pg.NewStoryMgr.GetInstance():IsPlayed(var_1_0) then
		pg.NewStoryMgr.GetInstance():Play(var_1_0[1])
	end

	return
end

return NieRAutomataMainPage
