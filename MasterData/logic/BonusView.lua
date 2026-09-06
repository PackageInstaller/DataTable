-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/BonusView.lua

module("logic.extensions.bonus.view.BonusView", package.seeall)

local BonusView = class("BonusView", ViewComponent)

BonusView.MainCellSizeY = 75
BonusView.SubCellSizeY = 65
BonusView.ReduceSize = 10

local Event_Name = "bonusviewchangetab"

function BonusView:ctor()
	BonusView.super.ctor(self)
end

function BonusView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function BonusView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function BonusView:buildUI()
	BonusView.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
	self.container = self:getGo("container")
	self._tablist = self:getGo("tablist")
	self._commonTab = TabFrameCommonTab.create(self._tablist, GameUtil.handler(self._onUpdateExtCell, self), GameUtil.handler(self._onUpdateRight, self))

	self._commonTab:setTabDataFilterCallBack(GameUtil.handler(self._onTabFilter, self))
	self._commonTab:setPreClickCallBack(GameUtil.handler(self._onPreClickCell, self))
	self._commonTab:getScrollList():regValueChanged(GameUtil.handler(self._onValueChanged, self))

	self._tip = self:getGo("tip")
	self._tipRect = self:getGo("tip"):GetComponent(goutil.Type_RectTransform)
	self._bgGo = self:getGo("bg")
end

function BonusView:destroyUI()
	self._curViewDatas = nil

	RedPointController.instance:RemoveViewRedpointInfo(self._viewPresentor.viewName)
end

function BonusView:onEnter()
	self.addGEvent(self, TrainerCourseNewAgent.PM_TrainerCourseGetInfoRes, self._onTrainerCourseGetInfoRes, self)
	self.addGEvent(self, "UpdataExcellentClassTask", self._onTrainerCourseGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.closeBonusView, self._closeBonusView, self)
	self.addGEvent(self, GlobalNotify.RedPointUpdate, self._updateRedpoint, self)
	self.addGEvent(self, GlobalNotify.BounsRedPointUpdate, self._updateRedpoint, self)
	self.addGEvent(self, GlobalNotify.Passport_ActIds_Update, self.updateViewList, self)
	self.addGEvent(self, GlobalNotify.SURVEY_LIST_INFO_UPDATE, self.updateSurveyList, self)
	self.addGEvent(self, Event_Name, self._onViewTabChange, self)

	self.lastRedState = RedPointModel.instance:isActive(RedPointModel.ID_SEVENSIGN2)

	PassportController.instance:sendAndGetPassActive()

	local firstParam = self:getFirstParam()

	self:_initScrollTab(firstParam)

	self._startY = 32
	self._moveY = 5
	self._animInterval = 1
	self._animTime = 0.3
	self._moveSequence = nil
	self._moveSequence = DG.Tweening.DOTween.Sequence()

	self:_setTipAnim()

	if ActivityDefineController.instance:isInActivityTimeById(106, 106001) then
		SevenDaysController.instance:CSRequestClassInfo(106001)
	end

	SevenDaysController.instance:CSRequestClassInfo(0)
	SurveyController.instance:sendPM_SignForSdkSurveyReq()
end

function BonusView:_initScrollTab(firstParam)
	local lastOpenBonusId = BounsModel.instance:getLastOpenBonusId()

	if firstParam ~= nil then
		if string.nilorempty(firstParam) and not string.nilorempty(SevenDaysModel.instance.openBonusName) and lastOpenBonusId ~= 0 then
			firstParam = SevenDaysModel.instance.openBonusName
		end

		SevenDaysModel.instance.openBonusName = nil
	end

	local data

	self._emptyMap = {}
	self._leafMap = {}

	self._commonTab:clearAllData()

	local tagCfgs = BonusConfig.instance:getTabCfg()

	for i, tacCfg in ipairs(tagCfgs) do
		tacCfg.redpointId = ""

		local obj = self._commonTab:addTabData(tacCfg.tabName, tacCfg)

		self._emptyMap[obj.root] = true

		local cfg = BonusConfig.instance:getCfgByTab(tacCfg.tabId) or {}

		for j, v in ipairs(cfg) do
			tacCfg.redpointId = tacCfg.redpointId .. v.redpointId .. "#"

			local tem = self._commonTab:addTabData(v.name, v, obj.root)

			self._emptyMap[obj.root] = false
			self._leafMap[v.viewname] = v

			if firstParam and not data and type(firstParam) == "string" and not string.nilorempty(firstParam) and firstParam == v.viewname then
				if self:checkCanOpen(v) then
					data = v
				end
			elseif not data and not firstParam and lastOpenBonusId ~= 0 and self:checkCanOpen(v) and (lastOpenBonusId == v.id or lastOpenBonusId == tacCfg.id) then
				data = v
			end
		end
	end

	if data then
		BounsModel.instance:setLastOpenBonusId(data.id)
	end

	self._commonTab:jumpTabByData(data)
