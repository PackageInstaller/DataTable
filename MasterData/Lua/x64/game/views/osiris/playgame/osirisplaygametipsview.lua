local OsirisPlayGameTipsView = class("OsirisPlayGameTipsView", ReduxView)

function OsirisPlayGameTipsView:UIName()
	return "Widget/System/Activity_Osiris/Activity_Osiris_tips"
end

function OsirisPlayGameTipsView:UIParent()
	return manager.ui.uiPop.transform
end

function OsirisPlayGameTipsView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OsirisPlayGameTipsView:InitUI()
	self:BindCfgUI()
end

function OsirisPlayGameTipsView:OnEnter()
	self.nameText_.text = string.format(GetTips("ACTIVITY_GENERALITY_CHAPTER_UNLOCK"), GetI18NText(ActivityGeneralityChapterCfg[self.params_.chapterID + 1].chapter_name))

	OsirisPlayGameData:SetFirstUnlock(self.params_.chapterID + 1)
	self:StopTimer()

	self.timer_ = Timer.New(function()
		self:StopTimer()
		self:Back()
	end, 1.5, 1)

	self.timer_:Start()
end

function OsirisPlayGameTipsView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function OsirisPlayGameTipsView:AddUIListener()
	return
end

function OsirisPlayGameTipsView:OnExit()
	self:StopTimer()
	OsirisPlayGameTipsView.super.OnExit(self)
end

function OsirisPlayGameTipsView:Dispose()
	OsirisPlayGameTipsView.super.Dispose(self)
end

return OsirisPlayGameTipsView
