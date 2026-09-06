-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/rank/AoqiGodPetRankView.lua

module("logic.extensions.aoqigod.view.rank.AoqiGodPetRankView", package.seeall)

local AoqiGodPetRankView = class("AoqiGodPetRankView", ViewComponent)

function AoqiGodPetRankView:buildUI()
	AoqiGodPetRankView.super.buildUI(self)

	self._filedView = goutil.findChild(self.mainGO, "rankCol/titleCol/filedView")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
end

function AoqiGodPetRankView:bindEvents()
	AoqiGodPetRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoqiGodPetRankView:unbindEvents()
	AoqiGodPetRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoqiGodPetRankView:onEnter()
	AoqiGodPetRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._rankType = checknumber(params[2])

	local isInTime = AoqiGodController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("不在活动时间内")
		self:close()

		return
	end

	self._aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(self._activityId)
	self._myRank = 0
	self._rankInfoList = {}

	self.addGEvent(self, GlobalNotify.HandlePM_AoqiGodChallengeRankRes, self._handlePM_AoqiGodChallengeRankRes, self)
	AoqiGodController.instance:sendPM_AoqiGodChallengeRankReq(self._activityId)
end

function AoqiGodPetRankView:onExit()
	AoqiGodPetRankView.super.onExit(self)
	self._rankScrollList:dispose()
end

function AoqiGodPetRankView:_handlePM_AoqiGodChallengeRankRes()
	self._rankMsg = self._aoqiGodMo:getPetRankResMsg()
	self._rankInfoList = self._rankMsg.rankInfos

	self:_onUpdate()
end

function AoqiGodPetRankView:_onUpdate()
	GameUtil.SetActive(self._emptyGo, #self._rankInfoList <= 0)
	self._rankScrollList:reloadData(self._rankInfoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
end

function AoqiGodPetRankView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local challengeId = info.challengeId
	local socre = info.value
	local clgData = AoqiGodConfig.instance:getClgData(self._activityId, challengeId)
	local skinId = clgData.skinId
	local raceId = PetSkinConfig.instance:getPetSkinRaceId(skinId)
	local petName = CharacterConfig.instance:getPetName(skinId)
	local mainGo = cell.gameObject
	local petGo = goutil.findChild(mainGo, "pet")
	local petCon = goutil.findChild(mainGo, "pet/icon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	MaterialMgr.setIcon(petCon, MatType.Pet, skinId, nil, nil)
	GameUtil.addClickHandler(petGo, function()
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, skinId)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end)

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtRank.text = rank
	txtName.text = petName
	txtScore.text = socre
end

function AoqiGodPetRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local petGo = goutil.findChild(mainGo, "pet")
	local petCon = goutil.findChild(mainGo, "pet/icon")

	MaterialMgr.clearIcon(petCon)
	GameUtil.rmClickHandler(petGo)
end

return AoqiGodPetRankView
