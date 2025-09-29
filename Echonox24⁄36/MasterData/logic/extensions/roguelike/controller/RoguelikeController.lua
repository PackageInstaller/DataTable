-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/controller/RoguelikeController.lua

module("logic.extensions.roguelike.controller.RoguelikeController", package.seeall)

local M = class("RoguelikeController", BaseController)
local SCENE_ID_DEFAULT = 6001

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.FORCE_FINISH_GUIDE, self._onForceFinishGuide, self)
	self:onReset()
end

function M:onReset()
	self._replyPlotPlayingStatus = false
	self._enterPlotPlayingStatus = false
	self._workReplyPlotPlayingStatus = false
	self._sceneId = nil
	self._delayEntering = nil

	self:setIsSelectRoleScene(false)
end

function M:_onForceFinishGuide(sender, isRoguelikeGuide)
	if isRoguelikeGuide then
		RoguelikeAgent.instance:sendQuitRequest()
	end
end

function M:getSceneId(mapId)
	local mapCo = RoguelikeConfig.instance:getMapById(mapId)

	if mapCo then
		if mapCo.sceneCode ~= -1 then
			return mapCo.sceneCode
		else
			return SCENE_ID_DEFAULT
		end
	end

	return SCENE_ID_DEFAULT
end

function M:resetMapParent()
	self._goMapParent = UnityEngine.GameObject.Find("plane")
end

function M:setIsSelectRoleScene(isSelect)
	self._isSelectRoleScene = isSelect
end

function M:getIsSelectRoleScene()
	return self._isSelectRoleScene
end

function M:getIsAllowQuit()
	if self._inAnimation then
		return false
	end

	return true
end

function M:closeMapView()
	if ViewMgr.instance:isOpen(ViewName.RogueMap) then
		ViewMgr.instance:close(ViewName.RogueMap)
	end

	if ViewMgr.instance:isOpen(ViewName.RogueSecondaryMap) then
		ViewMgr.instance:close(ViewName.RogueSecondaryMap)
	end
end

function M:enterRunGroupScene(sceneId, isSwitchScene)
	if isSwitchScene then
		ViewMgr.instance:close(ViewName.RogueMap)
		SceneFace.instance:exitScene()
	end

	self._sceneId = sceneId

	SceneFace.instance:enterRunGroupScene(sceneId)
end

function M:setMapParent(index, go)
	if index == 1 then
		self._mapParent1 = go
	else
		self._mapParent2 = go
	end
end

function M:getMapParent(index)
	return index == 1 and self._mapParent1 or self._mapParent2
end

function M:switchSelectScene2RunGroupScene(scriptId)
	if RoguelikeController.instance:getIsSelectRoleScene() then
		if goutil.isNil(self._mapParent1) then
			printError("当前场景没有选人场景")

			return
		end

		local pos = Vector3.zero
		local time = 2

		VirtualCameraMgr.instance:setDampingX(1)
		VirtualCameraMgr.instance:setDampingZ(1)
		VirtualCameraMgr.instance:doFollowPosition(pos.x, pos.y, pos.z, time - 0.2)

		local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()

		virtualCamera:doRotation(24, 0, 0, 0.5)

		local animator = self._mapParent1:GetComponent(ComponentType.Animation)

		animator:Play("xuanrenchangjing_xs")

		self._scriptId = scriptId
		self._delayEntering = true

		settimer(time, self.delayEnterRogueMap, self, false)

		return
	end
end

function M:isDelayEntering()
	return self._delayEntering
end

function M:setDelayEntering(delayEntering)
	self._delayEntering = delayEntering
end

function M:delayHideSelectRoles()
	RoguelikeUtil.instance:destroySelectRoles()
end

function M:delayEnterRogueMap()
	goutil.setActive(self._mapParent1, false)
	goutil.setActive(self._mapParent2, true)
	ViewMgr.instance:open(ViewName.RogueMap, {
		true,
		function()
			self:playSelectRolePlot()
		end
	})
end

