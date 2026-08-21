-- chunkname: @IQIGame\\Module\\Battle\\BattleDamageEffect\\BattleDamageEffectCritical.lua

BattleDamageEffectCritical = class(nil, BaseBattleDamageEffect)

function BattleDamageEffectCritical:InitProperties()
	self.base:InitProperties()

	self.CriticalTMP = self.CriticalObj ~= nil and self.CriticalObj:GetComponent(typeof(TMPro.TextMeshProUGUI)) or nil
end

function BattleDamageEffectCritical:DisposeProperties()
	self.CriticalTMP = nil

	self.base:DisposeProperties()
end

function BattleDamageEffectCritical:SetTMPProperties(isCure, elementType)
	if self.textMeshProUGUI ~= nil then
		local colorString, materialID = self:GetSpecialEffectConfigData(isCure, elementType)

		if self.CriticalTMP ~= nil then
			UGUIUtil.SetHtmlColor(self.CriticalTMP, colorString)

			local fontMaterial = BattleResourceManager.GetBattleDamageTMPMaterial(materialID)

			if fontMaterial ~= nil then
				self.CriticalTMP.fontSharedMaterial = fontMaterial
			end
		end

		UGUIUtil.SetHtmlColor(self.textMeshProUGUI, colorString)

		local fontMaterial = BattleResourceManager.GetBattleDamageTMPMaterial(materialID)

		if fontMaterial ~= nil then
			self.textMeshProUGUI.fontSharedMaterial = fontMaterial
		end
	end
end

function BattleDamageEffectCritical:SetShowInfo(damageNumber, elementType)
	LuaUtility.SetGameObjectShow(self.CriticalObj, true)

	if damageNumber < 0 then
		damageNumber = -damageNumber

		self:SetTMPProperties(true, elementType)
	else
		self:SetTMPProperties(false, elementType)
	end

	if self.isSerialHitState then
		self:SetFinalDamageStrInSerialHitState(damageNumber)
	else
		self:SetFinalDamageStr(damageNumber)
	end
end

function BattleDamageEffectCritical:SetFinalDamageStr(damageNumber)
	local numStr = tostring(damageNumber)
	local finalInfoTb = {}

	table.insert(finalInfoTb, self.EffectHelper.PrefixTags)

	local richStr

	for i = 1, #numStr do
		richStr = string.sub(numStr, i, i)

		if i == 1 then
			richStr = self:AddRotEffectTagToNum(richStr)
		end

		richStr = self:AddOffsetEffectTagToNum(i % 2 ~= 0, richStr)

		table.insert(finalInfoTb, richStr)
	end

	self.DamageStr = table.concat(finalInfoTb)
end

function BattleDamageEffectCritical:SetFinalDamageStrInSerialHitState(damageNumber)
	if self.EffectHelper ~= nil then
		self.DamageStr = self.EffectHelper.PrefixTags .. tostring(damageNumber)
	else
		self.DamageStr = tostring(damageNumber)
	end
end

function BattleDamageEffectCritical:AddOffsetEffectTagToNum(isOdd, num)
	local tb = {}

	if isOdd then
		table.insert(tb, "{offset a=-1}")
	else
		table.insert(tb, "{offset a=1}")
	end

	table.insert(tb, num)
	table.insert(tb, "{/offset}")

	return table.concat(tb)
end

function BattleDamageEffectCritical:AddRotEffectTagToNum(num)
	local tb = {}

	table.insert(tb, "{rot}")
	table.insert(tb, num)
	table.insert(tb, "{/rot}")

	return table.concat(tb)
end
