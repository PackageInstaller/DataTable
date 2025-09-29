-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompInteractPointUI.lua

module("logic.extensions.mainui.scene.unit.UnitCompInteractPointUI", package.seeall)

local M = class("UnitCompInteractPointUI", UnitComponentBase)
local URL = ResName.MainUI_Editor_Btn

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = SingleResLoader.New()
	self._goInst = nil
	self._followUIComp = nil
	self._isVisible = nil
end

function M:onInit()
	self._followUIComp = self._unit.uiFollow

	GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_PERFORM_EDITOR, self._handleMainScenePerformEditor, self)
end

function M:onReuse()
	GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_PERFORM_EDITOR, self._handleMainScenePerformEditor, self)
end

function M:onReset()
	GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_PERFORM_EDITOR, self._handleMainScenePerformEditor, self)
	self:_clearInst()

	self._isVisible = false
end

function M:onDestroy()
	GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_PERFORM_EDITOR, self._handleMainScenePerformEditor, self)
	self:_clearInst()

	self._resLoader = nil
	self._followUIComp = nil
	self._isVisible = false
end

function M:_handleMainScenePerformEditor(e, active)
	self:setVisible(active)
end

function M:getBodySize()
	if not self._size then
		self._size = Vector3.New()
	end

	return self._size
end

function M:setEntityInfo(info)
	self._entityInfoCache = info
end

function M:setVisible(visible)
	self._isVisible = visible

	if visible == false then
		self:_clearInst()

		return
	end

	if self._goInst then
		self:_setVisible()
	elseif self._resLoader then
		self._resLoader:load(URL, self._onResLoaded, self)
	end
end

function M:_setVisible()
	if self._isVisible and not ViewMgr.instance:isOpen(ViewName.MainUIView) then
		self._isVisible = false
	end

	goutil.setActive(self._goInst, self._isVisible)

	if self._isVisible then
		self:_refreshStatus()
	end
end

function M:_onResLoaded()
	self._goInst = self._resLoader:getResInstance()

	self:_buildUI(self._goInst)
	goutil.addChildToParent(self._goInst, self._unit:getTransform())

	local pointId = self._unit:getPointId()
	local pointGo = self._entityInfoCache.go

	self._followUIComp:setMainGameObject(pointGo)
	self._followUIComp:addBottomFollowGameObject(self._goInst)
	self:_setVisible()
end

function M:_clearInst()
	self:unbindUI()

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = nil
	end

	if self._goInst then
		self._followUIComp:removeBottomFollowGameObject(self._goInst)
		goutil.destroy(self._goInst)
	end

	self._goInst = false

	if self._resLoader then
		self._resLoader:clear()
	end
end

