-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/agent/RoguelikeAgent.lua

module("logic.extensions.roguelike.agent.RoguelikeAgent", package.seeall)

local M = class("RoguelikeAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)

	self._propCodeList = {}
end

function M:sendLoadInfoRequest()
	local msg = RoguelikeExtension_pb.LoadInfoRequest()

	self:sendMsg(msg)
end

function M:handleLoadInfoReply(status, msg)
	if status == 0 then
		RoguelikeModel.instance:updateMapConfig(msg.mapConfig)
		RoguelikeModel.instance:updateExploreInfo(msg.info)
	end
end

function M:sendTeamUpRequest(codes)
	local msg = RoguelikeExtension_pb.TeamUpRequest()

	for k, v in ipairs(codes) do
		table.insert(msg.code, v)
	end

	self:sendMsg(msg)
end

function M:handleTeamUpReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_TEAM_UP_SUCCESS)
	end
end

function M:sendJudgeRequest(effectCodes)
	local isInRogue = RoguelikeModel.instance:getIsInRogue()

	if not isInRogue then
		return
	end

	local msg = RoguelikeExtension_pb.JudgeRequest()

	for k, v in ipairs(effectCodes) do
		table.insert(msg.effects, v)
	end

	self:sendMsg(msg)
end

function M:handleJudgeReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendRectifyRequest(attr)
	local msg = RoguelikeExtension_pb.RectifyRequest()

	msg.attr = attr

	self:sendMsg(msg)
end

function M:handleRectifyReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendQuitRequest(isIgnore)
	local isInRogue = RoguelikeModel.instance:getIsInRogue()

	if not isInRogue and not isIgnore or RogueExploreModel.instance:getIsGameFinish() then
		return
	end

	if RogueMgr.instance:getIsClientMode() or not RoguelikeController.instance:getIsAllowQuit() then
		return
	end

	local msg = RoguelikeExtension_pb.QuitRequest()

	self:sendMsg(msg)
end

function M:handleQuitReply(status, msg)
	if status == 0 then
		RoguelikeModel.instance:clearRoomMos()
		RoguelikeModel.instance:clearScriptId()
		FloatWordMgr.instance:show(lang("tip_r_quit_success"))
		self:closeRogueView()
	end
end

function M:closeCurOpenView(viewName)
	if ViewMgr.instance:isOpen(viewName) then
		ViewMgr.instance:close(viewName)
	end
end

function M:closeRogueView()
	self:closeCurOpenView(ViewName.RogueMonsterSettlement)
	self:closeCurOpenView(ViewName.RogueEventSettlement)
	self:closeCurOpenView(ViewName.RogueMeetMonster)
	self:closeCurOpenView(ViewName.RogueMeetEvent)
	self:closeCurOpenView(ViewName.RogueVendingMachine)
	self:closeCurOpenView(ViewName.RogueGuessDiceGame)
	self:closeCurOpenView(ViewName.RogueMoonyDiceGame)
end

function M:handleGameOverPush(status, msg)
	if status == 0 then
		self:closeRogueView()
		RoguelikeModel.instance:clearRoomMos()
		RogueExploreModel.instance:setState(msg.state)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_GAME_OVER, RogueExploreModel.instance:getIsExploreWin())

		if RogueExploreModel.instance:getIsExploreWin() then
			if not RoguelikeConst.IsGuideFinish() then
				local guideId = RoguelikeConfig.instance:getConstByName("GuideModelFinishStep").numValue

				GuideModel.instance:setFinishGuide(guideId)
				GuideAgent.instance:sendFinishGuideRequest(guideId, 2, 0)

				local guideMO = GuideModel.instance:getGuideMO(guideId)

				UserUtil.uploadGuideBuryPoint(guideMO, false, 2, 0)
			end

			FloatWordMgr.instance:show("游戏探索完成")

			local scriptId = RoguelikeConfig.instance:getConstByName("GuideScriptId").numValue

			RoguelikeModel.instance:clearScriptId()

			if RoguelikeModel.instance:getCurScriptId() ~= scriptId then
				-- block empty
			end

			RogueExploreModel.instance:updateCurScriptNo(msg.script)
		else
			if ViewMgr.instance:isOpen(ViewName.RogueMonsterJudge) then
				-- block empty
			end

			RogueExploreModel.instance:updateCurScriptNo(msg.script)
		end
	end
