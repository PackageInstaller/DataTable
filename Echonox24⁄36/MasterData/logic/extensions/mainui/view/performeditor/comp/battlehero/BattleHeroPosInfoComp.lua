-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/battlehero/BattleHeroPosInfoComp.lua

module("logic.extensions.mainui.view.performeditor.comp.battlehero.BattleHeroPosInfoComp", package.seeall)

local M = class("BattleHeroPosInfoComp")

function M:ctor(mainGo)
	self.mainGO = mainGo

	self:buildUI()
	self:bindEvents()
end

function M:buildUI()
	local mainGO = self.mainGO

	self._goContent = goutil.findChild(mainGO, "content").gameObject

	goutil.setActive(self._goContent, true)

	self._inputModelId = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "titlePanel/input_modelId"))
	self._btnSwitch = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "titlePanel/btnSwitch"))
	self._inputPX = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/position/input_x"))
	self._inputPY = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/position/input_y"))
	self._inputPZ = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/position/input_z"))
	self._inputRX = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/rotation/input_x"))
	self._inputRY = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/rotation/input_y"))
	self._inputRZ = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/rotation/input_z"))
	self._inputScale = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/scale/input_x"))
	self._inputScaleZ = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/scale/input_z"))
	self._inputAction1 = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/animation1/action"))
	self._btnPlayAction1 = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "content/animation1/btnPlay"))
	self._inputOutPut = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "content/output/input_output"))
	self._btnGet = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "content/btnGet").gameObject)
	self._btnSave = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "content/btnSave").gameObject)
	self._btnReset = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "content/btnReset").gameObject)
end

function M:destroyUI()
	self._goContent = nil
	self._inputPX = nil
	self._inputPY = nil
	self._inputPZ = nil
	self._inputRX = nil
	self._inputRY = nil
	self._inputRZ = nil
	self._inputScale = nil
	self._inputScaleZ = nil
	self._inputOutPut = nil
end

function M:bindEvents()
	self._inputPX:AddOnEndEdit(self._onInputEndPos, self)
	self._inputPY:AddOnEndEdit(self._onInputEndPos, self)
	self._inputPZ:AddOnEndEdit(self._onInputEndPos, self)
	self._inputRX:AddOnEndEdit(self._onInputEndRotate, self)
	self._inputRY:AddOnEndEdit(self._onInputEndRotate, self)
	self._inputRZ:AddOnEndEdit(self._onInputEndRotate, self)
	self._inputScale:AddOnEndEdit(self._onInputEndScale, self)
	self._inputScaleZ:AddOnEndEdit(self._onInputEndScaleZ, self)
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnSwitch:AddClickListener(self._onClickSwitch, self)
	self._btnPlayAction1:AddClickListener(self._onClickPlayAction1, self)
	self._inputAction1:AddOnEndEdit(self._onInputEndAction, self)
end

function M:unbindEvents()
	self._inputPX:RemoveOnEndEdit()
	self._inputPY:RemoveOnEndEdit()
	self._inputPZ:RemoveOnEndEdit()
	self._inputRX:RemoveOnEndEdit()
	self._inputRY:RemoveOnEndEdit()
	self._inputRZ:RemoveOnEndEdit()
	self._inputScale:RemoveOnEndEdit()
	self._inputScaleZ:RemoveOnEndEdit()
	self._btnGet:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnSwitch:RemoveClickListener()
	self._btnPlayAction1:RemoveClickListener()
	self._inputAction1:RemoveOnEndEdit()
end

function M:onEnter()
	self._pointIdx = 1

	BattleDispatcher:dispatchEvent(BattleEventType.OnPosEditorUpdate, "init")
	self:setEvents(true)
	self:_onEditModelChange()
	self:_onClickReset()
end

function M:setTabIndex(idx)
	self._pointIdx = idx

	self:_onEditModelChange(self._modelId)
	BattleDispatcher:dispatchEvent(BattleEventType.OnPosEditorUpdate, "posIdx", idx == 2)
end

function M:onExit()
	self:setEvents(false)
end

function M:destroy()
	return
end

function M:setEvents(add)
	if add then
		-- block empty
	end
end

function M:initView()
	return
end