function M:_buildUI(mainGO)
	if not mainGO then
		return
	end

	self._viewElementsRegistry = ViewElementsRegistry.New(mainGO)

	local registry = self._viewElementsRegistry
	local comps = {}

	comps.mutexObj = {}
	comps.btn = {}
	comps.dropDownAdapter = {}
	comps.toggle = {}
	comps.sliderAdapter = {}
	comps.editorPanel = registry:findUIElement("main_perform_editor_btn_-1387861133")

	goutil.setActive(comps.editorPanel, false)

	comps.txtStatus = registry:findUIElement("main_perform_editor_btn_-556835542", UIComponentType.Text)

	local btnStatus = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_btn_1079359486"))

	btnStatus:AddClickListener(self._onClickStatus, self)

	comps.btn.btnStatus = btnStatus
	comps.rootGoAni = registry:findUIElement("main_perform_editor_btn_1864225462")
	comps.txtStatusAni = registry:findUIElement("main_perform_editor_btn_-1101567162", UIComponentType.Text)
	comps.goAddAni = registry:findUIElement("main_perform_editor_btn_-258729373")
	comps.txtAniStr = registry:findUIElement("main_perform_editor_btn_976803938", UIComponentType.Text)
	comps.inputAniStr = registry:findUIElement("main_perform_editor_btn_-902023514", UIComponentType.InputFieldAdapter)

	local btnAni = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_btn_-1593253785"))

	btnAni:AddClickListener(self._onClickAni, self)

	comps.btn.btnAni = btnAni

	local btnConfirmChangeAniStr = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_btn_225189213"))

	btnConfirmChangeAniStr:AddClickListener(self._onClickConfirmAniStr, self)

	comps.btn.btnConfirmChangeAniStr = btnConfirmChangeAniStr

	local btnChangeElement = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_btn_1539412264"))

	btnChangeElement:AddClickListener(self._onClickChangeElement, self)

	comps.btn.btnChangeElement = btnChangeElement
	comps.dropDownElement = registry:findUIElement("main_perform_editor_btn_-1675068919", UIComponentType.Dropdown)

	local dropAdapterElement = registry:findUIElement("main_perform_editor_btn_-1675068919", UIComponentType.DropdownApapter)

	dropAdapterElement:AddListener(self._onDropDownElement, self)

	comps.dropDownAdapter.dropdownApapterElement = dropAdapterElement
	comps.txtDropSelectElement = registry:findUIElement("main_perform_editor_btn_-1908202103", UIComponentType.Text)

	goutil.setActive(btnChangeElement.gameObject, false)
	goutil.setActive(goutil.findChild(comps.editorPanel, "editElement").gameObject, false)

	local btnChangeHero = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_btn_-435806473"))

	btnChangeHero:AddClickListener(self._onClickChangeHero, self)

	comps.btn.btnChangeHero = btnChangeHero
	comps.dropDownHero = registry:findUIElement("main_perform_editor_btn_-506816997", UIComponentType.Dropdown)

	local dropAdapterHero = registry:findUIElement("main_perform_editor_btn_-506816997", UIComponentType.DropdownApapter)

	dropAdapterHero:AddListener(self._onDropDownHero, self)

	comps.dropDownAdapter.dropdownApapterHero = dropAdapterHero
	comps.txtDropSelectHero = registry:findUIElement("main_perform_editor_btn_-1258975831", UIComponentType.Text)
	comps.rooGoBgPerform = registry:findUIElement("main_perform_editor_btn_-2142559827")

	goutil.setActive(comps.rooGoBgPerform, false)

	local btnChangeBgPerform = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_btn_552279366"))

	btnChangeBgPerform:AddClickListener(self._onClickChangeBgPerform, self)

	comps.btn.btnChangeBgPerform = btnChangeBgPerform
	comps.goAddBgPerform = registry:findUIElement("main_perform_editor_btn_-47211657")
	comps.dropDownBgElement = {}
	comps.dropDownBgElement[1] = registry:findUIElement("main_perform_editor_btn_2073696409", UIComponentType.Dropdown)
	comps.dropDownBgElement[2] = registry:findUIElement("main_perform_editor_btn_2071635116", UIComponentType.Dropdown)
	comps.dropDownBgElement[3] = registry:findUIElement("main_perform_editor_btn_1945486539", UIComponentType.Dropdown)
	comps.txtDropSelectBgEle = {}
	comps.txtDropSelectBgEle[1] = registry:findUIElement("main_perform_editor_btn_-457093608", UIComponentType.Text)
	comps.txtDropSelectBgEle[2] = registry:findUIElement("main_perform_editor_btn_1486328713", UIComponentType.Text)
	comps.txtDropSelectBgEle[3] = registry:findUIElement("main_perform_editor_btn_-178639351", UIComponentType.Text)
	comps.dropDownBgHero = {}
	comps.dropDownBgHero[1] = registry:findUIElement("main_perform_editor_btn_1202534239", UIComponentType.Dropdown)
	comps.dropDownBgHero[2] = registry:findUIElement("main_perform_editor_btn_1939949875", UIComponentType.Dropdown)
	comps.dropDownBgHero[3] = registry:findUIElement("main_perform_editor_btn_726602395", UIComponentType.Dropdown)
	comps.txtDropSelectBgHero = {}
	comps.txtDropSelectBgHero[1] = registry:findUIElement("main_perform_editor_btn_1053113304", UIComponentType.Text)
	comps.txtDropSelectBgHero[2] = registry:findUIElement("main_perform_editor_btn_-1595696589", UIComponentType.Text)
	comps.txtDropSelectBgHero[3] = registry:findUIElement("main_perform_editor_btn_-1667366470", UIComponentType.Text)
	comps.dropDownAdapter.dropdownApapterBgEle1 = registry:findUIElement("main_perform_editor_btn_2073696409", UIComponentType.DropdownApapter)
	comps.dropDownAdapter.dropdownApapterBgEle2 = registry:findUIElement("main_perform_editor_btn_2071635116", UIComponentType.DropdownApapter)
	comps.dropDownAdapter.dropdownApapterBgEle3 = registry:findUIElement("main_perform_editor_btn_1945486539", UIComponentType.DropdownApapter)
	comps.dropDownAdapter.dropdownApapterBgHero1 = registry:findUIElement("main_perform_editor_btn_1202534239", UIComponentType.DropdownApapter)
	comps.dropDownAdapter.dropdownApapterBgHero2 = registry:findUIElement("main_perform_editor_btn_1939949875", UIComponentType.DropdownApapter)
	comps.dropDownAdapter.dropdownApapterBgHero3 = registry:findUIElement("main_perform_editor_btn_726602395", UIComponentType.DropdownApapter)

	comps.dropDownAdapter.dropdownApapterBgEle1:AddListener(function(handler, index)
		self:_onDropDownBgEle(1, index)
	end, self)
	comps.dropDownAdapter.dropdownApapterBgEle2:AddListener(function(handler, index)
		self:_onDropDownBgEle(2, index)
	end, self)
	comps.dropDownAdapter.dropdownApapterBgEle3:AddListener(function(handler, index)
		self:_onDropDownBgEle(3, index)
	end, self)
	comps.dropDownAdapter.dropdownApapterBgHero1:AddListener(function(handler, index)
		self:_onDropDownBgHero(1, index)
	end, self)
	comps.dropDownAdapter.dropdownApapterBgHero2:AddListener(function(handler, index)
		self:_onDropDownBgHero(2, index)
	end, self)
	comps.dropDownAdapter.dropdownApapterBgHero3:AddListener(function(handler, index)
		self:_onDropDownBgHero(3, index)
	end, self)

	local btnConfirmBgPerform = UIComponentType.ButtonAdapter(registry:findUIElement("main_perform_editor_btn_-2031144971"))

	btnConfirmBgPerform:AddClickListener(self._onClickConfirmBgPerform, self)

	comps.btn.btnConfirmBgPerform = btnConfirmBgPerform
	comps.mutexObj[comps.goAddAni:GetInstanceID()] = comps.goAddAni
	comps.mutexObj[comps.dropDownElement.gameObject:GetInstanceID()] = comps.dropDownElement.gameObject
	comps.mutexObj[comps.dropDownHero.gameObject:GetInstanceID()] = comps.dropDownHero.gameObject
	comps.mutexObj[comps.goAddBgPerform:GetInstanceID()] = comps.goAddBgPerform
	self._uiComps = comps

	self:_setEvent(true)
	self:_dealMutexObj(nil)
