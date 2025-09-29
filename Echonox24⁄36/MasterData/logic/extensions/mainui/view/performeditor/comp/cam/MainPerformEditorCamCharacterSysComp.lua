-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/cam/MainPerformEditorCamCharacterSysComp.lua

module("logic.extensions.mainui.view.performeditor.comp.cam.MainPerformEditorCamCharacterSysComp", package.seeall)

local M = class("MainPerformEditorCamCharacterSysComp", MainPerformEditorCompBase)

M.PageType = {
	Hero = 3,
	Element = 2,
	Base = 1
}

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self:getMainGo()

	self._txtHeroStatus = goutil.findChildComponent(mainGO, "title/bg/txtHeroId", UIComponentType.Text)
	self._btnReset = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "group/select/btnReset").gameObject)
	self._btnSave = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "group/select/btnSave").gameObject)
	self._btnSearch = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "group/select/btnSearch").gameObject)
	self._btnDelete = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "group/select/btnDelete").gameObject)
	self._dropCamGroupId = goutil.findChildComponent(mainGO, "group/select/dropDown_id", UIComponentType.Dropdown)
	self._dropAdapterCamGroupId = goutil.findChildComponent(mainGO, "group/select/dropDown_id", UIComponentType.DropdownApapter)
	self._txtDropCamGroupId = goutil.findChildTextComponent(mainGO, "group/select/dropDown_id/Label")
	self._dropCamGroupName = goutil.findChildComponent(mainGO, "group/select/dropDown_name", UIComponentType.Dropdown)
	self._dropAdapterCamGroupName = goutil.findChildComponent(mainGO, "group/select/dropDown_name", UIComponentType.DropdownApapter)
	self._txtDropCamGroupName = goutil.findChildTextComponent(mainGO, "group/select/dropDown_name/Label")
	self._inputSaveCamGroupId = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "group/select/btnSave/input_camCode").gameObject)
	self._inputSaveCamGroupName = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "group/select/btnSave/input_name").gameObject)
	self._goPrefabItem = goutil.findChild(mainGO, "group/edit_item").gameObject

	goutil.setActive(self._goPrefabItem, false)

	self._itemType = {}

	for keyStr, valIntType in pairs(MainPerformEnum.CharSysCamGroupItemTyp) do
		table.insert(self._itemType, valIntType)
	end

	table.sort(self._itemType)

	self._tabRoot = goutil.findChildComponent(mainGO.transform.parent.parent.parent.gameObject, "tabCharSysGroup", UIComponentType.RectTransform)
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)

	for i = 0, self._tabRoot.childCount - 1 do
		self._toggleTabControl:addToggleTab(self._tabRoot:GetChild(i):GetComponent(UIComponentType.SpaceXToggle))
	end

	goutil.setActive(self._tabRoot.gameObject, false)

	self._subPanelGo = {
		[M.PageType.Base] = goutil.findChild(mainGO, "group").gameObject,
		[M.PageType.Element] = goutil.findChild(mainGO, "element").gameObject,
		[M.PageType.Hero] = goutil.findChild(mainGO, "hero").gameObject
	}
	self._loopLstEle = LoopListHelper.New(goutil.findChild(mainGO, "element/scroll").gameObject)

	self._loopLstEle:InitListView(0, self._onCellUpdateEle, self)

	self._loopLstHero = LoopListHelper.New(goutil.findChild(mainGO, "hero/scroll").gameObject)

	self._loopLstHero:InitListView(0, self._onCellUpdateHero, self)

	self._cellEle = {}
	self._cellHero = {}
end

