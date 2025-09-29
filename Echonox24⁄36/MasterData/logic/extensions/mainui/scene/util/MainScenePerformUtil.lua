-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/util/MainScenePerformUtil.lua

module("logic.extensions.mainui.scene.util.MainScenePerformUtil", package.seeall)

local MainScenePerformUtil = {}

function MainScenePerformUtil.getDisplayAdjutantHeroId()
	local playerData = PlayerModel.instance:getMyPlayerInfo()
	local displayHeroId = playerData and playerData.displayHero or nil
	local displaySkinId = CharacterSkinUtil.getHeroUsingSkinId(displayHeroId)

	return displayHeroId, displaySkinId
end

function MainScenePerformUtil.getAdjutantHeroCamCode()
	return 0
end

function MainScenePerformUtil.getMainSceneCharacterLight()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Room then
		local sceneLight = scene.light

		return sceneLight:getCharacterLight()
	end
end

function MainScenePerformUtil.characterLightSetDirty(dirtyMark, setDirty, reset)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_LIGHT_SET_DIRTY, {
		dirtyMark = dirtyMark,
		setDirty = setDirty,
		reset = reset
	})
end

function MainScenePerformUtil.characterLightReset()
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_LIGHT_RESET)
end

function MainScenePerformUtil.getMainSceneCamGo(sceneType)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == sceneType then
		local sceneCam = scene.camera

		if sceneCam and sceneCam.getCamGo then
			return sceneCam:getCamGo()
		end
	end
end

function MainScenePerformUtil.setCamLocalPos(x, y, z)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Room then
		local sceneCam = scene.camera

		sceneCam:setLocalPos(x, y, z)
	end
end

function MainScenePerformUtil.getCamPos()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Room then
		local sceneCam = scene.camera

		return sceneCam:getBasePosSplit()
	end
end

function MainScenePerformUtil.getCamCode(viewName, subPage, heroId)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Room then
		local viewCamMgr = scene.viewCamMgr

		return viewCamMgr:getCamCode(viewName, subPage, heroId)
	end
end

function MainScenePerformUtil.tweenMainSceneCam(camCode, duration, ease, callBack, callBackHandler)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Room then
		local sceneCam = scene.camera

		sceneCam:releaseCamTween()

		duration = duration or MainPerformEnum.DefaultCamTweenDuration

		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CAM_OFFSET_CTRL, duration * 0.35)

		ease = ease or DG.Tweening.Ease.Linear

		sceneCam:tweenCam(camCode, duration, ease, true)

		if callBack then
			local delay = duration - 0.1

			delay = delay <= 0 and 0 or delay

			settimer(delay, function()
				if callBack then
					if callBackHandler then
						callBack(callBackHandler)
					else
						callBack()
					end
				end
			end, self, false)
		end
	end
end

function MainScenePerformUtil.setMainSceneCamFov(fov)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Room then
		scene.camera:setFieldOfView(fov)
	end
end

function MainScenePerformUtil.getMainSceneCamFov()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Room then
		return scene.camera:getFieldOfView()
	end
end

function MainScenePerformUtil.setCamOffsetFov(fov, duration)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.Room then
		return scene.camera:setOffsetFov(fov, duration)
	end
end

function MainScenePerformUtil.tweenMainSceneCamByAdjutant(duration, ease, callBack, callBackHandler)
	local camCode = MainScenePerformUtil.getAdjutantHeroCamCode()

	MainScenePerformUtil.tweenMainSceneCam(camCode, duration, ease, callBack, callBackHandler)
end

function MainScenePerformUtil.viewCamCtrl(viewName, subPage, open, isNormal, heroId, modelId, callBack, callBackHandler)
	local info = {
		viewName = viewName,
		subPage = subPage,
		open = open,
		isNormal = isNormal,
		heroId = heroId,
		modelId = modelId,
		callBack = callBack,
		callBackHandler = callBackHandler
	}

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_VIEW_CAM_CTRL, info)
end

function MainScenePerformUtil.setElementShow(elementId, show, transparency)
	local info = {
		elementId = elementId,
		show = show,
		transparency = transparency
	}

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_SET_ELEMENT_SHOW, info)
end

function MainScenePerformUtil.setElementTransparency(elementId, transparency, duration)
	local info = {
		elementId = elementId,
		transparency = transparency,
		duration = duration
	}

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_SET_ELEMENT_ALPHA, info)
end

function MainScenePerformUtil.showElementHideOtherSamePointElement(elementId, point, transparency)
	local info = {
		elementId = elementId,
		point = point,
		transparency = transparency
	}

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_SET_ELEMENT_SHOW_HIDE_OTHER, info)
end

