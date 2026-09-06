-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchfindingView.lua

module("logic.extensions.annimatch.view.AnnimatchfindingView", package.seeall)

local AnnimatchfindingView = class("AnnimatchfindingView", ViewComponent)

function AnnimatchfindingView:ctor()
	AnnimatchfindingView.super.ctor(self)
end

function AnnimatchfindingView:buildUI()
	AnnimatchfindingView.super.buildUI(self)

	self._text_end = self:getGo("text_end"):GetComponent("Text")

	self._text_end.gameObject:SetActive(false)

	self._text_count_down_time = self:getGo("text_count_down_time"):GetComponent("Text")
	self._btnCancelMatch = self:getBtn("btnCancelMatch")
	self._txtCancelMatch = self:getGo("btnCancelMatch/txtCancelMatch"):GetComponent("Text")
	self._btnClose = self:getBtn("btnClose")
end

function AnnimatchfindingView:bindEvents()
	AnnimatchfindingView.super.bindEvents(self)
	self._btnCancelMatch:AddClickListener(function()
		if self._enemyFinded then
			-- block empty
		else
			removetimer(self._onNoEnemy, self)
			AnnimatchController.instance:sendCancelMatch(self.activityId)
			self:close()
		end
	end, self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
end

function AnnimatchfindingView:unbindEvents()
	AnnimatchfindingView.super.unbindEvents(self)
	self._btnCancelMatch:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function AnnimatchfindingView:_startMatchEnemy()
	self._text_end.gameObject:SetActive(false)
	self:_initNeedTimeCount()
	self:_showEffect()
end

function AnnimatchfindingView:endMatchEnemy()
	removetimer(self._onNoEnemy, self)
	self._text_end.gameObject:SetActive(true)

	self._text_end.text = RankRaceConfig.instance:getWord(8)

	removetimer(self._updateTime, self)
	self._text_count_down_time.gameObject:SetActive(false)

	self._txtCancelMatch.text = RankRaceConfig.instance:getWord(9)
	self._enemyFinded = true

	if self._effectControl then
		self._effectControl:StopTurn()
	end

	settimer(1, self._openMatchSuccView, self, false)
end

function AnnimatchfindingView:destroyUI()
	AnnimatchfindingView.super.destroyUI(self)
end

function AnnimatchfindingView:onEnter()
	AnnimatchfindingView.super.onEnter(self)

	self.activityId = self:getFirstParam()
	self._viewFlag = true
	self._txtCancelMatch.text = RankRaceConfig.instance:getWord(10)
	self._enemyFinded = false

	self:_startMatchEnemy()
	settimer(40, self._onNoEnemy, self, false)
	GameUtil.SetActive(self._btnCancelMatch, true)
	self.registerNotify(self, GlobalNotify.OnAnnimatchMatchSuccess, self._onRankRaceResult, self)
	self.registerNotify(self, GlobalNotify.OnAnnimatchMatchFailed, self._onFindingFailed, self)
end

function AnnimatchfindingView:onEnterFinished()
	AnnimatchfindingView.super.onEnterFinished(self)
end

function AnnimatchfindingView:onExit()
	AnnimatchfindingView.super.onExit(self)
	self:_clearEffect()
	removetimer(self._updateTime, self)
	removetimer(self._onNoEnemy, self)
	removetimer(self._openMatchSuccView, self)
	self.unregisterNotify(self, GlobalNotify.OnAnnimatchMatchSuccess, self._onRankRaceResult, self)
	self.unregisterNotify(self, GlobalNotify.OnAnnimatchMatchFailed, self._onFindingFailed, self)
end

function AnnimatchfindingView:onExitFinished()
	AnnimatchfindingView.super.onExitFinished(self)
end

function AnnimatchfindingView:_getSpeed()
	return 40
end

function AnnimatchfindingView:_getNeedTime()
	return 1
end

function AnnimatchfindingView:_initNeedTimeCount()
	self.need_time = self:_getNeedTime()

	removetimer(self._updateTime, self)
	self:_updateTime()
	settimer(1, self._updateTime, self)
end

function AnnimatchfindingView:_updateTime()
	local hour, min, sec = GameUtil.getTimeHHMMSS(self.need_time)

	self._text_count_down_time.text = string.format("%02d:%02d", min, sec)
	self.need_time = self.need_time + 1

	if self.need_time <= 0 then
		self:endMatchEnemy()
	end
end

function AnnimatchfindingView:_onClickBtnClose()
	return
end

function AnnimatchfindingView:_onNoEnemy(_fromProto)
	removetimer(self._updateTime, self)
	removetimer(self._onNoEnemy, self)

	if not _fromProto then
		AnnimatchController.instance:sendCancelMatch(self.activityId)
		self:close()
	end

	TipsFacade.instance:openTipWindowNoX(lang("tip"), RankRaceConfig.instance:getWord(11), function()
		self:_viewClose()
	end, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function AnnimatchfindingView:_openMatchSuccView()
	removetimer(self._openMatchSuccView, self)
	self:_viewClose()
end

function AnnimatchfindingView:_showEffect()
	local effect_path = "fx_ui_pipeduishou/fx_ui_pipeduishoueffect.prefab"

	self._uiEffect = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		return
	end, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)

		self._effectControl = eff.effGo:GetComponent("UIrankraceFindEnemyEffectContrl")
	end)

	self._uiEffect:setParent(self.mainGO.transform)
	self._uiEffect:setScale(1)
end

function AnnimatchfindingView:_clearEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function AnnimatchfindingView:_onRankRaceResult()
	removetimer(self._updateTime, self)
	removetimer(self._onNoEnemy, self)
	removetimer(self._openMatchSuccView, self)
	GameUtil.SetActive(self._btnCancelMatch, false)
end

function AnnimatchfindingView:_onFindingFailed()
	TipsFacade.instance:openCommonTips(lang("没有找到旗鼓相当的对手"))
	self:_viewClose()
end

function AnnimatchfindingView:_viewClose()
	if self._viewFlag then
		self:close()
	end

	self._viewFlag = false
end

return AnnimatchfindingView
