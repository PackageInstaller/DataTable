local TileSprite = require("view.Sprite.explore.TileSprite")
local MonsterTile = class("MonsterTile", function(arg_1_0)
	return TileSprite:createNode(arg_1_0)
end)
local explore_manager = require("controller.explore_manager")
local L2Actor = require("view.Sprite.L2Actor")
local model_data = require("data.model_data")
local var_0_5
local var_0_6
local var_0_7 = config._DEBUG and 0 or 1
local var_0_8 = 0.24
local var_0_9 = {
	[TILE_TYPE.SPECIAL_ENEMY] = "explore/monster_title1.png"
}

function MonsterTile:createNode(arg_2_1)
	return MonsterTile.new()
end

function MonsterTile:create(arg_3_1)
	local var_3_0 = MonsterTile.new(arg_3_1)

	var_3_0:init(arg_3_1)

	return var_3_0
end

function MonsterTile:createIcon(arg_4_1)
	if not self:isTileActive() then
		return false
	end

	var_0_5 = require("data.explore.explore_level_data")
	var_0_6 = require("data.explore.explore_monster_team_data")

	local var_4_0 = self.tileInfo["result" .. (self.parent.usedTile[self.idx].result or 1) .. "_param"]

	assert(var_0_5[self.tileInfo["result" .. (self.parent.usedTile[self.idx].result or 1) .. "_param"]], self.tileInfo["result" .. (self.parent.usedTile[self.idx].result or 1) .. "_param"])
	assert(var_0_5[var_4_0].boss_team, var_4_0)
	assert(var_0_6[var_0_5[var_4_0].boss_team], var_0_5[var_4_0].boss_team)
	assert(var_0_6[var_0_5[var_4_0].boss_team].boss_icon, var_0_5[var_4_0].boss_team)

	local var_4_1 = var_0_6[var_0_5[var_4_0].boss_team].boss_icon

	assert(var_0_6[var_0_5[var_4_0].boss_team].boss_icon, var_0_5[var_4_0].boss_team)
	assert(model_data[var_4_1], var_4_1)

	local var_4_2 = model_data[var_4_1].spine_model
	local var_4_3 = model_data[var_4_1].clothes_model
	local var_4_4 = (self.tileInfo.model_scale or 1) * var_0_8 * (model_data[var_4_1].modelscale > 1.3 and 1.3 or model_data[var_4_1].modelscale)
	local var_4_5 = cc.size(model_data[var_4_1].modelweight, model_data[var_4_1].modelheight)

	self.icon = L2Actor:create(ROLE_SPINE_PATH .. var_4_2 .. ".json", ROLE_SPINE_PATH .. var_4_2 .. ".atlas", (var_4_3 or nil) and (CLOTHES_SPINE_PATH .. var_4_3 .. ".atlas" or nil))
	self.icon.type = "spine"

	self.icon:setScale(var_4_4 * (self.tileInfo.isFlippedX == 1 and -1 or 1), var_4_4)
	self.icon:setContentSize(var_4_5)
	self.icon:playAni(nil, "idle", true)
	self.icon:setPosition(TILE_SIZE / 2, TILE_SIZE / 2)
	self:addChild(self.icon)

	if var_0_9[self.tileInfo.class] then
		local var_4_6

		if config._DEBUG then
			var_4_6 = cc.Sprite:create(var_0_9[self.tileInfo.class]) or cc.Sprite:createWithSpriteFrameName(var_0_9[self.tileInfo.class])
		end

		var_4_6:setAnchorPoint(cc.p(0.5, 1))
		var_4_6:setScale(0.5 / math.abs(self.icon.scale))
		var_4_6:setPosition(self.icon.size.width * math.abs(self.icon.scale) / 2 - 20, self.icon.size.height * math.abs(self.icon.scale) / 2 + 120)
		self.icon:addChild(var_4_6)
	end

	self.icon.type = "spine"
	self.icon.size = var_4_5
	self.icon.scale = var_4_4
	self.scale = var_4_4

	self:createAimTitle()
	self:createRangeIcon()
	self:createHpBar()
end

