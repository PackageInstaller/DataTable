-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkBattleStartCameraEffect.lua

module("logic.battle.battleflow.defaultwork.WorkBattleStartCameraEffect", package.seeall)

local M = class("WorkBattleStartCameraEffect", WorkBase)
local kCameraCode = BattleConst.START_CAMERA_CODE
local kWalkDuration = 0.5
local kWaitDuration = 0.5

function M:ctor()
	M.super.ctor(self)

	self._timelineTask = TimelineTask.New()
end

function M:onEnter(context)
	if BattleCampAdjustmentModel.instance:isBeforeCampAdjustmentGuideTriggerred() then
		self:onDone(WorkResult.Succeed)

		return
	end

	self:_getCurveAnimationSettings()

	local boardMgr = context.boardMgr
	local settingModel = context.settingModel
	local walkUnionIndexList = settingModel:getCameraWalkUnionIndexList()
	local duration = 0
	local sequence = DG.Tweening.DOTween.Sequence()

	for i, unionIndex in pairs(walkUnionIndexList) do
		local position = boardMgr:getCellPosition(unionIndex)

		if i == 1 then
			sequence:AppendInterval(kWaitDuration)

			duration = duration + kWaitDuration
		else
			sequence:Append(BattleCameraUtil.doFollowPosition(position.x, position.y, position.z, kWalkDuration))
			sequence:AppendInterval(kWaitDuration)

			duration = duration + kWalkDuration + kWaitDuration
		end
	end

	self._timelineTask:clear()
	self._timelineTask:addTask(duration, self._tChangeCamera, self)
	self._timelineTask:addTask(self._curveTime)
	self._timelineTask:addFinishListener(self._onFinishTask, self)
	self._timelineTask:start()
end

function M:onExit(isInterrupt)
	self._timelineTask:clear()
	WorkTriggerEnterDone:setUIPropertiesVisible(true)
end

function M:_getCurveAnimationSettings()
	local tcamera = VirtualCameraMgr.instance:getTemporaryCamera(kCameraCode)
	local settings = tcamera:getMainGO():GetComponent(typeof(AnimationCurveSettings))

	self._curveTime = 1.5
	self._animationCurve = nil

	if settings then
		self._animationCurve = settings:GetCurve()
		self._curveTime = settings:GetDuartion()
	end
end

function M:_tChangeCamera()
	local unionIndex = BattleCampAdjustmentModel.instance:getDefaultFocusUnionIndex()
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local position = boardMgr:getCellPosition(unionIndex)

	self._curStype = VirtualCameraMgr.instance:getBlendStyle()

	if self._animationCurve then
		VirtualCameraMgr.instance:setBlendCurve(self._animationCurve, self._curveTime)
	else
		if enableErrorLog then
			printError("没有配置镜头blend的AnimationCurve")
		end

		VirtualCameraMgr.instance:setBlendStyle(Cinemachine.CinemachineBlendDefinition.Style.EaseIn)
		VirtualCameraMgr.instance:setBlendDuration(self._curveTime)
	end

	local tcamera = VirtualCameraMgr.instance:getTemporaryCamera(kCameraCode)

	goutil.setActive(tcamera.mainGO, false)
	BattleCameraUtil.doFollowPosition(position.x, position.y, position.z, kWalkDuration)
end

function M:_onFinishTask()
	VirtualCameraMgr.instance:setBlendStyle(self._curStype)
	VirtualCameraMgr.instance:clearBlendCurve()
	VirtualCameraMgr.instance:releaseTemporaryCamera(kCameraCode)
	self:onDone(WorkResult.Succeed)
end

return M
