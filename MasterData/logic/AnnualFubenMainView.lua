-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/view/AnnualFubenMainView.lua

module("logic.extensions.annualfuben.view.AnnualFubenMainView", package.seeall)

local AnnualFubenMainView = class("AnnualFubenMainView", ViewComponent)

function AnnualFubenMainView:ctor()
	AnnualFubenMainView.super.ctor(self)
end

function AnnualFubenMainView:unbindEvents()
	AnnualFubenMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChapter1)
	GameUtil.rmClickHandler(self._btnChapter2)
	GameUtil.rmClickHandler(self._btnChapter3)
	GameUtil.rmClickHandler(self._btnJump)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStory)
end

function AnnualFubenMainView:bindEvents()
	AnnualFubenMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChapter1, self._onClickChapterOne, self)
	GameUtil.addClickHandler(self._btnChapter2, self._onClickChapterTwo, self)
	GameUtil.addClickHandler(self._btnChapter3, self._onClickChapterThree, self)
	GameUtil.addClickHandler(self._btnJump, self._onClickJump, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnStory, self._onClickStory, self)
end

function AnnualFubenMainView:buildUI()
	AnnualFubenMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._info = self:getGo("info")
	self._btnChapter1 = self:getGo("info/btnChapter1")
	self._btnChapter2 = self:getGo("info/btnChapter2")
	self._openTime2 = self:getGo("info/btnChapter2/openTime")
	self._txtOpenTime2 = self:getTxt("info/btnChapter2/openTime/txt")
	self._btnChapter3 = self:getGo("info/btnChapter3")
	self._openTime3 = self:getGo("info/btnChapter3/openTime")
	self._txtOpenTime3 = self:getTxt("info/btnChapter3/openTime/txt")
	self._redpointChapter1 = self:getGo("info/btnChapter1/redpoint")
	self._redpointChapter2 = self:getGo("info/btnChapter2/redpoint")
	self._redpointChapter3 = self:getGo("info/btnChapter3/redpoint")
	self._btnJump = self:getGo("info/btnJump")
	self._enterEffect = self:getGo("enterEffect")
	self._txtWorldTime = self:getTxt("info/worldTime/txtTime")
	self._petCon = self:getGo("petCon")
	self._enterStory = self:getGo("enterStory")
	self._btnStory = self:getGo("enterStory/btnStory")
	self._sandClockEffect = self:getGo("enterStory/sandClockEffect")
	self._shalouGo = self:getGo("enterStory/shalou")
	self._sharkEffect = self:getGo("enterStory/sharkEffect")
	self._ballEffectPos = self:getGo("enterStory/ballEffectPos")
	self._ballEffect = self:getGo("enterStory/ballEffect")
	self._enterPetCon = self:getGo("enterStory/pet/petCon")
	self._bg_1 = self:getGo("bg_1")
	self._bg_2 = self:getGo("bg_2")
	self._txtTime = self:getTxt("time/txtTime")
	self._worldTime = self:getGo("info/worldTime")
end

function AnnualFubenMainView:onExit()
	AnnualFubenMainView.super.onExit(self)
	removetimer(self._onClock, self)
	self:_clearEnterRole()
	RoleObjectPool.instance:removeRole(self._role)

	self._role = nil
end

function AnnualFubenMainView:onEnter()
	AnnualFubenMainView.super.onEnter(self)
	self:addGEvent(GlobalNotify.PM_AnnualFubenInfoRes, self._refreshView)

	self._spineRenderers = {}
	self._saveMaterials = {}
	self._tempMats = {}
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 546001
	end

	self._activityCfg = AnnualFubenConfig.instance:getActivityCfg(self._activityId)

	AnnualFubenAgent.instance:sendPM_AnnualFubenInfoReq(self._activityId)

	if not AnnualFubenModel.instance:getFirstEnterMain(self._activityId) == true then
		self._enterRole = RoleObjectPool.instance:addRoleToParent(self._enterRole, self._activityCfg.faceId, self._enterPetCon, 1, function(go)
			if go then
				self:_updateSpineMat(go)
			end
		end)

		self:_showEnterAnim()
	else
		GameUtil.SetActive(self._enterStory, false)
		GameUtil.SetActive(self._bg_1, false)
		GameUtil.SetActive(self._bg_2, true)
		GameUtil.SetActive(self._petCon, true)
		GameUtil.SetActive(self._info, true)
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._activityCfg.faceId, self._petCon, 1)
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
end

