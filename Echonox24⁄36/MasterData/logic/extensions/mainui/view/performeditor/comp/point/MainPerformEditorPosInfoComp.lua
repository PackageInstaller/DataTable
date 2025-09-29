-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/point/MainPerformEditorPosInfoComp.lua

module("logic.extensions.mainui.view.performeditor.comp.point.MainPerformEditorPosInfoComp", package.seeall)

local M = class("MainPerformEditorPosInfoComp", MainPerformEditorCompBase)

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self:getMainGo()

	self._goContent = goutil.findChild(mainGO, "content").gameObject

	goutil.setActive(self._goContent, true)

	self._inputPX = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/position/input_x"))
	self._inputPY = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/position/input_y"))
	self._inputPZ = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/position/input_z"))
	self._inputRX = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/rotation/input_x"))
	self._inputRY = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/rotation/input_y"))
	self._inputRZ = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/rotation/input_z"))
	self._inputScale = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/scale/input_x"))
	self._inputOutPut = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/output/input_output"))
	self._toggleChange = goutil.findChildComponent(mainGO, "content/toggle_posEditor", UIComponentType.SpaceXToggle)
	self._toggleChangeType = goutil.findChildComponent(mainGO, "content/toggle_posEditTyp", UIComponentType.SpaceXToggle)
	self._inputColliderCenterX = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/collider_center/input_x"))
	self._inputColliderCenterY = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/collider_center/input_y"))
	self._inputColliderCenterZ = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/collider_center/input_z"))
	self._inputColliderSizeX = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/collider_size/input_x"))
	self._inputColliderSizeY = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/collider_size/input_y"))
	self._inputColliderSizeZ = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/collider_size/input_z"))
	self._btnGet = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "content/btnGet").gameObject)
	self._btnSave = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "content/btnSave").gameObject)
	self._btnReset = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "content/btnReset").gameObject)
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._goContent = nil
	self._inputPX = nil
	self._inputPY = nil
	self._inputPZ = nil
	self._inputRX = nil
	self._inputRY = nil
	self._inputRZ = nil
	self._inputScale = nil
	self._inputOutPut = nil
	self._inputColliderCenterX = nil
	self._inputColliderCenterY = nil
	self._inputColliderCenterZ = nil
	self._inputColliderSizeX = nil
	self._inputColliderSizeY = nil
	self._inputColliderSizeZ = nil

	self:startTimerUpdatePosInfo(false)
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._inputPX:AddOnEndEdit(self._onInputEndPos, self)
	self._inputPY:AddOnEndEdit(self._onInputEndPos, self)
	self._inputPZ:AddOnEndEdit(self._onInputEndPos, self)
	self._inputRX:AddOnEndEdit(self._onInputEndRotate, self)
	self._inputRY:AddOnEndEdit(self._onInputEndRotate, self)
	self._inputRZ:AddOnEndEdit(self._onInputEndRotate, self)
	self._inputScale:AddOnEndEdit(self._onInputEndScale, self)
	self._inputColliderCenterX:AddOnEndEdit(self._onInputEndCollider, self)
	self._inputColliderCenterY:AddOnEndEdit(self._onInputEndCollider, self)
	self._inputColliderCenterZ:AddOnEndEdit(self._onInputEndCollider, self)
	self._inputColliderSizeX:AddOnEndEdit(self._onInputEndCollider, self)
	self._inputColliderSizeY:AddOnEndEdit(self._onInputEndCollider, self)
	self._inputColliderSizeZ:AddOnEndEdit(self._onInputEndCollider, self)
	self._toggleChange:AddListener(self._onToggleChange, self)
	self._toggleChangeType:AddListener(self._onToggleChangeType, self)
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)

	self._toggleChange.IsOn = false

	self:_afterToggleChange(false)
	self._inputPX:RemoveOnEndEdit()
	self._inputPY:RemoveOnEndEdit()
	self._inputPZ:RemoveOnEndEdit()
	self._inputRX:RemoveOnEndEdit()
	self._inputRY:RemoveOnEndEdit()
	self._inputRZ:RemoveOnEndEdit()
	self._inputScale:RemoveOnEndEdit()
	self._inputColliderCenterX:RemoveOnEndEdit()
	self._inputColliderCenterY:RemoveOnEndEdit()
	self._inputColliderCenterZ:RemoveOnEndEdit()
	self._inputColliderSizeX:RemoveOnEndEdit()
	self._inputColliderSizeY:RemoveOnEndEdit()
	self._inputColliderSizeZ:RemoveOnEndEdit()
	self._toggleChange:RemoveListener()
	self._toggleChangeType:RemoveListener()
	self._btnGet:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function M:onEnter()
	M.super.onEnter(self)

	self._toggleChange.IsOn = false
	self._toggleChangeType.IsOn = false

	self:setEvent(true)
	self:_onClickReset()
