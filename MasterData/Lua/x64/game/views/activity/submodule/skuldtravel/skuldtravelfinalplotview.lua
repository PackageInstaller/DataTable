local SkuldTravelFinalPlotView = class("SkuldTravelFinalPlotView", ReduxView)
local var_0_1 = "TextureConfig/EmptyDream/travel/image/"

function SkuldTravelFinalPlotView:UIName()
	return "UI/EmptyDream/EDream_travelled/EDream_travelEndDetails"
end

function SkuldTravelFinalPlotView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldTravelFinalPlotView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldTravelFinalPlotView:InitUI()
	self:BindCfgUI()
end

function SkuldTravelFinalPlotView:AddUIListeners()
	self:AddBtnListener(self.bgbtn_, nil, function()
		JumpTools.Back()
	end)
end

function SkuldTravelFinalPlotView:OnEnter()
	self:RefreshUI()
end

function SkuldTravelFinalPlotView:RefreshUI()
	self.stroytext_.text = GetI18NText(TravelSkuldEndingCfg[self.params_.endingid].story_word)
	self.storyname_.text = GetI18NText(TravelSkuldEndingCfg[self.params_.endingid].story_name)

	local var_8_0 = var_0_1

	var_8_0 = SkuldTravelData:GetSkuldBtnIsBreach() and var_8_0 .. TravelSkuldEndingCfg[self.params_.endingid].destroy_picture or var_8_0 .. TravelSkuldEndingCfg[self.params_.endingid].picture
	self.itemimage_.sprite = pureGetSpriteWithoutAtlas(var_8_0)

	SetActive(self.panelGo_, false)
end

function SkuldTravelFinalPlotView:OnExit()
	return
end

function SkuldTravelFinalPlotView:Dispose()
	self.super.Dispose(self)
end

return SkuldTravelFinalPlotView
