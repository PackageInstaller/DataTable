-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaWeekReward.lua

module("logic.extensions.arena.view.ArenaWeekReward", package.seeall)

local ArenaWeekReward = class("ArenaWeekReward")
local LuaComponentContainer = Framework.LuaComponentContainer

function ArenaWeekReward.AddOnce(go)
	local component = ArenaWeekReward.Get(go)

	component = component or LuaComponentContainer.Add(go, ArenaWeekReward)

	return component
end

function ArenaWeekReward.Remove(go)
	LuaComponentContainer.Remove(go, ArenaWeekReward)
end

function ArenaWeekReward.Get(go)
	return (LuaComponentContainer.Get(go, ArenaWeekReward))
end

function ArenaWeekReward:ctor(container)
	self._container = container
end

function ArenaWeekReward:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.ArenaGainWeekReward, self._updateRewardBtn, self)

	local Txt_Top = goutil.findChildTextComponent(self._container, "Txt_Top")

	Txt_Top.text = ArenaModel.instance:getBestPositionEver()

	local winGetTxt = goutil.findChildTextComponent(self._container, "pnl_txt/winGetTxt")
	local lostGetTxt = goutil.findChildTextComponent(self._container, "pnl_txt/lostGetTxt")

	winGetTxt.text = ArenaConfig.instance:getValue("WIN_ADD_ARENA_SCORE")
	lostGetTxt.text = ArenaConfig.instance:getValue("LOST_ADD_ARENA_SCORE")

	local zoneId = ArenaModel.instance:getZoneId()
	local topGroupId = ArenaModel.instance:getTopGroupId()
	local cfg = ArenaConfig.instance:getArenaTopGroupCfgById(topGroupId)
	local nowCfg = ArenaConfig.instance:getArenaTopGroupCfgById(ArenaModel.instance:getTopGroupId())

	self:_updateRewardBtn()
end

function ArenaWeekReward:_updateRewardBtn()
	return
end

function ArenaWeekReward:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.ArenaGainWeekReward, self._updateRewardBtn, self)
end

return ArenaWeekReward
