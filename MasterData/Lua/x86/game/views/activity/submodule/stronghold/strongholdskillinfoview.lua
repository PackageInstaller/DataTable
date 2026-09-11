local StrongholdSkillInfoView = class("StrongholdSkillInfoView", ReduxView)

function StrongholdSkillInfoView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdPopupUI"
end

function StrongholdSkillInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function StrongholdSkillInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdSkillInfoView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, StrongholdSkillInfoItem)
end

function StrongholdSkillInfoView:AddUIListener()
	self:AddBtnListener(nil, self.m_mask, function()
		self:Back()
	end)
end

function StrongholdSkillInfoView:OnTop()
	manager.windowBar:SwitchBar({})
end

function StrongholdSkillInfoView:OnEnter()
	self.skillTypes = StrongholdData:GetRoomSkillTypes(CooperationData:GetRoomData().room_id)
	self.skillTypes_key = {
		1,
		2,
		3
	}

	self.list:StartScroll(#self.skillTypes_key)
end

function StrongholdSkillInfoView:OnExit()
	manager.windowBar:HideBar()
end

function StrongholdSkillInfoView:Dispose()
	self.list:Dispose()
	StrongholdSkillInfoView.super.Dispose(self)
end

function StrongholdSkillInfoView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self.skillTypes_key[arg_11_1], self.skillTypes[self.skillTypes_key[arg_11_1]] or 0)
end

return StrongholdSkillInfoView
