local MonsterTile = require("view.Sprite.explore.MonsterTile")
local storyMonsterTile = class("storyMonsterTile", function(arg_1_0)
	return MonsterTile:createNode(arg_1_0)
end)
local explore_manager = require("controller.explore_manager")
local L2Actor = require("view.Sprite.L2Actor")
local model_data = require("data.model_data")

function storyMonsterTile:create(arg_2_1)
	local var_2_0 = storyMonsterTile.new(arg_2_1)

	var_2_0:init(arg_2_1)

	return var_2_0
end

function storyMonsterTile:runTileEvent(arg_3_1)
	(function()
		local var_4_0
		local var_4_1
		local var_4_2
		local var_4_3

		if arg_3_1 then
			var_4_0 = arg_3_1.type
			var_4_1 = arg_3_1.param
			var_4_2 = arg_3_1.des
			var_4_3 = arg_3_1.result_count
		end

		explore_manager:setUniqueMonsterId(self.idx, self.pos)
		explore_manager:beginExploreFight(var_4_1)
		explore_manager:setFightFinishCallback(function(arg_5_0, arg_5_1, arg_5_2)
			local var_5_0 = {
				fightresult = 0,
				room_order = self.parent.curRoomOrder,
				object_idx = self.idx,
				result_type = var_4_0,
				result_param = var_4_1,
				result_count = var_4_3,
				result_des = var_4_2
			}

			self:updateHpBar()

			if arg_5_2 or arg_5_1 < 0 then
				classification = self.tileInfo.result_talk2

				function talkcallback()
					self.parent.root.touchLock = false
				end

				global_basic_scene:addChild(self.tileInfo.result_talk_type == 2 and TalkLayer:create(classification, nil, 1, "", talkcallback) or ExploreTalkLayer:create({
					classification = classification,
					finishCallback = talkcallback
				}), ZORDER_TALKLAYER)
			else
				explore_manager:trigger_event(var_5_0, function(arg_7_0)
					if arg_7_0.result > 0 then
						if not self.tileInfo.result_talk1 and not self.tileInfo.result_talk2 then
							self:updateState()

							if self.finishCallback then
								self.finishCallback({
									tileInfo = self.tileInfo,
									msg = arg_7_0,
									eventconfig = var_5_0
								})
							end

							if self.controller_idx then
								self:trigger_controller()
							end
						else
							local var_7_1 = self.finishCallback
							local var_7_2 = {
								tileInfo = self.tileInfo,
								msg = arg_7_0,
								eventconfig = var_5_0
							}

							local function var_7_3()
								self:updateState()

								if var_7_1 then
									var_7_1(var_7_2)
								end

								if self.controller_idx then
									self:trigger_controller()
								end
							end

							global_basic_scene:addChild(self.tileInfo.result_talk_type == 2 and TalkLayer:create(self.tileInfo.result_talk1, nil, 1, "", var_7_3) or ExploreTalkLayer:create({
								classification = self.tileInfo.result_talk1,
								finishCallback = var_7_3
							}), ZORDER_TALKLAYER)
						end
					elseif self.finishCallback then
						self.finishCallback({
							tileInfo = self.tileInfo,
							msg = arg_7_0,
							eventconfig = var_5_0
						})
					end
				end)
			end

			if arg_5_0 then
				arg_5_0()
			end
		end)
	end)()
end

return storyMonsterTile