end

function M:onExit()
	M.super.onExit(self)
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:onEditHeroChange(heroId)
	self._toggleChange.IsOn = false

	self:_afterToggleChange(false)
	self:setDispatchEvent(false)

	if SceneFace.instance:isCurScene(SceneType.Room) then
		local point = self:getPoint()
		local cfg
		local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)
		local modelId = unitHero and unitHero:getModelId() or 0

		if unitHero then
			if point == MainPerformEnum.ElementPointAdjutant then
				cfg = MainPerformConfig.instance:getLandLadyRConfig(modelId)
			else
				cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformHeroR, modelId)
			end
		end

		local px = cfg and cfg.posData[1] or 0
		local py = cfg and cfg.posData[2] or 0
		local pz = cfg and cfg.posData[3] or 0
		local rx = cfg and cfg.posData[4] or 0
		local ry = cfg and cfg.posData[5] or 0
		local rz = cfg and cfg.posData[6] or 0
		local scale = cfg and cfg.posData[7] or 1

		self._inputPX:SetText(px)
		self._inputPY:SetText(py)
		self._inputPZ:SetText(pz)
		self._inputRX:SetText(rx)
		self._inputRY:SetText(ry)
		self._inputRZ:SetText(rz)
		self._inputScale:SetText(scale)
		self._inputOutPut:SetText(string.format("%s,%s,%s,%s,%s,%s,%s", px, py, pz, rx, ry, rz, scale))

		local centerX, centerY, centerZ, sizeX, sizeY, sizeZ = MainPerformConfig.instance:getLandLadyColliderData(modelId)

		if unitHero and unitHero.collider then
			unitHero.collider:setColliderCenter(centerX, centerY, centerZ)
			unitHero.collider:setColliderSize(sizeX, sizeY, sizeZ)
		end

		self._inputColliderCenterX:SetText(centerX)
		self._inputColliderCenterY:SetText(centerY)
		self._inputColliderCenterZ:SetText(centerZ)
		self._inputColliderSizeX:SetText(sizeX)
		self._inputColliderSizeY:SetText(sizeY)
		self._inputColliderSizeZ:SetText(sizeZ)
	end

	self:setDispatchEvent(true)
end

function M:canShow()
	return self:getPoint() >= 0
end

function M:IsDataDirty()
	if SceneFace.instance:isCurScene(SceneType.Room) then
		local point = self:getPoint()
		local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)

		if unitHero then
			local heroId = unitHero:getHeroId()
			local modelId = unitHero:getModelId()
			local cfg

			if point == MainPerformEnum.ElementPointAdjutant then
				cfg = MainPerformConfig.instance:getLandLadyRConfig(modelId)
			else
				cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformHeroR, modelId)
			end

			if cfg then
				local posInfo = cfg.posData
				local px, py, pz, rx, ry, rz, scale = posInfo[1], posInfo[2], posInfo[3], posInfo[4], posInfo[5], posInfo[6], posInfo[7]
				local strInCfg = string.format("%s,%s,%s,%s,%s,%s,%s", px, py, pz, rx, ry, rz, scale)
				local strInOutPut = self._inputOutPut:GetText()

				printWarn(string.format("配表[%s] ouput[%s]", strInCfg, strInOutPut))

				return strInOutPut ~= strInCfg
			end

			return false
		end

		return false
	end

	return false
end

