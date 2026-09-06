-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleDomainSkillsView.lua

module("logic.extensions.battle.view.BattleDomainSkillsView", package.seeall)

local BattleDomainSkillsView = class("BattleDomainSkillsView", ViewComponent)

function BattleDomainSkillsView:buildUI()
	BattleDomainSkillsView.super.buildUI(self)

	self._btnClose = Framework.UIClickTrigger.Get(self:getGo("bgClosed"))
	self._leftPetsLayout = self:getGo("Node/leftSkills/PetsView/Viewport/Content/items"):GetComponent(ComponentType.UILayoutSingleLine)
	self._leftPetsContentNode = self:getGo("Node/leftSkills/PetsView/Viewport/Content")
	self._rightPetsLayout = self:getGo("Node/rightSkills/PetsView/Viewport/Content/items"):GetComponent(ComponentType.UILayoutSingleLine)
	self._rightPetsContentNode = self:getGo("Node/rightSkills/PetsView/Viewport/Content")
	self._skillsContentNode = self:getGo("Node/SkillsView/Viewport/Content")
	self._skillsVpSize = self:getGo("Node/SkillsView/Viewport").transform.rect.height
	self._skillsViewBg = self:getGo("Node/SkillsView"):GetComponent(ComponentType.UIImageColorChange)
end

function BattleDomainSkillsView:bindEvents()
	BattleDomainSkillsView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function BattleDomainSkillsView:unbindEvents()
	BattleDomainSkillsView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function BattleDomainSkillsView:onEnter()
	BattleDomainSkillsView.super.onEnter(self)

	self._leftUnits = BattleDoaminSkillMgr.instance:getDomainSkillUnits()
	self._rightUnits = BattleDoaminSkillMgr.instance:getEnemyDomainSkillUnits()
	self._isFirstRefresh = true

	self:_refreshView()

	self._isFirstRefresh = nil

	GlobalDispatcher:addListener(GlobalNotify.OnDomainSkillTrigged, self._onDomainSkillTrigged, self)
	GlobalDispatcher:addListener(GlobalNotify.OnDomainSkillRemoved, self._onDomainSkillRemoved, self)
end

function BattleDomainSkillsView:_refreshView()
	local var_5_0 = self._currPetData

	if not self._currPetData then
		var_5_0 = BattleDoaminSkillMgr.instance:getCurrDomainSkill()
		var_5_0 = var_5_0 or self._leftUnits[1]
	end

	self:_selectPet(var_5_0)
end

function BattleDomainSkillsView:onExit()
	BattleDomainSkillsView.super.onExit(self)

	self._isFirstRefresh = nil
	self._currPetData = nil

	GlobalDispatcher:removeListener(GlobalNotify.OnDomainSkillTrigged, self._onDomainSkillTrigged, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnDomainSkillRemoved, self._onDomainSkillRemoved, self)
end

function BattleDomainSkillsView:onExitFinished()
	BattleDomainSkillsView.super.onExitFinished(self)

	local transform = self._leftPetsLayout.transform

	for i = 1, transform.childCount do
		local petNode = goutil.findChild(transform:GetChild(i - 1).gameObject, "petNode")

		MaterialMgr.resetAll(petNode)
	end

	transform = self._rightPetsLayout.transform

	for i = 1, self._rightPetsLayout.transform.childCount do
		local petNode = goutil.findChild(transform:GetChild(i - 1).gameObject, "petNode")

		MaterialMgr.resetAll(petNode)
	end

	self._leftUnits = nil
	self._rightUnits = nil
end

function BattleDomainSkillsView:_onClickClose()
	self:close()
end

function BattleDomainSkillsView:_selectPet(petData)
	self._currPetData = petData

	self:_refreshCurrSkillsView()
	self:_refreshPetsView(self._leftPetsContentNode, self._leftPetsLayout, self._leftUnits)
	self:_refreshPetsView(self._rightPetsContentNode, self._rightPetsLayout, self._rightUnits)
end

function BattleDomainSkillsView:_refreshCurrSkillsView()
	local raceId = self._currPetData.attrs:getOriginRaceId()
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local skinId = raceId
	local id = self._currPetData.attrs:getOriginSkinId()

	if checknumber(id) > 0 then
		skinId = checknumber(id)
	end

	local petCo = PetSkinConfig.instance:getPetSkinCfg(skinId)

	self:_refreshSkillsView(petCo.domainSkillId, skinId)
	self._skillsViewBg:SetState(self._currPetData.teamId)