function M:playSelectRolePlot()
	local scriptCo = RoguelikeConfig.instance:getScriptById(self._scriptId)
	local plotId = scriptCo and scriptCo.selectRolePlot or 0

	if plotId ~= 0 and RoguelikeConst.IsAllowStory(plotId) then
		StoryMgr.instance:startSingle(plotId, false, self.onSelectRolePlotFinished, self)
		RoguelikeConst.SetStoryPlayed(plotId)
	else
		RogueCameraUtil.instance:playEnterSceneCamera()
	end
end

function M:onSelectRolePlotFinished()
	RogueCameraUtil.instance:playEnterSceneCamera(true)
end

function M:enterRunGroupJudgeScene(callback)
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Anim)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SWITCH_BG_MUSIC, RoguelikeConst.ROGUE_EXPLORE_TYPE.JUDGE)
	self:creatAnimationWork(true, callback)

	self._isInJudgeScene = true
end

function M:enterRunGroupSecondaryScene(sceneId)
	self._sceneId = sceneId
	self._inAnimation = true

	self:_destroyWork()

	local work = self:_createWork()

	work:setDoneCaller(self.dealEnterSecondaryScene, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkMapUIActive.New())
	sequence:addChild(WorkMapRoleAnimation.New())
	sequence:addChild(WorkMapRiseDownAnimation.New())
	work:addChild(sequence)

	local context = {}

	context.isShowMapUI = false
	context.isEnterSecondaryScene = true
	context.isRoleLeave = true
	context.isDown = true
	context.isInSecondRoom = false

	work:start(context)
end

function M:dealEnterSecondaryScene()
	self._inAnimation = false

	if RoguelikeConst.IsPreloadScene then
		local scene = SceneMgr.instance:getScene(SceneType.RunGroup)

		scene.stage:activeAdditionScene(self._sceneId)

		local mapMgr = RogueMgr.instance:getMapMgr()

		if mapMgr then
			mapMgr:switchToSecondScene(true)
		end

		ViewMgr.instance:close(ViewName.RogueMap)
		ViewMgr.instance:open(ViewName.RogueSecondaryMap, true)
		RoguelikeController.instance:showEnterSecondarySceneAni()
	else
		SceneFace.instance:enterRunGroupSecondaryScene(self._sceneId)
	end
end

function M:showEnterSceneAni(callback)
	self._inAnimation = true

	self:_destroyWork()

	local mapRoot = RogueMapGenerator.getMapsRoot()

	if not goutil.isNil(mapRoot) then
		goutil.setActive(mapRoot, false)
	end

	self._enterCallback = callback

	local roleRoot = RogueMapGenerator.getRoleRoot()

	goutil.setActive(roleRoot, false)

	local work = self:_createWork()

	work:setDoneCaller(self.onEnteredScene, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkMapRiseDownAnimation.New())
	sequence:addChild(WorkMapUIActive.New())
	sequence:addChild(WorkMapRoleAnimation.New())
	work:addChild(sequence)

	local context = {}

	context.isShowMapUI = true
	context.isEnterSecondaryScene = false
	context.isRoleLeave = false
	context.isDown = false
	context.isInSecondRoom = false

	work:start(context)
end

function M:showEnterSecondarySceneAni()
	self._inAnimation = true

	self:_destroyWork()

	local mapRoot = RogueMapGenerator.getMapsRoot2()

	if not goutil.isNil(mapRoot) then
		goutil.setActive(mapRoot, false)
		print("隐藏次级地图", debug.traceback())
	end

	local work = self:_createWork()

	work:setDoneCaller(self.onEnteredScene, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkMapRiseDownAnimation.New())
	sequence:addChild(WorkMapRoleAnimation.New())
	sequence:addChild(WorkMapUIActive.New())
	work:addChild(sequence)

	local context = {}

	context.isShowMapUI = true
	context.isEnterSecondaryScene = false
	context.isRoleLeave = false
	context.isDown = false
	context.isInSecondRoom = true

	work:start(context)
end

