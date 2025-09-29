-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/new/CharacterEchoFragmentViewNew.lua

module("logic.extensions.charactersystem.view.carrier.new.CharacterEchoFragmentViewNew", package.seeall)

local M = class("CharacterEchoFragmentViewNew", CharacterMainSystemSubViewBase)

function M:getRegistry()
	return self._registry
end

function M:getPageIndex()
	return CommEnum.CharacterSystemTab.EchoItem
end

function M:getReOpenAnimName()
	return "open"
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self._registry:getMainGO()

	self._goNodeRoot = self._registry:getGo("echo_main_panel_-1471263212")
	self._goNodeEmpty = self._registry:getGo("echo_main_panel_1837289392")

	goutil.setActive(self._registry:getGo("15&empty_unit_-1492724947"), false)

	self._btnEquip = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "node_empty/btnEquip"))
	self._goRedDotHasEquipCanEquip = goutil.findChild(mainGO, "node_empty/btnEquip/red").gameObject
	self._txtName = self._registry:getText("echo_main_panel_46801815")
	self._imgIcon = self._registry:getImage("echo_main_panel_343952305")
	self._goIconHeroRoot = self._registry:getGo("echo_main_panel_-220552051")
	self._imgIconHero = self._registry:getImage("echo_main_panel_-984138296")
	self._btnLock = self._registry:getBtn("echo_main_panel_712728567")
	self._goMarkLock = self._registry:getGo("echo_main_panel_160608995")
	self._goMarkUnLock = self._registry:getGo("echo_main_panel_1069966390")
	self._breakPointView = Astral.LuaComponentContainer.Add(goutil.findChild(self._goNodeRoot, "scroll/view/content/content1/break_point").gameObject, EchoItemBreakPointView)
	self._baseAttrLst = {}

	table.insert(self._baseAttrLst, {
		root = self._registry:getGo("echo_main_panel_-1223165220"),
		txtName = self._registry:getText("echo_main_panel_-1876010650"),
		txtAttr = self._registry:getText("echo_main_panel_-160343227")
	})
	table.insert(self._baseAttrLst, {
		root = self._registry:getGo("echo_main_panel_-1153214314"),
		txtName = self._registry:getText("echo_main_panel_-403136230"),
		txtAttr = self._registry:getText("echo_main_panel_-1740694820")
	})
	table.insert(self._baseAttrLst, {
		root = self._registry:getGo("echo_main_panel_25374127"),
		txtName = self._registry:getText("echo_main_panel_-1239630748"),
		txtAttr = self._registry:getText("echo_main_panel_237377432")
	})
	table.insert(self._baseAttrLst, {
		root = self._registry:getGo("echo_main_panel_2118039765"),
		txtName = self._registry:getText("echo_main_panel_199654867"),
		txtAttr = self._registry:getText("echo_main_panel_-728363594")
	})

	self._descRootTrs = self._registry:getUIComponent("echo_main_panel_728725114", UIComponentType.RectTransform)
	self._txtCareerFlag = self._registry:getUIComponent("echo_main_panel_1677580594", UIComponentType.TextMeshProUGUI)
	self._txtCareer = self._registry:getUIComponent("echo_main_panel_-1921120904", UIComponentType.TextMeshProUGUI)
	self._btnDesc = self._registry:getBtn("echo_main_panel_709080603")

	local attributeRoot = self._registry:getUIComponent("echo_main_panel_-1596370597", UIComponentType.RectTransform)

	self._attrViewList = {}

	for i = 1, attributeRoot.childCount - 1 do
		local view = Astral.SimpleLuaComponentContainer.Add(attributeRoot:GetChild(i).gameObject, EchoItemBreakAttrViewNew)

		view:setIndex(i + 1)
		table.insert(self._attrViewList, view)
	end

	self._btnChange = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "node/content3/btnChange"))
	self._btnBreak = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "node/content3/btnBreak"))
	self._showCardView = Astral.LuaComponentContainer.Add(self._registry:getGo("echo_show_card_-997813653"), EchoItemShowCardView)

	self._showCardView:showGyros()
	self._showCardView:setClickFunction(self._onClickEchoFind, self)
	self._showCardView:setAddBtnVisible(false)
	self._showCardView:setImgForShowVisible(true)

	self._rectTrShowPoint = self._registry:getUIComponent("echo_main_panel_-908414196", UIComponentType.RectTransform)
	self._echoRedPoint = goutil.findChild(self._rectTrShowPoint.gameObject, "echo_show_card/red_point")
	self._canvasGroupCardShowFx = goutil.addComponentOnce(self._registry:getGo("echo_main_panel_2025854564"), ComponentType.CanvasGroup)
	self._btnPresets = self._registry:getBtn("13&btn_presets_600318579")

	self:_regLockStats(GameEnum.SystemEnum.HeroPreset, self._btnPresets.gameObject, nil, nil)
