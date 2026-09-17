VerifyLayer = class("VerifyLayer", function()
	return ccexp.VideoPlayer:create()
end)

require("view.Layer.VideoPlayerLayer")

local var_0_0

function VerifyLayer.getInstance(arg_2_0)
	return var_0_0
end

function VerifyLayer.create(arg_3_0)
	local var_3_0 = VerifyLayer.new()

	var_3_0:init()

	return var_3_0
end

function VerifyLayer:init()
	var_0_0 = self
	self.continue = true
	self.loopstart = 4
	self.loopend = 4.98
	self.player = VideoPlayerLayer:create("res/video/verify.mp4")

	self:addChild(self.player)
	self.player:registerEventHandler(3, function()
		self.player:runAction(cc.RemoveSelf:create())
	end)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_0 = nil

			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedule)
		end
	end)
end

function VerifyLayer.invoke(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.schedule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(arg_7_0.schedule)
		arg_7_1()
	end, arg_7_2, false)
end

function VerifyLayer:play()
	self.player:play()
	self:invoke(function()
		self:loop()
	end, self.loopend)
end

function VerifyLayer:loop()
	if self.continue then
		self.player:seekTo(self.loopstart)
		self:invoke(function()
			self:loop(self.player)
		end, self.loopend - self.loopstart)
	end
end

function VerifyLayer.endLoop(arg_13_0)
	arg_13_0.continue = false
end

function VerifyLayer:registerEventHandler(arg_14_1, arg_14_2)
	self.player:registerEventHandler(arg_14_1, arg_14_2)
end
