-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/AresMomMainView.lua

module("logic.extensions.aresmom.view.AresMomMainView", package.seeall)

local AresMomMainView = class("AresMomMainView", ViewComponent)

function AresMomMainView:buildUI()
	AresMomMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._roleCon = self:getGo("role")
	self._petInfo = self:getGo("petInfo")
	self._btnSkill = goutil.findChild(self._petInfo, "btnSkill")
	self._btnInfo = goutil.findChild(self._petInfo, "btnInfo")
	self._rareCon = goutil.findChild(self._petInfo, "rare")
	self._txtPetName = goutil.findChildTextComponent(self._petInfo, "txtName")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnCall = self:getGo("btnCall")
	self._btnRank = self:getGo("btnRank")
	self._btnShop = self:getGo("btnShop")
	self._btnChallenge = self:getGo("btnChallenge")
	self._redPoint = goutil.findChild(self._btnChallenge, "redpoint")
	self._txtProgress = self:getTxt("txtProgress/txt")
	self._sldProgress = self:getSlider("sldProgress")
	self._progressCells = {}

	for i = 1, 5 do
		local cell = {}

		cell.go = goutil.findChild(self._sldProgress.gameObject, "phase_" .. i)
		cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
		cell.icon = goutil.findChildComponent(cell.go, "iconImg", "UIImageSpriteChange")
		cell.iconGo = goutil.findChild(cell.go, "iconImg")
		cell.iconLightGo = goutil.findChild(cell.go, "iconImgLight")
		cell.needProgress = 0
		self._progressCells[i] = cell
	end
end

function AresMomMainView:bindEvents()
	AresMomMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function AresMomMainView:unbindEvents()
	AresMomMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function AresMomMainView:onEnter()
	AresMomMainView.super.onEnter(self)

	self._challengeId = self:_getChallengeId()

	local isInTime = AresMomController.instance:isInTime(self._challengeId)

	if not isInTime then
		local text = "挑战未开启"

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:getConfigs()
	self:refreshViewByCfgs()

	self._mainEff = UIEffectManager.instance:playEffect(self, "20220930/aruisimuqin/fx_ui_aruisimq_jm1.prefab", nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)

	local redIdList = {}
	local keyList = {
		"ARES_GAME_DAILY_RED",
		"ARES_CHALLENGE_RED"
	}

	for _, key in ipairs(keyList) do
		local redId = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, key)

		if not string.nilorempty(redId) then
			table.insert(redIdList, redId)
		end
	end

	RedPointController.instance:regRedPoint(self._redPoint, unpack(redIdList))
	GlobalDispatcher:addListener(GlobalNotify.AresMomUpdateInfo, self.refreshViewByInfo, self)
	AresMomController.instance:getInfo(self._challengeId)
end

function AresMomMainView:onExit()
	AresMomMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AresMomUpdateInfo, self.refreshViewByInfo, self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.resetAll(self._rareCon)
	removetimer(self._onTick, self)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end

	if self._flowerEff then
		UIEffectManager.instance:stopEffect(self._flowerEff)

		self._flowerEff = nil
	end

	RedPointController.instance:unregRedPoint(self._redPoint)

	for k, v in ipairs(self._progressCells) do
		MaterialMgr.resetAll(v.iconGo)
		MaterialMgr.resetAll(v.iconLightGo)
	end
end

function AresMomMainView:_getChallengeId()
	return 51
end

function AresMomMainView:getConfigs()
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)
	self._skinId = checkint(self._challengeCfg and self._challengeCfg.raceId)
	self._skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)
	self._actCfg = AresMomConfig.instance:getActCfgById(self._challengeId)
	self._sldCfgs = AresMomConfig.instance:getSldCfgs()
end

function AresMomMainView:refreshViewByCfgs()
	self:setPetInfo()
	self:setActTime()

	for k, v in ipairs(self._progressCells) do
		local cfg = self._sldCfgs[k]

		if cfg then
			v.needProgress = cfg.progress
		end

		v.txtNum.text = v.needProgress

		local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.itemId)

		MaterialMgr.setIcon(v.iconGo, matType, matId, nil, nil)
		MaterialMgr.setIcon(v.iconLightGo, matType, matId, nil, nil)
	end
end

function AresMomMainView:refreshViewByInfo()
	self:_refreshProgress()
end

function AresMomMainView:setPetInfo()
	if self._skinCfg then
		MaterialMgr.setCell(MatType.Rare, self._skinId, self._rareCon)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._skinId, self._roleCon, 1)
		self._txtPetName.text = self._skinCfg.name
	end
end

function AresMomMainView:setActTime()
	self:_onTick()

	if self._challengeId and TLChallengeController.instance:isInOpenTime(self._challengeId) then
		settimer(1, self._onTick, self, true)
	end
