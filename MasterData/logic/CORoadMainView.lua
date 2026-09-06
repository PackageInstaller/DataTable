-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/view/CORoadMainView.lua

module("logic.extensions.cantonoperaroad.view.CORoadMainView", package.seeall)

local CORoadMainView = class("CORoadMainView", ViewComponent)

function CORoadMainView:buildUI()
	CORoadMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")

	local content = goutil.findChild(self.mainGO, "main/Viewport/Content")

	self._bgEffRoot = goutil.findChild(content, "bgEffRoot")
	self._modelView = goutil.findChild(content, "modelView")
	self._road = goutil.findChild(content, "road")
	self._roleView = goutil.findChild(content, "road/roleView")
	self._roleEffRoot = goutil.findChild(content, "road/roleEffRoot")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
end

function CORoadMainView:bindEvents()
	CORoadMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function CORoadMainView:unbindEvents()
	CORoadMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function CORoadMainView:onEnter()
	CORoadMainView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CantonOperaRoad)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._showGoldCount = 0

	self:_onSetUI()
	self:_setRoadAnim(GameEnum.AnimOper.Ready)
	GlobalDispatcher:addListener(GlobalNotify.CORGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.CORPvGetPrizeRes, self._handlePvGetPrizeRes, self)
	self:_sendInfoReq()
end

function CORoadMainView:onExit()
	CORoadMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CORGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.CORPvGetPrizeRes, self._handlePvGetPrizeRes, self)
	self:_setRoadAnim(GameEnum.AnimOper.Clear)
	self:_onClearModelView()
	self:_clearRoleEff()

	if self._bgEff then
		UIEffectManager.instance:stopEffect(self._bgEff)

		self._bgEff = nil
	end

	if self._unlockEff then
		UIEffectManager.instance:stopEffect(self._unlockEff)

		self._unlockEff = nil
	end

	if self._bubbleItem then
		MaterialMgr.resetAll(self._bubbleItem)
	end
end

function CORoadMainView:_sendInfoReq()
	CantonOperaRoadController.instance:sendPM_CantonOperaRoadGetInfoReq(self._activityId)
end

function CORoadMainView:_onSetUI()
	local actData = CantonOperaRoadConfig.instance:getCorActData(self._activityId)
	local startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.CantonOperaRoad, self._activityId)

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	local effParent = self._bgEffRoot
	local pathName = "20220902/yuejuzhilu/fx_ui_yjzl_jiemian"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function CORoadMainView:_onUpdate()
	self:_onUpdateModelIdToFit()
	self:_onUpdateData()
	self:_onUpdateUI()
	self:_resetRoadAnim()
end

function CORoadMainView:_onUpdateData()
	self:_onUpdateModelViewData()
end

function CORoadMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateModelViewUI()
	self:_onUpdateRoleViewUI()
end

function CORoadMainView:_onUpdatePlaneUI()
	local actData = CantonOperaRoadConfig.instance:getCorActData(self._activityId)
	local goldDataList = {}

	if not CantonOperaRoadController.instance:isPassAllEnergyModelAsCORModel() then
		local energyList = CantonOperaRoadController.instance:getEnergyListAsCOR(self._activityId)

		table.insert(goldDataList, energyList)
	end

	if not string.nilorempty(actData.resKey) then
		local propList = {
			id = actData.resKey
		}

		table.insert(goldDataList, propList)
	end

	if self._goldBarCon and #goldDataList ~= self._showGoldCount then
		self._showGoldCount = #goldDataList

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, goldDataList)
	end
end

function CORoadMainView:_onUpdateModelIdToFit()
	self._curModelId = self._curModelId or 0

	local cfg = CantonOperaRoadConfig.instance:getCorModelCfgById(self._activityId)

	for _, data in ipairs(cfg) do
		if data then
			if CantonOperaRoadController.instance:isPassAsCORModel(data.modelId) then
				self._curModelId = data.modelId
			elseif CantonOperaRoadController.instance:isCanEnterModelAsCOR(data.modelId) then
				self._curModelId = data.modelId
			end
		end
	end
