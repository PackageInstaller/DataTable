-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorhero/view/ArmorHeroClgView.lua

module("logic.extensions.armorhero.view.ArmorHeroClgView", package.seeall)

local ArmorHeroClgView = class("ArmorHeroClgView", ViewComponent)

function ArmorHeroClgView:ctor()
	ArmorHeroClgView.super.ctor(self)
end

function ArmorHeroClgView:unbindEvents()
	ArmorHeroClgView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnFight)
	GameUtil.rmClickHandler(self._btnTip)
end

function ArmorHeroClgView:bindEvents()
	ArmorHeroClgView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickFight, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function ArmorHeroClgView:buildUI()
	ArmorHeroClgView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._roleCon = self:getGo("roleCon")
	self._btnFight = self:getGo("btnFight")
	self._txtTimes = self:getTxt("times/txt")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnTip = self:getGo("leftTop/btnTip")

	local cellProgress = self:getGo("prize/cell")
	local tabProgress = self:getGo("prize/tableview")

	self._tableviewProgress = ScrollerList.create(tabProgress, cellProgress, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._progressBar = self:getSlider("prize/tableview/viewport/content/progressBar")
	self._txtNumDamage = self:getTxt("prize/damageNum/txtNum")
end

function ArmorHeroClgView:onExit()
	ArmorHeroClgView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self._tableviewProgress:dispose()
end

function ArmorHeroClgView:onEnter()
	ArmorHeroClgView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ArmorHeroInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_ArmorHeroGainProgressPrizeRes, self._updatePrizes, self)

	self._activityId = 540001
	self._stageId = 1

	local params = self:getOpenParam()

	if params then
		if params[1] then
			self._activityId = checknumber(params[1])
		end

		if params[2] then
			self._stageId = checknumber(params[2])
		end
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	ArmorHeroController.instance:getInfo(self._activityId)
end

function ArmorHeroClgView:_updateUIByCfg()
	self._actCfg = ArmorHeroConfig.instance:getActivityCfgByActId(self._activityId)
	self._stageCfg = ArmorHeroConfig.instance:getStageCfgByIdAndStageId(self._activityId, self._stageId)
	self._progressCfgs = ArmorHeroConfig.instance:getProgressCfgsByPlanId(self._stageCfg.progressPlan)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = checknumber(self._stageCfg.skinId)

	if skinId > 0 then
		local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", skinId)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._roleCon, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])
	end
end

function ArmorHeroClgView:_updateUIByInfo()
	self:_updatePrizes()

	self._todayChallengeTimes = 0

	local info = ArmorHeroModel.instance:getInfo(self._activityId)

	if info then
		if not info.stageInfos then
			local stageInfos = {}

			for _, stageInfo in ipairs(stageInfos) do
				if stageInfo.stageId == self._stageId then
					self._todayChallengeTimes = stageInfo.todayChallengeTimes or 0

					break
				end
			end
		end
	end

	if not self._actCfg.dailyClgTimes then
		local maxTimes = 0

		self._txtTimes.text = string.format("今日挑战次数：%d/%d", self._todayChallengeTimes, maxTimes)
	end
end

function ArmorHeroClgView:_updatePrizes()
	self._hasGainProgressPrizeIdMap = {}
	self._totalDamage = 0

	local info = ArmorHeroModel.instance:getInfo(self._activityId)

	if info then
		if not info.stageInfos then
			do
				local stageInfos = {}

				for _, stageInfo in ipairs(stageInfos) do
					if stageInfo.stageId == self._stageId then
						self._totalDamage = checknumber(stageInfo.totalDamage)

						if not stageInfo.hasGainProgressPrizeId then
							local hasGainProgressPrizeId = {}

							for _, progressId in ipairs(hasGainProgressPrizeId) do
								self._hasGainProgressPrizeIdMap[progressId] = true
							end

							break
						end
					end
				end
			end

			local showIndex = -1
			local lastIndex = -1
			local scoreList = {}

			for i, v in ipairs(self._progressCfgs) do
				if checknumber(v.progress) <= self._totalDamage then
					if not self._hasGainProgressPrizeIdMap[i] then
						if showIndex <= 0 then
							showIndex = i
						end
					else
						lastIndex = i
					end
				end

				table.insert(scoreList, checknumber(v.progress))
			end

			if lastIndex <= 0 then
				lastIndex = 1
			end

			if showIndex <= 0 then
				showIndex = lastIndex
			end

			self._tableviewProgress:updateUnderSlider(self._progressBar, self._totalDamage, scoreList)
			self._tableviewProgress:reloadData(self._progressCfgs)
			self._tableviewProgress:MoveCellToBegin(showIndex - 1)

			self._txtNumDamage.text = self:_formatNum(self._totalDamage)
		end
	end
end

function ArmorHeroClgView:_onClickFight()
	if not self._actCfg.dailyClgTimes then
		if self._actCfg.dailyClgTimes <= self._todayChallengeTimes then
			FloatWordMgr.instance:show(lang("今日挑战次数已用完"))

			return
		end

		ArmorHeroController.instance:showBossMissionView(self._activityId, self._stageId)
	end
end

function ArmorHeroClgView:_formatNum(num)
	local num = checknumber(num)

	num = Mathf.Max(num, 0)

	if num >= 100000000 then
		if num % 100000000 == 0 then
			return string.format("%.0f亿", num / 100000000)
		end

		return string.format("%.2f亿", num / 100000000)
	elseif num >= 10000 then
		if num % 10000 == 0 then
			return string.format("%.0f万", num / 10000)
		end

		return string.format("%.2f万", num / 10000)
	else
		return tostring(num)
	end
end

function ArmorHeroClgView:_updateProgressCell(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.setCellByCfg(data.prize, item)

	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	txtNum.text = self:_formatNum(data.progress)

	if not self._hasGainProgressPrizeIdMap[data.progressId] then
		local isGain = false
		local isMatchGain = not isGain and self._totalDamage >= checknumber(data.progress)
		local btnGet = goutil.findChild(cell.gameObject, "btnGet")

		goutil.setActive(btnGet, isMatchGain)

		local effect = goutil.findChild(cell.gameObject, "effect")

		if isMatchGain then
			self:_playCellEffect(effect)
			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGainPrize, self, data.progressId))
		else
			self:_clearCellEffect(effect)
		end

		local geted = goutil.findChild(cell.gameObject, "geted")

		goutil.setActive(geted, isGain)
	end
end

function ArmorHeroClgView:_clearProgressCell(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	if item then
		MaterialMgr.resetAll(item)
	end

	local btnGet = goutil.findChild(cell.gameObject, "btnGet")

	if btnGet then
		GameUtil.rmClickHandler(btnGet)
	end

	local effect = goutil.findChild(cell.gameObject, "effect")

	if effect then
		self:_clearCellEffect(effect)
	end
end

function ArmorHeroClgView:_onClickGainPrize(progressId)
	ArmorHeroController.instance:sendGainProgressPrize(self._activityId, progressId, self._stageId)
end

function ArmorHeroClgView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("prize/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function ArmorHeroClgView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function ArmorHeroClgView:_onClickTip()
	if self._stageCfg == nil then
		return
	end

	local key = self._stageCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

return ArmorHeroClgView