end

function M:sendAddPropsRequest(code, heroId, attr, cardIndex)
	local msg = RoguelikeExtension_pb.AddPropsRequest()
	local randNum = SpaceX.MyRandomUtils.NextLong()
	local secretKey = RoguelikeConfig.instance:getConstByName("SecretKey").numValue
	local newNum = tonumber(secretKey .. code)
	local s = SpaceX.MyRandomUtils.GetXorNum(newNum, randNum)

	msg.code = tostring(s)
	msg.heroId = heroId
	attr = attr ~= nil and attr ~= -1 and attr or 0
	msg.attr = attr
	msg.card = cardIndex or 1

	local slId = self._propCodeList[1] and self._propCodeList[1][2] or 0

	msg.slId = slId
	self._lastPropId = code

	self:sendMsg(msg)

	self._propCodes = nil
end

function M:handleAddPropsReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ADD_PROP_SUCCESS)
		RoguelikeController.instance:openPropRewardTips(self._lastPropId)
		table.remove(self._propCodeList, 1)

		if #self._propCodeList ~= 0 then
			self._propCodes = self._propCodeList[1][1]

			self:delayShowProps()
		end
	end
end

function M:sendDropPropsRequest(propId)
	local msg = RoguelikeExtension_pb.DropPropsRequest()

	msg.id = propId

	self:sendMsg(msg)
end

function M:handleDropPropsReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_PROP)
	end
end

function M:handlePlayerInfoUpdatePush(status, msg)
	if status == 0 then
		RoguelikeModel.instance:updateExploreInfo(msg.info)
	end
end

function M:handleGoldUpdatePush(status, msg)
	if status == 0 then
		RoguelikeModel.instance:updateGold(msg.num)
	end
end

function M:handleSelectPropsPush(status, msg)
	if status == 0 then
		for k, v in pairs(self._propCodeList) do
			if v[2] == msg.slId then
				return
			end
		end

		local codes = msg.code

		for k, v in ipairs(codes) do
			print("选择道具", v)
		end

		self._propCodes = #self._propCodeList > 0 and self._propCodeList[1][1] or codes

		table.insert(self._propCodeList, {
			codes,
			msg.slId
		})

		if ViewMgr.instance:isOpen(ViewName.RogueMap) or ViewMgr.instance:isOpen(ViewName.RogueSecondaryMap) or ViewMgr.instance:isOpen(ViewName.RogueMonsterJudge) then
			self:delayShowProps()
		end
	end
end

function M:delayShowProps()
	if ViewMgr.instance:isOpen(ViewName.RogueSelectPropAndRole) or ViewMgr.instance:isOpen(ViewName.RogueSelectPropAndRole2) and self._propCodes ~= nil then
		return
	end

	self:delayShowMeetMonster()

	if self._propCodes == nil then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.RogueMoonyDiceGame) then
		ViewMgr.instance:open(ViewName.RogueSelectPropAndRole2, {
			2,
			self._propCodes
		})
	else
		ViewMgr.instance:open(ViewName.RogueSelectPropAndRole, {
			2,
			self._propCodes
		})
	end

	print("显示道具", self._propCodes)
end

function M:getPropCodes()
	return self._propCodes
end

function M:clearPropCodes()
	self._propCodes = nil
	self._propCodeList = {}
end

