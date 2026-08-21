local var_0_0 = class("TransitionSkillView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:BuildContext()
	arg_2_0:AddUIListeners()
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.context = {
		curTabIdx = 1,
		tabModule = TransitionSkillListTabModule.New(arg_3_0.tabModuleObj_)
	}
	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListObj_, TransitionSkillItem)
end

function var_0_0.InitContext(arg_4_0)
	arg_4_0.data = {
		curGiftPt = 0,
		curSelectID = 0,
		index = 1,
		heroID = 0,
		leftPt = 0,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT),
		list = {},
		useList = {},
		curUseList = {}
	}
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

local function var_0_1(arg_6_0, arg_6_1)
	return table.indexof(arg_6_1, arg_6_0)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.data.list[arg_7_1]
	local var_7_1 = arg_7_0.data.curUseList[var_7_0] or 1

	arg_7_2:RefreshUI(var_7_0, var_7_1)
	arg_7_2:SetUsed(arg_7_0:IsUsed(var_7_0))
	arg_7_2:SetSelect(arg_7_0.data.curSelectID == var_7_0)
	arg_7_2:SetRecommand(var_0_1(var_7_0, CultureGravureData:GetTransitionListByID(arg_7_0.data.heroID)[arg_7_0.data.index]))
	arg_7_2:RegistCallBack(function()
		arg_7_0:OnItemClick(var_7_0)
	end)
end

function var_0_0.AddUIListeners(arg_9_0)
	arg_9_0.context.tabModule:RegisterClickCallback(handler(arg_9_0, arg_9_0.OnTabClick))

	arg_9_0.tryToImproveTransitionGiftPtHandler_ = handler(arg_9_0, arg_9_0.OnTryToImproveTransitionGiftPt)

	manager.notify:RegistListener(IMPROVE_TRANSITION_GIFT_PT, arg_9_0.tryToImproveTransitionGiftPtHandler_)
end

function var_0_0.RenderView(arg_10_0, arg_10_1)
	arg_10_0:InitContext()

	arg_10_0.data.index = arg_10_1.index or 1
	arg_10_0.data.heroID = arg_10_1.heroID
	arg_10_0.data.type = arg_10_1.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_10_0.data.heroDataProxy = HeroViewDataProxy.New(arg_10_0.data.type)

	arg_10_0.context.tabModule:OnTabClick(arg_10_0.data.index)
end

function var_0_0.GetData(arg_11_0)
	arg_11_0:GetUseList()
	arg_11_0:GetCurUseList()
end

function var_0_0.GetUseList(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = arg_12_0:GetHeroTransition()

	arg_12_0.data.curGiftPt = 0

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = iter_12_1.slot_id

		var_12_0[var_12_2] = deepClone(iter_12_1.skill_list)

		if var_12_2 == arg_12_0.data.index then
			arg_12_0.data.curGiftPt = iter_12_1.talent_points

			break
		end
	end

	arg_12_0.data.useList = var_12_0
end

function var_0_0.GetCurUseList(arg_13_0)
	local var_13_0 = {
		all = {}
	}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.data.useList[arg_13_0.data.index] or {}) do
		local var_13_1 = iter_13_1.skill_id

		var_13_0[var_13_1] = iter_13_1.skill_level

		table.insert(var_13_0.all, var_13_1)
	end

	arg_13_0.data.curUseList = var_13_0
end

function var_0_0.RefreshUI(arg_14_0)
	arg_14_0:RefreshList()
	arg_14_0:RefreshType()
end

function var_0_0.RefreshList(arg_15_0)
	local var_15_0 = HeroCfg[arg_15_0.data.heroID].hero_equip_skill[arg_15_0.data.index] or {}

	table.sort(var_15_0, function(arg_16_0, arg_16_1)
		if arg_15_0:IsUsed(arg_16_0) ~= arg_15_0:IsUsed(arg_16_1) then
			return arg_15_0:IsUsed(arg_16_0)
		end

		if arg_15_0:IsUsed(arg_16_0) and arg_15_0:IsUsed(arg_16_1) then
			local var_16_0 = arg_15_0.data.curUseList[arg_16_0]
			local var_16_1 = arg_15_0.data.curUseList[arg_16_1]

			if var_16_0 ~= var_16_1 then
				return var_16_1 < var_16_0
			end
		end

		return arg_16_0 < arg_16_1
	end)

	arg_15_0.data.list = var_15_0
	arg_15_0.data.curSelectID = arg_15_0.data.list[1]

	arg_15_0.scrollHelper_:StartScroll(#arg_15_0.data.list)
	arg_15_0:OnItemClick(arg_15_0.data.curSelectID)
end

function var_0_0.RefreshType(arg_17_0)
	arg_17_0.data.leftPt = arg_17_0.data.curGiftPt

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.data.curUseList.all) do
		arg_17_0.data.leftPt = arg_17_0.data.leftPt - arg_17_0.data.curUseList[iter_17_1]
	end

	local var_17_0 = #arg_17_0.data.curUseList.all

	arg_17_0.restrictTxt_.text = table.concat({
		GetTips("JUMP_EQUIP_UPPER_DESC"),
		var_17_0,
		"/",
		GameSetting.exclusive_skill_use_num_max.value[1]
	})

	arg_17_0:DispatchJumpElementChangeEmitter()
