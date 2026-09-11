local PolyhedronBeaconOperateView = class("PolyhedronBeaconOperateView", ReduxView)

function PolyhedronBeaconOperateView:UIName()
	return "Widget/System/Polyhedron/Beacon/PolyhedronBeaconOperateUI"
end

function PolyhedronBeaconOperateView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronBeaconOperateView:Init()
	self:InitUI()
end

function PolyhedronBeaconOperateView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, PolyhedronBeaconOperateItem)
end

function PolyhedronBeaconOperateView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function PolyhedronBeaconOperateView:OnEnter()
	self:Refresh()
end

function PolyhedronBeaconOperateView:Refresh()
	self.data = PolyhedronBeaconCfg.all

	table.sort(self.data, function(arg_8_0, arg_8_1)
		local var_8_0 = PolyhedronData:GetBeaconIsLock(arg_8_1)

		if PolyhedronData:GetBeaconIsLock(arg_8_0) == var_8_0 then
			local var_8_1 = PolyhedronTools.GetBeaconIsUnlockCondition(arg_8_0)

			if var_8_1 == PolyhedronTools.GetBeaconIsUnlockCondition(arg_8_1) then
				return arg_8_0 < arg_8_1
			else
				return var_8_1
			end
		else
			return var_8_0
		end
	end)
	self.list_:StartScroll(#self.data)
end

function PolyhedronBeaconOperateView:OnExit()
	manager.windowBar:HideBar()
end

function PolyhedronBeaconOperateView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.data[arg_10_1])
end

function PolyhedronBeaconOperateView:Dispose()
	self.list_:Dispose()
	PolyhedronBeaconOperateView.super.Dispose(self)
end

function PolyhedronBeaconOperateView:OnPolyhedronBeaconUnlock()
	for iter_12_0, iter_12_1 in pairs((self.list_:GetItemList())) do
		iter_12_1:Refresh()
	end
end

return PolyhedronBeaconOperateView
