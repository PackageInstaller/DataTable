local var_0_0 = class("ModuleItemResolveView", ReduxView)
local var_0_1 = GameSetting.weapon_module_break_return

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Shop/ShopExchangePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, CommonItemView)
	arg_4_0.resultList = LuaList.New(handler(arg_4_0, arg_4_0.indexItem2), arg_4_0.list2Go_, FragmentExchangeItem)
	arg_4_0.controller = arg_4_0.controller_:GetController("state")
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.titleTxt_.text = GetTips("FILE_EXCHANGE")
	arg_5_0.bottleTxt_.text = GetTips("SHOP_EXCHANGE_CONFIRM_1")
	arg_5_0.curModulePieceList_ = {}

	arg_5_0.controller:SetSelectedState(HeroTools.CheckModulePieceCanEnter() and "have" or "none")

	arg_5_0.noneTxt_.text = GetTips("WEAPON_MODULE_MATERIAL_NOT_ENOUGH")

	if HeroTools.CheckModulePieceCanEnter() == false then
		return
	end

	local var_5_0 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MODULE_PIECE]
	local var_5_1 = 1

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		local var_5_2 = ItemTools.getItemNum(iter_5_1)

		if var_5_2 > 0 then
			local var_5_3 = {
				select = 0,
				id = iter_5_1,
				number = var_5_2,
				index = var_5_1
			}

			table.insert(arg_5_0.curModulePieceList_, var_5_3)

			var_5_1 = var_5_1 + 1
		end
	end

	arg_5_0.list_:StartScroll(#arg_5_0.curModulePieceList_)
	arg_5_0.resultList:StartScroll(1)
	arg_5_0:RefreshReward()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnOK_, nil, function()
		if arg_6_0.getNum_ == 0 then
			ShowTips(GetTips("WEAPON_MODULE_MATERIAL_SELECT"))
		else
			local var_8_0 = {}

			for iter_8_0, iter_8_1 in pairs(arg_6_0.curModulePieceList_) do
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
	arg_6_0:AddBtnListener(arg_6_0.btnCancel_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnLock_, nil, function()
		ShowTips("WEAPON_MODULE_MATERIAL_NOT_ENOUGH")
	end)
end

function var_0_0.OnItemSelect(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_1.number > arg_11_1.topAmountValue then
		arg_11_1.topAmountValue = arg_11_1.topAmountValue + 1
		arg_11_0.curModulePieceList_[arg_11_3].select = arg_11_1.topAmountValue

		arg_11_2:SetData(arg_11_1)
		arg_11_0:RefreshReward()

		return true
	end

	return false
end

function var_0_0.OnItemCut(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_1.topAmountValue > 0 then
		arg_12_1.topAmountValue = arg_12_1.topAmountValue - 1

		if arg_12_1.topAmountValue == 0 then
			arg_12_1.grayFlag = false
		end

		arg_12_0.curModulePieceList_[arg_12_3].select = arg_12_1.topAmountValue

		arg_12_2:SetData(arg_12_1)
		arg_12_0:RefreshReward()

		return true
	end

	return false
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.curModulePieceList_[arg_13_1]

	var_13_0.topAmountValue = var_13_0.select

	function var_13_0.clickFun(arg_14_0)
		arg_13_0:OnItemSelect(arg_14_0, arg_13_2, arg_13_1)
	end

	function var_13_0.clickAmountFun(arg_15_0)
		return arg_13_0:OnItemCut(arg_15_0, arg_13_2, arg_13_1)
	end

	function var_13_0.longClickFun(arg_16_0)
		return arg_13_0:OnItemSelect(arg_16_0, arg_13_2, arg_13_1)
	end

	CommonTools.SetCommonData(arg_13_2, var_13_0)
end

function var_0_0.indexItem2(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.item = arg_17_2
	arg_17_0.info = {
		number = 1,
		id = var_0_1.value[1],
		clickFun = function()
			ShowPopItem(POP_SOURCE_ITEM, {
				var_0_1.value[1]
			})
		end
	}

	arg_17_2:SetData(arg_17_0.info, arg_17_0.getNum_ or 0)
end

function var_0_0.RefreshReward(arg_19_0)
	arg_19_0.getNum_ = 0

	for iter_19_0, iter_19_1 in pairs(arg_19_0.curModulePieceList_) do
		arg_19_0.getNum_ = arg_19_0.getNum_ + iter_19_1.select
	end

	arg_19_0.getNum_ = arg_19_0.getNum_ * var_0_1.value[2]
	arg_19_0.info = {
		number = 1,
		id = var_0_1.value[1],
		clickFun = function()
			ShowPopItem(POP_SOURCE_ITEM, {
				var_0_1.value[1]
			})
		end
	}

	if arg_19_0.item then
		arg_19_0.item:SetData(arg_19_0.info, arg_19_0.getNum_)
	end
end

function var_0_0.OnResolveModuleItem(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.getNum_ == 0 then
		return
	end

	if arg_21_1.result == 0 then
		JumpTools:Back()

		local var_21_0 = {
			{
				id = var_0_1.value[1],
				num = arg_21_0.getNum_
			}
		}

		getReward(var_21_0)
	else
		ShowTips(arg_21_1.result)
	end
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0:RemoveAllListeners()

	if arg_22_0.list_ then
		arg_22_0.list_:Dispose()

		arg_22_0.list_ = nil
	end

	if arg_22_0.resultList then
		arg_22_0.resultList:Dispose()

		arg_22_0.resultList = nil
	end

	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