end

function var_0_0.IsUsed(arg_18_0, arg_18_1)
	return arg_18_0.data.curUseList[arg_18_1] ~= nil
end

function var_0_0.IsSelected(arg_19_0, arg_19_1)
	return arg_19_1 == arg_19_0.data.curSelectID
end

function var_0_0.SaveDataCheckNet(arg_20_0, arg_20_1)
	if manager.net ~= nil and manager.net.tcpConnection_ ~= nil then
		local var_20_0 = manager.net.tcpConnection_:GetMachineState()

		if var_20_0 and (var_20_0 == "connected" or var_20_0 == "connecting") then
			arg_20_0:SaveData(arg_20_1)
		end
	end
end

function var_0_0.SaveData(arg_21_0, arg_21_1)
	local var_21_0 = {}

	if not arg_21_0.data.curUseList or not arg_21_0.data.curUseList.all then
		return
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.data.curUseList.all) do
		var_21_0[iter_21_0] = {
			skill_id = iter_21_1,
			skill_level = arg_21_0.data.curUseList[iter_21_1]
		}
	end

	HeroAction.TryToSaveTransitionSkill(arg_21_0.data.heroID, arg_21_0.data.index, var_21_0, arg_21_1)
end

function var_0_0.OnTryToImproveTransitionGiftPt(arg_22_0)
	ShowTips("EXCLUSIVE_SKILL_POINT_UP")
	arg_22_0:GetUseList()
	arg_22_0.scrollHelper_:Refresh()
	arg_22_0:RefreshType()
end

function var_0_0.OnExit(arg_23_0)
	return
end

function var_0_0.Dispose(arg_24_0)
	manager.notify:RemoveListener(IMPROVE_TRANSITION_GIFT_PT, arg_24_0.tryToImproveTransitionGiftPtHandler_)
	arg_24_0:RemoveAllEventListener()
	arg_24_0:RemoveAllListeners()

	if arg_24_0.scrollHelper_ then
		arg_24_0.scrollHelper_:Dispose()

		arg_24_0.scrollHelper_ = nil
	end

	arg_24_0.context.tabModule:Dispose()

	arg_24_0.context.tabModule = nil

	var_0_0.super.Dispose(arg_24_0)
end

function var_0_0.RegisterTabListener(arg_25_0, arg_25_1)
	arg_25_0.context.tabSwitchEmitter = arg_25_1
end

function var_0_0.RegisterItemClickListener(arg_26_0, arg_26_1)
	arg_26_0.context.itemClickEmitter = arg_26_1
end

function var_0_0.RegisterRefreshJumpElement(arg_27_0, arg_27_1)
	arg_27_0.context.jumpElementChangeEmitter = arg_27_1
end

function var_0_0.RegisterRefreshJumpSlotView(arg_28_0, arg_28_1)
	arg_28_0.context.jumpSlotRefreshEmitter = arg_28_1
end

function var_0_0.OnTabClick(arg_29_0, arg_29_1)
	arg_29_0:SaveData()

	arg_29_0.data.index = arg_29_1

	arg_29_0:GetData()
	arg_29_0:RefreshUI()
	arg_29_0:DispatchTabSwitchEmitter(arg_29_1)
end

function var_0_0.OnItemClick(arg_30_0, arg_30_1)
	arg_30_0.data.curSelectID = arg_30_1

	arg_30_0.scrollHelper_:Refresh()
	arg_30_0:DispatchItemClickEmitter(arg_30_1)
end

