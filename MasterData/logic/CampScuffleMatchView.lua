-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScuffleMatchView.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScuffleMatchView", package.seeall)

local CampScuffleMatchView = class("CampScuffleMatchView", ViewComponent)

function CampScuffleMatchView:ctor()
	CampScuffleMatchView.super.ctor(self)

	self._waitTime = 0
end

function CampScuffleMatchView:buildUI()
	CampScuffleMatchView.super.buildUI(self)

	self._myHead = self:getGo("animNode/root/left/information/portrait")
	self._myTxtRank = self:getTxt("animNode/root/left/information/group/Text03")
	self._myTxtName = self:getTxt("animNode/root/left/information/group/Text01")
	self._myTxtAreaName = self:getTxt("animNode/root/left/information/group/Text02")
	self._myCampScore = self:getTxt("animNode/root/left/information/group/Text04")
	self._myLevel = self:getGo("animNode/root/left/information/icon")
	self._myLevelName = self:getTxt("animNode/root/left/information/icon/txt")
	self._enemyParent = self:getGo("animNode/root/right/information")
	self._enemyHead = self:getGo("animNode/root/right/information/portrait")
	self._enemyTxtRank = self:getTxt("animNode/root/right/information/group/Text03")
	self._enemyTxtName = self:getTxt("animNode/root/right/information/group/Text01")
	self._enemyTxtAreaName = self:getTxt("animNode/root/right/information/group/Text02")
	self._enemyCampScore = self:getTxt("animNode/root/right/information/group/Text04")
	self._enemyLevel = self:getGo("animNode/root/right/information/icon")
	self._enemyLevelName = self:getTxt("animNode/root/right/information/icon/txt")
	self._txtCountdown = self:getTxt("txtCountdown")
	self._btnCancel = self:getBtn("animNode/root/Image")
	self._txtCancel = self:getTxt("animNode/root/Image/text")
	self._goEffectVS = self:getGo("effectVS")
	self._goEffectSuccess = self:getGo("effectSuccess")
	self._questionMark = self:getGo("animNode/root/right/tiao_red/questionMark")
	self._animator = goutil.findChildComponent(self.mainGO, "animNode", "Animator")
end

function CampScuffleMatchView:bindEvents()
	CampScuffleMatchView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
end

function CampScuffleMatchView:unbindEvents()
	CampScuffleMatchView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
end

function CampScuffleMatchView:onEnter()
	CampScuffleMatchView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.CS_NotifyGameStartRes, self._onMatchingSuccessRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CS_CancelMatchingRes, self._onCancelMatchingRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CS_NotifyMatchingOverTimeRes, self._onMatchingOverTimeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CS_NotifyMatchFailRes, self._onMatchingFailRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CS_NotifyGameEndRes, self._onGameEndRes, self)
	BattleSettlementModel.instance:clearChangeSetId()

	self._waitTime = 0
	self._isCanSendCancel = false

	settimer(1, self._onSecond, self)
	self._btnCancel.gameObject:SetActive(true)
	self:_setMyInfo()
	self:_setEnemyVisible(false)
	self:_setBtnCancelTxt(false)
	self:_setIsMatchSuccess(false)
	self:_updateCountdown()
	self:_resetEffectGo()
	self:_loadEffect()
	self:_showVsEffect()

	local time = CampGameConfig.instance:getCommonValueByKey("BEFORE_MATCH_TIME")

	self._tweenStartDelay = TweenUtil.DoDelay(checknumber(time), function()
		self:_sendMatchReq()

		self._isCanSendCancel = true
	end)
end

function CampScuffleMatchView:onExit()
	CampScuffleMatchView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_NotifyGameStartRes, self._onMatchingSuccessRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_CancelMatchingRes, self._onCancelMatchingRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_NotifyMatchingOverTimeRes, self._onMatchingOverTimeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_NotifyMatchFailRes, self._onMatchingFailRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CS_NotifyGameEndRes, self._onGameEndRes, self)
	removetimer(self._onSecond, self)
	self:_removeTween()
	self:_removeLevelIcon()
	self:_removeEffect()
end

function CampScuffleMatchView:_onClickClose()
	self:close()
end

function CampScuffleMatchView:_onClickCancel()
	if not self._isCanSendCancel then
		self:_onClickClose()

		return
	end

	if not self:_getIsMatchSuccess() then
		CampScuffleAgent.instance:sendCS_CancelMatchingReq()
	end
end

function CampScuffleMatchView:_onMatchingSuccessRes()
	self:_setEnemyVisible(true)
	self:_setBtnCancelTxt(true)
	self:_setIsMatchSuccess(true)
	self:_setEnemyInfo()

	local time = CampGameConfig.instance:getCommonValueByKey("AFTER_MATCH_TIME")

	self._enterNextTween = TweenUtil.DoDelay(checknumber(time), function()
		self:_onClickClose()
		UIStateManager.instance:push(ViewName.CampScuffleBanView)
	end)

	self:_showSucessEffect()
	self._animator:Play("fx_ui_pipeichenggong")
end

function CampScuffleMatchView:_onCancelMatchingRes(isSuccess)
	if isSuccess then
		self:_onClickClose()
	end
end

function CampScuffleMatchView:_onMatchingOverTimeRes()
	FloatWordMgr.instance:show(lang("scuffleTip4"))
	self:_onClickClose()
end

function CampScuffleMatchView:_onMatchingFailRes()
	FloatWordMgr.instance:show("匹配失败")
	self:_onClickClose()
end

