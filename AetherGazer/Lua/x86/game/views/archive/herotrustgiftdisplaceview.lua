local var_0_0 = class("HeroTrustGiftDisplaceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_coop/HeroCoopGiftUI"
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

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, HeroTrustGiftDisplaceItem)
	arg_4_0.item = CommonItemView.New(arg_4_0.m_item, true)
	arg_4_0.rareController = ControllerUtil.GetController(arg_4_0.transform_, "rare")
	arg_4_0.selectController = ControllerUtil.GetController(arg_4_0.transform_, "select")
	arg_4_0.changeController = ControllerUtil.GetController(arg_4_0.transform_, "change")
	arg_4_0.clickHandle = handler(arg_4_0, arg_4_0.ItemClick)
	arg_4_0.unSelectHanld = handler(arg_4_0, arg_4_0.UnSelect)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_star2Btn, function()
		arg_5_0:SelectItem(2)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_star3Btn, function()
		arg_5_0:SelectItem(3)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_star4Btn, function()
		arg_5_0:SelectItem(4)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_star5Btn, function()
		arg_5_0:SelectItem(5)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_displaceBtn, function()
		local var_10_0 = 0

		for iter_10_0, iter_10_1 in pairs(arg_5_0.choice_item) do
			var_10_0 = var_10_0 + iter_10_1
		end

		local var_10_1 = arg_5_0:GetGiftItemId(arg_5_0.rare)
		local var_10_2 = arg_5_0:GetRatio(var_10_1)
		local var_10_3 = math.floor(var_10_0 / var_10_2)
		local var_10_4 = var_10_3 * var_10_2

		if var_10_4 < var_10_2 then
			ShowTips("HERO_TRUST_DISPLACE_FAIL")

			return
		end

		local var_10_5 = ArchiveData:GetTrustGiftDisplaceCount(var_10_1)

		if arg_5_0:GetTrustGiftDisplaceMax(var_10_1) < var_10_3 + var_10_5 then
			ShowTips("HERO_TRUST_DISPLACE_UP_LIMIT")

			return
		end

		local var_10_6 = {}

		for iter_10_2, iter_10_3 in pairs(arg_5_0.choice_item) do
			var_10_6[iter_10_2] = iter_10_3
		end

		local var_10_7 = var_10_0 - var_10_4

		while var_10_7 > 0 do
			local var_10_8 = table.remove(arg_5_0.operate_item)

			if var_10_8 then
				if var_10_6[var_10_8] and var_10_6[var_10_8] > 0 then
					local var_10_9 = var_10_7

					var_10_7 = var_10_7 - var_10_6[var_10_8]
					var_10_6[var_10_8] = math.max(0, var_10_6[var_10_8] - var_10_9)
				end
			else
				break
			end
		end

		if var_10_7 > 0 then
			ShowTips("HERO_TRUST_DISPLACE_FAIL")

			return
		end

		local var_10_10 = {}

		for iter_10_4, iter_10_5 in pairs(var_10_6) do
			if iter_10_5 ~= 0 then
				table.insert(var_10_10, {
					id = iter_10_4,
					num = iter_10_5
				})
			end
		end

		ArchiveAction.QueryExChangeTrustItem(var_10_10, {
			{
				id = var_10_1,
				num = var_10_3
			}
		})
		arg_5_0:RefreshRight()
	end)
	arg_5_0.m_slider.onValueChanged:AddListener(function()
		local var_11_0 = arg_5_0.m_slider.value

		if var_11_0 < 1 then
			arg_5_0.m_slider.value = 1
			var_11_0 = 1
		end

		arg_5_0.choice_item[arg_5_0.select_item_id] = var_11_0
		arg_5_0.m_selectNum.text = var_11_0

		if arg_5_0.select_item_id ~= arg_5_0.operate_item[#arg_5_0.operate_item] then
			table.insert(arg_5_0.operate_item, arg_5_0.select_item_id)
		end

		arg_5_0.list:Refresh()
		arg_5_0:RefreshRight()

		arg_5_0.m_delBtn.interactable = var_11_0 > 1
		arg_5_0.m_addBtn.interactable = var_11_0 < arg_5_0.m_slider.maxValue
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_addBtn, function()
		local var_12_0 = ItemTools.getItemNum(arg_5_0.select_item_id)
		local var_12_1 = arg_5_0.choice_item[arg_5_0.select_item_id] or 0

		if var_12_1 >= arg_5_0.m_slider.maxValue then
			ShowTips("HERO_TRUST_DISPLACE_MAX")

			return
		end

		local var_12_2 = arg_5_0:GetGiftItemId(arg_5_0.rare)
		local var_12_3 = arg_5_0:GetRatio(var_12_2)
		local var_12_4 = 0

		for iter_12_0, iter_12_1 in pairs(arg_5_0.choice_item) do
			var_12_4 = var_12_4 + iter_12_1
		end

		local var_12_5 = math.floor(var_12_4 / var_12_3) * var_12_3

		if var_12_4 ~= var_12_5 then
			var_12_3 = var_12_3 - var_12_4 + var_12_5
		end

		local var_12_6 = var_12_1 + math.min(var_12_3, var_12_0 - var_12_1)

		arg_5_0.m_slider.value = var_12_6
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_delBtn, function()
		local var_13_0 = arg_5_0.choice_item[arg_5_0.select_item_id] or 0

		if var_13_0 <= 1 then
			return
		end

		local var_13_1 = arg_5_0:GetGiftItemId(arg_5_0.rare)
		local var_13_2 = arg_5_0:GetRatio(var_13_1)
		local var_13_3 = 0

		for iter_13_0, iter_13_1 in pairs(arg_5_0.choice_item) do
			var_13_3 = var_13_3 + iter_13_1
		end

		local var_13_4 = math.floor(var_13_3 / var_13_2) * var_13_2

		if var_13_3 ~= var_13_4 then
			var_13_2 = var_13_3 - var_13_4
		end

		local var_13_5 = var_13_0 - math.min(var_13_2, var_13_0)

		arg_5_0.m_slider.value = var_13_5
	end)
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("HERO_TRUST_DISPLACE_TIP")
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.gifts = arg_15_0:GetGiftItemList()

	arg_15_0.list:StartScroll(#arg_15_0.gifts)

	arg_15_0.select_item_id = 0
	arg_15_0.choice_item = {}
	arg_15_0.operate_item = {}

	arg_15_0:RefreshSlider()
	arg_15_0:SelectItem(2)
end

function var_0_0.GetGiftItemList(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.ARCHIVE_GIFT]

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if ItemCfg[iter_16_1].sub_type == 1 and ItemTools.getItemNum(iter_16_1) > 0 then
			table.insert(var_16_0, iter_16_1)
		end
	end

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_16_0:GetLikeHero(arg_17_0)
		local var_17_1 = arg_16_0:GetLikeHero(arg_17_1)
		local var_17_2 = var_17_0 ~= 0 and ArchiveData:GetArchive(var_17_0).lv or 0
		local var_17_3 = var_17_1 ~= 0 and ArchiveData:GetArchive(var_17_1).lv or 0

		if var_17_0 ~= var_17_1 then
			if var_17_2 ~= var_17_3 then
				return var_17_3 < var_17_2
			else
				return arg_17_1 < arg_17_0
			end
		else
			return arg_17_1 < arg_17_0
		end
	end)

	return var_16_0
end

function var_0_0.GetLikeHero(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(HeroRecordCfg.all) do
		local var_18_0 = HeroRecordCfg[iter_18_1]

		if table.indexof(var_18_0.gift_like_id1, arg_18_1) then
			return iter_18_1
		end
	end

	return 0
end

function var_0_0.OnExit(arg_19_0)
	manager.windowBar:HideBar()
end

function var_0_0.SelectItem(arg_20_0, arg_20_1)
	arg_20_0.choice_item = {}
	arg_20_0.operate_item = {}
	arg_20_0.rare = arg_20_1

	arg_20_0.rareController:SetSelectedState(arg_20_1)
	arg_20_0:RefreshRight()

	arg_20_0.select_item_id = 0

	arg_20_0:RefreshSlider()
end

function var_0_0.RefreshSlider(arg_21_0)
	if arg_21_0.select_item_id == 0 then
		arg_21_0.selectController:SetSelectedIndex(0)
	else
		local var_21_0 = arg_21_0.choice_item[arg_21_0.select_item_id] or 0
		local var_21_1 = arg_21_0:GetGiftItemId(arg_21_0.rare)
		local var_21_2 = arg_21_0:GetRatio(var_21_1)
		local var_21_3 = 0

		for iter_21_0, iter_21_1 in pairs(arg_21_0.choice_item) do
			if iter_21_0 ~= arg_21_0.select_item_id then
				var_21_3 = var_21_3 + iter_21_1
			end
		end

		local var_21_4 = ArchiveData:GetTrustGiftDisplaceCount(var_21_1)
		local var_21_5 = (arg_21_0:GetTrustGiftDisplaceMax(var_21_1) - var_21_4) * var_21_2

		if var_21_3 < var_21_5 then
			arg_21_0.selectController:SetSelectedIndex(1)

			arg_21_0.m_slider.maxValue = math.min(ItemTools.getItemNum(arg_21_0.select_item_id), var_21_5 - var_21_3)
		elseif var_21_0 == 0 then
			arg_21_0.selectController:SetSelectedIndex(0)
		else
			arg_21_0.selectController:SetSelectedIndex(1)

			arg_21_0.m_slider.maxValue = var_21_0
		end

		arg_21_0.m_slider.minValue = 0
		arg_21_0.m_slider.value = math.max(1, var_21_0)
		arg_21_0.m_selectNum.text = math.max(1, var_21_0)
	end

	arg_21_0.list:Refresh()
	arg_21_0:RefreshRight()
end

function var_0_0.RefreshRight(arg_22_0)
	local var_22_0 = arg_22_0:GetGiftItemId(arg_22_0.rare)
	local var_22_1 = clone(ItemTemplateData)

	var_22_1.id = var_22_0
	var_22_1.number = 1

	function var_22_1.clickFun()
		ShowPopItem(POP_ITEM, {
			var_22_0,
			1
		})
	end

	arg_22_0.item:SetData(var_22_1)

	arg_22_0.m_itemName.text = ItemTools.getItemName(var_22_0)

	local var_22_2 = arg_22_0:GetRatio(var_22_0)

	arg_22_0.m_ratioLab.text = var_22_2

	local var_22_3 = 0

	for iter_22_0, iter_22_1 in pairs(arg_22_0.choice_item) do
		var_22_3 = var_22_3 + iter_22_1
	end

	if var_22_3 == 0 then
		arg_22_0.m_displaceBtn.interactable = false

		arg_22_0.changeController:SetSelectedIndex(0)
	else
		arg_22_0.m_displaceBtn.interactable = true

		arg_22_0.changeController:SetSelectedIndex(1)
	end

	local var_22_4 = math.floor(var_22_3 / var_22_2)
	local var_22_5 = var_22_4 * var_22_2

	arg_22_0.m_displaceNum.text = var_22_4

	local var_22_6 = ArchiveData:GetTrustGiftDisplaceCount(var_22_0)
	local var_22_7 = arg_22_0:GetTrustGiftDisplaceMax(var_22_0)

	arg_22_0.m_ceilLab.text = var_22_6 .. "/" .. var_22_7

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_0.layoutTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_0.layoutTrs_)
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0.item:Dispose()
	arg_24_0.list:Dispose()
	var_0_0.super.Dispose(arg_24_0)
end

function var_0_0.GetGiftItemId(arg_25_0, arg_25_1)
	if arg_25_1 == 2 then
		return 30012
	elseif arg_25_1 == 3 then
		return 30013
	elseif arg_25_1 == 4 then
		return 30014
	else
		return 30015
	end
end

function var_0_0.GetRatio(arg_26_0, arg_26_1)
	local var_26_0 = GameSetting.hero_trust_exchange_need.value

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		if arg_26_1 == iter_26_1[1] then
			return iter_26_1[2]
		end
	end

	return 1
end

function var_0_0.GetTrustGiftDisplaceMax(arg_27_0, arg_27_1)
	local var_27_0 = GameSetting.hero_trust_exchange_up_limit.value

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		if arg_27_1 == iter_27_1[1] then
			return iter_27_1[2]
		end
	end

	return 0
end

function var_0_0.IndexItem(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.gifts[arg_28_1]
	local var_28_1 = arg_28_0.choice_item[var_28_0] or 0

	arg_28_2:SetData(var_28_0, var_28_1)
	arg_28_2:SetSelect(arg_28_0.select_item_id)
	arg_28_2:RegistCallBack(arg_28_0.clickHandle)
	arg_28_2:RegistCallBack2(arg_28_0.unSelectHanld)
end

function var_0_0.ItemClick(arg_29_0, arg_29_1)
	arg_29_0.select_item_id = arg_29_1

	local var_29_0 = arg_29_0.list:GetItemList()

	for iter_29_0, iter_29_1 in pairs(var_29_0) do
		iter_29_1:SetSelect(arg_29_0.select_item_id)
	end

	if not arg_29_0.choice_item[arg_29_1] or arg_29_0.choice_item[arg_29_1] == 0 then
		local var_29_1 = arg_29_0:GetGiftItemId(arg_29_0.rare)
		local var_29_2 = arg_29_0:GetRatio(var_29_1)
		local var_29_3 = 0

		for iter_29_2, iter_29_3 in pairs(arg_29_0.choice_item) do
			var_29_3 = var_29_3 + iter_29_3
		end

		local var_29_4 = ArchiveData:GetTrustGiftDisplaceCount(var_29_1)
		local var_29_5 = (arg_29_0:GetTrustGiftDisplaceMax(var_29_1) - var_29_4) * var_29_2

		if var_29_3 < var_29_5 then
			local var_29_6 = math.min(var_29_5 - var_29_3, ItemTools.getItemNum(arg_29_1))

			arg_29_0.choice_item[arg_29_1] = math.min(var_29_2, var_29_6)

			table.insert(arg_29_0.operate_item, arg_29_1)
		else
			ShowTips("HERO_TRUST_DISPLACE_MAX")
		end
	end

	arg_29_0:RefreshSlider()
end

function var_0_0.UnSelect(arg_30_0, arg_30_1)
	arg_30_0.select_item_id = 0

	local var_30_0 = arg_30_0.list:GetItemList()

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		iter_30_1:SetSelect(arg_30_0.select_item_id)
	end

	arg_30_0.choice_item[arg_30_1] = 0

	arg_30_0:RefreshSlider()
end

function var_0_0.OnHeroTrustItemDisplace(arg_31_0)
	arg_31_0.gifts = arg_31_0:GetGiftItemList()

	local var_31_0 = arg_31_0.list:GetScrolledPosition()

	arg_31_0.list:StartScrollWithoutAnimator(#arg_31_0.gifts, var_31_0)

	arg_31_0.select_item_id = 0
	arg_31_0.choice_item = {}
	arg_31_0.operate_item = {}

	arg_31_0:RefreshSlider()
end

return var_0_0
