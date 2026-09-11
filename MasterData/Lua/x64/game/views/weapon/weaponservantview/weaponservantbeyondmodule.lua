local WeaponServantBeyondModule = class("WeaponServantBeyondModule", ReduxView)

function WeaponServantBeyondModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function WeaponServantBeyondModule:BuildContext()
	self.eventHandler = {
		promoteHandler = handler(self, self.OnBeyondSuccess)
	}
	self.controller = {
		comps = self.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			maxLevel = {
				False = "false",
				name = "maxLevel",
				True = "true"
			}
		}
	}
	self.data = {
		servantAddLv = 0,
		heroId = 0,
		curCostType = 1,
		descType = 1,
		info = {},
		servantS_ = {}
	}
	self.constVar = {
		red = "CD421E",
		yellow = "363A42",
		subDescColor = "#70767F",
		costItem = {
			costType = 1,
			entity = ServantBeyondViewConsumeModule.New(self.consumeRes1_)
		},
		costMaterial = {
			costType = 2,
			entity = ServantBeyondViewConsumeModule.New(self.consumeRes2_)
		},
		proxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	}

	self.constVar.costItem.entity:RegisteBtnListener(function()
		self:OnCostItemClick()
	end)
	self.constVar.costMaterial.entity:RegisteBtnListener(function()
		self:OnCostMaterialClick()
	end)
	self:RegistEventListener(SERVANT_PROMOTE, self.eventHandler.promoteHandler)
end

function WeaponServantBeyondModule:InitContext()
	self.data = {
		servantAddLv = 0,
		heroId = 0,
		descType = 1,
		info = {},
		servantS_ = {}
	}
end

function WeaponServantBeyondModule:Init()
	self:BindCfgUI()
	self:BuildContext()
	self:AddUIListener()
end

function WeaponServantBeyondModule:AddUIListener()
	self:AddBtnListener(self.beyondBtn_, nil, function()
		self:OnBeyondClick()
	end)
end

function WeaponServantBeyondModule:OnEnter()
	self:RegistEventListener(SERVANT_PROMOTE, self.eventHandler.promoteHandler)
end

function WeaponServantBeyondModule:OnExit()
	self:RemoveAllEventListener()
end

function WeaponServantBeyondModule:Dispose()
	self.constVar.costItem.entity:Dispose()

	self.constVar.costItem.entity = nil

	self.constVar.costMaterial.entity:Dispose()

	self.constVar.costMaterial.entity = nil

	self:RemoveAllEventListener()
	self:RemoveAllListeners()
	WeaponServantBeyondModule.super.Dispose(self)
end

function WeaponServantBeyondModule:CheckIsArriveMax(arg_12_1)
	return arg_12_1.stage >= GameSetting.weapon_promote_max.value[WeaponServantCfg[arg_12_1.id].starlevel] + 1
end

function WeaponServantBeyondModule:OnRenderModule(arg_13_1)
	self.isCanBarCurrency = true

	self:InitContext()

	self.data.info = arg_13_1.servantData
	self.data.heroId = arg_13_1.heroId
	self.data.servantS_ = ServantTools.GetServantByIDLimited(arg_13_1.servantData.id, true, true, arg_13_1.servantData.uid)

	if self:CheckIsArriveMax(arg_13_1.servantData) then
		self:SwitchControllerState(self.controller.state.maxLevel.name, self.controller.state.maxLevel.True)

		self.curLevelTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_2"), GameSetting.weapon_promote_max.value[WeaponServantCfg[arg_13_1.servantData.id].starlevel] + 1)
		self.strdescText_.text = self.constVar.proxy:GetServantEffect(arg_13_1.servantData.id, arg_13_1.servantData.stage)
		self.isCanBarCurrency = false

		return
	end

	self:SwitchControllerState(self.controller.state.maxLevel.name, self.controller.state.maxLevel.False)

	self.strdescText_.text = self.constVar.proxy:GetServantEffect(arg_13_1.servantData.id, arg_13_1.servantData.stage + 1)
	self.curLevelTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_2"), arg_13_1.servantData.stage)
	self.nextLevelTxt_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_2"), arg_13_1.servantData.stage + 1)
	self.costGoldTxt_.text = setTextColor(self.constVar.yellow, self.constVar.red, ServantTools.ServantBreakCost(WeaponServantCfg[arg_13_1.servantData.id].starlevel, arg_13_1.servantData.stage) or 0, ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) or 0)

	self:RenderStrengthItem()
	self:OnCostItemClick()
end

function WeaponServantBeyondModule:RenderStrengthItem()
	self.constVar.costItem.entity:RefreshData({
		id = self.data.info.id,
		bottomText = table.concat({
			setTextColor(self.constVar.red, "FFFFFF", #self.data.servantS_, 1, function(arg_15_0, arg_15_1)
				return arg_15_0 < arg_15_1
			end),
			"/",
			1
		})
	})

	if WeaponServantCfg[self.data.info.id].starlevel > 3 then
		SetActive(self.consumeRes2_, true)

		local var_14_0 = ServantTools.ServantBreakMaterialCost(self.data.info.id, WeaponServantCfg[self.data.info.id].starlevel)

		self.constVar.costMaterial.entity:RefreshData({
			id = var_14_0[1],
			bottomText = table.concat({
				setTextColor(self.constVar.red, "FFFFFF", ItemTools.getItemNum(var_14_0[1]), var_14_0[2], function(arg_16_0, arg_16_1)
					return arg_16_0 < arg_16_1
				end),
				"/",
				var_14_0[2]
			})
		})
	else
		SetActive(self.consumeRes2_, false)
		self.constVar.costMaterial.entity:RefreshData(nil)
	end