function M:_updateHeroPosInfo()
	self:setDispatchEvent(false)

	if SceneFace.instance:isCurScene(SceneType.Room) then
		local point = self:getPoint()
		local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)

		if unitHero then
			local tr = unitHero.meshModel:getModelTr()

			self:setPos(TransformUtils.GetLocalPosition(tr, 0, 0, 0))
			self:setRotate(TransformUtils.GetLocalEulerAngles(tr, 0, 0, 0))

			local scale, _, _ = TransformUtils.GetLocalScale(tr, 1, 1, 1)

			self:setScale(scale)
			self:updateOutPutCfg()

			local colliderCenter = {}
			local colliderSize = {}

			if unitHero.collider then
				local collider = unitHero.collider:getCompCollider()

				colliderCenter = collider.center
				colliderSize = collider.size
			end

			self._inputColliderCenterX:SetText(colliderCenter and colliderCenter.x or 0)
			self._inputColliderCenterY:SetText(colliderCenter and colliderCenter.y or 0)
			self._inputColliderCenterZ:SetText(colliderCenter and colliderCenter.z or 0)
			self._inputColliderSizeX:SetText(colliderSize and colliderSize.x or 0)
			self._inputColliderSizeY:SetText(colliderSize and colliderSize.y or 0)
			self._inputColliderSizeZ:SetText(colliderSize and colliderSize.z or 0)
		else
			self._inputPX:SetText(nil)
			self._inputPY:SetText(nil)
			self._inputPZ:SetText(nil)
			self._inputRX:SetText(nil)
			self._inputRY:SetText(nil)
			self._inputRZ:SetText(nil)
			self._inputScale:SetText(nil)
			self._inputOutPut:SetText(nil)
			self._inputColliderCenterX:SetText(nil)
			self._inputColliderCenterY:SetText(nil)
			self._inputColliderCenterZ:SetText(nil)
			self._inputColliderSizeX:SetText(nil)
			self._inputColliderSizeY:SetText(nil)
			self._inputColliderSizeZ:SetText(nil)
		end
	end

	self:setDispatchEvent(true)
end

function M:startTimerUpdatePosInfo(active)
	self._timerUpdatePosInfo = active

	if active then
		settimer(0.1, self._updateHeroPosInfo, self, true)
	else
		removetimer(self._updateHeroPosInfo, self)
	end
end

function M:setDispatchEvent(active)
	self._dispatchEvent = active
end

function M:getIsDispatchEvent()
	return self._dispatchEvent
end

function M:setPos(x, y, z, updateCfgOutPut)
	self._inputPX:SetText(self:_formatVal(x))
	self._inputPY:SetText(self:_formatVal(y))
	self._inputPZ:SetText(self:_formatVal(z))

	if updateCfgOutPut then
		self:updateOutPutCfg()
	end
end

function M:setRotate(x, y, z, updateCfgOutPut)
	self._inputRX:SetText(self:_formatVal(x, true))
	self._inputRY:SetText(self:_formatVal(y, true))
	self._inputRZ:SetText(self:_formatVal(z, true))

	if updateCfgOutPut then
		self:updateOutPutCfg()
	end
end

function M:setScale(x, updateCfgOutPut)
	self._inputScale:SetText(self:_formatVal(x))

	if updateCfgOutPut then
		self:updateOutPutCfg()
	end
end

function M:updateOutPutCfg()
	local px = self:_getInputNum(self._inputPX, true)
	local py = self:_getInputNum(self._inputPY, true)
	local pz = self:_getInputNum(self._inputPZ, true)
	local rx = self:_getInputNum(self._inputRX, true, true)
	local ry = self:_getInputNum(self._inputRY, true, true)
	local rz = self:_getInputNum(self._inputRZ, true, true)
	local scale = self:_getInputNum(self._inputScale, true)

	self._inputOutPut:SetText(string.format("%s,%s,%s,%s,%s,%s,%s", px, py, pz, rx, ry, rz, scale))
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

function M:_getInputNum(input, format, isRotate)
	local num = 0

	if input then
		local str = input:GetText()

		if not string.nilorempty(str) then
			num = tonumber(str)
		end
	end

	if format then
		num = self:_formatVal(num, isRotate)
	end

	return num
end

function M:_onToggleChange(_, isOn)
	local sceneType = SceneMgr.instance:getCurSceneType()

	if sceneType ~= SceneType.Room then
		printWarn("非主场景，不响应操作")

		if isOn then
			self._toggleChange.IsOn = false

			self:_afterToggleChange(false)
		end

		return
	end

	if not Astral.OSDef.isEditor then
		if isOn then
			self._toggleChange.IsOn = false

			self:_afterToggleChange(false)
		end

		FloatWordMgr.instance:show("非Editor，不支持该操作")

		return
	end

	local point = self:getPoint()
	local scene = SceneMgr.instance:getCurScene()
	local camComp = scene.camera
	local camOffset = camComp:getCamOffset()
	local runtimeGizmo = camComp:getRuntimeTransGizmo()

	if isOn then
		local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)

		self._targetCache = unitHero and unitHero.meshModel:getModelTr() or nil

		if self._targetCache then
			runtimeGizmo:AddTarget(self._targetCache)

			if self._toggleChangeType.IsOn then
				runtimeGizmo:SetTransformTypeRotate()
			else
				runtimeGizmo:SetTransformTypeMove()
			end

			self:_afterToggleChange(true)
		else
			self._toggleChange.IsOn = false

			self:_afterToggleChange(false)
		end
	else
		if self._targetCache then
			runtimeGizmo:RemoveTarget(self._targetCache)
		else
			runtimeGizmo:ClearTargets()
		end

		self._targetCache = nil

		self:_afterToggleChange(false)
	end

	if camOffset then
		camOffset.enabled = not isOn
	end
