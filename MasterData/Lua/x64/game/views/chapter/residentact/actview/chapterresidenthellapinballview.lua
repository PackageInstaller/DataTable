ChapterResidentActBaseView = import("game.views.chapter.residentAct.ChapterResidentActBaseView")

local ChapterResidentHellaPinballView = class("ChapterResidentHellaPinballView", ChapterResidentActBaseView)

function ChapterResidentHellaPinballView:Init()
	self:InitUI()
	self:AddUIListener()

	if self.rewardListGo_ then
		self.rewardList_ = LuaList.New(handler(self, self.IndexRewardItem), self.rewardListGo_, CommonItemView)
	end

	self.btnStateController_ = self.controller_:GetController("btnState")

	self:BindRed(true)

	self.progressControlller_ = self.progressControllerEx_:GetController("progress")
end

function ChapterResidentHellaPinballView:RefreshUI()
	ChapterResidentHellaPinballView.super.RefreshUI(self)

	self.progress_ = PinballData:GetStageFinishProgress()
	self.progressSlider_.value = self.progress_
	self.progressValueTxt_.text = math.floor(self.progress_ * 100) .. "%"

	if self.progress_ < 0.42 then
		self.progressControlller_:SetSelectedState("yellow")
	elseif self.progress_ < 0.67 then
		self.progressControlller_:SetSelectedState("orange")
	elseif self.progress_ < 1 then
		self.progressControlller_:SetSelectedState("red")
	else
		self.progressControlller_:SetSelectedState("green")
	end
end

return ChapterResidentHellaPinballView
