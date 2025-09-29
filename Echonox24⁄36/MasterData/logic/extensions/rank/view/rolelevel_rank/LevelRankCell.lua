-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/rolelevel_rank/LevelRankCell.lua

module("logic.extensions.rank.view.rolelevel_rank.LevelRankCell", package.seeall)

local M = class("LevelRankCell", ListBinderCell)

function M:Awake()
	self._text_level = goutil.findChildTextComponent(self._go, "stateZJ/txtRank")
	self._go_user = goutil.findChild(self._go, "player_ranking_common_item")
	self._rankUserCell = Astral.LuaComponentContainer.Add(self._go_user, RankUserCell)
end

function M:updateData(data)
	if not data then
		return
	end

	self._rankUserCell:updateData(data)

	self._text_level.text = self:_formatLevel(data:getLevel())
end

function M:_formatLevel(level)
	local a = math.floor(level / 10)
	local b = level % 10

	return string.format("%s-%s", a, b)
end

return M