function M:generateArchive(type, roomId, enemyId, enemyOuterHp, enemyInnerHp, round, heroId, enemyFace, selectedAttr, selfFaces, isJudged, eventId, curFeatureIndex, features, totalFaces, tmpExtraFaces, clientRoundFaces, clientFaces)
	local no = RoguelikeExtension_pb.ArchiveNO()

	eventId = eventId ~= nil and eventId or 0
	no.type = type
	no.enemyId = enemyId
	no.eventId = eventId
	no.enemyOuterHp = enemyOuterHp
	no.enemyInnerHp = enemyInnerHp
	no.round = round
	no.heroId = heroId

	if enemyFace.face then
		no.enemyFace.face = enemyFace.face
		no.enemyFace.num = enemyFace.num
	end

	no.selectedAttr = selectedAttr or 1
	no.roleWall = RogueMgr.instance:getRogueFlow().judgeModel:getRoleDiceWall()

	local lossValue = RogueMgr.instance:getRogueFlow().stateMgr:getCurJudgeRoleChangeValue()

	for k, v in pairs(lossValue) do
		local changeNo = RoguelikeExtension_pb.RoleChangeValue()

		changeNo.heroId = k
		changeNo.hp = v.hp
		changeNo.san = v.san

		table.insert(no.lossValue, changeNo)
	end

	local cardUseInfo = RogueMgr.instance:getRogueFlow().stateMgr:getJudgeCardUseInfo()

	for k, v in pairs(cardUseInfo) do
		local card = RoguelikeExtension_pb.CardValue()

		card.id = k
		card.value = v

		table.insert(no.cardUseInfo, card)
	end

	no.isJudged = isJudged or false

	if curFeatureIndex then
		no.curFeature = curFeatureIndex

		for k, v in ipairs(features or {}) do
			table.insert(no.features, v)
		end
	end

	local stateMgr = RogueMgr.instance:getRogueFlow().stateMgr

	for k, v in pairs(stateMgr:getClientNextCardEntries() or {}) do
		table.insert(no.entryNext, v)
	end

	for k, v in pairs(stateMgr:getContinueEntries() or {}) do
		table.insert(no.entry, v)
	end

	return no
end

function M:sendJudgeArchiveRequest(archive, isIgnoreQuick)
	if RogueMgr.instance:getIsClientMode() or RoguelikeModel.instance:getIsQuit() or archive ~= nil and (archive.type == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT or archive.type == RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT) and RoguelikeConst.GetIsEventJudgeQuick() and not isIgnoreQuick then
		return
	end

	local msg = RoguelikeExtension_pb.JudgeArchiveRequest()

	if archive == nil then
		self._tempArchive = archive

		self:sendMsg(msg)

		return
	end

	print("开始存档", debug.traceback())

	msg.archive.type = archive.type
	msg.archive.enemyId = archive.enemyId
	msg.archive.eventId = archive.eventId
	msg.archive.enemyOuterHp = archive.enemyOuterHp
	msg.archive.enemyInnerHp = archive.enemyInnerHp
	msg.archive.round = archive.round
	msg.archive.heroId = archive.heroId

	if archive.enemyFace.face then
		msg.archive.enemyFace.face = archive.enemyFace.face
		msg.archive.enemyFace.num = archive.enemyFace.num
	end

	msg.archive.selectedAttr = archive.selectedAttr
	msg.archive.roleWall = archive.roleWall
	msg.archive.isJudged = archive.isJudged

	if archive.curFeature then
		msg.archive.curFeature = archive.curFeature

		for k, v in ipairs(archive.features or {}) do
			table.insert(msg.archive.features, v)
		end
	end

	for k, v in ipairs(archive.entryNext or {}) do
		table.insert(msg.archive.entryNext, v)
	end

	for k, v in ipairs(archive.entry or {}) do
		table.insert(msg.archive.entry, v)
	end

	for k, v in ipairs(archive.lossValue or {}) do
		local changeNo = RoguelikeExtension_pb.RoleChangeValue()

		changeNo.heroId = v.heroId
		changeNo.hp = v.hp
		changeNo.san = v.san

		table.insert(msg.archive.lossValue, changeNo)
	end

	for k, v in ipairs(archive.cardUseInfo or {}) do
		local card = RoguelikeExtension_pb.CardValue()

		card.id = v.id
		card.value = v.value

		table.insert(msg.archive.cardUseInfo, card)
	end

	self._tempArchive = msg.archive

	self:sendMsg(msg)
end