function MonsterTile:createHpBar()
	if not explore_manager:isHpInherit() then
		return
	end

	local var_5_0 = self.icon:getChildByName("icon_title")
	local var_5_1 = 0
	local var_5_2 = 0

	if var_5_0 then
		var_5_1 = var_5_0:getPositionX()
		var_5_2 = var_5_0:getPositionY()
	else
		var_5_2 = self.icon.size.height * self.icon.scale
	end

	local var_5_3

	if config._DEBUG then
		var_5_3 = cc.Sprite:create("explore/hpInherit/hp_bg_inherit_1.png") or cc.Sprite:createWithSpriteFrameName("explore/hpInherit/hp_bg_inherit_1.png")
	end

	var_5_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_5_3:setPosition(cc.p(var_5_1, var_5_2 + 25))
	self.icon:addChild(var_5_3, 1)

	local var_5_4 = self:getHpInheritInfo() or 1

	self.progressTimer = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("explore/hpInherit/hp_bar_inherit_1.png") or cc.Sprite:createWithSpriteFrameName("explore/hpInherit/hp_bar_inherit_1.png")))

	self.icon:addChild(self.progressTimer, 1, "progressTimer")
	self.progressTimer:setAnchorPoint(cc.p(0.5, 0.5))
	self.progressTimer:setPosition(cc.p(var_5_1 + 8, var_5_2 + 25))
	self.progressTimer:setMidpoint(cc.p(0, 0.5))
	self.progressTimer:setBarChangeRate(cc.p(1, 0))
	self.progressTimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.progressTimer:setPercentage(math.round(var_5_4 * 100))

	self.labelHp = cc.Label:createWithTTF(math.round(var_5_4 * 100) .. "%", "fonts/new1.ttf", 13)

	self.labelHp:setAnchorPoint(cc.p(1, 0.5))
	self.labelHp:setPosition(cc.p(self.progressTimer:getContentSize().width, 6))
	self.labelHp:setAlignment(cc.TEXT_ALIGNMENT_RIGHT, cc.TEXT_ALIGNMENT_CENTER)
	self.labelHp:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	self.progressTimer:addChild(self.labelHp)
	self.labelHp:setVisible(false)
end

function MonsterTile:updateHpBar()
	if not self.progressTimer or not self.labelHp then
		return
	end

	local var_6_0 = self:getHpInheritInfo() or 1

	self.progressTimer:setPercentage(math.round(var_6_0 * 100))
	self.labelHp:setString(math.round(var_6_0 * 100) .. "%")
end

function MonsterTile:getHpInheritInfo()
	local var_7_0

	if self.tileInfo.result1_type then
		var_7_0 = self.tileInfo["result" .. (not self.tileInfo.result2_type and 1 or self.parent.usedTile[self.idx].result and self.parent.usedTile[self.idx].result or 1) .. "_param"]
	end

	local var_7_2 = "_" .. self.idx .. self.pos.x .. self.pos.y

	if not var_7_0 then
		print("getBossInfo error")

		return 1
	end

	local var_7_3 = explore_manager:initBossListInfo(var_7_0)

	if not var_7_3 then
		print("getBossInfo error")

		return 1
	end

	if var_7_3.boss then
		return explore_manager:getHpInherit(var_7_3.boss.id .. var_7_2) or 1
	end

	if not var_7_3.monster then
		return 1
	end

	if #var_7_3.monster == 0 then
		return 1
	end

	local var_7_4 = 0

	for iter_7_0, iter_7_1 in ipairs(var_7_3.monster) do
		var_7_4 = var_7_4 + explore_manager:getHpInherit(iter_7_1.id .. var_7_2) or 1
	end

	return var_7_4 / #var_7_3.monster
end

function MonsterTile:createRangeIcon()
	self.range = ccui.Layout:create()

	self.parent.maskPanel:addChild(self.range)

	for iter_8_0, iter_8_1 in pairs(self.parent.usedTile[self.idx].range) do
		if iter_8_0 ~= self.order and self.tileInfo.trigger_range ~= 0 and self.tileInfo.trigger_range ~= -1 then
			local var_8_0 = ccui.ImageView:create("explore/red_mask.png", var_0_7)

			var_8_0:setAnchorPoint(cc.p(0, 0))

			local var_8_1 = self.parent:transform_index_pos_coordinate(iter_8_0, "index")

			var_8_0:setPosition(var_8_1.x, var_8_1.y)
			self.range:addChild(var_8_0)
		end
	end
end

function MonsterTile:removeIcon()
	if self.icon then
		self.icon:removeFromParent()

		self.icon = nil
	end

	if self.shadow then
		self.shadow:removeFromParent()

		self.shadow = nil
	end

	if self.light then
		self.light:removeFromParent()

		self.light = nil
	end

	if self.range then
		self.range:removeFromParent()

		self.range = nil
	end
end

