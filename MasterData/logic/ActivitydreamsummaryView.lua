-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivitydreamsummaryView.lua

module("logic.extensions.operationsummary.view.ActivitydreamsummaryView", package.seeall)

local ActivitydreamsummaryView = class("ActivitydreamsummaryView", ActivitySmallSummaryThreeView)

function ActivitydreamsummaryView:buildUI()
	ActivitydreamsummaryView.super.buildUI(self)

	self._flyObjTween = self:getGo("flyObj"):GetComponent(UnityTweensType.TweenPosition)

	self._flyObjTween:Stop()

	for i = 1, 4 do
		local go = self:getGo("cell" .. i)

		if go then
			goutil.setActive(go, false)
		end
	end

	self._conGo = self:getGo("flyObj/con")
end

function ActivitydreamsummaryView:onExit()
	ActivitydreamsummaryView.super.onExit(self)

	self._targetCellData = nil

	self._flyObjTween:RemoveListener()
	self._flyObjTween:Stop()

	self._tickObjs = {}

	removetimer(self._tick, self)

	self._isFlying = false

	RoleObjectPool.instance:removeRole(self._roleObj)

	self._roleObj = nil
end

function ActivitydreamsummaryView:onEnter()
	self._tickObjs = {}

	ActivitydreamsummaryView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SeekFoodInfoRes, self._onSeekFoodInfoRes, self)

	if self._lastActId ~= self.activityId then
		self._lastActId = self.activityId
		self._targetCellTr = nil
	end

	self._roleObj = RoleObjectPool.instance:addSpineToParent(self._roleObj, ActivitydreamsummaryViewPresentor.FlyNuo, self._conGo, 0.1)
	self._useFlyObj = self.activityId ~= 17076

	self:_startMoveToTarget()
	self:_initFlyObjTransform()
	self:_initFlyObjActive()
	self:_checkSendGetFoodInfoMsg()
end

function ActivitydreamsummaryView:_getSumActivityId()
	local actId = self:getFirstParam()

	return checknumber(actId)
end

function ActivitydreamsummaryView:onClickActivityCell(cell, data, ignorMove)
	if not OpSummaryController.instance:isInActTimeAsTab(data.id) then
		FloatWordMgr.instance:show("不在开放时间内噢~")

		return
	end

	if self._useFlyObj and not ignorMove then
		if self._isFlying then
			FloatWordMgr.instance:show("正在飞翔")

			return
		end

		self._targetCellData = {
			cell = cell,
			data = data
		}
		self._flyObjTween.from = self._flyObjTween.transform.position
		self._targetCellTr = cell.mainGo.transform

		self:_startMoveToTarget()

		return
	end

	SurveyController.instance:reportBehavior(data.reportBehavior)

	if data.paramObj and data.paramObj.story then
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, data.paramObj.story)
	end

	if not string.nilorempty(data.gotoStr) then
		GotoMgr.gotoByString(data.gotoStr)
	elseif checknumber(data.funcId) > 0 then
		if string.nilorempty(data.params) then
			FuncOpenController.instance:openFunc(data.funcId)
		else
			local arr = string.split(data.params, "#")

			FuncOpenController.instance:openFunc(data.funcId, unpack(arr))
		end
	elseif not string.nilorempty(data.viewname) then
		FuncOpenController.instance:openFuncByViewName(data.viewname)
	end

	OpSummaryController.instance:saveRedIdAsTabNew(data.id)
end

function ActivitydreamsummaryView:updateActivityCell(cell, notUpdateBase)
	self:_removeTickObj(cell.txtTime)

	if not notUpdateBase then
		ActivitydreamsummaryView.super.updateActivityCell(self, cell)
	end

	self:_updateActivityCellWithFood(cell.data.paramObj, cell)
end

function ActivitydreamsummaryView:_updateActivityCellWithFood(paramObj, cell)
	if not paramObj or not paramObj.activityId or not paramObj.foodId then
		return
	end

	local cfg = SeekFoodConfig.instance:getSfFoodCfg(paramObj.activityId)

	if not cfg then
		return
	end

	local foodCfg = SeekFoodConfig.instance:getSfFoodData(paramObj.activityId, paramObj.foodId)

	GameUtil.SetActive(cell.time, foodCfg)

	if not foodCfg then
		return
	end

	local matCfgs = SeekFoodConfig.instance:getSfMatCfg(paramObj.activityId, paramObj.foodId)
	local normalCount = #matCfgs
	local finishCount = #matCfgs
	local maxCollectEndTime = 0
	local nowTime = ServerTime.now()

	for i, v in ipairs(matCfgs) do
		local state = SeekFoodModel.instance:getMaterialState(paramObj.foodId, v.materialId)

		if state == SeekFoodModel.MatState.Normal then
			normalCount = normalCount - 1
		end

		if state == SeekFoodModel.MatState.Collecting then
			local endTimeMs = SeekFoodModel.instance:getEndTimeStampOfMat(paramObj.foodId, v.materialId)
			local endTimeSec = checknumber(endTimeMs) / 1000

			if maxCollectEndTime < endTimeSec then
				maxCollectEndTime = endTimeSec
			end
		end

		if state == SeekFoodModel.MatState.HasFinishCollected or state == SeekFoodModel.MatState.CanFinishCollect then
			finishCount = finishCount - 1
		end
	end

	if maxCollectEndTime - nowTime > 0 then
		self:_addTickObj(cell.txtTime, math.ceil(maxCollectEndTime))
	else
		cell.txtTime.text = finishCount <= 0 and "已集齐" or "今日未采集"
	end