end

function M:unbindUI()
	self:_setEvent(false)

	if self._uiComps then
		for _, btn in pairs(self._uiComps.btn) do
			if btn then
				btn:RemoveClickListener()
			end
		end

		for _, adapter in pairs(self._uiComps.dropDownAdapter) do
			if adapter then
				adapter:RemoveClickListener()
			end
		end

		for _, toggle in pairs(self._uiComps.toggle) do
			if toggle then
				toggle:RemoveListener()
			end
		end

		for _, sliderAdapter in pairs(self._uiComps.sliderAdapter) do
			if sliderAdapter then
				sliderAdapter:RemoveOnValueChanged()
			end
		end

		self._uiComps = nil
	end

	self._heroDropDownLst = nil
	self._heroBgEditorDropDownLst = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_ANIM_PLAY, self._handleHeroAnimPlay, self)
		GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_DISPLAYHERO_SUC, self._handleDisplayAdjutantHeroChange, self)
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPEN_OVER_EVENT, self._handleViewOpenOverEvent, self)
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseEvent, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_ANIM_PLAY, self._handleHeroAnimPlay, self)
		GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_DISPLAYHERO_SUC, self._handleDisplayAdjutantHeroChange, self)
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OPEN_OVER_EVENT, self._handleViewOpenOverEvent, self)
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseEvent, self)
	end
