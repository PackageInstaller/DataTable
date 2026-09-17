local TileSprite = require("view.Sprite.explore.TileSprite")
local ControllerSprite = class("ControllerSprite", function(arg_1_0)
	return TileSprite:createNode(arg_1_0)
end)
local explore_manager = require("controller.explore_manager")

function ControllerSprite:create(arg_2_1)
	local var_2_0 = ControllerSprite.new(arg_2_1)

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ControllerSprite:init(arg_3_1)
	self.initConfig = arg_3_1
	self.tileInfo = arg_3_1.tileInfo
	self.parent = arg_3_1.parent
	self.tileid = arg_3_1.tileInfo.id
	self.idx = arg_3_1.idx
	self.order = arg_3_1.order
	self.pos = arg_3_1.pos
	self.zOrder = arg_3_1.zOrder
	self.fullImage = arg_3_1.fullImage
	self.size_num = arg_3_1.size_num
	self.controller_idx = self.parent.usedTile[self.idx].controller

	self:setPosition(self.pos)
	self:setName(self.order .. "object")
	self.parent.iconLayout:addChild(self, self.zOrder)
	self:createIcon()
end

function ControllerSprite:runTileEvent()
	local function var_4_0()
		local var_5_0 = {
			room_order = self.parent.curRoomOrder,
			object_idx = self.idx
		}

		explore_manager:trigger_event(var_5_0, function(arg_6_0)
			if arg_6_0.result > 0 then
				self:updateState()

				if self.finishCallback then
					self.finishCallback({
						tileInfo = self.tileInfo,
						msg = arg_6_0,
						eventconfig = var_5_0
					})
				end

				if self.parent.tileobjects[self.controller_idx] then
					self.parent.tileobjects[self.controller_idx]:updateState(true)
					self.parent:popTalkSp(self.tileInfo.controller_des or L_EXPLORE_CONTROLLER_OPEN)
				end
			elseif self.finishCallback then
				self.finishCallback({
					tileInfo = self.tileInfo,
					msg = arg_6_0,
					eventconfig = var_5_0
				})
			end
		end)
	end

	if self.tileInfo.trigger_talk then
		local function var_4_2()
			var_4_0()
		end

		global_basic_scene:addChild(self.tileInfo.trigger_talk_type == 2 and TalkLayer:create(self.tileInfo.trigger_talk, nil, 1, "", var_4_2) or ExploreTalkLayer:create({
			classification = self.tileInfo.trigger_talk,
			finishCallback = var_4_2
		}), ZORDER_TALKLAYER)
	else
		var_4_0()
	end
end

return ControllerSprite