function M:archiveToString(archive)
	local temp = {}

	temp.type = archive.type
	temp.enemyId = archive.enemyId
	temp.enemyOuterHp = archive.enemyOuterHp
	temp.enemyInnerHp = archive.enemyInnerHp
	temp.round = archive.round
	temp.heroId = archive.heroId
	temp.enemyFace = {}
	temp.enemyFace.face = archive.enemyFace.face
	temp.enemyFace.num = archive.enemyFace.num
	temp.selectedAttr = archive.selectedAttr
	temp.selfFaces = {}
	temp.isJudged = archive.isJudged
	temp.curFeature = archive.curFeature
	temp.features = {}

	for k, v in ipairs(archive.features or {}) do
		table.insert(temp.features, v)
	end

	temp.totalFaces = {}
	temp.tmpExtraFaces = {}
	temp.lossValue = {}

	for k, v in ipairs(archive.lossValue or {}) do
		local changeNo = {}

		changeNo.heroId = v.heroId
		changeNo.hp = v.hp
		changeNo.san = v.san

		table.insert(temp.lossValue, changeNo)
	end

	temp.cardUseInfo = {}

	for k, v in ipairs(archive.cardUseInfo or {}) do
		local card = {}

		card.id = v.id
		card.value = v.value

		table.insert(temp.cardUseInfo, card)
	end

	TableUtil.dump(temp)
end

function M:handleJudgeArchiveReply(status, msg)
	if status == 0 then
		local archive = self._tempArchive == nil and msg.archive or self._tempArchive

		RoguelikeModel.instance:updateJudgeArchive(archive)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_UPDATE_JUDGE_ARCHIVE, archive)
	end
end

function M:sendLoadScriptRequest()
	local msg = RoguelikeExtension_pb.LoadScriptRequest()

	self:sendMsg(msg)
end

function M:handleLoadScriptReply(status, msg)
	if status == 0 then
		RoguelikeModel.instance:updateScripts(msg.infos)
	end
end

function M:sendSelectScriptRequest(id, diffLevelIndex)
	local cos = RoguelikeConfig.instance:getScriptDiffCo(id)

	diffLevelIndex = diffLevelIndex + 1

	local diffLevel = cos[diffLevelIndex] and cos[diffLevelIndex].level or 0
	local msg = RoguelikeExtension_pb.SelectScriptRequest()

	msg.id = id
	msg.d = diffLevel

	self:sendMsg(msg)
end

function M:handleSelectScriptReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendNextLayerRequest()
	local msg = RoguelikeExtension_pb.NextLayerRequest()

	self:sendMsg(msg)
end

function M:handleNextLayerReply(status, msg)
	if status == 0 then
		RoguelikeModel.instance:updateRoomInfo(msg.map)
	elseif status == 6002 then
		FloatWordMgr.instance:show("当前处于最后一层了")
	end
end

function M:sendTakeEffectRequest(effects, heroId, attr, count, cardIndex)
	local isInRogue = RoguelikeModel.instance:getIsInRogue()

	if not isInRogue then
		return
	end

	local msg = RoguelikeExtension_pb.TakeEffectRequest()

	if effects == nil or #effects == 0 then
		return
	end

	local secretKey = RoguelikeConfig.instance:getConstByName("SecretKey").numValue

	for k, v in ipairs(effects) do
		local randNum = SpaceX.MyRandomUtils.NextLong()
		local newNum = tonumber(secretKey .. v)
		local s = SpaceX.MyRandomUtils.GetXorNum(newNum, randNum)
		local r = tostring(s)

		if r ~= nil and r ~= "" then
			table.insert(msg.effects, r)
		end
	end

	msg.heroId = heroId
	msg.attr = attr ~= -1 and attr or 0
	msg.card = cardIndex or 1
	msg.x = count or 0

	self:sendMsg(msg)
end

function M:handleTakeEffectReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendStartJudgeRequest(judgeType, enemyId, eventId, byGm)
	local isInRogue = RoguelikeModel.instance:getIsInRogue()

	if not isInRogue then
		return
	end

	local msg = RoguelikeExtension_pb.StartJudgeRequest()

	msg.type = judgeType
	msg.enemyId = enemyId
	msg.eventId = eventId
	msg.byGm = byGm or false

	self:sendMsg(msg)
