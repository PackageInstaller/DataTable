local PolyhedronBeaconView = class("PolyhedronBeaconView", ReduxView)

function PolyhedronBeaconView:UIName()
	return "Widget/System/Polyhedron/Beacon/PolyhedronBeaconUI"
end

function PolyhedronBeaconView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronBeaconView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronBeaconView:InitUI()
	self:BindCfgUI()

	self.beaconList_ = LuaList.New(handler(self, self.IndexBeaconItem), self.m_list, PolyhedronBeaconItem)
	self.nextController = ControllerUtil.GetController(self.transform_, "next")
end

function PolyhedronBeaconView:AddUIListener()
	self:AddBtnListener(self.m_backBtn, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.m_okBtn, nil, function()
		PolyhedronAction.QueryStartPolyhedron({
			(PolyhedronData:GetCacheSelectHero())
		}, self.selectBeaconList, (PolyhedronData:GetCacheSelectDifficulty()))
	end)
end

function PolyhedronBeaconView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function PolyhedronBeaconView:OnEnter()
	manager.ui:SetMainCamera("hero")

	self.selectBeaconList = PolyhedronData:GetCacheBeaconList()
	self.maxBeaconSelect = 3
	self.maxBeaconSelect = PolyhedronData:GetBeaconMaxBeaconSelect()
	self.beaconData = PolyhedronData:GetUnlockBeaconList()

	table.sort(self.beaconData, function(arg_10_0, arg_10_1)
		return arg_10_0 < arg_10_1
	end)
	self.beaconList_:StartScroll(#self.beaconData)

	self.m_numLab.text = #self.selectBeaconList .. "/" .. self.maxBeaconSelect
end

function PolyhedronBeaconView:OnExit()
	manager.windowBar:HideBar()
	PolyhedronData:SetCacheBeaconList(self.selectBeaconList)
end

function PolyhedronBeaconView:IndexBeaconItem(arg_12_1, arg_12_2)
	local var_12_0 = not not table.indexof(self.selectBeaconList, self.beaconData[arg_12_1])

	arg_12_2:SetData(self.beaconData[arg_12_1])
	arg_12_2:SetChoice(var_12_0)
	arg_12_2:SetMask(not var_12_0 and #self.selectBeaconList >= self.maxBeaconSelect)
	arg_12_2:RegistCallBack(handler(self, self.OnBeaconItemClick))
end

function PolyhedronBeaconView:OnBeaconItemClick(arg_13_1, arg_13_2)
	if table.indexof(self.selectBeaconList, arg_13_1) then
		self:UnSelectBeacon(arg_13_1)
	else
		if self.maxBeaconSelect == 0 then
			ShowTips("POLYHEDRON_SELECT_BEACON_EMPTY")

			return
		end

		if #self.selectBeaconList >= self.maxBeaconSelect then
			ShowTips("POLYHEDRON_SELECT_BEACON_MAX")

			return
		end

		local var_13_0 = PolyhedronBeaconCfg[arg_13_1]
		local var_13_1 = {}
		local var_13_2 = PolyhedronData:GetTerminalGift() or {}

		for iter_13_0, iter_13_1 in ipairs(PolyhedronBeaconCfg[arg_13_1].require_terminal_list or {}) do
			if table.indexof(var_13_2, iter_13_1) then
				table.insert(var_13_1, iter_13_1)
			end
		end

		if #var_13_1 > 0 then
			local var_13_3 = ""

			for iter_13_2, iter_13_3 in ipairs(var_13_1) do
				var_13_3 = iter_13_2 == 1 and PolyhedronTerminalCfg[iter_13_3].name or var_13_3 .. "," .. PolyhedronTerminalCfg[iter_13_3].name
			end

			ShowMessageBox({
				content = string.format(GetTips("ERROR_MATRIX_NOT_EFFECTIVE"), var_13_0.name, var_13_3),
				OkCallback = function()
					self:SelectBeacon(arg_13_1)
				end
			})

			return
		end

		self:SelectBeacon(arg_13_1)
	end
end

function PolyhedronBeaconView:SelectBeacon(arg_15_1)
	table.insert(self.selectBeaconList, arg_15_1)

	self.m_numLab.text = #self.selectBeaconList .. "/" .. self.maxBeaconSelect

	self.beaconList_:Refresh()
end

function PolyhedronBeaconView:UnSelectBeacon(arg_16_1)
	table.remove(self.selectBeaconList, (table.indexof(self.selectBeaconList, arg_16_1)))

	self.m_numLab.text = #self.selectBeaconList .. "/" .. self.maxBeaconSelect

	self.beaconList_:Refresh()
end

function PolyhedronBeaconView:Dispose()
	self.beaconList_:Dispose()
	PolyhedronBeaconView.super.Dispose(self)
end

return PolyhedronBeaconView
