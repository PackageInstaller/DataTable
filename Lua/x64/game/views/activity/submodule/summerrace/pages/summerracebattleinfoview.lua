local var_0_0 = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceEnemyWaveItemView")
local var_0_1 = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceEquipItemView")
local var_0_2 = import("game.views.common.CommonItemView")
local var_0_3 = class("SummerRaceBattleInfoView", ReduxView)
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

	for iter_3_0 = 1, #(arg_3_0 and arg_3_0.slotSummary or {}) do
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
	local var_4_2 = tostring(arg_4_2.itemId or "")

	return table.concat({
		tostring(arg_4_0),
		tostring(arg_4_1),
		var_4_0,
		var_4_1,
		var_4_2
	}, "|")
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

	return {
		title = tostring(arg_9_0.bodyName or ""),
		desc = tostring(arg_9_0.desc or arg_9_0.bodyDesc or ""),
		hpText = var_0_12(arg_9_0.hp, 0),
		costText = var_0_12(arg_9_0.cost, 0)
	}
end

local function var_0_16(arg_10_0)
	if arg_10_0 == nil then
		return nil
	end

	local var_10_0 = arg_10_0.properties and arg_10_0.properties[1] or nil

	return {
		title = tostring(arg_10_0.title or ""),
		desc = tostring(arg_10_0.desc or ""),
		hpText = var_10_0 and var_10_0.value or 0,
		costText = arg_10_0.cost or 0
	}
end

local function var_0_17(arg_11_0, arg_11_1)
	if arg_11_0 == nil or arg_11_0.bodyTipsGo_ == nil or arg_11_1 == nil then
		return nil
	end

	local var_11_0 = arg_11_0.bodyTipsGo_.transform.parent

	if var_11_0 == nil then
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

	local var_14_2 = var_14_0.x - var_14_1.x
	local var_14_3 = arg_14_0.bodyTipsGo_.transform.localPosition

	arg_14_0.bodyTipsGo_.transform.localPosition = Vector3.New(var_14_3.x + var_14_2, var_14_3.y, var_14_3.z)
end

