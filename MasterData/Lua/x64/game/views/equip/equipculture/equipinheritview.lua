local EquipInheritView = class("EquipInheritView", EquipBaseView)

function EquipInheritView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.params_ = arg_1_3

	self:Init()
end

function EquipInheritView:Init()
	self:InitUI()
	self:AddUIListener()
	EquipInheritView.super.Init(self)
end

function EquipInheritView:InitUI()
	self:BindCfgUI()

	self.costItemList_ = LuaList.New(handler(self, self.IndexCostItem), self.materialListGo_, CommonItemView)
	self.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	self.stateController_ = self.transCon_:GetController("state")
	self.costController_ = ControllerUtil.GetController(self.transform_, "costState")
end

function EquipInheritView:AddUIListener()
	self:AddBtnListener(self.btnTips_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("EQUIP_INHERIT_DESC")
		})
	end)
	self:AddBtnListener(self.btnAdd_, nil, function()
		JumpTools.OpenPageByJump("equipInheritPrefabSelect", {
			equipID = self.equipID_,
			suitId = self.selectSuitID_,
			selectSuitHandler = handler(self, self.OnSelectSuit)
		})
	end)
	self:AddBtnListener(self.btnInherit_, nil, function()
		if self.selectSuitID_ == nil then
			ShowTips("EQUIP_INHERIT_SELECT")
		elseif self.selectSuitID_ == self.equipCfg_.suit then
			ShowTips("ERROR_EQUIP_SAME_ID")
		elseif self.materialEnough_ == false then
			ShowTips("ERROR_ITEM_NO_ENOUGH_MATERIAL")
		elseif self.goldEnough_ == false then
			local var_7_0 = false

			for iter_7_0, iter_7_1 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND] or {}) do
				if ItemTools.getItemNum(iter_7_1) > 0 then
					var_7_0 = true

					break
				end
			end

			if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or var_7_0 then
				JumpTools.OpenPopUp("currencyBuyGold", nil, ViewConst.SYSTEM_ID.BUY_GOLD)
			else
				ShowTips(GetTips("ERROR_ITEM_NOT_ENOUGH_GOLD"))
			end
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_INHERIT_CONFIRM"),
				OkCallback = function()
					EquipAction.InheritEquip(self.equipID_, self.selectPrefabID_)
				end
			})
		end
	end)
	self:AddBtnListener(self.btnInfo_, nil, function()
		self.handler_:RefreshEquipInfo(self.selectInfo_)
	end)
end

function EquipInheritView:IndexCostItem(arg_10_1, arg_10_2)
	local var_10_0 = self.materialList_[arg_10_1]
	local var_10_1 = clone(ItemTemplateData)

	var_10_1.id = self.materialList_[arg_10_1].id
	var_10_1.hideBottomRightTextFlag = true

	local var_10_2 = ItemTools.getItemNum(var_10_0.id)

	var_10_1.bottomText = {
		var_10_2,
		var_10_0.number
	}

	function var_10_1:clickFun()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.id,
			self.number
		})
	end

	arg_10_2:SetData(var_10_1)

	if self.materialEnough_ == true then
		self.materialEnough_ = var_10_2 >= var_10_0.number
	end
end

function EquipInheritView:OnEnter()
	self:OnEquipChange(self.params_.equipId)
	self:RegistEventListener(CURRENCY_UPDATE, handler(self, self.OnGoldChange))
end

function EquipInheritView:OnEquipChange(arg_13_1)
	self.equipID_ = arg_13_1
	self.equipData_ = EquipData:GetEquipData(self.equipID_)
	self.equipCfg_ = EquipCfg[self.equipData_.prefab_id]
	self.selectSuitID_ = nil

	self:OnSelectSuit()
end

function EquipInheritView:RefreshMoney()
	local var_14_0 = self.moneyCost_ or 0
	local var_14_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
	local var_14_2 = tostring(var_14_0)

	if var_14_1 < var_14_0 then
		var_14_2 = "<color='#FF0000'>" .. var_14_2 .. "</color>"
	end

	self.goldEnough_ = var_14_0 <= var_14_1
	self.costNum_.text = var_14_2
end

function EquipInheritView:RefreshMaterial()
	self.materialEnough_ = true

	self.costItemList_:StartScroll(#self.materialList_)
end

function EquipInheritView:OnGoldChange(arg_16_1)
	if self.selectSuitID_ and arg_16_1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		self:RefreshMoney()
	end
end

function EquipInheritView:ChangeBar()
	local var_17_0 = {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	}

	if self.selectSuitID_ then
		table.insert(var_17_0, CurrencyConst.CURRENCY_TYPE_GOLD)
		manager.windowBar:SwitchBar(var_17_0)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	else
		manager.windowBar:SwitchBar(var_17_0)
	end
end

function EquipInheritView:OnTop()
	self:ChangeBar()
end

function EquipInheritView:OnSelectSuit(arg_19_1)
	if arg_19_1 ~= nil then
		self.stateController_:SetSelectedIndex(1)

		self.selectSuitID_ = arg_19_1
		self.materialList_, self.moneyCost_ = EquipData:GetInheritCost(self.selectSuitID_)

		self:RefreshMaterial()
		self:RefreshMoney()
		self:RefreshSelect()
		self:ChangeBar(true)
	else
		self.stateController_:SetSelectedIndex(0)
		self:ChangeBar(false)
	end
end

function EquipInheritView:RefreshSelect()
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/icon_s/" .. self.selectSuitID_)

	for iter_20_0 = #EquipCfg.get_id_list_by_suit[self.selectSuitID_], 1, -1 do
		if EquipCfg[EquipCfg.get_id_list_by_suit[self.selectSuitID_][iter_20_0]].pos == self.equipCfg_.pos and EquipCfg[EquipCfg.get_id_list_by_suit[self.selectSuitID_][iter_20_0]].starlevel >= 5 then
			self.selectPrefabID_ = EquipCfg.get_id_list_by_suit[self.selectSuitID_][iter_20_0]

			break
		end
	end

	self.name_.text = ItemTools.getItemName(self.selectPrefabID_)
	self.selectInfo_ = deepClone(self.equipData_)
	self.selectInfo_.prefab_id = self.selectPrefabID_
	self.selectInfo_.equipConfig = EquipCfg[self.selectPrefabID_]
end

function EquipInheritView:ResetInherit()
	self.selectSuitID_ = nil
	self.equipData_ = EquipData:GetEquipData(self.equipID_)
	self.equipCfg_ = EquipCfg[self.equipData_.prefab_id]

	self.stateController_:SetSelectedIndex(0)
end

function EquipInheritView:OnExit()
	self:RemoveAllEventListener()
end

function EquipInheritView:Dispose()
	if self.costItemList_ then
		self.costItemList_:Dispose()

		self.costItemList_ = nil
	end

	EquipInheritView.super.Dispose(self)
end

return EquipInheritView