end

function M:destroyUI()
	M.super.destroyUI(self)
	self._showCardView:onExit()

	self._showCardView = nil
	self._baseAttrLst = nil
	self._attrViewList = nil
end

function M:bindEvents()
	self._btnLock:AddClickListener(self._onClickLock, self)
	self._btnChange:AddClickListener(self._onClickChange, self)
	self._btnBreak:AddClickListener(self._onClickBreak, self)
	self._btnEquip:AddClickListener(self._onClickEquip, self)
	self._btnDesc:AddClickListener(self._onClickDesc, self)
	self._btnPresets:AddClickListener(self._onClickPreinstall, self)
end

function M:unbindEvents()
	self._btnLock:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnBreak:RemoveClickListener()
	self._btnEquip:RemoveClickListener()
	self._btnDesc:RemoveClickListener()
	self._btnPresets:RemoveClickListener()
end

function M:setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ECHO_ITEM_INFO_REFRESH, self._handleEchoItemInfoRefresh, self)
		GlobalDispatcher:addEventListener(EventType.CHARACTER_MAIN_SYSTEM_SWITCH, self._handleEchoItemInfoRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_ADD_BTN_CLICK, self._handleClickAdd, self)
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ECHO_ITEM_INFO_REFRESH, self._handleEchoItemInfoRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_MAIN_SYSTEM_SWITCH, self._handleEchoItemInfoRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_ADD_BTN_CLICK, self._handleClickAdd, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
	end
end

function M:onEnter()
	local echoItemData = EchoItemController.instance:getCurHeroEchoItem()
	local echoItemId = echoItemData and echoItemData:getId() or 0

	self._canvasGroupCardShowFx.alpha = echoItemId > 0 and 1 or 0

	M.super.onEnter(self)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	self:setEvents(true)
	self._showCardView:onEnter()
	self._showCardView:showGyros()
	self._showCardView:setOtherPlayerUI(self._isOther)
	self._showCardView:setAddBtnVisible(true)
	self:refreshView()
	self:_handleOnSystemOpen()
end

function M:onExit()
	self:setEvents(false)
	self:_playItemOpenAni(false)
	self._showCardView:onExit()
end

function M:_regLockStats(key, root, objNormal, objLock)
	if not self._lockStatsGroup then
		self._lockStatsGroup = {}
	end

	local data = {}

	data.root = root.gameObject
	data.normal = objNormal and objNormal.gameObject or nil
	data.lock = objLock and objLock.gameObject or nil
	self._lockStatsGroup[key] = self._lockStatsGroup[key] or {}

	table.insert(self._lockStatsGroup[key], data)
end

function M:_handleOnSystemOpen()
	for key, group in pairs(self._lockStatsGroup or {}) do
		for _, data in ipairs(group) do
			local showOnLock = SystemOpenFacade.instance:isShowOnLock(key)
			local isOpen = SystemOpenFacade.instance:isOpen(key)

			goutil.setActive(data.root, isOpen or showOnLock and not isOpen)

			if data.lock then
				goutil.setActive(data.lock, not isOpen)
			end

			if data.normal then
				goutil.setActive(data.normal, isOpen)
			end
		end
	end
