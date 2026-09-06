-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerfunc/view/AnswerFuncView.lua

module("logic.extensions.answerfunc.view.AnswerFuncView", package.seeall)

local AnswerFuncView = class("AnswerFuncView", ViewComponent)

function AnswerFuncView:ctor()
	AnswerFuncView.super.ctor(self)

	self._stageItemList = nil
	self._stageIndexList = nil
end

function AnswerFuncView:onExit()
	AnswerFuncView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.Answer_UpdataFuncInfo, self._updataAllStageItemShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.Answer_UpdataStoryPrize, self._updataAllStageItemShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.Answer_UpdataCurrentAnswer, self._openAnswerShowView, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	self:_stopRoleAnims()
end

function AnswerFuncView:destroyUI()
	AnswerFuncView.super.destroyUI(self)

	self._stageItemList = nil
	self._stageIndexList = nil
end

function AnswerFuncView:bindEvents()
	AnswerFuncView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		AnswerFuncModel.instance.curChoiseParam = nil

		self:close()
	end, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "answerfunc")
	end, self)
	self._answerBtn:AddClickListener(self._onClickAnswerBtn, self)
end

function AnswerFuncView:unbindEvents()
	AnswerFuncView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._answerBtn:RemoveClickListener()
end

function AnswerFuncView:buildUI()
	AnswerFuncView.super.buildUI(self)

	self._timeTxt = self:getTxt("timeGo/timeTxt")
	self._scoreTxt = self:getTxt("scoreGo/scoreTxt")
	self._closeBtn = self:getBtn("leftTopGo/closeBtn")
	self._tipsBtn = self:getBtn("leftTopGo/tipsBtn")
	self._role = self:getGo("role")
	self._roleCons = {}
	self._roleCons[1] = self:getGo("role/con_1")
	self._roleCons[2] = self:getGo("role/con_2")
	self._roleCanvasGroup = self._role:GetComponent(ComponentType.CanvasGroup)
	self._petEffs = {}

	local stageAllTrans = self:getGo("stageAllTrans").transform

	self._stageItemList = {}
	self._stageIndexList = {}

	for i = 1, stageAllTrans.childCount do
		local go = stageAllTrans:GetChild(i - 1).gameObject
		local strs = string.split(go.name, "_")

		self._stageItemList[tonumber(strs[2])] = {
			itemGo = go,
			selectGo = goutil.findChild(go, "selectGo"),
			lockGo = goutil.findChild(go, "lockGo"),
			passGo = goutil.findChild(go, "passGo"),
			redGo = goutil.findChild(go, "redGo"),
			stageTxt = goutil.findChildTextComponent(go, "stageTxt"),
			getTxt = goutil.findChildTextComponent(go, "getTxt"),
			iconGo = goutil.findChild(go, "getTxt/iconGo")
		}
	end

	self._leftBtnGo = self:getGo("leftBtnGo")
	self._leftBtnTxt = goutil.findChildTextComponent(self._leftBtnGo, "leftTxt")
	self._leftLockGo = goutil.findChild(self._leftBtnGo, "leftLockGo")
	self._leftLockTxt = goutil.findChildTextComponent(self._leftLockGo, "leftLockTxt")
	self._leftRedGo = goutil.findChild(self._leftBtnGo, "leftRedGo")
	self._rightBtnGo = self:getGo("rightBtnGo")
	self._rightBtnTxt = goutil.findChildTextComponent(self._rightBtnGo, "rightTxt")
	self._rightLockGo = goutil.findChild(self._rightBtnGo, "rightLockGo")
	self._rightLockTxt = goutil.findChildTextComponent(self._rightLockGo, "rightLockTxt")
	self._rightRedGo = goutil.findChild(self._rightBtnGo, "rightRedGo")
	self._answerBtn = self:getBtn("answerBtn")
	self._answerTxt = self:getTxt("answerBtn/answerTxt")
	self._answerRedGo = self:getGo("answerBtn/answerRedGo")
	self._timeTxt.text = ""

	GameUtil.SetActive(self._leftBtnGo, false)
	GameUtil.SetActive(self._rightBtnGo, false)

	self._scoreTxt.text = ""
	self._answerTxt.text = ""

	GameUtil.SetActive(self._answerRedGo, false)
end

