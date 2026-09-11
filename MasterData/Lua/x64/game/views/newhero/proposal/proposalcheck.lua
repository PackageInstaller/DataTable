local ProposalCheck = class("ProposalCheck", ReduxView)

function ProposalCheck:UIName()
	return "Widget/System/Hero_equip/EquipmentUsePopUI"
end

function ProposalCheck:UIParent()
	return manager.ui.uiPop.transform
end

function ProposalCheck:Init()
	self.equipS_ = {}
	self.itemS_ = {}

	self:InitUI()
	self:AddUIListener()
end

function ProposalCheck:InitUI()
	self:BindCfgUI()
end

function ProposalCheck:InitItem(arg_5_1)
	local var_5_0 = {}

	ComponentBinder.GetInstance():BindCfgUI(var_5_0, arg_5_1)

	var_5_0.gameObject_ = arg_5_1
	var_5_0.equip = EquipItem.New(var_5_0.equipItemGo_)

	function var_5_0:RefreshUI(arg_6_1)
		self.equip:RefreshData(arg_6_1, true)

		self.heroIcon_.sprite = HeroTools.GetSmallHeadSprite(arg_6_1.equiping)
	end

	return var_5_0
end

function ProposalCheck:RefreshItems()
	for iter_7_0 = 1, #self.list_ do
		if not self.itemS_[iter_7_0] then
			local var_7_0 = Object.Instantiate(self.itemGo_, self.equipTrs_)

			self.itemS_[iter_7_0] = self:InitItem(var_7_0)

			SetActive(var_7_0, true)
			self.itemS_[iter_7_0]:RefreshUI(self.list_[iter_7_0])
		else
			SetActive(self.itemS_[iter_7_0].gameObject_, true)
			self.itemS_[iter_7_0]:RefreshUI(self.list_[iter_7_0])
		end
	end

	for iter_7_1 = #self.list_ + 1, #self.itemS_ do
		SetActive(self.itemS_[iter_7_1].gameObject_, false)
	end
end

function ProposalCheck:AddUIListener()
	self:AddBtnListener(self.btn_okBtn_, nil, function()
		local var_9_0 = {}

		for iter_9_0 = 1, #self.equipS_ do
			var_9_0[iter_9_0] = {
				pos = self.equipS_[iter_9_0].pos,
				equip_id = self.equipS_[iter_9_0].equip_id
			}
		end

		EquipAction.EquipQuickDressOn(self.heroID_, var_9_0)
	end)
	self:AddBtnListener(self.btn_cancelBtn_, nil, function()
		self:Back()
	end)
end

function ProposalCheck:OnEquipQuickDressOn(arg_11_1, arg_11_2)
	for iter_11_0 = 1, 6 do
		HeroAction.HeroChangeEquip(arg_11_2.hero_id, arg_11_2.use_equip_list[iter_11_0].equip_id, arg_11_2.use_equip_list[iter_11_0].pos)
	end

	self:Back()
end

function ProposalCheck:OnEnter()
	self.equipS_ = self.params_.equipS
	self.heroID_ = self.params_.heroID

	self:UpdateData()
	self:RefreshItems()
end

function ProposalCheck:OnExit()
	return
end

function ProposalCheck:UpdateData()
	self.list_ = {}

	for iter_14_0, iter_14_1 in pairs(self.equipS_) do
		if iter_14_1.equip_id ~= 0 and iter_14_1.equiping then
			local var_14_0 = deepClone(EquipData:GetEquipData(iter_14_1.equip_id))

			var_14_0.equiping = iter_14_1.equiping

			table.insert(self.list_, var_14_0)
		end
	end
end

function ProposalCheck:Dispose()
	self:RemoveAllListeners()

	for iter_15_0, iter_15_1 in pairs(self.itemS_) do
		iter_15_1.equip:Dispose()
	end

	self.itemS_ = nil

	ProposalCheck.super.Dispose(self)
end

return ProposalCheck
