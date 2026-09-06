-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodCallerPublicView.lua

module("logic.extensions.aoqigod.view.AoqiGodCallerPublicView", package.seeall)

local AoqiGodCallerPublicView = class("AoqiGodCallerPublicView", ViewComponent)

function AoqiGodCallerPublicView:ctor()
	AoqiGodCallerPublicView.super.ctor(self)
end

function AoqiGodCallerPublicView:buildUI()
	AoqiGodCallerPublicView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtHelpTips = goutil.findChildTextComponent(self.mainGO, "txtHelpTips")
	self._helpTipsStr = self._txtHelpTips.text
	self._txtGetTips = goutil.findChildTextComponent(self.mainGO, "txtGetTips")
	self._getTipsStr = self._txtGetTips.text
	self._txtTimeTips = goutil.findChildTextComponent(self.mainGO, "txtTimeTips")
	self._timeTipsStr = self._txtTimeTips.text

	local petScrView = goutil.findChild(self.mainGO, "petCol/scrView")
	local petScrCell = goutil.findChild(self.mainGO, "petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function AoqiGodCallerPublicView:bindEvents()
	AoqiGodCallerPublicView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoqiGodCallerPublicView:unbindEvents()
	AoqiGodCallerPublicView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoqiGodCallerPublicView:onEnter()
	AoqiGodCallerPublicView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if not AoqiGodController.instance:isInActivityTime(self._activityId) then
		FloatWordMgr.instance:show("不在活动时间范围内")
		self:close()

		return
	end

	self._aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(self._activityId)
	self._actData = AoqiGodConfig.instance:getActData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodSeekHelpRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.AoqiGodItemHelpChange, self._onUpdate, self)
	self:_onUpdate()
end

function AoqiGodCallerPublicView:onExit()
	AoqiGodCallerPublicView.super.onExit(self)
	self._petScrollerList:dispose()
end

function AoqiGodCallerPublicView:_onUpdate()
	self._caller = self._aoqiGodMo:getCaller()
	self._curChallengeId = self._caller and self._caller:getChallengeId() or 0

	local cfg = AoqiGodController.instance:getClgCfgSort(self._activityId)

	self._petScrollerList:reloadData(cfg)

	self._txtHelpTips.text = string.format(self._helpTipsStr, self._aoqiGodMo:getLeftCountOfCallerPublicInWeek())
	self._txtGetTips.text = string.format(self._getTipsStr, self._aoqiGodMo:getLeftCountOfCaller())
	self._txtTimeTips.text = string.format(self._timeTipsStr, self._actData.helpTimeHour)
end

function AoqiGodCallerPublicView:_updatePetCell(view, cell, data, tag)
	local challengeId = data.challengeId
	local skinId = data.skinId
	local raceId = PetSkinConfig.instance:getPetSkinRaceId(skinId)
	local finishItem = self._aoqiGodMo:getFinishItem(challengeId)
	local isHasGain = finishItem ~= nil
	local isDoing = self._curChallengeId == challengeId
	local mainGo = cell.gameObject
	local tag = goutil.findChild(mainGo, "tag")
	local hasGain = goutil.findChild(mainGo, "hasGain")
	local btnHelp = goutil.findChild(mainGo, "btnHelp")
	local con = goutil.findChild(mainGo, "mask/con")
	local Img_attr = goutil.findChild(mainGo, "Img_attr")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")
	local rareBg = goutil.findChild(mainGo, "rareBg")
	local notGetTag = goutil.findChild(mainGo, "notGetTag")
	local isInBag = BagModel.instance:isExistRaceId(raceId)

	GameUtil.SetActive(notGetTag, not isHasGain and not isInBag)

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, imgUrl)
	else
		uGuiUtil.clearImage(con)
	end

	local rare = CharacterConfig.instance:getInitRare(raceId)

	GameUtil.setUIImageSpriteIdx(rareBg, rare - 1)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	race = race % 10

	GameUtil.setUIImageSpriteIdx(Img_attr, race - 1)

	local petName = CharacterConfig.instance:getPetName(skinId)

	txtName.text = petName

	GameUtil.SetActive(tag, isDoing)
	GameUtil.SetActive(hasGain, isHasGain)
	GameUtil.SetActive(btnHelp, not isDoing and not isHasGain)

	local tryPublicResult = AoqiGodController.instance:getTryPublicCallerResultAndTips(false, self._activityId, challengeId)

	GameUtil.SetGray(btnHelp, tryPublicResult ~= GameEnum.ResultCode.Success)
	GameUtil.addClickHandler(btnHelp, function()
		local result = AoqiGodController.instance:getTryPublicCallerResultAndTips(true, self._activityId, challengeId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		local maxFinishCountInWeek = self._aoqiGodMo:getMaxFinishCountInWeek()
		local tipsContent = string.format("是否确认发起%s的挑战请求\n发起请求后不可撤回与修改,有效期内大神完成挑战即可获得该精灵,每周仅可发布%s次求助。", petName, maxFinishCountInWeek)

		local function okFunc()
			AoqiGodController.instance:sendPM_AoqiGodSeekHelpReq(self._activityId, challengeId)
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
	end)
	GameUtil.addClickHandler(con, function()
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, skinId)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end)
end

function AoqiGodCallerPublicView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local btnHelp = goutil.findChild(mainGo, "btnHelp")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(con)
end

return AoqiGodCallerPublicView
