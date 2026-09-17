local xpbg = class("xpbg", function(arg_1_0)
	return cc.Node:create()
end)

function xpbg:create(arg_2_1, arg_2_2)
	local var_2_0 = xpbg.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function xpbg:init(arg_3_1, arg_3_2)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and self.skeletonData then
			self.skeletonData:release()

			self.skeletonData = nil
		end
	end)
end

function xpbg:refreshSkeleton(arg_5_1, arg_5_2, arg_5_3)
	if self.skeleton then
		self:removeChild(self.skeleton)

		self.skeleton = nil
	end

	if self.skeletonData then
		self.skeletonData:release()

		self.skeletonData = nil
	end

	self.skeletonData = SpineCacheManager:addSpineData("spine/test/" .. arg_5_1 .. ".json", "spine/test/" .. arg_5_1 .. ".atlas")

	self.skeletonData:retain()

	self.skeleton = sp.SkeletonAnimation:create(self.skeletonData:getData())

	self:addChild(self.skeleton)
	self:setScale(arg_5_2, arg_5_3)
end

function xpbg:play(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 == nil then
		arg_6_2 = true
	end

	self.skeleton:setAnimation(0, arg_6_1, arg_6_2)

	if arg_6_3 and arg_6_3 > 0 then
		self.skeleton:jumpToTime(arg_6_3)
	end
end

function xpbg:setScale(arg_7_1, arg_7_2)
	if not self.skeleton then
		return
	end

	arg_7_1 = arg_7_1 or 1
	arg_7_2 = arg_7_2 or 1

	self.skeleton:setScale(arg_7_1 * arg_7_2, arg_7_1)
end

function xpbg:setTimeScale(arg_8_1)
	if not self.skeleton then
		return
	end

	self.skeleton:setTimeScale(arg_8_1)
end

function xpbg:getTimeScale()
	if not self.skeleton then
		return 1
	end

	return self.skeleton:getTimeScale()
end

function xpbg:pauseAni()
	if self.skeleton then
		self.skeleton:pause()
	end

	self:pause()
end

function xpbg:resumeAni()
	if self.skeleton then
		self.skeleton:resume()
	end

	self:resume()
end

return xpbg
