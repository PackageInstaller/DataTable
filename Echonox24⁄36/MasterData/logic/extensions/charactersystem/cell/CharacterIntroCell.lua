-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/cell/CharacterIntroCell.lua

module("logic.extensions.charactersystem.cell.CharacterIntroCell", package.seeall)

local M = class("CharacterIntroCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()

	self._imgIcon = goutil.findChildImageComponent(mainGO, "imgIcon")
	self._txtName = goutil.findChildTextComponent(mainGO, "txtName")
	self._txtContent = goutil.findChildTextComponent(mainGO, "txtContent")
	self._txtRange = goutil.findChildTextComponent(mainGO, "tab1/txtNum")
	self._txtMobility = goutil.findChildTextComponent(mainGO, "tab2/txtNum")
end

function M:updateCareerData(conf)
	if not conf then
		return
	end

	IconLoader.setSprite(self._imgIcon, IconType.Skinlib, CommEnum.Career2IconNoDi[conf.career])

	self._txtName.text = CommEnum.Career2Name[conf.career]
	self._txtContent.text = conf.desc
	self._txtRange.text = conf.range
	self._txtMobility.text = conf.mobility
end

function M:updateLabelData(conf)
	if not conf then
		return
	end

	local id = tonumber(conf.id)
	local tagCO = ActiveSkillConfig.instance:getSkillTagCO(id)
	local iconName = ActiveSkillConfig.instance:getTagBigIconName(tagCO.typeName)

	IconLoader.setSprite(self._imgIcon, IconType.SkillEffectLabel, iconName)

	self._txtName.text = tagCO.name
	self._txtContent.text = tagCO.desc
end

function M:getMainGo()
	return self.mainGO
end

return M