function var_0_0.DispatchTabSwitchEmitter(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.context.tabSwitchEmitter

	if var_31_0 then
		var_31_0(arg_31_1)
	end
end

function var_0_0.DispatchItemClickEmitter(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.context.itemClickEmitter

	if var_32_0 then
		var_32_0({
			skillID = arg_32_1,
			level = arg_32_0.data.curUseList[arg_32_1] or 1,
			equipped = arg_32_0:IsUsed(arg_32_1)
		})
	end
end

function var_0_0.DispatchJumpElementChangeEmitter(arg_33_0)
	local var_33_0 = arg_33_0.context.jumpElementChangeEmitter

	if var_33_0 then
		var_33_0({
			totalElement = arg_33_0.data.curGiftPt,
			leftElement = arg_33_0.data.leftPt
		})
	end
end

function var_0_0.DispatchJumpSlotRefreshEmitter(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.context.jumpSlotRefreshEmitter

	if var_34_0 then
		var_34_0(arg_34_0:GetSlotParam(arg_34_1))
	end
end

function var_0_0.OnSkillEquip(arg_35_0)
	if #arg_35_0.data.curUseList.all >= GameSetting.exclusive_skill_use_num_max.value[1] then
		ShowTips("EXCLUSIVE_SKILL_MAX")

		return
	end

	if arg_35_0.data.leftPt <= 0 then
		JumpTools.OpenPageByJump("transitionGiftPt", {
			isEnter = true,
			giftPt = arg_35_0.data.curGiftPt,
			heroID = arg_35_0.data.heroID,
			index = arg_35_0.data.index
		})
		arg_35_0:SaveData()

		return
	end

	arg_35_0.data.curUseList[arg_35_0.data.curSelectID] = 1

	table.insert(arg_35_0.data.curUseList.all, arg_35_0.data.curSelectID)
	arg_35_0.scrollHelper_:Refresh()
	arg_35_0:RefreshType()
	arg_35_0:DispatchItemClickEmitter(arg_35_0.data.curSelectID)
	arg_35_0:DispatchJumpSlotRefreshEmitter(arg_35_0.data.index)
	ShowTips("EXCLUSIVE_SKILL_LOAD")
	OperationRecorder.RecordButtonTouch({
		button_name = "exclusive_skill_use",
		hero_id = arg_35_0.data.heroID,
		pos = arg_35_0.data.index,
		exclusive_skill_list = string.format("{%s,%s}", arg_35_0.data.curSelectID, arg_35_0.data.curUseList[arg_35_0.data.curSelectID] or 1)
	})
end

function var_0_0.OnSkillExchange(arg_36_0)
	local var_36_0 = arg_36_0.data.curUseList
	local var_36_1 = arg_36_0.data.curSelectID

	OperationRecorder.RecordButtonTouch({
		button_name = "exclusive_skill_unload",
		hero_id = arg_36_0.data.heroID,
		pos = arg_36_0.data.index,
		exclusive_skill_list = string.format("{%s,%s}", var_36_1, var_36_0[var_36_1] or 1)
	})
	table.remove(var_36_0.all, table.indexof(var_36_0.all, var_36_1))

	var_36_0[var_36_1] = nil

	arg_36_0.scrollHelper_:Refresh()
	arg_36_0:RefreshType()
	arg_36_0:DispatchItemClickEmitter(arg_36_0.data.curSelectID)
	arg_36_0:DispatchJumpSlotRefreshEmitter(arg_36_0.data.index)
	ShowTips("EXCLUSIVE_SKILL_UNLOAD")
end

function var_0_0.OnSkillLevelUp(arg_37_0)
	if arg_37_0.data.leftPt <= 0 then
		JumpTools.OpenPageByJump("transitionGiftPt", {
			isEnter = true,
			giftPt = arg_37_0.data.curGiftPt,
			heroID = arg_37_0.data.heroID,
			index = arg_37_0.data.index
		})
		arg_37_0:SaveData()

		return
	end

	local var_37_0 = arg_37_0.data.curUseList
	local var_37_1 = arg_37_0.data.curSelectID

	var_37_0[var_37_1] = var_37_0[var_37_1] + 1

	arg_37_0.scrollHelper_:Refresh()
	arg_37_0:RefreshType()
	arg_37_0:DispatchItemClickEmitter(arg_37_0.data.curSelectID)
	arg_37_0:DispatchJumpSlotRefreshEmitter(arg_37_0.data.index)
	ShowTips("EXCLUSIVE_SKILL_LEVEL_UP")
	OperationRecorder.RecordButtonTouch({
		button_name = "exclusive_skill_lv_up",
		hero_id = arg_37_0.data.heroID,
		pos = arg_37_0.data.index,
		exclusive_skill_list = string.format("{%s,%s}", var_37_1, var_37_0[var_37_1] or 1)
	})
end

function var_0_0.ResetUseList(arg_38_0)
	arg_38_0.data.curUseList = {}
	arg_38_0.data.curUseList.all = {}

	arg_38_0.scrollHelper_:Refresh()
	arg_38_0:RefreshType()
	arg_38_0:DispatchItemClickEmitter(arg_38_0.data.curSelectID)
end

function var_0_0.GetCurGiftPoint(arg_39_0)
	return arg_39_0.data.curGiftPt
end

function var_0_0.GetSlotParam(arg_40_0, arg_40_1)
	local var_40_0 = {
		slotIdx = arg_40_1,
		heroId = arg_40_0.data.heroID,
		skills = {}
	}

	for iter_40_0, iter_40_1 in ipairs(arg_40_0.data.curUseList.all) do
		var_40_0.skills[iter_40_0] = {
			skillId = iter_40_1,
			level = arg_40_0.data.curUseList[iter_40_1]
		}
	end

	return var_40_0
end

function var_0_0.GetHeroData(arg_41_0)
	return arg_41_0.data.heroDataProxy:GetHeroData(arg_41_0.data.heroID)
end

function var_0_0.GetHeroTransition(arg_42_0)
	return arg_42_0.data.heroDataProxy:GetHeroTransitionInfoList(arg_42_0.data.heroID) or {}
end

function var_0_0.GetHeroEquip(arg_43_0)
	return arg_43_0.heroDataProxy:GetEquipInfoList(arg_43_0.data.heroID)
end

return var_0_0