function M:_onEditModelChange(modelId)
	self._modelId = modelId

	self:setDispatchEvent(false)

	if modelId then
		self._inputModelId:SetText(modelId)

		local id = modelId * 100 + self._pointIdx
		local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.BattlePerformanceHeroPos, id, true)

		if self._pointIdx ~= 1 then
			cfg = cfg or MainPerformConfig.instance:getConfigByKey(ConfigName.BattlePerformanceHeroPos, modelId * 100 + 1, true)
		end

		local px = -0.425
		local py = -1.33
		local pz = 0
		local rx = 0
		local ry = 135
		local rz = 0
		local scale = 1
		local scaleZ = 1
		local action = "idle2"

		if cfg then
			local posData = cfg.posData

			px = posData[1]
			py = posData[2]
			pz = posData[3]
			rx = posData[4]
			ry = posData[5]
			rz = posData[6]
			scale = posData[7]
			scaleZ = posData[8]
			action = cfg.animation
		end

		self._inputPX:SetText(px)
		self._inputPY:SetText(py)
		self._inputPZ:SetText(pz)
		self._inputRX:SetText(rx)
		self._inputRY:SetText(ry)
		self._inputRZ:SetText(rz)
		self._inputScale:SetText(scale)
		self._inputScaleZ:SetText(scaleZ)
		self._inputAction1:SetText(action)
		self._inputOutPut:SetText(string.format("%s,%s,%s,%s,%s,%s,%s,%s", px, py, pz, rx, ry, rz, scale, scaleZ))

		if not cfg then
			self:_updateHeroPosInfo()
		end
	else
		self._inputModelId:SetText(0)
		self._inputPX:SetText(0)
		self._inputPY:SetText(0)
		self._inputPZ:SetText(0)
		self._inputRX:SetText(0)
		self._inputRY:SetText(0)
		self._inputRZ:SetText(0)
		self._inputScale:SetText(1)
		self._inputScaleZ:SetText(1)
		self._inputAction1:SetText("idle2")
		self._inputOutPut:SetText(string.format("%s,%s,%s,%s,%s,%s,%s,%s", 0, 0, 0, 0, 0, 0, 1, 1))
	end

	self:setDispatchEvent(true)
end

function M:_updateHeroPosInfo()
	self:setDispatchEvent(false)

	local tr = self:_getModelContainer()

	if tr then
		if tr then
			self:setPos(TransformUtils.GetLocalPosition(tr, 0, 0, 0))
			self:setRotate(TransformUtils.GetLocalEulerAngles(tr, 0, 0, 0))

			local scale, _, scaleZ = TransformUtils.GetLocalScale(tr, 1, 1, 1)

			self:setScale(scale, scaleZ)
			self:updateOutPutCfg()
		else
			self._inputPX:SetText(nil)
			self._inputPY:SetText(nil)
			self._inputPZ:SetText(nil)
			self._inputRX:SetText(nil)
			self._inputRY:SetText(nil)
			self._inputRZ:SetText(nil)
			self._inputScale:SetText(nil)
			self._inputScaleZ:SetText(nil)
			self._inputOutPut:SetText(nil)
		end
	end

	self:setDispatchEvent(true)
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

function M:setScale(x, z)
	self._inputScale:SetText(self:_formatVal(x))
	self._inputScaleZ:SetText(self:_formatVal(z))
end

function M:updateOutPutCfg()
	local px = self:_getInputNum(self._inputPX, true)
	local py = self:_getInputNum(self._inputPY, true)
	local pz = self:_getInputNum(self._inputPZ, true)
	local rx = self:_getInputNum(self._inputRX, true, true)
	local ry = self:_getInputNum(self._inputRY, true, true)
	local rz = self:_getInputNum(self._inputRZ, true, true)
	local scale = self:_getInputNum(self._inputScale, true)
	local scaleZ = self:_getInputNum(self._inputScaleZ, true)
	local action1 = self._inputAction1:GetText()

	self._inputOutPut:SetText(string.format("%s,%s,%s,%s,%s,%s,%s,%s", px, py, pz, rx, ry, rz, scale, scaleZ))
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

function M:_onClickGet()
	if not self:_getModelContainer() then
		printWarn("非战斗场景，不响应操作")

		return
	end

	self:_updateHeroPosInfo()
end

function M:_onClickSave()
	if not self:_getModelContainer() then
		printWarn("非战斗场景，不响应操作")

		return
	end

	local modelId = self:_getModelId()

	if modelId then
		local _posData = {}
		local posInfoStr = self._inputOutPut:GetText()
		local arrSingleStep = string.split(posInfoStr, ",")

		for index, value in ipairs(arrSingleStep) do
			table.insert(_posData, tonumber(value))
		end

		local _animation = self._inputAction1:GetText()
		local id = modelId * 100 + self._pointIdx

		MainScenePerformUtil.changeOrCreateLuaCfg(ConfigName.BattlePerformanceHeroPos, MainPerformConfig.instance, id, {
			posData = _posData,
			animation = _animation
		})
	end