function M:showExitSecondarySceneAni()
	self._inAnimation = true

	self:_destroyWork()

	local work = self:_createWork()

	work:setDoneCaller(self.onExitedSecondSceneAni, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkMapUIActive.New())
	sequence:addChild(WorkMapRoleAnimation.New())
	sequence:addChild(WorkMapRiseDownAnimation.New())
	work:addChild(sequence)

	local context = {}

	context.isShowMapUI = false
	context.isEnterSecondaryScene = false
	context.isRoleLeave = true
	context.isDown = true
	context.isInSecondRoom = true

	work:start(context)
end

function M:onExitedSecondSceneAni()
	self._inAnimation = false

	if RoguelikeConst.IsPreloadScene then
		local mapMgr = RogueMgr.instance:getMapMgr()

		if mapMgr then
			mapMgr:switchToSecondScene(false)
		end

		ViewMgr.instance:close(ViewName.RogueSecondaryMap)
		ViewMgr.instance:open(ViewName.RogueMap)

		local scene = SceneMgr.instance:getScene(SceneType.RunGroup)

		scene.stage:activeMainScene()
		RoguelikeController.instance:showEnterSceneAni()
	else
		SceneFace.instance:backScene()
	end
end

function M:onEnteredScene()
	self._inAnimation = false

	if self._enterCallback then
		self._enterCallback()

		self._enterCallback = nil
	end
end

function M:getCurSceneId()
	return self._sceneId
end

function M:getInAnimation()
	return self._inAnimation
end

function M:getIsViewOpening()
	return ViewMgr.instance:isOpen(ViewName.RogueMonsterSettlement) or ViewMgr.instance:isOpen(ViewName.RogueEventSettlement)
end

function M:creatAnimationWork(isDown, callback)
	self._inAnimation = true

	self:_destroyWork()

	self._aniCallback = callback

	local work = self:_createWork()

	work:setDoneCaller(self._onAniWorkFinish, self)

	local sequence = FlowSequence.New()

	if isDown then
		sequence:addChild(WorkMapRoleAnimation.New())
		sequence:addChild(WorkMapUIAnimation.New())
		sequence:addChild(WorkMapRiseDownAnimation.New())
		sequence:addChild(WorkJudgeMapAnimation.New())
		sequence:addChild(WorkSetJudgePos.New())
	else
		sequence:addChild(WorkMapUIActive.New())
		sequence:addChild(WorkSetJudgePos.New())
		sequence:addChild(WorkJudgeMapAnimation.New())
		sequence:addChild(WorkMapRiseDownAnimation.New())
		sequence:addChild(WorkMapUIAnimation.New())
		sequence:addChild(WorkMapRoleAnimation.New())
	end

	work:addChild(sequence)

	local context = {}

	context.isDown = isDown
	context.isRoleLeave = isDown

	work:start(context)
end

function M:_onAniWorkFinish()
	if self._aniCallback then
		self._aniCallback()

		self._aniCallback = nil
	end

	self._inAnimation = false

	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)
end

function M:_createWork()
	self:_destroyWork()

	self._workingWork = WorkFlow.New()

	return self._workingWork
end

function M:_destroyWork()
	if self._workingWork then
		self._workingWork:destroy()

		self._workingWork = false
	end
end

function M:exitRunGroupSceneFlow()
	local sceneFlow = SceneFace.instance:getCurSceneFlow()
	local curSceneFlowTyp = SceneFace.instance:getCurSceneFlowTyp()

	if sceneFlow and curSceneFlowTyp and curSceneFlowTyp ~= SceneType.Room then
		SceneFace.instance:backScene()
	end

	RogueMgr.instance:exit()
end

function M:jumpToRoomScene()
	RogueMgr.instance:exit()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:getIsInJudgeScene()
	return self._isInJudgeScene
end

function M:exitRunGroupJudgeSceneFlow(callback)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SWITCH_BG_MUSIC, RoguelikeConst.ROGUE_EXPLORE_TYPE.MOVE)

	if not self._isInJudgeScene then
		if callback ~= nil then
			callback()
		end

		return
	end

	self._isInJudgeScene = false

	ViewMgr.instance:close(ViewName.RogueMonsterJudge)
	ViewMgr.instance:close(ViewName.RogueEventJudge)

	if RoguelikeModel.instance:getIsInSecondRoom() then
		ViewMgr.instance:open(ViewName.RogueSecondaryMap)
	else
		ViewMgr.instance:open(ViewName.RogueMap)
	end

	self:creatAnimationWork(false, callback)