function AnnualFubenMainView:_refreshView()
	self:_initTimer()

	local chapterThreeOpenTime = GameUtil.string2time(self._activityCfg.openTimeThree)
	local chapterTwoOpenTime = GameUtil.string2time(self._activityCfg.openTimeTwo)
	local chapterThreeOpenDate = GameUtil.string2date(self._activityCfg.openTimeThree)
	local chapterTwoOpenTData = GameUtil.string2date(self._activityCfg.openTimeTwo)

	GameUtil.SetActive(self._openTime2, chapterTwoOpenTime > ServerTime.now())
	GameUtil.SetActive(self._openTime3, chapterThreeOpenTime > ServerTime.now())

	if chapterTwoOpenTime > ServerTime.now() then
		self._txtOpenTime2.text = langPara("%d.%02d %d:%02d开启", chapterTwoOpenTData.month, chapterTwoOpenTData.day, chapterTwoOpenTData.hour, chapterTwoOpenTData.min)
	end

	if chapterThreeOpenTime > ServerTime.now() then
		self._txtOpenTime3.text = langPara("%d.%02d %d:%02d开启", chapterThreeOpenDate.month, chapterThreeOpenDate.day, chapterThreeOpenDate.hour, chapterThreeOpenDate.min)
	end

	if self._curPrecent and self._curPrecent >= 1 and not AnnualFubenModel.instance:getReadChapterThreeStory(self._activityId) then
		GameUtil.SetActive(self._redpointChapter3, true)
	else
		GameUtil.SetActive(self._redpointChapter3, false)
	end

	local todayTimes = AnnualFubenModel.instance:getSearchClueTime(self._activityId)
	local actCfg = AnnualFubenConfig.instance:getActivityCfg(self._activityId)
	local curTimes = actCfg.dailyClue - todayTimes
	local clueCfgs = AnnualFubenConfig.instance:getClueCfgs(self._activityId)
	local isGainAllSearch = true

	for i, v in ipairs(clueCfgs) do
		if v.initClue == true and not AnnualFubenModel.instance:isGainClue(self._activityId, v.clueId) then
			isGainAllSearch = false

			break
		end
	end

	if curTimes > 0 and not isGainAllSearch or AnnualFubenController.instance:isCanGetCluePrize(self._activityId) then
		GameUtil.SetActive(self._redpointChapter1, true)
	else
		GameUtil.SetActive(self._redpointChapter1, false)
	end

	GameUtil.SetActive(self._redpointChapter2, false)
end

function AnnualFubenMainView:_updateSpineMat(go)
	local components = go:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic), true)

	for i = 1, components.Length do
		local component = components:GetValue(i - 1)

		self._spineRenderers[go] = component
		self._saveMaterials[go] = component.material
		self._tempMats[go] = SimpleMaterialLoader.instance:getInstanceMat(CommonResPath.SpineSkeletonGraphicMat)
		self._tempMats[go].mainTexture = component.material.mainTexture
		component.material = self._tempMats[go]
	end
end

function AnnualFubenMainView:_refreshClockInfo(curPrecent, curProgress, curShowTime)
	self._curPrecent = curPrecent
	self._txtWorldTime.text = GameUtil.FormatTimeSymbol(curShowTime)
end

function AnnualFubenMainView:_initTimer()
	self._curProgressId, self._precentStart, self._startProgressTime, self._nexProgressId, self._nextProgressTime, self._precentEnd = AnnualFubenController.instance:getWorldProgressCfgInfo(self._activityId)

	removetimer(self._onClock, self)

	local curTime = ServerTime.now()

	self:_onClock()

	if self._nextProgressTime and curTime < self._nextProgressTime then
		settimer(1, self._onClock, self, true)
	end
end

function AnnualFubenMainView:_onClock()
	local curTime = ServerTime.now()

	if not self._nextProgressTime then
		local curPrecent, curProgress, curShowTime = AnnualFubenController.instance:getWorldProgressInfo(self._activityId, self._curProgressId, self._precentStart, self._startProgressTime, self._nexProgressId, self._nextProgressTime, self._precentEnd)

		self:_refreshClockInfo(curPrecent, curProgress, curShowTime)
	elseif curTime < self._nextProgressTime then
		local curPrecent, curProgress, curShowTime = AnnualFubenController.instance:getWorldProgressInfo(self._activityId, self._curProgressId, self._precentStart, self._startProgressTime, self._nexProgressId, self._nextProgressTime, self._precentEnd)

		self:_refreshClockInfo(curPrecent, curProgress, curShowTime)
	else
		self:_initTimer()
	end
end

function AnnualFubenMainView:_showEnterAnim()
	GameUtil.SetActive(self._info, false)
	GameUtil.SetActive(self._bg_2, false)
	GameUtil.SetActive(self._petCon, false)
	GameUtil.SetActive(self._enterStory, true)
	GameUtil.SetActive(self._btnStory, true)
	GameUtil.SetActive(self._bg_1, true)
end

function AnnualFubenMainView:_onClickChapterOne()
	UIStateManager.instance:push(ViewName.AnnualFubenChapterOneView, self._activityId)
end

function AnnualFubenMainView:_onClickChapterTwo()
	local chapterTwoOpenTime = GameUtil.string2time(self._activityCfg.openTimeTwo)
	local chapterTwoOpenTData = GameUtil.string2date(self._activityCfg.openTimeTwo)

	if chapterTwoOpenTime > ServerTime.now() then
		local centent = langPara("%d.%02d %d:%02d开启", chapterTwoOpenTData.month, chapterTwoOpenTData.day, chapterTwoOpenTData.hour, chapterTwoOpenTData.min)

		FloatWordMgr.instance:show(centent)
	else
		UIStateManager.instance:push(ViewName.AnnualFuBenChapterTwoView, self._activityId)
	end
