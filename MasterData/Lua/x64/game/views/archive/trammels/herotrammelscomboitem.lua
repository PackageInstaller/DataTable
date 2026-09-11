local HeroTrammelsComboItem = class("HeroTrammelsComboItem", ReduxView)

function HeroTrammelsComboItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroTrammelsComboItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTrammelsComboItem:InitUI()
	self:BindCfgUI()

	self.combRoleNumController = ControllerUtil.GetController(self.transform_, "combRoleNum")
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function HeroTrammelsComboItem:AddUIListener()
	self:AddBtnListener(nil, self.m_btn, function()
		if self.callback_ then
			self.callback_(self.comboId)
		end
	end)
end

function HeroTrammelsComboItem:SetData(arg_6_1)
	self.comboId = arg_6_1

	self:Refresh()
	self:RefreshRedPoint()
end

function HeroTrammelsComboItem:Refresh()
	self.m_skillLevel.text = GetTips("LEVEL") .. ComboSkillData:GetCurComboSkillLevel(self.comboId)
	self.m_comboName.text = HeroSkillCfg[ComboSkillCfg[self.comboId].skill_id].name
	self.m_icon.sprite = getSpriteViaConfig("ComboSkill", ComboSkillCfg[self.comboId].skill_id)

	local var_7_0 = deepClone(ComboSkillCfg[self.comboId].cooperate_role_ids)

	CommonTools.UniversalSortEx(var_7_0, {
		ascend = true,
		map = function(arg_8_0)
			return arg_8_0
		end
	})

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		self["m_comboHead" .. iter_7_0].sprite = getSpriteViaConfig("HeroLittleIcon", iter_7_1)
	end

	self.combRoleNumController:SetSelectedIndex(#ComboSkillCfg[self.comboId].cooperate_role_ids)
end

function HeroTrammelsComboItem:RefreshRedPoint()
	local var_9_0 = ComboSkillData:GetCurComboSkillLevel(self.comboId)

	if var_9_0 < ComboSkillTools.GetMaxComboSkillLevel(self.comboId) then
		local var_9_1 = true

		for iter_9_0, iter_9_1 in ipairs(ComboSkillLevelCfg.get_id_list_by_level[var_9_0]) do
			if not ComboSkillTools.CheckComboSkillUpContion(iter_9_1, self.comboId) then
				var_9_1 = false

				break
			end
		end

		if var_9_1 then
			manager.redPoint:SetRedPointIndependent(self.transform_, true)
		else
			manager.redPoint:SetRedPointIndependent(self.transform_, false)
		end
	else
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end
end

function HeroTrammelsComboItem:RefreshState(arg_10_1)
	self.stateController:SetSelectedIndex(arg_10_1 == self.comboId and 1 or 0)
end

function HeroTrammelsComboItem:SetActive(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)

	if not arg_11_1 then
		self.comboId = 0
	end
end

function HeroTrammelsComboItem:RegistCallBack(arg_12_1)
	self.callback_ = arg_12_1
end

function HeroTrammelsComboItem:GetComboId()
	return self.comboId
end

function HeroTrammelsComboItem:Dispose()
	HeroTrammelsComboItem.super.Dispose(self)
end

return HeroTrammelsComboItem