function MainScenePerformUtil.getUnitHeroByPoint(point)
	local unityFactory
	local curSceneFlow = SceneFace.instance:getCurSceneFlow()

	if curSceneFlow then
		unityFactory = curSceneFlow.unitFactory
	end

	if unityFactory and unityFactory.getUnitHeroByPoint then
		local unitHero = unityFactory:getUnitHeroByPoint(point)

		return unitHero
	end

	return nil
end

function MainScenePerformUtil.changeHeroReq(pointId, heroId, skinId, forceSet, prefix, mixDuration, isChange, defaultHide, blockChangeEff)
	local info = {
		pointId = pointId,
		heroId = heroId,
		skinId = skinId,
		forceSet = forceSet,
		prefix = prefix,
		mixDuration = mixDuration,
		isChange = isChange,
		defaultHide = defaultHide,
		blockChangeEff = blockChangeEff
	}

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_CHANGE_REQ, info)
end

function MainScenePerformUtil.showTmpHero(show, heroId, skinId, defaultAnim, pos, angle, scale)
	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return
	end

	local curSceneFlow = SceneFace.instance:getCurSceneFlow()

	if show then
		local entityInfo = {
			elementId = -1,
			point = -1,
			entityCode = heroId,
			heroId = heroId,
			skinId = skinId,
			pos = pos,
			angle = angle,
			scale = scale,
			defaultAnim = defaultAnim
		}

		curSceneFlow.unitFactory:createUnit("Tmp", entityInfo)
	else
		curSceneFlow.unitFactory:removeUnitByTag("Tmp")
	end
end

function MainScenePerformUtil.removeUnitByPoint(pointId, includeElement)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_POINT_HERO_REMOVE_REQ, {
		pointId = pointId,
		includeElement = includeElement
	})
end

function MainScenePerformUtil.setBgHeroShow(show, includeElement, includeAdjutant)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_SET_BG_HERO_SHOW, show, includeElement, includeAdjutant)
end

function MainScenePerformUtil.setHeroShow(pointId, show, forcePrefix, includeElement)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_SET_POINT_HERO_SHOW, {
		pointId = pointId,
		show = show,
		forcePrefix = forcePrefix,
		includeElement = includeElement
	})
end

function MainScenePerformUtil.getAnimPrefix(animState, considerChangeState)
	local prefix

	if not string.nilorempty(animState) and string.match(animState, "_") then
		local strArr = string.split(animState, "_")

		if Astral.OSDef.isEditor and #strArr ~= 2 and not string.match(animState, "face") and not string.match(animState, MainPerformEnum.AnimFullName.ShafaTouch) then
			printWarn(string.format("[%s] 的动画命名下划线数量不匹配，注意", animState), debug.traceback())
		end

		if MainPerformEnum.AnimPrefixLayer[strArr[1]] then
			prefix = strArr[1]
		elseif MainPerformEnum.AnimPrefixLayerFallBack[strArr[1]] then
			prefix = MainPerformEnum.AnimPrefixLayerFallBack[strArr[1]]
		end

		if considerChangeState and MainPerformEnum.AnimPrefixLayer[strArr[2]] then
			prefix = strArr[2]
		end
	end

	return prefix
end

function MainScenePerformUtil.setHeroMagicalClothEnable(pointId, enabled)
	local info = {
		pointId = pointId,
		enabled = enabled
	}

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_SET_MAGICAL_CLOTH, info)
end

function MainScenePerformUtil.setHeroLookAtWeight(pointId, weight)
	local info = {
		pointId = pointId,
		weight = weight
	}

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_SET_LOOK_AT_WEIGHT, info)
end

function MainScenePerformUtil.heroAnimPlay(heroId, animName, isLoop, isForceRestart, mixDuration)
	heroId = heroId or 0
	heroId = tonumber(heroId)

	if heroId <= 0 then
		return
	end

	local info = {
		heroId = heroId,
		animName = animName,
		isLoop = isLoop,
		isForceRestart = isForceRestart,
		mixDuration = mixDuration
	}

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_ANIM_CALL_PLAY, info)
end

function MainScenePerformUtil.heroAnimSeqPlay(heroId, prefix, mixDuration)
	heroId = heroId or 0
	heroId = tonumber(heroId)

	if heroId <= 0 then
		return
	end

	local info = {
		heroId = heroId,
		prefix = prefix,
		mixDuration = mixDuration
	}

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_SEQ_ANIM_PLAY, info)
end

function MainScenePerformUtil.heroAnimStepCtrl(heroId, reset, animStepStr)
	local info = {}

	info.heroId = heroId
	info.reset = reset
	info.animStepStr = animStepStr

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_ANIM_STEP_CTRL, info)
end