function M:destroyUI()
	M.super.destroyUI(self)
	self:_clearItems()
	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	self._loopLstEle:Dispose()

	self._loopLstEle = nil

	self._loopLstHero:Dispose()

	self._loopLstHero = nil

	for index, cell in ipairs(self._cellEle or {}) do
		cell.destroyUI()
	end

	self._cellEle = nil

	for index, cell in ipairs(self._cellHero or {}) do
		cell.destroyUI()
	end

	self._cellHero = nil
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnSearch:AddClickListener(self._onClickSearch, self)
	self._btnDelete:AddClickListener(self._onClickDelete, self)
	self._dropAdapterCamGroupId:AddListener(self._onDropCamGroupId, self)
	self._dropAdapterCamGroupName:AddListener(self._onDropCamGroupName, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnReset:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
	self._btnDelete:RemoveClickListener()
	self._dropAdapterCamGroupId:RemoveClickListener()
	self._dropAdapterCamGroupName:RemoveClickListener()
	self._dropAdapterElement:RemoveClickListener()
	self._dropAdapterHero:RemoveClickListener()
end

function M:onEnter()
	M.super.onEnter(self)
	self:refreshView()
	goutil.setActive(self._tabRoot.gameObject, true)
	self._toggleTabControl:selectTab(1)
end

function M:onExit()
	M.super.onExit(self)

	self._activeIndex = nil

	goutil.setActive(self._tabRoot.gameObject, false)
end

function M:canShow()
	return true
end

function M:IsDataDirty()
	return false
end

function M:refreshView()
	self:_prepareData()
	self:_resetOriginalSelect()
end

function M:setPage(tabIndex)
	if self._activeIndex and self._activeIndex == tabIndex then
		return
	end

	self._activeIndex = tabIndex

	for _pTyp, go in pairs(self._subPanelGo) do
		goutil.setActive(go, _pTyp == self._activeIndex)
	end

	if self._activeIndex == M.PageType.Element then
		self:_prepareData(true)

		local count = #self._elementIds

		self._loopLstEle:SetListItemCount(count, true)
		self._loopLstEle:RefreshAllShownItem()
	elseif self._activeIndex == M.PageType.Hero then
		self:_prepareData(true)

		local count = #self._heroIds

		self._loopLstHero:SetListItemCount(count, true)
		self._loopLstHero:RefreshAllShownItem()
	end
end

function M:_prepareData(onlyRefresh)
	local selectIndex = 0

	self._camCodeLstIds = {}
	self._camCodeLstName = {}

	local cfgLstCamCode = MainPerformConfig.instance:getConfigList(ConfigName.MainPerformCameraR)

	for _, _cfg in ipairs(cfgLstCamCode or {}) do
		if _cfg.id >= 0 then
			table.insert(self._camCodeLstIds, _cfg.id)
			table.insert(self._camCodeLstName, _cfg.name)
		end
	end

	self._groupLstIds = {
		0
	}
	self._groupLstName = {
		"无"
	}
	self._cfgLst = MainPerformConfig.instance:getConfigList(ConfigName.MainPerformCamGroupChaSysR)

	if self._cfgLst and #self._cfgLst > 0 then
		for _, _cfg in ipairs(self._cfgLst) do
			table.insert(self._groupLstIds, _cfg.id)
			table.insert(self._groupLstName, _cfg.name)
		end
	end

	MainScenePerformUtil.updateDropDownLst(self._dropCamGroupId, self._groupLstIds)
	MainScenePerformUtil.updateDropDownLst(self._dropCamGroupName, self._groupLstName)

	self._callOtherDrop = false
	self._dropCamGroupId.value = selectIndex
	self._dropCamGroupName.value = selectIndex

	self:_onDropCamGroupId(selectIndex)
	self:_onDropCamGroupName(selectIndex)

	self._callOtherDrop = true
	self._elementIds = {}
	self._elementName = {}

	local cfgEle = MainPerformConfig.instance:getElementLstByPointId(MainPerformEnum.ElementPointAdjutant)

	for _, _cfg in ipairs(cfgEle or {}) do
		table.insert(self._elementIds, _cfg.id)
		table.insert(self._elementName, _cfg.name)
	end

	self._heroIds = {}
	self._heroNames = {}
	self._modelIds = {}
	self._skinNames = {}

	local cfgHero = CharacterConfig.instance:getCharacterDataList()

	for k, data in pairs(cfgHero) do
		if data.modelId > 0 and data.id > 2000000 then
			local _cfgModel = ModelConfig.instance:getModelConfig(data.modelId)

			if _cfgModel and _cfgModel.mainSceneElement > 0 then
				table.insert(self._heroIds, data.id)

				local heroName = MainScenePerformUtil.getHeroName(data.id)

				table.insert(self._heroNames, heroName)
				table.insert(self._modelIds, data.modelId)
				table.insert(self._skinNames, "--原皮肤--")
			end
		end
	end

	local cfgSkinList = HeroSkinConfig.instance:getAllInfo()

	for k, data in pairs(cfgSkinList or {}) do
		local heroId = tonumber(data.heroId) or 0

		if heroId > 2000000 then
			local modelId = data.module
			local index = table.indexof(self._heroIds, heroId)

			if index and not table.indexof(self._modelIds, modelId) then
				local heroName = MainScenePerformUtil.getHeroName(heroId)

				table.insert(self._heroIds, index + 1, heroId)
				table.insert(self._heroNames, index + 1, heroName)
				table.insert(self._modelIds, index + 1, modelId)
				table.insert(self._skinNames, index + 1, string.format("<color=#50FF04>%s</color>", data.name))
			end
		end
	end
end

function M:_resetOriginalSelect()
	return
end

function M:_onClickReset()
	self:refreshView()
end

function M:_onClickSave()
	local _camIds = self:getEditCamIds()
	local theId = self._inputSaveCamGroupId:GetText()
	local theName = self._inputSaveCamGroupName:GetText()

	if string.nilorempty(theId) then
		FloatWordMgr.instance:show("请先输入ID")

		return
	end

	theId = tonumber(theId)

	if theId <= 0 then
		FloatWordMgr.instance:show("镜头组ID必须大于0")

		return
	end

	if #_camIds < #MainPerformEnum.CharSysCamGroupItemName then
		TableUtil.dump(_camIds)
		FloatWordMgr.instance:show("镜头数量不匹配")

		return
	end

	local dialogContent
	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformCamGroupChaSysR, theId, true)
	local isNewCam = cfg == nil

	if isNewCam then
		dialogContent = string.format("新建镜头组[%s] 名字[%s] 的配置?", theId, theName)
	else
		dialogContent = string.format("覆盖镜头组[%s] 名字[%s] 的配置?", theId, cfg.name)
	end

	local dialog = Dialog.showMessage("提示", dialogContent)

	dialog:setConfirmListener(function()
		MainScenePerformUtil.changeOrCreateLuaCfg(ConfigName.MainPerformCamGroupChaSysR, MainPerformConfig.instance, theId, {
			camIds = _camIds,
			name = theName
		})
		settimer(0.2, function()
			self:refreshView()
		end, self, false)
	end, self)