end

function M:_handleHeroAnimPlay(e, pointId, elementId, heroId, animState, isInterrupt)
	local point = self._unit:getPointId()

	if point == pointId then
		self:_refreshStatusAni(animState, isInterrupt)
	end
end

function M:_handleDisplayAdjutantHeroChange()
	local comps = self._uiComps

	if not comps then
		return
	end

	goutil.setActive(comps.editorPanel, false)
	DoTweenUtil.DelayedCall(0.2, function()
		self:_refreshStatus()
	end)
end

function M:_handleViewOpenOverEvent(e, viewName, opTyp)
	if MainUIModel.instance:getPerformEditorVisible() and viewName == ViewName.MainUIView then
		self._isVisible = true

		self:_setVisible()
	end
end

function M:_handleViewCloseEvent(e, viewName, opTyp)
	if MainUIModel.instance:getPerformEditorVisible() and viewName == ViewName.MainUIView then
		self._isVisible = false

		self:_setVisible()
	end
end

function M:_onClickStatus()
	local comps = self._uiComps

	if not comps then
		return
	end

	local show = not comps.editorPanel.activeSelf

	goutil.setActive(comps.editorPanel, show)
	goutil.setActive(comps.rooGoBgPerform, self._unit:getPointId() == 0)
	self:_dealMutexObj(nil)
end

function M:_onClickAni()
	local comps = self._uiComps

	if not comps then
		return
	end

	local show = not comps.goAddAni.activeSelf

	goutil.setActive(comps.goAddAni, show)

	if show then
		local point = self._unit:getPointId()
		local curSceneFlow = SceneFace.instance:getCurSceneFlow()
		local unitHero = curSceneFlow.unitFactory:getUnitHeroByPoint(point)

		if unitHero then
			local heroId = unitHero:getHeroId()
			local modelId = unitHero:getModelId()

			comps.txtAniStr.text = unitHero.animCtrl:getAnimStepStr()

			if point == 0 then
				local cfg = MainPerformConfig.instance:getLandLadyRConfig(modelId)

				comps.inputAniStr:SetText(cfg and cfg.anim or nil)
			else
				local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformHeroR, modelId)

				comps.inputAniStr:SetText(cfg and cfg.anim or nil)
			end
		else
			comps.txtAniStr.text = "无法查找角色"

			comps.inputAniStr:SetText(nil)
		end
	end

	self:_dealMutexObj(show and comps.goAddAni or nil)
end

function M:_onClickConfirmAniStr()
	local comps = self._uiComps

	if not comps then
		return
	end

	local animStr = comps.inputAniStr:GetText()

	if string.nilorempty(animStr) then
		return
	end

	local curSceneFlow = SceneFace.instance:getCurSceneFlow()
	local point = self._unit:getPointId()
	local unitHero = curSceneFlow.unitFactory:getUnitHeroByPoint(point)

	if unitHero then
		local heroId = unitHero:getHeroId()
		local allHasAnim = true

		for _, _animState in ipairs(MainScenePerformUtil.deserializeAnimStep(animStr)) do
			if allHasAnim and not unitHero.meshModel:containsAnim(_animState) then
				local msg = string.format("[%s]%s,没有动画 %s", heroId, MainScenePerformUtil.getHeroName(heroId), _animState)

				printWarn(msg)
				FloatWordMgr.instance:show(msg)

				allHasAnim = false
			end
		end

		if allHasAnim then
			unitHero.animCtrl:setAnimStepStr(animStr)
		end

		comps.txtAniStr.text = unitHero.animCtrl:getAnimStepStr()
	else
		comps.txtAniStr.text = "无法查找角色"
	end
end

