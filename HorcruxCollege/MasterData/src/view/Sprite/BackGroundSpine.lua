local BackGroundSpine = class("BackGroundSpine", function()
	return cc.Node:create()
end)
local background_data = require("data.background_data")
local item_data = require("data.item_data")

function BackGroundSpine:create(arg_2_1, arg_2_2)
	local var_2_0 = BackGroundSpine.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function BackGroundSpine:init(arg_3_1, arg_3_2)
	showgirlInstance = self
	self.backGroundid = arg_3_1
	self.skeletonData = nil
	self.autocollect = arg_3_2
	self._nowjsonfile = nil
	self._nowatlasfile = nil

	self:initDownload()
	self:checkResource({
		json = BACKGROUND_SPINE_PATH .. background_data[self.backGroundid].background_spine .. ".json",
		atlas = BACKGROUND_SPINE_PATH .. background_data[self.backGroundid].background_spine .. ".atlas"
	})
	self:registerTimeEvent()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.skeletonData then
				self.skeletonData:release()

				self.skeletonData = nil
			end

			if self.skeletonAnimation then
				self.skeletonAnimation:removeFromParent()

				self.skeletonAnimation = nil
			end

			SpineCacheManager:removeShowGirlSpineCache(self._nowjsonfile, self._nowatlasfile)
		end
	end)
end

function BackGroundSpine:reset(arg_5_1)
	if arg_5_1 == self.backGroundid then
		return
	end

	self.backGroundid = arg_5_1

	self:checkResource({
		json = BACKGROUND_SPINE_PATH .. background_data[self.backGroundid].background_spine .. ".json",
		atlas = BACKGROUND_SPINE_PATH .. background_data[self.backGroundid].background_spine .. ".atlas"
	})
end

require("controller.filedownloader.download_node_utils"):addDownloadInterface(BackGroundSpine, "Spine")

function BackGroundSpine:onDownloadProcessing()
	if self.skeletonData then
		self.skeletonData:release()

		self.skeletonData = nil

		SpineCacheManager:removeShowGirlSpineCache(self._nowjsonfile, self._nowatlasfile)
	end

	if self._loadingani then
		self._loadingani:setVisible(true)
		self._loadingani:play()

		return
	end

	self._loadingani = require("view.Sprite.LoadingSprite"):create()

	self._loadingani:setPosition(cc.p(GameDisplay.cx - self:getPositionX(), GameDisplay.cy - self:getPositionY()))
	self:addChild(self._loadingani)
end

function BackGroundSpine:onDownloadComplete(arg_7_1)
	if not arg_7_1 then
		return
	end

	if arg_7_1.json ~= BACKGROUND_SPINE_PATH .. background_data[self.backGroundid].background_spine .. ".json" then
		return
	end

	self:refreshSkeleton()

	if self.lastAniName then
		self:play(self.lastAniName, self.lastAniCycled)
	end
end

function BackGroundSpine:refreshSkeleton()
	if self._loadingani then
		self._loadingani:stop()
		self._loadingani:setVisible(false)
	end

	if self.skeletonAnimation then
		self:removeChild(self.skeletonAnimation)

		self.skeletonAnimation = nil
	end

	if self.skeletonData then
		self.skeletonData:release()

		self.skeletonData = nil

		SpineCacheManager:removeShowGirlSpineCache(self._nowjsonfile, self._nowatlasfile)
	end

	local var_8_0 = background_data[self.backGroundid].background_spine

	self.skeletonData = SpineCacheManager:addSpineData(BACKGROUND_SPINE_PATH .. background_data[self.backGroundid].background_spine .. ".json", BACKGROUND_SPINE_PATH .. background_data[self.backGroundid].background_spine .. ".atlas")

	self.skeletonData:retain()

	self.skeletonAnimation = sp.SkeletonAnimation:create(self.skeletonData:getData())

	self:addChild(self.skeletonAnimation)
	self:registerEventListener()

	self._nowjsonfile = BACKGROUND_SPINE_PATH .. var_8_0 .. ".json"
	self._nowatlasfile = BACKGROUND_SPINE_PATH .. var_8_0 .. ".atlas"

	self:play("idle", true)
end

function BackGroundSpine:play(arg_9_1, arg_9_2)
	if arg_9_2 == nil then
		arg_9_2 = true
	end

	if not self.skeletonAnimation then
		self.lastAniName = arg_9_1
		self.lastAniCycled = arg_9_2

		return
	end

	self.skeletonAnimation:setAnimation(0, arg_9_1, arg_9_2)

	self.lastAniName = arg_9_1
	self.lastAniCycled = arg_9_2
end

function BackGroundSpine:addAnimation(arg_10_1, arg_10_2)
	if arg_10_2 == nil then
		arg_10_2 = true
	end

	if not self.skeletonAnimation then
		self.lastAniName = arg_10_1
		self.lastAniCycled = arg_10_2

		return
	end

	self.skeletonAnimation:addAnimation(0, arg_10_1, arg_10_2)

	if self.lastAniName ~= nil then
		self.skeletonAnimation:setMix(self.lastAniName, arg_10_1, 0.1)
	end

	self.lastAniName = arg_10_1
	self.lastAniCycled = arg_10_2
end

function BackGroundSpine:registerTimeEvent()
	local function var_11_0()
		local var_12_0 = 0

		while background_data[self.backGroundid]["spine_touch_ani_" .. var_12_0 + 1] do
			var_12_0 = var_12_0 + 1
		end

		if var_12_0 > 0 then
			local var_12_1 = background_data[self.backGroundid]["spine_touch_ani_" .. math.random(var_12_0)]

			if self.lastAniName == var_12_1 then
				return
			end

			self.lastAniName = var_12_1

			self:addAnimation(var_12_1, false)
		end
	end

	local var_11_1 = {}

	for iter_11_0 = 1, 20 do
		table.insert(var_11_1, math.floor((math.random(30, 90) + math.random(30, 90)) / 2))
	end

	local var_11_2 = 1
	local var_11_3 = cc.Node:create()

	self:addChild(var_11_3)

	local var_11_4 = 0

	var_11_3:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		var_11_4 = var_11_4 + 1

		if var_11_4 == var_11_1[var_11_2] then
			var_11_2 = var_11_2 + 1
			var_11_2 = var_11_2 % #var_11_1 + 1

			var_11_0()

			var_11_4 = 0
		end
	end))))
end

function BackGroundSpine:registerEventListener()
	self.skeletonAnimation:registerSpineEventHandler(function(arg_15_0)
		if arg_15_0.animation ~= "idle" then
			self:play("idle", true)
		end
	end, SP_ANIMATION_COMPLETE)
end

return BackGroundSpine