function MainScenePerformUtil.getRandomBgFormula()
	local lastFormula
	local cfgName = ConfigName.MainPerformFormula
	local cfgLst = MainPerformConfig.instance:getConfigList(cfgName)
	local _tmpLst = {}
	local _weightCache = 0
	local len = cfgLst and #cfgLst or 0

	if len > 0 then
		for index, cfg in ipairs(cfgLst) do
			if cfg.weight > 0 then
				table.insert(_tmpLst, {
					w = _weightCache + cfg.weight,
					index = index
				})

				_weightCache = _weightCache + cfg.weight
			end
		end
	end

	if _weightCache > 0 then
		local rWeight = math.random(1, _weightCache)

		for _, val in ipairs(_tmpLst) do
			if rWeight <= val.w then
				return cfgLst[val.index]
			end
		end
	end

	printWarn(string.format("无法找到可用方案,总权重[%s]", _weightCache))

	return nil
end

function MainScenePerformUtil.getRandomInteractElement(pointId)
	local cfgLst = MainPerformConfig.instance:getElementLstByPointId(pointId)
	local _tmpLst = {}
	local _weightCache = 0

	for index, cfg in ipairs(cfgLst) do
		if cfg.weight > 0 then
			table.insert(_tmpLst, {
				w = _weightCache + cfg.weight,
				index = index
			})

			_weightCache = _weightCache + cfg.weight
		end
	end

	if _weightCache > 0 then
		local rWeight = math.random(1, _weightCache)

		for _, val in ipairs(_tmpLst) do
			if rWeight <= val.w then
				return cfgLst[val.index]
			end
		end
	end

	printWarn(string.format("无法找到可用方案,总权重[%s]", _weightCache))

	return nil
end

function MainScenePerformUtil.getRandomElementHeros(pointPerformData, elementLst, ignoreHero, onlyExist, includeSP)
	pointPerformData = pointPerformData or {}

	local ignoreHeroMap = {}

	if ignoreHero then
		ignoreHeroMap[ignoreHero] = 1
	end

	for index, elementId in ipairs(elementLst) do
		local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainInteractElement, elementId)

		if cfg then
			local point = cfg.interactPoint
			local heroId
			local skinId = 0
			local cfgBgElementHero = MainScenePerformUtil.getRandomElementHero(elementId, ignoreHeroMap, onlyExist, includeSP)

			if cfgBgElementHero then
				heroId = cfgBgElementHero and cfgBgElementHero.heroId or heroId
				ignoreHeroMap[heroId] = 1
			else
				printWarn(string.format("交互点[%s] 元素[%s] 无法roll 到可用配置", point, elementId))
			end

			pointPerformData[point] = {
				heroId = heroId,
				skinId = skinId,
				point = point,
				elementId = elementId
			}
		end
	end

	return pointPerformData
end

function MainScenePerformUtil.getRandomElementHero(elementId, ignoreHeroMap, onlyExist, includeSP)
	local cfgHeroMap = MainPerformConfig.instance:getPerformHeroMap(elementId)
	local _tmpLst = {}
	local _heroIdBackUp = 0
	local _weightCache = 0

	for heroId, cfg in pairs(cfgHeroMap) do
		local weight = cfg.weight

		if _heroIdBackUp == 0 and not ignoreHeroMap[heroId] and weight > 0 then
			_heroIdBackUp = heroId
		end

		if onlyExist then
			local herodata = HeroDepotModel.instance:getHeroInfoByID(heroId)

			if herodata == nil or herodata == false then
				weight = 0
			end
		end

		if includeSP then
			-- block empty
		end

		if ignoreHeroMap[heroId] then
			weight = 0
		end

		if weight > 0 then
			table.insert(_tmpLst, {
				w = _weightCache + cfg.weight,
				heroId = heroId
			})

			_weightCache = _weightCache + cfg.weight
		end
	end

	if _weightCache > 0 then
		local rWeight = math.random(1, _weightCache)

		for _, val in ipairs(_tmpLst) do
			if rWeight <= val.w then
				return cfgHeroMap[val.heroId]
			end
		end
	else
		return cfgHeroMap[_heroIdBackUp]
	end
end

