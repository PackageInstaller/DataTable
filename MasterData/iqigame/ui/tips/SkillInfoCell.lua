-- chunkname: @IQIGame\\UI\\Tips\\SkillInfoCell.lua

local SkillInfoCell = {
	damageTypeCellPool = {}
}
local DamageTypeCell = require("IQIGame.UI.Common.DamageTypeCell")

function SkillInfoCell.New(go)
	local o = Clone(SkillInfoCell)

	o:Initialize(go)

	return o
end

function SkillInfoCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.tfName = self.goName:GetComponent("Text")
	self.tfType = self.goSkillType:GetComponent("Text")
	self.tfReleaseType = self.goReleaseType:GetComponent("Text")
	self.tfAnger = self.goAnger:GetComponent("Text")
	self.tfCd = self.goCd:GetComponent("Text")
	self.damageTypeCellPool[1] = DamageTypeCell.New(self.goDamageType)
	self.skillCell = SkillCell.PackageOrReuseView(self, self.goSlotParent.transform:GetChild(0).gameObject)
end

function SkillInfoCell:RefreshView(cfgSkillData)
	self.cfgSkillData = cfgSkillData

	self:RefreshMisc()
end

function SkillInfoCell:OnDestroy()
	for i, v in pairs(self.damageTypeCellPool) do
		v:OnDestroy()
	end

	self.skillCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SkillInfoCell:RefreshMisc()
	self.tfName.text = SkillTipApi:GetString("goName", self.cfgSkillData.Name)
	self.tfReleaseType.text = SkillTipApi:GetString("goReleaseType", self.cfgSkillData.ReleaseType)

	local cfgSkillDetailData = CfgSkillDetailTable[self.cfgSkillData.SkillDetail]

	self.tfCd.text = SkillTipApi:GetString("goCd", cfgSkillDetailData.CoolDown)
	self.tfAnger.text = SkillTipApi:GetString("goAnger", cfgSkillDetailData.HeroEnergyCost)

	local isShow = SkillTipApi:GetString("showSkillType", self.cfgSkillData.ShowType)

	self.goSkillType.transform.parent.gameObject:SetActive(isShow)

	if isShow then
		self.tfType.text = SkillTipApi:GetString("goSkillTypeTxtInCellInfo", self.cfgSkillData.ShowType)
	end

	self.skillCell:SetSkill(self.cfgSkillData.Id)

	for i, v in pairs(self.damageTypeCellPool) do
		v:Close()
	end

	local types = SkillModule.GetDamageTypes({
		self.cfgSkillData.Id
	})

	for i, v in ipairs(types) do
		local cell = self:GetDamageTypeCell(i)

		cell:Open(v, true)
	end
end

function SkillInfoCell:GetDamageTypeCell(index)
	local ret = self.damageTypeCellPool[index]

	if ret == nil then
		local goClone = UnityEngine.Object.Instantiate(self.goDamageType)

		goClone.transform:SetParent(self.goDamageType.transform.parent, false)

		ret = DamageTypeCell.New(goClone)
		self.damageTypeCellPool[index] = ret
	end

	return ret
end

return SkillInfoCell
