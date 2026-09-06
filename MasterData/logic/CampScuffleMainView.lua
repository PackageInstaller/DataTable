-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScuffleMainView.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScuffleMainView", package.seeall)

local CampScuffleMainView = class("CampScuffleMainView", ViewComponent)

function CampScuffleMainView:ctor()
	CampScuffleMainView.super.ctor(self)
end

function CampScuffleMainView:buildUI()
	CampScuffleMainView.super.buildUI(self)

	self._closeButton = self:getBtn("topLeft/btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._headIcon = self:getGo("playerInfo/headIcon")
	self._txtPlayerName = self:getTxt("playerInfo/txtPlayerName")
	self._txtArea = self:getTxt("playerInfo/txtArea")
	self._txtRank = self:getTxt("playerInfo/txtRank")
	self._imgLevelIcon = self:getGo("level/imgLevelIcon")
	self._levelChange = self:getGo("level/imgLevelName"):GetComponent(typeof(UIImageSpriteChange))
	self._txtCurScore = self:getTxt("score/txtCurScore")
	self._txtNextScore = self:getTxt("score/txtNextScore")
	self._goScoreUp = self:getGo("score/txtCurScore/scoreChange")
	self._txtDeltaNum = self:getTxt("score/txtCurScore/scoreChange/txtDeltaNum")
	self._txtCurCampScore = self:getTxt("score/txtCurCampScore")
	self._goCampScoreUp = self:getGo("score/txtCurCampScore/scoreChange")
	self._txtCampDeltaNum = self:getTxt("score/txtCurCampScore/scoreChange/txtDeltaNum")
	self._btnNormal = self:getBtn("btnNormal")
	self._btnReport = self:getBtn("bottom/btnReport")
	self._btnRank = self:getBtn("bottom/btnRank")
	self._redPoint = self:getGo("bottom/btnReward/redPoint")
	self._rtEffect1 = self:getGo("rtEffect1"):GetComponent(goutil.Type_RectTransform)
	self._rtEffect2 = self:getGo("playerInfo/rtEffect2"):GetComponent(goutil.Type_RectTransform)
	self._scoreEffect = self:getGo("score/effect")
	self._campEffect = self:getGo("score/campEffect")

	goutil.setActive(self._scoreEffect, false)
	goutil.setActive(self._campEffect, false)

	self._scoreChange = self:getGo("score/txtCurScore/scoreChange"):GetComponent(typeof(UIChangeGroup))
	self._campScoreChange = self:getGo("score/txtCurCampScore/scoreChange"):GetComponent(typeof(UIChangeGroup))
	self._txtCount = self:getTxt("txtCount")
	self._btnAdd = self:getBtn("txtCount/btnAdd")
	self._txtOpenTime = self:getTxt("openTime/txtOpenTime")
end

function CampScuffleMainView:destroyUI()
	CampScuffleMainView.super.destroyUI(self)
end

function CampScuffleMainView:bindEvents()
	CampScuffleMainView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnNormal:AddClickListener(self._onClickNormal, self)
	self._btnReport:AddClickListener(self._onClickReport, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
end

function CampScuffleMainView:unbindEvents()
	CampScuffleMainView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnNormal:RemoveClickListener()
	self._btnReport:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
end

function CampScuffleMainView:onEnter()
	CampScuffleMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.CS_ScuffleInfoRes, self._onScuffleInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CS_BuyTimesRes, self._onBuyTimesRes, self)

	self._maxCfgGameCount = checknumber(CampGameConfig.instance:getCommonValueByKey("DAILY_TIME_LIMIT"))

	settimer(1, self._onSecond, self)
	CampScuffleModel.instance:onTempReset()
	self:_resetGameObject()
	self:_initView()
	self:_refreshView()
	self:_showScoreUp()
	self:_showCampScoreUp()
	self:_loadEffect()
	self:_initOpenTime()
end

function CampScuffleMainView:onExit()
	CampScuffleMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_ScuffleInfoRes, self._onScuffleInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_BuyTimesRes, self._onBuyTimesRes, self)
	removetimer(self._onSecond, self)
	self:_removeHeadIcon()
	self:_removeTween()
	self:_removeLevelIcon()
	self:_removeEffect()
