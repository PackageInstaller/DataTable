local ModuleItemResolveView = class("ModuleItemResolveView", ReduxView)
local var_0_1 = GameSetting.weapon_module_break_return

function ModuleItemResolveView:UIName()
	return "Widget/System/Shop/ShopExchangePopUI"
end

function ModuleItemResolveView:UIParent()
	return manager.ui.uiPop.transform
end

function ModuleItemResolveView:InitUI()
	self:BindCfgUI()
end

function ModuleItemResolveView:Init()
	self:InitUI()
	self:AddUIListener()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, CommonItemView)
	self.resultList = LuaList.New(handler(self, self.indexItem2), self.list2Go_, FragmentExchangeItem)
	self.controller = self.controller_:GetController("state")
end

function ModuleItemResolveView:OnEnter()
	self.titleTxt_.text = GetTips("FILE_EXCHANGE")
	self.bottleTxt_.text = GetTips("SHOP_EXCHANGE_CONFIRM_1")
	self.curModulePieceList_ = {}

	self.controller:SetSelectedState(HeroTools.CheckModulePieceCanEnter() and "have" or "none")

	self.noneTxt_.text = GetTips("WEAPON_MODULE_MATERIAL_NOT_ENOUGH")

	if HeroTools.CheckModulePieceCanEnter() == false then
		return
	end

	for iter_5_0, iter_5_1 in pairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MODULE_PIECE]) do
		local var_5_0 = ItemTools.getItemNum(iter_5_1)

		if var_5_0 > 0 then
			table.insert(self.curModulePieceList_, {
				select = 0,
				id = iter_5_1,
				number = var_5_0,
				index = 1
			})
		end
	end

	self.list_:StartScroll(#self.curModulePieceList_)
	self.resultList:StartScroll(1)
	self:RefreshReward()
end

function ModuleItemResolveView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btnOK_, nil, function()
		if self.getNum_ == 0 then
			ShowTips(GetTips("WEAPON_MODULE_MATERIAL_SELECT"))
		else
			local var_8_0 = {}

			for iter_8_0, iter_8_1 in pairs(self.curModulePieceList_) do
				if iter_8_1.select > 0 then
					table.insert(var_8_0, {
						id = iter_8_1.id,
						num = iter_8_1.select
					})
				end
			end

			HeroAction.ResolveModuleItem(var_8_0)
		end
	end)
	self:AddBtnListener(self.btnCancel_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btnLock_, nil, function()
		ShowTips("WEAPON_MODULE_MATERIAL_NOT_ENOUGH")
	end)
end

function ModuleItemResolveView:OnItemSelect(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_1.number > arg_11_1.topAmountValue then
		arg_11_1.topAmountValue = arg_11_1.topAmountValue + 1
		self.curModulePieceList_[arg_11_3].select = arg_11_1.topAmountValue

		arg_11_2:SetData(arg_11_1)
		self:RefreshReward()

		return true
	end

	return false
end

function ModuleItemResolveView:OnItemCut(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_1.topAmountValue > 0 then
		arg_12_1.topAmountValue = arg_12_1.topAmountValue - 1

		if arg_12_1.topAmountValue == 0 then
			arg_12_1.grayFlag = false
		end

		self.curModulePieceList_[arg_12_3].select = arg_12_1.topAmountValue

		arg_12_2:SetData(arg_12_1)
		self:RefreshReward()

		return true
	end

	return false
end

function ModuleItemResolveView:IndexItem(arg_13_1, arg_13_2)
	self.curModulePieceList_[arg_13_1].topAmountValue = self.curModulePieceList_[arg_13_1].select
	self.curModulePieceList_[arg_13_1].clickFun = function(arg_14_0)
		self:OnItemSelect(arg_14_0, arg_13_2, arg_13_1)
	end
	self.curModulePieceList_[arg_13_1].clickAmountFun = function(arg_15_0)
		return self:OnItemCut(arg_15_0, arg_13_2, arg_13_1)
	end
	self.curModulePieceList_[arg_13_1].longClickFun = function(arg_16_0)
		return self:OnItemSelect(arg_16_0, arg_13_2, arg_13_1)
	end

	CommonTools.SetCommonData(arg_13_2, self.curModulePieceList_[arg_13_1])
end

function ModuleItemResolveView:indexItem2(arg_17_1, arg_17_2)
	self.item = arg_17_2
	self.info = {
		number = 1,
		id = var_0_1.value[1],
		clickFun = function()
			ShowPopItem(POP_SOURCE_ITEM, {
				var_0_1.value[1]
			})
		end
	}

	arg_17_2:SetData(self.info, self.getNum_ or 0)
end

function ModuleItemResolveView:RefreshReward()
	self.getNum_ = 0

	for iter_19_0, iter_19_1 in pairs(self.curModulePieceList_) do
		self.getNum_ = self.getNum_ + iter_19_1.select
	end

	self.getNum_ = self.getNum_ * var_0_1.value[2]
	self.info = {
		number = 1,
		id = var_0_1.value[1],
		clickFun = function()
			ShowPopItem(POP_SOURCE_ITEM, {
				var_0_1.value[1]
			})
		end
	}

	if self.item then
		self.item:SetData(self.info, self.getNum_)
	end
end

function ModuleItemResolveView:OnResolveModuleItem(arg_21_1, arg_21_2)
	if self.getNum_ == 0 then
		return
	end

	if arg_21_1.result == 0 then
		JumpTools:Back()
		getReward({
			{
				id = var_0_1.value[1],
				num = self.getNum_
			}
		})
	else
		ShowTips(arg_21_1.result)
	end
end

function ModuleItemResolveView:Dispose()
	self:RemoveAllListeners()

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	if self.resultList then
		self.resultList:Dispose()

		self.resultList = nil
	end

	ModuleItemResolveView.super.Dispose(self)
end

return ModuleItemResolveView
