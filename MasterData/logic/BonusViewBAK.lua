-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/BonusViewBAK.lua

module("logic.extensions.bonus.view.BonusViewBAK", package.seeall)

local BonusViewBAK = class("BonusViewBAK", ViewComponent)

BonusViewBAK.MainCellSizeY = 75
BonusViewBAK.SubCellSizeY = 65
BonusViewBAK.ReduceSize = 10

local Event_Name = "bonusviewchangetab"

function BonusViewBAK:ctor()
	BonusViewBAK.super.ctor(self)
end

function BonusViewBAK:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
end

function BonusViewBAK:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnHome:RemoveClickListener()
end

function BonusViewBAK:buildUI()
	BonusViewBAK.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
	self._btnHome = self:getBtn("btn_home")
	self.container = self:getGo("container")
	self.ScrollView = self:getGo("ScrollView")
	self.BtnCell = self:getGo("BtnCell")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))

	self._tableview:regGetCellSize(function(view, index)
		return self:_cellSize(view, index)
	end)
	self._tableview:regReloadFinish(function()
		self:_onReloadFinish()
	end)
	self._tableview:regValueChanged(GameUtil.handler(self._onValueChanged, self))

	self._dropLineTr = goutil.findChild(self.mainGO, "tableview/Nego_Viewport/Nego_Content/dropLine").transform
	self._tabContent = goutil.findChild(self.mainGO, "tableview/Nego_Viewport/Nego_Content").transform
	self._dropLineV2 = Vector2.New(141, 0)
	self._dropLineTr.sizeDelta = self._dropLineV2
	self._tip = self:getGo("tip")
	self._tipRect = self:getGo("tip"):GetComponent(goutil.Type_RectTransform)
end

function BonusViewBAK:destroyUI()
	self._curViewDatas = nil

	RedPointController.instance:RemoveViewRedpointInfo(self._viewPresentor.viewName)
end

function BonusViewBAK:onEnter()
	self.addGEvent(self, TrainerCourseNewAgent.PM_TrainerCourseGetInfoRes, self._onTrainerCourseGetInfoRes, self)
	self.addGEvent(self, "UpdataExcellentClassTask", self._onTrainerCourseGetInfoRes, self)

	self._isOpen = true

	self:initList()
	self:_checkSelectSurvey()

	local curData = self:_getFirstActiveData()

	self._curRoot = nil

	self:_onClickView(curData)
	self._tableview:refresh()

	for i, v in ipairs(self._curViewDatas or {}) do
		if checknumber(curData.id) == checknumber(v.id) then
			self._tableview:MoveCellInView(i - 1, false)
		end
	end

	GlobalDispatcher:addListener(GlobalNotify.closeBonusView, self._closeBonusView, self)

	self.lastRedState = RedPointModel.instance:isActive(RedPointModel.ID_SEVENSIGN2)

	self.addGEvent(self, GlobalNotify.RedPointUpdate, self._updateRedpoint, self)
	self.addGEvent(self, GlobalNotify.BounsRedPointUpdate, self._updateRedpoint, self)
	self.addGEvent(self, GlobalNotify.Passport_ActIds_Update, self.updateViewList, self)
	self.addGEvent(self, GlobalNotify.SURVEY_LIST_INFO_UPDATE, self.updateSurveyList, self)
	PassportController.instance:sendAndGetPassActive()

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
	GlobalDispatcher:addListener(Event_Name, self._onViewTabChange, self)
end

function BonusViewBAK:_onViewTabChange(params)
	local viewName

	if params then
		viewName = params[1]
	end

	if not string.nilorempty(viewName) then
		local isFound = false
		local arr = {}
		local tagCfgs = BonusConfig.instance:getTabCfg()

		for i, tacCfg in ipairs(tagCfgs) do
			tacCfg.redpointId = ""

			local cfg = BonusConfig.instance:getCfgByTab(tacCfg.tabId) or {}
			local tem = {}

			for j, v in ipairs(cfg) do
				if self:checkCanOpen(v) then
					if v.viewname == viewName then
						self._isOpen = true
						self._curRoot = tacCfg.tabId
						self._curSelectData = v
						isFound = true
					end

					table.insert(tem, v)
				end
			end

			if #tem > 0 then
				table.insert(arr, tacCfg)

				if self._isOpen and self._curRoot == tacCfg.tabId then
					for k, v in ipairs(tem) do
						table.insert(arr, v)
					end
				end
			end
		end

		if isFound then
			self._curViewDatas = arr

			self:showTabAt(self.container)
			self:showTabAt(self.container, self._curSelectData.viewname, self._curSelectData.parameter)
			self._tableview:reloadData(self._curViewDatas)

			for i, v in ipairs(self._curViewDatas or {}) do
				if checknumber(self._curSelectData.id) == checknumber(v.id) then
					self._tableview:MoveCellInView(i - 1, false)
				end

				if self._curRoot == checknumber(v.tabId) then
					self._cellIdx = i - 1
				end
			end

			self:_onReloadFinish()
		end
	end
