-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/model/RogueExploreModel.lua

module("logic.extensions.roguelike.model.RogueExploreModel", package.seeall)

local kGameState = {
	Win = 1,
	Fail = 2,
	Gaming = 0
}
local M = class("RogueExploreModel", BaseModel)

function M:onReset()
	return
end

function M:updateExploreInfo(info)
	self._scriptId = info.scriptId
	self._roundGoldCount = info.goldCount
	self._state = info.state
end

function M:setState(state)
	self._state = state
end

function M:updateScripts(infos)
	self._scriptInfos = infos

	if self._scriptId then
		for k, v in ipairs(infos) do
			if v.scriptId == self._scriptId then
				self._curScriptNo = v
			end
		end
	end
end

function M:updateCurScriptNo(no)
	self._curScriptNo = no

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_END_OPTION_SELECT, no)
end

function M:getIsGaming()
	return self._state == kGameState.Gaming or self._state ~= kGameState.Gaming and self:getIsInOptionSelect()
end

function M:getIsGameFinish()
	return self:getIsExploreWin() or self:getIsExploreFail()
end

function M:getIsExploreWin()
	return self._state == kGameState.Win
end

function M:getIsExploreFail()
	return self._state == kGameState.Fail
end

function M:getRoundGoldCount()
	return self._roundGoldCount
end

function M:getCurScriptNO()
	return self._curScriptNo
end

function M:getNeedSelectRole()
	if not self._curScriptNo then
		return false
	end

	local needSelectCard = self._state == kGameState.Gaming and self._curScriptNo.startCard and #self._curScriptNo.startCard == 1

	return needSelectCard
end

function M:getIsInOptionSelect()
	local needSelectCard = self._curScriptNo and self._curScriptNo.startCard and #self._curScriptNo.startCard == 3

	return self:getCurEndOptionCount() ~= 0 or needSelectCard
end

function M:getCurEndOptionCount()
	local count = self._curScriptNo and self._curScriptNo.options and #self._curScriptNo.options or 0

	return count
end

M.instance = M.New()

return M