function MonsterTile:triggerEvent(arg_10_1)
	self.finishCallback = arg_10_1

	local var_10_0

	if self.tileInfo.result1_type then
		local var_10_1 = not self.tileInfo.result2_type and 1 or self.parent.usedTile[self.idx].result and self.parent.usedTile[self.idx].result or 1

		var_10_0 = {
			type = self.tileInfo["result" .. var_10_1 .. "_type"],
			param = self.tileInfo["result" .. var_10_1 .. "_param"],
			des = self.tileInfo["result" .. var_10_1 .. "_des"],
			result_count = var_10_1
		}
	else
		var_10_0 = {}
	end

	self.icon.skeletonAnimation:runAction(cc.Sequence:create(cc.ScaleTo:create(0.15, math.abs(self.icon.scale) * 1.2 * (self.tileInfo.isFlippedX == 1 and -1 or 1), math.abs(self.icon.scale) * 1.2), cc.ScaleTo:create(0.08, math.abs(self.icon.scale) * 0.9 * (self.tileInfo.isFlippedX == 1 and -1 or 1), math.abs(self.icon.scale) * 0.9), cc.ScaleTo:create(0.08, math.abs(self.icon.scale) * 1 * (self.tileInfo.isFlippedX == 1 and -1 or 1), math.abs(self.icon.scale) * 1), cc.CallFunc:create(function()
		local function var_11_0()
			if LayerManager:getActiveLayerName() == "ExploreMapLayer" then
				if self.tileInfo.istofight then
					self:runTileEvent(var_10_0)
				else
					LayerManager:pushInLayer("LevelDetailLayer", {
						fight_type = "EXPLORE",
						mode = self.parent.curMapType,
						level = var_10_0.param,
						callback = function()
							self:runTileEvent(var_10_0)
						end,
						cancelcallback = function()
							if not tolua.isnull(self.parent) then
								self.parent.root.touchLock = false
							end
						end,
						uniqueMonsterId = "_" .. self.idx .. self.pos.x .. self.pos.y
					})
				end
			end
		end

		print("1111111112222233333")
		print(self.tileInfo.trigger_talk, self.tileInfo.trigger_talk_type)

		if self.tileInfo.trigger_talk then
			local var_11_1

			local function var_11_2()
				var_11_0()
			end

			if self.tileInfo.trigger_talk_type == 2 then
				var_11_1 = TalkLayer:create(self.tileInfo.trigger_talk, nil, 1, "", var_11_2)
			else
				print("in")

				var_11_1 = ExploreTalkLayer:create({
					classification = self.tileInfo.trigger_talk,
					finishCallback = var_11_2
				})
			end

			global_basic_scene:addChild(var_11_1, ZORDER_TALKLAYER)
		else
			var_11_0()
		end
	end)))

	local var_10_2 = 0
	local var_10_3 = 0

	if self.tileInfo.title_offset then
		var_10_2, var_10_3 = self.tileInfo.title_offset:match("([^,]+),(.+)")
		var_10_3 = tonumber(var_10_3)
		var_10_2 = tonumber(var_10_2)
	end

	local var_10_4 = ccui.ImageView:create("explore/tanhao.png", var_0_7)

	var_10_4:setAnchorPoint(cc.p(0.5, 0))
	var_10_4:setPosition(self.icon.size.width * math.abs(self.icon.scale) / 2 - 20 + var_10_2, self.icon.size.height * math.abs(self.icon.scale) / 2 + 40 + var_10_3)
	var_10_4:setScale(0.1)
	self.icon:addChild(var_10_4, 9)
	var_10_4:runAction(cc.Sequence:create(cc.ScaleTo:create(0.15, 0.8 / math.abs(self.icon.scale)), cc.ScaleTo:create(0.08, 0.6 / math.abs(self.icon.scale)), cc.ScaleTo:create(0.08, 0.7 / math.abs(self.icon.scale)), cc.RemoveSelf:create()))
end

function MonsterTile:runTileEvent(arg_16_1)
	(function()
		local var_17_0
		local var_17_1
		local var_17_2
		local var_17_3

		if arg_16_1 then
			var_17_0 = arg_16_1.type
			var_17_1 = arg_16_1.param
			var_17_2 = arg_16_1.des
			var_17_3 = arg_16_1.result_count
		end

		explore_manager:setUniqueMonsterId(self.idx, self.pos)
		explore_manager:beginExploreFight(var_17_1)
		explore_manager:setFightFinishCallback(function(arg_18_0, arg_18_1, arg_18_2)
			local var_18_0 = {}

			var_18_0.room_order = self.parent and self.parent.curRoomOrder
			var_18_0.object_idx = self.idx
			var_18_0.fightresult = arg_18_1
			var_18_0.result_type = var_17_0
			var_18_0.result_param = var_17_1
			var_18_0.result_count = var_17_3
			var_18_0.result_des = var_17_2
			var_18_0.isSurrender = arg_18_2

			self:updateHpBar()
			explore_manager:trigger_event(var_18_0, function(arg_19_0)
				if arg_19_0.result > 0 then
					if not self:checkResultEvent() or arg_18_2 then
						local var_19_1 = global_deepCopy(self.tileInfo)

						self:updateState()

						if self.finishCallback then
							self.finishCallback({
								tileInfo = var_19_1,
								msg = arg_19_0,
								eventconfig = var_18_0
							})
						end

						print("?????self.controller_idx", self.tileid, self.controller_idx)

						if self.controller_idx and not arg_18_2 then
							self:trigger_controller()
						end
					else
						local var_19_2 = self.finishCallback
						local var_19_3 = {
							tileInfo = self.tileInfo,
							msg = arg_19_0,
							eventconfig = var_18_0
						}

						self:runResultEvent(function()
							self:updateState()

							if var_19_2 then
								var_19_2(var_19_3)
							end

							if self.controller_idx then
								self:trigger_controller()
							end
						end)
					end
				elseif self.finishCallback then
					self.finishCallback({
						tileInfo = self.tileInfo,
						msg = arg_19_0,
						eventconfig = var_18_0
					})
				end
			end)

			if arg_18_0 then
				arg_18_0()
			end
		end)
	end)()
end

return MonsterTile