end

function BonusViewBAK:_checkSelectSurvey()
	if not RedPointModel.instance:isActive(RedPointModel.ID_SURVEY_LIST) and self._curSelectData and self._curSelectData.viewname == ViewName.SurveylistView then
		self._curSelectData = nil

		return true
	end

	return false
end

function BonusViewBAK:updateSurveyList()
	if self:_checkSelectSurvey() then
		local curData = self:_getFirstActiveData()

		self._curRoot = nil

		self:_onClickView(curData)
	end
end

function BonusViewBAK:updateViewList()
	self._curViewDatas = self:getViewList()

	self._tableview:reloadData(self._curViewDatas)
	self:_updateScrollBg(self:_getSelectedIndex(), self._curRoot, self._isOpen)
end

function BonusViewBAK:getCfgs()
	return BonusConfig.instance:getCfgs()
end

function BonusViewBAK:initList()
	self.allList = {}
	self.onlyoneTab = {}

	local tagCfgs = BonusConfig.instance:getTabCfg()

	for i, tacCfg in ipairs(tagCfgs) do
		tacCfg.redpointId = ""

		local cfg = BonusConfig.instance:getCfgByTab(tacCfg.tabId) or {}

		if #cfg == 1 then
			self.onlyoneTab[tacCfg.tabId] = true
		else
			table.insert(self.allList, tacCfg)
		end

		for i, v in ipairs(cfg) do
			tacCfg.redpointId = tacCfg.redpointId .. v.redpointId .. "#"

			table.insert(self.allList, v)
		end
	end
end

function BonusViewBAK:getViewList()
	local arr = {}
	local tagCfgs = BonusConfig.instance:getTabCfg()

	for i, tacCfg in ipairs(tagCfgs) do
		tacCfg.redpointId = ""

		local cfg = BonusConfig.instance:getCfgByTab(tacCfg.tabId) or {}
		local tem = {}

		for j, v in ipairs(cfg) do
			if self:checkCanOpen(v) then
				tacCfg.redpointId = tacCfg.redpointId .. v.redpointId .. "#"

				table.insert(tem, v)
			end
		end

		if #tem > 0 then
			table.insert(arr, tacCfg)

			if self._isOpen and self._curRoot == tacCfg.tabId then
				for k, v in ipairs(tem) do
					table.insert(arr, v)
				end
			end
		end
	end

	return arr
end

function BonusViewBAK:checkCanOpen(cfg)
	if BootstrapPjaqGameConfigMgr.isReview and checkbool(cfg.hideWithReview) then
		return false
	end

	local pass = self:_checkSevensignViewPass(cfg)

	if pass then
		if cfg.tab == 13 and cfg.viewname ~= ViewName.Passportshow2024View and not PassportModel.instance:checkIsActiveByFuncId(checknumber(cfg.parameter)) then
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

function BonusViewBAK:_getFirstActiveData()
	local cfgs = self.allList
	local firstParam = self:getFirstParam()

	if firstParam ~= nil then
		if string.nilorempty(firstParam) and not string.nilorempty(SevenDaysModel.instance.openBonusName) then
			firstParam = SevenDaysModel.instance.openBonusName
		end

		SevenDaysModel.instance.openBonusName = nil

		if type(firstParam) == "string" and not string.nilorempty(firstParam) then
			for i, cfg in ipairs(cfgs) do
				if cfg and cfg.viewname == firstParam and self:_checkSevensignViewPass(cfg) then
					return cfg
				end
			end
		end
	elseif self._curSelectData then
		return self._curSelectData
	end

	return (self:getFirstHasRedpointOrActive(cfgs))
end

function BonusViewBAK:getFirstHasRedpointOrActive(cfgs)
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

