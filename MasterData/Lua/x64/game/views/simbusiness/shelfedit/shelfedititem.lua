local ShelfEditItem = class("ShelfEditItem", ReduxView)

function ShelfEditItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function ShelfEditItem:InitUI()
	self:BindCfgUI()

	self.levelBgController = ControllerUtil.GetController(self.transform_, "itembglevel")
	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.stateController = ControllerUtil.GetController(self.transform_, "state")

	self:AddUIListener()
end

function ShelfEditItem:AddUIListener()
	local var_3_0 = self:FindCom("EventTriggerListener")

	function var_3_0.onPointerDown(arg_4_0, arg_4_1)
		self:OnPointerDown(arg_4_0, arg_4_1)
	end

	function var_3_0.onBeginDrag(arg_5_0, arg_5_1)
		self:BeginDrag(arg_5_1)
	end

	function var_3_0.onEndDrag(arg_6_0, arg_6_1)
		self:EndDrag(arg_6_1)
	end

	function var_3_0.onDrag(arg_7_0, arg_7_1)
		self:Drag(arg_7_1)
	end

	self:SetListener(var_3_0)
	self:AddBtnListener(self.infoBtn, nil, function()
		if self.itemInfoFunc then
			self.itemInfoFunc(self.id)
		end
	end)
end

local function var_0_1(arg_9_0)
	local var_9_0 = SimBusinessTools.GetShelfOverrideLevel(arg_9_0)

	return var_9_0 or SimBusinessData:GetShelfLevel(arg_9_0), var_9_0 ~= nil
end

function ShelfEditItem:GetShelfCostText()
	if SimBusinessTools.CheckDeployNewShelfCostOver(self.cfgID) then
		return "<color=#FF0000>" .. SimBusinessShelfCfg[self.cfgID].cost .. "</color>"
	end

	return SimBusinessShelfCfg[self.cfgID].cost
end

function ShelfEditItem:RefreshUI(arg_11_1, arg_11_2)
	self.parentView = arg_11_1

	local var_11_0 = arg_11_1.dataList[arg_11_2]

	self.cfgID = arg_11_1.dataList[arg_11_2]
	self.idx = arg_11_2

	self.selectController:SetSelectedState(arg_11_1.selIndex == arg_11_2 and "select" or "normal")

	self.cfg = SimBusinessShelfCfg[var_11_0]

	if self.cfg then
		self:RefreshAvailable()

		self.name_.text = self.cfg.name
		self.cost_.text = self:GetShelfCostText(var_11_0)
		self.costCoinIcon_.sprite = SimBusinessTools.GetCoinIcon()
		self.icon_.sprite = SimBusinessTools.GetShelfIcon(var_11_0)
		self.level = var_0_1(var_11_0)

		self.levelBgController:SetSelectedState(self.level)
	else
		Debug.LogError("货柜" .. var_11_0 .. "在activity_sim_business_shelf表内未找到")
	end
end

function ShelfEditItem:RefreshAvailable()
	self.stateController:SetSelectedState(self:IsAvailable() and "normal" or "gray")
end

function ShelfEditItem:IsAvailable()
	return not SimBusinessTools.CheckDeployNewShelfCostOver(self.cfgID)
end

function ShelfEditItem:OnPointerDown(arg_14_1)
	self.parentView:OnShelfItemPointerDown(arg_14_1, self)
end

function ShelfEditItem:BeginDrag(arg_15_1)
	self.parentView:OnShelfItemBeginDrag(arg_15_1, self)
end

function ShelfEditItem:Drag(arg_16_1)
	self.parentView:OnShelfItemDrag(arg_16_1, self)
end

function ShelfEditItem:EndDrag(arg_17_1)
	self.parentView:OnShelfItemEndDrag(arg_17_1, self)
end

return ShelfEditItem