end

function M:_onClickSearch()
	if not self._groupId then
		return
	end

	if self._groupId <= 0 then
		return
	end

	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformCamGroupChaSysR, self._groupId)

	if not cfg then
		return
	end

	local useData = self:checkCamGroupUse(self._groupId)

	if useData.isBeUsed then
		local dialog = Dialog.showMessage("引用信息", table.concat(useData.useContent, "\n"))

		printWarn(table.concat(useData.useContent, "\n"))
	else
		FloatWordMgr.instance:show(string.format("镜头组[%s]%s 很干净，没有相关引用", cfg.id, cfg.name))
	end
end

function M:_onClickDelete()
	if not self._groupId then
		return
	end

	if self._groupId <= 0 then
		return
	end

	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformCamGroupChaSysR, self._groupId)

	if not cfg then
		return
	end

	if self._groupId <= 1 then
		FloatWordMgr.instance:show(string.format("镜头组[%s]为保底id不能删除", self._groupId))

		return
	end

	local useData = self:checkCamGroupUse(self._groupId)

	if useData.isBeUsed then
		local dialog = Dialog.showMessage("引用信息", table.concat(useData.useContent, "\n"))

		FloatWordMgr.instance:show(string.format("镜头组[%s][%s] 存在引用，不能直接删除", cfg.id, cfg.name))
		printWarn(table.concat(useData.useContent, "\n"))

		return
	end

	local dialog = Dialog.showMessage("提示", string.format("是否删除镜头组[%s][%s]?", cfg.id, cfg.name))

	dialog:setConfirmListener(function()
		MainScenePerformUtil.deleteLuaCfg(ConfigName.MainPerformCamGroupChaSysR, MainPerformConfig.instance, self._groupId)
		settimer(0.2, function()
			self:refreshView()
		end, self, false)
	end, self)
end

function M:_onDropCamGroupId(index)
	self._groupId = self._groupLstIds[index + 1]
	self._txtDropCamGroupId.text = self._groupId
	self._txtDropCamGroupName.text = self._groupLstName[index + 1]

	self._inputSaveCamGroupId:SetText(self._groupId)
	self._inputSaveCamGroupName:SetText(self._groupLstName[index + 1])
	self:refreshItemLst()

	if self._callOtherDrop then
		self._callOtherDrop = false

		settimer(0, function()
			self._dropCamGroupName.value = index
			self._callOtherDrop = true
		end, self, false)
	end
end

function M:_onDropCamGroupName(index)
	self._groupId = self._groupLstIds[index + 1]
	self._txtDropCamGroupId.text = self._groupId
	self._txtDropCamGroupName.text = self._groupLstName[index + 1]

	self._inputSaveCamGroupId:SetText(self._groupId)
	self._inputSaveCamGroupName:SetText(self._groupLstName[index + 1])
	self:refreshItemLst()

	if self._callOtherDrop then
		self._callOtherDrop = false

		settimer(0, function()
			self._dropCamGroupId.value = index
			self._callOtherDrop = true
		end, self, false)
	end