end

function M:exitRunGroupSecondSceneFlow(isQuit, isBack2Main)
	local sceneFlow = SceneFace.instance:getCurSceneFlow()

	if sceneFlow then
		if isBack2Main then
			SceneFace.instance:backScene()
			RogueMgr.instance:exit()

			return
		end

		if isQuit then
			RogueMgr.instance:exit()

			if not RoguelikeConst.IsPreloadScene then
				SceneFace.instance:backScene()
			end

			SceneFace.instance:backScene()
		else
			self:showExitSecondarySceneAni()
		end
	end
end

function M:getIsAllDeath()
	local allRoles = RogueMgr.instance:getRogueFlow() and RogueMgr.instance:getModel():getAllRoleMos() or {}

	if not RoguelikeModel.instance:getIsInRogue() or not RogueMgr.instance:isInRogue() then
		return true
	end

	for i = 1, #allRoles do
		local prop = allRoles[i].roleProp

		if not prop:getIsDeath() then
			return false
		end
	end

	return true
end

function M:checkNeedQuit(callback)
	if self:getIsAllDeath() then
		local curScriptId = RoguelikeModel.instance:getCurScriptId()
		local scriptCo = RoguelikeConfig.instance:getScriptById(curScriptId)
		local plotId = scriptCo and scriptCo.failPlot or 0

		if plotId ~= 0 then
			RoguePlotUtil.instance:startPlot(plotId, function()
				self:_onFailPlotFinish()

				if callback ~= nil then
					callback()
				end
			end)
		else
			RoguelikeAgent.instance:sendQuitRequest(true)

			if callback ~= nil then
				callback()
			end
		end
	elseif callback ~= nil then
		callback()
	end
end

function M:_onFailPlotFinish()
	RoguelikeAgent.instance:sendQuitRequest(true)
end

function M:enterRogueMeetView(eventId)
	self._eventId = eventId

	local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)

	if not self:getPlotPlayingStatus() and eventCo and eventCo.prestory ~= "" and eventCo.prestory ~= "0" and RoguelikeConst.IsAllowStory(tonumber(eventCo.prestory)) and not RoguelikeConst.IsGuildMode() then
		self:setPlayingEnterPlotStatus(true)
		RoguePlotUtil.instance:startPlot(tonumber(eventCo.prestory), function()
			self:_onPlotFinish()
		end)

		return
	end

	ViewMgr.instance:open(ViewName.RogueMeetEvent, eventId)
end

function M:_onPlotFinish()
	LoadingFacade.instance:hideLoading()
	ViewMgr.instance:open(ViewName.RogueMeetEvent, self._eventId)
end

function M:setPlayingEnterPlotStatus(status)
	self._enterPlotPlayingStatus = status
end

function M:getPlayingEnterPlotStatus()
	return self._enterPlotPlayingStatus
end

function M:getPlayingReplyPlotStatus()
	return self._replyPlotPlayingStatus
end

function M:setPlayingReplyPlotStatus(status)
	self._replyPlotPlayingStatus = status
end

function M:getPlayingWorkReplyPlotStatus()
	return self._workReplyPlotPlayingStatus
end

function M:setPlayingWorkReplyPlotStatus(status)
	self._workReplyPlotPlayingStatus = status
end

function M:getPlotPlayingStatus(status)
	return self._replyPlotPlayingStatus or self._enterPlotPlayingStatus or self._workReplyPlotPlayingStatus
end

