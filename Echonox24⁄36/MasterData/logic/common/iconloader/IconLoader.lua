-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/iconloader/IconLoader.lua

module("logic.common.iconloader.IconLoader", package.seeall)

local spriteAtlasMgr = SpriteAtlasMgr.instance
local IconLoader = {}

function IconLoader.setSpriteByItemType(img, itemType, iconName, callback, target, subType)
	local iconType = IconLoader.itemTypeToIconType(itemType, subType)

	IconLoader.setSprite(img, iconType, iconName, callback, target)
end

function IconLoader.setSprite(img, iconType, iconName, callback, target, modelId)
	local setting = IconType.getSetting(iconType)
	local loadType = setting.loadType
	local url = setting.url

	if loadType == IconType.LoadType_DynIcon then
		local dynIcon = Astral.ImageDynIcon.Get(img.gameObject)

		dynIcon:SetImage(string.format(url, iconName), callback, target)
	elseif loadType == IconType.LoadType_SpriteAtlas then
		spriteAtlasMgr:setSpriteToImage(img, iconType, iconName)
	elseif loadType == IconType.LoadType_CutSprite then
		IconLoader.setCutSpriteToImage(img, iconType, url, iconName, modelId, callback, target)
	elseif enableErrorLog then
		printError("unhandle load type", loadType)
	end
end

function IconLoader.setCutSpriteToImage(img, iconType, iconResPath, iconName, modelId, handler, handlerObj)
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

	local imgGo = img.gameObject
	local parentGo = imgGo.transform.parent.gameObject
	local cutCenterGo = goutil.findChild(parentGo, "cardcutcenter")

	goutil.setHeight(imgGo.transform, goutil.getHeight(parentGo.transform))
	goutil.setWidth(imgGo.transform, goutil.getWidth(parentGo.transform))
	RectTransformUtils.SetAnchoredPosition(imgGo.transform, 0, 0)
	RectTransformUtils.SetScale(imgGo.transform, 1, 1, 1)

	local preScaleX = cutCenterGo.transform.localScale.x
	local preScaleY = cutCenterGo.transform.localScale.y
	local rectX = (-cutCenterGo.transform.anchoredPosition.x / preScaleX + (cutInfo[1] + 0.5 * width)) / cutInfo[3]
	local rectY = (-cutCenterGo.transform.anchoredPosition.y / preScaleY + cutInfo[2]) / cutInfo[4]
	local rectWidth = goutil.getWidth(imgGo.transform) / preScaleX / cutInfo[3]
	local rectHeight = goutil.getHeight(imgGo.transform) / preScaleY / cutInfo[4]
	local comp = SpaceX.ImageBigBGCut.Get(imgGo)
	local imgUrl = string.format(iconResPath, iconName)

	comp:SetCutInfo(rectX, rectY, rectWidth, rectHeight, preScaleX, preScaleY)
	comp:SetImage(imgUrl, handler, handlerObj)
end

function IconLoader.setMaskSpriteToImage(img, iconType, iconName, modelId, handler, handlerObj)
	local setting = IconType.getSetting(iconType)
	local iconResPath = setting.url
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

	local imgGo = img.gameObject
	local parentGo = imgGo.transform.parent.gameObject
	local cutCenterGo = goutil.findChild(parentGo, "cardcutcenter")
	local preScaleX = cutCenterGo.transform.localScale.x * cutInfo[3]
	local preScaleY = cutCenterGo.transform.localScale.y * cutInfo[4]
	local rectX = cutCenterGo.transform.localPosition.x - (cutInfo[1] + 0.5 * width) * cutCenterGo.transform.localScale.x
	local rectY = cutCenterGo.transform.localPosition.y - cutInfo[2] * cutCenterGo.transform.localScale.y
	local rectWidth = 0
	local rectHeight = 0
	local comp = SpaceX.ImageBigBGCut.Get(imgGo)
	local imgUrl = string.format(iconResPath, iconName)

	comp:SetCutInfo(rectX, rectY, rectWidth, rectHeight, preScaleX, preScaleY)
	comp:SetMaskImage(imgUrl, handler, handlerObj)
end

function IconLoader.clearSprite(img)
	local dynIcon = img.gameObject:GetComponent(ComponentType.ImageDynIcon)

	if dynIcon then
		dynIcon:ClearImage()
	end

	img.sprite = nil
end

function IconLoader.getSpriteAtlasUrl(iconType)
	return spriteAtlasMgr:getSpriteAtlasUrl(iconType)
end

function IconLoader.bindSpriteAtlas(iconType)
	spriteAtlasMgr:bindSpriteAtlas(iconType)
end

function IconLoader.unbindSpriteAtlas(iconType)
	spriteAtlasMgr:unbindSpriteAtlas(iconType)
end

function IconLoader.itemTypeToIconType(itemType, subType)
	local iconType = IconType.ItemIcon

	if itemType == GameEnum.ItemTypeEnum.EquipItemType then
		iconType = IconType.EquipIcon
	elseif itemType == GameEnum.ItemTypeEnum.EchoItemType then
		iconType = IconType.EchoItemIcon
	elseif itemType == GameEnum.ItemTypeEnum.HeroType then
		iconType = IconType.RoleHeadIcon
	elseif itemType == GameEnum.ItemTypeEnum.FurnitureItemType then
		iconType = IconType.Furniture
	elseif itemType == GameEnum.ItemTypeEnum.DiceItem then
		iconType = IconType.D6Icon
	elseif itemType == GameEnum.ItemTypeEnum.AirSeasonCup then
		iconType = IconType.AirWorkShopTrophy
	elseif itemType == GameEnum.ItemTypeEnum.AirAchievementCup then
		iconType = IconType.AirWorkShopTrophy
	elseif itemType == GameEnum.ItemTypeEnum.PuzzlePiecesItem then
		if subType and subType == GameEnum.PuzzlePiecesSubTypeEnum.Echo then
			iconType = IconType.EchoPuzzleItemIcon
		end
	else
		iconType = IconType.ItemIcon
	end

	return iconType
end

return IconLoader
