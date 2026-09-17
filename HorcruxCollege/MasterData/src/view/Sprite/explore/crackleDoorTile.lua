local TileSprite = require("view.Sprite.explore.TileSprite")
local crackleDoorTile = class("crackleDoorTile", function(arg_1_0)
	return TileSprite:createNode(arg_1_0)
end)
local explore_manager = require("controller.explore_manager")
local L2Actor = require("view.Sprite.L2Actor")
local item_manager = require("controller.item_manager")
local explore_img_data = require("data.explore.explore_img_data")
local model_data = require("data.model_data")
local tile_data = require("data.explore.tile_data")
local servant_data = require("data.servant_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local item_data = require("data.item_data")
local audio_manager = require("controller.audio_manager")
local audio_module = require("controller.audio_module")
local major_factor_data = require("data.major_factor_data")
local BrokenNode = require("view.Sprite.BrokenNode")

function crackleDoorTile:create(arg_2_1)
	local var_2_0 = crackleDoorTile.new(arg_2_1)

	var_2_0:init(arg_2_1)

	return var_2_0
end

function crackleDoorTile:createCrackle()
	return (BrokenNode:create(self.icon.path))
end

function crackleDoorTile:checkTriggerPrecondition()
	if self.reset == false then
		return
	end

	local var_4_0

	if self.tileInfo.result1_type then
		local var_4_1 = not self.tileInfo.result2_type and 1 or self.parent.usedTile[self.idx].result and self.parent.usedTile[self.idx].result or 1

		var_4_0 = {
			type = self.tileInfo["result" .. var_4_1 .. "_type"],
			param = self.tileInfo["result" .. var_4_1 .. "_param"],
			des = self.tileInfo["result" .. var_4_1 .. "_des"],
			result_count = var_4_1
		}
	else
		var_4_0 = {}
	end

	local function var_4_3()
		self.reset = false
		self.parent.root.touchLock = false

		self:runTileEvent(var_4_0)
		self.parent:playAni("idle")
	end

	local function var_4_4()
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			self.parent:playAni("skill1", var_4_3)
			self:playeffectMusic("sound/400100-attack")
		end)))
	end

	if self.tileInfo.trigger_type > 0 then
		if self.tileInfo.trigger_type ~= 1 then
			if self.tileInfo.trigger_type == 4 then
				local var_4_5 = {
					trigger_type = self.tileInfo.trigger_type,
					needid = self.tileInfo.trigger_param1,
					neednum = self.tileInfo.trigger_param2
				}

				var_4_5.needItems = self:readNeedItems()
				var_4_5.ownnum = explore_manager:getItemNumber(self.tileInfo.trigger_param1)
				var_4_5.des = self.tileInfo.trigger_des

				function var_4_5.surecallback()
					var_4_4()
				end

				function var_4_5.cancelcallback()
					self.parent.root.touchLock = false
				end

				self.parent.root:addChild(self:needKeyPopLayer(var_4_5), 999)
			elseif self.tileInfo.trigger_type == 2 then
				LayerManager:pushInLayer("PopDoLayer", {
					labels = {
						title = "探险信息",
						titleImage = "title_explore_msg.png",
						des = self.tileInfo.trigger_des
					},
					system_figure = self.parent:randomRole(),
					surecallback = function()
						var_4_4()
					end,
					cancelcallback = function()
						self.parent.root.touchLock = false
					end
				})
			elseif self.tileInfo.trigger_type == 3 then
				if explore_manager.curMapConfig.usedTile[self.curRoomOrder][index].usedcount == 0 then
					if self.tileInfo.trigger_param1 then
						global_basic_scene:addChild(self.tileInfo.trigger_param1_talk_type == 2 and TalkLayer:create(self.tileInfo.trigger_param1, nil, 1, "") or ExploreTalkLayer:create({
							classification = self.tileInfo.trigger_param1
						}))
					end

					var_4_4()
				end

				if self.tileInfo.trigger_param2 then
					self.parent.root:addChild(self:npcPopLayer({
						tileInfo = self.tileInfo,
						surecallback = function()
							var_4_4()
						end,
						cancelcallback = function()
							self.parent.root.touchLock = false
						end
					}), 999)
				end
			end
		end
	elseif self.tileInfo.trigger_des then
		if self.tileInfo.trigger_des_type == 2 then
			LayerManager:pushInLayer("PopDoLayer", {
				labels = {
					title = "探险信息",
					titleImage = "title_explore_msg.png",
					des = self.tileInfo.trigger_des
				},
				system_figure = self.parent:randomRole(),
				surecallback = function()
					var_4_4()
				end,
				cancelcallback = function()
					self.parent.root.touchLock = false
				end
			})
		else
			local function var_4_7()
				var_4_4()
			end

			if self.tileInfo.trigger_des_host == 1 then
				self:popTalkSp(self.tileInfo.trigger_des)
			else
				self.parent:popTalkSp(self.tileInfo.trigger_des)
			end

			var_4_7()
		end
	else
		self:runTileEvent(var_4_0)
	end
end

function crackleDoorTile:runTileEvent(arg_18_1, arg_18_2)
	local function var_18_0()
		local var_19_0
		local var_19_1
		local var_19_2

		if arg_18_1 then
			var_19_0 = arg_18_1.type
			var_19_1 = arg_18_1.param
			var_19_2 = arg_18_1.des
		end

		local var_19_5 = {
			room_order = self.parent.curRoomOrder,
			object_idx = self.idx,
			result_type = var_19_0,
			result_param = var_19_1,
			result_des = var_19_2,
			result_count = arg_18_1.result_count
		}

		explore_manager:trigger_event(var_19_5, function(arg_23_0)
			if arg_23_0.result > 0 then
				if not self:checkResultEvent() then
					self:updateState()

					if self.controller_idx then
						self:trigger_controller()
					end

					if self.finishCallback then
						self.finishCallback({
							tileInfo = self.tileInfo,
							msg = arg_23_0,
							eventconfig = var_19_5
						})
					end
				else
					local var_23_0 = self.finishCallback
					local var_23_1 = {
						tileInfo = self.tileInfo,
						msg = arg_23_0,
						eventconfig = var_19_5
					}

					self:runResultEvent(function()
						self:updateState()

						if self.controller_idx then
							self:trigger_controller()
						end

						if var_23_0 then
							var_23_0(var_23_1)
						end
					end)
				end
			elseif self.finishCallback then
				self.finishCallback({
					tileInfo = self.tileInfo,
					msg = arg_23_0,
					eventconfig = var_19_5
				})
			end
		end)
	end

	if self:checkTriggerEvent() then
		self:runTriggerEvent(var_18_0)
	else
		var_18_0()
	end
end

return crackleDoorTile