function M:useSkill(callback)
	local equipMo = RoguelikeModel.instance:getCurEquipMOS()[1]

	if equipMo then
		local effects = equipMo:getActiveEffects()

		if effects and #effects > 0 then
			local effectIds = effects
			local needSelect, needSelectAttr, isAll, firstEffectCo, firstEffectId

			for k, v in ipairs(effectIds) do
				local effectCo = RoguelikeConfig.instance:getEffectById(v)

				if k == 1 then
					firstEffectCo = effectCo
					firstEffectId = v
				end

				local selectable = string.find(effectCo.params, "SELECTABLE")

				if selectable or effectCo.program == "AddChosenAttribute" or effectCo.program == "SelectedHeroToRiseAttribute" then
					needSelect = true
					firstEffectId = v
				end

				needSelectAttr = needSelectAttr or effectCo.program == "AddChosenAttribute" or effectCo.program == "SelectedHeroToRiseAttribute"

				if string.find(effectCo.params, "ALL") then
					isAll = true
				end
			end

			if needSelect and not isAll then
				local tempCallback = callback

				ViewMgr.instance:open(ViewName.RogueSelectPropAndRole, {
					1,
					function(idx)
						ViewMgr.instance:close(ViewName.RogueSelectPropAndRole)

						local roleProp = RogueMgr.instance:getModel():getRoleMoByIndex(idx)

						if needSelectAttr then
							ViewMgr.instance:open(ViewName.RoguePropSelect, function(attr)
								RoguelikeAgent.instance:sendUseSkillRequest(roleProp:getRoleId(), attr)

								if tempCallback then
									tempCallback()
								end
							end, roleProp)
						else
							RoguelikeAgent.instance:sendUseSkillRequest(roleProp:getRoleId(), -1)

							if tempCallback then
								tempCallback()
							end
						end
					end,
					firstEffectCo.description,
					firstEffectId
				})
			else
				RoguelikeAgent.instance:sendUseSkillRequest(0, -1)

				if callback then
					callback()
				end
			end
		end
	else
		FloatWordMgr.instance:show("暂无装备")
	end
end

function M:execEffectIds(effectIds, callback, roleId, count)
	if effectIds ~= nil then
		local needSelect, needSelectAttr, isAll, firstEffectCo, firstEffectId

		for k, v in ipairs(effectIds) do
			local effectCo = RoguelikeConfig.instance:getEffectById(v)

			if not effectCo then
				printError("找不到效果", v)
			end

			if k == 1 then
				firstEffectCo = effectCo
				firstEffectId = v
			end

			local selectable = string.find(effectCo.params, "SELECTABLE")

			if selectable or effectCo.program == "AddChosenAttribute" or effectCo.program == "SelectedHeroToRiseAttribute" then
				needSelect = true
				firstEffectId = v
			end

			needSelectAttr = needSelectAttr or effectCo.program == "AddChosenAttribute" or effectCo.program == "SelectedHeroToRiseAttribute"

			if string.find(effectCo.params, "ALL") then
				isAll = true
			end
		end

		if needSelect and not isAll and not roleId then
			local tempCallback = callback

			ViewMgr.instance:open(ViewName.RogueSelectPropAndRole, {
				1,
				function(idx)
					ViewMgr.instance:close(ViewName.RogueSelectPropAndRole)

					local roleProp = RogueMgr.instance:getModel():getRoleMoByIndex(idx)

					if needSelectAttr then
						ViewMgr.instance:open(ViewName.RoguePropSelect, function(attr)
							RoguelikeAgent.instance:sendTakeEffectRequest(effectIds, roleProp:getRoleId(), attr, count)

							if tempCallback then
								tempCallback()
							end
						end, roleProp)
					else
						RoguelikeAgent.instance:sendTakeEffectRequest(effectIds, roleProp:getRoleId(), -1, count)

						if tempCallback then
							tempCallback()
						end
					end
				end,
				firstEffectCo.description,
				firstEffectId
			})
		else
			local execRoleId = roleId or 0

			RoguelikeAgent.instance:sendTakeEffectRequest(effectIds, execRoleId, -1, count)

			if callback then
				callback()
			end
		end
	elseif callback then
		callback()
	end
end

