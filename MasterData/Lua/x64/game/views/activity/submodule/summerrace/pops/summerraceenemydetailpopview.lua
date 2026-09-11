local SummerRaceEnemyDetailPopView = class("SummerRaceEnemyDetailPopView", ReduxView)

local function var_0_1(arg_1_0)
	if arg_1_0 == nil or arg_1_0.enemyId == nil then
		error("SummerRaceEnemyDetailPopView requires params.enemyId")
	end

	return arg_1_0.enemyId
end

local function var_0_2(arg_2_0)
	local var_2_0 = {}

	for iter_2_0 = 1, #(arg_2_0 or {}) do
		if arg_2_0[iter_2_0] ~= nil and arg_2_0[iter_2_0].isEmpty ~= true and arg_2_0[iter_2_0].itemId ~= nil and tostring(arg_2_0[iter_2_0].itemId) ~= "" then
			var_2_0[#var_2_0 + 1] = arg_2_0[iter_2_0]
		end
	end

	return var_2_0
end

function SummerRaceEnemyDetailPopView:UIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_OutGameUI/pop/Activity_SummerRace_EnemyDetailPopUI"
end

function SummerRaceEnemyDetailPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerRaceEnemyDetailPopView:Init()
	self:BindCfgUI()
	self:BindViewRuntime()
	self:AddUIListener()
end

function SummerRaceEnemyDetailPopView:BindViewRuntime()
	self.equipSlotItemList_ = LuaList.New(handler(self, self.IndexSlotItem), self.equipListGo_, SummerRaceEquipSlotItemView)
	self.stateController_ = self.controllerEx_:GetController("state")
	self.slotList_ = {}
end

function SummerRaceEnemyDetailPopView:OnEnter()
	self:RefreshView()
end

function SummerRaceEnemyDetailPopView:OnExit()
	return
end

function SummerRaceEnemyDetailPopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		JumpTools.Back()
	end)
end

function SummerRaceEnemyDetailPopView:IndexSlotItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.slotList_[arg_12_1], arg_12_1, handler(self, self.OnSlotAction))
end

function SummerRaceEnemyDetailPopView:OnSlotAction(arg_13_1, arg_13_2, arg_13_3)
	if arg_13_3 == "select" and arg_13_2 and arg_13_2.itemId ~= "" then
		SummerRaceAction.OpenEquipInfoPop(arg_13_2.itemId)
	end
end

function SummerRaceEnemyDetailPopView:RefreshView()
	local var_14_0 = SummerRaceData:GetEnemyDetailModel((var_0_1(self.params_)))

	self.slotList_ = var_0_2(var_14_0.slotList)
	self.enemyNameText_.text = tostring(var_14_0.enemyName or "")

	self.stateController_:SetSelectedState(#self.slotList_ > 0 and "show" or "hide")
	self.equipSlotItemList_:StartScroll(#self.slotList_)
end

function SummerRaceEnemyDetailPopView:Dispose()
	if self.equipSlotItemList_ then
		self.equipSlotItemList_:Dispose()

		self.equipSlotItemList_ = nil
	end

	SummerRaceEnemyDetailPopView.super.Dispose(self)
end

return SummerRaceEnemyDetailPopView
