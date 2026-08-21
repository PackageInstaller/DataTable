-- chunkname: @IQIGame\\UI\\Formation\\RoleDetailsInfo\\FormationBaseSkillView.lua

local m = {
	SkillItemList = {}
}
local formationSkillDetailsCell = require("IQIGame.UI.Formation.ItemCell.FormationSkillDetailsCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 3 do
		local SkillItemObj = UnityEngine.Object.Instantiate(self.SkillItemPrefab)

		SkillItemObj.transform:SetParent(self.SkillGroup.transform, false)
		table.insert(self.SkillItemList, formationSkillDetailsCell.New(SkillItemObj))
	end

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(heroData)
	for i = 1, #self.SkillItemList do
		self.SkillItemList[i]:SetData(i, heroData)
	end
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()

	for i = 1, #self.SkillItemList do
		self.SkillItemList[i]:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