function M:getEffectParams(effectIds, callback)
	if effectIds ~= nil then
		local needSelect, needSelectAttr, isAll, firstEffectCo, firstEffectId

		for k, v in ipairs(effectIds) do
			local effectCo = RoguelikeConfig.instance:getEffectById(v)

			if k == 1 then
				firstEffectCo = effectCo
				firstEffectId = v
			end

			local selectable = string.find(effectCo.params, "SELECTABLE")

			if selectable or effectCo.program == "AddChosenAttribute" or effectCo.program == "SelectedHeroToRiseAttribute" then
				needSelect = true
				firstEffectId = v
			end

			needSelectAttr = needSelectAttr or effectCo.program == "AddChosenAttribute" or effectCo.program == "SelectedHeroToRiseAttribute"

			if string.find(effectCo.params, "ALL") then
				isAll = true
			end
		end

		if needSelect and not isAll then
			local tempCallback = callback

			ViewMgr.instance:open(ViewName.RogueSelectPropAndRole, {
				1,
				function(idx)
					ViewMgr.instance:close(ViewName.RogueSelectPropAndRole)

					local roleProp = RogueMgr.instance:getModel():getRoleMoByIndex(idx)

					if needSelectAttr then
						ViewMgr.instance:open(ViewName.RoguePropSelect, function(attr)
							if tempCallback then
								tempCallback(roleProp:getRoleId(), attr)
							end
						end, roleProp)
					elseif tempCallback then
						tempCallback(roleProp:getRoleId(), 0)
					end
				end,
				firstEffectCo.description,
				firstEffectId
			})
		elseif callback then
			callback(0, 0)
		end
	end
end

function M:execGetProp(propId)
	local propCo = RoguelikeConfig.instance:getPropById(propId)

	if propCo then
		ViewMgr.instance:open(ViewName.RogueSelectPropAndRole, {
			2,
			{
				propId
			}
		})
	end
end

function M:openPropRewardTips(propId, callback)
	local data = {}
	local item = {}

	item.propId = propId

	table.insert(data, item)

	if callback ~= nil then
		callback()
	end
end

function M:getRolePos()
	local mapMgr = RogueMgr.instance:getMapMgr()
	local pos = mapMgr:getMapRolePos()

	return pos
end

function M:exitSettlementView()
	local allRoles = RoguelikeModel.instance:getRoleStates()
	local allEnterRoles = RoguelikeModel.instance:getEnterRoleStates()
	local changRoles = {}

	if #allEnterRoles > 0 then
		for i = 1, #allRoles do
			if allRoles[i].hp ~= allEnterRoles[i].hp or allRoles[i].san ~= allEnterRoles[i].san then
				local data = {}

				data.id = allRoles[i].id
				data.hp = allEnterRoles[i].hp - allRoles[i].hp
				data.san = allEnterRoles[i].san - allRoles[i].san

				table.insert(changRoles, data)
			end
		end
	end

	if #changRoles > 0 then
		if ViewMgr.instance:isOpen(ViewName.RogueSelectPropAndRole) then
			local propCodes = RoguelikeAgent.instance:getPropCodes()

			ViewMgr.instance:close(ViewName.RogueSelectPropAndRole)
			ViewMgr.instance:open(ViewName.RogueSelectPropAndRole, {
				3,
				function()
					if propCodes ~= nil then
						ViewMgr.instance:open(ViewName.RogueSelectPropAndRole, {
							2,
							propCodes
						})
					end
				end
			})
		else
			ViewMgr.instance:open(ViewName.RogueSelectPropAndRole, {
				3,
				function()
					RoguelikeModel.instance:setEnterRoleStates()
				end
			})
		end
	else
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_CHECK_SETTLEMENT)
	end
end

function M:createTempDices(count)
	self._dices = {}

	for i = 1, count do
		local dice = RogueDiceMo.New(RoguelikeConst.ROGUE_DICE_TYPE.COMBAT)

		dice:setUpIndex(1)
		dice:setDiceType(1)
		table.insert(self._dices, dice)
	end

	RogueMgr.instance:getRogueFlow().diceMgr:getDiceInst(function(inst)
		self:onGetDiceRes(inst)
	end)

	self._dicesWall = {}

	for i = 1, count do
		local dice = RogueDiceMo.New(RoguelikeConst.ROGUE_DICE_TYPE.COMBAT)

		dice:setUpIndex(1)
		dice:setDiceType(1)
		table.insert(self._dicesWall, dice)
	end

	RogueMgr.instance:getRogueFlow().diceMgr:getDiceInst(function(inst)
		self:onTestDiceWall(inst)
	end)
