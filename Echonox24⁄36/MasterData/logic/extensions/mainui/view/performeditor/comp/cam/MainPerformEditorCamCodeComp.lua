-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/cam/MainPerformEditorCamCodeComp.lua

module("logic.extensions.mainui.view.performeditor.comp.cam.MainPerformEditorCamCodeComp", package.seeall)

local M = class("MainPerformEditorCamCodeComp", MainPerformEditorCompBase)

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self:getMainGo()

	self._dropDownID = goutil.findChildComponent(mainGO, "select/dropDown_id", UIComponentType.Dropdown)
	self._dropAdapterID = goutil.findChildComponent(mainGO, "select/dropDown_id", UIComponentType.DropdownApapter)
	self._txtDropID = goutil.findChildTextComponent(mainGO, "select/dropDown_id/Label")
	self._dropDownName = goutil.findChildComponent(mainGO, "select/dropDown_name", UIComponentType.Dropdown)
	self._dropAdapterName = goutil.findChildComponent(mainGO, "select/dropDown_name", UIComponentType.DropdownApapter)
	self._txtDropName = goutil.findChildTextComponent(mainGO, "select/dropDown_name/Label")
	self._btnReset = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "select/btnReset").gameObject)
	self._btnSearch = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "select/btnSearch").gameObject)
	self._btnDelete = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "select/btnDelete").gameObject)
	self._btnGet = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "select/output/btnGet").gameObject)
	self._btnSave = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "select/btnSave").gameObject)
	self._inputOutPut = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "select/output/input_output").gameObject)
	self._inputSaveCamCode = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "select/btnSave/input_camCode").gameObject)
	self._inputSaveCamName = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "select/btnSave/input_name").gameObject)
	self._toggleCloseCamOffset = goutil.findChildComponent(mainGO, "select/toggle_closeCamOffset", UIComponentType.SpaceXToggle)
	self._toggleCloseCamOffset.IsOn = false
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._inputOutPut = nil
	self._btnReset = nil
	self._btnDelete = nil
	self._btnGet = nil
	self._btnSave = nil
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnSearch:AddClickListener(self._onClickResearch, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnDelete:AddClickListener(self._onClickDelete, self)
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._dropAdapterID:AddListener(self._onDropDownID, self)
	self._dropAdapterName:AddListener(self._onDropDownName, self)
	self._toggleCloseCamOffset:AddListener(self._onToggleCloseCamOffset, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnSearch:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnDelete:RemoveClickListener()
	self._btnGet:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._dropAdapterID:RemoveClickListener()
	self._dropAdapterName:RemoveClickListener()
	self._toggleCloseCamOffset:RemoveListener()
end

function M:onEnter()
	M.super.onEnter(self)
	self:refreshView()

	self._toggleCloseCamOffset.IsOn = false
end

function M:onExit()
	M.super.onExit(self)
	self:_onToggleCloseCamOffset(nil, false)
end

function M:canShow()
	return self:getPoint() == 0
end

function M:IsDataDirty()
	return false
end

function M:_onToggleCloseCamOffset(_, isOn)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Room then
		local sceneCam = SceneMgr.instance:getCurScene().camera
		local camOffset = sceneCam:getCamOffset()

		camOffset.enabled = not isOn
	end
end

function M:_onClickResearch()
	if not self._camCode then
		return
	end

	local camName = self:getCamName(self._camCode)
	local useData = self:checkCamUse(self._camCode)

	if useData.isBeUsed then
		local dialog = Dialog.showMessage("引用信息", table.concat(useData.useContent, "\n"))
	else
		FloatWordMgr.instance:show(string.format("镜头[%s]%s 很干净，没有相关引用", self._camCode, camName))
	end
end

function M:_onClickReset()
	self:refreshView()

	local camCode = 0
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Room then
		local sceneCam = scene.camera
		local _duration = 0.4

		sceneCam:releaseCamTween()
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CAM_OFFSET_CTRL, _duration - 0.1)
		sceneCam:tweenCam(camCode, _duration, nil, true)
	end

	self._inputOutPut:SetText(self:getCamCfgStr(camCode))
end

function M:_onClickDelete()
	if not self._camCode then
		return
	end

	local camName = self:getCamName(self._camCode)

	if self._camCode <= 1 then
		FloatWordMgr.instance:show(string.format("镜头[%s] 名字[%s] 为默认镜头，不能删除", self._camCode, camName))

		return
	end

	local useData = self:checkCamUse(self._camCode)

	if useData.isBeUsed then
		local dialog = Dialog.showMessage("引用信息", table.concat(useData.useContent, "\n"))

		FloatWordMgr.instance:show(string.format("镜头[%s] 名字[%s],被配置引用,不能删除", self._camCode, camName))
		printWarn(table.concat(useData.useContent, "\n"))

		return
	end

	local dialog = Dialog.showMessage("提示", string.format("删除镜头[%s] 名字[%s]的配置？", self._camCode, camName))

	dialog:setConfirmListener(function()
		MainScenePerformUtil.deleteLuaCfg(ConfigName.MainPerformCameraR, MainPerformConfig.instance, self._camCode)
		settimer(0.2, function()
			self:refreshView()
		end, self, false)
	end, self)
end

function M:_onClickGet()
	local x, y, z, rx, ry, rz, fov = self:getActiveCamData()

	self._inputOutPut:SetText(string.format("%s,%s,%s,%s,%s,%s,%s", x, y, z, rx, ry, rz, fov))
end

function M:_onClickSave()
	local sceneType = SceneMgr.instance:getCurSceneType()

	if sceneType ~= SceneType.Room then
		printWarn("非主场景，不响应操作")

		return
	end

	local posInfoStr = self._inputOutPut:GetText()

	if string.nilorempty(posInfoStr) then
		FloatWordMgr.instance:show("请先获取数据")

		return
	end

	local theId = self._inputSaveCamCode:GetText()

	if string.nilorempty(theId) then
		FloatWordMgr.instance:show("请先输入ID")

		return
	end

	local sceneCam = SceneMgr.instance:getCurScene().camera
	local camOffset = sceneCam:getCamOffset()

	if camOffset.enabled and sceneCam:getCamOffset():GetOffsetX() ~= 0 then
		FloatWordMgr.instance:show(string.format("镜头因左右滑动，有偏移( %s, 0, 0),请重置或禁用组件", sceneCam:getCamOffset():GetOffsetX()))

		return
	end

	theId = tonumber(theId)

	local theCamName = self._inputSaveCamName:GetText() or ""
	local dialogContent
	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformCameraR, theId, true)
	local isNewCam = cfg == nil

	if isNewCam then
		dialogContent = string.format("新建镜头[%s] 名字[%s] 的配置?", theId, theCamName)
	else
		dialogContent = string.format("覆盖镜头[%s] 名字[%s] 的配置?", theId, cfg.name)
	end

	local dialog = Dialog.showMessage("提示", dialogContent)

	dialog:setConfirmListener(function()
		local _posData = {}
		local arrSingleStep = string.split(posInfoStr, ",")

		for index, value in ipairs(arrSingleStep) do
			table.insert(_posData, tonumber(value))
		end

		MainScenePerformUtil.changeOrCreateLuaCfg(ConfigName.MainPerformCameraR, MainPerformConfig.instance, theId, {
			posData = _posData,
			name = theCamName
		})
		settimer(0.2, function()
			self:refreshView()
		end, self, false)
	end, self)
