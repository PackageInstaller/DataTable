-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/anlong/AnLongCopyView.lua

module("logic.extensions.scenariocopy.view.anlong.AnLongCopyView", package.seeall)

local AnLongCopyView = class("AnLongCopyView", OnePeopleCopyView)

function AnLongCopyView:buildUI()
	AnLongCopyView.super.buildUI(self)

	local chapterNum = self:_getChapterMaxNum()

	for i = 1, chapterNum do
		self._chapters[i].colorChange = self:getGo(string.format("chapters/btnChapter%d/txtName", i)):GetComponent(typeof(UITextColorChange))
	end
end

function AnLongCopyView:_getChapterMaxNum()
	return 2
end

function AnLongCopyView:_getStageMaxNum()
	return 8
end

function AnLongCopyView:_getIndexRange()
	return 5, 6
end

function AnLongCopyView:_getViewName()
	return ViewName.AnLongCopyView
end

function AnLongCopyView:_getStageViewName()
	return ViewName.AnLongStageView
end

function AnLongCopyView:_updateChapters(isResetSelect)
	AnLongCopyView.super._updateChapters(self, isResetSelect)

	for i, v in ipairs(self._chapters) do
		v.colorChange:SetState(v.isUnlock and 1 or 0)
	end
end

function AnLongCopyView:_markRedPoint()
	ScenariocopyController.instance:markAnLongCopyRedPoint()
end

function AnLongCopyView:_getBgEffectPath()
	return AnLongCopyViewPresentor.BgEffectPath
end

function AnLongCopyView:_getChapterSelectEffectPath()
	return AnLongCopyViewPresentor.ChapterEffectPath
end

function AnLongCopyView:_getLevelSelectEffectPath()
	return AnLongCopyViewPresentor.LevelEffectPath
end

function AnLongCopyView:_loadMainIconEffect()
	return
end

function AnLongCopyView:_removeMainIconEffect()
	return
end

return AnLongCopyView
