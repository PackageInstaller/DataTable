local MardukSpecialNoteView = class("MardukSpecialNoteView", ReduxView)

function MardukSpecialNoteView:UIName()
	return "UI/MardukUI/special/MardukSpecialNoteUI"
end

function MardukSpecialNoteView:UIParent()
	return manager.ui.uiPop.transform
end

function MardukSpecialNoteView:OnCtor()
	return
end

function MardukSpecialNoteView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MardukSpecialNoteView:InitUI()
	self:BindCfgUI()
end

function MardukSpecialNoteView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function MardukSpecialNoteView:AddEventListeners()
	self:RegistEventListener(GUILD_EXIT, function()
		self:Go("/home")
	end)
end

function MardukSpecialNoteView:OnTop()
	self:UpdateBar()
end

function MardukSpecialNoteView:UpdateBar()
	return
end

function MardukSpecialNoteView:OnEnter()
	self:AddEventListeners()

	self.contentText_.text = GetTips("MARDUK_SPECIAL_NOTE")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content_)
end

function MardukSpecialNoteView:OnExit()
	self:RemoveAllEventListener()
end

function MardukSpecialNoteView:OnMainHomeViewTop()
	return
end

function MardukSpecialNoteView:Dispose()
	MardukSpecialNoteView.super.Dispose(self)
end

return MardukSpecialNoteView