end

function M:onTestDiceWall(asset)
	self._diceWallGos = {}

	if self._dicesWall then
		local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr

		for k, v in ipairs(self._dices) do
			local inst = diceMgr:getDiceObj(diceMgr:getDiceIndex(v))
			local pos = Vector3.New(20, 1 + math.floor(k / 5) * 1.5, -((k - 1) % 4) * 1.5)

			inst.transform.position = pos

			local rigidbody = inst:GetComponent("Rigidbody")

			rigidbody.isKinematic = true

			goutil.setActive(inst, true)
			v:setGo(inst)
			table.insert(self._diceWallGos, inst)
		end
	end
end

function M:onGetDiceRes(asset)
	self._diceRigidbodys = {}
	self._diceGos = {}

	if self._dices then
		local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr
		local dicePos = RogueMgr.instance:getRogueFlow().model:getPlayerDicePos()

		for k, v in ipairs(self._dices) do
			local inst = diceMgr:getDiceObj(diceMgr:getDiceIndex(v))
			local pos = Vector3.New(dicePos.x + (k - #self._dices / 2) * 2.5, dicePos.y + 10, dicePos.z)

			inst.transform.position = pos

			for i = 1, 6 do
				local pattern = v:getPatternByIndex(i)
				local child = goutil.findChild(inst, diceMgr:getDiceFaceName(i))

				diceMgr:setDicePattern(child, pattern)
				goutil.setActive(child.gameObject, v:getPatternByIndex(i) ~= RoguelikeConst.DICE_PATTERN.WHITE)
			end

			local rigidbody = inst:GetComponent("Rigidbody")

			rigidbody.isKinematic = true

			table.insert(self._diceRigidbodys, {
				body = rigidbody,
				index = v:getUpIndex(),
				dice = v,
				flyIndex = k
			})
			goutil.setActive(inst, true)
			v:setGo(inst)
			table.insert(self._diceGos, inst)
		end

		self:flyToOrigin()
	end
end

function M:flyToOrigin()
	local rolePos = RoguelikeController.instance:getRolePos()
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE

	for k, v in pairs(self._diceGos) do
		local line = math.modf(k / 3)
		local offset = math.fmod(k, 3)

		if offset == 0 and line > 0 then
			line = line - 1
		end

		offset = offset == 0 and 3 or offset

		local y = (0.5 + line) * RoguelikeConst.DICE_SCALE + rolePos.y
		local z = (-(#self._diceGos / 2) + k) * RoguelikeConst.DICE_SCALE + rolePos.z + kMapItemSize * 1
		local pos = Vector3.New(rolePos.x + kMapItemSize * 1.5, y + 10, z)

		v.transform:DOMove(pos, 0.5):OnComplete(self.onMoveFinish, self)
		v.transform:DOLocalRotate(Vector3.zero, 0.5)
	end

	settimer(0.5, self.diceFloat, self, false)
end

function M:diceFloat()
	for k, v in pairs(self._diceGos) do
		local item = Astral.LuaComponentContainer.Add(v, RogueDiceCompFloat)
		local rotation = Vector3.New(math.random(1, 359), math.random(1, 359), math.random(1, 359))
		local minY = math.random(2, 5)
		local maxY = minY + math.random(2, 4)

		item:setRandomFloat(rotation, minY, maxY)
	end
end

function M:stopDiceFloat()
	for k, v in pairs(self._diceGos) do
		if not goutil.isNil(v) then
			local item = Astral.LuaComponentContainer.Add(v, RogueDiceCompFloat)

			item:stopFloat()
		end
	end
end

function M:clearTempDices()
	for k, v in pairs(self._diceGos) do
		goutil.destroy(v)
	end
end

function M:getTempDices()
	return self._diceGos, self._diceWallGos
end

function M:clear()
	self._isInJudgeScene = false
	self._enterPlotPlayingStatus = false
end

M.instance = M.New()

return M
