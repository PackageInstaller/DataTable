local TileSprite = require("view.Sprite.explore.TileSprite")
local TalkTile = class("TalkTile", function(arg_1_0)
	return TileSprite:createNode(arg_1_0)
end)
local explore_manager = require("controller.explore_manager")
local item_manager = require("controller.item_manager")

local function var_0_4(arg_2_0)
	if not arg_2_0 then
		return
	end

	local var_2_0 = {}

	if type(arg_2_0) == "number" then
		var_2_0 = {
			{
				roomorder = self.parent.curRoomOrder,
				controller_idx = arg_2_0
			}
		}
	elseif type(arg_2_0) == "string" then
		for iter_2_0 in arg_2_0:gmatch("([^,]+)") do
			local var_2_1
			local var_2_2

			if string.find(iter_2_0, "-") then
				var_2_1, var_2_2 = iter_2_0:match("([^-]+)-([^-]+)")
				var_2_2 = tonumber(var_2_1)
				var_2_1 = tonumber(var_2_1)
			else
				var_2_1 = self.parent.curRoomOrder
				var_2_2 = tonumber(iter_2_0)
			end

			var_2_0[#var_2_0 + 1] = {
				roomorder = var_2_1,
				controller_idx = var_2_2
			}
		end
	end

	return var_2_0
end

function TalkTile:create(arg_3_1)
	local var_3_0 = TalkTile.new(arg_3_1)

	var_3_0:init(arg_3_1)
	var_3_0:initother()

	return var_3_0
end

function TalkTile:initother()
	self.select_talk_conf = {}
	self.main_talkid = self.tileInfo.trigger_talk

	while self.tileInfo["select_talk" .. 1] do
		table.insert(self.select_talk_conf, {
			index = 1,
			talkid = self.tileInfo["select_talk" .. 1],
			unlock_type = self.tileInfo["unlock_type" .. 1],
			unlock_param1 = self.tileInfo["unlock_param" .. 1 .. "_1"],
			unlock_param2 = self.tileInfo["unlock_param" .. 1 .. "_2"],
			unlock_des = self.tileInfo["unlock_des" .. 1],
			result_type = self.tileInfo["result_type" .. 1],
			result_param1 = self.tileInfo["result_param" .. 1 .. "_1"],
			result_param2 = self.tileInfo["result_param" .. 1 .. "_2"],
			result_des = self.tileInfo["result_des" .. 1],
			finished_tile = self.tileInfo["finished_tile" .. 1],
			finished_image = self.tileInfo["finished_image" .. 1],
			is_trigger_now = self.tileInfo["is_trigger_now" .. 1],
			controller_idx = var_0_4(self.tileInfo["controller" .. 1]),
			controller_des = self.tileInfo["controller_des" .. 1]
		})
	end
end

function TalkTile:triggerEvent(arg_5_1)
	self.finishCallback = arg_5_1

	print(":::::::::::ExploreTalkLayer:::::::::::", dump(self.select_talk_conf))

	local var_5_0 = ExploreTalkLayer:create({
		classification = self.main_talkid,
		finishCallback = function(arg_6_0)
			print("talkcallback>>>>>>>>>>>>>>>>>>", dump(arg_6_0))

			local var_6_0 = {}

			for iter_6_0, iter_6_1 in pairs(arg_6_0) do
				var_6_0[iter_6_1] = true
			end

			local var_6_1

			for iter_6_2, iter_6_3 in ipairs(self.select_talk_conf) do
				if var_6_0[iter_6_3.talkid] then
					var_6_1 = iter_6_2

					break
				end
			end

			self.select_index = var_6_1

			assert(self.select_index, "ERROR, CALL JinHong, 格子表中没有对话选项的匹配项")
			self:runTileEvent()
		end,
		select_talk_conf = self.select_talk_conf
	})

	var_5_0:setName("ExploreTalkLayer")
	global_basic_scene:addChild(var_5_0, 999)
end

