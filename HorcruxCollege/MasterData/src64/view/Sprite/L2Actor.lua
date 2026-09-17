SP_ANIMATION_START = 0
SP_ANIMATION_END = 2
SP_ANIMATION_COMPLETE = 3
SP_ANIMATION_EVENT = 5

require("view.Sprite.TalkBubbleSprite")

local L2Skeleton = class("L2Skeleton", function()
	return cc.Node:create()
end)

function L2Skeleton:create(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = L2Skeleton.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function L2Skeleton:init(arg_3_1, arg_3_2, arg_3_3)
	self.jsonFilePath = arg_3_1
	self.atlasFilePath = arg_3_2
	self.clothesFilePath = arg_3_3
	self.scale = 1
	self.dir = 1
	self.size = cc.size(81, 370)
	self._pause = false
	self._datarefcount = 0
	self._scaleX = 1
	self._scaleY = 1
	self._timescale = 1
	self.aniListener = {}

	self:initDownload()
	self:refreshSkeleton()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "enter" then
			self._datarefcount = self._datarefcount + 1

			if self.skeletonData then
				self.skeletonData:retain()
			end
		elseif arg_4_0 == "exit" then
			self._datarefcount = self._datarefcount - 1

			if self.skeletonData then
				self.skeletonData:release()
			end
		end
	end)
end

function L2Skeleton:retain()
	cc.Ref.retain(self)

	self._datarefcount = self._datarefcount + 1

	if self.skeletonData then
		self.skeletonData:retain()
	end
end

function L2Skeleton:release()
	cc.Ref.release(self)

	self._datarefcount = self._datarefcount - 1

	if self.skeletonData then
		self.skeletonData:release()
	end
end

function L2Skeleton:updateSpine(arg_7_1, arg_7_2, arg_7_3)
	self.jsonFilePath = arg_7_1
	self.atlasFilePath = arg_7_2
	self.clothesFilePath = arg_7_3
	self._lastAni = nil
	self._lastAniCycled = nil
	self._scaleX = 1
	self._scaleY = 1
	self._timescale = 1

	self:refreshSkeleton()
end

function L2Skeleton:refreshSkeleton()
	self:checkResource({
		json = self.jsonFilePath,
		atlas = self.atlasFilePath
	})
end

function L2Skeleton:drawSkeleton()
	if self.skeletonAnimation then
		self:removeChild(self.skeletonAnimation)

		self.skeletonAnimation = nil
	end

	if self.skeletonData then
		self.skeletonData:release(self._datarefcount)

		self.skeletonData = nil
	end

	self.skeletonData = SpineCacheManager:addSpineData(self.jsonFilePath, self.atlasFilePath, self.clothesFilePath)

	self.skeletonData:retain(self._datarefcount)

	self.skeletonAnimation = sp.SkeletonAnimation:create(self.skeletonData:getData())

	self:addChild(self.skeletonAnimation)
	self:registerEventHandler()
end

require("controller.filedownloader.download_node_utils"):addDownloadInterface(L2Skeleton, "Spine")

function L2Skeleton:onDownloadComplete(arg_10_1)
	if not arg_10_1 then
		return
	end

	self.jsonFilePath = arg_10_1.json
	self.atlasFilePath = arg_10_1.atlas

	self:drawSkeleton()

	if self._lastAni then
		self:playAni(nil, self._lastAni, self._lastAniCycled)
	end

	self:setTimeScale(self._timescale)
	self:setScale(self._scaleX, self._scaleY)
end

function L2Skeleton:setScale(arg_11_1, arg_11_2)
	self.dir = arg_11_1 > 0 and 1 or -1
	self.scale = math.abs(arg_11_1)
	self._scaleX = arg_11_1
	self._scaleY = arg_11_2

	self.skeletonAnimation:setScale(arg_11_1, arg_11_2)
end

function L2Skeleton:setTimeScale(arg_12_1)
	self._timescale = arg_12_1

	self.skeletonAnimation:setTimeScale(arg_12_1)
