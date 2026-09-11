ChapterVariantBaseItem = import("game.views.chapterVariant.base.ChapterVariantBaseItem")

local ChapterVariantEmptyDreamItem = class("ChapterVariantEmptyDreamItem", ChapterVariantBaseItem)

function ChapterVariantEmptyDreamItem:RefreshControllerState()
	if self.isLock_ or self.chapterID_ == 11112 and not SkuldTravelData:IsCollectAllPhoto() then
		self.controller_:SetSelectedState("lock")
	else
		self.controller_:SetSelectedState("normal")
	end
end

return ChapterVariantEmptyDreamItem