function var_0_3.RefreshOptionInfoPanel(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == nil or arg_15_2 == nil then
		return
	end

	arg_15_1:SetData(arg_15_2)
end

local function var_0_21(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_2
	local var_16_1 = var_16_0 and var_16_0.rewardData or nil
	local var_16_2

	if var_16_0 ~= nil and var_16_0.itemId ~= nil and tostring(var_16_0.itemId) ~= "" then
		var_16_2 = var_0_14(SummerRaceData:GetOptionDefById(var_16_0.itemId))
	end

	if var_16_2 == nil and var_16_1 ~= nil and var_16_1.rewardType == 3 then
		local var_16_3 = var_0_13(SummerRaceData:GetBodyDefs(), var_16_1.itemId)

		arg_16_0.tipsController_:SetSelectedState("tips_s")
		arg_16_0.bodyTipsView_:SetData(var_0_15(var_16_3))
		var_0_20(arg_16_0, arg_16_4)

		return true
	end

	if var_16_2 == nil and var_16_1 ~= nil and var_16_1.rewardType ~= 3 then
		arg_16_0.tipsController_:SetSelectedState("none")

		return false
	end

	if var_16_2 ~= nil then
		if var_16_1 ~= nil then
			arg_16_0.tipsController_:SetSelectedState("tips_s")
			arg_16_0.bodyTipsView_:SetData(var_0_16(var_16_2))
			var_0_20(arg_16_0, arg_16_4)

			return true
		end

		if arg_16_3 == 1 then
			if var_16_2.panelType == "equip" then
				arg_16_0.tipsController_:SetSelectedState("tips_m")
				arg_16_0:RefreshOptionInfoPanel(arg_16_0.equipTipsView_, var_16_2)
			else
				arg_16_0.tipsController_:SetSelectedState("tips_l")
				arg_16_0:RefreshOptionInfoPanel(arg_16_0.weaponTipsView_, var_16_2)
			end
		elseif var_16_2.panelType == "equip" then
			arg_16_0.tipsController_:SetSelectedState("tips_m_2")
			arg_16_0:RefreshOptionInfoPanel(arg_16_0.equipTipsView2_, var_16_2)
		else
			arg_16_0.tipsController_:SetSelectedState("tips_l_2")
			arg_16_0:RefreshOptionInfoPanel(arg_16_0.weaponTipsView2_, var_16_2)
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

		if var_17_0 ~= nil then
			var_17_0.isSelected = var_0_10(arg_17_2, iter_17_0, var_17_0) == arg_17_1
		end
	end
end

local function var_0_23(arg_18_0)
	local var_18_0 = {}

	for iter_18_0 = 1, #(arg_18_0 or {}) do
		local var_18_1 = arg_18_0[iter_18_0]

		if var_18_1 ~= nil and var_18_1.itemId ~= nil and tostring(var_18_1.itemId) ~= "" then
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
		local var_22_2

		local function var_22_3()
			var_0_26(arg_22_0)
			arg_22_3()
		end

		arg_22_0.adminSpineCompleteHandler_ = var_22_3
		arg_22_0.adminSpine_.AnimationState.Complete = arg_22_0.adminSpine_.AnimationState.Complete + var_22_3
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

function var_0_3.SyncAdminPos(arg_29_0, arg_29_1)
	var_0_29(arg_29_0, arg_29_1)
end

function var_0_3.OnCtor(arg_30_0, arg_30_1)
	arg_30_0.gameObject_ = arg_30_1
	arg_30_0.transform_ = arg_30_1.transform

	arg_30_0:Init()
end

function var_0_3.Init(arg_31_0)
	arg_31_0:BindCfgUI()

	arg_31_0.enemyWaveList_ = {}
	arg_31_0.detailSlotList_ = {}
	arg_31_0.statusSlotList_ = {}
	arg_31_0.rewardList_ = {}
	arg_31_0.selectedSlotKey_ = ""
	arg_31_0.enemyWaveItemList_ = LuaList.New(handler(arg_31_0, arg_31_0.IndexEnemyWaveItem), arg_31_0.enemyWaveListGo_, var_0_0)
	arg_31_0.detailEquipSlotItemList_ = LuaList.New(handler(arg_31_0, arg_31_0.IndexDetailSlotItem), arg_31_0.equipListGo_, var_0_1)
	arg_31_0.rewardItemList_ = LuaList.New(handler(arg_31_0, arg_31_0.IndexRewardItem), arg_31_0.rewardListGo_, var_0_2)
	arg_31_0.statusEquipItemList_ = LuaList.New(handler(arg_31_0, arg_31_0.IndexStatusSlotItem), arg_31_0.statusEquipListGo_, var_0_1)
	arg_31_0.modeController_ = arg_31_0.controllerEx_:GetController("mode")
	arg_31_0.tipsController_ = arg_31_0.controllerEx_:GetController("tips")
	arg_31_0.adminPosController_ = arg_31_0.controllerEx_:GetController("adminPos")
	arg_31_0.clearStateController_ = arg_31_0.controllerEx_:GetController("clearState")
	arg_31_0.adminSpineGo_ = var_0_25(arg_31_0)
	arg_31_0.adminSpine_ = arg_31_0.adminSpineGo_ and arg_31_0.adminSpineGo_:GetComponent(typeof(Spine.Unity.SkeletonGraphic)) or nil
	arg_31_0.propertiesItemPrefab_ = Asset.Load(var_0_6)
	arg_31_0.bodyTipsView_ = SummerRaceBodyTipsView.New(arg_31_0.bodyTipsGo_)
	arg_31_0.weaponTipsView_ = SummerRaceOptionTipsView.New(arg_31_0.weaponTipsGo_, arg_31_0.propertiesItemPrefab_)
	arg_31_0.equipTipsView_ = SummerRaceOptionTipsView.New(arg_31_0.equipTipsGo_, arg_31_0.propertiesItemPrefab_)
	arg_31_0.weaponTipsView2_ = SummerRaceOptionTipsView.New(arg_31_0.weaponTipsGo2_, arg_31_0.propertiesItemPrefab_)
	arg_31_0.equipTipsView2_ = SummerRaceOptionTipsView.New(arg_31_0.equipTipsGo2_, arg_31_0.propertiesItemPrefab_)
	arg_31_0.defaultTexts_ = {
		stageName = arg_31_0.stageNameText_.text,
		stageIndex = arg_31_0.stageIndexText_.text,
		stageDesc = arg_31_0.stageDescText_.text
	}

	arg_31_0:AddUIListener()
	manager.redPoint:bindUIandKey(arg_31_0.modifyBtn_.transform, var_0_7())
end

function var_0_3.SetHandlers(arg_32_0, arg_32_1)
	arg_32_0.modifyHandler_ = arg_32_1.modify
	arg_32_0.rankHandler_ = arg_32_1.rank
	arg_32_0.stageStartHandler_ = arg_32_1.stageStart
	arg_32_0.challengeStartHandler_ = arg_32_1.challengeStart
	arg_32_0.enemyWaveHandler_ = arg_32_1.enemyWave
	arg_32_0.detailSlotHandler_ = arg_32_1.detailSlot
	arg_32_0.rewardClickHandler_ = arg_32_1.rewardClick
end

function var_0_3.AddUIListener(arg_33_0)
	arg_33_0:AddBtnListener(arg_33_0.modifyBtn_, nil, function()
		arg_33_0:HideTips()
		arg_33_0.modifyHandler_()
	end)
	arg_33_0:AddBtnListener(arg_33_0.rankBtn_, nil, function()
		arg_33_0:HideTips()
		arg_33_0.rankHandler_()
	end)
	arg_33_0:AddBtnListener(arg_33_0.mainStartBtn_, nil, function()
		arg_33_0:HideTips()
		arg_33_0.stageStartHandler_()
	end)
	arg_33_0:AddBtnListener(arg_33_0.challengeStartBtn_, nil, function()
		arg_33_0:HideTips()
		arg_33_0.challengeStartHandler_()
	end)
	arg_33_0:AddBtnListener(arg_33_0.tipsBgBtn_, nil, function()
		arg_33_0:HideTips()
	end)
end

function var_0_3.IndexEnemyWaveItem(arg_39_0, arg_39_1, arg_39_2)
	arg_39_2:SetData(arg_39_0.enemyWaveList_[arg_39_1], arg_39_1, handler(arg_39_0, arg_39_0.OnEnemyWaveAction))
end

function var_0_3.IndexDetailSlotItem(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0.detailSlotList_[arg_40_1] or arg_40_0.rewardList_[arg_40_1]

	if var_40_0 ~= nil then
		var_40_0.isSelected = var_0_10("detail", arg_40_1, var_40_0) == arg_40_0.selectedSlotKey_
	end

	arg_40_2:SetData(var_40_0, arg_40_1, handler(arg_40_0, arg_40_0.OnDetailSlotAction2))
end

function var_0_3.IndexRewardItem(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0.rewardList_[arg_41_1]

	if var_41_0 == nil then
		return
	end

	arg_41_2:SetData({
		id = var_41_0.itemId,
		number = var_41_0.rewardCount,
		iconPath = var_41_0.iconPath,
		rewardData = var_41_0,
		clickFun = handler(arg_41_0, arg_41_0.OnRewardClick)
	})
end

function var_0_3.IndexStatusSlotItem(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0.statusSlotList_[arg_42_1]

	if var_42_0 ~= nil then
		var_42_0.isSelected = var_0_10("status", arg_42_1, var_42_0) == arg_42_0.selectedSlotKey_
	end

	arg_42_2:SetData(var_42_0, arg_42_1, handler(arg_42_0, arg_42_0.OnDetailSlotAction))
end

function var_0_3.OnEnemyWaveAction(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	arg_43_0:HideTips()
	arg_43_0.enemyWaveHandler_(arg_43_1, arg_43_2, arg_43_3)
end

function var_0_3.OnDetailSlotAction(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	if arg_44_3 == "select" then
		if var_0_21(arg_44_0, arg_44_0.tipsController_, arg_44_2, 1) then
			arg_44_0:SetSelectedSlot("status", arg_44_1, arg_44_2)
		else
			arg_44_0:ClearSelectedSlot()
		end
	end
end

function var_0_3.OnDetailSlotAction2(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	if arg_45_3 == "select" then
		if var_0_21(arg_45_0, arg_45_0.tipsController_, arg_45_2, 2, arg_45_4) then
			arg_45_0:SetSelectedSlot("detail", arg_45_1, arg_45_2)
		else
			arg_45_0:ClearSelectedSlot()
		end
	end
end

function var_0_3.OnRewardClick(arg_46_0, arg_46_1)
	if arg_46_1 == nil then
		return
	end

	arg_46_0:HideTips()
	arg_46_0.rewardClickHandler_(arg_46_1.rewardData or arg_46_1.id)
end

function var_0_3.HideTips(arg_47_0, arg_47_1)
	if arg_47_0.tipsController_ ~= nil then
		arg_47_0.tipsController_:SetSelectedState("none")
	end

	arg_47_0:ClearSelectedSlot(arg_47_1)
end

function var_0_3.SetSelectedSlot(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	arg_48_0.selectedSlotKey_ = var_0_10(arg_48_1, arg_48_2, arg_48_3)

	arg_48_0:RefreshSlotSelections()
end

function var_0_3.ClearSelectedSlot(arg_49_0, arg_49_1)
	if arg_49_0.selectedSlotKey_ == "" then
		return
	end

	arg_49_0.selectedSlotKey_ = ""

	if arg_49_1 ~= true then
		arg_49_0:RefreshSlotSelections()
	end
end

function var_0_3.RefreshSlotSelections(arg_50_0)
	var_0_22(arg_50_0.detailSlotList_, arg_50_0.selectedSlotKey_, "detail")
	var_0_22(arg_50_0.statusSlotList_, arg_50_0.selectedSlotKey_, "status")

	if arg_50_0.detailEquipSlotItemList_ ~= nil then
		arg_50_0.detailEquipSlotItemList_:StartScroll(#arg_50_0.detailSlotList_)
	end

	if arg_50_0.statusEquipItemList_ ~= nil then
		arg_50_0.statusEquipItemList_:StartScroll(#arg_50_0.statusSlotList_)
	end
end

function var_0_3.GetVehicleRootGo(arg_51_0)
	return arg_51_0.battleInfoCarRootGo_
end

function var_0_3.GetDefaultTexts(arg_52_0)
	return arg_52_0.defaultTexts_
end

function var_0_3.SetBattleInfoText(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	arg_53_0.stageNameText_.text = tostring(arg_53_1 or "")
	arg_53_0.stageIndexText_.text = tostring(arg_53_2 or "")
	arg_53_0.stageDescText_.text = tostring(arg_53_3 or "")
end

function var_0_3.ResetBattleInfoText(arg_54_0)
	arg_54_0:SetBattleInfoText(arg_54_0.defaultTexts_.stageName, arg_54_0.defaultTexts_.stageIndex, arg_54_0.defaultTexts_.stageDesc)
end

function var_0_3.PlayOpenAnim(arg_55_0)
	if arg_55_0.openAnimatorEnabled_ ~= false then
		var_0_24(arg_55_0.ani_)
	end

	if arg_55_0.openAdminSpineEnabled_ ~= false then
		var_0_28(arg_55_0)
	end
end

function var_0_3.SetOpenAnimEnabled(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_1 == true

	arg_56_0.openAnimatorEnabled_ = var_56_0
	arg_56_0.openAdminSpineEnabled_ = var_56_0

	if arg_56_0.ani_ ~= nil then
		arg_56_0.ani_.enabled = var_56_0
	end
end

function var_0_3.ApplyBuildSnapshot(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	local var_57_0 = arg_57_1 or {}

	arg_57_0.infoVehicleSnapshot_ = var_57_0

	local var_57_1 = var_57_0.costSummary or {}

	arg_57_0.detailSlotList_ = {}

	for iter_57_0 = 1, #(var_57_0.slotSummary or {}) do
		local var_57_2 = var_0_8(var_57_0.slotSummary[iter_57_0])

		if var_57_2 ~= nil then
			var_57_2.interactionMode = "inspect"
			var_57_2.itemClickEnabled = true
			var_57_2.showEquippedIcon = true
			arg_57_0.detailSlotList_[iter_57_0] = var_57_2
		end
	end

	var_0_22(arg_57_0.detailSlotList_, arg_57_0.selectedSlotKey_, "detail")

	arg_57_0.hpText_.text = tostring(var_57_0.hp or "")

	if var_57_1.totalCost ~= nil or var_57_1.budgetCost ~= nil then
		arg_57_0.costText_.text = string.format("%s/%s", tostring(var_57_1.totalCost or 0), tostring(var_57_1.budgetCost or 0))
	else
		arg_57_0.costText_.text = tostring(var_57_0.totalCost or "")
	end

	arg_57_2.interactable = var_57_1.isOverflow ~= true

	arg_57_0.detailEquipSlotItemList_:StartScroll(#arg_57_0.detailSlotList_)

	arg_57_0.statusSlotList_ = var_0_9(var_57_0)

	var_0_22(arg_57_0.statusSlotList_, arg_57_0.selectedSlotKey_, "status")

	if arg_57_0.statusEquipItemList_ ~= nil then
		arg_57_0.statusEquipItemList_:StartScroll(#arg_57_0.statusSlotList_)
	end

	var_0_29(arg_57_0, arg_57_3)
end

function var_0_3.ApplyEnemyWaveList(arg_58_0, arg_58_1)
	arg_58_0.enemyWaveList_ = arg_58_1 or {}

	arg_58_0.enemyWaveItemList_:StartScroll(#arg_58_0.enemyWaveList_)
end

function var_0_3.ApplyRewardList(arg_59_0, arg_59_1)
	arg_59_0.rewardList_ = arg_59_1 or {}

	arg_59_0.rewardItemList_:StartScroll(#arg_59_0.rewardList_)
end

function var_0_3.SetMode(arg_60_0, arg_60_1)
	arg_60_0.currentMode_ = arg_60_1

	arg_60_0.modeController_:SetSelectedState(arg_60_1)
end

function var_0_3.ApplyStageDetailModel(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_1.stageInfo

	arg_61_0:SetBattleInfoText(var_61_0.stageName, var_61_0.stageIndex, var_61_0.stageDesc)
	arg_61_0:ApplyBuildSnapshot(arg_61_1.vehicleSnapshot, arg_61_0.mainStartBtn_, arg_61_1.vehicleDisplay)

	local var_61_1 = var_0_23(arg_61_1.rewardList)

	if #var_61_1 > 0 then
		arg_61_0.detailSlotList_ = var_61_1

		var_0_22(arg_61_0.detailSlotList_, arg_61_0.selectedSlotKey_, "detail")
		arg_61_0.detailEquipSlotItemList_:StartScroll(#arg_61_0.detailSlotList_)
	end

	arg_61_0:ApplyEnemyWaveList(arg_61_1.enemyWaves)
	arg_61_0:ApplyRewardList(arg_61_1.rewardList)

	arg_61_0.mainStartBtn_.interactable = var_61_0.canStartBattle ~= false and arg_61_0.mainStartBtn_.interactable

	arg_61_0:SetMode(var_61_0.modeState or "main")
	var_0_30(arg_61_0, var_61_0)
end

function var_0_3.ApplyChallengeModel(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_1.stageInfo or {}

	arg_62_0:SetBattleInfoText(var_62_0.stageName, var_62_0.stageIndex, var_62_0.stageDesc)
	arg_62_0:ApplyEnemyWaveList(arg_62_1.enemyWaves or {})
	arg_62_0:ApplyRewardList(arg_62_1.rewardList or {})

	arg_62_0.stageDescText_.text = tostring(arg_62_1.ruleText or var_62_0.stageDesc or arg_62_0.defaultTexts_.stageDesc or "")

	if arg_62_1.hasChallengeRecord == true then
		arg_62_0.bestScoreText_.text = tostring(arg_62_1.bestScore or "")
		arg_62_0.bestWaveText_.text = tostring(arg_62_1.bestWave or "")
	else
		arg_62_0.bestScoreText_.text = GetTips("NO_RECORD")
		arg_62_0.bestWaveText_.text = ""
	end

	arg_62_0:ApplyBuildSnapshot(arg_62_1.currentBuild, arg_62_0.challengeStartBtn_, arg_62_1.vehicleDisplay)
	arg_62_0:SetMode("challenge")
	var_0_30(arg_62_0, var_62_0)
end

function var_0_3.OnExit(arg_63_0)
	var_0_26(arg_63_0)
	arg_63_0:HideTips(true)
end

function var_0_3.Dispose(arg_64_0)
	var_0_26(arg_64_0)
	arg_64_0:HideTips(true)
	manager.redPoint:unbindUIandKey(arg_64_0.modifyBtn_.transform, var_0_7())

	if arg_64_0.enemyWaveItemList_ then
		arg_64_0.enemyWaveItemList_:Dispose()

		arg_64_0.enemyWaveItemList_ = nil
	end

	if arg_64_0.detailEquipSlotItemList_ then
		arg_64_0.detailEquipSlotItemList_:Dispose()

		arg_64_0.detailEquipSlotItemList_ = nil
	end

	if arg_64_0.rewardItemList_ then
		arg_64_0.rewardItemList_:Dispose()

		arg_64_0.rewardItemList_ = nil
	end

	if arg_64_0.statusEquipItemList_ then
		arg_64_0.statusEquipItemList_:Dispose()

		arg_64_0.statusEquipItemList_ = nil
	end

	if arg_64_0.propertiesItemPrefab_ ~= nil then
		Asset.Unload(var_0_6)

		arg_64_0.propertiesItemPrefab_ = nil
	end

	if arg_64_0.bodyTipsView_ then
		arg_64_0.bodyTipsView_:Dispose()

		arg_64_0.bodyTipsView_ = nil
	end

	if arg_64_0.weaponTipsView_ then
		arg_64_0.weaponTipsView_:Dispose()

		arg_64_0.weaponTipsView_ = nil
	end

	if arg_64_0.equipTipsView_ then
		arg_64_0.equipTipsView_:Dispose()

		arg_64_0.equipTipsView_ = nil
	end

	if arg_64_0.weaponTipsView2_ then
		arg_64_0.weaponTipsView2_:Dispose()

		arg_64_0.weaponTipsView2_ = nil
	end

	if arg_64_0.equipTipsView2_ then
		arg_64_0.equipTipsView2_:Dispose()

		arg_64_0.equipTipsView2_ = nil
	end

	arg_64_0.adminSpine_ = nil
	arg_64_0.adminSpineGo_ = nil
	arg_64_0.adminPosController_ = nil
	arg_64_0.clearStateController_ = nil

	arg_64_0:RemoveAllListeners()
	var_0_3.super.Dispose(arg_64_0)
end

return var_0_3
