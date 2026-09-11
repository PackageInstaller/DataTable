local StoryTimeLineNormalIllutItemView = class("StoryTimeLineNormalIllutItemView", (import("game.views.chapterTimeLine.StoryTimeLineItemBaseView")))

function StoryTimeLineNormalIllutItemView:RefreshData()
	self.isIllu_ = true
end

function StoryTimeLineNormalIllutItemView:RefreshItem()
	StoryTimeLineNormalIllutItemView.super.RefreshItem(self)
end

function StoryTimeLineNormalIllutItemView:SetInfo(arg_3_1)
	self.info_ = arg_3_1
end

function StoryTimeLineNormalIllutItemView:SetSizeState(arg_4_1)
	self.sizeState_ = arg_4_1

	self.stateController_:SetSelectedState(arg_4_1)
end

function StoryTimeLineNormalIllutItemView:SetUnlockNum(arg_5_1)
	self.unlockNum_ = arg_5_1

	if not self.info_ then
		return
	end

	self.illCollectNumText_.text = self.unlockNum_ .. "/" .. self.info_.all
end

return StoryTimeLineNormalIllutItemView
