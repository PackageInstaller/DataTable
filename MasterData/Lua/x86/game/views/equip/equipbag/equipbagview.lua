local EquipBagView = class("EquipBagView", ReduxView)

function EquipBagView:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.info_ = arg_1_4

	self:Init()
end

function EquipBagView:RefreshData(arg_2_1, arg_2_2)
	self.handler_ = arg_2_1

	for iter_2_0, iter_2_1 in pairs(arg_2_2) do
		self.info_[iter_2_0] = iter_2_1
	end

	self:Render()
end

function EquipBagView:OnEquipFilterConfirm(arg_3_1)
	if self.isExit_ then
		return
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		self.info_[iter_3_0] = iter_3_1
	end

	self.info_.suit = self.info_.filterGroup[1]
	self.info_.skill = self.info_.filterGroup[2]

	self.filterController_:SetSelectedState((#self.info_.suit > 0 or #self.info_.skill > 0) and "orange" or "normal")
	self:Render()
end

function EquipBagView:Init()
	self:InitUI()
	self:AddUIListener()
	self:InitDropdownData()
end

function EquipBagView:InitDropdownData()
	self.textDropdown_.text = GetTips("TIP_UPGRADE")
	self.textCulture_.text = GetTips("TIP_UPGRADE")
	self.textQuality_.text = GetTips("TIP_RARE")
end

function EquipBagView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.listGo_, CommonItemView)
	self.orderController_ = ControllerUtil.GetController(self.sortBtn_.transform, "order")
	self.tabController_ = self.tab_:GetController("tab")
	self.sortController_ = self.dropDown_:GetController("sortby")
	self.filterController_ = self.filterCon_:GetController("color")
	self.emptyController_ = self.emptyCon_:GetController("empty")
end

function EquipBagView:AddUIListener()
	self.posTab_ = {}

	for iter_7_0 = 1, 6 do
		self.posTab_[iter_7_0] = self[string.format("pos%s_", iter_7_0)]

		self:AddBtnListener(self.posTab_[iter_7_0], nil, function()
			manager.audio:PlayEffect("ui_system_3_0", "ui_sight_listchange", "")

			self.info_.suitPos = iter_7_0

			self.handler_:RefreshPos(iter_7_0)
			self:Render()
		end)
	end

	self:AddBtnListener(self.sortBtn_, nil, function()
		if self.info_.order == ItemConst.SORT_TYPE.DOWN then
			self.info_.order = ItemConst.SORT_TYPE.UP

			self.orderController_:SetSelectedState("up")
		else
			self.info_.order = ItemConst.SORT_TYPE.DOWN

			self.orderController_:SetSelectedState("down")
		end

		self:Render()
		self.handler_:HidePopView()
	end)
	self:AddBtnListener(self.btnFilter_, nil, function()
		JumpTools.OpenPageByJump("equipFilterView", {
			info = self.info_
		})
		self.handler_:HidePopView()
	end)
	self:AddBtnListener(self.btnDropdown_, nil, function()
		SetActive(self.dropDown_.gameObject, true)
		self.handler_:HidePopView()
	end)
	self:AddBtnListener(self.btnDropMask_, nil, function()
		SetActive(self.dropDown_.gameObject, false)
	end)
	self:AddBtnListener(self.btnCulture_, nil, function()
		if self.info_ == nil then
			return
		end

		self.info_.priority = EquipConst.EQUIP_SORT.LEVEL

		self.sortController_:SetSelectedState("culture")

		self.textDropdown_.text = GetTips("TIP_UPGRADE")

		SetActive(self.dropDown_.gameObject, false)
		self:Render()
	end)
	self:AddBtnListener(self.btnQuality_, nil, function()
		if self.info_ == nil then
			return
		end

		self.info_.priority = EquipConst.EQUIP_SORT.RARE

		self.sortController_:SetSelectedState("quality")

		self.textDropdown_.text = GetTips("TIP_RARE")

		SetActive(self.dropDown_.gameObject, false)
		self:Render()
	end)
end

function EquipBagView:OnEnter(arg_15_1)
	self.isExit_ = false
	self.suitShow_ = false
	self.info_ = self.info_ or {}
	self.info_.heroId = arg_15_1.heroId
	self.info_.suitPos = arg_15_1.suitPos or 1
	self.info_.order = self.info_.order or ItemConst.SORT_TYPE.DOWN
	self.info_.priority = self.info_.priority or EquipConst.EQUIP_SORT.LEVEL
	self.lastScrollPos_ = self.lastScrollPos_

	self:Render()

	self.equipNum_.text = string.format("%s/%s", #self.equipList_, GameSetting.max_equip.value[1])

	self:RegistEventListener(EQUIP_FILTER_CONFIRM, handler(self, self.OnEquipFilterConfirm))
end

function EquipBagView:Render(arg_16_1)
	self:RefreshEquipList()
	self:RefreshState()
end

function EquipBagView:RefreshEquipList()
	if self.listGo_.activeSelf == false then
		return
	end

	self.equipList_ = self:GetEquipList()

	local var_17_0 = #self.equipList_

	self.emptyController_:SetSelectedState(tostring(#self.equipList_ == 0))
	self.scrollHelper_:StartScrollByPosition(var_17_0, self.lastScrollPos_ or self.scrollHelper_:GetScrolledPosition())
end

function EquipBagView:GetEquipList()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs((EquipData:GetEquipListComplex(self.info_.order, self.info_.priority, self.info_.suitPos, self.info_.suit, self.info_.skill))) do
		local var_18_1 = {
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

		if iter_18_1.race == 0 or table.keyof(RaceEffectCfg.all, iter_18_1.race) ~= nil then
			var_18_1.race = iter_18_1.race or 0
			var_18_1.bindHeroID = 0
		else
			if not HeroCfg[iter_18_1.race].race then
				var_18_1.race = 0
			end

			var_18_1.bindHeroID = iter_18_1.race
		end

		table.insert(var_18_0, var_18_1)
	end

	return var_18_0
end

function EquipBagView:indexItem(arg_19_1, arg_19_2)
	self.equipList_[arg_19_1].clickFun = function(self)
		if self.selectItem_ then
			self.selectItem_:RefreshSelectState2(false)
		end

		arg_19_2:RefreshSelectState2(true)

		self.selectItem_ = arg_19_2
		self.selectId_ = self.equip_id
		self.lastScrollPos_ = self.scrollHelper_:GetScrolledPosition()

		self.BagItemClickFunc(self, arg_19_2)
	end

	if self.selectId_ and self.equipList_[arg_19_1].equip_id == self.selectId_ then
		self.equipList_[arg_19_1].selectStyle2 = true
		self.selectItem_ = arg_19_2

		self.BagItemClickFunc(self.equipList_[arg_19_1], arg_19_2)
	end

	CommonTools.SetCommonData(arg_19_2, self.equipList_[arg_19_1])
end

function EquipBagView:RegisterItemClick(arg_21_1)
	self.BagItemClickFunc = arg_21_1
end

function EquipBagView:RefreshState()
	self.tabController_:SetSelectedState(self.info_.suitPos)
end

function EquipBagView:RefreshEquipLock(arg_23_1, arg_23_2)
	if self.scrollHelper_ then
		for iter_23_0, iter_23_1 in pairs(self.scrollHelper_:GetItemList()) do
			if iter_23_1:GetData().equip_id == arg_23_2 then
				iter_23_1:RefreshEquipLock(arg_23_1)
			end
		end
	end
end

function EquipBagView:RefreshEquipS()
	local var_24_0 = HeroData:GetEquipMap()

	for iter_24_0, iter_24_1 in pairs((self.scrollHelper_:GetItemList())) do
		local var_24_1 = iter_24_1:GetData()

		if var_24_1.equipedHeroID ~= var_24_0[var_24_1.equip_id] then
			var_24_1.equipedHeroID = var_24_0[var_24_1.equip_id]
			self.equipList_[iter_24_0].equipedHeroID = var_24_0[var_24_1.equip_id]

			CommonTools.SetCommonData(iter_24_1, var_24_1)
		end
	end
end

function EquipBagView:ClearSelect()
	self.selectItem_ = nil
	self.selectId_ = nil
	self.lastScrollPos_ = nil
end

function EquipBagView:GetSelectType()
	return self.selectType_
end

function EquipBagView:OnExit()
	self.info_ = {}
	self.isExit_ = true

	self.filterController_:SetSelectedState("normal")
end

function EquipBagView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	EquipBagView.super.Dispose(self)
end

return EquipBagView
