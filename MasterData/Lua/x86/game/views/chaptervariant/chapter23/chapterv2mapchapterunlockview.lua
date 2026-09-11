local ChapterV2MapChapterUnlockView = class("ChapterV2MapChapterUnlockView", ReduxView)

function ChapterV2MapChapterUnlockView:UIName()
	if string.isNullOrEmpty(ChapterV2ChapterCfg[self.params_.chapterId].prefab) then
		Debug.LogError(string.format("ChapterV2ChapterCfg[%d]的预制体为空", self.params_.chapterId))
	end

	return ChapterV2ChapterCfg[self.params_.chapterId].prefab
end

function ChapterV2MapChapterUnlockView:UIParent()
	return manager.ui.uiPop.transform
end

function ChapterV2MapChapterUnlockView:Cacheable()
	return false
end

function ChapterV2MapChapterUnlockView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function ChapterV2MapChapterUnlockView:AddListeners()
	if self.bgBtn_ then
		self:AddBtnListener(self.bgBtn_, nil, function()
			self:Back()
		end)
	else
		Debug.LogError(string.format("%s 预制体没有用于点击返回的按钮", self:UIName()))
	end
end

function ChapterV2MapChapterUnlockView:OnEnter()
	saveData("ChapterV2MapData", "chapter_pop_" .. self.params_.chapterId, true)
end

function ChapterV2MapChapterUnlockView:OnExit()
	return
end

function ChapterV2MapChapterUnlockView:OnExitInput()
	JumpTools.Back()

	return true
end

function ChapterV2MapChapterUnlockView:Dispose()
	ChapterV2MapChapterUnlockView.super.Dispose(self)
end

return ChapterV2MapChapterUnlockView