function MainScenePerformUtil.deserializeAnimStep(animStr)
	local animStep = {}

	if string.nilorempty(animStr) then
		return animStep
	end

	local arrStep = string.split(animStr, "#")

	for index, valueStr in ipairs(arrStep) do
		if string.match(valueStr, ";") then
			local arrSingleStep = string.split(valueStr, ";")
			local animState = arrSingleStep[1]
			local animCountStr = arrSingleStep[2] or ""
			local arrAnimCountStr = string.split(animCountStr, ",")
			local minCount, maxCount = 1, 1

			if #arrAnimCountStr == 2 then
				minCount, maxCount = tonumber(arrAnimCountStr[1]), tonumber(arrAnimCountStr[2])
			else
				printError(string.format("[%s] 动画次数配置格式出错,长度[%s],次数原始字符[%s],总配置原始字符[%s]", animState, #animCountStr, animCountStr, animStr))
			end

			local count = math.random(minCount, maxCount)

			for i = 1, count do
				table.insert(animStep, animState)
			end
		else
			table.insert(animStep, valueStr)
		end
	end

	return animStep
end

function MainScenePerformUtil.getHeroAnimItemPath(modelId, point)
	if not modelId or modelId < 0 then
		return nil
	end

	local cfgHero

	if point == MainPerformEnum.ElementPointAdjutant then
		cfgHero = MainPerformConfig.instance:getLandLadyRConfig(modelId)
	else
		cfgHero = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformHeroR, modelId)
	end

	local path = cfgHero and cfgHero.animItem or nil

	return path
end

function MainScenePerformUtil.getHeroActivationItemPathTable(modelId, point)
	if not point or point < 0 then
		return
	end

	if not modelId or modelId < 0 then
		return nil
	end

	local cfgHero

	if point == MainPerformEnum.ElementPointAdjutant then
		cfgHero = MainPerformConfig.instance:getLandLadyRConfig(modelId)
	else
		cfgHero = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformHeroR, modelId, true)
	end

	local str = cfgHero and cfgHero.activationItem or nil
	local path

	if not string.nilorempty(str) then
		local step = string.split(str, "#")

		path = step[1]
	end

	return path
end

function MainScenePerformUtil.getHeroChangeShowTimelinePath(modelId)
	local path
	local modelData = ModelConfig.instance:getModelData(modelId)

	if modelData then
		path = modelData:getMainSceneChangeTimelinePath()

		if not Astral.LuaResourceCache.Instance:ExistsResource(path) then
			path = nil
		end
	end

	return path
end

function MainScenePerformUtil.getHeroEnterShowTimelinePath(modelId)
	local path
	local modelData = ModelConfig.instance:getModelData(modelId)

	if modelData then
		path = modelData:getLotteryEnterShowTimelinePath()

		if not Astral.LuaResourceCache.Instance:ExistsResource(path) then
			path = nil
		end
	end

	return path
end

function MainScenePerformUtil.getMainSceneResName(modelId)
	local resName
	local modelData = ModelConfig.instance:getModelData(modelId)

	if modelData then
		resName = modelData:mainSceneResName()
	end

	return resName
end

function MainScenePerformUtil.getHeroActivationItemNeedActive(model, point, animState)
	local cfgHero

	if point == MainPerformEnum.ElementPointAdjutant then
		cfgHero = MainPerformConfig.instance:getLandLadyRConfig(model)
	else
		cfgHero = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformHeroR, model)
	end

	local str = cfgHero and cfgHero.activationItem or nil
	local active = false

	if not string.nilorempty(str) then
		local step = string.split(str, "#")

		if #step >= 2 then
			for i = 2, #step do
				if not active and string.match(animState, step[i]) then
					active = true
				end
			end
		end
	end

	return active
end

function MainScenePerformUtil.getElementName(elementId)
	if not elementId then
		return "nil"
	end

	if elementId <= 0 then
		return elementId
	end

	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainInteractElement, elementId)
	local name = cfg and cfg.name or elementId
	local find = false
	local point = cfg and cfg.interactPoint or nil

	if point then
		if point == 0 then
			find = true
		else
			local cfgMap = MainPerformConfig.instance:getPerformHeroMap(elementId)

			for heroId, _cfg in pairs(cfgMap or {}) do
				if _cfg.weight > 0 then
					find = true

					break
				end
			end
		end
	end

	if not find then
		name = string.format("<color=#bf404a>%s</color>", name)
	end

	return name
end

function MainScenePerformUtil.updateDropDownLst(dropDown, lst)
	if not dropDown then
		return
	end

	dropDown:ClearOptions()

	local t = TableUtil.deepCopy(lst)

	if t[0] then
		table.insert(t, 1, t[0])

		t[0] = nil
	end

	for index, value in ipairs(t or {}) do
		local name = value .. ""
		local t = UnityEngine.UI.Dropdown.OptionData.New(name)

		dropDown.options:Add(t)
	end
end

