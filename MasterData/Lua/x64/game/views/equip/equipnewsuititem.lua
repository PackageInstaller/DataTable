local EquipNewSuitItem = class("EquipNewSuitItem", ReduxView)
local EquipTools = import("game.tools.EquipTools")

function EquipNewSuitItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:Init()
end

function EquipNewSuitItem:RefreshData(arg_2_1, arg_2_2)
	self.heroData_ = arg_2_1
	self.info_ = arg_2_2

	self:Render()
end

function EquipNewSuitItem:InitUI()
	self:BindCfgUI()

	self.activeController_ = self.activeCon_:GetController("active")

	TerminologyTools.AddTerminologyHandler(self, self.desc_, nil, nil)
end

function EquipNewSuitItem:Render()
	self:RefreshUI()
end

function EquipNewSuitItem:Init()
	return
end

function EquipNewSuitItem:RefreshUI()
	if self.info_ then
		local var_6_0 = self.info_.num >= EquipTools.GetSuitNeedNum(self.info_.id, (HeroTools.GetIsSuitNumCut(self.heroData_)))
		local var_6_1 = self.info_.equipId == nil and true or HeroData:GetEquipMap()[self.info_.equipId] ~= nil
		local var_6_2 = EquipSuitCfg[self.info_.id]
		local var_6_3 = EquipSuitCfg[self.info_.id].need

		self.name_.text = GetI18NText(EquipSuitCfg[self.info_.id].name)

		if var_6_1 then
			self.activeController_:SetSelectedState(var_6_0 and "active" or "inactive")
		else
			self.activeController_:SetSelectedState("normal")
		end

		self.num_.text = string.format(GetTips("EQUIP_SUIT_NUM"), var_6_3)
		self.desc_.text = GetI18NText(EquipTools.GetEffectDesc(var_6_2.suit_effect[1]))
	end
end

function EquipNewSuitItem:ShowSelect(arg_7_1)
	SetActive(self.select_, arg_7_1)
end

function EquipNewSuitItem:OnClick()
	if self.clickFunc then
		self.clickFunc(self.info_)
	end
end

function EquipNewSuitItem:RegistCallBack(arg_9_1)
	self.clickFunc = arg_9_1
end

function EquipNewSuitItem:GetItemInfo()
	return self.info_
end

function EquipNewSuitItem:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function EquipNewSuitItem:Dispose()
	self.clickFunc = nil

	self:RemoveAllListeners()
	EquipNewSuitItem.super.Dispose(self)
end

return EquipNewSuitItem
