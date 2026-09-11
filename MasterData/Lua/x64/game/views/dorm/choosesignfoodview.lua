local ChooseSignFoodView = class("ChooseSignFoodView", ReduxView)

function ChooseSignFoodView:UIName()
	return "Widget/BackHouseUI/canteen/EmptyDreamTodayMenuPop"
end

function ChooseSignFoodView:UIParent()
	return manager.ui.uiMain.transform
end

function ChooseSignFoodView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChooseSignFoodView:InitUI()
	self:BindCfgUI()

	self.foodScroll_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, ChooseFoodItem)
	self.chooseItemScroll_ = LuaList.New(handler(self, self.refreshItem), self.chooseuilistGo_, TodayMenuItem)
	self.chooseListController = ControllerUtil.GetController(self.transform_, "food")
	self.btnController = {
		[3] = ControllerUtil.GetController(self.fryingpanBtn_.transform, "name"),
		[4] = ControllerUtil.GetController(self.steamerBtn_.transform, "name"),
		[5] = ControllerUtil.GetController(self.grillBtn_.transform, "name"),
		[6] = ControllerUtil.GetController(self.potBtn_.transform, "name")
	}
end

function ChooseSignFoodView:RegisterEvent()
	self:RegistEventListener(CANTEEN_SET_SIGNFOOD_SUCCESS, function()
		self:RefreshFoodList()
	end)
end

function ChooseSignFoodView:AddUIListener()
	self:AddBtnListener(self.fryingpanBtn_, nil, function()
		self.selectIndex_ = DormEnum.FurnitureTypeNum.Pan

		self:UpdateItemData()
		self.foodScroll_:StartScroll(#self.itemList_)
	end)
	self:AddBtnListener(self.grillBtn_, nil, function()
		self.selectIndex_ = DormEnum.FurnitureTypeNum.Oven

		self:UpdateItemData()
		self.foodScroll_:StartScroll(#self.itemList_)
	end)
	self:AddBtnListener(self.steamerBtn_, nil, function()
		self.selectIndex_ = DormEnum.FurnitureTypeNum.Steamer

		self:UpdateItemData()
		self.foodScroll_:StartScroll(#self.itemList_)
	end)
	self:AddBtnListener(self.potBtn_, nil, function()
		self.selectIndex_ = DormEnum.FurnitureTypeNum.Pot

		self:UpdateItemData()
		self.foodScroll_:StartScroll(#self.itemList_)
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function ChooseSignFoodView:refreshItem(arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(self.chooseItemList_[arg_13_1])

	self.cursignfoodText_.text = #CanteenFoodData:GetChooseFoodList()
	self.totalsignfoodText_.text = "/" .. DormSkillData:GetCanSignFoodNum()
end

function ChooseSignFoodView:indexItem(arg_14_1, arg_14_2)
	arg_14_2:RefreshUI(self.itemList_[arg_14_1])
	arg_14_2:RegistCallBack(function(arg_15_0)
		if (#CanteenFoodData:GetChooseFoodList() or 0) >= DormSkillData:GetCanSignFoodNum() then
			ShowTips(GetTips("CANTEEN_FOOD_MAX"))
		else
			JumpTools.OpenPageByJump("/reviseSignFoodNumView", {
				foodID = arg_15_0
			})
		end
	end)
	arg_14_2:RegisterLackCallBack(function(arg_16_0)
		JumpTools.OpenPageByJump("canteenLackFoodIngredientsView", {
			foodID = arg_16_0
		})
	end)
end

function ChooseSignFoodView:UpdateItemData()
	self.itemList_ = {}

	for iter_17_0, iter_17_1 in pairs(BackHomeCanteenFoodCfg.all) do
		if self.selectIndex_ == BackHomeCanteenFoodCfg[iter_17_1].cook_type then
			if BackHomeCanteenFoodCfg[iter_17_1].unlock > 0 then
				if CanteenTools:CheckFoodUnLock(iter_17_1) then
					table.insert(self.itemList_, iter_17_1)
				end
			else
				table.insert(self.itemList_, iter_17_1)
			end
		end
	end

	CommonTools.UniversalSortEx(self.itemList_, {
		map = function(arg_18_0)
			return arg_18_0
		end
	})

	self.cooktitleText_.text = GetI18NText(CanteenTools:GetCookCfgName(self.selectIndex_))

	for iter_17_2, iter_17_3 in pairs(self.btnController) do
		if self.selectIndex_ == iter_17_2 then
			iter_17_3:SetSelectedState("on")
		else
			iter_17_3:SetSelectedState("off")
		end
	end
end

function ChooseSignFoodView:OnEnter()
	self.selectIndex_ = self.selectIndex_ or DormEnum.FurnitureTypeNum.Pan

	if manager.guide:IsPlaying() then
		self.selectIndex_ = DormEnum.FurnitureTypeNum.Pan
	end

	self.params_.type = nil

	self:RefreshFoodList()
	self:RegisterEvent()
end

function ChooseSignFoodView:RefreshFoodList()
	self:UpdateItemData()
	self.foodScroll_:StartScroll(#self.itemList_)

	self.chooseItemList_ = CanteenFoodData:GetChooseFoodList()

	if #self.chooseItemList_ > 0 then
		self.chooseListController:SetSelectedState("on")
	else
		self.chooseListController:SetSelectedState("off")
	end

	self.chooseItemScroll_:StartScroll(#self.chooseItemList_)
end

function ChooseSignFoodView:OnExit()
	self:RemoveAllEventListener()
end

function ChooseSignFoodView:Dispose()
	if self.toggleList_ then
		self.toggleList_:Dispose()
	end

	if self.chooseItemList_ then
		self.chooseItemScroll_:Dispose()
	end

	if self.foodScroll_ then
		self.foodScroll_:Dispose()
	end

	ChooseSignFoodView.super.Dispose(self)
end

return ChooseSignFoodView
