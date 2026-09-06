-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivitysmalljumpsummarythreeView.lua

module("logic.extensions.operationsummary.view.ActivitysmalljumpsummarythreeView", package.seeall)

local ActivitysmalljumpsummarythreeView = class("ActivitysmalljumpsummarythreeView", ActivityGrandSummaryView)

ActivitysmalljumpsummarythreeView.StoryKey = "ActivitysmalljumpsummarythreeView_PlayStory"

function ActivitysmalljumpsummarythreeView:_getSumActivityId()
	local key = self._viewPresentor.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))

		return
	end

	return data.activityId
end

function ActivitysmalljumpsummarythreeView:buildUI()
	ActivitysmalljumpsummarythreeView.super.buildUI(self)

	self._btnShowCol = goutil.findChild(self.mainGO, "btnShowCol")
	self._tweenPool = {}
end

function ActivitysmalljumpsummarythreeView:bindEvents()
	ActivitysmalljumpsummarythreeView.super.bindEvents(self)
end

function ActivitysmalljumpsummarythreeView:unbindEvents()
	ActivitysmalljumpsummarythreeView.super.unbindEvents(self)
end

function ActivitysmalljumpsummarythreeView:onEnter()
	ActivitysmalljumpsummarythreeView.super.onEnter(self)

	local actId = 31017

	if ActivityDefineController.instance:isInActivityTimeById(31, actId) and not OpSummaryModel.instance:getHaveGetInvitation(actId) then
		UIStateManager.instance:push(ViewName.InvitationCardDragonAncestorView, actId)
	end

	local activityId = self:_getSumActivityId()
end

function ActivitysmalljumpsummarythreeView:onExit()
	ActivitysmalljumpsummarythreeView.super.onExit(self)
	self:clearShowAnim()
	self:clearBtnShowCol()
end

function ActivitysmalljumpsummarythreeView:onUpdateUI()
	ActivitysmalljumpsummarythreeView.super.onUpdateUI(self)
	self:updateBtnShowCol()
end

function ActivitysmalljumpsummarythreeView:CreatActivity()
	ActivitysmalljumpsummarythreeView.super.CreatActivity(self)

	local btnShowKeyList = {}
	local parent = self._btnShowCol.transform

	for idx = 1, parent.childCount do
		local mainGo = parent:GetChild(idx - 1)

		table.insert(btnShowKeyList, self:getPoolKey(mainGo.name))
	end

	if self._animClipsPool == nil then
		self._animClipsPool = {}
	end

	for _, btnShowKey in ipairs(btnShowKeyList) do
		local infoList = {}

		for _, cell in ipairs(self._actCellList) do
			if btnShowKey == cell.data.cellName then
				local info = {
					cell = cell,
					isInShowTime = OpSummaryController.instance:isInShowTimeAsTab(cell.data.id),
					isInActTime = OpSummaryController.instance:isInActTimeAsTab(cell.data.id),
					isUnlock = OpSummaryController.instance:isUnlockAsTab(cell.data.id)
				}

				table.insert(infoList, info)
			end
		end

		table.sort(infoList, function(a, b)
			return a.cell.data.id < b.cell.data.id
		end)

		if not self._animClipsPool[btnShowKey] then
			local var_8_0 = {
				infoList = infoList
			}

			var_8_0.showType = self._animClipsPool[btnShowKey].showType or false
			var_8_0.isNeedAnim = self._animClipsPool[btnShowKey].isNeedAnim or false

			if self._animClipsPool[btnShowKey].showType then
				var_8_0.curIdx = #infoList or 1
			end

			self._animClipsPool[btnShowKey] = var_8_0
		end
	end
end

function ActivitysmalljumpsummarythreeView:getPoolKey(cellName)
	return cellName .. "_cell"
end

function ActivitysmalljumpsummarythreeView:updateActivity()
	ActivitysmalljumpsummarythreeView.super.updateActivity(self)

	for key, animClips in pairs(self._animClipsPool) do
		for _, info in ipairs(animClips.infoList) do
			GameUtil.SetActive(info.cell.mainGo, GameUtil.GetActive(info.cell.mainGo) and animClips.showType)
		end
	end
end