end

function M:handleStartJudgeReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendEndJudgeRequest(type, isWin)
	local isInRogue = RoguelikeModel.instance:getIsInRogue()
	local msg = RoguelikeExtension_pb.EndJudgeRequest()

	msg.success = isWin and 1 or 0

	self:sendMsg(msg)
end

function M:handleEndJudgeReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendMoveRequest(coordinate)
	local isInRogue = RoguelikeModel.instance:getIsInRogue()

	if not isInRogue then
		return
	end

	local msg = RoguelikeExtension_pb.MoveRequest()

	msg.p = coordinate

	local randNum = SpaceX.MyRandomUtils.NextLong()
	local secretKey = RoguelikeConfig.instance:getConstByName("SecretKey").numValue
	local s = SpaceX.MyRandomUtils.GetXorNum(secretKey, randNum)

	msg.s = tostring(s)

	self:sendMsg(msg)
end

function M:handleMoveReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:handleMapUpdatePush(status, msg)
	if status == 0 then
		local rooms = msg.rooms

		for k, v in ipairs(rooms) do
			local index = v.index + 1
			local mo = RoguelikeModel.instance:getRoomMoByIndex(index)

			if mo then
				if v.vision ~= nil then
					mo:setVersion(v.vision)
				end

				if v.finished ~= nil then
					mo:setIsFinish(v.finished)
				end

				if v.touches ~= nil then
					mo:setTouches(v.touches)
				end
			else
				print("找不到房间索引", index)
			end
		end

		self._curRoom = msg.curRoom
		self._curRoom2 = msg.curRoom2

		RoguelikeUtil.instance:saveCurCoordinate()
		RoguelikeModel.instance:setCurRoom(msg.curRoom)
		RoguelikeModel.instance:setIsInMap2(msg.isInMap2)
		RoguelikeModel.instance:checkPlateVisible()
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROOM_INFO_REFRESH)
	end
end

function M:handleMonsterPush(status, msg)
	if status == 0 then
		local monsterId = msg.id

		self._meetMonsterId = monsterId

		if ViewMgr.instance:isOpen(ViewName.RogueMap) or ViewMgr.instance:isOpen(ViewName.RogueSecondaryMap) then
			self:delayShowMeetMonster()
		end
	end
end

function M:delayShowMeetMonster()
	if not self._meetMonsterId then
		return
	end

	ViewMgr.instance:close(ViewName.RogueEventSettlement)
	ViewMgr.instance:open(ViewName.RogueMeetMonster, self._meetMonsterId)

	self._meetMonsterId = nil
end

function M:handleEventPush(status, msg)
	if status == 0 then
		local eventId = msg.id
		local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)
		local replyIds = eventCo.replys or {}

		if #replyIds == 1 then
			local replyCo = RoguelikeConfig.instance:getEventReplyById(replyIds[1])
			local eventType = replyCo.type
		end

		RoguelikeController.instance:enterRogueMeetView(eventId)
	end
end

function M:sendLoadAllRoomPrizesRequest()
	local isInRogue = RoguelikeModel.instance:getIsInRogue()

	if not isInRogue then
		return
	end

	local msg = RoguelikeExtension_pb.LoadAllRoomPrizesRequest()

	self:sendMsg(msg)
end

function M:handleLoadAllRoomPrizesReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_ROOM_PRIZES, msg)
	end
end

function M:handleRoomPrizesUpdatePush(status, msg)
	if status == 0 then
		for k, v in ipairs(msg.prize) do
			if v.taken then
				RoguelikeController.instance:openPropRewardTips(v.id)
			end
		end

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROOM_PRICE_REFRESH, msg)
	end
end

function M:sendMallBuyRequest(id, isRestore)
	local isInRogue = RoguelikeModel.instance:getIsInRogue()

	if not isInRogue then
		return
	end

	local msg = RoguelikeExtension_pb.MallBuyRequest()

	msg.id = id

	self:sendMsg(msg)
