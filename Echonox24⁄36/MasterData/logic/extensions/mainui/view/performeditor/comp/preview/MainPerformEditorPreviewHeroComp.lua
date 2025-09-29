-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/preview/MainPerformEditorPreviewHeroComp.lua

module("logic.extensions.mainui.view.performeditor.comp.preview.MainPerformEditorPreviewHeroComp", package.seeall)

local kHeroConfigName = ConfigName.CharacterPreviewInfo
local M = class("MainPerformEditorPreviewHeroComp", MainPerformEditorCompBase)

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)
end

function M:buildUI()
	local compGo = self:getMainGo()
	local mainGo = goutil.findChild(compGo, "content")
	local goHero = goutil.findChild(mainGo, "hero")

	self._dropDownID = goutil.findChildComponent(goHero, "dropDown_id", UIComponentType.Dropdown)
	self._dropAdapterID = goutil.findChildComponent(goHero, "dropDown_id", UIComponentType.DropdownApapter)
	self._txtDropID = goutil.findChildComponent(goHero, "dropDown_id/Label", UIComponentType.Text)
	self._dropDownName = goutil.findChildComponent(goHero, "dropDown_name", UIComponentType.Dropdown)
	self._dropAdapterName = goutil.findChildComponent(goHero, "dropDown_name", UIComponentType.DropdownApapter)
	self._txtDropName = goutil.findChildComponent(goHero, "dropDown_name/Label", UIComponentType.Text)

	local goCam = goutil.findChild(mainGo, "camera")
	local goPos = goutil.findChild(mainGo, "position")

	self._camCell = self:_buildDropCell(goCam, self._onSelectCam)
	self._posCell = self:_buildDropCell(goPos, self._onSelectPos)
	self._btnSave = UIComponentType.ButtonAdapter(goutil.findChild(mainGo, "btnSave"))
	self._btnDelete = UIComponentType.ButtonAdapter(goutil.findChild(mainGo, "btnDelete"))
	self._inputSaveCode = UIComponentType.InputFieldAdapter(goutil.findChild(mainGo, "btnSave/input_camCode"))
	self._inputSaveName = UIComponentType.InputFieldAdapter(goutil.findChild(mainGo, "btnSave/input_name"))
end

function M:bindEvents()
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnDelete:AddClickListener(self._onClickDelete, self)
	self._dropAdapterID:AddListener(self._onDropDownID, self)
	self._dropAdapterName:AddListener(self._onDropDownName, self)
end

function M:unbindEvents()
	self._btnSave:RemoveClickListener()
	self._btnDelete:RemoveClickListener()
	self._dropAdapterID:RemoveClickListener()
	self._dropAdapterName:RemoveClickListener()
end

function M:onEnter()
	self:refreshView()
end

function M:onExit()
	return
end

function M:refreshView()
	self:_initDropDown(self._camCell, ConfigName.CharacterPreviewCamInfo)
	self:_initDropDown(self._posCell, ConfigName.CharacterPreviewPosInfo)

	local selectIndex = 0

	self._codeLst = {}
	self._nameLst = {}
	self._config = CharacterPreviewConfig.instance:getConfig(kHeroConfigName)
	self._heroCoList = CharacterPreviewConfig.instance:getConfigList(kHeroConfigName)

	for _, heroCo in ipairs(self._heroCoList) do
		table.insert(self._codeLst, heroCo.id)
		table.insert(self._nameLst, heroCo.name)
	end

	MainScenePerformUtil.updateDropDownLst(self._dropDownID, self._codeLst)
	MainScenePerformUtil.updateDropDownLst(self._dropDownName, self._nameLst)

	self._dropDownID.value = selectIndex
	self._dropDownName.value = selectIndex

	self:_onDropDownID(selectIndex)
	self:_onDropDownName(selectIndex)
end

function M:_initDropDown(dropCell, configName)
	local selectIndex = 0
	local codeLst = {}
	local nameLst = {}
	local cfgList = CharacterPreviewConfig.instance:getConfigList(configName)

	if cfgList and #cfgList > 0 then
		for _, heroCo in ipairs(cfgList) do
			table.insert(codeLst, heroCo.id)
			table.insert(nameLst, heroCo.name)
		end
	end

	MainScenePerformUtil.updateDropDownLst(dropCell.dropDownID, codeLst)
	MainScenePerformUtil.updateDropDownLst(dropCell.dropDownName, nameLst)

	dropCell.dropDownID.value = selectIndex
	dropCell.dropDownName.value = selectIndex
end

function M:_onDropDownID(index)
	self:_onSelectChange(index)
end

function M:_onDropDownName(index)
	self:_onSelectChange(index)
end

