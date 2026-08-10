local var_0_0 = class("EquipDecomposeView", ReduxView)
local var_0_1 = import("game.tools.HeroTools")
local var_0_2 = import("game.tools.EquipTools")

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Bag/SplitEquipUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.equipItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexEquipItem), arg_4_0.uiListGo_, CommonItemView)
	arg_4_0.rewardItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexRewardItem), arg_4_0.rewardListGo_, CommonItemView)
	arg_4_0.equipSkillView_ = EquipNewSkillInfoView.New(arg_4_0.skillPopGo_)
	arg_4_0.equipInfo_ = EquipInfoView.New(arg_4_0.equipInfoGo_)

	arg_4_0.equipInfo_:RegisterSkillClick(handler(arg_4_0, arg_4_0.SkillClick))

	arg_4_0.equipPosBtn_ = {}

	for iter_4_0 = 0, 6 do
		arg_4_0.equipPosBtn_[iter_4_0] = arg_4_0["equipPosBtn_" .. iter_4_0]
	end

	arg_4_0.starToggle_ = {}

	for iter_4_1 = 2, 5 do
		arg_4_0.starToggle_[iter_4_1] = arg_4_0["toggle_" .. iter_4_1]
	end

	arg_4_0.popController_ = arg_4_0.controllerEx_:GetController("pop")
	arg_4_0.infoController_ = arg_4_0.controllerEx_:GetController("info")
	arg_4_0.btnController_ = arg_4_0.controllerEx_:GetController("btnState")
	arg_4_0.posController_ = arg_4_0.posCon_:GetController("pos")
	arg_4_0.orderController_ = arg_4_0.orderCon_:GetController("sort")
	arg_4_0.filterController_ = arg_4_0.filterCon_:GetController("color")
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0 = 0, 6 do
		arg_5_0:AddBtnListener(arg_5_0.equipPosBtn_[iter_5_0], nil, function()
			if arg_5_0.pos == iter_5_0 then
				return
			end

			arg_5_0:ChangePos(iter_5_0)
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.btnShowFliter_, nil, function()
		JumpTools.OpenPageByJump("equipFilterView", {
			isFilterEquiped = true,
			info = arg_5_0.filterInfo_
		})
	end)
	arg_5_0:AddToggleListener(arg_5_0.dropDown_, function(arg_8_0)
		arg_5_0.priority_ = arg_8_0 == 0 and EquipConst.EQUIP_SORT.RARE or EquipConst.EQUIP_SORT.LEVEL

		arg_5_0:RefreshData()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnOrder_, nil, function()
		local var_9_0 = arg_5_0.order_ == ItemConst.SORT_TYPE.DOWN

		arg_5_0.order_ = var_9_0 and ItemConst.SORT_TYPE.UP or ItemConst.SORT_TYPE.DOWN

		arg_5_0.orderController_:SetSelectedState(var_9_0 and "down" or "up")
		arg_5_0:RefreshData()
	end)

	for iter_5_1 = 2, 5 do
		arg_5_0:AddToggleListener(arg_5_0.starToggle_[iter_5_1], function(arg_10_0)
			arg_5_0:QuickSelectEquip(iter_5_1, arg_10_0)
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.btnPreview_, nil, function()
		if arg_5_0.popController_:GetSelectedState() == "preview" then
			arg_5_0.popController_:SetSelectedState("hide")
		else
			arg_5_0:RefreshRewardItem()
			arg_5_0.popController_:SetSelectedState("preview")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnMask_, nil, function()
		if arg_5_0.popController_:GetSelectedState() == "skill" and arg_5_0.selectSkillItem_ then
			arg_5_0.selectSkillItem_:ShowSelect(false)
		end

		arg_5_0.popController_:SetSelectedState("hide")
	end)
	arg_5_0:AddBtnListenerScale(arg_5_0.btnConfirm_, nil, function()
		if arg_5_0.currentSelectNum_ > 0 then
			arg_5_0:RefreshRewardItem()
			JumpTools.OpenPageByJump("decomposeConfirmPop", {
				type = "equip",
				itemList = arg_5_0.usedEquipList_,
				returnList = arg_5_0.rewardList_
			})
		end
	end)