function MainScenePerformUtil.getHeroDropLstData(point)
	local idLst = {}
	local nameLst = {}
	local modelIds = {}
	local skinIds = {}
	local skinNames = {}

	if point == MainPerformEnum.ElementPointAdjutant then
		local dataList = CharacterConfig.instance:getCharacterDataList()

		for k, data in pairs(dataList) do
			if data.modelId > 0 and data.id > 2000000 then
				local _cfgModel = ModelConfig.instance:getModelConfig(data.modelId)

				if _cfgModel and _cfgModel.mainSceneElement > 0 then
					table.insert(idLst, data.id)
					table.insert(nameLst, MainScenePerformUtil.getHeroName(data.id))
					table.insert(modelIds, data.modelId)
					table.insert(skinNames, "")
					table.insert(skinIds, 0)
				end
			end
		end
	else
		local cfgLst = MainPerformConfig.instance:getElementLstByPointId(point)

		for _, _cfg in ipairs(cfgLst or {}) do
			local map = MainPerformConfig.instance:getPerformHeroMap(_cfg.id)

			for _heroId, __ in pairs(map) do
				table.insert(idLst, _heroId)
				table.insert(nameLst, MainScenePerformUtil.getHeroName(_heroId))
				table.insert(modelIds, CharacterUtil.getModelId(_heroId, 0))
				table.insert(skinNames, "")
				table.insert(skinIds, 0)
			end
		end
	end

	local cfgSkinList = HeroSkinConfig.instance:getAllInfo()

	for k, data in pairs(cfgSkinList or {}) do
		local heroId = tonumber(data.heroId) or 0

		if heroId > 2000000 then
			local modelId = data.module
			local index = table.indexof(idLst, heroId)

			if index and not table.indexof(modelIds, modelId) then
				local heroName = MainScenePerformUtil.getHeroName(heroId)

				table.insert(idLst, index + 1, heroId)
				table.insert(nameLst, index + 1, heroName)
				table.insert(modelIds, index + 1, modelId)
				table.insert(skinNames, index + 1, string.format("<color=#50FF04>%s</color>", data.name))
				table.insert(skinIds, index + 1, data.id)
			end
		end
	end

	return idLst, nameLst, modelIds, skinIds, skinNames
end

function MainScenePerformUtil.getHeroDropName(point, heroId, modelId)
	if not modelId then
		return "nil"
	end

	if modelId <= 0 then
		return "无"
	end

	local canCreate = true

	if point == MainPerformEnum.ElementPointAdjutant then
		local _cfgModel = ModelConfig.instance:getModelConfig(modelId)
		local _elementId = _cfgModel and _cfgModel.mainSceneElement or 0

		canCreate = _elementId > 0
	end

	local heroName = MainScenePerformUtil.getHeroName(heroId)

	heroName = canCreate and heroName or string.format("<color=#bf404a>%s</color>", heroName)

	return heroName
end

function MainScenePerformUtil.getHeroName(heroId)
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(heroId)
	local heroName = heroInfoCO and heroInfoCO.name or heroId

	return heroName
end

function MainScenePerformUtil.getHeroModelAssetExist(heroId, skinId, showToast)
	heroId = tonumber(heroId)

	local heroName = MainScenePerformUtil.getHeroName(heroId)
	local modelId
	local exist = false

	if skinId and skinId > 0 then
		local skinCo = HeroSkinConfig.instance:getInfo(skinId)

		if skinCo then
			modelId = skinCo.module
		end
	else
		local entityCO = BattleConfigUtil.getEntityConfig(heroId)

		if entityCO then
			modelId = entityCO.modelId
		else
			printError(string.format("无法找到[%s]的配置", heroId))
		end
	end

	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not modelCO then
		printError(string.format("无法找到model[%s]的配置,heroId[%s],skinId[%s]", modelId, heroId, skinId))

		exist = false
	else
		local resFloderName = modelCO.mainSceneResName
		local resFloderId = modelId

		if string.match(resFloderName, "_") then
			local arrId = string.split(resFloderName, "_")

			resFloderId = tonumber(arrId[1])
		end

		if modelId ~= resFloderId and resFloderId == 100021 then
			exist = false

			printWarn(string.format("角色[%s][%s]modelId[%s]和配置目录[%s]不匹配，判断为容错资源，视为无正式资源", heroId, heroName, modelId, resFloderName))
		else
			local url = string.format("Assets/GameAssets/shared/character3d/%s/general", modelCO.mainSceneResName)

			exist = EditorHelperUtils.GetIsAssetExist(string.format("%s-main", modelCO.mainSceneResName), url)
		end
	end

	if not exist and showToast then
		FloatWordMgr.instance:show(string.format("角色[%s][%s]没有主场景模型", heroId, heroName))
	end

	return exist
end

function MainScenePerformUtil.createGyroPerformData()
	local dataTable = {}

	dataTable.angleMaxX = false
	dataTable.angleMaxY = false
	dataTable.filterX = false
	dataTable.filterY = false
	dataTable.durationGetDevice = false
	dataTable.durationTween = false

	return dataTable
end