function M:_onClickChangeElement()
	local comps = self._uiComps

	if not comps then
		return
	end

	local point = self._unit:getPointId()
	local show = not comps.dropDownElement.gameObject.activeSelf
	local cfgLst = MainPerformConfig.instance:getElementLstByPointId(point)

	if #cfgLst <= 0 then
		show = false
	end

	local selectIndex = 1
	local elementLst = {}

	if show then
		local curSceneFlow = SceneFace.instance:getCurSceneFlow()
		local unitHero = curSceneFlow.unitFactory:getUnitHeroByPoint(point)
		local elementId = unitHero and MainPerformConfig.instance:getHeroElementId(unitHero:getHeroId(), point, unitHero:getSkinId()) or -1

		for index, cfg in ipairs(cfgLst) do
			table.insert(elementLst, MainScenePerformUtil.getElementName(cfg.id))

			if elementId == cfg.id then
				selectIndex = index
			end
		end

		self:_updateDropDownLst(comps.dropDownElement, elementLst)

		comps.dropDownElement.value = selectIndex - 1

		goutil.setActive(comps.dropDownElement.gameObject, show)

		comps.txtDropSelectElement.text = elementLst[selectIndex]
	else
		goutil.setActive(comps.dropDownElement.gameObject, show)
	end

	self:_dealMutexObj(show and comps.dropDownElement.gameObject or nil)
end

function M:_onClickChangeHero()
	local comps = self._uiComps

	if not comps then
		return
	end

	local point = self._unit:getPointId()
	local show = not comps.dropDownHero.gameObject.activeSelf
	local curSceneFlow = SceneFace.instance:getCurSceneFlow()
	local unitHero = curSceneFlow.unitFactory:getUnitHeroByPoint(point)
	local selectIndex = 1
	local heroNameLst

	if show then
		self._heroDropDownLst = nil
		self._heroDropDownLst, heroNameLst = MainScenePerformUtil.getHeroDropLstData(point)

		self:_updateDropDownLst(comps.dropDownHero, heroNameLst)

		if unitHero then
			selectIndex = table.indexof(self._heroDropDownLst, unitHero:getHeroId())
		end

		comps.dropDownHero.value = selectIndex - 1

		goutil.setActive(comps.dropDownHero.gameObject, show)

		comps.txtDropSelectHero.text = heroNameLst[selectIndex]
	else
		goutil.setActive(comps.dropDownHero.gameObject, show)
	end

	self:_dealMutexObj(show and comps.dropDownHero.gameObject or nil)
end

function M:_updateDropDownLst(dropDown, lst)
	MainScenePerformUtil.updateDropDownLst(dropDown, lst)
end

function M:_onDropDownHero(index)
	local point = self._unit:getPointId()
	local comps = self._uiComps

	if not comps then
		return
	end

	if not comps.dropDownHero.gameObject.activeSelf then
		return
	end

	local curSceneFlow = SceneFace.instance:getCurSceneFlow()
	local unitHero = curSceneFlow.unitFactory:getUnitHeroByPoint(point)
	local heroId = unitHero and unitHero:getHeroId() or nil
	local newHeroId = self._heroDropDownLst and self._heroDropDownLst[index + 1] or nil

	if not newHeroId then
		printWarn(string.format("无法定位index[%s]对应的heroId", index))
		goutil.setActive(comps.dropDownHero.gameObject, false)

		return
	end

	if heroId == newHeroId then
		goutil.setActive(comps.dropDownHero.gameObject, false)

		return
	end

	if newHeroId > 0 then
		local skinId = CharacterSkinUtil.getHeroUsingSkinId(newHeroId)
		local exist = MainScenePerformUtil.getHeroModelAssetExist(newHeroId, skinId, true)
		local forceSet = true
		local prefix, mixDuration
		local isChange = false

		MainScenePerformUtil.changeHeroReq(point, newHeroId, skinId, forceSet, prefix, mixDuration, isChange)
	else
		curSceneFlow.unitFactory:removeUnitHeroByPoint(point)
	end

	self:_refreshStatusAni()

	comps.txtDropSelectHero.text = MainScenePerformUtil.getHeroDropName(point, newHeroId)

	goutil.setActive(comps.dropDownHero.gameObject, false)
end