end

function AresMomMainView:_onTick()
	if self._challengeId == nil or not TLChallengeController.instance:isInOpenTime(self._challengeId) then
		self._txtTime.text = ""

		local text = lang("活动已经结束")

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
		removetimer(self._onTick, self)
	else
		local cfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

		if cfg.openTimeType == 4 then
			self._txtTime.text = TLChallengeController.getActLimitTimeDesc(self._challengeId)

			removetimer(self._onTick, self)

			return
		end

		local leftTimeFormat = TLChallengeController.instance:getLeftTimeFormat(self._challengeId)

		self._txtTime.text = string.format("距离活动结束：%s", leftTimeFormat)
	end
end

function AresMomMainView:_onClickTip()
	if self._challengeCfg then
		UIStateManager.instance:push(ViewName.RulesView, self._challengeCfg.ruleKey)
	end
end

function AresMomMainView:_onClickInfo()
	if self._skinCfg then
		local raceId = self._skinCfg.raceId

		PetbookController.instance:openPetinfoView(raceId)
	end
end

function AresMomMainView:_onClickSkill()
	if self._skinCfg then
		local raceId = self._skinCfg.raceId

		PetbookController.instance:previewBattle(raceId, self._skinId)
	end
end

function AresMomMainView:_onClickCall()
	local gotoStr = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_JUMP_KEY_2")

	GotoMgr.gotoByString(gotoStr)
end

function AresMomMainView:_onClickRank()
	local gotoStr = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_JUMP_KEY_1")

	GotoMgr.gotoByString(gotoStr)
end

function AresMomMainView:_onClickShop()
	local gotoStr = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_JUMP_KEY_3")

	GotoMgr.gotoByString(gotoStr)
end

function AresMomMainView:_refreshProgress()
	local curProgress = 0

	self._curPrgressId = 0

	local lastEffId = checkint(GameUtil.getUserData("aresmommainview_flower_Id"))
	local curEffId = 0
	local checkItemParm = self._actCfg.itemId

	if not string.nilorempty(checkItemParm) then
		local arr = string.split(checkItemParm, ":") or {}

		curProgress = MaterialModel.instance:getMaterialsNumber(arr[1], arr[2])
	end

	self._txtProgress.text = langPara("当前进度：%s/%s", curProgress, self._actCfg.progress)

	for k, v in ipairs(self._progressCells) do
		GameUtil.SetActive(v.iconGo, true)
		GameUtil.SetActive(v.iconLightGo, false)
	end

	local sldValue = 0

	if curProgress >= self._actCfg.progress then
		sldValue = 1

		for k, v in ipairs(self._progressCells) do
			GameUtil.SetActive(v.iconGo, false)
			GameUtil.SetActive(v.iconLightGo, true)
		end

		curEffId = 5
	else
		local stepNum = 6
		local stepValue = checknumber(1) / checknumber(stepNum)
		local addValue = 0
		local isNeedAfterDeal = true

		if curProgress >= self._progressCells[1].needProgress then
			sldValue = sldValue + stepValue

			GameUtil.SetActive(self._progressCells[1].iconGo, false)
			GameUtil.SetActive(self._progressCells[1].iconLightGo, true)

			curEffId = 1
		end

		for i = 2, 5 do
			local cell = self._progressCells[i]

			if curProgress >= cell.needProgress then
				sldValue = sldValue + stepValue

				GameUtil.SetActive(cell.iconGo, false)
				GameUtil.SetActive(cell.iconLightGo, true)

				curEffId = i
			else
				addValue = checknumber(curProgress - self._progressCells[i - 1].needProgress) / checknumber(cell.needProgress - self._progressCells[i - 1].needProgress) * stepValue
				sldValue = sldValue + addValue
				isNeedAfterDeal = false

				break
			end
		end

		if isNeedAfterDeal then
			addValue = checknumber(curProgress - self._progressCells[5].needProgress) / checknumber(self._actCfg.progress - self._progressCells[5].needProgress) * stepValue
			sldValue = sldValue + addValue
		end
	end

	self._sldProgress:SetValue(sldValue)

	if lastEffId ~= curEffId and curEffId ~= 0 then
		self._flowerEff = UIEffectManager.instance:playEffect(self, "20220930/aruisimuqin/fx_ui_aruisimq_huakai.prefab", nil, 0, 0, false, false, nil, function(target, eff)
			eff:setParent(self._progressCells[curEffId].go.gameObject.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)
	end

	GameUtil.saveUserData("aresmommainview_flower_Id", curEffId)
end

function AresMomMainView:_onClickChallenge()
	local viewName = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_VIEW_NAME_CHALLENGE")

	if not string.nilorempty(viewName) then
		UIStateManager.instance:push(viewName, self._challengeId)
	end
end

return AresMomMainView