end

function M:handleMallBuyReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOP_BUY_SUCCESS)
	end
end

function M:sendMallRestoreStateRequest(heroId, type)
	local isInRogue = RoguelikeModel.instance:getIsInRogue()

	if not isInRogue then
		return
	end

	local msg = RoguelikeExtension_pb.MallRestoreStateRequest()

	msg.heroId = heroId
	msg.type = type

	self:sendMsg(msg)
end

function M:handleMallRestoreStateReply(status, msg)
	if status == 0 then
		print("状态恢复成功")
	end
end

function M:sendGuessDiceRequest(type)
	local isInRogue = RoguelikeModel.instance:getIsInRogue()

	if not isInRogue then
		return
	end

	local msg = RoguelikeExtension_pb.GuessDiceRequest()

	msg.type = type

	self:sendMsg(msg)
end

function M:handleGuessDiceReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_BEGIN_SHOW_GUESS_DICE)
	elseif status == 6011 then
		FloatWordMgr.instance:show("金币不足")
	end
end

function M:sendGuessDiceResultRequest(type)
	local msg = RoguelikeExtension_pb.GuessDiceResultRequest()

	msg.type = type

	self:sendMsg(msg)
end

function M:handleGuessDiceResultReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_GUESS_DICE, msg.result)
	end
end

function M:sendGetGuessNumRequest()
	local msg = RoguelikeExtension_pb.GetGuessNumRequest()

	self:sendMsg(msg)
end

function M:handleGetGuessNumReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_GET_GUESS_DICE_TIME, msg.num)
	end
end

function M:sendGuessDiceGetRewardRequest(index, id)
	local msg = RoguelikeExtension_pb.GuessDiceGetRewardRequest()

	msg.index = index
	msg.id = id
	self._rewardId = id

	self:sendMsg(msg)
end

function M:handleGuessDiceGetRewardReply(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("领取奖励成功")

		local id = self._rewardId

		RoguelikeController.instance:openPropRewardTips(id, function()
			RoguelikeController.instance:execGetProp(id)
		end)
	else
		FloatWordMgr.instance:show("领取奖励失败")
	end
end

function M:sendLuckyDiceRequest(id)
	local msg = RoguelikeExtension_pb.LuckyDiceRequest()

	msg.id = id

	self:sendMsg(msg)
end

function M:handleLuckyDiceReply(status, msg)
	if status == 0 then
		self:sendLoadAllRoomPrizesRequest()
	end
end

function M:sendStartEventRequest(eventId)
	local isInRogue = RoguelikeModel.instance:getIsInRogue()

	if not isInRogue then
		return
	end

	local msg = RoguelikeExtension_pb.StartEventRequest()

	if eventId then
		msg.id = eventId
	end

	self:sendMsg(msg)
end

function M:handleStartEventReply(status, msg)
	if status == 0 then
		print(TableUtil.dump(msg))
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_EVENT_REPLY, msg)
	end
end

function M:handleEffectPush(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_CHANGE_COLLECTOR, msg.changes)
	end
end

function M:sendGetAllEquipRequest()
	local msg = RoguelikeExtension_pb.GetAllEquipRequest()

	self:sendMsg(msg)
end

function M:handleGetAllEquipReply(status, msg)
	if status == 0 then
		RoguelikeModel.instance:updateEquipInfo(msg.equip)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_GET_ALL_ROGUE_EQUIP, msg.equip)
	end
end

function M:sendWearEquipRequest(id)
	local msg = RoguelikeExtension_pb.WearEquipRequest()

	msg.id = id

	self:sendMsg(msg)
end

function M:handleWearEquipReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendUpgradeEquipRequest(id)
	local msg = RoguelikeExtension_pb.UpgradeEquipRequest()

	msg.id = id

	self:sendMsg(msg)
end