end

function BonusView:_onPreClickCell(tabData)
	local data = tabData.data

	SevenDaysModel.instance.classTabIndex = 0

	if JackpotModel.instance.isDrawing then
		FloatWordMgr.instance:show("正在抽奖中")

		return true
	end

	BounsModel.instance:setLastOpenBonusId(data.id)

	return false
end

function BonusView:_onTabFilter(tabData)
	local data = tabData.data

	if self._emptyMap[tabData.root] then
		return true
	end

	if tabData.leaf > 0 then
		return not self:checkCanOpen(data)
	end

	return false
end

function BonusView:_onUpdateExtCell(view, cell, tabData, tag)
	local redPoint = goutil.findChild(cell, "redpoint")
	local newTag = goutil.findChild(cell, "newTag")
	local txtTag = goutil.findChildTextComponent(cell, "newTag/txtTag")
	local data = tabData.data
	local hasTag = not string.nilorempty(data.tagName)

	if self._curSelectData then
		GameUtil.SetActive(newTag, hasTag)

		if hasTag then
			GameUtil.setUIImageSpriteIdx(newTag, 2 - data.tagColor)

			txtTag.text = data.tagName
		end

		GameUtil.SetActive(redPoint, false)
		RedPointController.instance:unregRedPoint(redPoint)

		if checknumber(tabData.leaf) > 0 then
			RedPointController.instance:regRedPoint(redPoint, unpack(string.split(data.redpointId or "", "#")))
		else
			local cfg = BonusConfig.instance:getCfgByTab(data.tabId) or {}

			if #cfg == 1 then
				RedPointController.instance:regRedPoint(redPoint, unpack(string.split(data.redpointId or "", "#")))
			else
				local redStr = ""

				for i, v in ipairs(cfg) do
					if self:checkCanOpen(v) then
						redStr = redStr .. v.redpointId .. "#"
					end
				end

				RedPointController.instance:regRedPoint(redPoint, unpack(string.split(redStr or "", "#")))
			end
		end
	end
end

function BonusView:_onUpdateRight(tabData)
	if tabData == nil then
		self._curSelectData = nil

		self:showTabAt(self.container, "")

		return
	end

	local data = tabData.data

	self._curSelectData = data

	self:showTabAt(self.container)
	self:showTabAt(self.container, self._curSelectData.viewname, self._curSelectData.parameter)
	SurveyController.instance:reportBehavior(data.reportBehavior)
	goutil.setActive(self._bgGo, data.showBg)
end

function BonusView:_onViewTabChange(params)
	local viewName

	if params then
		viewName = params[1]
	end

	if not string.nilorempty(viewName) then
		local data = self._leafMap[viewName]

		if data then
			self._commonTab:jumpTabByData(data)
		end
	end
end

function BonusView:_checkSelectSurvey()
	if not RedPointModel.instance:isActive(RedPointModel.ID_SURVEY_LIST) then
		local tabData = self._commonTab:getCurrTabData()

		if tabData and tabData.data.viewname == ViewName.SurveylistView then
			return true
		end
	end

	return false
end

function BonusView:updateSurveyList()
	if self:_checkSelectSurvey() then
		self:_initScrollTab(nil)
	end
end

function BonusView:updateViewList()
	local tabData = self._commonTab:getCurrTabData()
	local data

	if tabData then
		data = tabData.data
	end

	self:_initScrollTab(nil)
	self._commonTab:jumpTabByData(data)
end

