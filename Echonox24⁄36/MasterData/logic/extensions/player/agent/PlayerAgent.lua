-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/player/agent/PlayerAgent.lua

module("logic.extensions.player.agent.PlayerAgent", package.seeall)

local M = class("PlayerAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	return
end

function M:sendLoadPlayerRequest()
	local req = PlayerExtension_pb.LoadPlayerRequest()

	self:sendMsg(req)
end

function M:handleLoadPlayerReply(status, loadPlayerReply)
	if status == 0 then
		PlayerModel.instance:updatePlayerInfo(loadPlayerReply)
		self:sendGetPlayerCardInfoRequest(loadPlayerReply.playerInfo.id, true)
		GlobalDispatcher:dispatchEvent(EventType.LOAD_PLAYER_DATA_FINISH)
	else
		GlobalDispatcher:dispatchEvent(EventType.ENTER_GAME_REQUEST_OVER_EVENT, false)
	end
end

function M:handlePlayerInfoPush(status, playerInfo)
	if status == 0 then
		PlayerModel.instance:updatePlayerInfo(playerInfo)
		GlobalDispatcher:dispatchEvent(EventType.UPDATE_PLAYER_INFO_EVENT)
	elseif enableErrorLog then
		printError("PlayerAgent:handlePlayerInfoPush(status, playerInfo)", status)
	end
end

function M:handleEnergyInfoPush(status, energyInfo)
	if status == 0 then
		EnergyRecoverModel.instance:setEnergyRecoverTime(energyInfo.energyInfo.time)
	end
end

function M:handleLevelInfoPush(status, playerLevelInfo)
	if status == 0 then
		PlayerModel.instance:updatePlayerLevelInfo(playerLevelInfo)
		GlobalDispatcher:dispatchEvent(EventType.UPDATE_PLAYER_INFO_EVENT)
	elseif enableErrorLog then
		printError("PlayerAgent:handleLevelInfoPush(status, playerLevelInfo)", status)
	end
end

function M:sendPrologueFinishStageRequest()
	local req = PlayerExtension_pb.PrologueFinishStageRequest()

	self:sendMsg(req)
end

function M:handlePrologueFinishStageReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:sendChangeNicknameRequest(newName)
	local req = PlayerExtension_pb.ChangeNicknameRequest()

	req.newName = newName

	self:sendMsg(req)
end

function M:handleChangeNicknameReply(status, msg)
	if status == 0 then
		PlayerModel.instance:setPrologueChangeNameFinished(true)
		GlobalDispatcher:dispatchEvent(EventType.UPDATE_ROLE_NAME_SUC, msg.newName)
	else
		GlobalDispatcher:dispatchEvent(EventType.UPDATE_ROLE_NAME_FAIL)
	end
end

function M:sendGetPlayerCardInfoRequest(userId, justCacheData)
	local req = PlayerExtension_pb.GetPlayerCardInfoRequest()

	req.userId = userId

	self:invoke({
		funcName = "handleGetPlayerCardInfoReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				local _justCacheData = justCacheData
				local isSelf = msg.info.userId == PlayerModel.instance:getId()

				if isSelf then
					PlayerModel.instance:setMyPlayerInfo(msg.info)
				end

				PlayerModel.instance:setPlayerCardInfo(msg.info)

				if not _justCacheData and not ViewMgr.instance:isOpen(ViewName.PlayerInfoMain) then
					PlayerCourseModel.instance:setCourseUserId(msg.info.userId)
					ViewMgr.instance:open(ViewName.PlayerInfoMain, {
						index = 1,
						isSelf = isSelf
					})
				end

				GlobalDispatcher:dispatchEvent(EventType.UPDATE_PLAYER_INFO_EVENT)
			end
		end
	})
end

function M:sendFinishCreatePlayerRequest(name, portrait, sixTemplate)
	local req = PlayerExtension_pb.FinishCreatePlayerRequest()

	req.nickname = name
	req.image = portrait == 0 and 1 or portrait

	self:invoke({
		funcName = "handleFinishCreatePlayerReply",
		sendData = req,
		handleCall = function(status, msg)
			PlayerCreateController.instance:resetSendState()

			if status == 0 then
				PlayerCreateController.instance:handleCreatedPlayer(msg)
			end
		end
	})
end

function M:sendChangePortraitRequest(portrait)
	local req = PlayerExtension_pb.ChangePortraitRequest()

	req.portrait = portrait

	self:sendMsg(req)
end

function M:handleChangePortraitReply(status, msg)
	if status == 0 then
		PlayerAgent.instance:sendGetPlayerCardInfoRequest(PlayerModel.instance:getId(), true)
		GlobalDispatcher:dispatchEvent(EventType.CHANGE_PLAYER_PORTRAIT_SUC, msg.portrait)
	end
end

function M:sendChangeDisplayCardRequest(itemId)
	local req = PlayerExtension_pb.ChangeDisplayCardRequest()

	req.itemId = itemId

	self:sendMsg(req)
end

function M:handleChangeDisplayCardReply(status, msg)
	if status == 0 then
		PlayerAgent.instance:sendGetPlayerCardInfoRequest(PlayerModel.instance:getId(), true)
		GlobalDispatcher:dispatchEvent(EventType.CHANGE_PLAYER_DISPLAYCARD_SUC, msg.itemId)
	end
end

function M:sendChangeImageRequest(image)
	local req = PlayerExtension_pb.ChangeImageRequest()

	req.image = image

	self:sendMsg(req)
end

function M:handleChangeImageReply(status, msg)
	if status == 0 then
		local playerInfo = PlayerModel.instance:getPlayerCardInfo()

		playerInfo.image = msg.image

		PlayerModel.instance:setPlayerCardInfo(playerInfo)
		GlobalDispatcher:dispatchEvent(EventType.CHANGE_PLAYER_IMAGE_SUC, msg.image)
	end
end

function M:sendChangeDisplayHeroRequest(displayHero)
	local req = PlayerExtension_pb.ChangeDisplayHeroRequest()

	req.displayHero = displayHero

	self:sendMsg(req)
end

function M:handleChangeDisplayHeroReply(status, msg)
	if status == 0 then
		local playerData = PlayerModel.instance:getMyPlayerInfo()

		playerData.displayHero = msg.displayHero
		playerData.displayHeroSkin = msg.displayHeroSkin

		GlobalDispatcher:dispatchEvent(EventType.CHANGE_PLAYER_DISPLAYHERO_SUC, msg.displayHero, msg.displayHeroSkin)
	end
end

function M:sendChangeDisplayHeroSkinRequest(displayHeroSkin)
	local req = PlayerExtension_pb.ChangeDisplayHeroSkinRequest()

	req.displayHeroSkin = displayHeroSkin

	self:sendMsg(req)
end

function M:handleChangeDisplayHeroSkinReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.CHANGE_PLAYER_DISPLAYSKIN_SUC, msg.displayHeroSkin)
	end