function MainScenePerformUtil.createLuaCfg(cfgName, tableContent)
	if not tableContent.title then
		printError("table不包含title字段")

		return
	end

	if not tableContent.dataList then
		printError("table不包含title字段")

		return
	end

	local allContent = "-- AUTO GENERATED. DO NOT MODIFY !!!"

	allContent = allContent .. string.format("\nmodule(\"logic.config.%s\", package.seeall)", cfgName)

	local titleKey = {}

	for index, t in ipairs(tableContent.title) do
		if index == 1 then
			allContent = allContent .. string.format("\nlocal title = {")
		end

		allContent = allContent .. string.format("%s=%s", t, index)

		if index == #tableContent.title then
			allContent = allContent .. string.format("}\n")
		else
			allContent = allContent .. ","
		end

		titleKey[index] = t
	end

	for index, value in ipairs(tableContent.dataList) do
		if index == 1 then
			allContent = allContent .. string.format("\nlocal dataList = {")
		end

		allContent = allContent .. "\n\t{"

		for _indexTitle, _keyTitle in ipairs(titleKey) do
			allContent = allContent .. string.format("%s", value[_keyTitle])

			if _indexTitle ~= #titleKey then
				allContent = allContent .. ","
			end
		end

		allContent = allContent .. "}"

		if index == #tableContent.dataList then
			allContent = allContent .. string.format("\n}\n")
		else
			allContent = allContent .. ","
		end
	end

	allContent = allContent .. string.format("\nlocal %s = {}", cfgName)
	allContent = allContent .. string.format("\n%s.dataList = dataList", cfgName)
	allContent = allContent .. "\n\nlocal mt = {\n"
	allContent = allContent .. "\t__index = function(t,key)\n"
	allContent = allContent .. "\t\tlocal index = title[key]\n"
	allContent = allContent .. "\t\tif index then\n"
	allContent = allContent .. "\t\t\treturn rawget(t,index)\n"
	allContent = allContent .. "\t\telse\n"
	allContent = allContent .. "\t\t\terror(string.format(\"the field name[%s] is nonexist!\",key))\n"
	allContent = allContent .. "\t\tend\n"
	allContent = allContent .. "\tend\n"
	allContent = allContent .. "}\n"
	allContent = allContent .. "\nfor i,v in ipairs(dataList) do\n"
	allContent = allContent .. string.format("\t%s[v[1]] = v\n", cfgName)
	allContent = allContent .. "\tsetmetatable(v,mt)\n"
	allContent = allContent .. "end\n"
	allContent = allContent .. string.format("\nreturn %s", cfgName)

	printWarn(allContent)

	local pathSave = string.format("Assets/Scripts/Lua/logic/config/%s.lua", cfgName)

	EditorHelperUtils.SaveFile(pathSave, allContent)
	FloatWordMgr.instance:show(string.format("保存成功：%s", cfgName))
end

function MainScenePerformUtil.getVec3Str(vec3)
	if vec3 == nil then
		vec3 = Vector3.zero
	end

	return string.format("{x=%s,y=%s,z=%s}", vec3.x, vec3.y, vec3.z)
end

