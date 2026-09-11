local HeroSurpassPlanNode = class("HeroSurpassPlanNode", ReduxView)
local var_0_1 = {
	lockState = {
		selectLock = "SelectLock",
		name = "lock",
		lock = "2",
		unlock = "1"
	},
	selectState = {
		name = "select",
		use = "state1",
		unUse = "state0"
	},
	upState = {
		unUp = "state0",
		name = "up",
		canUp = "state1"
	}
}

function HeroSurpassPlanNode:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:InitUI()
end

function HeroSurpassPlanNode:InitUI()
	self:BindCfgUI()
	self:InitPlanList()
	self:ShowView(false)
end

function HeroSurpassPlanNode:ShowView(arg_3_1)
	self.gameObject_:SetActive(arg_3_1)
	self:CancelSelect()

	self.selectIndex = nil
end

function HeroSurpassPlanNode:ShowAndNotCancelSelect()
	self.gameObject_:SetActive(true)
end

function HeroSurpassPlanNode:GetSelectIndex()
	return self.selectIndex
end

function HeroSurpassPlanNode:GetSelectStar()
	return (self.selectIndex or nil) and (self.planStarList[self.selectIndex] or nil)
end

function HeroSurpassPlanNode:InitPlanList()
	self.planList = {}

	for iter_7_0 = 1, 4 do
		self.planList[iter_7_0] = self:CreatePlanItem(iter_7_0)
	end
end

function HeroSurpassPlanNode:CreatePlanItem(arg_8_1)
	local var_8_0 = {}

	ComponentBinder.GetInstance():BindCfgUI(var_8_0, self["planbtn" .. arg_8_1 .. "Go_"])

	var_8_0.gameObject = self["planbtn" .. arg_8_1 .. "Go_"]
	var_8_0.lockController = var_8_0.Controllerexcollection_:GetController(var_0_1.lockState.name)
	var_8_0.selectController = var_8_0.Controllerexcollection_:GetController(var_0_1.selectState.name)
	var_8_0.upController = var_8_0.Controllerexcollection_:GetController(var_0_1.upState.name)

	self:AddBtnListener(var_8_0.planBtn_, nil, function()
		self:ClickPlanItem(arg_8_1)
	end)

	return var_8_0
end

function HeroSurpassPlanNode:CancelSelect()
	if self.selectIndex then
		self.planList[self.selectIndex].selectController:SetSelectedState(var_0_1.selectState.unUse)
	end
end

function HeroSurpassPlanNode:ClickPlanItem(arg_11_1)
	if self.selectIndex == arg_11_1 then
		return
	end

	self:CancelSelect()
	self.planList[arg_11_1].selectController:SetSelectedState(var_0_1.selectState.use)

	self.selectIndex = arg_11_1

	if self.clickCallBack then
		self.clickCallBack(self.planStarList[arg_11_1])
	end
end

function HeroSurpassPlanNode:ClickPlanItemByStarID(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self.planStarList) do
		if iter_12_1 == arg_12_1 then
			self:ClickPlanItem(iter_12_0)

			break
		end
	end
end

function HeroSurpassPlanNode:SetClickCallBack(arg_13_1)
	self.clickCallBack = arg_13_1
end

function HeroSurpassPlanNode:RefreshUi(arg_14_1, arg_14_2)
	local var_14_0 = SurpassTools.GetNextSurpassStarID(arg_14_2.star)

	self.planStarList = {}

	local var_14_1 = 0

	for iter_14_0, iter_14_1 in ipairs(HeroStarCfg.get_id_list_by_star[arg_14_1]) do
		if HeroStarCfg[iter_14_1] and HeroStarCfg[iter_14_1].phase > 0 then
			table.insert(self.planStarList, iter_14_1)

			var_14_1 = var_14_1 + 1

			self.planList[var_14_1].upController:SetSelectedState((checkGold(HeroStarCfg[iter_14_1].gold_cost, false) and var_14_0 and arg_14_2.piece >= HeroStarCfg[iter_14_1].star_up and var_14_0 == iter_14_1 or nil) and var_0_1.upState.canUp)
			self.planList[var_14_1].lockController:SetSelectedState(var_14_0 and var_14_0 == iter_14_1 and var_0_1.lockState.selectLock or var_14_0 and iter_14_1 < var_14_0 and var_0_1.lockState.unlock or var_0_1.lockState.lock)
		end
	end

	for iter_14_2, iter_14_3 in pairs(self.planList) do
		SetActive(iter_14_3.gameObject, iter_14_2 <= var_14_1 and true or false)
	end

	SetActive(self.lineGo_, var_14_1 ~= 0)
end

function HeroSurpassPlanNode:Dispose()
	HeroSurpassPlanNode.super.Dispose(self)
end

return HeroSurpassPlanNode