end

function var_0_0.OnEnter(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})

	arg_14_0.filterInfo_ = {}
	arg_14_0.refreshSelectIndex_ = 1
	arg_14_0.usedEquipList_ = {}
	arg_14_0.currentSelectNum_ = 0
	arg_14_0.pos = 0
	arg_14_0.suit = 0
	arg_14_0.skill = 0

	arg_14_0:RefreshData()

	arg_14_0.selectNum_.text = string.format("%s/%s", arg_14_0.currentSelectNum_, arg_14_0.totalNum_)

	arg_14_0.filterController_:SetSelectedState("normal")
	arg_14_0.popController_:SetSelectedState("hide")
	arg_14_0:RegistEventListener(EQUIP_FILTER_CONFIRM, handler(arg_14_0, arg_14_0.OnEquipFilterConfirm))
	arg_14_0.btnController_:SetSelectedState(arg_14_0.currentSelectNum_ > 0 and "split" or "grey")
	arg_14_0.posController_:SetSelectedState(0)

	for iter_14_0, iter_14_1 in pairs(arg_14_0.starToggle_) do
		iter_14_1.isOn = false
	end
end

function var_0_0.RefreshData(arg_15_0)
	arg_15_0.order_ = arg_15_0.order_ or ItemConst.SORT_TYPE.DOWN
	arg_15_0.priority_ = arg_15_0.priority_ or EquipConst.EQUIP_SORT.RARE
	arg_15_0.itemList_ = arg_15_0:GetItemList(arg_15_0.order_, arg_15_0.priority_, arg_15_0.pos, arg_15_0.filterInfo_.suit, arg_15_0.filterInfo_.skill)
	arg_15_0.totalNum_ = #arg_15_0.itemList_

	arg_15_0.equipItemList_:StartScroll(#arg_15_0.itemList_)
	arg_15_0.infoController_:SetSelectedState(#arg_15_0.itemList_ > 0 and "show" or "hide")
	arg_15_0:CheckToggleState(arg_15_0.itemList_)
end

function var_0_0.GetItemList(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_0 = EquipData:GetEquipListComplex(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_1 = var_0_1.GetEquipMap(HeroData:GetHeroList())
	local var_16_2 = ProposalData:GetEquipMap()
	local var_16_3 = {}

	for iter_16_0 = #var_16_0, 1, -1 do
		local var_16_4 = var_16_0[iter_16_0]

		if not var_16_1[var_16_4.equip_id] and not var_16_4.is_lock and not var_16_2[var_16_4.equip_id] then
			table.insert(var_16_3, var_16_4)
		end
	end

	return var_16_3
end

function var_0_0.RefreshRightInfo(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2

	if arg_17_0.selectedItem_ then
		arg_17_0.selectedItem_:RefreshSelectState2(false)
	end

	arg_17_1:RefreshSelectState2(true)

	arg_17_0.selectedItem_ = arg_17_1

	arg_17_0.equipInfo_:RefreshData(arg_17_0, var_17_0, nil, 0, var_17_0.equip_id)
end

function var_0_0.RefreshRewardItem(arg_18_0)
	if next(arg_18_0.usedEquipList_) ~= nil then
		arg_18_0.rewardList_ = var_0_2.GetDecomposeRewardItem(arg_18_0.usedEquipList_)
	else
		arg_18_0.rewardList_ = {}
	end

	local var_18_0 = #arg_18_0.rewardList_

	arg_18_0.rewardItemList_:StartScroll(var_18_0)
end

function var_0_0.indexEquipItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = clone(ItemTemplateData)
	local var_19_1 = arg_19_0.itemList_[arg_19_1]

	var_19_0.id = var_19_1.prefab_id
	var_19_0.equip_id = var_19_1.equip_id
	var_19_0.equipLevel = var_0_2.CountEquipLevel(var_19_1)

	local var_19_2 = var_19_1.race

	if var_19_2 == 0 or table.keyof(RaceEffectCfg.all, var_19_2) ~= nil then
		var_19_0.race = var_19_2 or 0
		var_19_0.bindHeroID = 0
	else
		local var_19_3 = var_19_2

		var_19_0.race = HeroCfg[var_19_3].race or 0
		var_19_0.bindHeroID = var_19_3
	end

	function var_19_0.clickFun(arg_20_0)
		local var_20_0 = arg_20_0.equip_id

		arg_19_0:RefreshRightInfo(arg_19_2, var_19_1)

		if arg_19_0.usedEquipList_[var_20_0] then
			arg_19_2:RefreshSelectState(false)

			arg_19_0.usedEquipList_[var_20_0] = nil
			arg_19_0.currentSelectNum_ = arg_19_0.currentSelectNum_ - 1

			arg_19_0:CheckToggleState({
				var_19_1
			})
		else
			arg_19_2:RefreshSelectState(true)

			arg_19_0.usedEquipList_[var_20_0] = var_19_1
			arg_19_0.currentSelectNum_ = arg_19_0.currentSelectNum_ + 1
		end

		arg_19_0.btnController_:SetSelectedState(arg_19_0.currentSelectNum_ > 0 and "split" or "grey")

		arg_19_0.selectNum_.text = string.format("%s/%s", arg_19_0.currentSelectNum_, arg_19_0.totalNum_)
	end

	arg_19_2:SetData(var_19_0)

	local var_19_4 = arg_19_0.usedEquipList_[var_19_1.equip_id] ~= nil

	arg_19_2:RefreshSelectState(var_19_4)

	if arg_19_0.refreshSelectIndex_ == arg_19_1 then
		arg_19_0:RefreshRightInfo(arg_19_2, var_19_1)
	end
end

function var_0_0.indexRewardItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = clone(ItemTemplateData)
	local var_21_1 = arg_21_0.rewardList_[arg_21_1]

	var_21_0.id = var_21_1.id
	var_21_0.number = var_21_1.number

	function var_21_0.clickFun(arg_22_0)
		ShowPopItem(POP_ITEM, {
			arg_22_0.id,
			arg_22_0.number
		})
	end

	arg_21_2:SetData(var_21_0)
end

function var_0_0.CheckToggleState(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		if arg_23_0.starToggle_[iter_23_1.star].isOn and not arg_23_0.usedEquipList_[iter_23_1.equip_id] then
			arg_23_0.notClearSelect_ = true
			arg_23_0.starToggle_[iter_23_1.star].isOn = false
		end
	end
end

function var_0_0.SkillClick(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.popController_:SetSelectedState("skill")

	arg_24_0.selectSkillItem_ = arg_24_1

	arg_24_0.equipSkillView_:RefreshData(arg_24_0, arg_24_2)
end

function var_0_0.QuickSelectEquip(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_2 then
		local var_25_0

		for iter_25_0, iter_25_1 in ipairs(arg_25_0.itemList_) do
			if iter_25_1.star == arg_25_1 then
				var_25_0 = var_25_0 or iter_25_0

				if arg_25_0.usedEquipList_[iter_25_1.equip_id] == nil then
					arg_25_0.currentSelectNum_ = arg_25_0.currentSelectNum_ + 1
				end

				arg_25_0.usedEquipList_[iter_25_1.equip_id] = iter_25_1
			end
		end

		if var_25_0 then
			arg_25_0.equipItemList_:ScrollToIndex(var_25_0, false, true, 0.5)
		end
	elseif arg_25_0.notClearSelect_ then
		arg_25_0.notClearSelect_ = false
	else
		for iter_25_2, iter_25_3 in ipairs(arg_25_0.itemList_) do
			if next(arg_25_0.usedEquipList_) ~= nil and arg_25_0.usedEquipList_[iter_25_3.equip_id] and iter_25_3.star == arg_25_1 then
				arg_25_0.usedEquipList_[iter_25_3.equip_id] = nil
				arg_25_0.currentSelectNum_ = arg_25_0.currentSelectNum_ - 1
			end
		end
	end

	arg_25_0:RefreshSelect()
end

function var_0_0.ChangePos(arg_26_0, arg_26_1)
	arg_26_0.posController_:SetSelectedState(arg_26_1)

	arg_26_0.pos = arg_26_1
	arg_26_0.filterInfo_.suitPos = arg_26_1

	arg_26_0:RefreshData()
	arg_26_0:ClearSelect()
end

function var_0_0.OnEquipDecompose(arg_27_0, arg_27_1, arg_27_2)
	if isSuccess(arg_27_1.result) then
		arg_27_0:Go("reward", {
			list = arg_27_0.rewardList_
		})

		arg_27_0.usedEquipList_ = {}

		arg_27_0.btnController_:SetSelectedState("grey")
		arg_27_0:RefreshData()

		arg_27_0.currentSelectNum_ = 0
		arg_27_0.selectNum_.text = string.format("%s/%s", arg_27_0.currentSelectNum_, arg_27_0.totalNum_)

		for iter_27_0, iter_27_1 in pairs(arg_27_0.starToggle_) do
			iter_27_1.isOn = false
		end
	else
		ShowTips(arg_27_1.result)
	end
end

function var_0_0.RefreshSelect(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.equipItemList_:GetItemList()) do
		local var_28_0 = iter_28_1:GetData()
		local var_28_1 = arg_28_0.usedEquipList_[var_28_0.equip_id] ~= nil

		iter_28_1:RefreshSelectState(var_28_1)
	end

	arg_28_0.selectNum_.text = string.format("%s/%s", arg_28_0.currentSelectNum_, arg_28_0.totalNum_)

	arg_28_0.btnController_:SetSelectedState(arg_28_0.currentSelectNum_ > 0 and "split" or "grey")
end

function var_0_0.OnEquipFilterConfirm(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in pairs(arg_29_1) do
		arg_29_0.filterInfo_[iter_29_0] = iter_29_1
	end

	arg_29_0.filterInfo_.suit = arg_29_0.filterInfo_.filterGroup[1]
	arg_29_0.filterInfo_.skill = arg_29_0.filterInfo_.filterGroup[2]

	local var_29_0 = #arg_29_0.filterInfo_.suit > 0 or #arg_29_0.filterInfo_.skill > 0

	arg_29_0.filterController_:SetSelectedState(var_29_0 and "orange" or "normal")
	arg_29_0:RefreshData()
	arg_29_0:ClearSelect()
end

function var_0_0.ClearSelect(arg_30_0)
	arg_30_0.usedEquipList_ = {}
	arg_30_0.currentSelectNum_ = 0
	arg_30_0.selectNum_.text = string.format("%s/%s", arg_30_0.currentSelectNum_, arg_30_0.totalNum_)

	arg_30_0.btnController_:SetSelectedState("grey")

	for iter_30_0, iter_30_1 in pairs(arg_30_0.starToggle_) do
		iter_30_1.isOn = false
	end
end

function var_0_0.OnExit(arg_31_0)
	return
end

function var_0_0.Dispose(arg_32_0)
	arg_32_0:RemoveAllListeners()
	arg_32_0.equipItemList_:Dispose()
	arg_32_0.rewardItemList_:Dispose()
	arg_32_0.equipSkillView_:Dispose()
	arg_32_0.equipInfo_:Dispose()
	var_0_0.super.Dispose(arg_32_0)
end

return var_0_0
