local IndiaNianSelectHeroProxy = class("IndiaNianSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function IndiaNianSelectHeroProxy:InitCustomParams(arg_1_1)
	self.destID = arg_1_1.destID
end

function IndiaNianSelectHeroProxy:UpdateBar()
	manager.windowBar:SwitchBar(self.barList)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/indiaNianMain")
	end)
end

function IndiaNianSelectHeroProxy:OnSectionSelectEnter()
	if IndiaNianCfg[self.destID].stage_type == 0 then
		self:AddHpTimer()
	end
end

function IndiaNianSelectHeroProxy:OnSectionSelectExit()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function IndiaNianSelectHeroProxy:AddHpTimer()
	self.timer = Timer.New(function()
		if IndiaNianData:GetCurrentHpByID(self.destID) == 0 then
			self:Back()
		end
	end, 1, -1, true)

	self.timer:Start()
end

return IndiaNianSelectHeroProxy