end

function L2Skeleton:setContentSize(arg_13_1)
	self.size = arg_13_1
end

function L2Skeleton:registerEventHandler()
	self.skeletonAnimation:registerSpineEventHandler(function(arg_15_0)
		if self.aniListener[arg_15_0.animation] then
			self.aniListener[arg_15_0.animation]()
		end
	end, SP_ANIMATION_COMPLETE)
end

function L2Skeleton:pauseAni()
	if not self._pause then
		local function var_16_0(arg_17_0)
			arg_17_0:pause()

			for iter_17_0, iter_17_1 in pairs(arg_17_0:getChildren()) do
				var_16_0(iter_17_1)
			end
		end

		var_16_0(self)

		self._pause = true
	end
end

function L2Skeleton:resumeAni()
	if self._pause then
		local function var_18_0(arg_19_0)
			arg_19_0:resume()

			for iter_19_0, iter_19_1 in pairs(arg_19_0:getChildren()) do
				var_18_0(iter_19_1)
			end
		end

		var_18_0(self)

		self._pause = false
	end
end

function L2Skeleton:getBoundingBox()
	if not self.skeletonAnimation then
		return cc.rect(0, 0, 0, 0)
	end

	return self.skeletonAnimation:getBoundingBox()
end

local var_0_1 = setmetatable({}, {
	__index = function(arg_21_0, arg_21_1)
		return L2Skeleton[arg_21_1]
	end
})

function L2Skeleton:execute(arg_22_1, arg_22_2, ...)
	var_0_1[arg_22_1](self, arg_22_2, ...)
end

function L2Skeleton:moveTo(arg_23_1, arg_23_2, arg_23_3)
	self:runAction(cc.Sequence:create(cc.MoveTo:create(arg_23_2, arg_23_3), cc.CallFunc:create(function()
		if arg_23_1 then
			arg_23_1()
		end
	end)))
end

function L2Skeleton:moveBy(arg_25_1, arg_25_2, arg_25_3)
	self:runAction(cc.Sequence:create(cc.MoveBy:create(arg_25_2, (cc.p(self.dir * arg_25_3.x, arg_25_3.y))), cc.CallFunc:create(function()
		if arg_25_1 then
			arg_25_1()
		end
	end)))
end

function L2Skeleton:jumpTo(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	self:runAction(cc.Sequence:create(cc.JumpTo:create(arg_27_2, arg_27_3, arg_27_4, arg_27_5), cc.CallFunc:create(function()
		if arg_27_1 then
			arg_27_1()
		end
	end)))
end

function L2Skeleton:jumpBy(arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	self:runAction(cc.Sequence:create(cc.JumpBy:create(arg_29_2, cc.p(self.dir * arg_29_3.x, arg_29_3.y), arg_29_4, arg_29_5), cc.CallFunc:create(function()
		if arg_29_1 then
			arg_29_1()
		end
	end)))
end

function L2Skeleton:playAni(arg_31_1, arg_31_2, arg_31_3)
	self.skeletonAnimation:setToSetupPose()

	if not arg_31_3 and arg_31_1 ~= nil then
		self.aniListener[arg_31_2] = function()
			self.aniListener[arg_31_2] = nil

			arg_31_1()
		end
	end

	self.skeletonAnimation:setAnimation(0, arg_31_2, arg_31_3)

	self._lastAni = arg_31_2
	self._lastAniCycled = arg_31_3
end

function L2Skeleton:delayTime(arg_33_1, arg_33_2)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_33_2), cc.CallFunc:create(function()
		if arg_33_1 then
			arg_33_1()
		end
	end)))
end

function L2Skeleton:talk(arg_35_1, arg_35_2, arg_35_3)
	if self.talkSprite then
		self.talkSprite:setVisible(false)

		self.talkSprite = nil
	end

	local var_35_0 = TalkBubbleSprite:create(arg_35_2, nil, self.dir, 0.8, arg_35_3, nil, function(arg_36_0)
		if arg_35_1 then
			arg_35_1(arg_36_0)
		end

		self.talkSprite = nil
	end)

	var_35_0:setPosition(cc.p(0, 260 * self.scale))

	self.talkSprite = var_35_0

	self:addChild(var_35_0)
