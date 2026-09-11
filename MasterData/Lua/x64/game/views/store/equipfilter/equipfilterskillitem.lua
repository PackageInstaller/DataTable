local EquipFilterSkillItem = class("EquipFilterSkillItem", ReduxView)

function EquipFilterSkillItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controllerEx_:GetController("state")
end

function EquipFilterSkillItem:Dispose()
	EquipFilterSkillItem.super.Dispose(self)
end

function EquipFilterSkillItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.data_.cnt <= 0 then
			return
		end

		manager.notify:Invoke(EQUIP_FILTER_SELECT_CHANGE, {
			type = self.data_.type,
			id = self.data_.id,
			state = (self.selectState_ == StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD or nil) and StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD
		})
	end)
end

function EquipFilterSkillItem:SetData(arg_5_1, arg_5_2)
	self.data_ = arg_5_1
	self.selectState_ = arg_5_2
	self.name_.text = GetI18NText(EquipSkillCfg[arg_5_1.id].name)
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. EquipSkillCfg[arg_5_1.id].icon)
	self.num_.text = arg_5_1.cnt

	if arg_5_1.cnt <= 0 then
		self.selectController_:SetSelectedState("lock")
	elseif arg_5_2 then
		self.selectController_:SetSelectedState("select")

		self.selectState_ = StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.REMOVE
	else
		self.selectController_:SetSelectedState("false")

		self.selectState_ = StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD
	end
end

function EquipFilterSkillItem:GetData()
	return self.data_
end

return EquipFilterSkillItem
