-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echoitem/agent/EchoItemAgent.lua

module("logic.extensions.echoitem.agent.EchoItemAgent", package.seeall)

local M = class("EchoItemAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendGetEchoItemInfoRequest()
	local msg = EchoItemExtension_pb.GetEchoItemInfoRequest()

	self:sendMsg(msg)
end

function M:handleGetEchoItemInfoReply(status, msg)
	if status == 0 then
		local items = msg.items

		EchoItemController.instance:refreshEchoItems(items)
	end
end

function M:sendWearEchoItemRequest(uuid, hero)
	local req = EchoItemExtension_pb.WearEchoItemRequest()

	req.uuid = uuid
	req.hero = hero

	self:invoke({
		funcName = "handleWearEchoItemReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				local itemData = ItemModel.instance:getItemDataByUuid(uuid)

				if itemData and hero > 0 then
					FloatWordMgr.instance:show(langF("tip_wear_success", itemData:getName()))
					CriwareAudioFacade.instance:playVoiceByAudioId(CharacterInfoEnum.VoiceResKey.xiedai, hero)
				end

				GlobalDispatcher:dispatchEvent(EventType.ITEM_MODEL_CHANGED_ANY)
			end
		end
	})
end

function M:sendLockEchoItemRequest(uuid, isLock)
	local msg = EchoItemExtension_pb.LockEchoItemRequest()

	msg.uuid = uuid
	msg.locked = isLock

	self:sendMsg(msg)
end

function M:handleLockEchoItemReply(status, msg)
	if status == 0 then
		if enableLog then
			printWarn("~~~~~~锁定/解锁操作成功")
		end

		local isUpgrade = false

		GlobalDispatcher:dispatchEvent(EventType.ECHO_ITEM_INFO_REFRESH, isUpgrade)
	end
end

function M:sendUpgradeEchoItemRequest(target, uuidList)
	TipsBlockController.instance:setBlockMark(TipsBlockUtil.BlockMark.EchoUpgrade, true)
	EchoItemMainController.instance:setIsUpgradingEcho(true)

	local msg = EchoItemExtension_pb.UpgradeEchoItemRequest()

	msg.target = target

	for _, id in ipairs(uuidList) do
		table.insert(msg.sources, id)
	end

	self:sendMsg(msg)
end

function M:handleUpgradeEchoItemReply(status, msg)
	if status == 0 then
		if enableLog then
			printWarn("~~~~~~升级成功")
		end

		local isUpgrade = true

		GlobalDispatcher:dispatchEvent(EventType.ECHO_ITEM_INFO_REFRESH, isUpgrade)
		EchoItemMainController.instance:clearCostEchoItemForBreakList(isUpgrade)
	else
		TipsBlockController.instance:setBlockMark(TipsBlockUtil.BlockMark.EchoUpgrade, false)
	end

	EchoItemMainController.instance:setIsUpgradingEcho(false)
end

function M:sendDecomposeEchoItemRequest(uuids)
	local msg = EchoItemExtension_pb.DecomposeEchoItemRequest()

	for _, id in ipairs(uuids) do
		table.insert(msg.uuids, id)
	end

	self:sendMsg(msg)
end

function M:handleDecomposeEchoItemReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_RECYCLE_REPLY, CommEnum.MainBackpackShowType.EchoShowType)
	end
end

function M:handleChangeEchoItemPush(status, msg)
	if status == 0 then
		if enableLog then
			printWarn("~~~~~~~回响物有变更")
		end

		local items = msg.items

		EchoItemController.instance:refreshEchoItems(items)
	end
end

M.instance = M.New()

return M