end

function M:getEditCamIds()
	local ids = {}

	for _, cell in ipairs(self._itemLst or {}) do
		local camCodeId = cell.getCamCode()

		table.insert(ids, camCodeId)
	end

	return ids
end

function M:refreshItemLst()
	self:_clearItems()

	if not self._groupId then
		return
	end

	if self._groupId == 0 then
		return
	end

	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformCamGroupChaSysR, self._groupId)

	if not cfg then
		return
	end

	local len = #self._itemType

	if len > 0 then
		local mainGO = self:getMainGo()

		for i = 1, len do
			self:_addItem(#self._itemLst + 1)
		end
	end

	for index, valueTyp in ipairs(self._itemType or {}) do
		local camCode = cfg.camIds[index]

		self._itemLst[index].updateData(index, valueTyp, camCode)
	end
end

function M:_addItem(index)
	if self._itemLst[index] then
		printError("已有index:", index)
	else
		local parent = self._subPanelGo[M.PageType.Base].transform
		local go = goutil.cloneAndSetParent(self._goPrefabItem, parent)
		local cell = self:_buildItem(go, index)

		goutil.setActive(go, true)

		self._itemLst[index] = cell
	end
end

function M:_clearItems()
	for index, cell in ipairs(self._itemLst or {}) do
		cell.destroyUI()
		goutil.destroy(cell.go)
	end

	self._itemLst = {}
end

function M:_buildItem(go, index)
	local data = {}

	data.go = go
	data.index = index
	data.txtName = goutil.findChildTextComponent(go, "txtName")
	data.btnPlay = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnPlay").gameObject)
	data.dropCamId = goutil.findChildComponent(go, "dropDown_id", UIComponentType.Dropdown)
	data.dropAdapterCamId = goutil.findChildComponent(go, "dropDown_id", UIComponentType.DropdownApapter)
	data.txtDropCamId = goutil.findChildTextComponent(go, "dropDown_id/Label")
	data.dropCamName = goutil.findChildComponent(go, "dropDown_name", UIComponentType.Dropdown)
	data.dropAdapterCamName = goutil.findChildComponent(go, "dropDown_name", UIComponentType.DropdownApapter)
	data.txtDropCamName = goutil.findChildTextComponent(go, "dropDown_name/Label")

	data.btnPlay:AddClickListener(function()
		self:_onCellClickPlayCamCode(data.camCode)
	end, self)
	data.dropAdapterCamId:AddListener(function(handler, _index)
		data.onDropCamId(_index)
	end, self)
	data.dropAdapterCamName:AddListener(function(handler, _index)
		data.onDropCamName(_index)
	end, self)

	function data.destroyUI()
		data.btnPlay:RemoveClickListener()
		data.dropAdapterCamId:RemoveClickListener()
		data.dropAdapterCamName:RemoveClickListener()
	end

	function data.tryInit()
		if not data.isInit then
			data.isInit = true

			MainScenePerformUtil.updateDropDownLst(data.dropCamId, self._camCodeLstIds)
			MainScenePerformUtil.updateDropDownLst(data.dropCamName, self._camCodeLstName)

			data.callOtherDrop = false
			data.dropCamId.value = 0
			data.dropCamName.value = 0

			data.onDropCamId(0)
			data.onDropCamName(0)

			data.callOtherDrop = true
		end
	end

	function data.updateData(_index, typ, camCode)
		data.tryInit()

		data.index = _index
		data.txtName.text = MainPerformEnum.CharSysCamGroupItemName[typ] or "nil"
		data.camCode = camCode

		local selectIndex = table.indexof(self._camCodeLstIds, camCode)

		data.dropCamId.value = selectIndex and selectIndex - 1 or 0
	end

	function data.getCamCode()
		return data.camCode
	end

	function data.onDropCamId(_index)
		local camId = self._camCodeLstIds[_index + 1]
		local camName = self._camCodeLstName[_index + 1]

		data.txtDropCamId.text = camId
		data.txtDropCamName.text = camName
		data.camCode = camId

		if data.callOtherDrop then
			data.callOtherDrop = false
			data.dropCamName.value = _index
			data.callOtherDrop = true
		end
	end

	function data.onDropCamName(_index)
		local camId = self._camCodeLstIds[_index + 1]
		local camName = self._camCodeLstName[_index + 1]

		data.txtDropCamId.text = camId
		data.txtDropCamName.text = camName
		data.camCode = camId

		if data.callOtherDrop then
			data.callOtherDrop = false
			data.dropCamId.value = _index
			data.callOtherDrop = true
		end
	end

	return data
end

function M:_onCellClickPlayCamCode(camCode)
	camCode = camCode or 0

	MainScenePerformUtil.tweenMainSceneCam(camCode, 0.5)
end

function M:checkCamGroupUse(camGroupId)
	local useData = {
		isBeUsed = false,
		useContent = {}
	}
	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformCamGroupChaSysR, camGroupId)

	if cfg then
		local cfgElementRLst = MainPerformConfig.instance:getConfigList(ConfigName.MainInteractElementR)

		for _, _cfg in ipairs(cfgElementRLst or {}) do
			if _cfg.charSysCamGroup > 0 and _cfg.charSysCamGroup == camGroupId then
				local cfgEle = MainPerformConfig.instance:getConfigByKey(ConfigName.MainInteractElement, _cfg.id)
				local eleName = cfgEle and cfgEle.name or "?"

				useData.isBeUsed = true

				table.insert(useData.useContent, string.format("镜头组[%s][%s] 已被设置为元素[%s][%s] 的默认镜头", cfg.id, cfg.name, _cfg.id, eleName))
			end
		end

		local cfgLandLadyRLst = MainPerformConfig.instance:getConfigList(ConfigName.MainPerformLandladyR)

		for _, _cfg in ipairs(cfgLandLadyRLst or {}) do
			if _cfg.charSysCamGroup > 0 and _cfg.charSysCamGroup == cfg.id then
				useData.isBeUsed = true

				table.insert(useData.useContent, string.format("镜头组[%s][%s] 已被设置为模型[%s] 使用", cfg.id, cfg.name, _cfg.id))
			end
		end
	end

	return useData
