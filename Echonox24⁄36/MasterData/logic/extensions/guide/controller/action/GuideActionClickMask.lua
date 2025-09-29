-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionClickMask.lua

module("logic.extensions.guide.controller.action.GuideActionClickMask", package.seeall)

local GuideActionClickMask = class("GuideActionClickMask", BaseGuideAction)

function GuideActionClickMask:ctor(guideId, stepId, guideStepCO)
	GuideActionClickMask.super.ctor(self, guideId, stepId, guideStepCO)

	self._guideControlType = guideStepCO.guideControlType
	self._guideCompleteType = guideStepCO.completeType
	self._params = guideStepCO.guideControlParam
end

function GuideActionClickMask:onEnter(context)
	self._finishAttrSelect = false
	self._clickFunction = false

	StoryDispatcher:addEventListener(StoryNotifyName.OnFinishAttrOption, self._onSelectAttrFinish, self)
	GlobalDispatcher:addEventListener(EventType.CLICK_SCENE_OBJECT, self._onClickSceneObject, self)
	GuideActionClickMask.super.onEnter(self, context)
	GuideController.instance:openGuideView(self.guideStepCO, self._onClickTarget, self, self._clickGuideFun)
end

function GuideActionClickMask:onExit()
	StoryDispatcher:removeEventListener(StoryNotifyName.OnFinishAttrOption, self._onSelectAttrFinish, self)
	GlobalDispatcher:removeEventListener(EventType.CLICK_SCENE_OBJECT, self._onClickSceneObject, self)

	if self._guideButtonAdapter then
		self._guideButtonAdapter:RemoveClickListener()
	end

	removetimer(self._waitUILoadEvent, self)

	self._guideButtonAdapter = false
	self._clickFunction = false

	GuideActionClickMask.super.onExit(self)
end

function GuideActionClickMask:isBattleClickCell()
	if SceneMgr.instance:getCurSceneType() ~= SceneType.Battle then
		return false
	end

	if self._guideControlType == GuideEnum.GuideControlType.CurPosInDungeon or self._guideControlType == GuideEnum.GuideControlType.NpcId then
		return true
	end

	return false
end

function GuideActionClickMask:_onClickTarget(isInside)
	self._clickInSide = isInside

	if isInside then
		if self:isBattleClickCell() then
			local x, z = self:_getCellCoordinate()

			BattleScenePickerViewFacade.instance:simulatePickCoordinates(x, z, false)
			ViewMgr.instance:close(ViewName.ToolTipsCharacterSkillDetailViewPresentor)
		end

		if self._guideCompleteType == GuideEnum.CompleteType.ClickTargetControl and self._guideControlType == GuideEnum.GuideControlType.ControlUI then
			return
		elseif self._guideCompleteType == GuideEnum.CompleteType.ClickTargetControl and self._guideControlType == GuideEnum.GuideControlType.SceneObject then
			self:_checkIsRealyClickSceneObj()

			return
		end

		self:onDone(WorkResult.Succeed)
		GlobalDispatcher:dispatchEvent(EventType.FINISH_GUIDE_STEP)
	end
end

function GuideActionClickMask:_clickGuideFun(curGuideId, curStepId)
	if curGuideId == self.guideStepCO.guideId and curStepId == self.guideStepCO.id then
		self._clickFunction = true

		self:_checkIsRealyClickUI()
	end
end

function GuideActionClickMask:_checkIsRealyClickUI()
	if self._clickFunction then
		if StoryFacde.instance:hasAttrOption() then
			return
		end

		self:onDone(WorkResult.Succeed)
		GlobalDispatcher:dispatchEvent(EventType.FINISH_GUIDE_STEP)
	end
end

function GuideActionClickMask:_doSelectAttrFinish()
	self:onDone(WorkResult.Succeed)
	GlobalDispatcher:dispatchEvent(EventType.FINISH_GUIDE_STEP)
end

function GuideActionClickMask:_onSceneHitNormal(e, position, isDoubleClick)
	if self:isBattleClickCell() then
		local params = self._params
		local activeCheckerBoard = BattleMgr.instance:getBoardMgr():getActiveCheckerBoard()
		local x, z = activeCheckerBoard:WorldPosition2CellPosition(position.x, position.y, position.z, 0, 0)

		if self._guideControlType == GuideEnum.GuideControlType.CurPosInDungeon then
			local coordinate = string.split(params, ",")

			if x == tonumber(coordinate[1] and z == tonumber(coordinate[2])) then
				self:onDone(WorkResult.Succeed)
			end
		elseif self._guideControlType == GuideEnum.GuideControlType.NpcId then
			local npcCode = tonumber(params)
			local unit = BattleMgr.instance:getUnitMgr():getUnitByEntityCode(npcCode)

			if unit then
				local npcX, npcZ = unit.transform:getCoordinates()

				if npcX == x and npcZ == z then
					self:onDone(WorkResult.Succeed)
				end
			end
		end
	end
end

function GuideActionClickMask:_getCellCoordinate()
	local params = self._params

	if self._guideControlType == GuideEnum.GuideControlType.CurPosInDungeon then
		local coordinate = string.split(params, ",")

		return tonumber(coordinate[1]), tonumber(coordinate[2])
	elseif self._guideControlType == GuideEnum.GuideControlType.NpcId then
		local npcCode = tonumber(params)
		local unit = BattleMgr.instance:getUnitMgr():getUnitByEntityCode(npcCode)

		if unit then
			local npcX, npcZ = unit.transform:getCoordinates()

			return npcX, npcZ
		end
	end

	return -1, -1
end

function GuideActionClickMask:_onSelectAttrFinish()
	self._finishAttrSelect = true

	if StoryFacde.instance:hasAttrOption() then
		self:_doSelectAttrFinish()
	end
end

function GuideActionClickMask:_onClickSceneObject(evt, clickName)
	if self._guideCompleteType == GuideEnum.CompleteType.ClickTargetControl and self._guideControlType == GuideEnum.GuideControlType.SceneObject then
		local uiGo = goutil.find(self._params)

		if uiGo and not goutil.isNil(uiGo) then
			if uiGo.name == clickName then
				self._clickSceneObject = true
			else
				self._clickSceneObject = false
			end
		end

		self:_checkIsRealyClickSceneObj()
	end
end

function GuideActionClickMask:_checkIsRealyClickSceneObj()
	if self._clickSceneObject and self._clickInSide then
		self:onDone(WorkResult.Succeed)
		GlobalDispatcher:dispatchEvent(EventType.FINISH_GUIDE_STEP)
	end
end

return GuideActionClickMask
