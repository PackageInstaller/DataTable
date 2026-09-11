local TeamHeroShortHead = class("TeamHeroShortHead", HeroShortHead)

function TeamHeroShortHead:InitUI()
	TeamHeroShortHead.super.InitUI(self)

	self.isBattlePanel_ = true
end

function TeamHeroShortHead:AddUIListener()
	self:AddBtnListener(self.selfBtn_, nil, function()
		if self.clickListener_ ~= nil then
			self.clickListener_(self.heroCfg_.id)
		end
	end)
end

return TeamHeroShortHead
