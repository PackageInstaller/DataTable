local EquipSkillInfoView = class("EquipSkillInfoView", ReduxView)

function EquipSkillInfoView:UIName()
	return "Widget/System/Hero_equip/EquipSkillPopUI"
end

function EquipSkillInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function EquipSkillInfoView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, EquipSkillInfoItem2)
end

function EquipSkillInfoView:OnEnter()
	if self.equipSkillData_ and self.equipSkillData_.id == self.params_.equipSkillData.id then
		return
	end

	self.equipSkillData_ = self.params_.equipSkillData

	self:RefreshUI()
end

function EquipSkillInfoView:OnExit()
	return
end

function EquipSkillInfoView:Dispose()
	EquipSkillInfoView.super.Dispose(self)
	self.uiList_:Dispose()

	self.uiList_ = nil
end

function EquipSkillInfoView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self.selectItem_:ShowSelect(false)
		self:Back()
	end)
end

function EquipSkillInfoView:RefreshUI()
	self.selectItem_ = self.equipSkillData_.selectItem

	self.selectItem_:ShowSelect(true)

	self.iconImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. EquipSkillCfg[self.equipSkillData_.id].icon)
	self.nameText_.text = GetI18NText(EquipSkillCfg[self.equipSkillData_.id].name)
	self.lvText_.text = string.format("%s/%s", self.equipSkillData_.skillLevel, EquipSkillCfg[self.equipSkillData_.id].lvmax)

	self.uiList_:StartScroll(EquipSkillCfg[self.equipSkillData_.id].lvmax)
end

function EquipSkillInfoView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.equipSkillData_.id, self.equipSkillData_.skillLevel, arg_10_1)
end

return EquipSkillInfoView
