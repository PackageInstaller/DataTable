-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroPetTipsView.lua

module("logic.extensions.aoqihero.view.AoqiHeroPetTipsView", package.seeall)

local AoqiHeroPetTipsView = class("AoqiHeroPetTipsView", ViewComponent)

function AoqiHeroPetTipsView:ctor()
	AoqiHeroPetTipsView.super.ctor(self)
end

function AoqiHeroPetTipsView:unbindEvents()
	AoqiHeroPetTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnAttack)
	GameUtil.rmClickHandler(self._btnDefence)
end

function AoqiHeroPetTipsView:bindEvents()
	AoqiHeroPetTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnAttack, self._onClickAttack, self)
	GameUtil.addClickHandler(self._btnDefence, self._onClickDefence, self)
end

function AoqiHeroPetTipsView:buildUI()
	AoqiHeroPetTipsView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._Nego_Content = self:getGo("Nego_Content")
	self._TxtC_Name = self:getTxt("Nego_Content/Nego_Top/TxtC_Name")
	self._ImgC_Con = self:getGo("Nego_Content/Nego_Top/ImgC_Con")
	self._TxtC_Level = self:getTxt("Nego_Content/Nego_Top/TxtC_Level")
	self._attrIcon = self:getGo("Nego_Content/Nego_Top/Nego_Attr/Img_attr"):GetComponent("UIImageSpriteChange")
	self._Nego_Attr = self:getGo("Nego_Content/Nego_Top/Nego_Attr")
	self._adjustPosition = self._Nego_Content:GetComponent("UIAdjustPosition")
	self._btnAttack = self:getGo("Nego_Content/Nego_Skill/btnAttack")
	self._btnDefence = self:getGo("Nego_Content/Nego_Skill/btnDefence")
	self._imgChangeAttackBtn = self._btnAttack:GetComponent(ComponentType.UIChangeGroup)
	self._imgChangeDefecnceBtn = self._btnDefence:GetComponent(ComponentType.UIChangeGroup)

	self:_buildSkillsView()
end

function AoqiHeroPetTipsView:_buildSkillsView()
	self._skills = {}
	self._skills[1] = {}
	self._skills[1].go = self:getGo("Nego_Content/Nego_Skill")
	self._skills[1].negoCon = self:getGo("Nego_Content/Nego_Skill/scrollview/viewport/Nego_Con")
	self._skills[1].skillBtn = self:getGo("Nego_Content/Nego_Skill/skillBtn")
	self.skillDesc = self:getTxt("Nego_Content/Nego_desc/ScrollView/Viewport/txtDesc")
	self.skillType = self:getTxt("Nego_Content/Nego_desc/txtType")
	self.skillName = self:getTxt("Nego_Content/Nego_desc/txtName")
	self._imgRange = self:getGo("Nego_Content/Nego_desc/ScrollView/imgRange")
	self._scroll = self:getGo("Nego_Content/Nego_desc/ScrollView"):GetComponent("ScrollRect")
end

function AoqiHeroPetTipsView:onExit()
	AoqiHeroPetTipsView.super.onExit(self)
	MaterialMgr.resetAll(self._ImgC_Con)
end

function AoqiHeroPetTipsView:onEnter()
	AoqiHeroPetTipsView.super.onEnter(self)

	local params = self:getFirstParam()

	if params then
		self:_adjustView(params)

		self.parentPresentor = params.view
		self._activityId = checknumber(params.activityId)
		self._raceId = checknumber(params.raceId)
		self._isAttack = params.isAttack
		self._lv = params.lv or 1
		self._selectIndex = params.defIndex or 1

		self:checkPresentor()
	end

	Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
	self:_initPetTip()
end

function AoqiHeroPetTipsView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

function AoqiHeroPetTipsView:_initPetTip()
	local activityId = self._activityId
	local raceId = self._raceId
	local petCfg = AoQiHeroConfig.instance:getPetCfg(activityId, raceId)

	goutil.setActive(self._Nego_Attr, true)

	self._TxtC_Level.text = langPara("LV.%d", self._lv)

	if petCfg.elementId > 0 then
		self._attrIcon:SetState(petCfg.elementId - 1)
	end

	self._TxtC_Name.text = petCfg.name

	local skinId = checknumber((checknumber(petCfg.faceIds)))
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
	local showRaceId = petSkinCfg.raceId
	local proxy = MaterialMgr.setCell(MatType.Pet, showRaceId, self._ImgC_Con)

	if proxy then
		proxy:setAutoTips(false)
		proxy.binder:setSkin(skinId)
	end

	self:_refreshSkillView()
