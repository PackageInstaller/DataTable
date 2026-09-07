local BeatGameMapPlane = class("BeatGameMapPlane", import(".BeatGameMapBase"))
local var_0_1 = 500
local var_0_2 = 0.1
local var_0_3 = 20

function BeatGameMapPlane:onInit()
	self.touchTf = findTF(self._tf, "touch")
	self.flapTf = findTF(self._tf, "flap")
	self.touchTrigger = GetOrAddComponent(self.touchTf, typeof(EventTriggerListener))
	self.flapTrigger = GetOrAddComponent(self.flapTf, typeof(EventTriggerListener))

	self.touchTrigger:AddPointDownFunc(function()
		self:keyTrigger("catch", "item_touch", "touch")

		return
	end)
	self.flapTrigger:AddPointDownFunc(function()
		self:keyTrigger("refuse", "item_flap", "flap")

		return
	end)
	self._event:bind(MusicBeatGameEvent.KEY_CODE_DOWN, function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_1 == KeyCode.A then
			self:keyTrigger("refuse", "item_flap", "flap")
		elseif arg_4_1 == KeyCode.D then
			self:keyTrigger("catch", "item_touch", "touch")
		end

		return
	end)

	self.leftSpine = GetComponent(findTF(self._tf, "char_left/ad/char"), typeof(SpineAnimUI))
	self.leftSpineSkeleton = findTF(self._tf, "char_left/ad/char"):GetComponent("SkeletonGraphic")
	self.rightSpine = GetComponent(findTF(self._tf, "char_right/ad/char"), typeof(SpineAnimUI))
	self.rightSpineSkeleton = findTF(self._tf, "char_right/ad/char"):GetComponent("SkeletonGraphic")
	self.emojiTf = findTF(self._tf, "emoji")

	setActive(self.emojiTf, false)

	self.beatCount = findTF(self._tf, "beat_count")

	setActive(self.beatCount, true)
	self:initData()
	self:initPosition()
	self:initItemMap()

	return
end

function BeatGameMapPlane:initData()
	self.dymItems = {}
	self.itemMap = {}
	self.itemFinalMap = {}

	return
end

function BeatGameMapPlane:initPosition()
	self.content = findTF(self._tf, "content")
	self.startTf = findTF(self._tf, "content/start")
	self.endTf = findTF(self._tf, "content/end")
	self.startPosition = self.startTf.anchoredPosition

	return
end

function BeatGameMapPlane:initItemMap()
	local var_7_0 = self._data.items

	for iter_7_0 = 1, #self._data.items do
		local var_7_1 = var_7_0[iter_7_0].track_key

		if self.itemMap[var_7_0[iter_7_0].track_key] == nil then
			self.itemMap[var_7_1] = {}
		elseif self.itemFinalMap[var_7_1] == nil then
			self.itemFinalMap[var_7_1] = {}
		end

		if var_7_0[iter_7_0].final then
			table.insert(self.itemFinalMap[var_7_1], var_7_0[iter_7_0])
		else
			table.insert(self.itemMap[var_7_1], var_7_0[iter_7_0])
		end
	end

	return
end

function BeatGameMapPlane:createDymItem(arg_8_1)
	local var_8_0 = self:getItemData(arg_8_1.track.key_flag, arg_8_1.final)
	local var_8_1 = self:createItemTf(var_8_0.prefab)
	local var_8_2 = GetComponent(var_8_1, typeof(Animator))

	var_8_2.speed = 1

	table.insert(self.dymItems, {
		check = true,
		data = var_8_0,
		tf = var_8_1,
		anim = var_8_2,
		track = arg_8_1.track
	})

	return
end

