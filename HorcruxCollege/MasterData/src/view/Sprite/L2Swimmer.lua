local L2Swimmer = class("L2Swimmer", (require("view.Sprite.L2Actor")))
local model_data = require("data.model_data")
local var_0_2
local var_0_3 = 750
local var_0_4 = 6400
local var_0_5 = 0.1
local var_0_6 = config._DEBUG and 0 or 1
local audio_manager = require("controller.audio_manager")
local swim_node_data = require("data.summer.swim_node_data")

local function var_0_9(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.start_speed or 500
	local var_1_1 = 1

	while arg_1_0["buff" .. var_1_1] do
		if arg_1_1 < arg_1_0["value" .. var_1_1] then
			return var_1_0
		end

		if arg_1_1 <= arg_1_0["value" .. var_1_1] + (var_1_0 + swim_node_data[arg_1_0["buff" .. var_1_1]].speed_add) * swim_node_data[arg_1_0["buff" .. var_1_1]].time then
			return swim_node_data[arg_1_0["buff" .. var_1_1]].speed_add + var_1_0
		end

		var_1_1 = var_1_1 + 1
	end

	return var_1_0
end

function L2Swimmer:create(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = L2Swimmer.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function L2Swimmer:setModel(arg_3_1)
	self._modelId = arg_3_1
end

function L2Swimmer:initNodeEvent()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" and self.schdule then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schdule)

			self.schdule = nil
		end
	end)
end

function L2Swimmer:initSwimAudioNode(arg_6_1)
	local var_6_0 = arg_6_1.start_speed or 500

	self._audioChangeNode = {}

	while arg_6_1["buff" .. 1] do
		table.insert(self._audioChangeNode, {
			arg_6_1["value" .. 1],
			arg_6_1["value" .. 1] + (var_6_0 + swim_node_data[arg_6_1["buff" .. 1]].speed_add) * swim_node_data[arg_6_1["buff" .. 1]].time
		})
	end
end

function L2Swimmer:checkAudioNeed(arg_7_1)
	if not self._audioChangeNode or not next(self._audioChangeNode) then
		return
	end

	if arg_7_1 <= self._audioChangeNode[1][2] and arg_7_1 >= self._audioChangeNode[1][1] then
		audio_manager:playeffectMusicTest("sound/swim")
		table.remove(self._audioChangeNode, 1)
	end
end

function L2Swimmer:startSwim(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self:playAni(nil, "swim", true)
	self:initSwimAudioNode(arg_8_2)

	var_0_2 = arg_8_3

	local var_8_0 = 0

	self.poolMoved = 0
	self.moved = 0
	self.schdule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_9_0)
		local var_9_0 = 0

		if self.poolMoved < var_0_2 then
			var_9_0 = var_0_9(arg_8_1, self.poolMoved)
		end

		local var_9_1 = var_0_9(arg_8_2, self.moved) + var_0_3 / arg_8_2.time

		if var_8_0 > arg_8_2.time then
			var_9_1 = 0
		end

		self:checkAudioNeed(self.moved)
		self:setTimeScale((math.min(math.max(0.6 + (var_9_1 - var_9_0) * var_0_5, 0.6), 4)))
		self:setPositionX(self:getPositionX() + arg_9_0 * (var_9_1 - var_9_0) * var_0_4 / var_0_2)
		self:updateModelOutWindowEffict()

		var_8_0 = var_8_0 + arg_9_0

		if var_8_0 > arg_8_2.time and not self.canShow then
			self.canShow = true

			self:setTimeScale(1)
			self:playAni(nil, "caishui", true)
		end

		if math.max(arg_8_2.time, arg_8_1.time) < var_8_0 then
			self:playAni(nil, "caishui", true)

			if arg_8_4 then
				arg_8_4()
			end

			if self.schdule then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schdule)

				self.schdule = nil
			end
		end

		self.poolMoved = self.poolMoved + arg_9_0 * var_9_0
		self.moved = self.moved + arg_9_0 * var_9_1
	end, 0, false)
end

function L2Swimmer:updateModelOutWindowEffict()
	local var_10_0 = self:getPositionX()
	local var_10_1 = self:getParent():getParent()
	local var_10_2 = var_10_1:getChildByName("out_window_layout")

	if var_10_0 < -30 or var_10_0 > 670 then
		local var_10_3 = math.floor(var_10_0 * 5 / 640)

		if var_10_2 then
			if var_10_3 > 0 then
				var_10_2:getChildByName("distance_lbl"):setString(var_10_3 .. "m")
			else
				var_10_2:getChildByName("distance_lbl"):setString(-var_10_3 .. "m")
			end
		else
			var_10_2 = ccui.Layout:create()

			var_10_2:setName("out_window_layout")
			var_10_2:setPositionY(190)
			var_10_1:addChild(var_10_2)

			local var_10_4 = ccui.ImageView:create("roleimage/role/wuji/" .. model_data[self._modelId].role_image .. ".png")

			var_10_4:setScale(0.4)
			var_10_2:addChild(var_10_4)

			local var_10_5 = ccui.ImageView:create("SchoolSwimLayer/distance_bg.png", var_0_6)

			var_10_5:setPosition(cc.p(var_10_4:getPositionX() - 4, var_10_4:getPositionY() - 50))
			var_10_2:addChild(var_10_5)

			local var_10_6 = cc.Label:createWithTTF("", FONT_TITLE, 22)

			var_10_6:setColor(cc.c3b(0, 0, 0))
			var_10_6:setPosition(cc.p(var_10_5:getPositionX() + 3, var_10_5:getPositionY() - 2))
			var_10_6:setName("distance_lbl")
			var_10_2:addChild(var_10_6)

			if var_10_3 > 0 then
				var_10_5:setScaleX(-1)
				var_10_2:setPositionX(583)
				var_10_6:setString(var_10_3 .. "m")
			else
				var_10_2:setPositionX(57)
				var_10_6:setString(-var_10_3 .. "m")
			end
		end
	elseif var_10_2 then
		var_10_2:removeFromParent()
	end
end

return L2Swimmer