end

function L2Skeleton:hide(arg_37_1)
	self:runAction(cc.Sequence:create(cc.Hide:create(), cc.CallFunc:create(function()
		if arg_37_1 then
			arg_37_1()
		end
	end)))
end

function L2Skeleton:show(arg_39_1)
	self:runAction(cc.Sequence:create(cc.Show:create(), cc.CallFunc:create(function()
		if arg_39_1 then
			arg_39_1()
		end
	end)))
end

local ExploreActor = class("ExploreActor", function(arg_41_0, arg_41_1, arg_41_2)
	return L2Skeleton:create(arg_41_0, arg_41_1, arg_41_2)
end)

function L2Skeleton:createExploreTheaterActor(arg_42_1, arg_42_2, arg_42_3)
	return (ExploreActor.new(arg_42_1, arg_42_2, arg_42_3))
end

function ExploreActor:moveBy_e(arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	local var_43_0 = (arg_43_3.x * 100 + arg_43_3.y * 100) / arg_43_2
	local var_43_1 = self:getPositionX() + arg_43_3.x * 100
	local var_43_2 = self:getPositionY() + arg_43_3.y * 100
	local var_43_3 = 0.016666666666666666
	local var_43_4 = 665

	arg_43_4 = arg_43_3.x * 100 == 0 and "y" or arg_43_3.y * 100 == 0 and "x" or arg_43_4 or "y"

	local var_43_5 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
		local var_44_0 = self:getPositionX()
		local var_44_1 = self:getPositionY()
		local var_44_4 = ExploreMapLayer.getInstance().curRoomMap:transform_index_pos_coordinate(cc.p(var_44_0, var_44_1), "coordinate").order_y

		local function var_44_5()
			if var_43_1 == var_44_0 then
				return
			end

			var_44_0 = var_44_0 + (var_43_1 - var_44_0) / math.abs(var_43_1 - var_44_0) * (math.abs(var_43_1 - var_44_0) < var_43_3 * var_43_0 and math.abs(var_43_1 - var_44_0) or var_43_3 * var_43_0)

			return true
		end

		local function var_44_6()
			if var_43_2 == var_44_1 then
				return
			end

			var_44_1 = var_44_1 + (var_43_2 - var_44_1) / math.abs(var_43_2 - var_44_1) * (math.abs(var_43_2 - var_44_1) < var_43_3 * var_43_0 and math.abs(var_43_2 - var_44_1) or 0.016666666666666666 * var_43_0)

			return true
		end

		if var_44_0 == var_43_1 and var_44_1 == var_43_2 then
			if arg_43_1 then
				arg_43_1()
			end

			self:stopActionByTag(var_43_4)
		end

		if arg_43_4 == "x" then
			if not var_44_5() then
				var_44_6()
			end
		elseif arg_43_4 == "y" and not var_44_6() then
			var_44_5()
		end

		self:setPosition(var_44_0, var_44_1)
		self:setLocalZOrder((ExploreMapLayer.getInstance().curRoomMap - var_44_4 + 1) * 2)
	end)))

	var_43_5:setTag(var_43_4)
	self:runAction(var_43_5)
end