end

function CORoadMainView:_onUpdateModelViewData()
	local modelInfoPool = {}
	local cfg = CantonOperaRoadConfig.instance:getCorModelCfgById(self._activityId)

	for _, data in ipairs(cfg) do
		modelInfoPool[data.modelId] = {
			data = data,
			isInTime = CantonOperaRoadController.instance:isInTimeAsCORModel(data.modelId),
			isPass = CantonOperaRoadController.instance:isPassAsCORModel(data.modelId),
			isUnlockCond = CantonOperaRoadController.instance:isUnlockConditionAsCORModel(data.modelId),
			isEnoughEnergy = CantonOperaRoadController.instance:isEnoughEnergyAsCORModel(data.modelId)
		}
	end

	self._modelInfoPool = modelInfoPool
end

function CORoadMainView:_onUpdateModelViewUI()
	local parentTran = self._modelView.transform
	local children = GameUtil.getChildren(parentTran)
	local infoList = {}

	for _, info in pairs(self._modelInfoPool) do
		table.insert(infoList, info)
	end

	table.sort(infoList, function(a, b)
		return a.data.modelId < b.data.modelId
	end)

	for index, info in ipairs(infoList) do
		local mainGo = children[index]

		if mainGo then
			self:_updateModelCell(mainGo, info)
		else
			printError("缺失模块预制( modelId = %d )", info.data.modelId)
		end
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= #infoList)
	end
end

function CORoadMainView:_onClearModelView()
	local parentTran = self._modelView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in ipairs(children) do
		GameUtil.rmClickHandler(mainGo)
	end
end

function CORoadMainView:_updateModelCell(mainGo, info)
	local data = info.data
	local isInTime = info.isInTime
	local isPass = info.isPass
	local isUnlockCond = info.isUnlockCond
	local isViewUnlock = CantonOperaRoadController.instance:isViewUnlockAsCORModel(self._activityId, data.modelId)
	local isCanEnter = CantonOperaRoadController.instance:isCanEnterModelAsCOR(data.modelId)
	local progressGo = goutil.findChild(mainGo, "progress")
	local lock = goutil.findChild(mainGo, "lock")
	local pass = goutil.findChild(mainGo, "pass")
	local txtProgressGo = goutil.findChild(mainGo, "progress")
	local txtProgress = goutil.findChildTextComponent(mainGo, "progress/txt")
	local txtLock = goutil.findChildTextComponent(mainGo, "lock/txtLock")

	GameUtil.SetActive(pass, isPass)
	GameUtil.SetActive(lock, not isInTime or not isUnlockCond or not isViewUnlock)

	local lockStr = ""

	if not isInTime then
		local timePeriod = GameUtil.getTimePeriod(data.openTime, data.endTime)

		if timePeriod == GameUtil.beforeTimePeriod then
			lockStr = string.format("%s将开启", GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.openTime), nil))

			if data.modelId == GameEnum.ModelTypeAsCOR.SHOW then
				lockStr = ""
			end
		elseif timePeriod == GameUtil.afterTimePeriod then
			lockStr = string.format("%s已结束", GameUtil.getFormatTimeByStamp(nil, GameUtil.string2time(data.endTime)))
		end
	elseif not isUnlockCond then
		-- block empty
	elseif not isViewUnlock then
		lockStr = string.format("点击解锁")
	end

	txtLock.text = lockStr

	local percentage = CantonOperaRoadController.instance:getProgressPercentageAsCORModel(data.modelId)
	local value = string.format("%d", Mathf.Min(percentage * 100, 100)) .. "%"

	txtProgress.text = string.format("进度：<size=26>%s</size>", value)

	GameUtil.SetActive(txtProgressGo, isCanEnter and isViewUnlock)

	if data.modelId == GameEnum.ModelTypeAsCOR.BOSS then
		txtProgress.text = string.format("全服进度：<size=26>%s</size>", value)
	elseif data.modelId == GameEnum.ModelTypeAsCOR.SHOW then
		local curProgress = CantonOperaRoadModel.instance:getModelProgress(data.modelId)

		txtProgress.text = curProgress >= 10000 and string.format("人数：<size=26>%.1f</size>w", curProgress / 10000) or string.format("人数：<size=26>%s</size>", curProgress)

		GameUtil.SetActive(pass, false)

		local bubble = goutil.findChild(mainGo, "bubble")
		local bubbleItem = goutil.findChild(mainGo, "bubble/item")
		local txtBubble = goutil.findChildTextComponent(mainGo, "bubble/txt")
		local actData = CantonOperaRoadConfig.instance:getCorActData(self._activityId)

		self._bubbleItem = bubbleItem

		if not string.nilorempty(actData.pvPrize) then
			local matType, matId, matNum = MaterialMgr.getMatParams(actData.pvPrize)

			MaterialMgr.setCellByCfg(actData.pvPrize, bubbleItem)

			txtBubble.text = string.format("将获得%s奖励*%s", MaterialMgr.getMaterialsName(matType, matId), matNum)
		end

		GameUtil.SetActive(bubble, not CantonOperaRoadModel.instance:isHasGainPrizeAsPv())
	end

	local oldModelId = CantonOperaRoadController.instance:getOldMaxPassModelId(self._activityId)

	if self._isNeedUnlockEff and oldModelId == data.modelId then
		self._isNeedUnlockEff = false

		local effParent = mainGo
		local pathName = "20220902/yuejuzhilu/fx_ui_yjzl_dianji"

		UIEffectManager.instance:stopEffect(self._unlockEff)

		if effParent and not string.nilorempty(pathName) then
			local path = pathName .. ".prefab"

			local function finishHandler(handlerTarget, eff)
				return
			end

			local function loadedHandler(handlerTarget, eff)
				eff:setParent(effParent.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1, 1, 1)

				eff.hideEffWhileNotOnTop = true
			end

			local handlerTarget

			self._unlockEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, handlerTarget)
		end
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickModelCell, self, info))
end

