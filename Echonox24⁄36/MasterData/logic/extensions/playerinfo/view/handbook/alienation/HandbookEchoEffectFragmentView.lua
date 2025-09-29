-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/alienation/HandbookEchoEffectFragmentView.lua

module("logic.extensions.playerinfo.view.handbook.alienation.HandbookEchoEffectFragmentView", package.seeall)

local M = class("HandbookEchoEffectFragmentView", StaticFragmentView)

function M:ctor(mainGO, viewPresentor)
	M.super.ctor(self, mainGO)

	self._viewPresentor = viewPresentor
end

function M:buildUI()
	self._txtEchoName = self._registry:getText("handbook_alienation_carry_view_631555094")
	self._imgEchoIcon = self._registry:getImage("handbook_alienation_carry_view_2066041729")
	self._limitGo = self._registry:getGo("handbook_alienation_carry_view_469391027")
	self._imgCareerDi = self._registry:getImage("1&career_-1600786498")
	self._imgCareerSign = self._registry:getImage("1&career_1390243743")
	self._txtLimit2 = self._registry:getText("handbook_alienation_carry_view_683077230")
	self._txtDesc = self._registry:getText("handbook_alienation_carry_view_1382868616")
	self._txtDesc2 = self._registry:getText("handbook_alienation_carry_view_-1968559705")

	local attributeParent = self._registry:getGo("handbook_alienation_carry_view_1149928093")
	local attrList = Astral.GameObjectUtil.GetChildren(attributeParent)

	self._attrViewList = {}

	for index = 1, attrList.Length - 1 do
		local view = Astral.LuaComponentContainer.Add(attrList[index], EchoItemBreakAttrView)

		view:setIndex(index + 1)
		table.insert(self._attrViewList, view)
	end

	local breakPointGo = goutil.findChild(self.mainGO, "scroll/viewPort/content/info/breakLv/break_point")

	self._breakPointView = Astral.LuaComponentContainer.Add(breakPointGo, EchoItemBreakPointView)
	self._baseAttrLst = {}
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:getMainGo()
	return self.mainGO
end

function M:setEchoItemData(echoItemId)
	if not echoItemId then
		return
	end

	local echoMaxLevel = EchoItemConfig.instance:getMaxLevel(echoItemId)
	local echoItemLevel = echoMaxLevel
	local cfg = BackpackConfig.instance:getItemInfoByItemId(echoItemId)

	self._txtEchoName.text = cfg.name
	self._txtDesc2.text = cfg.desc

	local quality = cfg.quality

	IconLoader.setSprite(self._imgEchoIcon, IconType.EchoItemIcon, cfg.icon)

	if cfg.career > 0 then
		IconLoader.setSprite(self._imgCareerSign, IconType.Skinlib, CommEnum.Career2Icon[cfg.career])

		self._txtLimit2.text = CommEnum.Career2Name[cfg.career]
	end

	goutil.setActive(self._limitGo, cfg.career > 0)

	local attCfg = EchoItemConfig.instance:getCfg(echoItemId, echoItemLevel)
	local skillIds = attCfg and attCfg.skills or {}
	local skillEnhanceMo

	if #skillIds > 0 then
		skillEnhanceMo = SkillEnhanceMO.New(skillIds[1])

		if #skillIds > 1 then
			skillEnhanceMo:clear()

			for i = 2, #skillIds do
				skillEnhanceMo:addSkillEnhanceCode(skillIds[i])
			end
		end

		skillEnhanceMo:rebuild()
	end

	local highLightTagIds
	local descStr = skillEnhanceMo and skillEnhanceMo:getDescriptionTagHighLight(highLightTagIds) or ""

	self._txtDesc.text = TextUtils.GetPunctuationFixedText(descStr, self._txtDesc, 0, 200)

	for index, attrView in ipairs(self._attrViewList) do
		local showLevel = index + 1
		local isBreak = showLevel <= echoItemLevel
		local colorAttr = false
		local colorSkill = false
		local descSplit = false
		local data = {
			level = echoItemLevel,
			descSplit = descSplit,
			desc = EchoItemConfig.instance:getAttrDesc(echoItemId, showLevel, colorAttr, colorSkill, descSplit, highLightTagIds)
		}

		attrView:setData(data, echoMaxLevel)
	end

	self._breakPointView:setEchoItemLevel(echoItemLevel, echoMaxLevel)

	local attLst = EchoItemConfig.instance:getAttrLst(echoItemId, echoItemLevel)
	local attCount = #attLst

	for index, comps in ipairs(self._baseAttrLst) do
		local data = attLst[index]
		local show = data ~= nil

		if show then
			local cfgAttDefine = AttributeDefineConfig.instance:getAttributePartDefineCO(data.id)

			comps.txtName.text = cfgAttDefine and cfgAttDefine.name or ""
			comps.txtAttr.text = data.num
		end

		goutil.setActive(comps.root, show)
	end
end

return M