end

function M:refreshView()
	local selectIndex = 0

	self._nameLst = {}
	self._codeLst = {}
	self._maxCode = 0
	self._cfgLst = MainPerformConfig.instance:getConfigList(ConfigName.MainPerformCameraR)

	if self._cfgLst and #self._cfgLst > 0 then
		for _, _cfg in ipairs(self._cfgLst) do
			if _cfg.id >= 0 then
				table.insert(self._codeLst, _cfg.id)
				table.insert(self._nameLst, self:getCamName(_cfg.id))

				self._maxCode = _cfg.id >= self._maxCode and _cfg.id or self._maxCode
			end
		end
	end

	MainScenePerformUtil.updateDropDownLst(self._dropDownID, self._codeLst)
	MainScenePerformUtil.updateDropDownLst(self._dropDownName, self._nameLst)

	self._callOtherDrop = false
	self._dropDownID.value = selectIndex
	self._dropDownName.value = selectIndex

	self:_onDropDownID(selectIndex)
	self:_onDropDownName(selectIndex)

	self._callOtherDrop = true
end

function M:_onDropDownID(index)
	self._camCode = self._codeLst[index + 1]
	self._txtDropID.text = self._camCode

	self._inputSaveCamCode:SetText(self._camCode)

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Room then
		local sceneCam = scene.camera
		local _duration = 0.4

		sceneCam:releaseCamTween()
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CAM_OFFSET_CTRL, _duration - 0.1)
		sceneCam:tweenCam(self._camCode, _duration, nil, true)
	end

	self._inputOutPut:SetText(self:getCamCfgStr(self._camCode))

	if self._callOtherDrop then
		self._callOtherDrop = false

		settimer(0, function()
			self._dropDownName.value = index
			self._callOtherDrop = true
		end, self, false)
	end
