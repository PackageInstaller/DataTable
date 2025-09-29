-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/uispine/SpineCutShowLoader.lua

module("logic.uispine.SpineCutShowLoader", package.seeall)

local SpineCutShowLoader = class("SpineCutShowLoader")
local DefaultZSpacing = -0.0002

SpineCutShowLoader.PhotoSizeNum = 2048
SpineCutShowLoader.spineScale = 1
SpineCutShowLoader.SpinePhotoName = "SpineLihuiPhotoUnitGO"

function SpineCutShowLoader:ctor()
	return
end

function SpineCutShowLoader.showSpineLihuiPhoto(paramTable)
	local photo = paramTable.photo
	local modelId = paramTable.modelId
	local cutCenterPos = paramTable.cutCenterPos
	local iconType = paramTable.iconType
	local func = paramTable.func
	local handle = paramTable.handle
	local param = paramTable.param
	local heroId = paramTable.heroId
	local skinId = paramTable.skinId
	local isShowEgg = paramTable.isShowEgg
	local isShowEnter = paramTable.isShowEnter
	local isShowXiuXian = paramTable.isShowXiuXian
	local isUseOriginPos = paramTable.useOriginPos
	local posInfo = paramTable.posInfo
	local showShadow = paramTable.showShadow or false
	local faceResName
	local skinModelId = false

	if paramTable.needIgnore then
		local lastParam = SpineCutShowLoader._lastParam

		if lastParam and heroId and lastParam.heroId == heroId and modelId == lastParam.modelId and photo == lastParam.photo and cutCenterPos[1] == lastParam.cutCenterPos[1] and cutCenterPos[2] == lastParam.cutCenterPos[2] then
			return
		end

		SpineCutShowLoader._lastParam = paramTable
	end

	local heroData = false

	if heroId then
		heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

		if heroData then
			skinId = skinId or heroData:getSkinId()

			if skinId > 0 then
				local skinCo = HeroSkinConfig.instance:getInfo(skinId)

				if skinCo then
					skinModelId = skinCo.module
				end
			end
		end
	end

	modelId = skinModelId and skinModelId or modelId

	if heroData then
		local faceCO = ExpressionConfig.instance:getConfigByModelIdAndExpressionId(modelId, heroData:getExpression())

		if faceCO then
			faceResName = faceCO.expressionRes
		end
	end

	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not modelCO then
		return
	end

	local clipCO = CutImageConfig.instance:getClipCO(modelId)

	if not clipCO then
		printError("缺少裁剪信息:", modelId)

		return
	end

	local cutInfo

	if posInfo then
		cutInfo = clipCO:getSpineClipInfoArr(posInfo)
	elseif iconType == IconType.CharaterBust then
		cutInfo = clipCO:getSpineClipInfoArr("bustPosInfo")
	elseif iconType == IconType.CharaterIcon then
		cutInfo = clipCO:getSpineClipInfoArr("fullPosInfo")
	elseif iconType == IconType.CharacterHeadLeft then
		cutInfo = clipCO:getSpineClipInfoArr("leftHandInfo")
	elseif iconType == IconType.CharacterSystem then
		cutInfo = clipCO:getSpineClipInfoArr("characterSystemPosInfo")
	elseif iconType == IconType.StoryCharacter then
		cutInfo = clipCO:getSpineClipInfoArr("storyPosInfo")
	else
		return
	end

	local go = photo._unit.go

	if not isUseOriginPos then
		if paramTable.needTweenScale then
			go.transform:DOScale(Vector3.New(cutInfo[3] * cutCenterPos[3], cutInfo[4] * cutCenterPos[4], 1), 0.3)
		else
			Astral.TransformUtil.SetLocalScale(go.transform, cutInfo[3] * cutCenterPos[3], cutInfo[4] * cutCenterPos[4], 1)
		end

		Astral.TransformUtil.SetLocalPos(go.transform, cutCenterPos[1] - cutInfo[1] * cutCenterPos[3], cutCenterPos[2] - cutInfo[2] * cutCenterPos[4], 0)
	end

	photo:setSpineLoadedCallback(func, handle, param)
	photo:setBodyLoadedParm(paramTable)
	photo:setIsShowEgg(isShowEgg)
	photo:setIsShowEnter(isShowEnter)
	photo:setIsShowXiuXian(isShowXiuXian)
	photo:setShadow(showShadow)
	photo:showUnitLiveWholeByID(modelId, faceResName)
	photo:setCameraRotation(0, 0, 0)
	photo:setCameraPosition(0, 0, -11)
end

