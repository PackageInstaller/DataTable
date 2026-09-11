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

function MainBattleBtn:ShowOrHideBtnEffect(arg_3_1)
	local var_3_0 = self._tf:Find("FX")

	if IsNil(var_3_0) then
		return
	end

	setActive(var_3_0, arg_3_1)

	return
end

return MainBattleBtn