end

function M:_onCellUpdateEle(curIndex)
	curIndex = curIndex + 1

	local item = self._loopLstEle:NewListViewItem("edit_item")

	self:_updateCellEle(item.gameObject, curIndex)

	return item
end

function M:_onCellUpdateHero(curIndex)
	curIndex = curIndex + 1

	local item = self._loopLstHero:NewListViewItem("edit_item")

	self:_updateCellHero(item.gameObject, curIndex)

	return item
end

function M:_updateCellEle(go, index)
	local key = go:GetInstanceID()
	local theItem = self._cellEle[key]

	if not theItem then
		theItem = {
			index = index,
			txtName = goutil.findChildTextComponent(go, "txtName"),
			dropId = goutil.findChildComponent(go, "dropDown_id", UIComponentType.SpaceXDropDown),
			txtDropId = goutil.findChildTextComponent(go, "dropDown_id/Label"),
			dropName = goutil.findChildComponent(go, "dropDown_name", UIComponentType.SpaceXDropDown),
			txtDropName = goutil.findChildTextComponent(go, "dropDown_name/Label"),
			btnSave = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnSave").gameObject)
		}

		function theItem.getIndex()
			return theItem.index
		end

		function theItem.getCamGroupId()
			return self._groupLstIds[theItem.dropId.value + 1]
		end

		function theItem.tryInit()
			if not theItem.isInit then
				theItem.isInit = true

				theItem.dropId:UpdateDropDownList(self._groupLstIds)
				theItem.dropName:UpdateDropDownList(self._groupLstName)
			end
		end

		theItem.dropId:AddOnValueChange(function(_index)
			theItem.dropName:SetValueWithoutNotify(_index)
		end)
		theItem.dropName:AddOnValueChange(function(_index)
			theItem.dropId:SetValueWithoutNotify(_index)
		end)
		theItem.btnSave:AddClickListener(function()
			local elementId = self._elementIds[theItem.getIndex()]
			local elementName = self._elementName[theItem.getIndex()]
			local camGroupId = theItem.getCamGroupId()
			local camGroupName = theItem.txtDropName.text

			self:_onCellClickSaveToElement(elementId, elementName, camGroupId, camGroupName)
		end, self)

		function theItem.destroyUI()
			theItem.btnSave:RemoveClickListener()
			theItem.dropId:RemoveAllListener()
			theItem.dropName:RemoveAllListener()
		end

		self._cellEle[key] = theItem
	end

	theItem.index = index

	theItem.tryInit()

	local elementId = self._elementIds[index]
	local name = self._elementName[index]

	theItem.txtName.text = string.format("%s\n%s", elementId, name)

	local camGroupId = MainPerformConfig.instance:getElementDefaultCharSysCamGroupId(elementId, false)

	camGroupId = camGroupId or 0

	local selectIndex = table.indexof(self._groupLstIds, camGroupId)

	theItem.dropId.value = selectIndex - 1