function AnswerFuncView:onEnter()
	AnswerFuncView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.Answer_UpdataFuncInfo, self._updataAllStageItemShow, self)
	GlobalDispatcher:addListener(GlobalNotify.Answer_UpdataStoryPrize, self._updataAllStageItemShow, self)
	GlobalDispatcher:addListener(GlobalNotify.Answer_UpdataCurrentAnswer, self._openAnswerShowView, self)

	local actId = AnswerFuncConfig.instance:getAnswerFuncActivityId()

	self._actCfg = AnswerFuncConfig.instance:getAnswerActivityCfg(actId)

	if actId <= 0 then
		printError("sr---问题功能      AnswerFuncView:onEnter()       策划未配置 = " .. actId)

		return
	end

	self._plotPlanId = AnswerFuncModel.instance:getPlotPlanId()

	self:_startInitData()
	AnswerFuncController.instance:csGetAnswerProblemUnlockPlotInfoReq(self._actCfg.activityId)

	local key = "AnswerFuncView" .. self._actCfg.activityId

	local function firstTimeCallback()
		local storyId = 4440001

		if storyId > 0 then
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end
	end

	GameUtil.doCallbackWhenFirst(key, firstTimeCallback, nil)
end

function AnswerFuncView:_startInitData()
	self._timeTxt.text = self._actCfg.timeDes

	local effPath = "20221028/jinglingwenda/fx_ui_jinglingwenda.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.mainGO.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
end

function AnswerFuncView:_updataAllStageItemShow()
	self:_startRoleAnims()

	self._afInfo = AnswerFuncModel.instance:getAnswerFuncInfo()
	self._plotPlanId = AnswerFuncModel.instance:getPlotPlanId()
	self._maxScore = AnswerFuncModel.instance:getAnswerAllScoreByPlanId(self._plotPlanId)

	local haveNum = math.max(self._actCfg.dailyTimes - self._afInfo.useNum, 0)
	local maxChapter = AnswerFuncModel.instance:getAnswerAllChapterByPlanId(self._plotPlanId)

	self._answerTxt.text = string.format("可问答次数：%s/%s", haveNum, self._actCfg.dailyTimes)
	self._scoreTxt.text = string.format("<size=18>答题积分：</size><color=#47E28F>%s/%s</color>", self._afInfo.score, self._maxScore)
	self._curParam = AnswerFuncModel.instance.curChoiseParam
	self._curStageList = self._curParam and self._curParam.chapterId and AnswerFuncModel.instance:getAnswerChapterStageList(self._plotPlanId, self._curParam.chapterId) or AnswerFuncModel.instance:getAnswerChapterStageList(self._plotPlanId)

	if self._curStageList == nil or #self._curStageList == nil then
		printError("sr---问题功能   AnswerFuncView:_updataAllStageItemShow()    没有找到对应章节数据 = " .. self._plotPlanId)

		return
	end

	self._curCharacter = self._curStageList[1].chapterId

	self:_choiseChapterById()
end

function AnswerFuncView:_onClickLeftRightBtn(isLeft)
	if not isLeft and not string.nilorempty(self._rightLockTips) then
		FloatWordMgr.instance:show(self._rightLockTips)

		return
	end

	self._curCharacter = checknumber(self._curCharacter)

	if isLeft and self._curCharacter <= 1 then
		return
	end

	local maxChapter = AnswerFuncModel.instance:getAnswerAllChapterByPlanId(self._plotPlanId)

	if not isLeft and maxChapter <= self._curCharacter then
		return
	end

	if isLeft then
		if not (self._curCharacter - 1) then
			local id = self._curCharacter + 1
			local list = AnswerFuncModel.instance:getAnswerChapterStageList(self._plotPlanId, id)

			if list == nil or #list == nil then
				return
			end

			self._curStageList = list
			self._curCharacter = id

			self:_choiseChapterById()
		end
	end
end