function CampScuffleMatchView:_onGameEndRes()
	CampScuffleController.instance:onGameEndRes(function()
		self:_onClickClose()
	end)
end

function CampScuffleMatchView:_onSecond()
	self:_updateCountdown()
end

function CampScuffleMatchView:_updateCountdown()
	self._txtCountdown.text = GameUtil.FormatTimeSymbol(self._waitTime)
	self._waitTime = self._waitTime + 1
end

function CampScuffleMatchView:_setMyInfo()
	self._myTxtRank.text = "排名 " .. CampScuffleModel.instance:getMyRank()
	self._myTxtName.text = RoleModel.instance:getUserName()
	self._myTxtAreaName.text = RoleModel.instance:getAreaName()
	self._myCampScore.text = CampScuffleModel.instance:getCampScore()

	HeadItemController.instance:setMyHeadCell(self._myHead)

	local cfg = CampScuffleController.instance:getCurLevelCfg()

	if cfg then
		uGuiUtil.setSpriteToImage(self._myLevel, uGuiUtil.SpriteType.BigBg, string.format(ScuffleModel.LevelPath, cfg.icon))

		self._myLevelName.text = cfg.levelName
	end
end

function CampScuffleMatchView:_setEnemyInfo()
	local rank = CampScuffleModel.instance:getEnemyRank()

	if checknumber(rank) < 0 then
		rank = lang("未上榜")
	end

	self._enemyTxtRank.text = "排名 " .. rank
	self._enemyTxtName.text = CampScuffleModel.instance:getEnemyName()
	self._enemyTxtAreaName.text = CampScuffleModel.instance:getEnemyAreaName()
	self._enemyCampScore.text = CampScuffleModel.instance:getEnemyCampScore()

	HeadItemController.instance:setHeadCellByInfo(self._enemyHead, CampScuffleModel.instance:getEnemyHeadInfo())

	local cfg = CampGameConfig.instance:getLevelCfgByScore(CampScuffleModel.instance:getEnemyScore())

	if cfg then
		uGuiUtil.setSpriteToImage(self._enemyLevel, uGuiUtil.SpriteType.BigBg, string.format(CampScuffleModel.LevelPath, cfg.icon))

		self._enemyLevelName.text = cfg.levelName
	end
end

function CampScuffleMatchView:_removeLevelIcon()
	local myLevel = Framework.ImageBigBG.Get(self._myLevel)

	myLevel:ClearImage()

	local enemyLevel = Framework.ImageBigBG.Get(self._enemyLevel)

	enemyLevel:ClearImage()
end

function CampScuffleMatchView:_removeHead()
	MaterialMgr.resetAll(self._myHead)
	MaterialMgr.resetAll(self._enemyHead)
end

function CampScuffleMatchView:_sendMatchReq()
	CampScuffleAgent.instance:sendCS_StartMatchingReq()
end

function CampScuffleMatchView:_setEnemyVisible(isVisible)
	self._enemyParent:SetActive(isVisible)
	self._questionMark:SetActive(not isVisible)
end

function CampScuffleMatchView:_setBtnCancelTxt(isMatchSuccess)
	self._txtCancel.text = isMatchSuccess and "匹配成功" or "取消匹配"
end

function CampScuffleMatchView:_setIsMatchSuccess(isSuccess)
	self._isMatchSuccess = isSuccess
end

function CampScuffleMatchView:_getIsMatchSuccess()
	return self._isMatchSuccess
end

function CampScuffleMatchView:_removeTween()
	if self._tweenStartDelay then
		self._tweenStartDelay:Kill()

		self._tweenStartDelay = nil
	end

	if self._enterNextTween then
		self._enterNextTween:Kill()

		self._enterNextTween = nil
	end
end

function CampScuffleMatchView:_loadEffect()
	self._vsUIEffect = UIEffectManager.instance:playEffect(self, CampScuffleMatchViewPresentor.VSPath, self._goEffectVS.transform, 0, 0, true, false)

	self._vsUIEffect:setParent(self._goEffectVS.transform)
	self._vsUIEffect:setScale(1)

	self._imgUIEffect = UIEffectManager.instance:playEffect(self, CampScuffleMatchViewPresentor.IngPath, self._goEffectVS.transform, 0, 0, true, false)

	self._imgUIEffect:setParent(self._goEffectVS.transform)
	self._imgUIEffect:setScale(1)
	self._imgUIEffect:setLocalPos(0, 298, 0)

	self._successUIEffect = UIEffectManager.instance:playEffect(self, CampScuffleMatchViewPresentor.SuccessPath, self._goEffectSuccess.transform, 0, 0, true, false)

	self._successUIEffect:setParent(self._goEffectSuccess.transform)
	self._successUIEffect:setScale(1)
end

function CampScuffleMatchView:_removeEffect()
	if self._vsUIEffect then
		UIEffectManager.instance:stopEffect(self._vsUIEffect)

		self._vsUIEffect = nil
	end

	if self._imgUIEffect then
		UIEffectManager.instance:stopEffect(self._imgUIEffect)

		self._imgUIEffect = nil
	end

	if self._successUIEffect then
		UIEffectManager.instance:stopEffect(self._successUIEffect)

		self._successUIEffect = nil
	end
end

function CampScuffleMatchView:_showVsEffect()
	self._goEffectVS:SetActive(true)
end

function CampScuffleMatchView:_showSucessEffect()
	self._goEffectSuccess:SetActive(true)
end

function CampScuffleMatchView:_resetEffectGo()
	self._goEffectVS:SetActive(false)
	self._goEffectSuccess:SetActive(false)
end

return CampScuffleMatchView
