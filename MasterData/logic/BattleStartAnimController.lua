-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlestartanim/controller/BattleStartAnimController.lua

module("logic.extensions.battlestartanim.controller.BattleStartAnimController", package.seeall)

local BattleStartAnimController = class("BattleStartAnimController", BaseController)

BattleStartAnimController.KeyWordSeeSelf = "BattleStartAnimSeeSelf"
BattleStartAnimController.KeyWordSeeSelfBattleBg = "BattleStartAnimSeeSelfBattleBg"

function BattleStartAnimController:ctor()
	return
end

function BattleStartAnimController:onInit()
	return
end

function BattleStartAnimController:onReset()
	return
end

function BattleStartAnimController:isSeeSelfBattleStartAnim()
	return GameUtil.getUserData(BattleStartAnimController.KeyWordSeeSelf)
end

function BattleStartAnimController:saveKeyWordSeeSelf(isSeeSelf)
	GameUtil.saveUserData(BattleStartAnimController.KeyWordSeeSelf, isSeeSelf)
end

function BattleStartAnimController:isSeeSelfBattleBg()
	return GameUtil.getUserData(BattleStartAnimController.KeyWordSeeSelfBattleBg)
end

function BattleStartAnimController:saveKeyWordSeeSelfBattleBg(isSeeSelf)
	GameUtil.saveUserData(BattleStartAnimController.KeyWordSeeSelfBattleBg, isSeeSelf)
end

function BattleStartAnimController:sendPM_LoadAllUniquePropsReq()
	UniquePropAgent.instance:sendPM_LoadAllUniquePropsReq()
end

function BattleStartAnimController:sendPM_GetOtherUniquePropsReq(type, targetUserId)
	UniquePropAgent.instance:sendPM_GetOtherUniquePropsReq(type, targetUserId)
end

function BattleStartAnimController:loadInfoOnLogin()
	self:sendPM_LoadAllUniquePropsReq()
end

function BattleStartAnimController:isOpenExteriorRule(key)
	return GameUtil.getUserData(key)
end

function BattleStartAnimController:openExteriorRulePopView(key, id)
	local data = {}

	if id == 1 then
		data.title = BattleStartAnimConfig.instance:getCommonCfg("battlestarttitle")
		data.list = {}

		local item = {}

		item.url = "ui/bigbg/playerinfobg/battlerule_1.png"
		item.desc = BattleStartAnimConfig.instance:getCommonCfg("battlestartdesc")

		table.insert(data.list, item)
	elseif id == 2 then
		data.title = BattleStartAnimConfig.instance:getCommonCfg("playerinfotitle")
		data.list = {}

		local item = {}

		item.url = "ui/bigbg/playerinfobg/battlerule_2.png"
		item.desc = BattleStartAnimConfig.instance:getCommonCfg("playerinfodesc")

		table.insert(data.list, item)
	elseif id == 3 then
		local data = {}

		data.title = BattleStartAnimConfig.instance:getCommonCfg("playermessagetitle")
		data.list = {}

		local item = {}

		item.url = "ui/bigbg/playerinfobg/battlerule_2.png"
		item.desc = BattleStartAnimConfig.instance:getCommonCfg("playermessagedesc")

		table.insert(data.list, item)
	end

	GameUtil.saveUserData(key, true)
	TipsFacade.instance:openImageRuleView(data.list, data.title)
end

BattleStartAnimController.instance = BattleStartAnimController.New()

return BattleStartAnimController