function AnswerFuncView:_choiseChapterById()
	local allCount = #self._curStageList
	local startNum = math.ceil(#self._stageItemList / 2) - math.ceil(allCount / 2) + 1
	local endNum = startNum + allCount - 1
	local index = 0

	for i = 1, #self._stageItemList do
		GameUtil.asBtn(self._stageItemList[i].itemGo):RemoveClickListener()
		MaterialMgr.resetAll(self._stageItemList[i].iconGo)

		if startNum <= i and i <= endNum then
			index = index + 1

			GameUtil.SetActive(self._stageItemList[i].itemGo, true)

			local cfg = self._curStageList[index]

			self._stageItemList[i].stageTxt.text = cfg.stageName

			local matType, matId, matNum = MaterialMgr.getMatParams(cfg.prize)
			local matName = MaterialMgr.getMaterialsName(matType, matId)

			self._stageItemList[i].getTxt.text = string.format("x%s", matNum)

			MaterialMgr.setIcon(self._stageItemList[i].iconGo, matType, matId)

			if self._afInfo.score >= cfg.scoreLimit then
				GameUtil.SetActive(self._stageItemList[i].lockGo, false)

				if self._curParam and self._curParam.stageId == cfg.stageId then
					GameUtil.SetActive(self._stageItemList[i].selectGo, true)
				else
					GameUtil.SetActive(self._stageItemList[i].selectGo, false)
				end

				if self._afInfo.poltHasLook and table.indexof(self._afInfo.poltHasLook, cfg.onlyId) then
					GameUtil.SetActive(self._stageItemList[i].passGo, true)
					GameUtil.SetActive(self._stageItemList[i].redGo, false)
				else
					GameUtil.SetActive(self._stageItemList[i].passGo, false)
					GameUtil.SetActive(self._stageItemList[i].redGo, true)
				end
			else
				GameUtil.SetActive(self._stageItemList[i].lockGo, true)
				GameUtil.SetActive(self._stageItemList[i].selectGo, false)
				GameUtil.SetActive(self._stageItemList[i].passGo, false)
				GameUtil.SetActive(self._stageItemList[i].redGo, false)
			end

			GameUtil.asBtn(self._stageItemList[i].itemGo):AddClickListener(function()
				self:_onClickChapterStageBtn(cfg)
			end, self)
		else
			GameUtil.SetActive(self._stageItemList[i].itemGo, false)
		end
	end
end

function AnswerFuncView:_onClickChapterStageBtn(cfg)
	if cfg == nil then
		return
	end

	if cfg.scoreLimit > self._afInfo.score then
		FloatWordMgr.instance:show(string.format("累计获得%s积分后解锁", cfg.scoreLimit))

		return
	end

	AnswerFuncModel.instance.curChoiseParam = {
		chapterId = cfg.chapterId,
		stageId = cfg.stageId
	}

	GlobalDispatcher:dispatch(GlobalNotify.StartStory, cfg.storyId)

	if self._afInfo.poltHasLook and table.indexof(self._afInfo.poltHasLook, cfg.onlyId) then
		return
	end

	AnswerFuncController.instance:csGetAnswerProblemUnlockPlotGainPrizeReq(self._actCfg.activityId, cfg.onlyId)
end

function AnswerFuncView:_onClickAnswerBtn()
	AnswerFuncModel.instance.curChoiseParam = nil

	if self._actCfg.dailyTimes <= self._afInfo.useNum then
		FloatWordMgr.instance:show("今日免费次数已使用完！")

		return
	end

	if AnswerFuncModel.instance:getTypeId() <= 0 then
		return
	end

	AnswerFuncController.instance:csGetAnswerProblemUnlockPlotStartAnswerReq(self._actCfg.activityId)
end

function AnswerFuncView:_openAnswerShowView(num, isStart, addScore)
	if not isStart then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.AnswerShow) then
		return
	end

	UIStateManager.instance:push(ViewName.AnswerShow, num)
end

function AnswerFuncView:_getSkinIdList(typeId)
	local typeData = AnswerFuncConfig.instance:getTypeData(self._actCfg.activityId, typeId)

	return (typeData or nil) and (typeData.skinIdList or {})
end

function AnswerFuncView:_getSkinId(typeId, roleIdx)
	local skinIdList = self:_getSkinIdList(typeId)

	return checknumber(skinIdList[roleIdx])
end

local RoleAnimPer = {
	Switch = 1,
	Stay = 2
}

function AnswerFuncView:_startRoleAnims()
	local typeId = AnswerFuncModel.instance:getTypeId()

	if typeId <= 0 then
		return
	end

	self._animSkinIdList = self:_getSkinIdList(typeId)
	self._curRoleIdx = 0
	self._curSkinListIdx = 0
	self._tickingDelta = 0.1
	self._totalStayDelta = 5
	self._curStayDelta = self._totalStayDelta
	self._roleAnimPer = RoleAnimPer.Stay

	if #self._animSkinIdList > 0 then
		settimer(self._tickingDelta, self._roleAnimTicking, self, true)
	end
