local EquipRecGroupItem = class("EquipRecGroupItem", ReduxView)

function EquipRecGroupItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.titleStrings_ = {
		GetTips("EQUIP_RECOMMEND_1"),
		GetTips("EQUIP_RECOMMEND_2"),
		(GetTips("EQUIP_RECOMMEND_3"))
	}
	self.descItems_ = {}

	self:Init()
end

function EquipRecGroupItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function EquipRecGroupItem:InitUI()
	self:BindCfgUI()

	self.indexController_ = ControllerUtil.GetController(self.gameObject_.transform, "index")
	self.items_ = {}
	self.itemGos_ = {
		self.item1,
		self.item2,
		self.item3,
		self.item4,
		self.item5,
		self.item6
	}

	for iter_3_0 = 1, 6 do
		table.insert(self.items_, (EquipRecItem.New(self.itemGos_[iter_3_0])))
	end
end

function EquipRecGroupItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.index_ = arg_4_1
	self.equipList_ = arg_4_2
	self.heroId_ = arg_4_3

	self.indexController_:SetSelectedState(tostring(arg_4_1))
	self:UpdateView()
end

function EquipRecGroupItem:UpdateView()
	self.nameText_.text = GetI18NText(self.titleStrings_[self.index_])

	for iter_5_0 = 1, #self.items_ do
		self.items_[iter_5_0]:SetEquipId(iter_5_0, self.heroId_, self.equipList_[iter_5_0], self:HaveEquipWithRace(self.equipList_[iter_5_0]))
	end

	local var_5_0 = {}

	for iter_5_1, iter_5_2 in ipairs(self.equipList_) do
		if not table.indexof(var_5_0, EquipCfg[iter_5_2].suit) then
			table.insert(var_5_0, EquipCfg[iter_5_2].suit)
		end
	end

	for iter_5_3, iter_5_4 in ipairs(var_5_0) do
		local var_5_1 = GetCfgDescription(EquipEffectCfg[EquipSuitCfg[iter_5_4].suit_effect[1]].desc[1], 1)

		self.descItems_[iter_5_3] = self.descItems_[iter_5_3] or EquipRecDescItem.New((Object.Instantiate(self.descItemPrefab_, self.container_)))

		self.descItems_[iter_5_3]:SetData(EquipSuitCfg[iter_5_4].name, var_5_1)
	end

	while #self.descItems_ > #var_5_0 do
		self.descItems_[#self.descItems_]:Dispose()
		table.remove(self.descItems_, #self.descItems_)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.container_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function EquipRecGroupItem:AddUIListener()
	self:AddBtnListener(self.gotoChangeBtn_, nil, function()
		local var_7_0

		if EquipRecommendCfg[self.heroId_] then
			var_7_0 = EquipRecommendCfg[self.heroId_].suit_list or {}
		end

		local var_7_1 = {}

		if var_7_0[1] then
			table.insert(var_7_1, var_7_0[1])
		end

		if var_7_0[2] then
			table.insert(var_7_1, var_7_0[2])
		end

		self:Go("/heroEquipBag", {
			isOpenInfo = false,
			suitPos = 0,
			isClearPos = true,
			suit = "recommend",
			heroId = self.heroId_,
			ids = var_7_1
		})
	end)
end

function EquipRecGroupItem:OnEnter()
	return
end

function EquipRecGroupItem:OnExit()
	return
end

function EquipRecGroupItem:HaveEquipWithRace(arg_10_1)
	local var_10_0 = {
		arg_10_1
	}

	if EquipCfg[arg_10_1].race == 0 then
		for iter_10_0, iter_10_1 in ipairs(EquipCfg.get_id_list_by_suit[EquipCfg[arg_10_1].suit]) do
			if EquipCfg[iter_10_1].starlevel == EquipCfg[arg_10_1].starlevel and EquipCfg[iter_10_1].pos == EquipCfg[arg_10_1].pos then
				table.insert(var_10_0, iter_10_1)
			end
		end
	end

	for iter_10_2, iter_10_3 in pairs((EquipData:GetEquipList())) do
		if table.indexof(var_10_0, iter_10_3.prefab_id) then
			return true
		end
	end

	return false
end

function EquipRecGroupItem:Dispose()
	self:RemoveAllListeners()

	if self.items_ then
		for iter_11_0, iter_11_1 in ipairs(self.items_) do
			iter_11_1:Dispose()
		end

		self.items_ = nil
	end

	if self.descItems_ then
		for iter_11_2, iter_11_3 in ipairs(self.descItems_) do
			iter_11_3:Dispose()
		end

		self.descItems_ = nil
	end

	EquipRecGroupItem.super.Dispose(self)
end

return EquipRecGroupItem
