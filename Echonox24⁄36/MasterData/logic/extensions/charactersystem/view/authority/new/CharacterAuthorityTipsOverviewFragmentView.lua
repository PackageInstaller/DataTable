-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/authority/new/CharacterAuthorityTipsOverviewFragmentView.lua

module("logic.extensions.charactersystem.view.authority.new.CharacterAuthorityTipsOverviewFragmentView", package.seeall)

local M = class("CharacterAuthorityTipsOverviewFragmentView", StaticFragmentView)
local MatchCodes = {
	{
		5001,
		5002,
		5003
	},
	{
		5101,
		5102,
		5103
	},
	{
		5301,
		5302,
		5303
	},
	{
		5201,
		5202,
		5203
	},
	{
		5401,
		5402,
		5403
	}
}
local MatchCodesNumber = {
	BattleExtension_pb.AttributePart.PART_MAX_HP_BASE,
	BattleExtension_pb.AttributePart.PART_ATK_PHY_BASE,
	BattleExtension_pb.AttributePart.PART_ATK_MAG_BASE,
	BattleExtension_pb.AttributePart.PART_DEF_PHY_BASE,
	BattleExtension_pb.AttributePart.PART_DEF_MAG_BASE
}

function M:buildUI()
	local registry = self._registry

	self._skillTipsBindGo = registry:findUIElement("authority_main_panel_copy_-98115819")
	self._contentRoot = registry:findUIElement("authority_main_panel_copy_-860323630", UIComponentType.RectTransform)
	self._goTxtContentRoot = registry:findUIElement("authority_main_panel_copy_1233139457", UIComponentType.RectTransform)
	self._goSkillContent = registry:findUIElement("authority_main_panel_copy_2134902923", UIComponentType.RectTransform)
	self._goEmpty = registry:findUIElement("empty_unit_-1401348703")

	goutil.setActive(registry:findUIElement("empty_unit_-1492724947"), false)
end

function M:destroyUI()
	for _, cell in pairs(self._cellSkill or {}) do
		cell.btnClick:RemoveClickListener()
	end

	self._skillTipsBindGo = nil
	self._contentRoot = nil
	self._goTxtContentRoot = nil
	self._goSkillContent = nil
	self._heroData = nil
	self._maxPowerLevel = nil
	self._maxNodeId = nil
	self._attrMap = nil
	self._allNodeUnlockCount = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	Astral.GeometryUtil.SetAnchorPosY(self._contentRoot, 0)
end

function M:onExit()
	return
end

function M:setHeroData(heroData, maxPowerLv)
	self._heroData = heroData
	self._maxPowerLevel = maxPowerLv
	self._maxNodeId = maxPowerLv * 5
end

function M:refreshPanel(nodeLv, nodeIndexInLv, nodeId)
	self._nodeLv = nodeLv
	self._nodeIndexInLv = nodeIndexInLv
	self._nodeId = nodeId

	if not self._nodeLv or not self._nodeId then
		return
	end

	if not self._heroData then
		return
	end

	local allNodeUnlockCount = CharacterAuthorityModel.instance:getAllNodeUnlockCount(self._heroData:getId())

	if self._allNodeUnlockCount and self._allNodeUnlockCount == allNodeUnlockCount then
		return
	end

	self._allNodeUnlockCount = allNodeUnlockCount

	goutil.setActive(self._goEmpty, allNodeUnlockCount == 0)
	self:_updateAttrs(self._heroData)
	self:_updateSkill(self._heroData)
end

function M:checkInAttrs(code)
	if not self._attrMap then
		self._attrMap = {}
	end

	if self._attrMap[code] then
		return true
	end

	for k, v in pairs(MatchCodes) do
		for k1, v1 in pairs(v) do
			if v1 == code then
				self._attrMap[code] = true

				return true
			end
		end
	end

	return false
end