function TalkTile:runTileEvent()
	local var_7_0 = self.select_talk_conf[self.select_index]

	local function var_7_1()
		local var_8_5 = {
			room_order = self.parent.curRoomOrder,
			object_idx = self.idx,
			result_type = var_7_0.result_type,
			result_param = var_7_0.result_param1,
			result_des = var_7_0.result_des,
			result_count = var_7_0.index,
			aim_condition = var_7_0.talkid
		}

		explore_manager:trigger_event(var_8_5, function(arg_9_0)
			if arg_9_0.result > 0 then
				if not self:checkResultEvent() then
					self:updateState()
					print("select_info.controller_idx>>>>>>>>>>>>>>", dump(var_7_0.controller_idx))

					if var_7_0.controller_idx then
						self:trigger_controller()
					end

					if self.tileInfo.puzzleids then
						self.parent:checkPuzzle(self.tileid)
					end

					if self.finishCallback then
						self.finishCallback({
							tileInfo = global_deepCopy(self.tileInfo),
							msg = arg_9_0,
							eventconfig = var_8_5
						})
					end
				else
					local var_9_0 = self.finishCallback
					local var_9_1 = {}

					var_9_1.tileInfo = global_deepCopy(self.tileInfo)
					var_9_1.msg = arg_9_0
					var_9_1.eventconfig = var_8_5

					self:runResultEvent(function()
						self:updateState()

						if var_7_0.controller_idx then
							self:trigger_controller()
						end

						if self.tileInfo.puzzleids then
							self.parent:checkPuzzle(self.tileid)
						end

						if var_9_0 then
							var_9_0(var_9_1)
						end
					end)
				end
			elseif self.finishCallback then
				self.finishCallback({
					tileInfo = self.tileInfo,
					msg = arg_9_0,
					eventconfig = var_8_5
				})
			end
		end)
	end

	local var_7_2 = {
		[3] = function()
			var_7_1()
		end,
		[4] = function()
			local var_12_4 = {
				room_order = self.parent.curRoomOrder,
				object_idx = self.idx,
				result_type = var_7_0.result_type,
				result_param = result_param1,
				result_des = var_7_0.result_des,
				result_count = var_7_0.index
			}

			explore_manager:beginExploreFight(var_7_0.result_param1)
			explore_manager:setFightFinishCallback(function(arg_13_0, arg_13_1, arg_13_2)
				var_12_4.fightresult = arg_13_1
				var_12_4.isSurrender = arg_13_2

				explore_manager:trigger_event(var_12_4, function(arg_14_0)
					if arg_14_0.result > 0 then
						if not self.tileInfo.result_talk or arg_13_2 then
							local var_14_1 = global_deepCopy(self.tileInfo)

							self:updateState()

							if self.finishCallback then
								self.finishCallback({
									tileInfo = var_14_1,
									msg = arg_14_0,
									eventconfig = var_12_4
								})
							end

							if var_7_0.controller_idx then
								self:trigger_controller()
							end
						else
							local var_14_2 = self.finishCallback
							local var_14_3 = {
								tileInfo = self.tileInfo,
								msg = arg_14_0,
								eventconfig = var_12_4
							}

							local function var_14_4()
								self:updateState()

								if var_14_2 then
									var_14_2(var_14_3)
								end

								if var_7_0.controller_idx then
									self:trigger_controller()
								end
							end

							global_basic_scene:addChild(self.tileInfo.result_talk_type == 2 and TalkLayer:create(self.tileInfo.result_talk, nil, 1, "", var_14_4) or ExploreTalkLayer:create({
								classification = self.tileInfo.result_talk,
								finishCallback = var_14_4
							}), ZORDER_TALKLAYER)
						end
					elseif self.finishCallback then
						self.finishCallback({
							tileInfo = self.tileInfo,
							msg = arg_14_0,
							eventconfig = var_12_4
						})
					end
				end)

				if arg_13_0 then
					arg_13_0()
				end
			end)
		end,
		[7] = function()
			var_7_1()
		end
	}

	if var_7_2[self.select_talk_conf[self.select_index].result_type] then
		var_7_2[self.select_talk_conf[self.select_index].result_type]()
	else
		var_7_1()
	end
end

function TalkTile:updateState(arg_17_1)
	if not arg_17_1 and self:isTileActive() then
		return
	end

	print(">>>>>>>>>>>>self.select_index", self.select_index, dump(self.select_talk_conf))

	local var_17_0 = self.select_talk_conf[self.select_index or 1]

	if self.select_talk_conf[self.select_index or 1].finished_tile then
		self:reset({
			tileInfo = explore_manager.getCurData("tile", self.parent.curMapType)[var_17_0.finished_tile],
			size_num = cc.size(explore_manager:getTileSize(var_17_0.finished_tile))
		})

		if var_17_0.is_trigger_now then
			local var_17_1 = self.idx

			global_basic_scene:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
				print("select_info.is_trigger_now>>>>>>>>>>>", var_17_1)
				ExploreMapLayer.getInstance().curRoomMap:triggerEvent(var_17_1)
			end)))
		end
	elseif var_17_0.finished_image then
		self:releaseSelf()
		self:finishAddImg()
		explore_manager:update_img_config({
			imgid = var_17_0.finished_image,
			order = self.order,
			roomorder = self.parent.curRoomOrder,
			room_img_layer = self.parent.curRoomInfo.imglayer,
			room_size_num = cc.size(self.parent.room_width_num, self.parent.room_height_num)
		})
	else
		self:releaseSelf()
	end
end

function TalkTile:trigger_controller()
	local tile_data = require("data.explore.tile_data")

	for iter_19_0, iter_19_1 in pairs(self.select_talk_conf[self.select_index].controller_idx) do
		if iter_19_1.roomorder == self.parent.curRoomOrder then
			if self.parent.tileobjects[iter_19_1.controller_idx] then
				self.parent.tileobjects[iter_19_1.controller_idx]:updateState(true)
			end
		else
			explore_manager:updateObjectState(iter_19_1.roomorder, iter_19_1.controller_idx)
		end
	end

	local var_19_1 = self.select_talk_conf[self.select_index].controller_des or L_EXPLORE_CONTROLLER_OPEN

	if var_19_1 ~= "kong" then
		self.parent:popTalkSp(var_19_1)
	end
end

return TalkTile