function CORoadMainView:_onClickModelCell(info)
	local modelId = info.data.modelId

	if not CantonOperaRoadController.instance:isCanEnterModelAsCOR(modelId) then
		local tipsStr = CantonOperaRoadController.instance:getTipsStrByEnterResultAsCOR(modelId)

		if not string.nilorempty(tipsStr) then
			FloatWordMgr.instance:show(tipsStr)
		end

		return
	end

	local isViewUnlock = CantonOperaRoadController.instance:isViewUnlockAsCORModel(self._activityId, modelId)

	if not isViewUnlock then
		return
	end

	if modelId == GameEnum.ModelTypeAsCOR.ANSWER then
		UIStateManager.instance:push(ViewName.CORoadAnswerMainView)
	elseif modelId == GameEnum.ModelTypeAsCOR.JIGSAW then
		UIStateManager.instance:push(ViewName.CORJigsawMainView)
	elseif modelId == GameEnum.ModelTypeAsCOR.CAKE then
		UIStateManager.instance:push(ViewName.CORoadMakingMainView)
	elseif modelId == GameEnum.ModelTypeAsCOR.BOSS then
		UIStateManager.instance:push(ViewName.CORoadBossMainView)
	elseif modelId == GameEnum.ModelTypeAsCOR.SHOW then
		self:_enterShowModel()
	end
end

function CORoadMainView:_enterShowModel()
	if CantonOperaRoadModel.instance:isHasGainPrizeAsPv() then
		self:_playVideo()
	else
		CantonOperaRoadController.instance:sendPM_CantonOperaRoadPvGetPrizeReq(self._activityId)
	end
end

function CORoadMainView:_playVideo()
	UIStateManager.instance:push(ViewName.ActivityOP220701VedioView, "cg_0_0")
end