function SpineCutShowLoader.getSpineLiHuiParam(paramTable)
	local photo = paramTable.photo
	local modelId = paramTable.modelId
	local cutCenterPos = paramTable.cutCenterPos
	local iconType = paramTable.iconType
	local func = paramTable.func
	local handle = paramTable.handle
	local param = paramTable.param
	local heroId = paramTable.heroId
	local skinId = paramTable.skinId
	local skinModelId = false
	local heroData = false

	if heroId then
		heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

		if heroData then
			skinId = skinId or heroData:getSkinId()

			if skinId > 0 then
				local skinCo = HeroSkinConfig.instance:getInfo(skinId)

				if skinCo then
					skinModelId = skinCo.module
				end
			end
		end
	end

	modelId = skinModelId and skinModelId or modelId

	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not modelCO then
		return
	end

	local clipCO = CutImageConfig.instance:getClipCO(modelId)

	if not clipCO then
		printError("缺少裁剪信息:", modelId)

		return
	end

	local cutInfo

	if iconType == IconType.CharaterBust then
		cutInfo = clipCO:getSpineClipInfoArr("bustPosInfo")
	elseif iconType == IconType.CharaterIcon then
		cutInfo = clipCO:getSpineClipInfoArr("fullPosInfo")
	elseif iconType == IconType.CharacterHeadLeft then
		cutInfo = clipCO:getSpineClipInfoArr("leftHandInfo")
	elseif iconType == IconType.CharacterSystem then
		cutInfo = clipCO:getSpineClipInfoArr("characterSystemPosInfo")
	elseif iconType == IconType.StoryCharacter then
		cutInfo = clipCO:getSpineClipInfoArr("storyPosInfo")
	else
		return
	end

	local param = {
		cutCenterPos[1] - cutInfo[1] * cutCenterPos[3],
		cutCenterPos[2] - cutInfo[2] * cutCenterPos[4],
		cutInfo[3] * cutCenterPos[3],
		cutInfo[4] * cutCenterPos[4]
	}

	return param
end

function SpineCutShowLoader.clearPhoto(go)
	local unitGO = goutil.findChild(go, SpineCutShowLoader.SpinePhotoName)

	if not goutil.isNil(unitGO) then
		local photo = PhotoUnit.Get(unitGO)

		photo:clear()
		goutil.setActive(unitGO, false)
	end
end

function SpineCutShowLoader.showSpineLihui(spine, modelId, cutCenterPos, iconType, func, handle, param)
	local modelCO = ModelConfig.instance:getModelConfig(modelId)
	local resName = modelCO.liveWholeIconName
	local clipCO = CutImageConfig.instance:getClipCO(modelId)

	if not clipCO then
		printError("缺少裁剪信息:", modelId)

		return
	end

	local width, height = clipCO:getWholeImgSize()
	local cutInfo

	if iconType == IconType.CharaterBust then
		cutInfo = clipCO:getImageClipInfoArr("bustPosInfo")
	elseif iconType == IconType.CharaterIcon then
		cutInfo = clipCO:getImageClipInfoArr("fullPosInfo")
	else
		printError("该图片类型未配置iconType:", iconType)

		return
	end

	local infoTable = {}
	local cutX = cutCenterPos[1] - (cutInfo[1] + 0.5 * width) * cutCenterPos[4]
	local cutY = cutCenterPos[2] - cutInfo[2] * cutCenterPos[4]

	infoTable.cutInfo = {
		cutX,
		cutY,
		0,
		0,
		cutCenterPos[3] * cutInfo[3],
		cutCenterPos[4] * cutInfo[4]
	}
	infoTable.size = {
		0,
		0
	}
	infoTable.param = param
	SpineCutShowLoader._loadedCallBackFunc = func
	SpineCutShowLoader._loadedCallBackHandle = handle
	spine.resName = resName

	spine:setBodyLoadedParm(infoTable)
	spine:setBodyLoadedCallBack(SpineCutShowLoader._onSpineBodyLoaded, nil)
	spine:showUnit(modelId)
end

function SpineCutShowLoader.setDirection(spine, dir, modelId)
	local isFlipX = dir ~= UnitSpineDir.Default

	if spine:getDirection() == dir then
		return
	end

	local symbol = 1

	if UnitSpineDir.Default == dir then
		symbol = -1
	end

	if spine.resName then
		local spineGo = spine._skeletonLoader:getInst()
		local clipCO = CutImageConfig.instance:getClipCO(modelId)
		local width, height = clipCO:getWholeImgSize()
		local scaleX = spineGo.transform.localScale.x
		local x, y = Astral.TransformUtil.GetAnchoredPos(spineGo.transform, 0, 0)

		x = x + symbol * width * scaleX

		RectTransformUtils.SetAnchoredPosition(spineGo.transform, x, y)
		spine:setDirection(dir)
	end
end

function SpineCutShowLoader.clear(go)
	local spine = UISpine.Get(go)

	spine:clear()
	SpineCutShowLoader.clearPhoto(go)
end

function SpineCutShowLoader:_onSpineBodyLoaded(go, imgCutInfo)
	local rect = go:GetComponent(goutil.Type_RectTransform)

	RectTransformUtils.SetPivot(rect, 0, 0)
	RectTransformUtils.SetAnchor(rect, 0, 0, 0, 0)
	RectTransformUtils.SetSize(rect, imgCutInfo.size[1], imgCutInfo.size[2])
	RectTransformUtils.SetScale(rect, imgCutInfo.cutInfo[5], imgCutInfo.cutInfo[6], 1)
	RectTransformUtils.SetAnchoredPosition(rect, imgCutInfo.cutInfo[1], imgCutInfo.cutInfo[2])
	Astral.TransformUtil.SetLocalRotation(go.transform, 0, 0, imgCutInfo.rotation or 0)

	if SpineCutShowLoader._loadedCallBackFunc then
		SpineCutShowLoader._loadedCallBackFunc(SpineCutShowLoader._loadedCallBackHandle, go, imgCutInfo.param)
	end
end

return SpineCutShowLoader