end

function M:_afterToggleChange(isOn)
	self:startTimerUpdatePosInfo(isOn)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_EDITOR_EVENT, MainPerformEnum.EditEventTyp.HeroPos, isOn)
end

function M:_onToggleChangeType(_, isOn)
	local sceneType = SceneMgr.instance:getCurSceneType()

	if sceneType ~= SceneType.Room then
		printWarn("非主场景，不响应操作")

		return
	end

	if not Astral.OSDef.isEditor then
		FloatWordMgr.instance:show("非Editor，不支持该操作")

		return
	end

	if self._targetCache then
		local point = self:getPoint()
		local scene = SceneMgr.instance:getCurScene()
		local camComp = scene.camera
		local runtimeGizmo = camComp:getRuntimeTransGizmo()

		if isOn then
			runtimeGizmo:SetTransformTypeRotate()
		else
			runtimeGizmo:SetTransformTypeMove()
		end
	end
end

function M:_onClickGet()
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		printWarn("非主场景，不响应操作")

		return
	end

	self:_updateHeroPosInfo()
end

function M:_onClickSave()
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		printWarn("非主场景，不响应操作")

		return
	end

	self._toggleChange.IsOn = false

	self:_afterToggleChange(false)

	local point = self:getPoint()
	local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)

	if unitHero then
		local heroId = unitHero:getHeroId()
		local modelId = unitHero:getModelId()
		local _posData = {}
		local posInfoStr = self._inputOutPut:GetText()
		local arrSingleStep = string.split(posInfoStr, ",")

		for index, value in ipairs(arrSingleStep) do
			table.insert(_posData, tonumber(value))
		end

		if point == MainPerformEnum.ElementPointAdjutant then
			MainScenePerformUtil.changeOrCreateLuaCfg(ConfigName.MainPerformLandladyR, MainPerformConfig.instance, modelId, {
				posData = _posData
			})
			settimer(0, function()
				MainScenePerformUtil.changeOrCreateLuaCfg(ConfigName.MainPerformLandladyR, MainPerformConfig.instance, modelId, {
					collider = self:_getColliderInputData()
				})
			end, self, false)
		else
			MainScenePerformUtil.changeOrCreateLuaCfg(ConfigName.MainPerformHeroR, MainPerformConfig.instance, modelId, {
				posData = _posData
			})
		end
	end
end

function M:_onClickReset()
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		printWarn("非主场景，不响应操作")

		return
	end

	self._toggleChange.IsOn = false

	self:_afterToggleChange(false)

	local point = self:getPoint()
	local px, py, pz, rx, ry, rz, centerX, centerY, centerZ, sizeX, sizeY, sizeZ
	local scale = 1
	local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)

	if unitHero then
		local heroId = unitHero:getHeroId()
		local modelId = unitHero:getModelId()
		local cfg

		if point == MainPerformEnum.ElementPointAdjutant then
			cfg = MainPerformConfig.instance:getLandLadyRConfig(modelId)
		else
			cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformHeroR, modelId)
		end

		if cfg then
			local posInfo = cfg.posData

			px, py, pz, rx, ry, rz, scale = posInfo[1], posInfo[2], posInfo[3], posInfo[4], posInfo[5], posInfo[6], posInfo[7]

			local tr = unitHero.meshModel:getModelTr()

			Astral.TransformUtil.SetLocalPos(tr, px, py, pz)
			Astral.TransformUtil.SetLocalRotation(tr, rx, ry, rz)
			TransformUtils.SetLocalScale(tr, scale, scale, scale)
		else
			printError(string.format("p[%s]hero[%s]model[%s]无法找到配置文件", point, heroId, modelId))
		end

		centerX, centerY, centerZ, sizeX, sizeY, sizeZ = MainPerformConfig.instance:getLandLadyColliderData(modelId)

		if unitHero.collider then
			unitHero.collider:setColliderCenter(centerX, centerY, centerZ)
			unitHero.collider:setColliderSize(sizeX, sizeY, sizeZ)
		end
	end

	self:setDispatchEvent(false)
	self._inputPX:SetText(px)
	self._inputPY:SetText(py)
	self._inputPZ:SetText(pz)
	self._inputRX:SetText(rx)
	self._inputRY:SetText(ry)
	self._inputRZ:SetText(rz)
	self._inputScale:SetText(scale)
	self._inputOutPut:SetText(string.format("%s,%s,%s,%s,%s,%s,%s", px, py, pz, rx, ry, rz, scale))
	self._inputColliderCenterX:SetText(centerX)
	self._inputColliderCenterY:SetText(centerY)
	self._inputColliderCenterZ:SetText(centerZ)
	self._inputColliderSizeX:SetText(sizeX)
	self._inputColliderSizeY:SetText(sizeY)
	self._inputColliderSizeZ:SetText(sizeZ)
	self:setDispatchEvent(true)
