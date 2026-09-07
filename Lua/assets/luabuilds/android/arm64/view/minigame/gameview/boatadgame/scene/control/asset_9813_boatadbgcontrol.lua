local BoatAdBgControl = class("BoatAdBgControl")
local var_0_1
local var_0_2 = 2
local var_0_3 = 100
local var_0_4 = 1

function BoatAdBgControl:Ctor(arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self._content = findTF(self._tf, "scene_front/content")
	self._spineSea = findTF(self._tf, "scene_background/content/spineSea")
	self._spineSeaLeft = findTF(self._tf, "scene_background/content/spineSeaLeft")
	self._spineSeaRight = findTF(self._tf, "scene_background/content/spineSeaRight")
	self.graphicUI = {}

	table.insert(self.graphicUI, self._spineSea:GetComponent("SkeletonGraphic"))
	table.insert(self.graphicUI, self._spineSeaLeft:GetComponent("SkeletonGraphic"))
	table.insert(self.graphicUI, self._spineSeaRight:GetComponent("SkeletonGraphic"))

	self._bgs = {}
	self._bgsPool = {}
	self.thunders = {}

	for iter_1_0 = 1, 3 do
		local var_1_0 = var_0_1.GetGameTplTf("bgs/thunder_" .. iter_1_0)
		local var_1_1 = {
			active = false,
			tf = var_1_0,
			animUI = GetComponent(findTF(var_1_0, "ad/img/spine"), typeof(SpineAnimUI))
		}

		setParent(var_1_0, self._content)
		setActive(var_1_0, false)
		table.insert(self.thunders, var_1_1)
	end

	return
end

function BoatAdBgControl:start()
	self:setSpineStop(false)
	self:clear()

	self._createTime = var_0_2
	self._thunderTime = var_0_4

	return
end

function BoatAdBgControl:step(arg_3_1)
	if self._createTime > 0 then
		self._createTime = self._createTime - arg_3_1

		if self._createTime <= 0 then
			self._createTime = var_0_2

			if math.random(1, 100) <= var_0_3 then
				self:createBg(BoatAdGameConst.create_bg[math.random(1, #BoatAdGameConst.create_bg)])
			end
		end
	end

	if #self._bgs > 0 and self._thunderTime > 0 then
		self._thunderTime = self._thunderTime - arg_3_1

		if self._thunderTime <= 0 then
			self._thunderTime = var_0_4

			for iter_3_0 = 1, #self.thunders do
				local var_3_0 = self.thunders[iter_3_0]

				if self.thunders[iter_3_0].active == false then
					self.thunders[iter_3_0].active = true
					self.thunders[iter_3_0].tf.anchoredPosition = self._bgs[math.random(1, #self._bgs)]:getPosition()

					setActive(self.thunders[iter_3_0].tf, true)
					self:setAnimation(self.thunders[iter_3_0].animUI, "normal", function()
						var_3_0.active = false

						setActive(var_3_0.tf, false)

						return
					end)
					print("创建闪电成功")

					break
				end
			end
		end
	end

	for iter_3_1 = #self._bgs, 1, -1 do
		self._bgs[iter_3_1]:step(arg_3_1)

		if self._bgs[iter_3_1]:getRemoveFlag() then
			table.remove(self._bgs, iter_3_1)
			self:returnBg(self._bgs[iter_3_1])
		end
	end

	return
end

function BoatAdBgControl:returnBg(arg_5_1)
	arg_5_1:clear()
	table.insert(self._bgsPool, arg_5_1)

	return
end

function BoatAdBgControl:getSpineStop()
	return self.spineStopFlag
end

function BoatAdBgControl:setSpineStop(arg_7_1)
	self.spineStopFlag = arg_7_1

	for iter_7_0 = 1, #self.graphicUI do
		self.graphicUI[iter_7_0].AnimationState.TimeScale = var_7_0
	end

	return
end

function BoatAdBgControl:createBg(arg_8_1)
	local var_8_0 = self:getOrCreateItem(arg_8_1)

	var_8_0:start()
	var_8_0:setMoveCount((math.random(1, 4)))
	table.insert(self._bgs, var_8_0)

	return
end

function BoatAdBgControl:getOrCreateItem(arg_9_1)
	local var_9_0

	if #self._bgsPool > 0 then
		for iter_9_0 = 1, #self._bgsPool do
			if self._bgsPool[iter_9_0]:getId() == arg_9_1 then
				var_9_0 = table.remove(self._bgsPool, iter_9_0)

				break
			end
		end
	end

	if not var_9_0 then
		if not BoatAdGameConst.game_bg[arg_9_1] then
			print("不存在背景id" .. arg_9_1)
		end

		var_9_0 = BoatAdBg.New(var_0_1.GetGameTplTf(BoatAdGameConst.game_bg[arg_9_1].tpl), self._event)

		var_9_0:setData(BoatAdGameConst.game_bg[arg_9_1])
		var_9_0:setContent(self._content)
	end

	var_9_0:start()

	return var_9_0
end

function BoatAdBgControl:setMoveSpeed(arg_10_1)
	self._moveSpeed = arg_10_1

	for iter_10_0 = 1, #self._bgs do
		self._bgs[iter_10_0]:setSpeed(arg_10_1)
	end

	if arg_10_1 == 0 then
		self:setSpineStop(true)
	else
		self:setSpineStop(false)
	end

	return
end

function BoatAdBgControl:getMoveSpeed()
	return self._moveSpeed
end

function BoatAdBgControl:stop()
	self.lastMoveSpeed = self._moveSpeed or 1

	self:setMoveSpeed(0)

	return
end

function BoatAdBgControl:resume()
	self:setMoveSpeed(self.lastMoveSpeed)

	return
end

function BoatAdBgControl:clear()
	for iter_14_0 = #self._bgs, 1, -1 do
		local var_14_0 = table.remove(self._bgs, iter_14_0)

		var_14_0:clear()
		table.insert(self._bgsPool, var_14_0)
	end

	for iter_14_1 = #self.thunders, 1, -1 do
		self.thunders[iter_14_1].active = false

		setActive(self.thunders[iter_14_1].tf, false)
	end

	self:setMoveSpeed(1)

	return
end

function BoatAdBgControl:setAnimation(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_1:SetActionCallBack(nil)
	arg_15_1:SetAction(arg_15_2, 0)
	arg_15_1:SetActionCallBack(function(arg_16_0)
		if arg_16_0 == "action" and arg_15_4 then
			arg_15_4()
		end

		if arg_16_0 == "finish" then
			arg_15_1:SetActionCallBack(nil)

			if arg_15_3 then
				arg_15_3()
			end
		end

		return
	end)

	return
end

function BoatAdBgControl:dispose()
	return
end

return BoatAdBgControl
