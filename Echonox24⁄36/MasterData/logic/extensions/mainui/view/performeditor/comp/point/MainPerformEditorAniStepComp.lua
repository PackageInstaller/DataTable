-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/point/MainPerformEditorAniStepComp.lua

module("logic.extensions.mainui.view.performeditor.comp.point.MainPerformEditorAniStepComp", package.seeall)

local M = class("MainPerformEditorAniStepComp", MainPerformEditorCompBase)

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self:getMainGo()

	self._goPrefabItem = goutil.findChild(mainGO, "item_aniSelect").gameObject
	self._inputOutPut = UIComponentType.InputFieldAdapter(goutil.findChild(mainGO, "output/input_output").gameObject)
	self._btnSave = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnGroup/btnSave").gameObject)
	self._btnAdd = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnGroup/btnAdd").gameObject)
	self._btnReset = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnGroup/btnReset").gameObject)

	goutil.setActive(self._goPrefabItem, false)
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._inputOutPut = nil
	self._btnSave = nil
	self._btnAdd = nil
	self._btnReset = nil

	self:_clearItems()
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnSave:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function M:onEnter()
	M.super.onEnter(self)
	self:refreshView()
end

function M:onExit()
	M.super.onExit(self)
end

function M:canShow()
	return self:getPoint() >= 0
end

function M:onEditHeroChange(heroId)
	if self:getMainGo().activeSelf then
		self:refreshView()
	end
end

function M:IsDataDirty()
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return false
	end

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
			local cfgStr = cfg and cfg.anim or nil
			local outputStr = self._inputOutPut:GetText()

			if not string.nilorempty(cfgStr) or not string.nilorempty(outputStr) then
				return cfgStr ~= outputStr
			end
		end
	end

	return false
end

function M:_onClickSave()
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		printWarn("非主场景，不响应操作")

		return
	end

	local point = self:getPoint()
	local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)

	if unitHero then
		local heroId = unitHero:getHeroId()
		local modelId = unitHero:getModelId()

		self:_updateOutputCfg()

		local _anim = self._inputOutPut:GetText()

		if point == MainPerformEnum.ElementPointAdjutant then
			MainScenePerformUtil.changeOrCreateLuaCfg(ConfigName.MainPerformLandladyR, MainPerformConfig.instance, modelId, {
				anim = _anim
			})
		else
			MainScenePerformUtil.changeOrCreateLuaCfg(ConfigName.MainPerformHeroR, MainPerformConfig.instance, modelId, {
				anim = _anim
			})
		end

		unitHero.animCtrl:setAnimStepStr(_anim)
	end
end

function M:_onClickAdd()
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		printWarn("非主场景，不响应操作")

		return
	end

	local handler = self:getHandler()

	if handler then
		local point = self:getPoint()
		local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)

		if unitHero then
			local heroId = unitHero:getHeroId()

			handler:openAniSelectTips(point, heroId, nil, true, nil, function(handler, animState)
				if not string.nilorempty(animState) then
					table.insert(self._animStep, {
						maxCount = 1,
						minCount = 1,
						name = animState
					})

					local newIndex = #self._itemLst + 1

					self:_addItem(newIndex)
					self._itemLst[newIndex].updateData(newIndex, self._animStep[newIndex])
					self:_updateOutputCfg()
				else
					printWarn("取消")
				end
			end, self)
		end
	end
end

function M:_onClickReset()
	self:refreshView()
end

