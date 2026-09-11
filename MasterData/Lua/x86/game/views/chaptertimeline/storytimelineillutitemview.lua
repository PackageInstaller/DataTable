local StoryTimeLineIllutItemView = class("StoryTimeLineIllutItemView", (import("game.views.chapterTimeLine.StoryTimeLineItemBaseView")))

function StoryTimeLineIllutItemView:RefreshData()
	self.isIllu_ = true
end

function StoryTimeLineIllutItemView:RefreshItem()
	self.categoryController_:SetSelectedState("main")

	cfg = StoryCfg
	self.nameText_.text = GetI18NText(StoryCfg[self.id_].name)
	self.illCollectNumText_.text = "1/1"

	SetSpriteWithoutAtlasAsync(self.img_, SpritePathCfg.CollectPlotSmall.path .. CollectStoryCfg[self.id_].picture)
end

function StoryTimeLineIllutItemView:SetClickCallBack(arg_3_1)
	self.clickCallBack_ = arg_3_1
end

function StoryTimeLineIllutItemView:SetInfo(arg_4_1)
	self.info_ = arg_4_1
end

function StoryTimeLineIllutItemView:SetUnlockNum(arg_5_1)
	self.unlockNum_ = arg_5_1
end

return StoryTimeLineIllutItemView
