-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/controller/BagPetSkinController.lua

module("logic.extensions.bag.controller.BagPetSkinController", package.seeall)

local BagPetSkinController = class("BagPetSkinController", BaseController)

BagPetSkinController.TYPE_NOT_HAS = 0
BagPetSkinController.TYPE_FOREVER = 1
BagPetSkinController.TYPE_LIMIT = 2

function BagPetSkinController:ctor()
	return
end

function BagPetSkinController:onInit()
	return
end

function BagPetSkinController:onReset()
	return
end

function BagPetSkinController:getAutoSkipStartAni()
	local skip = checknumber(GameUtil.getUserData("skip_start_ani"))

	return skip ~= 0
end

function BagPetSkinController:setAutoSkipStartAni(skip)
	if skip == true or skip == 1 then
		GameUtil.saveUserData("skip_start_ani", 1)
	else
		GameUtil.saveUserData("skip_start_ani", 0)
	end
end

function BagPetSkinController:exchangeForeverSkin(itemData, useCfg, callBack)
	local content = useCfg.content
	local arr = string.splitToNumber(content, ",")
	local skinId = arr[1]
	local refundCount = arr[2]
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
	local petCfg = MaterialMgr.getMatCfg(MatType.Pet, skinCfg.raceId)
	local hasPet = BagPetsController.instance:getPetNumByRaceId(skinCfg.raceId) > 0

	if hasPet then
		local skinLimit = self:checkSkinLimit(skinId)

		if skinLimit == BagPetSkinController.TYPE_NOT_HAS then
			TipsFacade.instance:openPopupWindow(lang("tip"), langPara(self:getDesc("TIPS_4"), refundCount), callBack)
		elseif skinLimit == BagPetSkinController.TYPE_LIMIT then
			TipsFacade.instance:openPopupWindow(lang("tip"), langPara(self:getDesc("TIPS_5"), refundCount), callBack)
		elseif skinLimit == BagPetSkinController.TYPE_FOREVER then
			TipsFacade.instance:openPopupWindow(lang("tip"), langPara(self:getDesc("TIPS_2"), skinCfg.skinName, refundCount), callBack)
		end
	else
		TipsFacade.instance:openCommonTips(langPara(self:getDesc("TIPS_3"), petCfg.name, skinCfg.skinName))
	end
end

function BagPetSkinController:exchangeExpireSkin(itemData, useCfg, callBack)
	local content = useCfg.content
	local arr = string.splitToNumber(content, ",")
	local skinId = arr[1]
	local refundCount = arr[3]
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
	local petCfg = MaterialMgr.getMatCfg(MatType.Pet, skinCfg.raceId)
	local hasPet = BagPetsController.instance:getPetNumByRaceId(skinCfg.raceId) > 0

	if hasPet then
		local skinLimit = self:checkSkinLimit(skinId)

		if skinLimit == BagPetSkinController.TYPE_NOT_HAS then
			TipsFacade.instance:openPopupWindow(lang("tip"), self:getDesc("TIPS_1"), callBack)
		elseif skinLimit == BagPetSkinController.TYPE_LIMIT then
			TipsFacade.instance:openPopupWindow(lang("tip"), self:getDesc("TIPS_1"), callBack)
		elseif skinLimit == BagPetSkinController.TYPE_FOREVER then
			TipsFacade.instance:openPopupWindow(lang("tip"), langPara(self:getDesc("TIPS_2"), skinCfg.skinName, refundCount), callBack)
		end
	else
		TipsFacade.instance:openCommonTips(langPara(self:getDesc("TIPS_3"), petCfg.name, skinCfg.skinName))
	end
end

function BagPetSkinController:getDesc(key)
	local cfg = PetSkinConfig.instance:getPetSkinCommonCfg(key)

	if cfg then
		return cfg.desc
	end

	return ""
end

function BagPetSkinController:checkSkinLimit(id)
	local data = PetskinModel.instance:getSkinInfoById(id)

	if data then
		local time = checknumber(data.expireTimeMillis)

		if time > 0 then
			local now = ServerTime.now()
			local limit = math.max(0, time - now)

			if limit <= 0 then
				return BagPetSkinController.TYPE_NOT_HAS
			else
				return BagPetSkinController.TYPE_LIMIT
			end
		else
			return BagPetSkinController.TYPE_FOREVER
		end
	else
		return BagPetSkinController.TYPE_NOT_HAS
	end
end

BagPetSkinController.instance = BagPetSkinController.New()

return BagPetSkinController