end

function M:_onInputEndPos(str)
	self:_dispatchPosChange()
	self:updateOutPutCfg()
end

function M:_onInputEndRotate(str)
	self:_dispatchRotateChange()
	self:updateOutPutCfg()
end

function M:_onInputEndScale(str)
	self:_dispatchScaleChange()
	self:updateOutPutCfg()
end

function M:_onInputEndCollider(str)
	if not self:getIsDispatchEvent() then
		return
	end

	if self._timerUpdatePosInfo then
		printWarn("处于编辑中，不响应直接修改设置")

		return
	end

	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return
	end

	local point = self:getPoint()
	local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)

	if unitHero and unitHero.collider then
		local centerX = self:_getInputNum(self._inputColliderCenterX, true)
		local centerY = self:_getInputNum(self._inputColliderCenterY, true)
		local centerZ = self:_getInputNum(self._inputColliderCenterZ, true)
		local sizeX = self:_getInputNum(self._inputColliderSizeX, true)
		local sizeY = self:_getInputNum(self._inputColliderSizeY, true)
		local sizeZ = self:_getInputNum(self._inputColliderSizeZ, true)

		unitHero.collider:setColliderCenter(centerX, centerY, centerZ)
		unitHero.collider:setColliderSize(sizeX, sizeY, sizeZ)
	end
end

function M:_getColliderInputData()
	local _colliderData = {
		tonumber(self:_getInputNum(self._inputColliderCenterX, true)),
		tonumber(self:_getInputNum(self._inputColliderCenterY, true)),
		tonumber(self:_getInputNum(self._inputColliderCenterZ, true)),
		tonumber(self:_getInputNum(self._inputColliderSizeX, true)),
		tonumber(self:_getInputNum(self._inputColliderSizeY, true)),
		tonumber(self:_getInputNum(self._inputColliderSizeZ, true))
	}

	return _colliderData
end

function M:_dispatchScaleChange()
	if not self:getIsDispatchEvent() then
		return
	end

	if self._timerUpdatePosInfo then
		printWarn("处于编辑中，不响应直接修改设置")

		return
	end

	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return
	end

	local scale = self:_getInputNum(self._inputScale, true)
	local point = self:getPoint()
	local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)

	if unitHero then
		local tr = unitHero.meshModel:getModelTr()

		TransformUtils.SetLocalScale(tr, scale, scale, scale)
	end
end

function M:_dispatchRotateChange()
	if not self:getIsDispatchEvent() then
		return
	end

	if self._timerUpdatePosInfo then
		printWarn("处于编辑中，不响应直接修改设置")

		return
	end

	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return
	end

	local point = self:getPoint()
	local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)

	if unitHero then
		local x = self:_getInputNum(self._inputRX, true, true)
		local y = self:_getInputNum(self._inputRY, true, true)
		local z = self:_getInputNum(self._inputRZ, true, true)
		local tr = unitHero.meshModel:getModelTr()

		TransformUtils.SetLocalEulerAngles(tr, x, y, z)
	end
end

function M:_dispatchPosChange()
	if not self:getIsDispatchEvent() then
		return
	end

	if self._timerUpdatePosInfo then
		printWarn("处于编辑中，不响应直接修改设置")

		return
	end

	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return
	end

	local point = self:getPoint()
	local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)

	if unitHero then
		local x = self:_getInputNum(self._inputPX, true)
		local y = self:_getInputNum(self._inputPY, true)
		local z = self:_getInputNum(self._inputPZ, true)
		local tr = unitHero.meshModel:getModelTr()

		TransformUtils.SetLocalPosition(tr, x, y, z)
	end
end

return M