end

function M:sendChangeBirthdayRequest(birthday)
	local req = PlayerExtension_pb.ChangeBirthdayRequest()

	req.birthday = birthday

	self:sendMsg(req)
end

function M:handleChangeBirthdayReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.CHANGE_PLAYER_BIRTHDAY_SUC, msg.birthday)
		PlayerAgent.instance:sendGetPlayerCardInfoRequest(PlayerModel.instance:getId(), true)
	end
end

function M:sendChangeSignRequest(leaveMsgMo)
	local req = PlayerExtension_pb.ChangeSignRequest()

	if leaveMsgMo then
		leaveMsgMo:trans2MessageCompositeNO(req.sign)
	end

	self:sendMsg(req)
end

function M:handleChangeSignReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.CHANGE_PLAYER_SIGN_SUC, msg.sign)
		PlayerAgent.instance:sendGetPlayerCardInfoRequest(PlayerModel.instance:getId(), true)
	end
end

function M:sendGetUnlockInfoRequest(typ)
	local req = PlayerExtension_pb.GetUnlockInfoRequest()

	table.insert(req.type, typ)
	self:sendMsg(req)
end

function M:sendGetUnlockGalleryRequestAllTyp()
	local msg = PlayerExtension_pb.GetUnlockInfoRequest()
	local allUnlockTyp = HandbookConfig.instance:getAllUnlockTyp()

	if allUnlockTyp and #allUnlockTyp > 0 then
		for _, typValInt in ipairs(allUnlockTyp) do
			table.insert(msg.type, typValInt)
		end
	end

	self:sendMsg(msg)
end

function M:sendGetUnlockInfoAllTypAirStudio()
	local msg = PlayerExtension_pb.GetUnlockInfoRequest()
	local allUnlockTyp = AirWorkShopConfig.instance:getAllUnlockTyp()

	if allUnlockTyp and #allUnlockTyp > 0 then
		for _, typValInt in ipairs(allUnlockTyp) do
			table.insert(msg.type, typValInt)
		end
	end

	self:sendMsg(msg)
end

function M:handleGetUnlockInfoReply(status, msg)
	if status == 0 then
		local dataLst = msg.data

		HandbookController.instance:onGetUnlockGalleryReply(dataLst)
		AirWorkShopModel.instance:onUnlockInfoReply(dataLst)
	end
end

function M:handleUnlockPush(status, msg)
	if status == 0 then
		if msg.type <= 100 then
			HandbookController.instance:onUnlockPush(msg.type, msg.id)
		else
			AirWorkShopModel.instance:onUnlockInfoPush(msg.type, msg.id)
		end
	end
end

function M:sendUpgradePlayerCardAttributeRequest(id, level)
	local req = PlayerExtension_pb.UpgradePlayerCardAttributeRequest()
	local attribute = PlayerExtension_pb.PlayerCardAttribute()

	attribute.id = id
	attribute.level = level

	table.insert(req.attribute, attribute)
	self:sendMsg(req)
end

function M:handleUpgradePlayerCardAttributeReply(status, msg)
	if status == 0 then
		PlayerAgent.instance:sendGetPlayerCardInfoRequest(PlayerModel.instance:getId(), true)
		GlobalDispatcher:dispatchEvent(EventType.PLAYER_ATTRIBUTE_UPGRADE)
	end
end

function M:sendGetMasterTrainingTaskListRequest()
	return
end

function M:handleGetMasterTrainingTaskListReply(status, msg)
	if status == 0 then
		MasterTrainingTaskModel.instance:updateTaskLst(msg.task)
	end
end

function M:sendFinishMasterTrainingTaskRequest(id)
	local msg = PlayerExtension_pb.FinishMasterTrainingTaskRequest()

	table.insert(msg.id, id)
	self:sendMsg(msg)
end

function M:handleFinishMasterTrainingTaskReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

M.instance = M.New()

return M