function MainScenePerformUtil.changeOrCreateLuaCfg(cfgName, cfgHandler, sortId, changeContent)
	TableUtil.dump(changeContent)

	if not cfgHandler then
		printError("未传入cfgHandler")

		return
	end

	local template = MainPerformEnum.Cfg2Template[cfgName]

	if not template then
		printError("无法找到对应模板：", cfgName)

		return
	end

	local dataTable = {}
	local sortKey = template.title[template.sortKey]

	dataTable.title = {}

	for index, titleStr in ipairs(template.title) do
		table.insert(dataTable.title, titleStr)
	end

	if not cfgHandler.getConfigList then
		return printError("cfgHandler中不存在API：getConfigList")
	end

	dataTable.dataList = {}

	local cfgLst = cfgHandler:getConfigList(cfgName)

	if not cfgLst then
		printError("无法找到对应配置文件：", cfgName)

		return
	end

	local function getArrayStr(t, isString)
		if t == "nil" then
			return nil
		end

		local dataStr = "{"

		for iNum, num in ipairs(t) do
			if isString then
				dataStr = string.format("%s\"%s\"", dataStr, num)
			else
				dataStr = dataStr .. num
			end

			if iNum == #t then
				dataStr = dataStr .. "}"
			else
				dataStr = dataStr .. ","
			end
		end

		return dataStr
	end

	sortId = tonumber(sortId)

	local findIndex = -1
	local insertIndex = #cfgLst + 1

	for index, _cfg in ipairs(cfgLst) do
		local cacheData = {}

		for i, titleStr in ipairs(template.title) do
			local format = template.format[i]

			if _cfg[titleStr] == nil then
				cacheData[titleStr] = _cfg[titleStr]
			elseif format == "array" then
				cacheData[titleStr] = getArrayStr(_cfg[titleStr], false)
			elseif format == "arrayStr" then
				cacheData[titleStr] = getArrayStr(_cfg[titleStr], true)
			elseif format == "string" then
				cacheData[titleStr] = string.format("\"%s\"", _cfg[titleStr])
			elseif format == "number" then
				local __val = _cfg[titleStr]

				cacheData[titleStr] = __val
			elseif format == "vector3" then
				cacheData[titleStr] = MainScenePerformUtil.getVec3Str(_cfg[titleStr])
			else
				cacheData[titleStr] = _cfg[titleStr]
			end
		end

		local cfgId = _cfg[sortKey]

		if cfgId == sortId then
			findIndex = index

			for _changeTitleStr, value in pairs(changeContent) do
				local _changeTitleIndex = table.indexof(template.title, _changeTitleStr)
				local format = template.format[_changeTitleIndex]

				if format == "array" then
					cacheData[_changeTitleStr] = getArrayStr(value, false)
				elseif format == "arrayStr" then
					cacheData[_changeTitleStr] = getArrayStr(value, true)
				elseif format == "string" then
					cacheData[_changeTitleStr] = string.format("\"%s\"", value)
				elseif format == "number" then
					cacheData[_changeTitleStr] = value and tonumber(value) or 0
				elseif format == "vector3" then
					cacheData[_changeTitleStr] = MainScenePerformUtil.getVec3Str(value)
				else
					cacheData[_changeTitleStr] = value
				end

				_cfg[_changeTitleStr] = value
			end
		elseif cfgId < sortId then
			insertIndex = index + 1
		end

		table.insert(dataTable.dataList, cacheData)
	end

	if findIndex < 0 then
		local strData = {}

		strData[sortKey] = sortId

		for _changeTitleStr, value in pairs(changeContent) do
			local _changeTitleIndex = table.indexof(template.title, _changeTitleStr)
			local format = template.format[_changeTitleIndex]

			if format == "array" then
				strData[_changeTitleStr] = getArrayStr(value, false)
			elseif format == "arrayStr" then
				strData[_changeTitleStr] = getArrayStr(value, true)
			elseif format == "string" then
				strData[_changeTitleStr] = string.format("\"%s\"", value)
			elseif format == "vector3" then
				strData[_changeTitleStr] = MainScenePerformUtil.getVec3Str(value)
			else
				strData[_changeTitleStr] = value
			end
		end

		table.insert(dataTable.dataList, insertIndex, strData)

		local cacheData = {}

		for i, titleStr in ipairs(template.title) do
			cacheData[i] = changeContent[titleStr]
		end

		cacheData[template.sortKey] = sortId

		setmetatable(cacheData, {
			__index = function(t, key)
				local index = table.indexof(MainPerformEnum.Cfg2Template[cfgName].title, key)

				if index then
					return rawget(t, index)
				else
					error(string.format("the field name[%s] is nonexist!", key))
				end
			end
		})
		table.insert(cfgHandler._dict[cfgName].dataList, insertIndex, cacheData)

		cfgHandler._dict[cfgName][sortId] = cacheData
	end

	MainScenePerformUtil.createLuaCfg(string.format("t_%s", cfgName), dataTable)
end

function MainScenePerformUtil.deleteLuaCfg(cfgName, cfgHandler, sortId)
	if not cfgHandler then
		printError("未传入cfgHandler")

		return
	end

	local template = MainPerformEnum.Cfg2Template[cfgName]

	if not template then
		printError("无法找到对应模板：", cfgName)

		return
	end

	local dataTable = {}
	local sortKey = template.title[template.sortKey]

	dataTable.title = {}

	for index, titleStr in ipairs(template.title) do
		table.insert(dataTable.title, titleStr)
	end

	dataTable.dataList = {}

	if not cfgHandler.getConfigList then
		return printError("cfgHandler中不存在API：getConfigList")
	end

	local cfgLst = cfgHandler:getConfigList(cfgName)

	if not cfgLst then
		printError("无法找到对应配置文件：", cfgName)

		return
	end

	local function getArrayStr(t, isString)
		local dataStr = "{"

		for iNum, num in ipairs(t) do
			if isString then
				dataStr = string.format("%s\"%s\"", dataStr, num)
			else
				dataStr = dataStr .. num
			end

			if iNum == #t then
				dataStr = dataStr .. "}"
			else
				dataStr = dataStr .. ","
			end
		end

		return dataStr
	end

	sortId = tonumber(sortId)

	local findIndex = -1
	local newCfgLst = {}

	for index, _cfg in ipairs(cfgLst) do
		if _cfg[sortKey] ~= sortId then
			table.insert(newCfgLst, _cfg)

			local cacheData = {}

			for i, titleStr in ipairs(template.title) do
				local format = template.format[i]

				if _cfg[titleStr] == nil then
					cacheData[titleStr] = _cfg[titleStr]
				elseif format == "array" then
					cacheData[titleStr] = getArrayStr(_cfg[titleStr], false)
				elseif format == "arrayStr" then
					cacheData[titleStr] = getArrayStr(_cfg[titleStr], true)
				elseif format == "string" then
					cacheData[titleStr] = string.format("\"%s\"", _cfg[titleStr])
				elseif format == "vector3" then
					cacheData[titleStr] = MainScenePerformUtil.getVec3Str(_cfg[titleStr])
				else
					cacheData[titleStr] = _cfg[titleStr]
				end
			end

			table.insert(dataTable.dataList, cacheData)
		else
			findIndex = index
		end
	end

	if findIndex > 0 then
		cfgHandler._dict[cfgName].dataList = newCfgLst
		cfgHandler._dict[cfgName][sortId] = nil

		MainScenePerformUtil.createLuaCfg(string.format("t_%s", cfgName), dataTable)
	end