function CORoadMainView:_handlePvGetPrizeRes()
	self:_sendInfoReq()
	self:_playVideo()
end

local roleEffPaths = {
	[0] = "20220902/yuejuzhilu/fx_ui_yjzl_yueshi",
	"20220902/yuejuzhilu/fx_ui_yjzl_yueshi",
	"20220902/yuejuzhilu/fx_ui_yjzl_yuefu",
	"20220902/yuejuzhilu/fx_ui_yjzl_yueju",
	"20220902/yuejuzhilu/fx_ui_yjzl_anyingxr",
	"20220902/yuejuzhilu/fx_ui_yjzl_yuejuwutai"
}

function CORoadMainView:_getRoleEffPath(modelId)
	return roleEffPaths[modelId]
end

function CORoadMainView:_clearRoleEff()
	if self._roleEff then
		UIEffectManager.instance:stopEffect(self._roleEff)
	end

	self._roleEff = nil
end

function CORoadMainView:_onUpdateRoleViewUI()
	local oldModelId = CantonOperaRoadController.instance:getOldMaxPassModelId(self._activityId)

	self:_clearRoleEff()

	local effParent = self._roleEffRoot
	local pathName = self:_getRoleEffPath(oldModelId)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._roleEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function CORoadMainView:_setRoadAnim(animOper)
	self._roadAnimator = self._road:GetComponent(ComponentType.Animator)

	local animationClips = self._roadAnimator.runtimeAnimatorController.animationClips
	local baseLayerName = self._roadAnimator:GetLayerName(0)

	for i = 0, animationClips.Length - 1 do
		local nameHash = string.format("%s.%s", baseLayerName, animationClips[i].name)

		nameHash = UnityEngine.Animator.StringToHash(nameHash)

		local smbList = self._roadAnimator:GetBehaviours(nameHash, 0)

		if smbList then
			if animOper == GameEnum.AnimOper.Ready then
				for i = 0, smbList.Length - 1 do
					smbList[i]:AddListener(self._onStateChange, self)
				end
			elseif animOper == GameEnum.AnimOper.Clear then
				for i = 0, smbList.Length - 1 do
					smbList[i]:RemoveListener()
				end
			end
		end
	end
end

function CORoadMainView:_resetRoadAnim()
	local oldModelId = CantonOperaRoadController.instance:getOldMaxPassModelId(self._activityId)
	local newModelId = Mathf.Clamp(oldModelId, 0, self._curModelId or 0)

	self._roadAnimator:SetTrigger("startAnim")
	self:_setIntegerToPlay(newModelId)
end

function CORoadMainView:_updateRoadAnim()
	local oldModelId = CantonOperaRoadController.instance:getOldMaxPassModelId(self._activityId)

	if oldModelId < self._curModelId then
		local newModelId = Mathf.Clamp(oldModelId + 1, 0, self._curModelId)

		CantonOperaRoadController.instance:saveNewMaxPassModelId(self._activityId, newModelId)
		self:_setIntegerToPlay(newModelId)

		self._isNeedUnlockEff = true
	elseif oldModelId > self._curModelId then
		local newModelId = Mathf.Clamp(self._curModelId, 0, self._curModelId)

		CantonOperaRoadController.instance:saveNewMaxPassModelId(self._activityId, newModelId)
		self:_setIntegerToPlay(newModelId)
	end
end

function CORoadMainView:_onStateChange(state, animator, animatorStateInfo, layerIndex)
	if state ~= AnimatorListener.STATE_ENTER then
		return
	end

	self:_onUpdateUI()
	self:_updateRoadAnim()
end

function CORoadMainView:_setIntegerToPlay(modelId)
	self._roadAnimator:SetInteger("modelId", modelId)
end

function CORoadMainView:_onClickBtnTip()
	local actData = CantonOperaRoadConfig.instance:getCorActData(self._activityId)

	TipsFacade.instance:openRulesView(actData.ruleKey)
end

return CORoadMainView