end

function CampScuffleMainView:_onClickClose()
	self:close()
end

function CampScuffleMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.CampScuffleRuleView)
end

function CampScuffleMainView:_onClickNormal()
	if not CampScuffleController.instance:isMatchGameTime() then
		FloatWordMgr.instance:show("未在开放时间哦！")

		return
	end

	if not CampScuffleController.instance:isInOpenTimeDaily() then
		FloatWordMgr.instance:show("每日开放时间：\n" .. CampScuffleController.instance:getOpenTimeTxt())

		return
	end

	local curUseGameCount = CampScuffleModel.instance:getCurGameTimes()
	local maxGameCount = CampScuffleModel.instance:getTotalMaxGameTimes(self._maxCfgGameCount)
	local isLeft = curUseGameCount < maxGameCount

	if not isLeft then
		FloatWordMgr.instance:show("次数用尽")

		return
	end

	UIStateManager.instance:push(ViewName.CampScuffleMatchView)
end

function CampScuffleMainView:_onClickReport()
	UIStateManager.instance:push(ViewName.CampScuffleReportView)
end

function CampScuffleMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.CampScuffleRankView)
end

function CampScuffleMainView:_onClickAdd()
	CampScuffleController.instance:onClickAddBuyScuffleTimes()
end

function CampScuffleMainView:_onClickNewGame()
	UIStateManager.instance:push(ViewName.CampScuffleSpecialRuleView)
end

function CampScuffleMainView:_onScuffleInfoRes(isSuccess)
	if isSuccess then
		self:_refreshView()
	else
		self:_popupCloseTip("精灵大乱斗未在活动时间内哦")
	end
end

function CampScuffleMainView:_onBuyTimesRes()
	self:_updateGameCount()
end

function CampScuffleMainView:_onSecond()
	return
end

function CampScuffleMainView:_initView()
	local cfg = CampScuffleController.instance:isExistCfgInActivityTime()

	if cfg then
		CampScuffleAgent.instance:sendCS_ScuffleInfoReq()
	else
		self:_popupCloseTip("精灵大乱斗未在活动时间内哦")
	end
end

function CampScuffleMainView:_popupCloseTip(txt)
	UIStateManager.instance:closeAllModalViews()
	TipsFacade.instance:openTipWindowNoX("提示", txt, function()
		self:_onClickClose()
	end, "确定")
end

function CampScuffleMainView:_setLevel()
	local cfg = CampScuffleController.instance:getCurLevelCfg()

	uGuiUtil.setSpriteToImage(self._imgLevelIcon, uGuiUtil.SpriteType.BigBg, string.format(CampScuffleModel.LevelPath, cfg.icon))
	self._levelChange:SetState(cfg.level - 1)
end

function CampScuffleMainView:_removeLevelIcon()
	local component = Framework.ImageBigBG.Get(self._imgLevelIcon)

	component:ClearImage()
end

function CampScuffleMainView:_setScore()
	self._txtCurScore.text = CampScuffleModel.instance:getScore()

	local score = CampScuffleController.instance:getScoreDisctanceOnNextLevel()

	self._txtNextScore.text = score > 0 and score or "已达到最高段位"
end

function CampScuffleMainView:_setCampScore()
	self._txtCurCampScore.text = CampScuffleModel.instance:getCampScore()
end

function CampScuffleMainView:_setPlayerInfo()
	self._txtPlayerName.text = RoleModel.instance:getUserName()
	self._txtArea.text = RoleModel.instance:getAreaName()
	self._txtRank.text = "排名 " .. CampScuffleModel.instance:getMyRank()

	HeadItemController.instance:setMyHeadCell(self._headIcon)
end

function CampScuffleMainView:_removeHeadIcon()
	MaterialMgr.resetAll(self._headIcon)
end

function CampScuffleMainView:_setOpenTime(key, node, txt)
	local times = self:_getOpenTimeValue(key)

	if times and times[1] and times[2] then
		local startList = string.split(times[1], ":")
		local endList = string.split(times[2], ":")

		txt.text = string.format("开放中：%s:%s - %s:%s", startList[1], startList[2], endList[1], endList[2])
	else
		txt.text = "未在活动时间"
	end