end

function M:_onClickPlayAction1()
	local anim = self._inputAction1:GetText()

	BattleDispatcher:dispatchEvent(BattleEventType.OnPosEditorUpdate, "anim", anim)
end

function M:_onClickSwitch()
	if not BattleMgr.instance:isInBattle() then
		FloatWordMgr.instance:show("非战斗场景，不响应操作")
		printError("非战斗场景，不响应操作")

		return
	end

	local input = self._inputModelId:GetText()
	local modelId = tonumber(input)

	if modelId then
		local modelCO = ModelConfig.instance:getModelConfig(modelId)

		if not modelCO then
			FloatWordMgr.instance:show("该模型不存在")

			return
		end

		BattleDispatcher:dispatchEvent(BattleEventType.OnPosEditorUpdate, "switch", modelId)
		self:_onEditModelChange(modelId)
	else
		printError("modelId不存在", modelId)
	end
end

function M:_onClickReset()
	if not self:_getModelContainer() then
		printWarn("非战斗场景，不响应操作")

		return
	end

	local px, py, pz, rx, ry, rz, action1 = nil, nil, nil, nil, nil, nil, "idle2"
	local scale = 1
	local scaleZ = 1
	local input = self._inputModelId:GetText()
	local modelId = tonumber(input)

	if modelId then
		local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.BattlePerformanceHeroPos, modelId)

		if cfg then
			local posInfo = cfg.posData

			px, py, pz, rx, ry, rz, scale, scaleZ = posInfo[1], posInfo[2], posInfo[3], posInfo[4], posInfo[5], posInfo[6], posInfo[7], posInfo[8]
			action1 = cfg.animation

			local tr = self:_getModelContainer()

			Astral.TransformUtil.SetLocalPos(tr, px, py, pz)
			Astral.TransformUtil.SetLocalRotation(tr, rx, ry, rz)
			TransformUtils.SetLocalScale(tr, scale, scale, scaleZ)
		else
			printError(string.format("p[%s]hero[%s]无法找到配置文件", point, modelId))
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
	self._inputScaleZ:SetText(scaleZ)
	self._inputAction1:SetText(action1)
	self._inputOutPut:SetText(string.format("%s,%s,%s,%s,%s,%s,%s,%s", px, py, pz, rx, ry, rz, scale, scaleZ))
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

function M:_onInputEndScaleZ(str)
	self:_dispatchScaleChange()
	self:updateOutPutCfg()
end

function M:_onInputEndAction(str)
	self:updateOutPutCfg()
end

function M:_dispatchScaleChange()
	if not self:getIsDispatchEvent() then
		return
	end

	if self._timerUpdatePosInfo then
		printWarn("处于编辑中，不响应直接修改设置")

		return
	end

	if not self:_getModelContainer() then
		return
	end

	local scale = self:_getInputNum(self._inputScale, true)
	local scaleZ = self:_getInputNum(self._inputScaleZ, true)

	TransformUtils.SetLocalScale(self:_getModelContainer(), scale, scale, scaleZ)
end

function M:_dispatchRotateChange()
	if not self:getIsDispatchEvent() then
		return
	end

	if self._timerUpdatePosInfo then
		printWarn("处于编辑中，不响应直接修改设置")

		return
	end

	if not self:_getModelContainer() then
		return
	end

	if self:_getModelContainer() then
		local x = self:_getInputNum(self._inputRX, true, true)
		local y = self:_getInputNum(self._inputRY, true, true)
		local z = self:_getInputNum(self._inputRZ, true, true)

		TransformUtils.SetLocalEulerAngles(self:_getModelContainer(), x, y, z)
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

	if not self:_getModelContainer() then
		return
	end

	if self:_getModelContainer() then
		local x = self:_getInputNum(self._inputPX, true)
		local y = self:_getInputNum(self._inputPY, true)
		local z = self:_getInputNum(self._inputPZ, true)

		TransformUtils.SetLocalPosition(self:_getModelContainer(), x, y, z)
	end
end

function M:_getModelContainer()
	local roleView = BattleMainViewFacade.instance:getRoleView()

	if roleView then
		return roleView:getModelContainer()
	end

	return false
end

function M:_getModelId()
	local roleView = BattleMainViewFacade.instance:getRoleView()

	if roleView then
		return roleView._modelCode
	end

	return false
end

return M
