local var_0_0 = class("EquipBagView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.info_ = arg_1_4

	arg_1_0:Init()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.handler_ = arg_2_1

	for iter_2_0, iter_2_1 in pairs(arg_2_2) do
		arg_2_0.info_[iter_2_0] = iter_2_1
	end

	arg_2_0:Render()
end

function var_0_0.OnEquipFilterConfirm(arg_3_0, arg_3_1)
	if arg_3_0.isExit_ then
		return
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		arg_3_0.info_[iter_3_0] = iter_3_1
	end

	arg_3_0.info_.suit = arg_3_0.info_.filterGroup[1]
	arg_3_0.info_.skill = arg_3_0.info_.filterGroup[2]

	local var_3_0 = #arg_3_0.info_.suit > 0 or #arg_3_0.info_.skill > 0

	arg_3_0.filterController_:SetSelectedState(var_3_0 and "orange" or "normal")
	arg_3_0:Render()
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
	arg_4_0:InitDropdownData()
end

function var_0_0.InitDropdownData(arg_5_0)
	arg_5_0.textDropdown_.text = GetTips("TIP_UPGRADE")
	arg_5_0.textCulture_.text = GetTips("TIP_UPGRADE")
	arg_5_0.textQuality_.text = GetTips("TIP_RARE")
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.scrollHelper_ = LuaList.New(handler(arg_6_0, arg_6_0.indexItem), arg_6_0.listGo_, CommonItemView)
	arg_6_0.orderController_ = ControllerUtil.GetController(arg_6_0.sortBtn_.transform, "order")
	arg_6_0.tabController_ = arg_6_0.tab_:GetController("tab")
	arg_6_0.sortController_ = arg_6_0.dropDown_:GetController("sortby")
	arg_6_0.filterController_ = arg_6_0.filterCon_:GetController("color")
	arg_6_0.emptyController_ = arg_6_0.emptyCon_:GetController("empty")
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0.posTab_ = {}

	for iter_7_0 = 1, 6 do
		arg_7_0.posTab_[iter_7_0] = arg_7_0[string.format("pos%s_", iter_7_0)]

		arg_7_0:AddBtnListener(arg_7_0.posTab_[iter_7_0], nil, function()
			manager.audio:PlayEffect("ui_system_3_0", "ui_sight_listchange", "")

			arg_7_0.info_.suitPos = iter_7_0

			arg_7_0.handler_:RefreshPos(iter_7_0)
			arg_7_0:Render()
		end)
	end

	arg_7_0:AddBtnListener(arg_7_0.sortBtn_, nil, function()
		if arg_7_0.info_.order == ItemConst.SORT_TYPE.DOWN then
			arg_7_0.info_.order = ItemConst.SORT_TYPE.UP

			arg_7_0.orderController_:SetSelectedState("up")
		else
			arg_7_0.info_.order = ItemConst.SORT_TYPE.DOWN

			arg_7_0.orderController_:SetSelectedState("down")
		end

		arg_7_0:Render()
		arg_7_0.handler_:HidePopView()
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnFilter_, nil, function()
		JumpTools.OpenPageByJump("equipFilterView", {
			info = arg_7_0.info_
		})
		arg_7_0.handler_:HidePopView()
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnDropdown_, nil, function()
		SetActive(arg_7_0.dropDown_.gameObject, true)
		arg_7_0.handler_:HidePopView()
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnDropMask_, nil, function()
		SetActive(arg_7_0.dropDown_.gameObject, false)
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnCulture_, nil, function()
		if arg_7_0.info_ == nil then
			return
		end

		arg_7_0.info_.priority = EquipConst.EQUIP_SORT.LEVEL

		arg_7_0.sortController_:SetSelectedState("culture")

		arg_7_0.textDropdown_.text = GetTips("TIP_UPGRADE")

		SetActive(arg_7_0.dropDown_.gameObject, false)
		arg_7_0:Render()
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnQuality_, nil, function()
		if arg_7_0.info_ == nil then
			return
		end

		arg_7_0.info_.priority = EquipConst.EQUIP_SORT.RARE

		arg_7_0.sortController_:SetSelectedState("quality")

		arg_7_0.textDropdown_.text = GetTips("TIP_RARE")

		SetActive(arg_7_0.dropDown_.gameObject, false)
		arg_7_0:Render()
	end)
end

function var_0_0.OnEnter(arg_15_0, arg_15_1)
	arg_15_0.isExit_ = false
	arg_15_0.suitShow_ = false
	arg_15_0.info_ = arg_15_0.info_ or {}
	arg_15_0.info_.heroId = arg_15_1.heroId
	arg_15_0.info_.suitPos = arg_15_1.suitPos or 1
	arg_15_0.info_.order = arg_15_0.info_.order or ItemConst.SORT_TYPE.DOWN
	arg_15_0.info_.priority = arg_15_0.info_.priority or EquipConst.EQUIP_SORT.LEVEL
	arg_15_0.lastScrollPos_ = arg_15_0.lastScrollPos_

	arg_15_0:Render()

	arg_15_0.equipNum_.text = string.format("%s/%s", #arg_15_0.equipList_, GameSetting.max_equip.value[1])

	arg_15_0:RegistEventListener(EQUIP_FILTER_CONFIRM, handler(arg_15_0, arg_15_0.OnEquipFilterConfirm))
end

function var_0_0.Render(arg_16_0, arg_16_1)
	arg_16_0:RefreshEquipList()
	arg_16_0:RefreshState()
end

function var_0_0.RefreshEquipList(arg_17_0)
	if arg_17_0.listGo_.activeSelf == false then
		return
	end

	arg_17_0.equipList_ = arg_17_0:GetEquipList()

	local var_17_0 = #arg_17_0.equipList_

	arg_17_0.emptyController_:SetSelectedState(tostring(var_17_0 == 0))
	arg_17_0.scrollHelper_:StartScrollByPosition(var_17_0, arg_17_0.lastScrollPos_ or arg_17_0.scrollHelper_:GetScrolledPosition())
end

function var_0_0.GetEquipList(arg_18_0)
	local var_18_0 = EquipData:GetEquipListComplex(arg_18_0.info_.order, arg_18_0.info_.priority, arg_18_0.info_.suitPos, arg_18_0.info_.suit, arg_18_0.info_.skill)
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_2 = {
			number = 1,
			type = ItemCfg[iter_18_1.prefab_id].type,
			id = iter_18_1.prefab_id,
			equip_info = iter_18_1,
			equip_star = getItemStar(iter_18_1.prefab_id),
			equipedHeroID = iter_18_1:GetEquipHero(),
			equip_id = iter_18_1.equip_id,
			equipLevel = EquipTools.CountEquipLevel(iter_18_1),
			equipEnchantCount = #iter_18_1.enchant_preview,
			equipedLocked = iter_18_1.is_lock
		}
		local var_18_3 = iter_18_1.race

		if var_18_3 == 0 or table.keyof(RaceEffectCfg.all, var_18_3) ~= nil then
			var_18_2.race = var_18_3 or 0
			var_18_2.bindHeroID = 0
		else
			local var_18_4 = var_18_3

			var_18_2.race = HeroCfg[var_18_4].race or 0
			var_18_2.bindHeroID = var_18_4
		end

		table.insert(var_18_1, var_18_2)
	end

	return var_18_1
end

function var_0_0.indexItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.equipList_[arg_19_1]

	function var_19_0.clickFun(arg_20_0)
		if arg_19_0.selectItem_ then
			arg_19_0.selectItem_:RefreshSelectState2(false)
		end

		arg_19_2:RefreshSelectState2(true)

		arg_19_0.selectItem_ = arg_19_2
		arg_19_0.selectId_ = arg_20_0.equip_id
		arg_19_0.lastScrollPos_ = arg_19_0.scrollHelper_:GetScrolledPosition()

		arg_19_0.BagItemClickFunc(arg_20_0, arg_19_2)
	end

	if arg_19_0.selectId_ and var_19_0.equip_id == arg_19_0.selectId_ then
		var_19_0.selectStyle2 = true
		arg_19_0.selectItem_ = arg_19_2

		arg_19_0.BagItemClickFunc(var_19_0, arg_19_2)
	end

	CommonTools.SetCommonData(arg_19_2, var_19_0)
end

function var_0_0.RegisterItemClick(arg_21_0, arg_21_1)
	arg_21_0.BagItemClickFunc = arg_21_1
end

function var_0_0.RefreshState(arg_22_0)
	arg_22_0.tabController_:SetSelectedState(arg_22_0.info_.suitPos)
end

function var_0_0.RefreshEquipLock(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.scrollHelper_ then
		for iter_23_0, iter_23_1 in pairs(arg_23_0.scrollHelper_:GetItemList()) do
			if iter_23_1:GetData().equip_id == arg_23_2 then
				iter_23_1:RefreshEquipLock(arg_23_1)
			end
		end
	end
end

function var_0_0.RefreshEquipS(arg_24_0)
	local var_24_0 = arg_24_0.scrollHelper_:GetItemList()
	local var_24_1 = HeroData:GetEquipMap()

	for iter_24_0, iter_24_1 in pairs(var_24_0) do
		local var_24_2 = iter_24_1:GetData()

		if var_24_2.equipedHeroID ~= var_24_1[var_24_2.equip_id] then
			var_24_2.equipedHeroID = var_24_1[var_24_2.equip_id]
			arg_24_0.equipList_[iter_24_0].equipedHeroID = var_24_1[var_24_2.equip_id]

			CommonTools.SetCommonData(iter_24_1, var_24_2)
		end
	end
end

function var_0_0.ClearSelect(arg_25_0)
	arg_25_0.selectItem_ = nil
	arg_25_0.selectId_ = nil
	arg_25_0.lastScrollPos_ = nil
end

function var_0_0.GetSelectType(arg_26_0)
	return arg_26_0.selectType_
end

function var_0_0.OnExit(arg_27_0)
	arg_27_0.info_ = {}
	arg_27_0.isExit_ = true

	arg_27_0.filterController_:SetSelectedState("normal")
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0:RemoveAllListeners()
	arg_28_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