function M:_updateAttrs(heroData)
	local attrs = HeroPowerConfig.instance:getHeroAdditionAttr(heroData:getId())
	local showAttrs = {}
	local hadAttrs = false

	for k, v in pairs(attrs) do
		local co = v.co
		local isUnlock = CharacterAuthorityModel.instance:checkNodeIsUnlock(heroData:getId(), co.code)
		local attr = v.attr
		local attrCode = tonumber(attr.key)

		if isUnlock then
			showAttrs[attrCode] = showAttrs[attrCode] or 0
			showAttrs[attrCode] = showAttrs[attrCode] + attr.value
			hadAttrs = true
		end
	end

	local realShowAttr = {}

	for k, v in pairs(MatchCodes) do
		local maxBaseValue = showAttrs[v[1]] or 0
		local multiValue = showAttrs[v[2]] or 0
		local fixedAddValue = showAttrs[v[3]] or 0
		local baseValue = heroData:getAttrPartsBase(MatchCodesNumber[k])
		local value = maxBaseValue + fixedAddValue + MathUtil.roundingBy456(baseValue * multiValue)

		if value ~= 0 then
			table.insert(realShowAttr, {
				code = v[1],
				value = value
			})
		end
	end

	for k, v in pairs(showAttrs) do
		if not self:checkInAttrs(k) then
			table.insert(realShowAttr, {
				code = k,
				value = v
			})
		end
	end

	local addDataLen = #realShowAttr

	while self._goTxtContentRoot.childCount < #realShowAttr + 1 do
		goutil.cloneAndSetParent(self._goTxtContentRoot:GetChild(1).gameObject, self._goTxtContentRoot)
	end

	for i = 1, self._goTxtContentRoot.childCount - 1 do
		local attrGo = self._goTxtContentRoot:GetChild(i).gameObject
		local show = i <= #realShowAttr

		if show then
			local data = realShowAttr[i]
			local txtName = goutil.findChildTextComponent(attrGo, "Text1")
			local txtValue = goutil.findChildTextComponent(attrGo, "Text2")
			local co = AttributeDefineConfig.instance:getAttributePartDefineCO(data.code)

			txtName.text = co and co.name or ""
			txtValue.text = data.value
		end

		goutil.setActive(attrGo, show)
	end
end

function M:_updateSkill(heroData)
	local characterCO = heroData:getCharacterCo()
	local allAddSkillNodeLst = HeroPowerConfig.instance:getAllAddSkillNodeLst(heroData:getId())
	local skillDataMap = {}
	local skillOrder = {}

	for _, skillId in ipairs(characterCO.normalSkills or {}) do
		local config1001 = SkillEnhanceMO.New(skillId)
		local hasEnhanceDesc = {}

		for _, enhanceData in ipairs(HeroPowerConfig.instance:getAllSkillEnhanceNodeLst(heroData:getId(), skillId) or {}) do
			if CharacterAuthorityModel.instance:checkNodeIsUnlock(heroData:getId(), enhanceData.nodeId) then
				config1001:addSkillEnhanceCode(enhanceData.effectId)

				local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(enhanceData.effectId)
				local enchanceText = skillEnhanceCOWrapper:getDescription() or ""

				table.insert(hasEnhanceDesc, {
					nodeId = enhanceData.nodeId,
					desc = enchanceText
				})
			end
		end

		if #hasEnhanceDesc > 0 then
			config1001:rebuild()

			if not skillDataMap[skillId] then
				skillDataMap[skillId] = {}
				skillDataMap[skillId].skillId = skillId
				skillDataMap[skillId].name = config1001:getName()
				skillDataMap[skillId].skillDesc = config1001:getDescription()
				skillDataMap[skillId].addSkill = false
				skillDataMap[skillId].enhance = hasEnhanceDesc
			end

			if not table.indexof(skillOrder, skillId) then
				table.insert(skillOrder, skillId)
			end
		end
	end

	for _, data in ipairs(allAddSkillNodeLst or {}) do
		local nodeId = data.nodeId
		local isUnlock = CharacterAuthorityModel.instance:checkNodeIsUnlock(heroData:getId(), nodeId)

		if isUnlock then
			local skillId = data.skillId
			local config1001 = SkillEnhanceMO.New(skillId)
			local hasEnhanceDesc = {}

			for _, enhanceData in ipairs(HeroPowerConfig.instance:getAllSkillEnhanceNodeLst(heroData:getId(), skillId) or {}) do
				if CharacterAuthorityModel.instance:checkNodeIsUnlock(heroData:getId(), enhanceData.nodeId) then
					config1001:addSkillEnhanceCode(enhanceData.effectId)

					local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(enhanceData.effectId)
					local enchanceText = skillEnhanceCOWrapper:getDescription() or ""

					table.insert(hasEnhanceDesc, {
						nodeId = enhanceData.nodeId,
						desc = enchanceText
					})
				end
			end

			config1001:rebuild()

			if not skillDataMap[skillId] then
				skillDataMap[skillId] = {}
				skillDataMap[skillId].skillId = skillId
				skillDataMap[skillId].name = config1001:getName()
				skillDataMap[skillId].skillDesc = config1001:getDescription()
				skillDataMap[skillId].addSkill = true
				skillDataMap[skillId].enhance = hasEnhanceDesc
			end

			if not table.indexof(skillOrder, skillId) then
				table.insert(skillOrder, skillId)
			end
		end
	end

	local len = #skillOrder

	self._cellSkill = {}

	while self._contentRoot.childCount < len + 1 do
		goutil.cloneAndSetParent(self._goSkillContent.gameObject, self._contentRoot)
	end

	for i = 1, self._contentRoot.childCount - 1 do
		local go = self._contentRoot:GetChild(i).gameObject
		local cell = self:_buildSkillCell(go)
		local data = skillOrder[i] and skillDataMap[skillOrder[i]] or nil

		cell.updateData(data)

		self._cellSkill[i] = cell

		goutil.setActive(go, i <= len)
	end