end

function M:_onDropDownName(index)
	self._camCode = self._codeLst[index + 1]

	local camName = self:getCamName(self._camCode)

	self._txtDropName.text = camName

	self._inputSaveCamName:SetText(camName)

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Room then
		local sceneCam = scene.camera
		local _duration = 0

		sceneCam:releaseCamTween()
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CAM_OFFSET_CTRL, _duration)
		sceneCam:tweenCam(self._camCode, _duration, nil, true)
	end

	self._inputOutPut:SetText(self:getCamCfgStr(self._camCode))

	if self._callOtherDrop then
		self._callOtherDrop = false

		settimer(0, function()
			self._dropDownID.value = index
			self._callOtherDrop = true
		end, self, false)
	end
end

function M:getActiveCamData()
	local camUnit = VirtualCameraMgr.instance:getActiveCamera()
	local camGo = camUnit:getMainGO()
	local x, y, z = TransformUtils.GetLocalPosition(camGo.transform, 0, 0, 0)
	local rx, ry, rz = TransformUtils.GetLocalEulerAngles(camGo.transform, 0, 0, 0)

	x = self:_formatVal(x)
	y = self:_formatVal(y)
	z = self:_formatVal(z)
	rx = self:_formatVal(rx, true)
	ry = self:_formatVal(ry, true)
	rz = self:_formatVal(rz, true)

	local fov = camUnit:getFieldOfView()

	return x, y, z, rx, ry, rz, fov
end

function M:_formatVal(val, isRotate)
	local finalVal = 0

	if isRotate then
		val = val % 360

		local precision = 10

		finalVal = math.ceil(val * precision) / precision
	else
		local precision = 1000

		finalVal = math.floor(val * precision) / precision
	end

	if math.abs(finalVal) == 0 then
		finalVal = 0
	end

	return finalVal
end

function M:getCamName(camCode)
	if not camCode then
		return nil
	end

	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformCameraR, camCode)

	return cfg and cfg.name or nil
end

function M:getCamCfgStr(camCode)
	if not camCode then
		return nil
	end

	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformCameraR, camCode)
	local posData = cfg and cfg.posData or {}

	return string.format("%s,%s,%s,%s,%s,%s,%s", posData[1] or 0, posData[2] or 0, posData[3] or 0, posData[4] or 0, posData[5] or 0, posData[6] or 0, posData[7] or MainPerformEnum.DefaultFov)
end

function M:checkCamUse(camCode)
	local useData = {
		isBeUsed = false,
		useContent = {}
	}
	local cfgLst = MainPerformConfig.instance:getConfigList(ConfigName.MainPerformCamGroupChaSysR)

	if cfgLst and #cfgLst > 0 then
		for _, _cfg in ipairs(cfgLst) do
			for _, _camCode in ipairs(_cfg.camIds or {}) do
				if _camCode == camCode then
					useData.isBeUsed = true

					table.insert(useData.useContent, string.format("镜头[%s][%s] 已被镜头组[%s][%s] 引用", camCode, self:getCamName(camCode), _cfg.id, _cfg.name))
				end
			end
		end
	end

	return useData
end

return M