end

function AnnualFubenMainView:_onClickChapterThree()
	local chapterThreeOpenTime = GameUtil.string2time(self._activityCfg.openTimeThree)
	local chapterThreeOpenDate = GameUtil.string2date(self._activityCfg.openTimeThree)

	if chapterThreeOpenTime > ServerTime.now() then
		local centent = langPara("%d.%02d %d:%02d开启", chapterThreeOpenDate.month, chapterThreeOpenDate.day, chapterThreeOpenDate.hour, chapterThreeOpenDate.min)

		FloatWordMgr.instance:show(centent)
	else
		UIStateManager.instance:push(ViewName.AnnualFubenChapterThreeView, self._activityId)
	end
end

function AnnualFubenMainView:_onClickJump()
	GotoMgr.gotoByString(self._activityCfg.jumpTo)
end

function AnnualFubenMainView:_onClickClose()
	self:close()
end

function AnnualFubenMainView:_onClickTip()
	TipsFacade.instance:openRulesView("annual_fuben_rule")
end

function AnnualFubenMainView:_onClickStory()
	AnnualFubenModel.instance:setFirstEnterMain(self._activityId)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._endStory, self)
	GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._activityCfg.enterStoryId)
	GameUtil.SetActive(self._btnStory, false)
end

function AnnualFubenMainView:_endStory()
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._endStory, self)

	local path = "20251219/26nianfeifubenzhujiemian1/fx_ui_nffb_sjcq_liuguang.prefab"
	local Type_SkeletonGraphic = typeof(Spine.Unity.SkeletonGraphic)
	local graphics = self._enterPetCon:GetComponentsInChildren(Type_SkeletonGraphic)

	for i = 0, graphics.Length - 1 do
		RoleObjectPool.instance:playAnimation(graphics[i].gameObject, "z1", false, function()
			RoleObjectPool.instance:playAnimation(graphics[i].gameObject, "idle", true, nil, true)
		end, true)
	end

	self._effectBall = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function()
		self:_moveBall()
	end)

	local startPos = GameUtil.getLocalPos(self._ballEffectPos)

	GameUtil.setLocalPos(self._ballEffect, startPos.x, startPos.y, startPos.z)
	self._effectBall:setParent(self._ballEffect.transform)
	self._effectBall:setScale(1)
	self._effectBall:setLocalPos(0, 0, 0)
end

function AnnualFubenMainView:_moveBall()
	local from = GameUtil.getLocalPos(self._ballEffectPos)
	local to = GameUtil.getLocalPos(self._shalouGo)
	local tween = UnityTweens.TweenPosition.StartTween(self._ballEffect, from, to, 1, UnityTweens.EaseType.linear, 1)

	tween:AddListener(function()
		self:_showSandClockEffect()
	end)
end

function AnnualFubenMainView:_showSandClockEffect()
	if self._effectBall then
		UIEffectManager.instance:stopEffect(self._effectBall)

		self._effectBall = nil
	end

	local path = "20251219/26nianfeifubenzhujiemian1/fx_ui_nffb_sjcq_shalou.prefab"

	self._effectSandClock = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, false, nil, function()
		self:_showFlashEffect()
	end)

	self._effectSandClock:setParent(self._sandClockEffect.transform)
	self._effectSandClock:setScale(1)
	self._effectSandClock:setLocalPos(0, 0, 0)
end

function AnnualFubenMainView:_showFlashEffect()
	if self._effectSandClock then
		UIEffectManager.instance:stopEffect(self._effectSandClock)

		self._effectSandClock = nil
	end

	local path = "20241220/zhongyanzhizhan/fx_ui_bianbai.prefab"
	local flashEffect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, false, nil, function()
		GameUtil.SetActive(self._enterStory, false)
		self:_clearEnterRole()
		GameUtil.SetActive(self._info, true)
		GameUtil.SetActive(self._bg_1, false)
		GameUtil.SetActive(self._bg_2, true)
		GameUtil.SetActive(self._petCon, true)
	end)

	flashEffect:setParent(self._sharkEffect.transform)
	flashEffect:setScale(1)
	flashEffect:setLocalPos(0, 0, 0)
end

function AnnualFubenMainView:_clearEnterRole()
	if self._spineRenderers then
		for k, v in pairs(self._spineRenderers) do
			v.material = self._saveMaterials[k]
		end

		self._spineRenderers = {}
	end

	if self._tempMats then
		for k, v in pairs(self._tempMats) do
			SimpleMaterialLoader.instance:recycleInstanceMat(CommonResPath.SpineSkeletonGraphicMat, v)
		end

		self._tempMats = {}
	end

	if self._enterRole then
		RoleObjectPool.instance:removeRole(self._enterRole)

		self._enterRole = nil
	end
end

return AnnualFubenMainView