function BeatGameMapPlane:getItemData(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2 and self.itemFinalMap[arg_9_1] or self.itemMap[arg_9_1]

	return var_9_0[math.random(1, #var_9_0)]
end

function BeatGameMapPlane:createItemTf(arg_10_1)
	local var_10_0 = tf(instantiate(findTF(self._tf, arg_10_1)))

	setParent(var_10_0, self.content)
	setActive(var_10_0, false)

	var_10_0.anchoredPosition = self.startTf.anchoredPosition

	return var_10_0
end

function BeatGameMapPlane:keyTrigger(arg_11_1, arg_11_2, arg_11_3)
	if self.finalEnd then
		return
	end

	if self.triggerCd then
		return
	end

	self.triggerCd = var_0_2

	self:setCharAnimation(self.leftSpine, arg_11_1, 0, function()
		self:setCharAnimation(self.leftSpine, "idle", 0)
		self.leftSpineSkeleton:Update(Time.deltaTime)

		return
	end, function()
		local var_13_0 = self:getCheckDymItem()

		if var_13_0 then
			self._event:emit(MusicBeatGameEvent.TRACK_EVENT_MATCH, var_13_0.track, function(arg_14_0, arg_14_1)
				if arg_14_0 then
					var_13_0.trigger = true
					var_13_0.anim.speed = 1

					var_13_0.anim:Play(arg_11_2, -1)

					if var_13_0.data.act == arg_11_3 then
						var_13_0.typeMatch = true

						self._event:emit(MusicBeatGameEvent.ADD_SCORE, {
							num = var_13_0.data.score
						})
						self:setEmoji("success")
						self:changeLife(1)
					else
						if var_13_0.data.act == "flap" and arg_11_3 ~= "flap" then
							var_13_0.typeMatch = false

							self:setCharAnimation(self.leftSpine, "shock", 0, function()
								self:setCharAnimation(self.leftSpine, "idle", 0)

								return
							end)
							self:changeLife(-1)
						end

						self:setEmoji("fail")
					end

					local var_14_0

					if var_13_0.typeMatch then
						if var_13_0.data.act == "flap" then
							var_14_0 = MusicBeatGameConst.sfx_plane_success_hit
						elseif var_13_0.data.act == "touch" then
							var_14_0 = MusicBeatGameConst.sfx_plane_success_touch
						end
					elseif var_13_0.data.act == "flap" then
						var_14_0 = MusicBeatGameConst.sfx_plane_faild_hit
					elseif var_13_0.data.act == "touch" then
						var_14_0 = MusicBeatGameConst.sfx_plane_faild_touch
					end

					if var_14_0 then
						print("play Effect sound " .. var_14_0)
						pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_14_0)
					end
				end

				return
			end)
		end

		return
	end)

	return
end

function BeatGameMapPlane:onStart()
	self.triggerCd = nil
	self.finalEnd = false

	onNextTick(function()
		if self.leftSpine then
			self.leftSpine:Resume()
		end

		if self.rightSpine then
			self.rightSpine:Resume()
		end

		return
	end)

	self.lifeCount = var_0_3

	self:changeLife(0)
	self:setCharAnimation(self.leftSpine, "idle", 0, function()
		return
	end, function()
		return
	end)
	self:setCharAnimation(self.rightSpine, "idle", 0, function()
		return
	end, function()
		return
	end)

	return
end

function BeatGameMapPlane:onStartTrack(arg_22_1)
	self:createDymItem(arg_22_1)

	return
end

function BeatGameMapPlane:onStep()
	if self.triggerCd then
		self.triggerCd = self.triggerCd - self._gameVo.deltaTime

		if self.triggerCd <= 0 then
			self.triggerCd = nil
		end
	end

	local var_23_0 = self._gameVo:getCriInfoTime()

	if var_23_0 ~= -1 then
		for iter_23_0 = #self.dymItems, 1, -1 do
			local var_23_1 = self.dymItems[iter_23_0]

			if self.dymItems[iter_23_0] then
				if var_23_1.active then
					if var_23_1.track.begin_time <= var_23_0 and var_23_0 - var_23_1.track.begin_time > var_0_1 then
						var_23_1.active = false
						var_23_1.remove = true
					end

					if var_23_1.check and not var_23_1.trigger and var_23_0 - var_23_1.track.begin_time > MusicBeatGameConst.beat_offset then
						var_23_1.check = false

						if not var_23_1.trigger then
							self:setEmoji("miss")

							if var_23_1.data.act == "flap" then
								self:changeLife(-1)
							end
						end
					end
				elseif var_23_1.remove == true then
					if var_23_1.data.final then
						self.finalEnd = true

						self:setCharAnimation(self.leftSpine, var_23_1.typeMatch and "final_correct" or "final_wrong", 0, function()
							self.leftSpine:Pause()

							return
						end)
						self:setCharAnimation(self.rightSpine, var_23_2, 0, function()
							self.rightSpine:Pause()

							return
						end)
					end

					local var_23_4 = table.remove(self.dymItems, iter_23_0)

					Destroy(var_23_4.tf)

					var_23_4.tf = nil
					var_23_4.anim = nil
					var_23_4.track = nil

					return
				elseif var_23_1.track.begin_time - var_23_0 > 0 and var_23_1.track.begin_time - var_23_0 <= var_23_1.data.distance_time then
					self:activeDymItem(var_23_1)
				elseif not var_23_1.throw and var_23_1.track.begin_time - var_23_0 > 0 and var_23_1.track.begin_time - var_23_0 <= var_23_1.data.distance_time + 100 then
					var_23_1.throw = true

					self:setCharAnimation(self.rightSpine, "throw", 0, function()
						self:setCharAnimation(self.rightSpine, "idle", 0, nil, nil)

						return
					end, nil)
				elseif var_23_1.track.begin_time - var_23_0 <= var_23_1.data.distance_time / 2 or var_23_1.track.begin_time <= var_23_0 and not var_23_1.active then
					var_23_1.remove = true
				end
			else
				warning("dymitem == nil")
			end
		end
	end

	return
end

function BeatGameMapPlane:onStop()
	for iter_27_0 = 1, #self.dymItems do
		if self.dymItems[iter_27_0].anim then
			self.dymItems[iter_27_0].anim.speed = 0
		end
	end

	return
end

function BeatGameMapPlane:onResume()
	for iter_28_0 = 1, #self.dymItems do
		if self.dymItems[iter_28_0].anim then
			self.dymItems[iter_28_0].anim.speed = 1
		end
	end

	return
end

function BeatGameMapPlane:changeLife(arg_29_1)
	self.lifeCount = self.lifeCount + arg_29_1

	if self.lifeCount <= 0 then
		self._event:emit(MusicBeatGameEvent.GAME_OVER)
	end

	setText(findTF(self.beatCount, "text"), self.lifeCount)

	return
end

function BeatGameMapPlane:setEmoji(arg_30_1)
	setActive(self.emojiTf, false)
	self:setChildVisible(findTF(self.emojiTf, "ad"), false)

	if arg_30_1 then
		setActive(self.emojiTf, true)
		setActive(findTF(self.emojiTf, "ad/" .. arg_30_1), true)
	end

	return
end

function BeatGameMapPlane:setChildVisible(arg_31_1, arg_31_2)
	for iter_31_0 = 1, arg_31_1.childCount do
		setActive(arg_31_1:GetChild(iter_31_0 - 1), arg_31_2)
	end

	return
end

function BeatGameMapPlane:getCheckDymItem()
	for iter_32_0 = 1, #self.dymItems do
		if self.dymItems[iter_32_0].check and not self.dymItems[iter_32_0].trigger then
			return self.dymItems[iter_32_0]
		end
	end

	return nil
end

function BeatGameMapPlane:activeDymItem(arg_33_1)
	setActive(arg_33_1.tf, true)

	arg_33_1.active = true

	arg_33_1.anim:Play("item_fly", -1, 0)

	arg_33_1.anim.speed = 1

	return
end

function BeatGameMapPlane:setCharAnimation(arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	if arg_34_1 then
		arg_34_1:SetActionCallBack(nil)
		arg_34_1:SetActionCallBack(function(arg_35_0)
			if arg_35_0 == "finish" and arg_34_4 then
				arg_34_1:SetActionCallBack(nil)
				arg_34_4()
			elseif arg_35_0 == "action" and arg_34_5 then
				arg_34_5()
			end

			return
		end)
	end

	if arg_34_1 == self.leftSpine then
		print("set action" .. arg_34_2)
	end

	arg_34_1:SetAction(arg_34_2, arg_34_3)

	return
end

function BeatGameMapPlane:onClear()
	for iter_36_0 = 1, #self.dymItems do
		if self.dymItems[iter_36_0].tf then
			Destroy(self.dymItems[iter_36_0].tf)

			self.dymItems[iter_36_0].tf = nil
			self.dymItems[iter_36_0].anim = nil
		end
	end

	self.dymItems = {}

	return
end

function BeatGameMapPlane:onDispose()
	return
end

return BeatGameMapPlane
