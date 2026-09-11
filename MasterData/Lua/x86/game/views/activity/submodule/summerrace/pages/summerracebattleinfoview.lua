local SummerRaceEnemyWaveItemView = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceEnemyWaveItemView")
local SummerRaceEquipItemView = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceEquipItemView")
local CommonItemView = import("game.views.common.CommonItemView")
local SummerRaceBattleInfoView = class("SummerRaceBattleInfoView", ReduxView)
local var_0_4 = "in"
local var_0_5 = "idle"
local var_0_6 = "Widget/System/Activity_SummerRace/com/propertiesItem"

local function var_0_7()
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_MODIFY, SummerRaceConst.ACTIVITY_ID.MAIN)
end

local function var_0_8(arg_2_0)
	if arg_2_0 == nil then
		return nil
	end

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		var_2_0[iter_2_0] = iter_2_1
	end

	return var_2_0
end

local function var_0_9(arg_3_0)
	local var_3_0 = {}

	for iter_3_0 = 1, #((arg_3_0 or nil) and (arg_3_0.slotSummary or {})) do
		local var_3_1 = var_0_8(arg_3_0.slotSummary[iter_3_0])

		if var_3_1 ~= nil then
			local var_3_2 = var_3_1.itemId ~= nil and tostring(var_3_1.itemId) ~= ""

			var_3_1.interactionMode = "inspect"
			var_3_1.itemClickEnabled = var_3_2
			var_3_1.showEquippedIcon = var_3_2
			var_3_1.isSelected = false
			var_3_0[#var_3_0 + 1] = var_3_1
		end
	end

	return var_3_0
end

local function var_0_10(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0 == nil or arg_4_1 == nil or arg_4_2 == nil then
		return ""
	end

	local var_4_0 = tostring(arg_4_2.slotType or "")
	local var_4_1 = tostring(arg_4_2.slotIndex or "")
	local var_4_2 = arg_4_2.itemId
	local var_4_3

	if not arg_4_2.itemId then
		var_4_2 = ""
		var_4_3 = {
			tostring(arg_4_0),
			tostring(arg_4_1),
			var_4_0,
			var_4_1
		}
	end

	var_4_3[5] = tostring(var_4_2)

	return table.concat(var_4_3, "|")
end

local function var_0_11(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = tonumber(arg_5_1) or 0
	local var_5_1 = tonumber(arg_5_2) or 0

	if var_5_1 <= 0 then
		error("[SummerRaceModifyView] invalid property max value for `" .. tostring(arg_5_0) .. "`")
	end

	return {
		type = arg_5_0,
		value = tostring(arg_5_3 ~= nil and arg_5_3 or var_5_0),
		currentValue = var_5_0,
		maxValue = var_5_1
	}
end

local function var_0_12(arg_6_0, arg_6_1)
	if arg_6_0 == nil or arg_6_0 == "" then
		return tostring(arg_6_1 or "-")
	end

	return tostring(arg_6_0)
end

local function var_0_13(arg_7_0, arg_7_1)
	if arg_7_0 == nil or arg_7_1 == nil then
		return nil
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
		if iter_7_1 ~= nil then
			if iter_7_1.bodyId ~= nil and iter_7_1.bodyId == arg_7_1 then
				return iter_7_1
			end

			if iter_7_1.itemId ~= nil and iter_7_1.itemId == arg_7_1 then
				return iter_7_1
			end

			if iter_7_1.id ~= nil and iter_7_1.id == arg_7_1 then
				return iter_7_1
			end

			if tostring(iter_7_1.bodyId) == tostring(arg_7_1) or tostring(iter_7_1.itemId) == tostring(arg_7_1) or tostring(iter_7_1.id) == tostring(arg_7_1) then
				return iter_7_1
			end
		end
	end

	return nil
end

local function var_0_14(arg_8_0)
	if arg_8_0 == nil then
		return nil
	end

	if arg_8_0.typeText == SummerRaceConst.FILTER.EQUIP then
		return {
			panelType = "equip",
			title = arg_8_0.itemName,
			cost = arg_8_0.cost,
			desc = arg_8_0.desc,
			properties = {
				var_0_11("Skill", arg_8_0.energyCost, SummerRaceData:GetPropertyMax("Skill", arg_8_0.typeText), var_0_12(arg_8_0.energyCost, 0))
			}
		}
	end

	return {
		panelType = "weapon",
		title = arg_8_0.itemName,
		cost = arg_8_0.cost,
		desc = arg_8_0.desc,
		properties = {
			var_0_11("ATK", arg_8_0.damage, SummerRaceData:GetPropertyMax("ATK", arg_8_0.typeText), var_0_12(arg_8_0.damage, 0)),
			var_0_11("ROF", arg_8_0.rof, SummerRaceData:GetPropertyMax("ROF", arg_8_0.typeText), var_0_12(arg_8_0.rof, 0)),
			var_0_11("Skill", arg_8_0.energyCost, SummerRaceData:GetPropertyMax("Skill", arg_8_0.typeText), var_0_12(arg_8_0.energyCost, 0))
		}
	}
end

local function var_0_15(arg_9_0)
	if arg_9_0 == nil then
		return nil
	end

	local var_9_0 = {}

	var_9_0.title = tostring(arg_9_0.bodyName or "")
	var_9_0.desc = tostring(arg_9_0.desc or arg_9_0.bodyDesc or "")
	var_9_0.hpText = var_0_12(arg_9_0.hp, 0)
	var_9_0.costText = var_0_12(arg_9_0.cost, 0)

	return var_9_0
end

local function var_0_16(arg_10_0)
	if arg_10_0 == nil then
		return nil
	end

	local var_10_0

	if arg_10_0.properties then
		var_10_0 = arg_10_0.properties[1] or nil
	end

	local var_10_1 = {}

	var_10_1.title = tostring(arg_10_0.title or "")
	var_10_1.desc = tostring(arg_10_0.desc or "")

	if var_10_0 then
		var_10_1.hpText = var_10_0.value or 0
	end

	var_10_1.costText = arg_10_0.cost or 0

	return var_10_1
end

local function var_0_17(arg_11_0, arg_11_1)
	if arg_11_0 == nil or arg_11_0.bodyTipsGo_ == nil or arg_11_1 == nil then
		return nil
	end

	local var_11_0 = arg_11_0.bodyTipsGo_.transform.parent

	if arg_11_0.bodyTipsGo_.transform.parent == nil then
		return nil
	end

	return var_11_0:InverseTransformPoint(arg_11_1.position)
end

local function var_0_18(arg_12_0)
	if arg_12_0 == nil then
		return nil
	end

	if arg_12_0.icon_ ~= nil and arg_12_0.icon_.transform ~= nil then
		return arg_12_0.icon_.transform
	end

	return arg_12_0.transform_
end

local function var_0_19(arg_13_0)
	if arg_13_0 == nil or arg_13_0.bodyTipsGo_ == nil then
		return nil
	end

	return arg_13_0.bodyTipsGo_.transform:Find("base/arrow") or arg_13_0.bodyTipsGo_.transform
end

local function var_0_20(arg_14_0, arg_14_1)
	local var_14_0 = var_0_17(arg_14_0, var_0_18(arg_14_1))
	local var_14_1 = var_0_17(arg_14_0, var_0_19(arg_14_0))

	if var_14_0 == nil or var_14_1 == nil or arg_14_0.bodyTipsGo_ == nil then
		return
	end

	arg_14_0.bodyTipsGo_.transform.localPosition = Vector3.New(arg_14_0.bodyTipsGo_.transform.localPosition.x + (var_14_0.x - var_14_1.x), arg_14_0.bodyTipsGo_.transform.localPosition.y, arg_14_0.bodyTipsGo_.transform.localPosition.z)
end

function SummerRaceBattleInfoView:RefreshOptionInfoPanel(arg_15_1, arg_15_2)
	if arg_15_1 == nil or arg_15_2 == nil then
		return
	end

	arg_15_1:SetData(arg_15_2)
end

local function var_0_21(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0

	if arg_16_2 then
		var_16_0 = arg_16_2.rewardData or nil
	end

	local var_16_1

	if arg_16_2 ~= nil and arg_16_2.itemId ~= nil and tostring(arg_16_2.itemId) ~= "" then
		var_16_1 = var_0_14(SummerRaceData:GetOptionDefById(arg_16_2.itemId))
	end

	if var_16_1 == nil and var_16_0 ~= nil and var_16_0.rewardType == 3 then
		arg_16_0.tipsController_:SetSelectedState("tips_s")
		arg_16_0.bodyTipsView_:SetData(var_0_15((var_0_13(SummerRaceData:GetBodyDefs(), var_16_0.itemId))))
		var_0_20(arg_16_0, arg_16_4)

		return true
	end

	if var_16_1 == nil and var_16_0 ~= nil and var_16_0.rewardType ~= 3 then
		arg_16_0.tipsController_:SetSelectedState("none")

		return false
	end

	if var_16_1 ~= nil then
		if var_16_0 ~= nil then
			arg_16_0.tipsController_:SetSelectedState("tips_s")
			arg_16_0.bodyTipsView_:SetData(var_0_16(var_16_1))
			var_0_20(arg_16_0, arg_16_4)

			return true
		end

		if arg_16_3 == 1 then
			if var_16_1.panelType == "equip" then
				arg_16_0.tipsController_:SetSelectedState("tips_m")
				arg_16_0:RefreshOptionInfoPanel(arg_16_0.equipTipsView_, var_16_1)
			else
				arg_16_0.tipsController_:SetSelectedState("tips_l")
				arg_16_0:RefreshOptionInfoPanel(arg_16_0.weaponTipsView_, var_16_1)
			end
		elseif var_16_1.panelType == "equip" then
			arg_16_0.tipsController_:SetSelectedState("tips_m_2")
			arg_16_0:RefreshOptionInfoPanel(arg_16_0.equipTipsView2_, var_16_1)
		else
			arg_16_0.tipsController_:SetSelectedState("tips_l_2")
			arg_16_0:RefreshOptionInfoPanel(arg_16_0.weaponTipsView2_, var_16_1)
		end

		return true
	end

	arg_16_0.tipsController_:SetSelectedState("tips_s")
	arg_16_0.bodyTipsView_:SetData(var_0_15(arg_16_0.infoVehicleSnapshot_ or arg_16_0.vehicleSnapshot_))

	return true
end

local function var_0_22(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0 = 1, #(arg_17_0 or {}) do
		local var_17_0 = arg_17_0[iter_17_0]

		if arg_17_0[iter_17_0] ~= nil then
			var_17_0.isSelected = var_0_10(arg_17_2, iter_17_0, var_17_0) == arg_17_1
		end
	end
end

local function var_0_23(arg_18_0)
	local var_18_0 = {}

	for iter_18_0 = 1, #(arg_18_0 or {}) do
		local var_18_1 = arg_18_0[iter_18_0]

		if arg_18_0[iter_18_0] ~= nil and var_18_1.itemId ~= nil and tostring(var_18_1.itemId) ~= "" then
			local var_18_2 = SummerRaceConst.FILTER.EQUIP

			if var_18_1.rewardType == 1 then
				var_18_2 = SummerRaceConst.FILTER.WEAPON
			elseif var_18_1.rewardType == 2 then
				var_18_2 = SummerRaceConst.FILTER.EQUIP
			elseif var_18_1.rewardType == 3 then
				var_18_2 = SummerRaceConst.FILTER.BODY
			end

			var_18_0[#var_18_0 + 1] = {
				showEquippedIcon = true,
				slotState = "normal",
				interactionMode = "inspect",
				itemClickEnabled = true,
				isSelected = false,
				slotType = var_18_2,
				slotIndex = iter_18_0,
				itemId = var_18_1.itemId,
				iconPath = var_18_1.iconPath,
				rewardData = var_18_1
			}
		end
	end

	return var_18_0
end

local function var_0_24(arg_19_0)
	arg_19_0.enabled = false
	arg_19_0.enabled = true
end

local function var_0_25(arg_20_0)
	if arg_20_0.adminSpineGo_ ~= nil then
		return arg_20_0.adminSpineGo_
	end
end

local function var_0_26(arg_21_0)
	if arg_21_0.adminSpineCompleteHandler_ ~= nil and arg_21_0.adminSpine_ ~= nil and arg_21_0.adminSpine_.AnimationState ~= nil then
		arg_21_0.adminSpine_.AnimationState.Complete = arg_21_0.adminSpine_.AnimationState.Complete - arg_21_0.adminSpineCompleteHandler_
	end

	arg_21_0.adminSpineCompleteHandler_ = nil
end

local function var_0_27(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	var_0_26(arg_22_0)

	if arg_22_0.adminSpine_ == nil or arg_22_0.adminSpine_.AnimationState == nil then
		return false
	end

	local var_22_0, var_22_1 = pcall(function()
		arg_22_0.adminSpine_.AnimationState:SetAnimation(0, arg_22_1, arg_22_2 == true)
	end)

	if var_22_0 ~= true then
		Debug.LogWarning(string.format("[SummerRaceBattleInfoView] failed to play admin spine animation: %s, %s", tostring(arg_22_1), tostring(var_22_1)))

		return false
	end

	if arg_22_3 ~= nil and arg_22_2 ~= true then
		arg_22_0.adminSpineCompleteHandler_ = nil
		arg_22_0.adminSpine_.AnimationState.Complete = arg_22_0.adminSpine_.AnimationState.Complete + function()
			var_0_26(arg_22_0)
			arg_22_3()
		end
	end

	return true
end

local function var_0_28(arg_25_0)
	var_0_27(arg_25_0, var_0_4, false, function()
		var_0_27(arg_25_0, var_0_5, true)
	end)
end

local function var_0_29(arg_27_0, arg_27_1)
	if arg_27_0.adminPosController_ == nil then
		return
	end

	local var_27_0 = tonumber(arg_27_1 and arg_27_1.bodyType) or 1

	if var_27_0 ~= 1 and var_27_0 ~= 2 and var_27_0 ~= 3 then
		var_27_0 = 1
	end

	arg_27_0.adminPosController_:SetSelectedState("pos_" .. tostring(var_27_0))
end

local function var_0_30(arg_28_0, arg_28_1)
	arg_28_0.clearStateController_:SetSelectedState(arg_28_1 and arg_28_1.isCompleted == true and "true" or "false")
end

function SummerRaceBattleInfoView:SyncAdminPos(arg_29_1)
	var_0_29(self, arg_29_1)
end

function SummerRaceBattleInfoView:OnCtor(arg_30_1)
	self.gameObject_ = arg_30_1
	self.transform_ = arg_30_1.transform

	self:Init()
end

function SummerRaceBattleInfoView:Init()
	self:BindCfgUI()

	self.enemyWaveList_ = {}
	self.detailSlotList_ = {}
	self.statusSlotList_ = {}
	self.rewardList_ = {}
	self.selectedSlotKey_ = ""
	self.enemyWaveItemList_ = LuaList.New(handler(self, self.IndexEnemyWaveItem), self.enemyWaveListGo_, SummerRaceEnemyWaveItemView)
	self.detailEquipSlotItemList_ = LuaList.New(handler(self, self.IndexDetailSlotItem), self.equipListGo_, SummerRaceEquipItemView)
	self.rewardItemList_ = LuaList.New(handler(self, self.IndexRewardItem), self.rewardListGo_, CommonItemView)
	self.statusEquipItemList_ = LuaList.New(handler(self, self.IndexStatusSlotItem), self.statusEquipListGo_, SummerRaceEquipItemView)
	self.modeController_ = self.controllerEx_:GetController("mode")
	self.tipsController_ = self.controllerEx_:GetController("tips")
	self.adminPosController_ = self.controllerEx_:GetController("adminPos")
	self.clearStateController_ = self.controllerEx_:GetController("clearState")
	self.adminSpineGo_ = var_0_25(self)
	self.adminSpine_ = self.adminSpineGo_ and self.adminSpineGo_:GetComponent(typeof(Spine.Unity.SkeletonGraphic)) or nil
	self.propertiesItemPrefab_ = Asset.Load(var_0_6)
	self.bodyTipsView_ = SummerRaceBodyTipsView.New(self.bodyTipsGo_)
	self.weaponTipsView_ = SummerRaceOptionTipsView.New(self.weaponTipsGo_, self.propertiesItemPrefab_)
	self.equipTipsView_ = SummerRaceOptionTipsView.New(self.equipTipsGo_, self.propertiesItemPrefab_)
	self.weaponTipsView2_ = SummerRaceOptionTipsView.New(self.weaponTipsGo2_, self.propertiesItemPrefab_)
	self.equipTipsView2_ = SummerRaceOptionTipsView.New(self.equipTipsGo2_, self.propertiesItemPrefab_)
	self.defaultTexts_ = {
		stageName = self.stageNameText_.text,
		stageIndex = self.stageIndexText_.text,
		stageDesc = self.stageDescText_.text
	}

	self:AddUIListener()
	manager.redPoint:bindUIandKey(self.modifyBtn_.transform, var_0_7())
end

function SummerRaceBattleInfoView:SetHandlers(arg_32_1)
	self.modifyHandler_ = arg_32_1.modify
	self.rankHandler_ = arg_32_1.rank
	self.stageStartHandler_ = arg_32_1.stageStart
	self.challengeStartHandler_ = arg_32_1.challengeStart
	self.enemyWaveHandler_ = arg_32_1.enemyWave
	self.detailSlotHandler_ = arg_32_1.detailSlot
	self.rewardClickHandler_ = arg_32_1.rewardClick
end

function SummerRaceBattleInfoView:AddUIListener()
	self:AddBtnListener(self.modifyBtn_, nil, function()
		self:HideTips()
		self.modifyHandler_()
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		self:HideTips()
		self.rankHandler_()
	end)
	self:AddBtnListener(self.mainStartBtn_, nil, function()
		self:HideTips()
		self.stageStartHandler_()
	end)
	self:AddBtnListener(self.challengeStartBtn_, nil, function()
		self:HideTips()
		self.challengeStartHandler_()
	end)
	self:AddBtnListener(self.tipsBgBtn_, nil, function()
		self:HideTips()
	end)
end

function SummerRaceBattleInfoView:IndexEnemyWaveItem(arg_39_1, arg_39_2)
	arg_39_2:SetData(self.enemyWaveList_[arg_39_1], arg_39_1, handler(self, self.OnEnemyWaveAction))
end

function SummerRaceBattleInfoView:IndexDetailSlotItem(arg_40_1, arg_40_2)
	local var_40_0 = self.detailSlotList_[arg_40_1] or self.rewardList_[arg_40_1]

	if var_40_0 ~= nil then
		var_40_0.isSelected = var_0_10("detail", arg_40_1, var_40_0) == self.selectedSlotKey_
	end

	arg_40_2:SetData(var_40_0, arg_40_1, handler(self, self.OnDetailSlotAction2))
end

function SummerRaceBattleInfoView:IndexRewardItem(arg_41_1, arg_41_2)
	if self.rewardList_[arg_41_1] == nil then
		return
	end

	arg_41_2:SetData({
		id = self.rewardList_[arg_41_1].itemId,
		number = self.rewardList_[arg_41_1].rewardCount,
		iconPath = self.rewardList_[arg_41_1].iconPath,
		rewardData = self.rewardList_[arg_41_1],
		clickFun = handler(self, self.OnRewardClick)
	})
end

function SummerRaceBattleInfoView:IndexStatusSlotItem(arg_42_1, arg_42_2)
	local var_42_0 = self.statusSlotList_[arg_42_1]

	if self.statusSlotList_[arg_42_1] ~= nil then
		var_42_0.isSelected = var_0_10("status", arg_42_1, var_42_0) == self.selectedSlotKey_
	end

	arg_42_2:SetData(var_42_0, arg_42_1, handler(self, self.OnDetailSlotAction))
end

function SummerRaceBattleInfoView:OnEnemyWaveAction(arg_43_1, arg_43_2, arg_43_3)
	self:HideTips()
	self.enemyWaveHandler_(arg_43_1, arg_43_2, arg_43_3)
end

function SummerRaceBattleInfoView:OnDetailSlotAction(arg_44_1, arg_44_2, arg_44_3)
	if arg_44_3 == "select" then
		if var_0_21(self, self.tipsController_, arg_44_2, 1) then
			self:SetSelectedSlot("status", arg_44_1, arg_44_2)
		else
			self:ClearSelectedSlot()
		end
	end
end

function SummerRaceBattleInfoView:OnDetailSlotAction2(arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	if arg_45_3 == "select" then
		if var_0_21(self, self.tipsController_, arg_45_2, 2, arg_45_4) then
			self:SetSelectedSlot("detail", arg_45_1, arg_45_2)
		else
			self:ClearSelectedSlot()
		end
	end
end

function SummerRaceBattleInfoView:OnRewardClick(arg_46_1)
	if arg_46_1 == nil then
		return
	end

	self:HideTips()
	self.rewardClickHandler_(arg_46_1.rewardData or arg_46_1.id)
end

function SummerRaceBattleInfoView:HideTips(arg_47_1)
	if self.tipsController_ ~= nil then
		self.tipsController_:SetSelectedState("none")
	end

	self:ClearSelectedSlot(arg_47_1)
end

function SummerRaceBattleInfoView:SetSelectedSlot(arg_48_1, arg_48_2, arg_48_3)
	self.selectedSlotKey_ = var_0_10(arg_48_1, arg_48_2, arg_48_3)

	self:RefreshSlotSelections()
end

function SummerRaceBattleInfoView:ClearSelectedSlot(arg_49_1)
	if self.selectedSlotKey_ == "" then
		return
	end

	self.selectedSlotKey_ = ""

	if arg_49_1 ~= true then
		self:RefreshSlotSelections()
	end
end

function SummerRaceBattleInfoView:RefreshSlotSelections()
	var_0_22(self.detailSlotList_, self.selectedSlotKey_, "detail")
	var_0_22(self.statusSlotList_, self.selectedSlotKey_, "status")

	if self.detailEquipSlotItemList_ ~= nil then
		self.detailEquipSlotItemList_:StartScroll(#self.detailSlotList_)
	end

	if self.statusEquipItemList_ ~= nil then
		self.statusEquipItemList_:StartScroll(#self.statusSlotList_)
	end
end

function SummerRaceBattleInfoView:GetVehicleRootGo()
	return self.battleInfoCarRootGo_
end

function SummerRaceBattleInfoView:GetDefaultTexts()
	return self.defaultTexts_
end

function SummerRaceBattleInfoView:SetBattleInfoText(arg_53_1, arg_53_2, arg_53_3)
	self.stageNameText_.text = tostring(arg_53_1 or "")
	self.stageIndexText_.text = tostring(arg_53_2 or "")
	self.stageDescText_.text = tostring(arg_53_3 or "")
end

function SummerRaceBattleInfoView:ResetBattleInfoText()
	self:SetBattleInfoText(self.defaultTexts_.stageName, self.defaultTexts_.stageIndex, self.defaultTexts_.stageDesc)
end

function SummerRaceBattleInfoView:PlayOpenAnim()
	if self.openAnimatorEnabled_ ~= false then
		var_0_24(self.ani_)
	end

	if self.openAdminSpineEnabled_ ~= false then
		var_0_28(self)
	end
end

function SummerRaceBattleInfoView:SetOpenAnimEnabled(arg_56_1)
	local var_56_0 = arg_56_1 == true

	self.openAnimatorEnabled_ = arg_56_1 == true
	self.openAdminSpineEnabled_ = var_56_0

	if self.ani_ ~= nil then
		self.ani_.enabled = var_56_0
	end
end

function SummerRaceBattleInfoView:ApplyBuildSnapshot(arg_57_1, arg_57_2, arg_57_3)
	local var_57_0 = arg_57_1 or {}

	self.infoVehicleSnapshot_ = var_57_0

	local var_57_1 = var_57_0.costSummary or {}

	self.detailSlotList_ = {}

	for iter_57_0 = 1, #(var_57_0.slotSummary or {}) do
		local var_57_2 = var_0_8(var_57_0.slotSummary[iter_57_0])

		if var_57_2 ~= nil then
			var_57_2.interactionMode = "inspect"
			var_57_2.itemClickEnabled = true
			var_57_2.showEquippedIcon = true
			self.detailSlotList_[iter_57_0] = var_57_2
		end
	end

	var_0_22(self.detailSlotList_, self.selectedSlotKey_, "detail")

	self.hpText_.text = tostring(var_57_0.hp or "")
	self.costText_.text = (var_57_1.totalCost ~= nil or var_57_1.budgetCost ~= nil) and string.format("%s/%s", tostring(var_57_1.totalCost or 0), tostring(var_57_1.budgetCost or 0)) or tostring((not var_57_0.totalCost or nil) and "")
	arg_57_2.interactable = var_57_1.isOverflow ~= true

	self.detailEquipSlotItemList_:StartScroll(#self.detailSlotList_)

	self.statusSlotList_ = var_0_9(var_57_0)

	var_0_22(self.statusSlotList_, self.selectedSlotKey_, "status")

	if self.statusEquipItemList_ ~= nil then
		self.statusEquipItemList_:StartScroll(#self.statusSlotList_)
	end

	var_0_29(self, arg_57_3)
end

function SummerRaceBattleInfoView:ApplyEnemyWaveList(arg_58_1)
	self.enemyWaveList_ = arg_58_1 or {}

	self.enemyWaveItemList_:StartScroll(#self.enemyWaveList_)
end

function SummerRaceBattleInfoView:ApplyRewardList(arg_59_1)
	self.rewardList_ = arg_59_1 or {}

	self.rewardItemList_:StartScroll(#self.rewardList_)
end

function SummerRaceBattleInfoView:SetMode(arg_60_1)
	self.currentMode_ = arg_60_1

	self.modeController_:SetSelectedState(arg_60_1)
end

function SummerRaceBattleInfoView:ApplyStageDetailModel(arg_61_1)
	self:SetBattleInfoText(arg_61_1.stageInfo.stageName, arg_61_1.stageInfo.stageIndex, arg_61_1.stageInfo.stageDesc)
	self:ApplyBuildSnapshot(arg_61_1.vehicleSnapshot, self.mainStartBtn_, arg_61_1.vehicleDisplay)

	local var_61_0 = var_0_23(arg_61_1.rewardList)

	if #var_61_0 > 0 then
		self.detailSlotList_ = var_61_0

		var_0_22(self.detailSlotList_, self.selectedSlotKey_, "detail")
		self.detailEquipSlotItemList_:StartScroll(#self.detailSlotList_)
	end

	self:ApplyEnemyWaveList(arg_61_1.enemyWaves)
	self:ApplyRewardList(arg_61_1.rewardList)

	self.mainStartBtn_.interactable = arg_61_1.stageInfo.canStartBattle ~= false and self.mainStartBtn_.interactable

	self:SetMode(arg_61_1.stageInfo.modeState or "main")
	var_0_30(self, arg_61_1.stageInfo)
end

function SummerRaceBattleInfoView:ApplyChallengeModel(arg_62_1)
	local var_62_0 = arg_62_1.stageInfo or {}

	self:SetBattleInfoText(var_62_0.stageName, var_62_0.stageIndex, var_62_0.stageDesc)
	self:ApplyEnemyWaveList(arg_62_1.enemyWaves or {})
	self:ApplyRewardList(arg_62_1.rewardList or {})

	self.stageDescText_.text = tostring(arg_62_1.ruleText or var_62_0.stageDesc or self.defaultTexts_.stageDesc or "")

	if arg_62_1.hasChallengeRecord == true then
		self.bestScoreText_.text = tostring(arg_62_1.bestScore or "")
		self.bestWaveText_.text = tostring(arg_62_1.bestWave or "")
	else
		self.bestScoreText_.text = GetTips("NO_RECORD")
		self.bestWaveText_.text = ""
	end

	self:ApplyBuildSnapshot(arg_62_1.currentBuild, self.challengeStartBtn_, arg_62_1.vehicleDisplay)
	self:SetMode("challenge")
	var_0_30(self, var_62_0)
end

function SummerRaceBattleInfoView:OnExit()
	var_0_26(self)
	self:HideTips(true)
end

function SummerRaceBattleInfoView:Dispose()
	var_0_26(self)
	self:HideTips(true)
	manager.redPoint:unbindUIandKey(self.modifyBtn_.transform, var_0_7())

	if self.enemyWaveItemList_ then
		self.enemyWaveItemList_:Dispose()

		self.enemyWaveItemList_ = nil
	end

	if self.detailEquipSlotItemList_ then
		self.detailEquipSlotItemList_:Dispose()

		self.detailEquipSlotItemList_ = nil
	end

	if self.rewardItemList_ then
		self.rewardItemList_:Dispose()

		self.rewardItemList_ = nil
	end

	if self.statusEquipItemList_ then
		self.statusEquipItemList_:Dispose()

		self.statusEquipItemList_ = nil
	end

	if self.propertiesItemPrefab_ ~= nil then
		Asset.Unload(var_0_6)

		self.propertiesItemPrefab_ = nil
	end

	if self.bodyTipsView_ then
		self.bodyTipsView_:Dispose()

		self.bodyTipsView_ = nil
	end

	if self.weaponTipsView_ then
		self.weaponTipsView_:Dispose()

		self.weaponTipsView_ = nil
	end

	if self.equipTipsView_ then
		self.equipTipsView_:Dispose()

		self.equipTipsView_ = nil
	end

	if self.weaponTipsView2_ then
		self.weaponTipsView2_:Dispose()

		self.weaponTipsView2_ = nil
	end

	if self.equipTipsView2_ then
		self.equipTipsView2_:Dispose()

		self.equipTipsView2_ = nil
	end

	self.adminSpine_ = nil
	self.adminSpineGo_ = nil
	self.adminPosController_ = nil
	self.clearStateController_ = nil

	self:RemoveAllListeners()
	SummerRaceBattleInfoView.super.Dispose(self)
end

return SummerRaceBattleInfoView
