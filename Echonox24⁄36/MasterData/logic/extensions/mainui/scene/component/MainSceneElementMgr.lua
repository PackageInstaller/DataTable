-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/component/MainSceneElementMgr.lua

module("logic.extensions.mainui.scene.component.MainSceneElementMgr", package.seeall)

local M = class("MainSceneElementMgr", ISceneFlowComp)

function M:ctor(flow)
	M.super.ctor(self, flow)
end

function M:onInit(sceneInfo)
	M.super.onInit(self, sceneInfo)

	self._posDataMap = {}
	self._pointPosDataMap = {}
	self._elementCls = {
		[15000] = {
			class = UnitCompMainSceneElementAdjutantSeat
		},
		[20001] = {
			class = UnitCompMainSceneElementAdjutantSeat
		},
		[20002] = {
			class = UnitCompMainSceneElementAdjutantSeat
		},
		[20003] = {
			class = UnitCompMainSceneElementAdjutantSeat
		},
		[20004] = {
			class = UnitCompMainSceneElementAdjutantSeat
		},
		[20005] = {
			class = UnitCompMainSceneElementAdjutantSeat
		},
		[30001] = {
			class = UnitCompMainSceneElementAirtightClock
		},
		[30002] = {
			class = UnitCompMainSceneElementTV
		}
	}
end

function M:onEnter()
	return
end

function M:onSceneLoadDone()
	self:_dealSPElement()
end

function M:onEnterDone()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)

	self._spElement = {}
	self._posDataMap = {}
	self._pointPosDataMap = {}
end

function M:onExitDone()
	return
end

function M:onLeaveScene(needUnloadRes)
	self:_setEvent(false)

	for _, behavior in pairs(self._spElement or {}) do
		if behavior.onLeaveScene then
			behavior:onLeaveScene(needUnloadRes)
		end
	end

	if not needUnloadRes then
		return
	end

	self._posDataMap = {}
	self._pointPosDataMap = {}
end

function M:onReturnScene(needUnloadRes)
	for _, behavior in pairs(self._spElement or {}) do
		if behavior.onReturnScene then
			behavior:onReturnScene(needUnloadRes)
		end
	end
end

function M:onReturnSceneFinished(needUnloadRes)
	for _, behavior in pairs(self._spElement or {}) do
		if behavior.onReturnSceneFinished then
			behavior:onReturnSceneFinished(needUnloadRes)
		end
	end

	self:_setEvent(true)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_SET_ELEMENT_SHOW, self._handleSetElementShow, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_SET_ELEMENT_ALPHA, self._handleSetElementTransparency, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_SET_ELEMENT_SHOW_HIDE_OTHER, self._handleSetElementShowHideOther, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_SET_ELEMENT_SHOW, self._handleSetElementShow, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_SET_ELEMENT_ALPHA, self._handleSetElementTransparency, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_SET_ELEMENT_SHOW_HIDE_OTHER, self._handleSetElementShowHideOther, self)
	end
end

function M:_handleSetElementShow(e, info)
	local elementId = info.elementId
	local show = info.show
	local transparency = info.transparency

	self:setElementShow(elementId, show, transparency)
end

function M:_handleSetElementTransparency(e, info)
	local elementId = info.elementId
	local transparency = info.transparency
	local duration = info.duration

	self:setElementTransparency(elementId, transparency, duration)
end

function M:_handleSetElementShowHideOther(e, info)
	local elementId = info.elementId
	local point = info.point
	local transparency = info.transparency

	self:showElementHideOtherSamePointElement(elementId, point, transparency)
end

function M:_dealSPElement()
	if not self._spElement then
		self._spElement = {}
	end

	local cfgLst = MainPerformConfig.instance:getElementLstByPointId(MainPerformEnum.ElementPointSP)

	for _, _cfg in ipairs(cfgLst or {}) do
		local elementId = _cfg.id
		local info = self._elementCls[elementId]

		if info then
			local data = self:getElementPosData(elementId)

			if data and data.go then
				local behavior = Astral.SimpleLuaComponentContainer.Add(data.go, info.class)

				behavior:setElementId(elementId)

				self._spElement[elementId] = behavior
			elseif enableLog then
				printWarn(string.format("无法定位[%s]元素", elementId))
			end
		elseif enableLog then
			printWarn(string.format("无配置[%s]元素对应的脚本", elementId))
		end
	end
