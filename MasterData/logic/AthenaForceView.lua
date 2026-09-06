-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/athena/AthenaForceView.lua

module("logic.extensions.timelimitedchallenge.view.athena.AthenaForceView", package.seeall)

local AthenaForceView = class("AthenaForceView", ViewComponent)

function AthenaForceView:unbindEvents()
	AthenaForceView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._buyChallengeTimesBtn:RemoveClickListener()
end

function AthenaForceView:bindEvents()
	AthenaForceView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._buyChallengeTimesBtn:AddClickListener(self._onClickBuyTimes, self)
	self._buffBtn:AddClickListener(self._onClickBuff, self)
end

function AthenaForceView:buildUI()
	AthenaForceView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btnClose")
	self._stageCell = self:getGo("stageCell")
	self._stageView = ScrollerList.create(self:getGo("stageView"), self._stageCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._stageView:regGetCellSize(function()
		return 254, 456
	end)

	self._unLockText = self:getTxt("info/txtPass")
	self._buyChallengeTimesBtn = self:getBtn("info/txtChallenge/btnAdd")
	self._challengeNum = self:getTxt("info/txtChallenge")
	self._buffIcon = self:getGo("info/buff")
	self._buffBtn = self:getBtn("info/buff")
	self._buffDesc = self:getTxt("info/buff/txtBuffDesc")
end

function AthenaForceView:onExit()
	AthenaForceView.super.onExit(self)
	GlobalDispatcher:removeListener(AthenaController.PM_WaterLightHeroTowerBuyTimes, self._waterLightHeroTowerBuyTimesRes, self)
	GlobalDispatcher:removeListener(AthenaController.PM_WaterLightHeroTowerGainBuff, self._waterLightHeroTowerGainBuffRes, self)
	self._stageView:regReloadFinish()
	self._stageView:dispose()
end

function AthenaForceView:onEnter()
	AthenaForceView.super.onEnter(self)

	self._challengeId = self:getFirstParam()

	local cfg = WaterLightHeroTowerConfig.instance:getPowerById(self._challengeId) or {}

	self._cellComponent = {}

	self._stageView:regReloadFinish(function()
		self._stageView:MoveCellToCenter(self._passedStage)
	end)

	self._passedStage = AthenaModel.instance:getPowerTowerStageId(self._challengeId)
	self._passedStage = checknumber(self._passedStage)

	self._stageView:reloadData(cfg)

	self._unLockText.text = lang("tip_cumulative") .. lang("tip_clearance") .. ":" .. self._passedStage .. "/" .. #cfg
	self._cfg = WaterLightHeroTowerConfig.instance:getCfgById(self._challengeId)
	self._challengeNum.text = string.format(lang("hongliannvhuangview__1"), self:_getGamingTimes(), self._cfg.powerChallengeDailyTimes)

	GlobalDispatcher:addListener(AthenaController.PM_WaterLightHeroTowerBuyTimes, self._waterLightHeroTowerBuyTimesRes, self)
	GlobalDispatcher:addListener(AthenaController.PM_WaterLightHeroTowerGainBuff, self._waterLightHeroTowerGainBuffRes, self)
	goutil.setActive(self._buyChallengeTimesBtn.gameObject, self:_getGamingTimes() == 0)
	self:_updateBuff()
end

function AthenaForceView:_waterLightHeroTowerBuyTimesRes()
	self._challengeNum.text = string.format(lang("hongliannvhuangview__1"), self:_getGamingTimes(), self._cfg.powerChallengeDailyTimes)

	goutil.setActive(self._buyChallengeTimesBtn.gameObject, false)
end

function AthenaForceView:_waterLightHeroTowerGainBuffRes()
	self:_updateBuff()
end

function AthenaForceView:_updateBuff()
	local buffCfg = WaterLightHeroTowerConfig.instance:getBuffById(self._challengeId, AthenaModel.instance:getCurBuffLevel(self._challengeId))

	self._buffDesc.text = buffCfg and buffCfg.des or ""

	if AthenaModel.instance:getTodayCanUpgrade(self._challengeId) then
		local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"

		self._eff = UIEffectManager.instance:playEffect(self, url, self._buffIcon, 0, 0, true, nil, nil, function(_, uiEffect)
			uiEffect:setClipping(self._buffIcon:GetComponent(goutil.Type_RectTransform))
			uiEffect:setParent(self._buffIcon.transform)
			uiEffect:setScale(0.61)

			local rectTrans = uiEffect.effGo:GetComponent(typeof(UnityEngine.RectTransform))

			Framework.TransformUtil.SetAnchoredPos(rectTrans, 0, 0)
		end)
	else
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end
end

function AthenaForceView:_onClickBuyTimes()
	if self:_getGamingTimes() > 0 then
		FloatWordMgr.instance:show(lang("hongliannvhuangview__3"))

		return
	end

	if self._cfg.powerChallengeBuyTimeLimit > AthenaModel.instance:getPowerTowerBuyTimes(self._challengeId) then
		local matType, matId, matNum = MaterialMgr.getMatParams(self._cfg.powerChallengeBuyTimeCost)

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, TianmanKingController.instance:getText("TEXT_14", matNum, MaterialMgr.getContentMatStr(self._cfg.powerChallengeBuyTimeCost, 26, 0, true), self._cfg.powerChallengeBuyTimeLimit, self._cfg.powerChallengeBuyTimeLimit - AthenaModel.instance:getPowerTowerBuyTimes(self._challengeId)), function()
			WaterLightHeroTowerAgent.instance:sendPM_WaterLightHeroTowerBuyTimesReq(self._challengeId)
		end)
	else
		FloatWordMgr.instance:show(lang("hongliannvhuangview__6"))
	end