end

function AnswerFuncView:_stopRoleAnims()
	removetimer(self._roleAnimTicking, self)
	self:_stopSwitchAnim()
	self:_clearAllRoleEff()
end

function AnswerFuncView:_roleAnimTicking()
	if self._roleAnimPer == RoleAnimPer.Switch then
		-- block empty
	elseif self._roleAnimPer == RoleAnimPer.Stay then
		self._curStayDelta = self._curStayDelta + self._tickingDelta

		if self._curStayDelta >= self._totalStayDelta then
			self._roleAnimPer = RoleAnimPer.Switch

			self:_playSwitchAnim()
		end
	end
end

function AnswerFuncView:_playSwitchAnim()
	self:_stopSwitchAnim()

	local oldGo = self._roleCons[self._curRoleIdx]

	self:_playAnimOfHideEff(oldGo)

	self._curRoleIdx = self._curRoleIdx % 2 + 1

	local newGo = self._roleCons[self._curRoleIdx]

	self._curSkinListIdx = self._curSkinListIdx % #self._animSkinIdList + 1

	local newSkinId = self._animSkinIdList[self._curSkinListIdx]

	self:_playAnimOfShowEff(newGo, newSkinId)
end

function AnswerFuncView:_stopSwitchAnim()
	self:_clearAnimOfShowEff()
	self:_clearAnimOfHideEff()
end

function AnswerFuncView:_loadRoleEff(go, skinId)
	skinId = checknumber(skinId)

	if skinId <= 0 then
		return
	end

	if goutil.isNil(go) then
		return
	end

	self._petEffs[go] = self._petEffs[go] or PetPhotoShow.Get(go)

	local eff = self._petEffs[go]
	local x, y, scale = 0, 0, 1
	local modelCfg = CharactorFacade.instance:getYdAnswerUIPosAndScale(skinId)

	if modelCfg then
		scale = modelCfg[3] or 1
		y = modelCfg[2] or 0
		x = modelCfg[1] or 0
	end

	eff:showPetEffect(skinId, true, 3)
	eff:setPetLocalPosAndScale(x, y, scale)

	return eff
end

function AnswerFuncView:_clearRoleEff(go)
	if not goutil.isNil(go) and self._petEffs[go] then
		self._petEffs[go]:clear()

		self._petEffs[go] = nil
	end
end

function AnswerFuncView:_clearAllRoleEff()
	for _, go in ipairs(self._roleCons) do
		self:_clearRoleEff(go)
	end
end

function AnswerFuncView:_playAnimOfShowEff(go, skinId)
	local eff = self:_loadRoleEff(go, skinId)

	if eff == nil then
		return
	end

	local startVal = 0
	local endVal = 1
	local duration = 1.7
	local luaTarget = self
	local easeType = DG.Tweening.Ease.Linear

	local function updateHander(val)
		Game.ImageUtil.SetRawImageAlpha(eff._rawImg, val)
	end

	local function endHander()
		self._curStayDelta = 0
		self._roleAnimPer = RoleAnimPer.Stay
	end

	self._roleAlphaTweenOfShow = TweenUtil.ValueTo(startVal, endVal, duration, updateHander, endHander, luaTarget, easeType)
end

function AnswerFuncView:_clearAnimOfShowEff()
	if self._roleAlphaTweenOfShow == nil then
		return
	end

	self._roleAlphaTweenOfShow:Kill(true)

	self._roleAlphaTweenOfShow = nil
end

function AnswerFuncView:_playAnimOfHideEff(go)
	if self._petEffs then
		local eff = self._petEffs[go]

		if self._petEffs == nil then
			return
		end

		local startVal = 1
		local endVal = 0
		local duration = 1.7
		local luaTarget = self
		local easeType = DG.Tweening.Ease.Linear

		local function updateHander(val)
			Game.ImageUtil.SetRawImageAlpha(eff._rawImg, val)
		end

		local function endHander()
			self:_clearRoleEff(go)
		end

		self._roleAlphaTweenOfHide = TweenUtil.ValueTo(startVal, endVal, duration, updateHander, endHander, luaTarget, easeType)
	end
end

function AnswerFuncView:_clearAnimOfHideEff()
	if self._roleAlphaTweenOfHide == nil then
		return
	end

	self._roleAlphaTweenOfHide:Kill(true)

	self._roleAlphaTweenOfHide = nil
end

return AnswerFuncView