function BonusViewBAK:_updateRedpoint()
	local tem = RedPointModel.instance:isActive(RedPointModel.ID_SEVENSIGN2)

	if self.lastRedState ~= tem then
		self.lastRedState = tem

		self:updateViewList()
	end
end

function BonusViewBAK:onEnterFinished()
	return
end

function BonusViewBAK:onExit()
	self._tableview:dispose()
	self._moveSequence:Kill(true)

	self._moveSequence = nil

	GlobalDispatcher:removeListener(Event_Name, self.onViewTabChange, self)
end

function BonusViewBAK:onExitFinished()
	return
end

function BonusViewBAK:_updateCell(view, cell, data)
	local imgBg = goutil.findChild(cell, "imgBg"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgSmallBg = goutil.findChild(cell, "imgSmallBg"):GetComponent(ComponentType.UIImageSpriteChange)
	local btnRoot = Framework.ButtonAdapter.GetFrom(cell.gameObject, "imgBg")
	local btnLeaf = Framework.ButtonAdapter.GetFrom(cell.gameObject, "imgSmallBg")
	local tag = goutil.findChild(cell, "tag")
	local redPoint = goutil.findChild(cell, "dot")
	local txtSel = goutil.findChildTextComponent(cell, "text")
	local txtTag = goutil.findChildTextComponent(tag, "Text")
	local imgTagChange = tag:GetComponent("UIImageSpriteChange")
	local txtChange = txtSel:GetComponent(ComponentType.UITextColorChange)

	txtSel.text = checknumber(data.id) > 0 and data.name or data.tabName

	local hasTag = not string.nilorempty(data.tagName)

	if self._curSelectData then
		local isSelected = not (self._curSelectData.id ~= data.id or data.id <= 0 or data.tabId ~= nil)

		goutil.setActive(tag, hasTag)

		if hasTag then
			imgTagChange:SetState(data.tagColor - 1)

			txtTag.text = data.tagName
		end

		local isSelectedRoot = self._curRoot == data.tabId
		local state = isSelected and 1 or 0

		imgBg:SetState(isSelectedRoot and 1 or 0)
		imgSmallBg:SetState(state)
		goutil.setActive(imgBg.gameObject, data.tabId)
		goutil.setActive(imgSmallBg.gameObject, not data.tabId)

		if not data.tabId then
			txtChange:SetState(isSelected and 3 or 2)
		else
			txtChange:SetState(isSelectedRoot and 1 or 0)
		end

		if isSelectedRoot then
			self._rootCell = {
				cell = cell,
				data = data
			}
		end

		RedPointController.instance:unregRedPoint(redPoint)

		if checknumber(data.id) > 0 then
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

		GameUtil.addClickHandler(btnRoot, GameUtil.handler(self._onClickView, self, data))
		GameUtil.addClickHandler(btnLeaf, GameUtil.handler(self._onClickView, self, data))

		if isSelectedRoot and data.tabId then
			self._cellIdx = cell.index
		end
	end
end

function BonusViewBAK:_clearTableview(cell)
	local imgBg = goutil.findChild(cell, "imgBg")
	local imgSmallBg = goutil.findChild(cell, "imgSmallBg")

	GameUtil.rmClickHandler(imgBg)
	GameUtil.rmClickHandler(imgSmallBg)

	local redPoint = goutil.findChild(cell, "imgPoint")

	RedPointController.instance:unregRedPoint(redPoint)
end

function BonusViewBAK:_onClickClose()
	if JackpotModel.instance.isDrawing then
		FloatWordMgr.instance:show("正在抽奖中")

		return
	end

	UIStateManager.instance:popByName(self._viewPresentor.viewName)

	self._curSelectData = nil
end

function BonusViewBAK:_onClickView(data)
	SevenDaysModel.instance.classTabIndex = 0

	if JackpotModel.instance.isDrawing then
		FloatWordMgr.instance:show("正在抽奖中")

		return
	end

	local funcId

	if checknumber(data.id) < 0 then
		local list = BonusConfig.instance:getCfgByTab(data.tabId)
		local isOpen = false

		for i, v in ipairs(list) do
			isOpen = isOpen or self:checkCanOpen(v)

			if not isOpen then
				funcId = v.funcId
			end
		end

		if not isOpen then
			local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)
			local tips = FuncOpenController.instance:getLockTips(cfg)

			FloatWordMgr.instance:show(tips)

			return
		end

		if self._curRoot ~= data.tabId then
			self._curRoot = data.tabId
			self._isOpen = true
			self._curSelectData = self:getFirstHasRedpointOrActive(list)
		else
			self._isOpen = not self._isOpen
		end
	else
		funcId = data.funcId

		if data.funcId and funcId > 0 and data.isShow ~= 1 then
			local isOpen = FuncOpenModel.instance:getFuncIsOpen(funcId)

			if not isOpen then
				local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)
				local tips = FuncOpenController.instance:getLockTips(cfg)

				FloatWordMgr.instance:show(tips)

				return
			end
		end

		self._curSelectData = data
		self._curRoot = data.tab
	end

	self._curViewDatas = self:getViewList()

	self:showTabAt(self.container)
	self:showTabAt(self.container, self._curSelectData.viewname, self._curSelectData.parameter)
	self._tableview:reloadData(self._curViewDatas)
	self:_updateScrollBg(self:_getSelectedIndex(), self._curRoot, self._isOpen)
	SurveyController.instance:reportBehavior(data.reportBehavior)
