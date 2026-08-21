-- chunkname: @IQIGame\\UI\\Equip\\EquipAdditionalAttributeCell.lua

local EquipAdditionalAttributeCell = {
	isChoose = false,
	isLock = false
}

function EquipAdditionalAttributeCell.New(go)
	local o = Clone(EquipAdditionalAttributeCell)

	o:Initialize(go)

	return o
end

function EquipAdditionalAttributeCell:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.graphicColorChange = self.gameObject:GetComponent("GraphicColorChange")
end

function EquipAdditionalAttributeCell:Refresh(equipData, attribute, index)
	local isUnlocked = attribute.OldAddAttNum ~= 0

	UGUIUtil.SetText(self.NameText, attribute.Name)

	local qualityPath

	if not isUnlocked then
		qualityPath = EquipApi:GetNewEquipOtherAttriActiveBgPath(0)

		self.graphicColorChange:EnablePreset(0)
		LuaUtility.SetTextFontSize(self.NameText, 18)
	else
		local qualityValue = EquipModule.GetQualityByAttribute(attribute.id, attribute.OldAddAttNum)

		qualityPath = EquipApi:GetNewEquipOtherAttriActiveBgPath(qualityValue)

		self.graphicColorChange:EnablePreset(1)
		LuaUtility.SetTextFontSize(self.NameText, 20)
	end

	local attrInerval = CfgEquipAttrTable[attribute.onlyId].AttrShowRange
	local attrCfg = CfgAttributeTable[attribute.id]

	UGUIUtil.SetText(self.intervalText, string.format("(%s-%s)", EquipApi:FormatAttrValue(attrCfg.IsPer, attrInerval[1]), EquipApi:FormatAttrValue(attrCfg.IsPer, attrInerval[2])))
	LuaUtility.SetGameObjectShow(self.intervalText, not isUnlocked)

	if not LuaUtility.StrIsNullOrEmpty(attribute.ImageUrl) then
		LuaUtility.LoadImage(self, attribute.ImageUrl, self.imageAttIcon:GetComponent("Image"))
	else
		self.imageAttIcon:GetComponent("Image").sprite = nil
	end

	LuaUtility.SetGameObjectShow(self.QualityIconImage, false)
	LuaUtility.SetGameObjectShow(self.ValueText, isUnlocked)
	UGUIUtil.SetText(self.ValueText, EquipApi:GetTextAddDescribe(attribute.AddAttNum))
	LuaUtility.SetGameObjectShow(self.UnlockConditionText, not isUnlocked)
	UGUIUtil.SetText(self.UnlockConditionText, EquipApi:GetUnLockLvDescribute(equipData:GetEquipCfg().CountCondition[index]))
end

function EquipAdditionalAttributeCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return EquipAdditionalAttributeCell
