ChapterVariantBaseItem = import("game.views.chapterVariant.base.ChapterVariantBaseItem")

local var_0_0 = class("ChapterVariantEmptyDreamItem", ChapterVariantBaseItem)

function var_0_0.RefreshControllerState(arg_1_0)
	if arg_1_0.isLock_ or arg_1_0.chapterID_ == 11112 and not SkuldTravelData:IsCollectAllPhoto() then
		arg_1_0.controller_:SetSelectedState("lock")
	else
		arg_1_0.controller_:SetSelectedState("normal")
	end
end

return var_0_0
