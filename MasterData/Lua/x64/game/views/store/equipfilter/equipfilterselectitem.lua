local EquipFilterSelectItem = class("EquipFilterSelectItem", ReduxView)

function EquipFilterSelectItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function EquipFilterSelectItem:Dispose()
	EquipFilterSelectItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function EquipFilterSelectItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		manager.notify:Invoke(EQUIP_FILTER_SELECT_CHANGE, {
			type = self.data_.type,
			id = self.data_.id,
			state = StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.REMOVE
		})
	end)
end

function EquipFilterSelectItem:SetData(arg_5_1)
	self.data_ = arg_5_1

	self:Show(true)

	self.nameText_.text = arg_5_1.type == StoreConst.EQUIP_FILTER_TYPE.SUIT and GetI18NText(EquipSuitCfg[arg_5_1.id].name) or GetI18NText(EquipSkillCfg[arg_5_1.id].name)
end

function EquipFilterSelectItem:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

return EquipFilterSelectItem
