local NewHeroSurpassPhaseUpView = class("NewHeroSurpassPhaseUpView", (import("game.views.pop.PopFramingBaseView")))

function NewHeroSurpassPhaseUpView:UIName()
	return "Widget/System/Hero_transition/HeroPrintRewardUI"
end

function NewHeroSurpassPhaseUpView:UIParent()
	return manager.ui.uiPop.transform
end

function NewHeroSurpassPhaseUpView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewHeroSurpassPhaseUpView:InitUI()
	self:BindCfgUI()

	self.attrItemList = {}

	for iter_4_0 = 1, 3 do
		self.attrItemList[iter_4_0] = HeroSurpassAttrItem.New(self["message" .. iter_4_0 .. "Go_"])
	end
end

function NewHeroSurpassPhaseUpView:AddUIListener()
	self:AddBtnListener(self.fullscreenBtn_, nil, function()
		self:Back(false)
	end)
end

function NewHeroSurpassPhaseUpView:OnEnter()
	self.starID = self.params_.starID
	self.heroID = self.params_.heroID

	self:Refresh()

	if self.starID == 600 then
		HeroTools.PlayTalk(self.heroID, "pro3", 1)
	elseif self.starID == 500 then
		HeroTools.PlayTalk(self.heroID, "pro2", 1)
	else
		HeroTools.PlayTalk(self.heroID, "pro1", 1)
	end
end

function NewHeroSurpassPhaseUpView:Refresh()
	SurpassTools.ChangeIconStarSpirte(self.iconImg_, HeroStarCfg[self.starID].star - 1)
	SurpassTools.ChangeIconStarSpirte(self.icon_changeImg_, HeroStarCfg[self.starID].star)

	local var_8_0 = math.max(HeroStarCfg[self.starID].star - 1, 0)

	self.attrItemList[1]:RefreshUI(HeroCfg[self.heroID].atk_ratio[var_8_0], HeroCfg[self.heroID].atk_ratio[HeroStarCfg[self.starID].star], 1, true)
	self.attrItemList[2]:RefreshUI(HeroCfg[self.heroID].arm_ratio[var_8_0], HeroCfg[self.heroID].arm_ratio[HeroStarCfg[self.starID].star], 2, true)
	self.attrItemList[3]:RefreshUI(HeroCfg[self.heroID].sta_ratio[var_8_0], HeroCfg[self.heroID].sta_ratio[HeroStarCfg[self.starID].star], 3, true)

	local var_8_1, var_8_2 = SurpassTools.GetStarUpAttrShowDesc(HeroCfg[self.heroID], self.starID)

	self.specialtextText_.text = var_8_2

	if var_8_2 ~= "" then
		SetActive(self.specialnodeGo_, true)
	else
		SetActive(self.specialnodeGo_, false)
	end
end

function NewHeroSurpassPhaseUpView:Dispose()
	for iter_9_0, iter_9_1 in pairs(self.attrItemList) do
		if iter_9_1 then
			iter_9_1:Dispose()
		end
	end

	NewHeroSurpassPhaseUpView.super.Dispose(self)
end

return NewHeroSurpassPhaseUpView