function ActivitysmalljumpsummarythreeView:updateBtnShowCol()
	local parent = self._btnShowCol.transform

	self._btnShowList = {}

	for idx = 1, parent.childCount do
		local mainGo = parent:GetChild(idx - 1)
		local redPoint = goutil.findChild(mainGo, "redpoint")
		local circle = goutil.findChild(mainGo, "circle")
		local btnShowKey = self:getPoolKey(mainGo.name)
		local infoList = self._animClipsPool[btnShowKey].infoList

		self._btnShowList[btnShowKey] = mainGo

		if circle then
			GameUtil.SetActive(circle, self._animClipsPool[btnShowKey].showType)
		end

		GameUtil.SetActive(redPoint, false)
		RedPointController.instance:unregRedPoint(redPoint)

		local redIdList = {}

		for _, info in ipairs(infoList) do
			local cell = info.cell
			local isUnlcok = OpSummaryController.instance:isUnlockAsTab(cell.data.id)

			if isUnlcok then
				if not string.nilorempty(cell.data.redpointId) then
					for _, redId in ipairs(string.split(cell.data.redpointId or "", "#")) do
						table.insert(redIdList, redId)
					end
				end

				table.insert(redIdList, OpSummaryController.instance:getRedIdAsTabNew(cell.data.id))
			end
		end

		RedPointController.instance:regRedPoint(redPoint, unpack(redIdList))

		local taskCfg = OperationSummaryConfig.instance:getTaskDetailsCfg(self._activityId)

		for _, info in ipairs(infoList) do
			local cell = info.cell
			local isNeedRed = false

			for _, taskData in pairs(taskCfg) do
				if cell.data.showType ~= 0 and cell.data.showType == taskData.showType then
					local isUnlcok = OpSummaryController.instance:isUnlockAsTab(cell.data.id)
					local isCanGet = OpSummaryController.instance:isCanGetPrizeAsTask(taskData.id)

					if isUnlcok and isCanGet then
						isNeedRed = true

						break
					end
				end
			end

			if isNeedRed then
				RedPointController.instance:unregRedPoint(cell.redPoint)
				GameUtil.SetActive(redPoint, true)

				break
			end
		end

		GameUtil.addClickHandler(mainGo, GameUtil.handler(self.onClickBtnShow, self, mainGo))
	end
end

function ActivitysmalljumpsummarythreeView:clearBtnShowCol()
	local parent = self._btnShowCol.transform

	for idx = 1, parent.childCount do
		local mainGo = parent:GetChild(idx - 1)
		local redPoint = goutil.findChild(mainGo, "redpoint")

		RedPointController.instance:unregRedPoint(redPoint)
		GameUtil.rmClickHandler(mainGo)
	end
end

function ActivitysmalljumpsummarythreeView:onClickBtnShow(go)
	local key = self:getPoolKey(go.name)

	if self._animClipsPool[key] == nil then
		return
	end

	if self._animClipsPool[key].isNeedAnim == true then
		return
	end

	self._animClipsPool[key].isNeedAnim = true

	self:playeCellsShowAnim()
end

function ActivitysmalljumpsummarythreeView:playeCellsShowAnim()
	removetimer(self.updateTime, self)
	settimer(0.1, self.updateTime, self, true)
end

function ActivitysmalljumpsummarythreeView:updateTime()
	local doNum = 0

	for key, animClips in pairs(self._animClipsPool) do
		if animClips.isNeedAnim then
			local curIdx = animClips.curIdx
			local len = #animClips.infoList
			local delta = animClips.showType and -1 or 1
			local endIdx = animClips.showType and 1 or len

			for i = curIdx, endIdx, delta do
				if animClips.infoList[i].isInShowTime then
					curIdx = i

					break
				end
			end

			local cell = animClips.infoList[curIdx].cell

			if cell then
				doNum = doNum + 1

				if animClips.showType == false then
					local function callBack()
						GameUtil.setLocalScale(cell.mainGo, 1, 1, 1)
					end

					self:doScaleAnim(cell.mainGo, 1.2, callBack)
					GameUtil.SetActive(cell.mainGo, true)
				else
					local function callBack()
						GameUtil.SetActive(cell.mainGo, false)
						GameUtil.setLocalScale(cell.mainGo, 1, 1, 1)
					end

					self:doScaleAnim(cell.mainGo, 0.8, callBack)
				end

				if len < curIdx + delta or curIdx + delta < 1 then
					local mainGo = self._btnShowList[key]

					if mainGo then
						local circle = goutil.findChild(mainGo, "circle")

						if circle then
							GameUtil.SetActive(circle, not self._animClipsPool[key].showType)
						end
					end

					self._animClipsPool[key].curIdx = curIdx
					self._animClipsPool[key].isNeedAnim = false
					self._animClipsPool[key].showType = not self._animClipsPool[key].showType
				else
					self._animClipsPool[key].curIdx = Mathf.Clamp(curIdx + delta, 1, len)
				end
			end
		end
	end

	if doNum == 0 then
		removetimer(self.updateTime, self)

		return
	end
end

function ActivitysmalljumpsummarythreeView:doScaleAnim(go, scale, callBack)
	self:clearAnimByGo(go)

	self._tweenPool[go] = go.transform:DOScale(Vector3.New(scale, scale, scale), 0.2):SetEase(DG.Tweening.Ease.InQuad):SetLoops(2, DG.Tweening.LoopType.Yoyo):OnComplete(callBack)
end

function ActivitysmalljumpsummarythreeView:clearAnimByGo(go)
	if self._tweenPool[go] then
		self._tweenPool[go]:Kill(true)
	end
end

function ActivitysmalljumpsummarythreeView:clearShowAnim()
	removetimer(self.updateTime, self)

	for key, animClips in pairs(self._animClipsPool) do
		self._animClipsPool[key].isNeedAnim = false

		for _, info in ipairs(animClips.infoList) do
			self:clearAnimByGo(info.cell.mainGo)
		end
	end
end

function ActivitysmalljumpsummarythreeView:_playStory(key, id)
	GameUtil.saveUserData(key, true)

	if checknumber(id) > 0 then
		StoryController.instance:startStory(checknumber(id))
	end
end

return ActivitysmalljumpsummarythreeView