function M:_onSelectChange(index)
	local realIndex = index + 1

	self._posCode = self._codeLst[realIndex]

	local posName = self._nameLst[realIndex]

	self._txtDropID.text = self._posCode
	self._txtDropName.text = posName

	self._inputSaveCode:SetText(self._posCode)
	self._inputSaveName:SetText(posName)

	local heroCo = self:_getHeroCo(realIndex)

	self:_onSelectCam(nil, heroCo.camId)
	self:_onSelectPos(nil, heroCo.posId)
end

function M:_buildDropCell(go, onSelectIndex)
	local dropDownID = goutil.findChildComponent(go, "dropDown_id", UIComponentType.Dropdown)
	local dropAdapterID = goutil.findChildComponent(go, "dropDown_id", UIComponentType.DropdownApapter)
	local txtDropID = goutil.findChildComponent(go, "dropDown_id/Label", UIComponentType.Text)
	local dropDownName = goutil.findChildComponent(go, "dropDown_name", UIComponentType.Dropdown)
	local dropAdapterName = goutil.findChildComponent(go, "dropDown_name", UIComponentType.DropdownApapter)
	local txtDropName = goutil.findChildComponent(go, "dropDown_name/Label", UIComponentType.Text)

	dropAdapterID:AddListener(onSelectIndex, self)
	dropAdapterName:AddListener(onSelectIndex, self)

	local cell = {
		dropDownID = dropDownID,
		txtDropID = txtDropID,
		dropDownName = dropDownName,
		txtDropName = txtDropName
	}

	return cell
end

function M:_onSelectCam(index, code)
	local realCode = code or CharacterPreviewConfig.instance:getConfigList(ConfigName.CharacterPreviewCamInfo)[index + 1].id
	local camCo = CharacterPreviewConfig.instance:getCamCfg()[realCode]

	self._camCell.txtDropID.text = camCo.id
	self._camCell.txtDropName.text = camCo.name

	GlobalDispatcher:dispatchEvent(EventType.HERO_PREVIEW_CAM_CTRL, camCo)
end

function M:_onSelectPos(index, code)
	local realCode = code or CharacterPreviewConfig.instance:getConfigList(ConfigName.CharacterPreviewPosInfo)[index + 1].id
	local posCo = CharacterPreviewConfig.instance:getPosCfg()[realCode]

	self._posCell.txtDropID.text = posCo.id
	self._posCell.txtDropName.text = posCo.name

	GlobalDispatcher:dispatchEvent(EventType.HERO_PREVIEW_POS_CTRL, posCo)
end

function M:_getHeroCo(index)
	local code = self._codeLst[index]

	return self:_getHeroCoById(code)
end

function M:_getHeroCoById(code)
	return self._config[code]
end

function M:_onClickSave()
	local id = self._inputSaveCode:GetText()

	if string.nilorempty(id) or not tonumber(id) then
		FloatWordMgr.instance:show("请先输入ID")

		return
	end

	id = tonumber(id)

	if id > 1 and CharacterConfig.instance:getCfgInfoByID(id) == nil then
		FloatWordMgr.instance:show(string.format("找不到Id为 [%d] 的角色！", id))

		return
	end

	local name = self._inputSaveName:GetText() or ""
	local dialogContent
	local heroCo = self:_getHeroCoById(id)

	if heroCo == nil then
		dialogContent = string.format("新建角色预览[%s] 名字[%s] 的配置?", id, name)
	else
		dialogContent = string.format("覆盖角色预览[%s] 名字[%s] 的配置?", id, heroCo.name)
	end

	local dialog = Dialog.showMessage("提示", dialogContent)

	dialog:setConfirmListener(function()
		local camId = tonumber(self._camCell.txtDropID.text)
		local posId = tonumber(self._posCell.txtDropID.text)

		MainScenePerformUtil.changeOrCreateLuaCfg(kHeroConfigName, CharacterPreviewConfig.instance, id, {
			camId = camId,
			posId = posId,
			name = name
		})
		self:refreshView()
	end, self)
end

function M:_onClickDelete()
	local id = self._inputSaveCode:GetText()

	if string.nilorempty(id) then
		FloatWordMgr.instance:show("请先输入删除ID")

		return
	end

	id = tonumber(id)

	local posName = self._inputSaveName:GetText()

	if id <= 1 then
		FloatWordMgr.instance:show(string.format("角色预览[%s] 名字[%s] 为默认位置，不能删除", id, posName))

		return
	end

	local dialog = Dialog.showMessage("提示", string.format("删除角色预览[%s] 名字[%s]的配置？", id, posName))

	dialog:setConfirmListener(function()
		MainScenePerformUtil.deleteLuaCfg(kHeroConfigName, CharacterPreviewConfig.instance, id)
		self:refreshView()
	end, self)
end

return M