function M:handleUpgradeEquipReply(status, msg)
	if status == 0 then
		local id = msg.id
		local lv = msg.lv

		RoguelikeModel.instance:updateEquipLevel(id, lv)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_EQUIP_REFRESH)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_EQUIP_UPGRADE, id, lv)
	end
end

function M:sendUseSkillRequest(heroId, attr, cardIndex)
	local msg = RoguelikeExtension_pb.UseSkillRequest()

	msg.heroId = heroId
	msg.attr = attr
	msg.card = cardIndex or 1

	self:sendMsg(msg)
end

function M:handlerUseSkillReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_EQUIP_REFRESH)
	else
		FloatWordMgr.instance:show("使用技能失败" .. status)
	end
end

function M:sendListTaskRequest()
	local msg = RoguelikeExtension_pb.RoguelikeListTaskRequest()

	self:sendMsg(msg)
end

function M:handleRoguelikeListTaskReply(status, msg)
	if status == 0 then
		local tasks = msg.tasks

		TaskAgent.instance:_updateTask(msg.tasks)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_GET_ALL_TASK, tasks)
	end
end

function M:sendTakeRewardRequest(ids)
	local msg = RoguelikeExtension_pb.RoguelikeTaskRewardRequest()

	for k, v in pairs(ids) do
		table.insert(msg.id, v)
	end

	self:sendMsg(msg)
end

function M:handleRoguelikeTaskRewardReply(status, msg)
	if status == 0 then
		local tasks = msg.tasks

		TaskAgent.instance:_updateTask(msg.tasks)
		GlobalDispatcher:dispatchEvent(EventType.UPDATA_TASKS, false)
		GlobalDispatcher:dispatchEvent(EventType.TASK_TAKE_REWARD_SUC, false)
	end
end

function M:handleRoguelikeRefreshTa(status, msg)
	if status == 0 and msg.refresh then
		self:sendListTaskRequest()
	end
end

function M:sendTouchRequest(id, roleId, attr, cardIndex)
	local msg = RoguelikeExtension_pb.TouchRequest()

	msg.id = id

	if roleId and roleId ~= 0 then
		msg.heroId = roleId
	end

	if attr and attr ~= 0 then
		msg.attr = attr
	end

	msg.card = cardIndex or 1

	self:sendMsg(msg)
end

function M:handleTouchReply(status, msg)
	if status == 0 then
		RoguelikeModel.instance:setTouchIds(msg.touchIds or {})
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_TOUCH_INFO_REFRESH)
	end
end

function M:sendLoadLogsRequest()
	local msg = RoguelikeExtension_pb.LoadLogsRequest()

	self:sendMsg(msg)
end

function M:handleLoadLogsReply(status, msg)
	if status == 0 then
		RoguelikeModel.instance:updateLogInfo(msg)
	end
end

function M:handleMapConfigPush(status, msg)
	if status == 0 then
		RoguelikeModel.instance:updateMapConfig(msg.mapConfig)
	end
end

function M:sendSetCardCdRequest(roleId, cardIndex, cardCd)
	local isInRogue = RoguelikeModel.instance:getIsInRogue()

	if not isInRogue then
		return
	end

	local msg = RoguelikeExtension_pb.SetCardCdRequest()

	msg.hero = roleId
	msg.card = cardIndex
	msg.cd = cardCd

	self:sendMsg(msg)
end

function M:handleSetCardCdReply(status, msg)
	if status == 0 then
		RoguelikeModel.instance:updateTeamInfo(msg.team)
	end
end

function M:sendEndRoundRequest()
	local isInRogue = RoguelikeModel.instance:getIsInRogue()

	if not isInRogue then
		return
	end

	local msg = RoguelikeExtension_pb.EndRoundRequest()

	self:sendMsg(msg)
end

function M:handleEndRoundReply(status, msg)
	if status == 0 then
		RoguelikeModel.instance:updateTeamInfo(msg.team)
	end
end

function M:handleSeedPush(status, msg)
	if status == 0 then
		SpaceX.MyRandomUtils.Seed = msg.seed
		self._seed = msg.seed
	end
end

function M:getSeed()
	return self._seed
end

M.instance = M.New()

return M