end

function AthenaForceView:_onClickBuff()
	if AthenaModel.instance:getHadGotBuff(self._challengeId) then
		FloatWordMgr.instance:show(lang("athena_challenge_tip_1"))
	elseif WaterLightHeroTowerConfig.instance:getBuffById(self._challengeId, AthenaModel.instance:getCurBuffLevel(self._challengeId) + 1) then
		WaterLightHeroTowerAgent.instance:sendPM_WaterLightHeroTowerGainBuffReq(self._challengeId)
	else
		FloatWordMgr.instance:show(lang("athena_challenge_tip_2"))
	end
end

function AthenaForceView:_updateCell(view, cell, data)
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
		if self._passedStage + 1 < data.stageId then
			FloatWordMgr.instance:show(lang("athena_challenge_tip_4"))
		elseif self._passedStage + 1 > data.stageId then
			FloatWordMgr.instance:show(lang("tip_passed"))
		elseif self:_getGamingTimes() > 0 then
			self:_onClickCellChallenge(masterCfg)
			self:close()
		else
			self:_onClickBuyTimes()
		end
	end)
	goutil.setActive(component.complete, self._passedStage >= data.stageId)

	component.rewardText.text = lang("text_reward") .. ":" .. data.addScore
	component.desc.text = masterCfg.missionDesc
end

function AthenaForceView:_onClickCellChallenge(masterCfg)
	UIStateManager.instance:push(self:_getMissionView(), self._challengeId, masterCfg)
end

function AthenaForceView:_clearCell(cell)
	if self._cellComponent[cell] then
		uGuiUtil.clearImage(self._cellComponent[cell].con)
	end
end

function AthenaForceView:_getGamingTimes()
	return self._cfg.powerChallengeDailyTimes + AthenaModel.instance:getPowerTowerBuyTimes(self._challengeId) - AthenaModel.instance:getPowerTowerDailyTimes(self._challengeId)
end

function AthenaForceView:_getMissionView()
	return ViewName.AthenaMissionView
end

return AthenaForceView