end

function M:_playItemOpenAni(play)
	return
end

function M:_onClickEchoFind()
	local echoItemData = EchoItemController.instance:getCurHeroEchoItem()

	if not echoItemData then
		return
	end

	EchoItemMainController.instance:setSelectedEchoItem(echoItemData)

	local params = {
		index = EchoItemMainViewNew.SubViewType.Detail
	}

	ViewMgr.instance:open(ViewName.EchoItemMainViewNew, params)
end

function M:_onClickEquip()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEcho, true) then
		return
	end

	local echoItemData = EchoItemController.instance:getCurHeroEchoItem()

	if echoItemData then
		self:refreshView()

		return
	end

	EchoItemMainController.instance:setSelectedEchoItem(nil)

	local params = {
		index = EchoItemMainViewNew.SubViewType.Change
	}

	ViewMgr.instance:open(ViewName.EchoItemMainViewNew, params)
end

function M:_onClickLock()
	local echoItemData = EchoItemController.instance:getCurHeroEchoItem()

	if not echoItemData then
		return
	end

	local uuid = echoItemData:getUuid()
	local isLock = echoItemData:getIsLock()
	local seId = CriwareAudioEnum.ui_shoumiren_canxiangsuoding

	CriwareAudioFacade.instance:playOnceSEbyId(seId, nil, nil, nil)

	if not isLock then
		EchoItemAgent.instance:sendLockEchoItemRequest(uuid, true)
	else
		local dialog = Dialog.showMessage(lang("tip_sure_unlock"), lang("tip_ask_unlock"))

		dialog:setConfirmListener(function()
			EchoItemAgent.instance:sendLockEchoItemRequest(uuid, false)
		end, self)
	end
end

function M:_onClickChange()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEcho, true) then
		return
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_canxianggenghuan, nil, nil, nil)

	local echoItemData = EchoItemController.instance:getCurHeroEchoItem()

	EchoItemMainController.instance:setSelectedEchoItem(echoItemData)

	local params = {
		index = EchoItemMainViewNew.SubViewType.Change
	}

	ViewMgr.instance:open(ViewName.EchoItemMainViewNew, params)
end

function M:_onClickBreak()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEcho, true) then
		return
	end

	local echoItemData = EchoItemController.instance:getCurHeroEchoItem()

	if not echoItemData then
		return
	end

	EchoItemMainController.instance:setSelectedEchoItem(echoItemData)

	local params = {
		index = EchoItemMainViewNew.SubViewType.Break
	}

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_canxiangtupo, nil, nil, nil)
	ViewMgr.instance:open(ViewName.EchoItemMainViewNew, params)
end

function M:_onClickDesc()
	local echoItemData = EchoItemController.instance:getCurHeroEchoItem()
	local echoItemId = echoItemData and echoItemData:getId() or 0

	if echoItemId == 0 then
		return
	end

	local skillEnhanceMO = echoItemData:getSkillEnhanceMO()
	local bindGo = self._btnDesc.gameObject
	local isPassEvent = true

	ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
end

function M:_onClickPreinstall()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.HeroPreset, true) then
		return
	end

	ViewMgr.instance:open(ViewName.CharacterPreinstallView, self:getHeroId(), 2)
end

function M:getHeroId()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if heroData then
		return heroData:getId()
	end

	return nil
end

function M:_handleEchoItemInfoRefresh(e)
	self:refreshView()
end