end

function CampScuffleMainView:_getOpenTimeValue(key)
	if self._timesValue and self._timesValue[key] then
		for i, v in ipairs(self._timesValue[key]) do
			if GameUtil.checkIsInTimePeriod(v[1], v[2], true) then
				return v
			end
		end

		return nil
	end

	local value = CampGameConfig.instance:getCommonValueByKey(key)
	local array = string.split(value, ",")

	self._timesValue = self._timesValue or {}
	self._timesValue[key] = self._timesValue[key] or {}

	local result

	for i, v in ipairs(array) do
		local times = string.split(v, "#")

		table.insert(self._timesValue[key], times)

		if GameUtil.checkIsInTimePeriod(times[1], times[2], true) then
			result = times
		end
	end

	return result
end

function CampScuffleMainView:_refreshView()
	self:_setPlayerInfo()
	self:_setScore()
	self:_setCampScore()
	self:_setLevel()
	self:_updateGameCount()
end

function CampScuffleMainView:_showScoreUp()
	if CampScuffleModel.instance:isHaveOldScore() then
		local oldScore = CampScuffleModel.instance:getOldScoreAndReset()
		local newScore = CampScuffleModel.instance:getScore()

		if newScore == oldScore then
			return
		end

		local isUp = oldScore < newScore
		local isDown = newScore < oldScore
		local state = 0

		if isUp then
			state = 1
			self._txtDeltaNum.text = string.format("+%d", newScore - oldScore)
		elseif isDown then
			state = 0
			self._txtDeltaNum.text = string.format("-%d", oldScore - newScore)
		end

		self._goScoreUp:SetActive(true)
		self._scoreChange:SetState(state)
		self:_showScoreEffect()

		self._scoreUpTween = TweenUtil.DoDelay(5, function()
			if not goutil.isNil(self._goScoreUp) then
				goutil.setActive(self._goScoreUp, false)
			end
		end)
	else
		goutil.setActive(self._goScoreUp, false)
	end
end

function CampScuffleMainView:_showCampScoreUp()
	if CampScuffleModel.instance:isHaveCampOldScore() then
		local oldScore = CampScuffleModel.instance:getCampOldScoreAndReset()
		local newScore = CampScuffleModel.instance:getCampScore()

		if newScore == oldScore then
			return
		end

		local isUp = oldScore < newScore
		local isDown = newScore < oldScore
		local state = 0

		if isUp then
			state = 1
			self._txtCampDeltaNum.text = string.format("+%d", newScore - oldScore)
		elseif isDown then
			state = 0
			self._txtCampDeltaNum.text = string.format("-%d", oldScore - newScore)
		end

		self._goCampScoreUp:SetActive(true)
		self._campScoreChange:SetState(state)
		self:_showCampScoreEffect()

		self._campScoreUpTween = TweenUtil.DoDelay(5, function()
			if not goutil.isNil(self._goCampScoreUp) then
				goutil.setActive(self._goCampScoreUp, false)
			end
		end)
	else
		goutil.setActive(self._goCampScoreUp, false)
	end
end

function CampScuffleMainView:_removeTween()
	if self._scoreUpTween then
		self._scoreUpTween:Kill()

		self._scoreUpTween = nil
	end

	if self._campScoreUpTween then
		self._campScoreUpTween:Kill()

		self._campScoreUpTween = nil
	end

	if self._showTween then
		self._showTween:Kill()

		self._showTween = nil
	end

	if self._campShowTween then
		self._campShowTween:Kill()

		self._campShowTween = nil
	end
end

function CampScuffleMainView:_resetGameObject()
	goutil.setActive(self._goScoreUp, false)
	goutil.setActive(self._goCampScoreUp, false)
end

