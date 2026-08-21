-- chunkname: @IQIGame\\UI\\DiySkill\\Strengthen\\DiyBreachAttrItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function m:Show(attrData)
	self.gameObject:SetActive(true)
end

function m:SetData(attrData)
	local attrCfg = CfgAttributeTable[attrData.type]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(attrCfg.ImageUrl), self.AttImg:GetComponent("Image"))
	UGUIUtil.SetText(self.textName, attrCfg.Name)
	UGUIUtil.SetText(self.textNowProperty, attrData.curLvValue)
	UGUIUtil.SetText(self.textTargetProperty, attrData.nextLvValue)
end

function m:Hide()
	self.gameObject:SetActive(false)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return m
