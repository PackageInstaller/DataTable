-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroUnlockView.lua

module("logic.extensions.aoqihero.view.AoqiHeroUnlockView", package.seeall)

local AoqiHeroUnlockView = class("AoqiHeroUnlockView", ViewComponent)

function AoqiHeroUnlockView:ctor()
	AoqiHeroUnlockView.super.ctor(self)
end

function AoqiHeroUnlockView:unbindEvents()
	AoqiHeroUnlockView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._con)
end

function AoqiHeroUnlockView:bindEvents()
	AoqiHeroUnlockView.super.bindEvents(self)
	GameUtil.addClickHandler(self._con, self._onClickPetCon, self)
end

function AoqiHeroUnlockView:buildUI()
	AoqiHeroUnlockView.super.buildUI(self)

	self._con = self:getGo("main/pet/petCon/con")
	self._imgRange = self:getGo("main/pet/imgRange")
	self._typeChange = goutil.findChildComponent(self.mainGO, "main/pet/type", ComponentType.UIImageSpriteChange)
end

function AoqiHeroUnlockView:onExit()
	AoqiHeroUnlockView.super.onExit(self)
	uGuiUtil.clearImage(self._imgRange)
	uGuiUtil.clearImage(self._con)
end

function AoqiHeroUnlockView:onEnter()
	AoqiHeroUnlockView.super.onEnter(self)

	local param = self._viewPresentor:getFirstParam()

	self._raceId = checknumber(param.raceId)
	self._activityId = checknumber(param.activityId)

	MaterialMgr.resetAll(self._con)

	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, self._raceId)

	MaterialMgr.setIcon(self._con, MatType.Pet, petCfg.faceIds)

	local showRaceId = petCfg.faceIds
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

	if not modelCo then
		printError("t_model id not exist:" .. showRaceId)

		return
	end

	uGuiUtil.setSpriteToImage(self._con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, 1)
	local skillCfg = AoQiHeroConfig.instance:getSkillCfg(propertyCfg.normalSkillId)

	uGuiUtil.setSpriteToImage(self._imgRange, uGuiUtil.SpriteType.BigBg, skillCfg.rangeImg)

	if petCfg.elementId > 0 then
		self._typeChange:SetState(petCfg.elementId - 1)
	end
end

function AoqiHeroUnlockView:_onClickPetCon()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._con)
	local param = {}

	param.pos = pos
	param.sizeDelta = sizeDelta
	param.view = self
	param.activityId = self._activityId
	param.raceId = self._raceId
	param.isAttack = true

	ViewMgr.instance:open(ViewName.AoqiHeroPetTipsView, param)
end

return AoqiHeroUnlockView