end

function ActivitydreamsummaryView:_startMoveToTarget()
	if self._targetCellTr then
		self:_startMove()
	else
		self._flyObjTween:Stop()

		if self.cfg_task_items then
			for k, data in pairs(self.cfg_task_items) do
				local go = goutil.findChild(self.activityContent, string.format("%s_%s", data.cellName, data.id))

				if go then
					self._targetCellTr = go.transform

					local x, y, z = Framework.TransformUtil.GetPos(self._targetCellTr, 0, 0, 0)
					local v = Vector3.New(x, y, z)

					Framework.TransformUtil.SetPos(self._flyObjTween.transform, x, y, z)

					self._flyObjTween.from = v

					self:_startMoveToTarget()

					break
				end
			end
		end
	end
end

function ActivitydreamsummaryView:_startMove()
	self._isFlying = true

	local x, y, z = Framework.TransformUtil.GetPos(self._targetCellTr, 0, 0, 0)

	self._flyObjTween.to = Vector3.New(x, y, z)
	self._flyObjTween.time = Vector3.Distance(self._flyObjTween.to, self._flyObjTween.from)
	self._flyObjTween.time = math.max(self._flyObjTween.time, 0.5)

	self._flyObjTween:AddListener(self._moveToTargetFinish, self)
	self._flyObjTween:Begin()
end

function ActivitydreamsummaryView:_moveToTargetFinish()
	self._isFlying = false

	if self._targetCellData then
		self._flyObjTween.from = self._flyObjTween.to

		self:onClickActivityCell(self._targetCellData.cell, self._targetCellData.data, true)
	end
end

function ActivitydreamsummaryView:_initFlyObjTransform()
	if not self._targetCellTr and self._actCellList and self._actCellList[1] then
		self._targetCellTr = self._actCellList[1].mainGo.transform

		local x, y, z = Framework.TransformUtil.GetPos(self._targetCellTr, 0, 0, 0)

		Framework.TransformUtil.SetPos(self._flyObjTween.transform, x, y, 0)

		self._flyObjTween.from = Vector3.New(x, y, z)
	end
end

function ActivitydreamsummaryView:_initFlyObjActive()
	goutil.setActive(self._flyObjTween.gameObject, self._useFlyObj)
end

function ActivitydreamsummaryView:_checkSendGetFoodInfoMsg()
	for k, v in pairs(self.cfg_task_items) do
		if v.paramObj and v.paramObj.activityId and v.paramObj.foodId then
			local foodCfg = SeekFoodConfig.instance:getSfFoodData(v.paramObj.activityId, v.paramObj.foodId)

			if foodCfg then
				SeekFoodController.instance:sendPM_SeekFoodInfoReq(v.paramObj.activityId)

				break
			end
		end
	end
end

function ActivitydreamsummaryView:_onSeekFoodInfoRes()
	self:_onlyUpdateActivity()
end

function ActivitydreamsummaryView:_addTickObj(txtComp, endTime)
	self._tickObjs[txtComp] = endTime

	settimer(1, self._tick, self, true)
	self:_tick()
end

function ActivitydreamsummaryView:_removeTickObj(txtComp)
	self._tickObjs[txtComp] = nil

	if table.nums(self._tickObjs) <= 0 then
		removetimer(self._tick, self)
	end
end

function ActivitydreamsummaryView:_tick()
	local now = ServerTime.now()
	local leftTime = 0

	for txtComp, endTime in pairs(self._tickObjs) do
		leftTime = endTime - now

		if endTime - now <= 0 then
			self:_removeTickObj(txtComp)
			self:_onlyUpdateActivity()

			return
		end

		local h, m, s = GameUtil.getTimeHHMMSS(leftTime)

		txtComp.text = string.format("%02d:%02d:%02d", h, m, s)
	end
end

function ActivitydreamsummaryView:_onlyUpdateActivity()
	for _, cell in pairs(self._actCellList or {}) do
		self:updateActivityCell(cell, true)
	end
end

function ActivitydreamsummaryView:_isIconSetNativeSize(itemCfg)
	if itemCfg.paramObj and itemCfg.paramObj.setNativeSize then
		return true
	end
end

return ActivitydreamsummaryView