end

function AoqiHeroPetTipsView:_refreshSkillView()
	local activityId = self._activityId
	local raceId = self._raceId
	local petCfg = AoQiHeroConfig.instance:getPetCfg(activityId, raceId)
	local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, self._lv)
	local skillIds = {}
	local isAttack = self._isAttack

	if isAttack == true then
		table.insert(skillIds, propertyCfg.normalSkillId)
		table.insert(skillIds, propertyCfg.ultSkillId)
		self._imgChangeAttackBtn:SetState(0)
		self._imgChangeDefecnceBtn:SetState(1)
	else
		table.insert(skillIds, propertyCfg.defenseNormalSkillId)
		table.insert(skillIds, propertyCfg.defenseUltSkillId)
		self._imgChangeAttackBtn:SetState(1)
		self._imgChangeDefecnceBtn:SetState(0)
	end

	self:setSkills(skillIds, self._skills[1])
end

function AoqiHeroPetTipsView:setSkills(skillIds, skillCfg)
	skillCfg.items = skillCfg.items or {}

	for i = 1, #skillCfg.items do
		local view = skillCfg.items[i]

		goutil.destroy(view)
	end

	skillCfg.items = {}

	local count = 0

	goutil.clearChildren(skillCfg.negoCon)

	for k, skillId in ipairs(skillIds) do
		local item = goutil.clone(skillCfg.skillBtn, "item" .. k)

		goutil.addChildToParent(item, skillCfg.negoCon)
		GameUtil.SetActive(item, true)
		table.insert(skillCfg.items, item)

		count = count + 1

		local con = goutil.findChild(item, "con")

		GameUtil.addClickHandler(item, GameUtil.handler(self.onClickSkillIdx, self, skillId, count, skillCfg))

		if count == self._selectIndex then
			self:onClickSkillIdx(skillId, count, skillCfg)
		end

		local skillCo = AoQiHeroConfig.instance:getSkillCfg(skillId)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, skillCo.skillImg)
	end
end

function AoqiHeroPetTipsView:onClickSkillIdx(skillId, idx, skillCfg)
	for i, v in ipairs(skillCfg.items) do
		local select = goutil.findChild(v, "selected")

		GameUtil.SetActive(select, i == idx)
	end

	for i = 1, #self._skills do
		if self._skills[i] ~= skillCfg and self._skills[i].items then
			for j, v in ipairs(self._skills[i].items) do
				local select = goutil.findChild(v, "selected")

				GameUtil.SetActive(select, false)
			end
		end
	end

	local skillCo = AoQiHeroConfig.instance:getSkillCfg(skillId)

	self.skillDesc.text = skillCo.skillDesc

	if GameUtil.isEmptyString(skillCo.skillType) then
		-- block empty
	else
		local showTxt = "类型："
		local typeStrs = string.split(skillCo.skillType, "#")

		for i, str in ipairs(typeStrs) do
			showTxt = showTxt .. string.format("【%s】", str)
		end
	end

	self.skillType.text = skillCo.type

	uGuiUtil.clearImage(self._imgRange)

	if not string.nilorempty(skillCo.rangeImg) and self._isAttack == true then
		GameUtil.SetActive(self._imgRange, true)
		uGuiUtil.setSpriteToImage(self._imgRange, uGuiUtil.SpriteType.BigBg, skillCo.rangeImg)
	else
		GameUtil.SetActive(self._imgRange, false)
	end
end

function AoqiHeroPetTipsView:checkPresentor(callback)
	if not self.parentPresentor or not self.parentPresentor:isOpen() then
		self:close()

		return
	end

	GameUtil.callBack(callback)
end

function AoqiHeroPetTipsView:_adjustView(params)
	local pos = params.pos

	self.pos = pos
	self.sizeDelta = params.sizeDelta

	if pos then
		GameUtil.SetActive(self.mainGO, false)
		settimer(0.1, self.showMainGo, self, false)
	else
		Framework.TransformUtil.SetLocalPos(self._content.transform, 0, 0, 0)
	end
end

function AoqiHeroPetTipsView:showMainGo()
	GameUtil.SetActive(self.mainGO, true)
	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
	self._adjustPosition:AdjustScreenPosition(self.pos, self.sizeDelta[1], self.sizeDelta[2])
	self:checkPresentor()
end

function AoqiHeroPetTipsView:_onClickAttack()
	self._isAttack = true

	self:_refreshSkillView()
end

function AoqiHeroPetTipsView:_onClickDefence()
	self._isAttack = false

	self:_refreshSkillView()
end

return AoqiHeroPetTipsView