end

function BonusViewBAK:_closeBonusView()
	self:_onClickClose()
end

function BonusViewBAK:_onClickHome()
	UIStateManager.instance:clear(true)
end

function BonusViewBAK:_checkSevensignViewPass(cfg)
	if (cfg.viewname == ViewName.SevenSign or cfg.viewname == ViewName.StarteamView) and NewhandwelfareModel.instance:isNewHandActivePlayer() then
		return false
	end

	return true
end

function BonusViewBAK:_getSelectedIndex()
	local index = 0

	if self._curSelectData then
		for i, v in ipairs(self._curViewDatas) do
			if self._curRoot == v.tabId then
				index = i

				break
			end
		end
	end

	return index
end

function BonusViewBAK:_getChildCellCount()
	local count = 0

	if self._curSelectData then
		for i, v in ipairs(self._curViewDatas) do
			if self._curRoot == v.tab then
				count = count + 1
			end
		end
	end

	return count
end

function BonusViewBAK:_updateScrollBg(index, tabId, isUnfold)
	do return end

	local posY = 0 - (self._cellOffsetY + (index - 1) * (self._cellHeight + self._cellSpaceingY))

	posY = posY - 10

	local height = 0

	if isUnfold then
		local count = self:_getChildCellCount()

		height = count * (self._cellHeight + self._cellSpaceingY) + self._cellHeight
	end

	local x, y = Framework.TransformUtil.GetAnchoredPos(self._dropLineRectTrans, 0, 0)

	Framework.TransformUtil.SetAnchoredPos(self._dropLineRectTrans, x, posY)
	goutil.setHeight(self._dropLineRectTrans, height)
end

function BonusViewBAK:_cellSize(view, index)
	local data = self._curViewDatas[index + 1]

	if data.tabId then
		return 100, BonusViewBAK.MainCellSizeY
	end

	return 100, BonusViewBAK.SubCellSizeY
end

function BonusViewBAK:_onReloadFinish()
	local cell = self._tableview:getView():GetCellAtIndex(self._cellIdx)

	if cell then
		local dropLineSizeY = 0

		if self._isOpen then
			local data = self._curViewDatas[self._cellIdx + 1]
			local cfg = BonusConfig.instance:getCfgByTab(data.tabId) or {}
			local count = 0

			for j, v in ipairs(cfg) do
				if self:checkCanOpen(v) then
					count = count + 1
				end
			end

			if count > 0 then
				dropLineSizeY = BonusViewBAK.MainCellSizeY + count * BonusViewBAK.SubCellSizeY - BonusViewBAK.ReduceSize
			end
		end

		self._dropLineV2.y = dropLineSizeY
		self._dropLineTr.sizeDelta = self._dropLineV2
		self._cellIdx = cell.index

		if dropLineSizeY > 0 then
			local cx, cy = Framework.TransformUtil.GetAnchoredPos(cell.transform, 0, 0)

			GameUtil.setAnchoredPos(self._dropLineTr.gameObject, 8.13, cy + 22)
		end
	end
end

function BonusViewBAK:_setTipAnim()
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

function BonusViewBAK:_onValueChanged()
	GameUtil.SetActive(self._tip, not self._tableview:isShowFinishCell())
end

function BonusViewBAK:_onTrainerCourseGetInfoRes()
	if self._curSelectData then
		self:_onClickView(self._curSelectData)
	end
end

return BonusViewBAK