function M:refreshView()
	local echoItemData = EchoItemController.instance:getCurHeroEchoItem()
	local echoItemId = echoItemData and echoItemData:getId() or 0

	self._showCardView:refreshView(echoItemId)
	self._showCardView:setOtherPlayerUI(self._isOther)
	self._showCardView:setAddBtnVisible(true)
	self._showCardView:updateDynamicEffect(echoItemData)
	goutil.setActive(self._goNodeEmpty, echoItemId == 0)
	goutil.setActive(self._goNodeRoot, echoItemId ~= 0)

	if echoItemId == 0 then
		local includeInOtherCard = false

		goutil.setActive(self._goRedDotHasEquipCanEquip, EchoItemController.instance:hasEchoCanEquip(includeInOtherCard))

		return
	end

	local isLock = echoItemData:getIsLock()
	local quality = echoItemData:getQuality()
	local career = echoItemData:getCareer()
	local heroId = echoItemData:getHeroId()
	local echoMaxLv = echoItemData:getMaxLevel()

	self._txtName.text = echoItemData:getName()

	IconLoader.setSprite(self._imgIcon, IconType.EchoItemIcon, echoItemData:getIcon())
	goutil.setActive(self._goMarkLock, isLock)
	goutil.setActive(self._goMarkUnLock, not isLock)

	if heroId > 0 then
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)
		local modelCO = heroMO and ModelConfig.instance:getModelConfig(heroMO:getModelId()) or nil

		if modelCO then
			IconLoader.setSprite(self._imgIconHero, IconType.RoleHeadIcon, modelCO.headIconName)
		end
	end

	goutil.setActive(self._goIconHeroRoot, heroId > 0)
	self._breakPointView:setEchoItemLevel(echoItemData:getLevel(), echoMaxLv)

	local attLst = echoItemData:getAttr()
	local attCount = #attLst

	for index, comps in ipairs(self._baseAttrLst) do
		local data = attLst[index]
		local show = data ~= nil

		if show then
			local cfg = AttributeDefineConfig.instance:getAttributePartDefineCO(data.id)

			comps.txtName.text = cfg and cfg.name or ""

			local offsetNumStr = data.num

			if data.num < 1 then
				offsetNumStr = string.format("+%s", data.num * 100) .. "%"
			end

			comps.txtAttr.text = offsetNumStr
		end

		goutil.setActive(comps.root, show)
	end

	local tagIds = HeroDepotModel.instance:getCurViewPageHeroTags()
	local skillEnhanceMO = echoItemData:getSkillEnhanceMO()
	local descStr = skillEnhanceMO and skillEnhanceMO:getDescriptionTagHighLight(tagIds) or ""
	local campIcon = CommEnum.Career2TmpResName[career] or ""
	local lines = string.split(descStr, "\n")

	self._txtCareerFlag.text = string.format("<size=24>%s</size>", campIcon)
	self._txtCareer.text = string.format("%s", CommEnum.Career2Name[career])

	goutil.setActive(self._txtCareerFlag.gameObject.transform.parent.gameObject, campIcon ~= "")
	goutil.setActive(self._descRootTrs.gameObject, descStr ~= "")

	if #lines > 0 then
		while self._descRootTrs.childCount - 1 < #lines do
			local textGo = goutil.cloneAndSetParent(self._descRootTrs:GetChild(1).gameObject, self._descRootTrs)

			textGo.transform:SetSiblingIndex(1)
		end

		for i = 1, self._descRootTrs.childCount - 1 do
			local go = self._descRootTrs:GetChild(i).gameObject
			local txtDesc = go:GetComponent(UIComponentType.TMPText)

			txtDesc.text = lines[i]

			goutil.setActive(go, i <= #lines)
		end
	end

	for index, attrView in ipairs(self._attrViewList) do
		local showLevel = index + 1
		local isBreak = showLevel <= echoItemData:getLevel()
		local colorAttr = false
		local colorSkill = false
		local descSplit = false
		local data = {
			echoItemId = echoItemData:getId(),
			level = echoItemData:getLevel(),
			descSplit = descSplit,
			desc = EchoItemConfig.instance:getAttrDesc(echoItemData:getId(), showLevel, colorAttr, colorSkill, descSplit, tagIds),
			itemData = echoItemData,
			showLevel = showLevel
		}

		attrView:setData(data, echoMaxLv)
	end
end

function M:_handleClickAdd()
	self:_onClickEquip()
end

return M