end

function MainScenePerformUtil.printViewBackStack(titleMsgStr, strAndNoPrint)
	if enableLog then
		titleMsgStr = string.nilorempty(titleMsgStr) and "" or titleMsgStr

		local backStack = ViewMgr.instance._viewMgrImpl._backStack

		if not backStack then
			return
		end

		local backSize = backStack:getSize()
		local t = {
			titleMsgStr,
			string.format("界面返回堆栈共有[%s]个界面", backSize)
		}
		local viewInfo = false

		for i = backSize, 1, -1 do
			viewInfo = backStack:getDataByIndex(i)

			if viewInfo then
				table.insert(t, string.format("[%s]%s", i, viewInfo.viewName))
			end
		end

		if strAndNoPrint then
			return table.concat(t, "\n")
		else
			printWarn(table.concat(t, "\n"))
		end
	end
end

function MainScenePerformUtil.isCanShowHeroInHeartAnchor(heroId)
	return false
end

function MainScenePerformUtil.getPreviewCameraUnit()
	if SceneFace.instance:isCurScene(SceneType.CharacterPreview) then
		local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()

		return virtualCamera
	end

	return nil
end

function MainScenePerformUtil.getPreviewHero()
	if SceneFace.instance:isCurScene(SceneType.CharacterPreview) then
		local scene = SceneMgr.instance:getScene(SceneType.CharacterPreview)

		return scene.stage:getHero()
	end

	return nil
end

function MainScenePerformUtil.formatVec3(vec3, isRotate)
	local function formatVal(val)
		local finalVal = 0

		if isRotate then
			val = val % 360

			local precision = 10

			finalVal = math.floor(val * precision) / precision
		else
			local precision = 1000

			finalVal = math.floor(val * precision) / precision
		end

		if math.abs(finalVal) == 0 then
			finalVal = 0
		end

		return finalVal
	end

	local result = Vector3.New(formatVal(vec3.x), formatVal(vec3.y), formatVal(vec3.z))

	return result
end

function MainScenePerformUtil.showCanvas(canvas, show, duration, ease)
	if not canvas then
		return
	end

	duration = duration or 0

	if show then
		canvas.alpha = 0

		goutil.setActive(canvas.gameObject, true)
	end

	local finalAlpha = show and 1 or 0

	canvas:DOKill(false)

	if duration > 0 then
		ease = ease or DG.Tweening.Ease.Linear

		canvas:DOFade(finalAlpha, duration):SetEase(ease):SetAutoKill(true)
	else
		canvas.alpha = finalAlpha
	end
end

function MainScenePerformUtil.createUnitCreateEntityInfo(heroId, skinId, pointId, loadAnimList, defaultAnim)
	local info = {
		isChange = false,
		localScale = 1,
		entityCode = heroId,
		skinId = skinId,
		point = pointId,
		loadAnimList = loadAnimList or {},
		defaultAnim = defaultAnim,
		pos = {
			z = 0,
			x = 0,
			y = 0
		},
		rotate = {
			z = 0,
			x = 0,
			y = 0
		},
		scale = {
			z = 1,
			x = 1,
			y = 1
		},
		posOffset = {
			z = 0,
			x = 0,
			y = 0
		},
		rotateOffset = {
			z = 0,
			x = 0,
			y = 0
		}
	}

	if not string.nilorempty(defaultAnim) then
		info.animStepStr = defaultAnim
	end

	return info
end

return MainScenePerformUtil