end

function WeaponServantBeyondModule:SwitchControllerState(arg_17_1, arg_17_2)
	local var_17_0 = self.controller.comps:GetController(arg_17_1)

	if var_17_0 then
		var_17_0:SetSelectedState(arg_17_2)
	end
end

function WeaponServantBeyondModule:GetHeroInfo(arg_18_1)
	return self.constVar.proxy:GetHeroData(arg_18_1)
end

function WeaponServantBeyondModule:OnBeyondSuccess(arg_19_1, arg_19_2)
	local var_19_0 = WeaponServantData:GetServantDataByUID(self.data.info.uid)

	if var_19_0 then
		self.data.info.locked = var_19_0.locked
		self.data.info.stage = var_19_0.stage
	end

	self:OnRenderModule({
		servantData = self.data.info,
		heroId = self.data.heroId
	})
	self:Go("servantBreak", {
		stage = self.data.info.stage - 1
	})
end

function WeaponServantBeyondModule:OnCostItemClick()
	self.constVar.costMaterial.entity:SetSelect(false)
	self.constVar.costItem.entity:SetSelect(true)

	self.data.curCostType = self.constVar.costItem.costType
end

function WeaponServantBeyondModule:OnCostMaterialClick()
	self.constVar.costMaterial.entity:SetSelect(true)
	self.constVar.costItem.entity:SetSelect(false)

	self.data.curCostType = self.constVar.costMaterial.costType
end

function WeaponServantBeyondModule:OnBeyondClick()
	self:CheckCost()
end

function WeaponServantBeyondModule:CheckCost()
	local var_23_0
	local var_23_1 = ServantTools.GetServantByIDLimited(self.data.info.id, true, true, self.data.info.uid)

	self:sortList(var_23_1)

	if self.data.curCostType == self.constVar.costItem.costType then
		var_23_0 = var_23_1[1]

		if not var_23_1[1] then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		local var_23_2 = WeaponServantData:GetServantDataByUID(var_23_0)

		if var_23_2.stage > 1 then
			ShowMessageBox({
				content = string.format(GetTips("SERVANT_CONSUME_CONFIRM"), var_23_2.stage),
				OkCallback = function()
					self:OnBeyondAction(var_23_0)
				end
			})

			return
		end

		if not _G.SkipTip.SkipServantPromoteRefineTip and SettingData:GetRemindSettingData().servant_promote_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("SERVANT_TRANSCEND_BY_SERVANT"), ItemTools.getItemName(self.data.info.id)),
				OkCallback = function()
					_G.SkipTip.SkipServantPromoteRefineTip = self.SkipServantPromoteRefineTip_

					self:OnBeyondAction(var_23_0)
				end,
				ToggleCallback = function(arg_26_0)
					self.SkipServantPromoteRefineTip_ = arg_26_0
				end
			})

			return
		end
	else
		local var_23_3 = WeaponServantCfg[self.data.info.id].starlevel
		local var_23_4 = ServantTools.ServantBreakMaterialCost(self.data.info.id, WeaponServantCfg[self.data.info.id].starlevel)

		if not var_23_4 then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		if ItemTools.getItemNum(var_23_4[1]) < var_23_4[2] then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		if not _G.SkipTip.SkipSpiritRefineTip and SettingData:GetRemindSettingData().spirit_refine_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("SERVANT_TRANSCEND"), ServantTools.ServantBreakMaterialCost(self.data.info.id, var_23_3)[2]),
				OkCallback = function()
					_G.SkipTip.SkipSpiritRefineTip = self.SkipSpiritRefineTip_

					self:OnBeyondAction(var_23_0)
				end,
				ToggleCallback = function(arg_28_0)
					self.SkipSpiritRefineTip_ = arg_28_0
				end
			})

			return
		end
	end

	self:OnBeyondAction(var_23_0)
end

function WeaponServantBeyondModule:OnBeyondAction(arg_29_1)
	local var_29_0 = ServantTools.ServantBreakCost(WeaponServantCfg[self.data.info.id].starlevel, self.data.info.stage)

	if checkGold(var_29_0) then
		ServantAction.ServantPromote((arg_29_1 or nil) and 0, self.data.info.uid, arg_29_1, var_29_0)
	end
end

function WeaponServantBeyondModule:sortList(arg_30_1)
	table.sort(arg_30_1, function(arg_31_0, arg_31_1)
		local var_31_0 = WeaponServantData:GetServantDataByUID(arg_31_0)
		local var_31_1 = WeaponServantData:GetServantDataByUID(arg_31_1)

		if var_31_0.stage ~= var_31_1.stage then
			return var_31_0.stage < var_31_1.stage
		end

		return var_31_0.uid < var_31_1.uid
	end)
end

return WeaponServantBeyondModule