end

function BattleDomainSkillsView:_refreshSkillsView(skillId, skinId)
	local curCfg = BattleConfig.instance:getSkillCo(skillId, skinId)
	local layerCos = BattleConfig.instance:getDomainSkillLevels(skillId)

	if not layerCos then
		printError("技能无配置：", skillId, skinId)
	end

	local transform = self._skillsContentNode.transform
	local childCount = transform.childCount
	local cnt = #layerCos

	while childCount < cnt do
		UGUIToolHelper.AddChild(transform.gameObject, transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	local posx, posy = 4, -20
	local offsetStart = 0
	local activeSize = 0
	local hasActived = false

	for i = 1, cnt do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local layerName = goutil.findChildTextComponent(go, "layerName")
		local desc = goutil.findChildTextComponent(go, "TxtC_Desc")
		local descBg = goutil.findChild(go, "descbg")
		local isActive = BattleDoaminSkillMgr.instance:isActive(self._currPetData, layerCos[i].skillId, layerCos[i].level)

		desc.text = layerCos[i].desc

		local preferredHeight = desc.preferredHeight
		local bgSize = descBg.transform.sizeDelta

		bgSize.y = preferredHeight + 10
		descBg.transform.sizeDelta = bgSize

		if isActive then
			layerName.text = string.format(lang("text_domainskill_active"), curCfg.name .. GameUtil.toRomanNumber(i))
			offsetStart = -posy
			activeSize = 54 + preferredHeight
			hasActived = true
		else
			layerName.text = string.format(lang("text_domainskill_notactive"), curCfg.name .. GameUtil.toRomanNumber(i))
		end

		Framework.TransformUtil.SetLocalPos(go.transform, posx, posy, 0)

		posy = posy - 54 - preferredHeight
	end

	for i = cnt + 1, childCount do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	local sizeDelta = self._skillsContentNode.transform.sizeDelta

	sizeDelta.y = -posy + 10
	self._skillsContentNode.transform.sizeDelta = sizeDelta

	if self._isFirstRefresh then
		local currx, curry = Framework.TransformUtil.GetAnchoredPos(self._skillsContentNode.transform, nil, nil)

		if offsetStart < curry then
			Framework.TransformUtil.SetAnchoredPos(self._skillsContentNode.transform, currx, offsetStart)
		elseif offsetStart > curry + self._skillsVpSize then
			Framework.TransformUtil.SetAnchoredPos(self._skillsContentNode.transform, currx, offsetStart - self._skillsVpSize + activeSize)
		end
	end
end

function BattleDomainSkillsView:_refreshPetsView(petsContentNode, petsLayout, petsData, currPetData)
	local transform = petsLayout.transform
	local childCount = transform.childCount
	local cnt = 0

	if petsData then
		cnt = #petsData
	end

	while childCount < cnt do
		UGUIToolHelper.AddChild(transform.gameObject, transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	for i = 1, cnt do
		local unit = petsData[i]
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		GameUtil.setAnchoredPos(go, 100 * (i - 1), 0)
		GameUtil.setLocalScale(go, 0.8, 0.8, 0.8)

		local petNode = goutil.findChild(go, "petNode")
		local selectd = goutil.findChild(go, "select")

		MaterialMgr.resetAll(petNode)
		selectd:SetActive(unit == self._currPetData)

		local item = MatType.Pet .. ":" .. unit.attrs:getOriginSkinId() .. ":" .. unit.attrs:getLevel()
		local proxy = MaterialMgr.setCellByCfg(item, petNode)

		if proxy then
			proxy.binder:setStars(unit.attrs:getAwakenLv())
			proxy.binder:setSelected(false)
			proxy.binder:setClickCallBack(function()
				if unit ~= self._currPetData then
					self:_selectPet(unit)
				end
			end)
		end
	end

	for i = cnt + 1, childCount do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	local sizeDelta = petsContentNode.transform.sizeDelta

	sizeDelta.x = cnt * 110
	petsContentNode.transform.sizeDelta = sizeDelta
end

function BattleDomainSkillsView:_onDomainSkillTrigged()
	self:_refreshCurrSkillsView()
end

function BattleDomainSkillsView:_onDomainSkillRemoved()
	self:_refreshCurrSkillsView()
end

return BattleDomainSkillsView