function M:refreshView()
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		printWarn("非主场景，不响应操作")

		return
	end

	local point = self:getPoint()
	local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)
	local animStr

	if unitHero then
		local heroId = unitHero:getHeroId()
		local modelId = unitHero:getModelId()
		local cfg

		if point == MainPerformEnum.ElementPointAdjutant then
			cfg = MainPerformConfig.instance:getLandLadyRConfig(modelId)
		else
			cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformHeroR, modelId)
		end

		animStr = cfg and cfg.anim or nil

		if not cfg then
			printError(string.format("p[%s]hero[%s]modelId[%s]无法找到配置文件", point, heroId, modelId))
		end
	end

	self._inputOutPut:SetText(animStr)

	self._animStep = {}

	if not string.nilorempty(animStr) then
		local arrStep = string.split(animStr, "#")

		for index, valueStr in ipairs(arrStep) do
			local minCount, maxCount = 1, 1
			local animState = valueStr

			if string.match(valueStr, ";") then
				local arrSingleStep = string.split(valueStr, ";")

				animState = arrSingleStep[1]

				local animCountStr = arrSingleStep[2] or ""
				local arrAnimCountStr = string.split(animCountStr, ",")

				if #arrAnimCountStr == 2 then
					minCount, maxCount = tonumber(arrAnimCountStr[1]), tonumber(arrAnimCountStr[2])
				else
					printError(string.format("[%s] 动画次数配置格式出错,长度[%s],次数原始字符[%s],总配置原始字符[%s]", animState, #animCountStr, animCountStr, animStr))
				end
			end

			table.insert(self._animStep, {
				name = animState,
				minCount = minCount,
				maxCount = maxCount
			})
		end
	end

	self:_refreshItemLst()
end

function M:_refreshItemLst()
	self:_clearItems()

	local len = #self._animStep

	if len > 0 then
		local mainGO = self:getMainGo()

		for i = 1, len do
			self:_addItem(#self._itemLst + 1)
		end
	end

	for index, value in ipairs(self._animStep or {}) do
		self._itemLst[index].updateData(index, value)
	end
end

function M:_addItem(index)
	if self._itemLst[index] then
		printError("已有index:", index)
	else
		local mainGO = self:getMainGo()
		local go = goutil.cloneAndSetParent(self._goPrefabItem, mainGO.transform)
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
	data.txtIndex = goutil.findChildTextComponent(go, "step")
	data.txtAniName = goutil.findChildTextComponent(go, "btnAni/txt")
	data.btnPlayAni = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnPlayAni").gameObject)
	data.btnAni = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnAni").gameObject)
	data.btnMinus = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnMinus"))
	data.inputMinCount = UIComponentType.InputFieldAdapter(goutil.findChild(go, "input_min"))
	data.inputMaxCount = UIComponentType.InputFieldAdapter(goutil.findChild(go, "input_max"))
	data.txtIndex.text = index

	data.btnPlayAni:AddClickListener(function()
		self:_onCellClickPlayAni(index)
	end, self)
	data.btnAni:AddClickListener(function()
		self:_onCellClickAni(index)
	end, self)
	data.btnMinus:AddClickListener(function()
		self:_onCellClickMinus(index)
	end, self)
	data.inputMinCount:AddOnEndEdit(function(handler, str)
		self:_onInputEndCellMin(index, str)
	end, self)
	data.inputMaxCount:AddOnEndEdit(function(handler, str)
		self:_onInputEndCellMax(index, str)
	end, self)

	function data.destroyUI()
		data.btnPlayAni:RemoveClickListener()
		data.btnAni:RemoveClickListener()
		data.btnMinus:RemoveClickListener()
		data.inputMinCount:RemoveOnEndEdit()
		data.inputMaxCount:RemoveOnEndEdit()
	end

	function data.updateData(_index, animStepData)
		data.index = _index
		data.txtIndex.text = _index
		data.txtAniName.text = animStepData.name

		data.inputMinCount:SetText(animStepData.minCount)
		data.inputMaxCount:SetText(animStepData.maxCount)
	end

	function data.updateAniState(animState)
		data.txtAniName.text = animState
	end

	function data.getStr()
		local minCount = self:_getInputNum(data.inputMinCount)
		local maxCount = self:_getInputNum(data.inputMaxCount)

		if minCount == 1 and maxCount == 1 then
			return data.txtAniName.text
		else
			return string.format("%s;%s,%s", data.txtAniName.text, minCount, maxCount)
		end
	end

	function data.changeMinCount(minCount)
		minCount = tonumber(minCount)
		minCount = math.floor(minCount)
		minCount = minCount < 1 and 1 or minCount

		local maxCount = self:_getInputNum(data.inputMaxCount)

		minCount = maxCount < minCount and maxCount or minCount

		data.inputMinCount:SetText(minCount)

		return minCount
	end

	function data.changeMaxCount(maxCount)
		maxCount = tonumber(maxCount)
		maxCount = math.floor(maxCount)
		maxCount = maxCount < 1 and 1 or maxCount

		local minCount = self:_getInputNum(data.inputMinCount)

		maxCount = maxCount < minCount and minCount or maxCount

		data.inputMaxCount:SetText(maxCount)

		return maxCount
	end

	return data
end

function M:_getInputNum(input)
	local num = 1

	if input then
		local str = input:GetText()

		if not string.nilorempty(str) then
			num = tonumber(str)
		end
	end

	num = math.floor(num)
	num = num < 1 and 1 or num

	return num
end

function M:_updateOutputCfg()
	local animStr = ""
	local len = self._itemLst and #self._itemLst or 0

	for index, cell in ipairs(self._itemLst or {}) do
		animStr = animStr .. cell.getStr()

		if len > 1 and index ~= len then
			animStr = animStr .. "#"
		end
	end

	self._inputOutPut:SetText(animStr)
end

function M:_onCellClickPlayAni(index)
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return
	end

	local point = self:getPoint()
	local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)

	if unitHero then
		local heroId = unitHero:getHeroId()
		local animName = self._animStep[index].name
		local isLoop = false
		local isForceRestart = true
		local mixDuration

		MainScenePerformUtil.heroAnimPlay(heroId, animName, isLoop, isForceRestart, mixDuration)
	end
end

function M:_onCellClickAni(index)
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return
	end

	local point = self:getPoint()
	local unitHero = MainScenePerformUtil.getUnitHeroByPoint(point)

	if unitHero then
		local heroId = unitHero:getHeroId()
		local handler = self:getHandler()

		if handler then
			local stateName = self._animStep[index].name

			handler:openAniSelectTips(point, heroId, stateName, true, nil, function(handler, animState)
				if not string.nilorempty(animState) then
					self._itemLst[index].updateAniState(animState)

					self._animStep[index].name = animState

					self:_updateOutputCfg()
				else
					printWarn("取消")
				end
			end, self)
		end
	end
end

function M:_onCellClickMinus(index)
	local t = {}

	for i, value in ipairs(self._animStep) do
		if i ~= index then
			table.insert(t, value)
		end
	end

	self._animStep = t

	self:_refreshItemLst()
	self:_updateOutputCfg()
end

function M:_onInputEndCellMin(index, str)
	local minCount = self._itemLst[index].changeMinCount(str)

	self._animStep[index].minCount = minCount

	self:_updateOutputCfg()
end

function M:_onInputEndCellMax(index, str)
	local maxCount = self._itemLst[index].changeMaxCount(str)

	self._animStep[index].maxCount = maxCount

	self:_updateOutputCfg()
end

return M