function ExploreActor:moveTo_e(arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	local var_47_0 = cc.p(self:getPositionX(), self:getPositionY())
	local var_47_1 = (math.abs(arg_47_3.x - var_47_0.x) + math.abs(arg_47_3.x - var_47_0.y)) / arg_47_2
	local var_47_2 = arg_47_3.x
	local var_47_3 = arg_47_3.y
	local var_47_4 = 0.016666666666666666
	local var_47_5 = 666

	arg_47_4 = arg_47_3.x - var_47_0.x == 0 and "y" or arg_47_3.x - var_47_0.y == 0 and "x" or arg_47_4 or "y"

	local var_47_6 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
		local var_48_0 = self:getPositionX()
		local var_48_1 = self:getPositionY()
		local var_48_4 = ExploreMapLayer.getInstance().curRoomMap:transform_index_pos_coordinate(cc.p(var_48_0, var_48_1), "coordinate").order_y

		local function var_48_5()
			if var_47_2 == var_48_0 then
				return
			end

			var_48_0 = var_48_0 + (var_47_2 - var_48_0) / math.abs(var_47_2 - var_48_0) * (math.abs(var_47_2 - var_48_0) < var_47_4 * var_47_1 and math.abs(var_47_2 - var_48_0) or var_47_4 * var_47_1)

			return true
		end

		local function var_48_6()
			if var_47_3 == var_48_1 then
				return
			end

			var_48_1 = var_48_1 + (var_47_3 - var_48_1) / math.abs(var_47_3 - var_48_1) * (math.abs(var_47_3 - var_48_1) < var_47_4 * var_47_1 and math.abs(var_47_3 - var_48_1) or var_47_4 * var_47_1)

			return true
		end

		if var_48_0 == var_47_2 and var_48_1 == var_47_3 then
			if arg_47_1 then
				arg_47_1()
			end

			self:stopActionByTag(var_47_5)
		end

		if arg_47_4 == "x" then
			if not var_48_5() then
				var_48_6()
			end
		elseif arg_47_4 == "y" and not var_48_6() then
			var_48_5()
		end

		self:setPosition(var_48_0, var_48_1)
		self:setLocalZOrder((ExploreMapLayer.getInstance().curRoomMap.room_height_num - var_48_4 + 1) * 2)
	end)))

	var_47_6:setTag(var_47_5)
	self:runAction(var_47_6)
end

local var_0_3 = setmetatable({}, {
	__index = function(arg_51_0, arg_51_1)
		if ExploreActor[arg_51_1] then
			return ExploreActor[arg_51_1]
		else
			return L2Skeleton[arg_51_1]
		end
	end
})

function ExploreActor:execute(arg_52_1, arg_52_2, ...)
	var_0_3[arg_52_1](self, arg_52_2, ...)
end

local ExploreLead = class("ExploreLead", function(arg_53_0, arg_53_1, arg_53_2)
	return L2Skeleton:create(arg_53_0, arg_53_1, arg_53_2)
end)

function L2Skeleton:createExploreLead(arg_54_1, arg_54_2, arg_54_3)
	return (ExploreLead.new(arg_54_1, arg_54_2, arg_54_3))
end

function ExploreLead:moveTo_e(arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	local explore_manager = require("controller.explore_manager")
	local var_55_1 = ExploreMapLayer.getInstance().curRoomMap:transform_index_pos_coordinate(arg_55_3, "coordinate")
	local var_55_2 = ExploreMapLayer.getInstance().curRoomMap:findRoad(var_55_1.index)

	assert(ExploreMapLayer.getInstance().curRoomMap:getFinialPath(var_55_1.index, var_55_2), "探险剧场主角移动寻路错误")
	self:runAction(cc.CallFunc:create(function()
		ExploreMapLayer.getInstance().curRoomMap:moveSelectedFrame(var_55_2, nil, function()
			explore_manager:move_cur_pos(ExploreMapLayer.getInstance().curRoomMap.curMapType, var_55_1.index)

			if arg_55_1 then
				arg_55_1()
			end
		end)
	end))
end

local var_0_5 = setmetatable({}, {
	__index = function(arg_58_0, arg_58_1)
		if ExploreLead[arg_58_1] then
			return ExploreLead[arg_58_1]
		else
			return L2Skeleton[arg_58_1]
		end
	end
})

function ExploreLead:execute(arg_59_1, arg_59_2, ...)
	var_0_5[arg_59_1](self, arg_59_2, ...)
end

return L2Skeleton
