local MainBattleBtn = class("MainBattleBtn", import(".MainBaseBtn"))

function MainBattleBtn:OnClick()
	local var_1_0 = getProxy(ChapterProxy):getActiveChapter()

	self:emit(NewMainMediator.GO_SCENE, SCENE.LEVEL, {
		chapterId = var_1_0 and var_1_0.id,
		mapIdx = var_1_0 and var_1_0:getConfig("map")
	})

	return
end

function MainBattleBtn:IsFixed()
	return true
end

return MainBattleBtn