end

function M:getInteractPointPosData(pointId)
	if not pointId then
		return nil
	end

	if self._pointPosDataMap[pointId] then
		return self._pointPosDataMap[pointId]
	end

	local cfgMap = MainPerformConfig.instance:getInteractPointMap()

	for _point, cfgLst in pairs(cfgMap or {}) do
		local scene = SceneMgr.instance:getScene(SceneType.Room)
		local go = scene.stage:getInteractPointGo(_point)

		if go then
			local posData = {
				go = go,
				pos = {},
				rotate = {},
				scale = {}
			}

			posData.pos.x, posData.pos.y, posData.pos.z = Astral.TransformUtil.GetPos(go.transform, 0, 0, 0)
			posData.rotate.x, posData.rotate.y, posData.rotate.z = Astral.TransformUtil.GetLocalRotation(go.transform, 0, 0, 0)
			posData.scale.x, posData.scale.y, posData.scale.z = Astral.TransformUtil.GetLocalScale(go.transform, 0, 0, 0)
			self._pointPosDataMap[_point] = posData
		end
	end

	return self._pointPosDataMap[pointId]
end

function M:getElementPosData(elementId)
	if not elementId then
		return nil
	end

	if self._posDataMap[elementId] and self._posDataMap[elementId].go and not goutil.isNil(self._posDataMap[elementId].go) then
		return self._posDataMap[elementId]
	end

	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainInteractElement, elementId)

	if cfg and not string.nilorempty(cfg.path) then
		local scene = SceneMgr.instance:getScene(SceneType.Room)
		local go = scene.stage:getMainSceneGo(cfg.path, 4)

		if go then
			local posData = {
				go = go,
				pos = {},
				rotate = {},
				scale = {},
				meshRendererLst = {},
				meshRendererLstAirtight = {}
			}

			posData.pos.x, posData.pos.y, posData.pos.z = Astral.TransformUtil.GetPos(go.transform, 0, 0, 0)
			posData.rotate.x, posData.rotate.y, posData.rotate.z = Astral.TransformUtil.GetLocalRotation(go.transform, 0, 0, 0)
			posData.scale.x, posData.scale.y, posData.scale.z = Astral.TransformUtil.GetLocalScale(go.transform, 0, 0, 0)

			for i = 0, go.transform.childCount - 1 do
				local childGo = go.transform:GetChild(i).gameObject
				local isAirtight = string.match(childGo.name, "_red")
				local meshRLst = childGo.transform:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)
				local len = meshRLst.Length

				if len > 0 then
					for j = 0, len - 1 do
						if isAirtight then
							table.insert(posData.meshRendererLstAirtight, meshRLst[j])
						else
							table.insert(posData.meshRendererLst, meshRLst[j])
						end
					end
				end
			end

			self._posDataMap[elementId] = posData
		elseif enableLog then
			printWarn(string.format("无法找到元素[%s] path[%s]", elementId, cfg.path))
		end
	end

	return self._posDataMap[elementId]
end

function M:setElementShow(elementId, show, transparency)
	if elementId <= 0 then
		return
	end

	local data = self:getElementPosData(elementId)

	if data and data.go then
		goutil.setActive(data.go, show)

		if show then
			local info = self._elementCls[elementId]

			if info then
				local behavior = Astral.SimpleLuaComponentContainer.Add(data.go, info.class)

				behavior:setElementId(elementId)
			end

			transparency = transparency or 1

			self:setElementTransparency(elementId, transparency)
		end
	elseif enableLog then
		printWarn(string.format("无法定位[%s]元素，不能设置为[%s]", elementId, show))
	end
end