end

function M:_updateCellHero(go, index)
	local key = go:GetInstanceID()
	local theItem = self._cellHero[key]

	if not theItem then
		theItem = {
			index = index,
			txtName = goutil.findChildTextComponent(go, "txtName"),
			dropId = goutil.findChildComponent(go, "dropDown_id", UIComponentType.SpaceXDropDown),
			txtDropId = goutil.findChildTextComponent(go, "dropDown_id/Label"),
			dropName = goutil.findChildComponent(go, "dropDown_name", UIComponentType.SpaceXDropDown),
			txtDropName = goutil.findChildTextComponent(go, "dropDown_name/Label"),
			btnSave = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnSave").gameObject)
		}

		function theItem.getIndex()
			return theItem.index
		end

		function theItem.getCamGroupId()
			return self._groupLstIds[theItem.dropId.value + 1]
		end

		function theItem.tryInit()
			if not theItem.isInit then
				theItem.isInit = true

				theItem.dropId:UpdateDropDownList(self._groupLstIds)
				theItem.dropName:UpdateDropDownList(self._groupLstName)
			end
		end

		theItem.dropId:AddOnValueChange(function(_index)
			theItem.dropName:SetValueWithoutNotify(_index)
		end)
		theItem.dropName:AddOnValueChange(function(_index)
			theItem.dropId:SetValueWithoutNotify(_index)
		end)
		theItem.btnSave:AddClickListener(function()
			local heroId = self._heroIds[theItem.getIndex()]
			local heroName = self._heroNames[theItem.getIndex()]
			local modelId = self._modelIds[theItem.getIndex()]
			local skinName = self._skinNames[theItem.getIndex()]
			local camGroupId = theItem.getCamGroupId()
			local camGroupName = theItem.txtDropName.text

			self:_onCellClickSaveToHero(heroId, modelId, heroName, skinName, camGroupId, camGroupName)
		end, self)

		function theItem.destroyUI()
			theItem.btnSave:RemoveClickListener()
			theItem.dropId:RemoveAllListener()
			theItem.dropName:RemoveAllListener()
		end

		self._cellHero[key] = theItem
	end

	theItem.index = index

	theItem.tryInit()

	local heroId = self._heroIds[index]
	local modelId = self._modelIds[index]
	local heroName = self._heroNames[index]
	local skinName = self._skinNames[index]

	theItem.txtName.text = string.format("%s\n%s\n%s\n%s", heroId, heroName, modelId, skinName)

	local cfgR = MainPerformConfig.instance:getLandLadyRConfig(modelId)
	local camGroupId = cfgR and cfgR.charSysCamGroup or nil

	camGroupId = camGroupId or 0

	local selectIndex = table.indexof(self._groupLstIds, camGroupId)

	theItem.dropId.value = selectIndex - 1
end

function M:_onCellClickSaveToElement(elementId, elementName, camGroupId, camGroupName)
	local dialog = Dialog.showMessage("提示", string.format("设置元素 [%s] %s 的镜头组为 [%s] %s 嘛？", elementId, elementName, camGroupId, camGroupName))

	dialog:setConfirmListener(function()
		MainScenePerformUtil.changeOrCreateLuaCfg(ConfigName.MainInteractElementR, MainPerformConfig.instance, elementId, {
			charSysCamGroup = camGroupId
		})
		settimer(0.2, function()
			self._loopLstEle:RefreshAllShownItem()
		end, self, false)
	end, self)
end

function M:_onCellClickSaveToHero(heroId, modelId, heroName, skinName, camGroupId, camGroupName)
	local dialog = Dialog.showMessage("提示", string.format("设置角色 [%s] %s, 皮肤:%s, 模型%s 的镜头组为\n [%s] %s 嘛？", heroId, heroName, skinName, modelId, camGroupId, camGroupName))

	dialog:setConfirmListener(function()
		MainScenePerformUtil.changeOrCreateLuaCfg(ConfigName.MainPerformLandladyR, MainPerformConfig.instance, modelId, {
			charSysCamGroup = camGroupId
		})
		settimer(0.2, function()
			self._loopLstHero:RefreshAllShownItem()
		end, self, false)
	end, self)
end

return M