function CampScuffleMainView:_loadEffect()
	local ratio = UnityEngine.Screen.height / 720

	self._rtEffect1.gameObject:SetActive(true)

	self._photoEffectMainBg = PhotoEffect.Get(self._rtEffect1.gameObject)

	local effectMainBg = UIEffectManager.instance:getEffectPath(ScuffleMainViewPresentor.MainViewBgPath)

	self._photoEffectMainBg:showEffectsFullScreen({
		effectMainBg
	}, self._rtEffect1.rect.width * ratio, self._rtEffect1.rect.height * ratio)
	self._photoEffectMainBg:setCameraPosition(0, 0, -10)
	self._photoEffectMainBg:setCameraSize(360)

	local camera = self._photoEffectMainBg._photo.producer.rtCamera

	camera.orthographic = true

	self._rtEffect2.gameObject:SetActive(true)

	self._photoEffectPlayerBg = PhotoEffect.Get(self._rtEffect2.gameObject)

	local playerBg = UIEffectManager.instance:getEffectPath(ScuffleMainViewPresentor.PlayerBgPath)

	self._photoEffectPlayerBg:showEffectsFullScreen({
		playerBg
	}, self._rtEffect2.rect.width * ratio, self._rtEffect2.rect.height * ratio)
	self._photoEffectPlayerBg:setCameraPosition(0, 36, -10)
	self._photoEffectPlayerBg:setCameraSize(192)

	local camera = self._photoEffectPlayerBg._photo.producer.rtCamera

	camera.orthographic = true

	self._scoreEffect:SetActive(false)

	self._scoreUIEffect = UIEffectManager.instance:playEffect(self, CampScuffleMainViewPresentor.ScoreUpPath, self._scoreEffect.transform, 0, 0, true, false)

	self._scoreUIEffect:setParent(self._scoreEffect.transform)
	self._scoreUIEffect:setScale(1)

	self._scoreUIEffect.hideEffWhileNotOnTop = false

	self._campEffect:SetActive(false)

	self._campUIEffect = UIEffectManager.instance:playEffect(self, CampScuffleMainViewPresentor.ScoreUpPath, self._campEffect.transform, 0, 0, true, false)

	self._campUIEffect:setParent(self._campEffect.transform)
	self._campUIEffect:setScale(1)

	self._campUIEffect.hideEffWhileNotOnTop = false
end

function CampScuffleMainView:_removeEffect()
	if self._photoEffectMainBg then
		self._photoEffectMainBg:clear()

		self._photoEffectMainBg = nil
	end

	if self._photoEffectPlayerBg then
		self._photoEffectPlayerBg:clear()

		self._photoEffectPlayerBg = nil
	end

	if self._scoreUIEffect then
		UIEffectManager.instance:stopEffect(self._scoreUIEffect)

		self._scoreUIEffect = nil
	end

	if self._campUIEffect then
		UIEffectManager.instance:stopEffect(self._campUIEffect)

		self._campUIEffect = nil
	end
end

function CampScuffleMainView:_showScoreEffect()
	goutil.setActive(self._scoreEffect, false)

	self._showTween = TweenUtil.DoDelay(0.5, function()
		goutil.setActive(self._scoreEffect, true)
	end)
end

function CampScuffleMainView:_showCampScoreEffect()
	goutil.setActive(self._campEffect, false)

	self._campShowTween = TweenUtil.DoDelay(0.5, function()
		goutil.setActive(self._campEffect, true)
	end)
end

function CampScuffleMainView:_checkIsFirstOpen()
	local key = "CampScuffleMainView_specialrule"
	local isFlag = GameUtil.getUserData(key)

	if not isFlag then
		self:_onClickNewGame()
		GameUtil.saveUserData(key, true)
	end
end

function CampScuffleMainView:_initOpenTime()
	local activityId = FunCampModel.instance:getActivityId()
	local cfgActivity = FunCampConfig.instance:getActivityCfg(activityId)

	if cfgActivity then
		local startTime = GameUtil.string2date(cfgActivity.battleStartTime)
		local endTime = GameUtil.string2date(cfgActivity.battleEndTime)

		self._txtOpenTime.text = string.format("开放时间：%02d.%02d 5:00-%02d.%02d 5:00", startTime.month, startTime.day, endTime.month, endTime.day)
	end
end

function CampScuffleMainView:_updateGameCount()
	self._txtCount.text = CampScuffleController.instance:getGameTimesText()
end

return CampScuffleMainView