function M:_onDropDownElement(index)
	local point = self._unit:getPointId()
	local comps = self._uiComps

	if not comps then
		return
	end

	if not comps.dropDownElement.gameObject.activeSelf then
		return
	end

	local cfgLst = MainPerformConfig.instance:getElementLstByPointId(point)

	if #cfgLst <= 0 then
		goutil.setActive(comps.dropDownElement.gameObject, false)

		return
	end

	local newElement = cfgLst[index + 1]

	if not newElement then
		printWarn(string.format("无法定位index[%s]对应的元素id", index))
		goutil.setActive(comps.dropDownElement.gameObject, false)

		return
	end

	newElement = newElement.id

	local curSceneFlow = SceneFace.instance:getCurSceneFlow()
	local unitHero = curSceneFlow.unitFactory:getUnitHeroByPoint(point)
	local elementId = unitHero and MainPerformConfig.instance:getHeroElementId(unitHero:getHeroId(), point, unitHero:getSkinId()) or nil

	print(string.format("切换元素[%s]->[%s]", elementId, newElement))

	if elementId == newElement then
		goutil.setActive(comps.dropDownElement.gameObject, false)

		return
	end

	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return
	end

	curSceneFlow.unitFactory:removeUnitHeroByPoint(point)
	curSceneFlow.elementMgr:hideAllElementInPoint(point)
	curSceneFlow.elementMgr:setElementShow(newElement, true)
	self:_refreshStatus()
	goutil.setActive(comps.dropDownElement.gameObject, false)

	comps.txtDropSelectElement.text = MainScenePerformUtil.getElementName(newElement)
end

function M:_refreshStatus()
	local comps = self._uiComps

	if not comps then
		return
	end

	local point = self._unit:getPointId()
	local curSceneFlow = SceneFace.instance:getCurSceneFlow()
	local unitHero = curSceneFlow.unitFactory:getUnitHeroByPoint(point)
	local elementId = unitHero and MainPerformConfig.instance:getHeroElementId(unitHero:getHeroId(), point, unitHero:getSkinId()) or nil

	comps.txtStatus.text = string.format("交互点[%s]元素[%s]", point, MainScenePerformUtil.getElementName(elementId))

	self:_refreshStatusAni()
end

function M:_refreshStatusAni(animState, isInterrupt)
	local comps = self._uiComps

	if not comps then
		return
	end

	local point = self._unit:getPointId()
	local curSceneFlow = SceneFace.instance:getCurSceneFlow()
	local unitHero = curSceneFlow.unitFactory:getUnitHeroByPoint(point)
	local showStr = unitHero and unitHero.animCtrl:getAnimStepStatusLog() or "无角色"

	if isInterrupt and not string.nilorempty(animState) then
		showStr = string.format("%s 打断by %s", showStr, animState)
	end

	comps.txtStatusAni.text = showStr

	goutil.setActive(self._uiComps.rootGoAni, true)
end

function M:_onClickChangeBgPerform()
	local comps = self._uiComps

	if not comps then
		return
	end

	local point = self._unit:getPointId()
	local show = not comps.goAddBgPerform.activeSelf

	if point ~= 0 then
		show = false
	end

	goutil.setActive(comps.goAddBgPerform, show)

	if show then
		for i = 1, 3 do
			self:_refreshBgPerformEditor(i, comps.dropDownBgElement[i], comps.txtDropSelectBgEle[i])
			self:_refreshBgPerformEditorHero(i, comps.dropDownBgHero[i], comps.txtDropSelectBgHero[i])
		end
	end

	self:_dealMutexObj(show and comps.goAddBgPerform or nil)
end

function M:_refreshBgPerformEditor(point, drop, selectTxt)
	local lastData = MainUIModel.instance:getLastBgPerformData()
	local pointPerformData = lastData.pointPerformData
	local selectIndex = 1
	local elementLst = {}

	if pointPerformData[point] then
		local cfgLst = MainPerformConfig.instance:getElementLstByPointId(point)
		local elementId = pointPerformData[point].elementId

		for index, cfg in ipairs(cfgLst) do
			table.insert(elementLst, MainScenePerformUtil.getElementName(cfg.id))

			if elementId == cfg.id then
				selectIndex = index
			end
		end
	end

	self:_updateDropDownLst(drop, elementLst)

	drop.value = selectIndex - 1
	selectTxt.text = elementLst[selectIndex]
end

