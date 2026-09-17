local MonopolyRankListLayer = class("MonopolyRankListLayer", function()
	require("view.Layer.RankListBaseLayer")

	return RankListBaseLayer.new()
end)
local expedition_manager = require("controller.expedition_manager")

function MonopolyRankListLayer:create(...)
	return MonopolyRankListLayer.new(...)
end

function MonopolyRankListLayer:ctor(...)
	self:init(...)
end

function MonopolyRankListLayer:DisplayRankList()
	expedition_manager:get_expedition_rank_list(function(arg_5_0)
		self.data = arg_5_0

		self:initTableView()
	end)
end

return MonopolyRankListLayer
