local EquipEnchantView = class("EquipEnchantView", EquipBaseView)

function EquipEnchantView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.params_ = arg_1_3

	self:Init()
end

function EquipEnchantView:Init()
	self:InitUI()
	self:AddUIListener()
	EquipEnchantView.super.Init(self)
end

function EquipEnchantView:InitUI()
	self:BindCfgUI()
	self:InitEnchant()

	self.skillFixedItems_ = {}
	self.fixedSkillScroller_ = LuaList.New(handler(self, self.indexItem), self.fixedListGo_, EnchantSkillItem)
end

function EquipEnchantView:InitEnchant()
	self.enchants = {}

	for iter_4_0 = 1, 2 do
		local var_4_0 = {
			skills = {}
		}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, self["enchant_" .. iter_4_0])

		var_4_0.lockController_ = var_4_0.transCon_:GetController("lock")

		for iter_4_1 = 1, 2 do
			var_4_0.skills[iter_4_1] = EnchantSkillItem.New(var_4_0["skill_" .. iter_4_1])
		end

		self:AddBtnListener(var_4_0.button_, nil, function()
			self:OnEnchantClick(iter_4_0)
		end)
		table.insert(self.enchants, var_4_0)
	end
end

function EquipEnchantView:AddUIListener()
	self:AddBtnListener(self.previewBtn_, nil, function()
		JumpTools.OpenPageByJump("equipSkillPreviewPage", {
			equipId = self.equipId
		})
	end)
end

function EquipEnchantView:OnEnter()
	self:OnEquipChange(self.params_.equipId)
end

function EquipEnchantView:OnEquipChange(arg_9_1)
	self.equipId = arg_9_1
	self.equip = EquipData:GetEquipData(self.equipId)
	self.slotNum = EquipCfg[self.equip.prefab_id].slot_num or 0
	self.slotOpenLevel = EquipCfg[self.equip.prefab_id].slot_open_level or {}

	self:RefreshUI()
end

function EquipEnchantView:RefreshUI()
	if not self.equip then
		return
	end

	self:RefreshFixedSkill()
	self:RefreshEnchantSkill()
end

function EquipEnchantView:RefreshFixedSkill()
	self.fixedSkillList_ = self.equip:GetBaseSkill()

	self.fixedSkillScroller_:StartScroll(#self.fixedSkillList_)
end

function EquipEnchantView:indexItem(arg_12_1, arg_12_2)
	self.fixedSkillList_[arg_12_1].equipLevel = self.equip:GetLevel()

	arg_12_2:RegistCallBack(handler(self, self.OnEnchantSkillClick))
	arg_12_2:RefreshData(self.fixedSkillList_[arg_12_1])
end

function EquipEnchantView:RefreshEnchantSkill()
	for iter_13_0 = 1, self.slotNum do
		local var_13_0 = self.enchants[iter_13_0]
		local var_13_1 = self.equip.enchant[iter_13_0]

		SetActive(self.enchants[iter_13_0].gameObject_, true)

		local var_13_2 = self.slotOpenLevel[iter_13_0] or 0

		if var_13_2 > self.equip:GetLevel() then
			var_13_0.lockController_:SetSelectedState("lock")

			var_13_0.lockDesc_.text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), var_13_2)
		elseif not var_13_1 or #var_13_1 == 0 then
			var_13_0.lockController_:SetSelectedState("empty")
		else
			var_13_0.lockController_:SetSelectedState("skill")
		end

		if #var_13_1 > 0 then
			for iter_13_1 = 1, 2 do
				if var_13_1[iter_13_1] then
					var_13_1[iter_13_1].equipLevel = self.equip:GetLevel()
				end

				var_13_0.skills[iter_13_1]:RefreshData(var_13_1[iter_13_1])
			end
		end
	end

	for iter_13_2 = self.slotNum + 1, #self.enchants do
		SetActive(self.enchants[iter_13_2].gameObject_, false)
	end
end

function EquipEnchantView:OnEnchantClick(arg_14_1)
	local var_14_0 = self.slotOpenLevel[arg_14_1] or 0

	if var_14_0 > self.equip:GetLevel() then
		ShowTips(string.format(GetTips("EQUIP_ENCHANT_OEPN_LEVEL"), var_14_0))

		return
	end

	self.handler_:HidePop()
	self:Go("/enchantChangeView", {
		equipId = self.equipId,
		enchatPos = arg_14_1,
		proxy = self.params_.proxy
	})
end

function EquipEnchantView:OnEnchantSkillClick(arg_15_1, arg_15_2)
	self.handler_:RefreshSkillInfo(arg_15_1, arg_15_2)
end

function EquipEnchantView:OnExit()
	self.handler_:HidePop()
end

function EquipEnchantView:Dispose()
	self.fixedSkillScroller_:Dispose()

	for iter_17_0, iter_17_1 in ipairs(self.enchants) do
		for iter_17_2 = 1, 2 do
			iter_17_1.skills[iter_17_2]:Dispose()
		end
	end

	self.enchants = nil

	EquipEnchantView.super.Dispose(self)
end

return EquipEnchantView