end

function M:_buildSkillCell(go)
	local cell = {}

	cell.go = go
	cell.txtName = goutil.findChildTextComponent(go, "skillContent/txtName")
	cell.txtSkillDesc = goutil.findChildComponent(go, "txtContent/Text (TMP)", UIComponentType.TextMeshProUGUI)
	cell.skillIcon = goutil.findChildImageComponent(go, "skillContent/skill_item_1/imgIcon")
	cell.goSkillUpgradeMark = goutil.findChild(go, "skillContent/Image1").gameObject
	cell.contentRoot = goutil.findChildComponent(go, "authorityContent", UIComponentType.RectTransform)
	cell.btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "skillContent/skill_item_1/click").gameObject)

	cell.btnClick:AddClickListener(function()
		self:_onSkillItemClick(cell.skillId)
	end, self)

	function cell.updateData(data)
		if not data then
			return
		end

		goutil.setActive(cell.goSkillUpgradeMark, #data.enhance > 0)

		cell.skillId = data.skillId
		cell.txtName.text = data.name
		cell.txtSkillDesc.text = data.skillDesc

		local skillCO = ActiveSkillConfig.instance:getActiveSkillCO(data.skillId)

		IconLoader.setSprite(cell.skillIcon, IconType.SkillIcon, ActiveSkillCOUtil.getSkillIcon(skillCO))

		while cell.contentRoot.childCount < #data.enhance do
			goutil.cloneAndSetParent(cell.contentRoot:GetChild(0).gameObject, cell.contentRoot)
		end

		for i = 0, cell.contentRoot.childCount - 1 do
			local _go = cell.contentRoot:GetChild(i).gameObject
			local _show = i < #data.enhance

			if _show then
				local txtDesc = goutil.findChildTextComponent(_go, "txtContent")
				local imgNodeLv = goutil.findChildImageComponent(_go, "level/txtNum1")
				local txtNodeIndexInLv = goutil.findChildTextComponent(_go, "level/txtNum2")
				local nodeId = data.enhance[i + 1].nodeId
				local nodeIndexInLv = nodeId % 5

				nodeIndexInLv = nodeIndexInLv == 0 and 5 or nodeIndexInLv
				txtDesc.text = data.enhance[i + 1].desc

				IconLoader.setSprite(imgNodeLv, IconType.DynSpriteAtlas_CharacterSystem_Authority, GameUrl.getAuthorityLevelNum(math.ceil(nodeId / 5)))

				txtNodeIndexInLv.text = nodeIndexInLv
			end

			goutil.setActive(_go, _show)
			goutil.setActive(cell.txtSkillDesc.gameObject, not _show)
		end
	end

	return cell
end

function M:_onSkillItemClick(skillId)
	local heroData = self._heroData
	local heroId = heroData:getId()
	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = heroId
	skillInfo.skillId = skillId
	skillInfo.defaultShowAll = false
	skillInfo.hangGO = self._skillTipsBindGo

	ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
end

return M
