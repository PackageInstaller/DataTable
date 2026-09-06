-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/athena/AthenaWitView.lua

module("logic.extensions.timelimitedchallenge.view.athena.AthenaWitView", package.seeall)

local AthenaWitView = class("AthenaWitView", ViewComponent)

function AthenaWitView:unbindEvents()
	AthenaWitView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._oneKeyBtn:RemoveClickListener()
	self._passBtn:RemoveClickListener()
end

function AthenaWitView:bindEvents()
	AthenaWitView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._oneKeyBtn:AddClickListener(self._onClickOneKey, self)
	self._passBtn:AddClickListener(self._onClickPass, self)
end

function AthenaWitView:buildUI()
	AthenaWitView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btnClose")
	self._stageCell = self:getGo("stageCell")
	self._cellComponent = {}
	self._stageView = ScrollerList.create(self:getGo("stageView"), self._stageCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._stageView:regGetCellSize(function()
		return 254, 456
	end)

	self._oneKeyBtn = self:getBtn("btnOneKey")
	self._oneKeyCost = self:getTxt("btnOneKey/txtOnekeyCost")
	self._oneKeyCostIcon = self:getGo("btnOneKey/txtOnekeyCost/icon")
	self._passBtn = self:getBtn("btnAllPass")
	self._passCost = self:getTxt("btnAllPass/txtAllpassCost")
	self._passCostIcon = self:getGo("btnAllPass/txtAllpassCost/icon")
end

function AthenaWitView:onExit()
	AthenaWitView.super.onExit(self)
	MaterialMgr.resetAll(self._passCostIcon)
	MaterialMgr.resetAll(self._oneKeyCostIcon)
	self._stageView:regReloadFinish()
	self._stageView:dispose()
	GlobalDispatcher:removeListener(AthenaController.PM_WaterLightHeroTowerOnKeyPassWisdom, self._PM_WaterLightHeroTowerOnKeyPassWisdomRes, self)
	GlobalDispatcher:removeListener(AthenaController.PM_WaterLightHeroTowerOnKeyPassWisdomStage, self._PM_WaterLightHeroTowerOnKeyPassWisdomStageRes, self)
end

function AthenaWitView:onEnter()
	AthenaWitView.super.onEnter(self)

	self._challengeId = self:getFirstParam()

	local cfg = WaterLightHeroTowerConfig.instance:getWisdomById(self._challengeId) or {}

	self._passedStage = AthenaModel.instance:getWisdomTowerStageId(self._challengeId)
	self._passedStage = checknumber(self._passedStage)

	self._stageView:regReloadFinish(function()
		self._stageView:MoveCellToCenter(self._passedStage)
	end)
	self._stageView:reloadData(cfg)
	goutil.setActive(self._oneKeyBtn.gameObject, self._passedStage < #cfg)
	goutil.setActive(self._passBtn.gameObject, self._passedStage < #cfg)

	if self._passedStage < #cfg then
		local matType, id, matNum = MaterialMgr.getMatParams(cfg[self._passedStage + 1].onekeyPassCost)

		self._passCost.text = matNum

		MaterialMgr.setIcon(self._passCostIcon, matType, id)

		local cost = 0

		for i = self._passedStage + 1, #cfg do
			matType, id, matNum = MaterialMgr.getMatParams(cfg[i].onekeyPassCost)
			cost = cost + matNum
		end

		self._oneKeyCost.text = cost

		MaterialMgr.setIcon(self._oneKeyCostIcon, matType, id)
	end

	GlobalDispatcher:addListener(AthenaController.PM_WaterLightHeroTowerOnKeyPassWisdom, self._PM_WaterLightHeroTowerOnKeyPassWisdomRes, self)
	GlobalDispatcher:addListener(AthenaController.PM_WaterLightHeroTowerOnKeyPassWisdomStage, self._PM_WaterLightHeroTowerOnKeyPassWisdomStageRes, self)
end

function AthenaWitView:_PM_WaterLightHeroTowerOnKeyPassWisdomRes(msg)
	self._passedStage = AthenaModel.instance:getWisdomTowerStageId(self._challengeId)

	self._stageView:refresh(WaterLightHeroTowerConfig.instance:getWisdomById(self._challengeId))
	self._stageView:MoveCellToCenter(self._passedStage)
	goutil.setActive(self._oneKeyBtn.gameObject, false)
	goutil.setActive(self._passBtn.gameObject, false)
	GlobalDispatcher:dispatch(AthenaController.PM_WaterLightHeroTowerInfo)
end

function AthenaWitView:_PM_WaterLightHeroTowerOnKeyPassWisdomStageRes(msg)
	self._passedStage = AthenaModel.instance:getWisdomTowerStageId(self._challengeId)

	local cfg = WaterLightHeroTowerConfig.instance:getWisdomById(self._challengeId)

	self._stageView:refresh(cfg)
	self._stageView:MoveCellToCenter(self._passedStage)

	self._passedStage = AthenaModel.instance:getWisdomTowerStageId(self._challengeId)

	goutil.setActive(self._oneKeyBtn.gameObject, self._passedStage < #cfg)
	goutil.setActive(self._passBtn.gameObject, self._passedStage < #cfg)

	if self._passedStage < #cfg then
		local matType, id, matNum = MaterialMgr.getMatParams(cfg[self._passedStage + 1].onekeyPassCost)

		self._passCost.text = matNum

		local cost = 0

		for i = self._passedStage + 1, #cfg do
			matType, id, matNum = MaterialMgr.getMatParams(cfg[i].onekeyPassCost)
			cost = cost + matNum
		end

		self._oneKeyCost.text = cost
	end

	GlobalDispatcher:dispatch(AthenaController.PM_WaterLightHeroTowerInfo)
end

function AthenaWitView:_onClickOneKey()
	TipsFacade.instance:openPopupCostDiamondView(tonumber(self._oneKeyCost.text), string.format(lang("athena_challenge_tip_5"), tonumber(self._oneKeyCost.text)), function()
		WaterLightHeroTowerAgent.instance:sendPM_WaterLightHeroTowerOnKeyPassWisdomReq(self._challengeId)
	end)
end

function AthenaWitView:_onClickPass()
	TipsFacade.instance:openPopupCostDiamondView(tonumber(self._passCost.text), string.format(lang("athena_challenge_tip_6"), tonumber(self._passCost.text)), function()
		WaterLightHeroTowerAgent.instance:sendPM_WaterLightHeroTowerOnKeyPassWisdomStageReq(self._challengeId)
	end)
end

function AthenaWitView:_updateCell(view, cell, data)
	if not self._cellComponent[cell] then
		self._cellComponent[cell] = {}
		self._cellComponent[cell].stageName = goutil.findChildTextComponent(cell.gameObject, "stageName")
		self._cellComponent[cell].con = goutil.findChild(cell.gameObject, "pet/con")
		self._cellComponent[cell].challengeBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "challengeBtn")
		self._cellComponent[cell].complete = goutil.findChild(cell.gameObject, "complete")
		self._cellComponent[cell].rewardText = goutil.findChildTextComponent(cell.gameObject, "reward")
		self._cellComponent[cell].desc = goutil.findChildTextComponent(cell.gameObject, "desc")
	end

	local component = self._cellComponent[cell]
	local masterCfg = WaterLightHeroTowerConfig.instance:getMasterById(data.creepMasterId)

	component.stageName.text = masterCfg.name

	local creepsCo = WaterLightHeroTowerConfig.instance:getCreepsById(data.creepMasterId)

	uGuiUtil.setSpriteToImage(component.con, uGuiUtil.SpriteType.BigBg, GameUrl.getLotteryPetImgUrl(creepsCo[1].raceId))
	uGuiUtil.setGoGrayState(component.con, self._passedStage + 1 < data.stageId)
	component.challengeBtn:AddClickListener(function()
		self:_onClickCellChallenge(masterCfg, data.supportPlanId)
		self:close()
	end)
	goutil.setActive(component.challengeBtn.gameObject, self._passedStage + 1 == data.stageId)
	goutil.setActive(component.complete, self._passedStage >= data.stageId)

	component.rewardText.text = lang("text_reward") .. ":" .. data.addScore
	component.desc.text = masterCfg.missionDesc
end

function AthenaWitView:_onClickCellChallenge(masterCfg, supportPlanId)
	UIStateManager.instance:push(self:_getMissionView(), self._challengeId, masterCfg, supportPlanId)
end

function AthenaWitView:_clearCell(cell)
	if self._cellComponent[cell] then
		self._cellComponent[cell].challengeBtn:RemoveClickListener()
		uGuiUtil.clearImage(self._cellComponent[cell].con)
	end
end

function AthenaWitView:_getMissionView()
	return ViewName.AthenaMissionView
end

return AthenaWitView