function BonusView:checkCanOpen(cfg)
	if BootstrapPjaqGameConfigMgr.isReview and checkbool(cfg.hideWithReview) then
		return false
	end

	if cfg.id == 37 then
		if FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
			return (RedPointModel.instance:isActive(751))
		else
			return false
		end
	end

	local pass = self:_checkSevensignViewPass(cfg)

	if pass then
		if cfg.checkParam == "passport" and cfg.viewname ~= ViewName.Passportshow2024View and not PassportModel.instance:checkIsActiveByFuncId(checknumber(cfg.parameter)) then
			return false
		end

		if not string.nilorempty(cfg.showTime) then
			local arr = string.split(cfg.showTime, "#")

			if not GameUtil.checkIsInTimePeriod(arr[1], arr[2]) then
				return false
			end
		end

		if cfg.viewname == ViewName.Dragonfullawake and (not self._curSelectData or self._curSelectData.id ~= cfg.id) then
			local actId = 106001
			local info = SevenDaysModel.instance:getInfo(actId)

			if not info then
				return false
			end

			local scoreMap = ExcellentClassConfig.instance:GetClsaaScoreCfgs(actId)

			if not info.gainStates then
				local gainStates = {}
				local gainCnt = #gainStates
				local scoreCnt = table.nums(scoreMap)
				local isGainStates = false

				if gainCnt == scoreCnt then
					isGainStates = true

					for i = 1, scoreCnt do
						if not gainStates[i] then
							isGainStates = false

							break
						end
					end
				end

				if isGainStates then
					local taskCfgs = ExcellentClassConfig.instance:GetClassAllTaskCfgs(actId)

					if not info.taskInfos then
						local taskInfos_kv = {}
						local allTaskGain = false

						for i, v in ipairs(info.taskInfos) do
							taskInfos_kv[v.taskId] = v
						end

						for i, v in ipairs(taskCfgs) do
							allTaskGain = true

							if v.tabID == 1 and (not taskInfos_kv[v.id] or not taskInfos_kv[v.id].gainPrize) then
								allTaskGain = false

								break
							end
						end

						if isGainStates and allTaskGain then
							return false
						end
					end
				end
			end
		end

		if cfg.viewname == ViewName.SurveylistView then
			if RedPointModel.instance:isActive(RedPointModel.ID_SURVEY_LIST) then
				return true
			else
				return false
			end
		end

		if cfg.viewname == ViewName.SevenSign then
			if RedPointModel.instance:isActive(RedPointModel.ID_SEVENSIGN2) then
				return true
			end
		elseif checknumber(cfg.funcId) > 0 and checknumber(cfg.isShow) ~= 1 then
			if FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
				return true
			end
		else
			return true
		end
	end

	return false
end

function BonusView:getFirstHasRedpointOrActive(cfgs)
	local firstCfg

	for i, v in ipairs(cfgs) do
		if checknumber(v.id) > 0 and self:checkCanOpen(v) then
			if firstCfg == nil then
				firstCfg = v
			end

			local redpointIds = string.split(v.redpointId or "", "#")

			for _, redpointId in ipairs(redpointIds) do
				if RedPointModel.instance:isActive(redpointId) then
					return v
				end
			end
		end
	end

	return firstCfg
end

function BonusView:_updateRedpoint()
	local tem = RedPointModel.instance:isActive(RedPointModel.ID_SEVENSIGN2)

	if self.lastRedState ~= tem then
		self.lastRedState = tem

		self:updateViewList()
	end
end

function BonusView:onEnterFinished()
	return
end

function BonusView:onExit()
	self._moveSequence:Kill(true)

	self._moveSequence = nil
end

function BonusView:onExitFinished()
	return
end

function BonusView:_onClickClose()
	if JackpotModel.instance.isDrawing then
		FloatWordMgr.instance:show("正在抽奖中")

		return
	end

	self:close()

	self._curSelectData = nil
end

function BonusView:_closeBonusView()
	self:_onClickClose()
end

function BonusView:_onClickHome()
	UIStateManager.instance:clear(true)
end

function BonusView:_checkSevensignViewPass(cfg)
	if (cfg.viewname == ViewName.SevenSign or cfg.viewname == ViewName.StarteamView) and NewhandwelfareModel.instance:isNewHandActivePlayer() then
		return false
	end

	return true
end

function BonusView:_setTipAnim()
	for i = 1, 2 do
		local moveUpTween = self._tipRect:DOAnchorPosY(self._startY + self._moveY, self._animTime):SetEase(DG.Tweening.Ease.Linear)
		local moveDownTween = self._tipRect:DOAnchorPosY(self._startY - self._moveY, self._animTime):SetEase(DG.Tweening.Ease.Linear)

		self._moveSequence:Append(moveUpTween)
		self._moveSequence:Append(moveDownTween)
	end

	local moveBackTween = self._tipRect:DOAnchorPosY(self._startY, self._animTime):SetEase(DG.Tweening.Ease.Linear)

	self._moveSequence:Append(moveBackTween)
	self._moveSequence:AppendInterval(self._animInterval)
	self._moveSequence:SetLoops(-1)
end

function BonusView:_onValueChanged()
	GameUtil.SetActive(self._tip, not self._commonTab:getScrollList():isShowFinishCell())
end

function BonusView:_onTrainerCourseGetInfoRes()
	self:updateViewList()
end

function BonusView:showTabAt(parent, childViewName, ...)
	if childViewName == ViewName.ExcellentClass and checknumber(RoleModel.instance:getUserId()) == 399799 then
		printError(">>>>>>>> excellentclass error log ")
	end

	BonusView.super.showTabAt(self, parent, childViewName, ...)
end

return BonusView