function M:getCurShowElementId(point)
	local elementId

	if point then
		local cfgLst = MainPerformConfig.instance:getElementLstByPointId(point)

		for _, _cfg in ipairs(cfgLst or {}) do
			if not elementId then
				local data = self:getElementPosData(_cfg.id)

				if data and data.go and data.go.activeSelf then
					elementId = _cfg.id
				end
			end
		end
	end

	return elementId
end

function M:getElementIsShowNow(elementId)
	local isShow = false
	local data = self:getElementPosData(elementId)

	if data and data.go and not goutil.isNil(data.go) then
		isShow = data.go.activeSelf
	end

	return isShow
end

function M:refreshElement(adjutantElementId, pointPerformData)
	if adjutantElementId then
		self:showElementHideOtherSamePointElement(adjutantElementId, MainPerformEnum.ElementPointAdjutant)
	else
		self:showDefaultElement(MainPerformEnum.ElementPointAdjutant)
	end

	if pointPerformData and #pointPerformData > 0 then
		for point, data in pairs(pointPerformData) do
			if point ~= MainPerformEnum.ElementPointAdjutant then
				self:showElementHideOtherSamePointElement(data.elementId, point)
			end
		end
	else
		local pointMap = MainPerformConfig.instance:getInteractPointMap()

		for point, _ in pairs(pointMap) do
			if point ~= MainPerformEnum.ElementPointAdjutant then
				self:showDefaultElement(point)
			end
		end
	end
end

function M:showDefaultElement(point)
	local elementId = MainPerformConfig.instance:getPointDefaultElementId(point)

	self:showElementHideOtherSamePointElement(elementId, point)
end

function M:showElementHideOtherSamePointElement(elementId, point, transparency)
	if not elementId then
		if enableLog then
			printWarn("未传入elementId，不执行")
		end

		return
	end

	if not point then
		local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainInteractElement, elementId)

		point = cfg and cfg.interactPoint or nil
	end

	if point then
		local cfgLst = MainPerformConfig.instance:getElementLstByPointId(point)

		for _, _cfg in ipairs(cfgLst or {}) do
			self:setElementShow(_cfg.id, false)
		end

		self:setElementShow(elementId, true, transparency)
	elseif enableLog then
		printWarn(string.format("element[%s] 无法定位point[%s],不执行", elementId, point))
	end
end

function M:hideAllElementInPoint(point)
	if not point then
		return
	end

	local cfgLst = MainPerformConfig.instance:getElementLstByPointId(point)

	for _, _cfg in ipairs(cfgLst or {}) do
		self:setElementShow(_cfg.id, false)
	end
end

function M:hideAllElement()
	self:setAllElementShow(false)
end

function M:setAllElementShow(isShow)
	local cfgLst = MainPerformConfig.instance:getConfigList(ConfigName.MainInteractElement)

	for _, cfg in ipairs(cfgLst or {}) do
		self:setElementShow(cfg.id, isShow)
	end
end

function M:setElementTransparency(elementId, transparency, duration)
	if not elementId or elementId <= 0 then
		return
	end

	if not duration or duration < 0 then
		duration = 0
	end

	local data = self:getElementPosData(elementId)

	if data then
		local inTime = AirtightRoomController.instance:getIsInAirtightTime(nil, nil, nil, false)
		local lst = inTime and data.meshRendererLstAirtight or data.meshRendererLst

		for _, _meshRenderer in ipairs(lst or {}) do
			local materialSetter = MaterialSetter.Get(_meshRenderer.gameObject)

			materialSetter:KillAll(true)
			materialSetter:SetFloat(ShaderConstants.ID_Gradient, 0.6)

			if duration > 0 then
				local fromVal = materialSetter:GetFloat(ShaderConstants.ID_Transparency)

				materialSetter:DOFloat(ShaderConstants.ID_Transparency, fromVal, transparency, duration)
			else
				materialSetter:SetFloat(ShaderConstants.ID_Transparency, transparency)
			end
		end
	end
end

return M