function M:_refreshBgPerformEditorHero(point, drop, selectTxt, changeElementId)
	local heroId

	if changeElementId then
		heroId = -1
	else
		local lastData = MainUIModel.instance:getLastBgPerformData()
		local pointPerformData = lastData.pointPerformData

		heroId = pointPerformData[point].heroId
	end

	local selectIndex = 1
	local heroNameLst

	if not self._heroBgEditorDropDownLst then
		self._heroBgEditorDropDownLst = {}
	end

	self._heroBgEditorDropDownLst[point] = {}
	self._heroBgEditorDropDownLst[point], heroNameLst = MainScenePerformUtil.getHeroDropLstData(point)

	self:_updateDropDownLst(drop, heroNameLst)

	if heroId and heroId > 0 then
		selectIndex = table.indexof(self._heroBgEditorDropDownLst[point], heroId)
	end

	drop.value = selectIndex - 1
	selectTxt.text = heroNameLst[selectIndex]
end

function M:_onDropDownBgEle(point, index)
	local comps = self._uiComps

	if not comps then
		return
	end

	if not comps.goAddBgPerform.activeSelf then
		return
	end

	local cfgLst = MainPerformConfig.instance:getElementLstByPointId(point)
	local cfg = cfgLst[index + 1]
	local elementId = cfg and cfg.id or nil

	comps.txtDropSelectBgEle[point].text = MainScenePerformUtil.getElementName(elementId)
	comps.dropDownBgHero[point].value = 0

	self:_refreshBgPerformEditorHero(point, comps.dropDownBgHero[point], comps.txtDropSelectBgHero[point], elementId)
end

function M:_onDropDownBgHero(point, index)
	local comps = self._uiComps

	if not comps then
		return
	end

	if not comps.goAddBgPerform.activeSelf then
		return
	end

	local newHeroId = self._heroBgEditorDropDownLst[point] and self._heroBgEditorDropDownLst[point][index + 1] or nil

	if not newHeroId then
		printWarn(string.format("无法定位index[%s]对应的heroId", index))

		return
	end

	comps.txtDropSelectHero.text = MainScenePerformUtil.getHeroDropName(point, newHeroId)
end

function M:_onClickConfirmBgPerform()
	local comps = self._uiComps

	if not comps then
		return
	end

	local point = self._unit:getPointId()

	if point ~= 0 then
		goutil.setActive(comps.goAddBgPerform, false)

		return
	end

	local element_1, hero_1 = self:_getBgPerformInputData(1)
	local element_2, hero_2 = self:_getBgPerformInputData(2)
	local element_3, hero_3 = self:_getBgPerformInputData(3)
	local adjutantHero = MainScenePerformUtil.getDisplayAdjutantHeroId()

	if hero_1 == adjutantHero or hero_2 == adjutantHero or hero_3 == adjutantHero then
		FloatWordMgr.instance:show("设置角色与副官角色冲突，不能设置")

		return
	end

	local lastData = MainUIModel.instance:getLastBgPerformData()
	local pointPerformData = lastData.pointPerformData

	pointPerformData[1] = {
		point = 1,
		skinId = 0,
		heroId = hero_1,
		elementId = element_1
	}
	pointPerformData[2] = {
		point = 2,
		skinId = 0,
		heroId = hero_2,
		elementId = element_2
	}
	pointPerformData[3] = {
		point = 3,
		skinId = 0,
		heroId = hero_3,
		elementId = element_3
	}

	local recordTime = true

	MainUIModel.instance:setLastBgPerformFormula(lastData.formulaId, pointPerformData, recordTime, false)
	goutil.setActive(comps.goAddBgPerform, false)
end

function M:_getBgPerformInputData(point)
	local comps = self._uiComps
	local cfgLst = MainPerformConfig.instance:getElementLstByPointId(point)
	local cfg = cfgLst[comps.dropDownBgElement[point].value + 1]
	local elementId = cfg and cfg.id or nil
	local heroId = self._heroBgEditorDropDownLst[point][comps.dropDownBgHero[point].value + 1]

	return elementId, heroId
end

function M:_dealMutexObj(go)
	local comps = self._uiComps

	if not comps then
		return
	end

	local activeInstanceId = go and go:GetInstanceID() or nil

	for instanceId, obj in pairs(comps.mutexObj or {}) do
		local show = activeInstanceId == instanceId

		goutil.setActive(obj, show)
	end
end

return M
