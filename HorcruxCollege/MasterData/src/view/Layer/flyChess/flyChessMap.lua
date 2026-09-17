flyChessMap = class("flyChessMap", function()
	return ccui.Layout:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = {}

var_0_4[0] = "/start_grid.png"
var_0_4[1] = "/normal_grid.png"
var_0_4[2] = "/reward_grid.png"
var_0_4[3] = "/elite_enemy_grid.png"
var_0_4[4] = "/reward_grid.png"
var_0_4[5] = "/dice_again.png"
var_0_4[6] = "/forward_small.png"
var_0_4[7] = "/forward_big.png"
var_0_4[8] = "/add_explore.png"
var_0_4[9] = "/build_grid.png"

function flyChessMap.create(arg_2_0, arg_2_1)
	local var_2_0 = flyChessMap.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function flyChessMap:init(arg_3_1)
	self.activityId = arg_3_1.activityId
	self.resPath = "activity_flyChess_" .. self.activityId
	self.map_grids = {}

	self:initGrids()
end

function flyChessMap:initGrids()
	self.map_infos = activity_manager:getFlychessAllInfo(self.activityId).map_infos
	self.grids_num = activity_manager:getFlychessConf(self.activityId).grids_num

	local var_4_0 = {
		1,
		(self.grids_num - 8) / 2,
		(self.grids_num - 8) / 2 + 5,
		self.grids_num - 4
	}

	for iter_4_0 = 1, self.grids_num do
		local var_4_1

		if iter_4_0 >= var_4_0[1] and iter_4_0 <= var_4_0[2] then
			var_4_1 = cc.p(90, 300 + 92 * (iter_4_0 - var_4_0[1]))
		end

		if iter_4_0 > var_4_0[2] and iter_4_0 <= var_4_0[3] then
			var_4_1 = cc.p(90 + 95 * (iter_4_0 - var_4_0[2]), 300 + 92 * (var_4_0[2] - var_4_0[1]))
		end

		if iter_4_0 > var_4_0[3] and iter_4_0 <= var_4_0[4] then
			var_4_1 = cc.p(90 + 5 * 95, 300 + 92 * (var_4_0[2] - var_4_0[1]) - 92 * (iter_4_0 - var_4_0[3]))
		end

		if iter_4_0 > var_4_0[4] then
			var_4_1 = cc.p(90 + 5 * 95 - 95 * (iter_4_0 - var_4_0[4]), 300)
		end

		local var_4_2

		if self.map_infos[iter_4_0] then
			var_4_2 = self.map_infos[iter_4_0].eventType or var_0_3

			if iter_4_0 == 1 then
				var_4_2 = var_0_2
			end
		end

		local var_4_3 = ccui.ImageView:create(self.resPath .. var_0_4[var_4_2], var_0_0)

		self:addChild(var_4_3)
		var_4_3:setPosition(var_4_1)
		var_4_3:setTouchEnabled(true)
		table.insert(self.map_grids, var_4_3)
	end
end

function flyChessMap:updateAllGrids(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		self.map_grids[iter_5_0]:loadTexture(self.resPath .. var_0_4[(iter_5_0 == 1 or nil) and var_0_2], var_0_0)
	end
end

function flyChessMap:attachPlayer(arg_6_1)
	self.player = arg_6_1

	self:addChild(arg_6_1)
end
