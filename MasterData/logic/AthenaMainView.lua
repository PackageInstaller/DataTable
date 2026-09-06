-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/athena/AthenaMainView.lua

module("logic.extensions.timelimitedchallenge.view.athena.AthenaMainView", package.seeall)

local AthenaMainView = class("AthenaMainView", ViewComponent)

function AthenaMainView:unbindEvents()
	AthenaMainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._ruleBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._tryBtn:RemoveClickListener()
	self._witBtn:RemoveClickListener()
	self._forceBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
end

function AthenaMainView:bindEvents()
	AthenaMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._ruleBtn:AddClickListener(self._onClickRule, self)
	self._rankBtn:AddClickListener(self._onClickRank, self)
	self._tryBtn:AddClickListener(self._onClickTry, self)
	self._witBtn:AddClickListener(self._onClickWit, self)
	self._forceBtn:AddClickListener(self._onClickForce, self)
	self._skillBtn:AddClickListener(self._onClickSkill, self)
	self._introduceBtn:AddClickListener(self._onClickIntroduce, self)
	self._shopBtn:AddClickListener(self._onClickShop, self)
end

function AthenaMainView:buildUI()
	AthenaMainView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btnClose")
	self._ruleBtn = self:getBtn("topleft/btnRule")
	self._slider = self:getGo("prize/ViewPort/Content/progressBar"):GetComponent(typeof(UnityEngine.UI.Slider))
	self._gridLayout = self:getGo("prize/ViewPort/Content/prizes"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._content = self:getGo("prize/ViewPort/Content"):GetComponent(typeof(UnityEngine.RectTransform))
	self._viewPort = self:getGo("prize/ViewPort"):GetComponent(typeof(UnityEngine.RectTransform))
	self._scrollRect = self:getGo("prize"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._txtCurScore = self:getTxt("score/Text")
	self._bar = DiscreteProgressBar.New(self._slider, self._gridLayout)
	self._con = self:getGo("con")
	self._rankBtn = self:getBtn("btnRank")
	self._tryBtn = self:getBtn("btnTry")
	self._pointTryItem = self:getGo("tipTry/pointItem")
	self._tipTry = self:getBtn("tipTry")
	self._witBtn = self:getBtn("witBtn")
	self._forceBtn = self:getBtn("forceBtn")
	self._time = self:getTxt("time")
	self._skillBtn = self:getBtn("petInfo/btnSkill")
	self._introduceBtn = self:getBtn("petInfo/btnIntroduce")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._shopGoods = self:getGo("shopItemGo/shopGoods")
	self._shopBtn = self:getBtn("shopItemGo/shopBtn")
end

function AthenaMainView:onExit()
	AthenaMainView.super.onExit(self)
	GlobalDispatcher:removeListener(AthenaController.PM_WaterLightHeroTowerInfo, self._waterLightHeroTowerInfoRes, self)
	GlobalDispatcher:removeListener(AthenaController.PM_WaterLightHeroTowerGainPrize, self._waterLightHeroTowerGainPrizeRes, self)
	removetimer(self._onTick, self)
	RoleObjectPool.instance:removeRole(self._roleObj)
	MaterialMgr.resetAll(self._pointRare)

	if self._canGainEffs then
		for _, v in pairs(self._canGainEffs) do
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._canGainEffs = nil

	MaterialMgr.resetAll(self._shopGoods)
end

function AthenaMainView:_getChallengeId()
	return AthenaModel.CHALLENGEID
end

function AthenaMainView:onEnter()
	AthenaMainView.super.onEnter(self)

	self._challengeId = self:_getChallengeId()
	self._cfg = WaterLightHeroTowerConfig.instance:getCfgById(self._challengeId)

	GlobalDispatcher:addListener(AthenaController.PM_WaterLightHeroTowerInfo, self._waterLightHeroTowerInfoRes, self)
	GlobalDispatcher:addListener(AthenaController.PM_WaterLightHeroTowerGainPrize, self._waterLightHeroTowerGainPrizeRes, self)

	self._canGainEffs = {}

	WaterLightHeroTowerAgent.instance:sendPM_WaterLightHeroTowerInfoReq(self._challengeId)

	local timeLimitedCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId) or {}

	MaterialMgr.setCell(MatType.Pet, timeLimitedCfg.raceId, self._shopGoods)
	MaterialMgr.setCell(MatType.Rare, timeLimitedCfg.raceId, self._pointRare)

	local collegeId = PetCollegeConfig.instance:raceId2ChallengeId(timeLimitedCfg.raceId)

	if checknumber(collegeId) > 0 then
		local stageCfgs = PetCollegeConfig.instance:getStageCfg(collegeId)
		local passedStageId = PetCollegeModel.instance:getCurrPassStageId(collegeId)
		local prizeDic = {}

		for k, v in ipairs(stageCfgs) do
			if passedStageId < k then
				local matType, matId, matNum = unpack(string.splitToNumber(v.firstPassPrize, ":"))
				local key = matType .. ":" .. matId

				prizeDic[key] = checknumber(prizeDic[key]) + matNum
			end
		end

		local matStr = ""

		for k, v in pairs(prizeDic) do
			matStr = k .. ":" .. v
		end

		MaterialMgr.setCellByCfg(matStr, self._pointTryItem)
		self._tipTry.gameObject:SetActive(not string.nilorempty(matStr))
	end

	settimer(1, self._onTick, self, true)

	local displayBagOffset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(timeLimitedCfg.raceId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, timeLimitedCfg.raceId, self._con, scale, nil, true, x, y)

	self:_onTick()
end

function AthenaMainView:_waterLightHeroTowerInfoRes()
	local scores = {}
	local prizeCfgs = WaterLightHeroTowerConfig.instance:getPrizeById(self._challengeId)

	self._gainedPrizeIds = AthenaModel.instance:getGainedPrize(self._challengeId)
	self._minGainedId = prizeCfgs[#prizeCfgs].prizeId - 1

	GameUtil.updateCellsWithCreate(self._gridLayout, prizeCfgs, self._updateOnePrize, self)

	for _, v in ipairs(prizeCfgs) do
		table.insert(scores, v.score)
	end

	self._content.sizeDelta = Vector2.New(self._bar:setValue(scores, AthenaModel.instance:getScore(self._challengeId)) + 70, 100)

	local cellWidth = self._gridLayout.cellSize.x
	local spacingX = self._gridLayout.spacing.x

	Framework.TransformUtil.SetAnchoredPos(self._content.transform, 35 + (cellWidth + spacingX) * self._minGainedId, 0)

	self._txtCurScore.text = string.format("已收集<color=#20b376>%d</color>", AthenaModel.instance:getScore(self._challengeId))

	self:_clickBtn()
	AthenaModel.instance:setBattleType(self._challengeId)
end

function AthenaMainView:_clickBtn()
	if AthenaModel.instance:getBattleType(self._challengeId) == 2 then
		self:_onClickForce()
	elseif AthenaModel.instance:getBattleType(self._challengeId) == 1 then
		self:_onClickWit()
	end
end

function AthenaMainView:_waterLightHeroTowerGainPrizeRes(prizeId)
	printInfo("AthenaMainView:_waterLightHeroTowerGainPrizeRes", self._challengeId, prizeId, self._canGainEffs[prizeId])

	if self._canGainEffs[prizeId] then
		self._canGainEffs[prizeId].received:SetActive(true)
		UIEffectManager.instance:stopEffect(self._canGainEffs[prizeId])

		self._canGainEffs[prizeId] = nil
	end
end

function AthenaMainView:_updateOnePrize(go, cfg)
	local itemPoint = goutil.findChild(go, "item/itemcell")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local received = goutil.findChild(go, "item/received")

	MaterialMgr.setCellByCfg(cfg.prize, itemPoint)

	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")

	txtNum.text = cfg.score

	received:SetActive(self._gainedPrizeIds[cfg.prizeId])

	local canGain = AthenaModel.instance:getScore(self._challengeId) >= cfg.score

	if canGain and not self._gainedPrizeIds[cfg.prizeId] then
		local url = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"
		local eff = self:_playEffect(url, go, 0.62)

		eff.received = received
		self._canGainEffs[cfg.prizeId] = eff

		btn.gameObject:SetActive(true)
		btn:AddClickListener(function()
			AthenaController.instance:sendPM_WaterLightHeroTowerGainPrizeReq(self._challengeId, cfg.prizeId)
		end)

		self._minGainedId = math.min(self._minGainedId, cfg.prizeId - 1)
	else
		btn.gameObject:SetActive(false)
	end
end

function AthenaMainView:_playEffect(url, parent, scale)
	return (UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true, nil, nil, function(_, uiEffect)
		uiEffect:setClipping(self._viewPort)
		uiEffect:setParent(parent.transform)
		uiEffect:setScale(scale or 1)

		local rectTrans = uiEffect.effGo:GetComponent(typeof(UnityEngine.RectTransform))

		Framework.TransformUtil.SetAnchoredPos(rectTrans, 0, 0)
	end))
end

function AthenaMainView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "yadiannamain")
end

function AthenaMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.LightKingRankView, self._challengeId)
end

function AthenaMainView:_onClickTry()
	local timeLimitedCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	FuncOpenController.instance:openFunc(149, timeLimitedCfg.raceId)
end

function AthenaMainView:_onClickWit()
	UIStateManager.instance:push(ViewName.AthenaWitView, self._challengeId)
end

function AthenaMainView:_onClickForce()
	UIStateManager.instance:push(ViewName.AthenaForceView, self._challengeId)
end

function AthenaMainView:_onClickSkill()
	local timeLimitedCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	PetbookController.instance:previewBattle(timeLimitedCfg.raceId)
end

function AthenaMainView:_onClickIntroduce()
	local timeLimitedCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	PetbookController.instance:openPetinfoView(timeLimitedCfg.raceId)
end

function AthenaMainView:_onClickShop()
	GotoMgr.gotoByString(self._cfg.jumpTo)
end

function AthenaMainView:_onTick()
	if not TLChallengeController.instance:isInOpenTime(self._challengeId) then
		if self._time then
			self._time.text = ""
		end

		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("moyanbattleview__1"), function()
			self:close()
		end)
		removetimer(self._onTick, self)
	else
		local leftTimeFormat = TLChallengeController.instance:getLeftTimeFormat(self._challengeId)

		if self._time then
			self._time.text = string.format(lang("tip_surplus") .. ":%s", leftTimeFormat)
		end
	end
end

return AthenaMainView
