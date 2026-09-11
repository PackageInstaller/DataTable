local OsirisRecallView = class("OsirisRecallView", ReduxView)

function OsirisRecallView:UIName()
	return "UI/BranchlineUI/OsirisRecallUI"
end

function OsirisRecallView:UIParent()
	return manager.ui.uiMain.transform
end

function OsirisRecallView:OnCtor()
	return
end

function OsirisRecallView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OsirisRecallView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, OsirisRecallItem)
end

function OsirisRecallView:AddUIListener()
	return
end

function OsirisRecallView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function OsirisRecallView:OnEnter()
	if ActivityStoryCollect[ActivityConst.OSIRIS_ACTIVITY] then
		self.data = ActivityStoryCollect[ActivityConst.OSIRIS_ACTIVITY].story_id or {}
	end

	self.list:StartScroll(#self.data)
end

function OsirisRecallView:OnExit()
	manager.windowBar:HideBar()
end

function OsirisRecallView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.data[arg_10_1])
end

function OsirisRecallView:Dispose()
	self.list:Dispose()
	OsirisRecallView.super.Dispose(self)
end

return OsirisRecallView
