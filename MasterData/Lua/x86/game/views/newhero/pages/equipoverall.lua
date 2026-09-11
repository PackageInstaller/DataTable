local EquipOverall = class("EquipOverall", ReduxView)

function EquipOverall:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function EquipOverall:Init()
	self:InitUI()
	self:AddUIListener()
end

function EquipOverall:InitUI()
	self:BindCfgUI()

	self.suitItems_ = {}
	self.attrItem_ = {}

	for iter_3_0 = 1, 3 do
		self.attrItem_[iter_3_0] = AttributeItem.New(self, self["attrItem_" .. iter_3_0])
	end

	self.tabController_ = self.transCon_:GetController("tab")
	self.stateController_ = self.transCon_:GetController("btnActive")
	self.btnController_ = self.btnCon_:GetController("btnState")
	self.suitController_ = self.suitCon_:GetController("suit")
	self.skillScroller_ = LuaList.New(handler(self, self.indexSkillItem), self.skillListGo_, EquipNewSkillItem)
end

function EquipOverall:AddUIListener()
	self:AddBtnListener(self.btnSuit_, nil, function()
		self.tabController_:SetSelectedState("suit")
	end)
	self:AddBtnListener(self.btnSkill_, nil, function()
		self.tabController_:SetSelectedState("skill")
	end)
	self:AddBtnListener(self.btnSave_, nil, function()
		self.saveFunc_()
	end)
	self:AddBtnListener(self.btnDelete_, nil, function()
		self.deleteFunc_()
	end)
	self:AddBtnListener(self.btnEquip_, nil, function()
		self.equipFunc_()
	end)
end

function EquipOverall:OnEnter(arg_10_1)
	self.heroViewProxy_ = arg_10_1
end

function EquipOverall:RefreshSuitItem()
	if #self.suitList_ ~= 0 then
		for iter_11_0, iter_11_1 in ipairs(self.suitList_) do
			local var_11_0 = self.suitItems_[iter_11_0]

			if self.suitItems_[iter_11_0] == nil then
				var_11_0 = EquipNewSuitItem.New((Object.Instantiate(self.suitGo_, self.suitContent_, false)))
				self.suitItems_[iter_11_0] = var_11_0
			end

			SetActive(var_11_0.gameObject_, true)
			var_11_0:RefreshData(self.heroViewProxy_:GetHeroData(self.heroID_), self.suitList_[iter_11_0])
		end
	end

	for iter_11_2 = #self.suitList_ + 1, #self.suitItems_ do
		SetActive(self.suitItems_[iter_11_2].gameObject_, false)
	end

	self.suitController_:SetSelectedState(#self.suitList_ ~= 0 and "suit" or "empty")
end

function EquipOverall:indexSkillItem(arg_12_1, arg_12_2)
	arg_12_2:RefreshData(self.skillList_[arg_12_1], true)
	arg_12_2:RegistCallBack(function(arg_13_0)
		self:SkillClick(arg_12_2, arg_13_0)
	end)
end

function EquipOverall:RefreshHeroInfo(arg_14_1, arg_14_2, arg_14_3)
	self.heroID_ = arg_14_1.id

	self:RefreshAttr(arg_14_2, arg_14_1.id)
	self:RefreshSkill(arg_14_2, arg_14_1, arg_14_1.id)
	self:RefreshSuit(arg_14_2, arg_14_1.id)
	self:RefreshBtn(arg_14_3)
end

function EquipOverall:RefreshAttr(arg_15_1, arg_15_2)
	local var_15_0 = self.heroViewProxy_:CalHeroEquipAttribute(arg_15_2, arg_15_1)

	for iter_15_0 = 1, 3 do
		self.attrItem_[iter_15_0]:RefreshData(self, {
			index = iter_15_0,
			attrS = var_15_0
		})
	end
end

function EquipOverall:RefreshSkill(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = self.heroViewProxy_:GetEquipDataList(arg_16_3, arg_16_1)
	local var_16_1, var_16_2, var_16_3 = EquipTools.CountHeroTotalSkill(var_16_0, arg_16_2, true)

	self.equipList_ = var_16_0
	self.isAdd_ = var_16_2
	self.skillList_ = {}

	for iter_16_0, iter_16_1 in pairs(var_16_1) do
		table.insert(self.skillList_, {
			unlockLevel = 0,
			id = iter_16_0,
			num = iter_16_1,
			isAdd = var_16_2,
			location = var_16_3[iter_16_0]
		})
	end

	local var_16_4 = HeroCfg[arg_16_3].equip_skill

	table.sort(self.skillList_, function(arg_17_0, arg_17_1)
		local var_17_0 = table.indexof(var_16_4, arg_17_0.id)
		local var_17_1 = table.indexof(var_16_4, arg_17_1.id)

		if var_17_0 and var_17_1 then
			return var_17_0 < var_17_1
		end

		return arg_17_0.id < arg_17_1.id
	end)
	self.skillScroller_:StartScroll(#self.skillList_)
end

function EquipOverall:RefreshSuit(arg_18_1, arg_18_2)
	self.suitList_ = EquipTools.CountActiveSuit((self.heroViewProxy_:GetEquipDataList(arg_18_2, arg_18_1)))

	for iter_18_0 = #self.suitList_, 1, -1 do
		self.suitList_[iter_18_0].heroId = arg_18_2
	end

	self:RefreshSuitItem()
end

function EquipOverall:RefreshBtn(arg_19_1)
	if arg_19_1 and self.heroViewProxy_.isSelf then
		self.stateController_:SetSelectedState("on")
		self.btnController_:SetSelectedState(arg_19_1)
	else
		self.stateController_:SetSelectedState("off")
	end
end

function EquipOverall:RegistSkillClick(arg_20_1)
	self.skillClickFunc_ = arg_20_1
end

function EquipOverall:SkillClick(arg_21_1, arg_21_2)
	if self.lastSkillSelect_ then
		self.lastSkillSelect_:ShowSelect(false)
	end

	self.lastSkillSelect_ = arg_21_1

	arg_21_1:ShowSelect(true)
	self.skillClickFunc_(arg_21_1, arg_21_2)
end

function EquipOverall:RegistOptionButton(arg_22_1, arg_22_2, arg_22_3)
	self.saveFunc_ = arg_22_1
	self.equipFunc_ = arg_22_2
	self.deleteFunc_ = arg_22_3
end

function EquipOverall:DeSelect()
	if self.lastSkillSelect_ then
		self.lastSkillSelect_:ShowSelect(false)
	end
end

function EquipOverall:Dispose()
	for iter_24_0, iter_24_1 in pairs(self.suitItems_) do
		iter_24_1:Dispose()
	end

	self.suitItems_ = nil

	if self.skillScroller_ then
		self.skillScroller_:Dispose()

		self.skillScroller_ = nil
	end

	if self.attrItem_ then
		for iter_24_2, iter_24_3 in pairs(self.attrItem_) do
			iter_24_3:Dispose()
		end

		self.attrItem_ = nil
	end

	EquipOverall.super.Dispose(self)
end

return EquipOverall
