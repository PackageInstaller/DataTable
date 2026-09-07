local IdolMasterView = class("IdolMasterView", import("..BaseMiniGameView"))
local var_0_1 = {
	"idom-THEIDOLM@STER",
	"idom-GOMYWAY"
}
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_3 = 120
local var_0_4 = 100
local var_0_5 = 15
local var_0_6 = {
	{
		30,
		1
	},
	{
		60,
		1
	},
	{
		90,
		3
	},
	{
		120,
		4
	}
}
local var_0_7 = {
	"OUXIANGDASHIRICHANG1",
	"",
	"OUXIANGDASHIRICHANG2",
	"",
	"OUXIANGDASHIRICHANG3",
	"",
	"OUXIANGDASHIRICHANG4"
}
local var_0_8 = false
local var_0_9 = {
	{
		10700011,
		10700010
	},
	{
		10700021,
		10700020
	},
	{
		10700031,
		10700030
	},
	{
		10700041,
		10700040
	},
	{
		10700051,
		10700050
	}
}
local var_0_10 = {
	{
		10700061,
		10700060
	},
	{
		10700071,
		10700070
	}
}
local var_0_11 = "EVENT_SEND_GIFT"
local var_0_12 = "EVENT_FANS_ACTION"
local var_0_13 = {
	1,
	2,
	3,
	4,
	5,
	6
}
local var_0_14 = {
	1,
	2
}
local var_0_15 = {
	3,
	4,
	5,
	6
}
local var_0_16 = 3
local var_0_17 = "event_bow"
local var_0_18 = "event_hello"
local var_0_19 = "event_stand"
local var_0_20 = "normal"
local var_0_21 = "work"
local var_0_22 = "wrong"
local var_0_23 = "end1"
local var_0_24 = "end2"
local var_0_25 = "gift"
local var_0_26 = "normal"
local var_0_27 = "walk"
local var_0_28 = 3
local var_0_29 = "type_fans_fail"
local var_0_30 = "type_fans_success"
local var_0_31 = 4
local var_0_32 = {
	Vector3(160, 160),
	Vector3(160, -30),
	Vector3(160, -210),
	Vector3(160, -400)
}
local var_0_33 = 200
local var_0_34 = "是否继续游戏？"
local var_0_35 = "是否退出游戏?"
local var_0_36 = "本次得分 :"
local var_0_37 = "最高得分 :"
local var_0_38 = "分数 :"

local function var_0_39(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		Ctor = function(self)
			self._giftTf = arg_1_0
			self._event = arg_1_2
			self._workerTf = arg_1_1

			local var_2_0 = "jiu-work"

			PoolMgr.GetInstance():GetSpineChar("jiu-work", true, function(arg_3_0)
				arg_3_0.transform.localScale = Vector3.one
				arg_3_0.transform.localPosition = Vector3.zero

				arg_3_0.transform:SetParent(self._workerTf, false)

				self.wokerSpine = {
					model = arg_3_0,
					anim = arg_3_0:GetComponent(typeof(SpineAnimUI)),
					name = var_2_0
				}

				self:changeWorkerAction(var_0_20, 0, nil)

				return
			end)

			self.selectedGifts = {}
			self.gifts = {}
			self.delegateGifts = {}

			for iter_2_0 = 1, #var_0_13 do
				local var_2_1 = iter_2_0
				local var_2_2 = findTF(self._giftTf, var_0_13[iter_2_0])

				table.insert(self.gifts, {
					tf = var_2_2,
					index = iter_2_0
				})

				local var_2_3 = GetOrAddComponent(var_2_2, "EventTriggerListener")

				var_2_3:AddPointDownFunc(function(arg_4_0, arg_4_1)
					self:selectGift(var_2_1)

					return
				end)
				table.insert(self.delegateGifts, var_2_3)
			end

			self:updateSelected()

			return
		end,
		changeWorkerAction = function(self, arg_5_1, arg_5_2, arg_5_3)
			self.wokerSpine.anim:SetActionCallBack(nil)
			self.wokerSpine.anim:SetAction(arg_5_1, 0)
			self.wokerSpine.anim:SetActionCallBack(function(arg_6_0)
				if arg_6_0 == "finish" then
					if arg_5_2 == 1 then
						self.wokerSpine.anim:SetActionCallBack(nil)
						self.wokerSpine.anim:SetAction(var_0_20, 0)
					end

					if arg_5_3 then
						arg_5_3()
					end
				end

				return
			end)

			if arg_5_2 ~= 1 and arg_5_3 then
				arg_5_3()
			end

			return
		end,
		selectGift = function(self, arg_7_1)
			if table.contains(var_0_14, arg_7_1) then
				for iter_7_0 = #self.selectedGifts, 1, -1 do
					if table.contains(var_0_14, self.selectedGifts[iter_7_0]) and self.selectedGifts[iter_7_0] ~= arg_7_1 then
						table.remove(self.selectedGifts, iter_7_0)
					end
				end
			elseif #self.selectedGifts == 2 and not table.contains(self.selectedGifts, arg_7_1) then
				local var_7_0 = false

				for iter_7_1 = 1, #self.selectedGifts do
					if table.contains(var_0_14, self.selectedGifts[iter_7_1]) then
						var_7_0 = true

						break
					end
				end

				if not var_7_0 then
					table.remove(self.selectedGifts, 1)
				end
			end

			local var_7_1 = 0

			for iter_7_2 = 1, #self.selectedGifts do
				if self.selectedGifts[iter_7_2] == arg_7_1 then
					var_7_1 = iter_7_2
				end
			end

			if var_7_1 == 0 then
				table.insert(self.selectedGifts, arg_7_1)
				self:moveJiujiu(arg_7_1)
				self:changeWorkerAction(var_0_21, 1)
			else
				table.remove(self.selectedGifts, var_7_1)
			end

			if #self.selectedGifts >= var_0_16 then
				self._event:emit(var_0_11, Clone(self.selectedGifts), function(arg_8_0, arg_8_1)
					if not arg_8_0 then
						self:changeWorkerAction(var_0_22, 1)
					else
						self:changeWorkerAction(var_0_20, 0, nil)
					end

					self:moveJiujiu(-1, arg_8_1)

					return
				end)

				self.selectedGifts = {}
			end

			self:updateSelected()

			return
		end,
		start = function(self)
			self.selectedGifts = {}

			self:updateSelected()

			return
		end,
		updateSelected = function(self)
			for iter_10_0 = 1, #self.gifts do
				if table.contains(self.selectedGifts, self.gifts[iter_10_0].index) then
					setActive(findTF(self.gifts[iter_10_0].tf, "selected"), true)
				else
					setActive(findTF(self.gifts[iter_10_0].tf, "selected"), false)
				end
			end

			return
		end,
		moveJiujiu = function(self, arg_11_1, arg_11_2)
			if arg_11_1 == -1 then
				self._workerTf.localScale = Vector3.New(-1, 1, 1)

				if arg_11_2 and arg_11_2 > 0 then
					local var_11_0 = Clone(var_0_32[arg_11_2])

					var_11_0.x = -100
					self._workerTf.anchoredPosition = var_11_0
				else
					self._workerTf.anchoredPosition = Vector3.New(-290, 30, 0)
				end
			else
				local var_11_1 = self._workerTf.parent:InverseTransformPoint(self.gifts[arg_11_1].tf.position)

				var_11_1.x = var_11_1.x + 22
				var_11_1.y = var_11_1.y - 50
				self._workerTf.anchoredPosition = var_11_1
				self._workerTf.localScale = Vector3.New(1, 1, 1)
			end

			return
		end,
		destroy = function(self)
			if self.delegateGifts and #self.delegateGifts > 0 then
				for iter_12_0 = 1, #self.delegateGifts do
					ClearEventTrigger(self.delegateGifts[iter_12_0])
				end

				self.delegateGifts = {}
			end

			PoolMgr.GetInstance():ReturnSpineChar(self.wokerSpine.name, self.wokerSpine.model)

			return
		end
	}

	var_1_0:Ctor()

	return var_1_0
end

local function var_0_40(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {
		Ctor = function(self)
			self._groupTf = arg_13_0
			self._groupIndex = arg_13_1
			self._groupTf.anchoredPosition = var_0_32[arg_13_1]
			self._event = arg_13_2
			self.modelData = {}

			SetActive(self._groupTf, true)

			self.fans = {}
			self.wantedData = {}

			return
		end,
		createIdol = function(self, arg_15_1, arg_15_2)
			if self.modelData.model then
				PoolMgr.GetInstance():ReturnSpineChar(self.modelData.id, self.modelData.model)
			end

			PoolMgr.GetInstance():GetSpineChar(Ship.New({
				configId = arg_15_1,
				skin_id = arg_15_2
			}):getPrefab(), true, function(arg_16_0)
				arg_16_0.transform.localScale = Vector3.one
				arg_16_0.transform.localPosition = Vector3.zero

				arg_16_0.transform:SetParent(findTF(self._groupTf, "idolPos"), false)

				self.modelData = {
					model = arg_16_0,
					id = arg_15_1,
					skinId = arg_15_2,
					anim = arg_16_0:GetComponent(typeof(SpineAnimUI))
				}

				self:changeCharAction(var_0_19, 0, nil)

				return
			end)

			return
		end,
		getFansAmount = function(self)
			return #self.fans
		end,
		changeCharAction = function(self, arg_18_1, arg_18_2, arg_18_3)
			if self.modelData.actionName == arg_18_1 then
				return
			end

			self.modelData.actionName = arg_18_1

			self.modelData.anim:SetActionCallBack(nil)
			self.modelData.anim:SetAction(arg_18_1, 0)
			self.modelData.anim:SetActionCallBack(function(arg_19_0)
				if arg_19_0 == "finish" then
					if arg_18_2 == 1 then
						self.modelData.anim:SetActionCallBack(nil)
						self.modelData.anim:SetAction(var_0_19, 0)
					end

					if arg_18_3 then
						arg_18_3()
					end
				end

				return
			end)

			if arg_18_2 ~= 1 and arg_18_3 then
				arg_18_3()
			end

			return
		end,
		createFans = function(self, arg_20_1)
			SetActive(arg_20_1, true)
			SetParent(arg_20_1, findTF(self._groupTf, "fansPos"))

			if #self.fans > 0 then
				self.fans[#self.fans].tf.anchoredPosition.x = self.fans[#self.fans].tf.anchoredPosition.x + var_0_33 + math.random() * 200 + 22
				arg_20_1.anchoredPosition = Vector3.New(self.fans[#self.fans].tf.anchoredPosition.x, self.fans[#self.fans].tf.anchoredPosition.y, self.fans[#self.fans].tf.anchoredPosition.z)
			else
				arg_20_1.anchoredPosition = Vector3.New((#self.fans + 1) * var_0_33 + 200, 0, 0)
			end

			setActive(findTF(arg_20_1, "wanted"), false)
			table.insert(self.fans, {
				tf = arg_20_1,
				speed = math.random() * 50 + 200
			})

			local var_20_0 = self.fans[#self.fans]
			local var_20_1 = "jiu-fan" .. math.random(1, 4)

			PoolMgr.GetInstance():GetSpineChar(var_20_1, true, function(arg_21_0)
				arg_21_0.transform.localScale = Vector3.one
				arg_21_0.transform.localPosition = Vector3.zero

				arg_21_0.transform:SetParent(findTF(var_20_0.tf, "spinePos"), false)

				var_20_0.modelData = {
					model = arg_21_0,
					anim = arg_21_0:GetComponent(typeof(SpineAnimUI)),
					modelName = var_20_1
				}

				return
			end)

			return
		end,
		changeFansAction = function(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
			if not arg_22_1.modelData or arg_22_1.modelData.actionName == arg_22_2 then
				return
			end

			arg_22_1.modelData.actionName = arg_22_2

			arg_22_1.modelData.anim:SetActionCallBack(nil)
			arg_22_1.modelData.anim:SetAction(arg_22_2, 0)
			arg_22_1.modelData.anim:SetActionCallBack(function(arg_23_0)
				if arg_23_0 == "finish" then
					if arg_22_3 == 1 then
						arg_22_1.modelData.anim:SetActionCallBack(nil)
						arg_22_1.modelData.anim:SetAction(var_0_26, 0)
					end

					if arg_22_4 then
						arg_22_4()
					end
				end

				return
			end)

			if arg_22_3 ~= 1 and arg_22_4 then
				arg_22_4()
			end

			return
		end,
		getWantedGifts = function(self)
			if #self.fans > 0 and self.fans[1].gifts and not self.fans[1].leave then
				return self.fans[1].gifts
			end

			return nil
		end,
		clearFans = function(self)
			for iter_25_0 = 1, #self.fans do
				PoolMgr.GetInstance():ReturnSpineChar(self.fans[iter_25_0].modelData.modelName, self.fans[iter_25_0].modelData.model)
				Destroy(self.fans[iter_25_0].tf)
			end

			self.fans = {}

			return
		end,
		start = function(arg_26_0)
			return
		end,
		step = function(self, arg_27_1)
			self.stepTime = arg_27_1

			for iter_27_0 = #self.fans, 1, -1 do
				if self.fans[iter_27_0].tf.anchoredPosition.x > (iter_27_0 - 1) * var_0_33 then
					self.fans[iter_27_0].tf.anchoredPosition.x = self.fans[iter_27_0].tf.anchoredPosition.x - self.fans[iter_27_0].speed * Time.deltaTime
					self.fans[iter_27_0].tf.anchoredPosition = self.fans[iter_27_0].tf.anchoredPosition

					self:changeFansAction(self.fans[iter_27_0], var_0_27, 0, nil)
				elseif iter_27_0 == 1 and not self.fans[iter_27_0].leave then
					if self.fans[iter_27_0].gifts == nil then
						self.fans[iter_27_0].gifts = self:createWantedGifts()
						self.fans[iter_27_0].time = arg_27_1 + var_0_5

						setImageSprite(findTF(self.fans[iter_27_0].tf, "score/pack"), (LoadSprite("ui/minigameui/idolmasterui_atlas", "pack" .. self.fans[iter_27_0].gifts[1])))
						self:changeFansAction(self.fans[iter_27_0], var_0_25, 0, nil)
						self:changeCharAction(var_0_18, 1, function()
							self:changeCharAction(var_0_19, 0, nil)

							return
						end)
					end
				elseif not self.fans[iter_27_0].leave then
					self:changeFansAction(self.fans[iter_27_0], var_0_26, 0, nil)
				end
			end

			if #self.fans > 0 then
				local var_27_1 = self.fans[1]

				if self.fans[1].time and arg_27_1 > var_27_1.time and not var_27_1.leave then
					var_27_1.leave = true

					self:fanLeave(var_27_1, var_0_29, function()
						table.remove(self.fans, 1)

						return
					end)
				else
					self:showFansWanted(var_27_1)
				end

				var_27_1.tf:SetSiblingIndex(#self.fans - 1)
			end

			return
		end,
		showFansWanted = function(self, arg_30_1)
			if arg_30_1.leave then
				return
			end

			local var_30_0 = arg_30_1.time

			if not arg_30_1.time then
				return
			end

			local var_30_1 = math.ceil(var_30_0 - self.stepTime) < 0 and 0 or var_30_0 - self.stepTime
			local var_30_2 = arg_30_1.gifts
			local var_30_3 = var_30_1 <= 5

			setActive(findTF(arg_30_1.tf, "wanted"), true)
			setActive(findTF(arg_30_1.tf, "wanted/bg1"), not var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/bgTime1"), not var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/time1"), not var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/bg2"), var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/bgTime2"), var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/time2"), var_30_3)

			if var_30_1 < 0 then
				var_30_1 = 0
			end

			setText(findTF(arg_30_1.tf, "wanted/time1"), math.abs(math.ceil(var_30_1)) .. "S")
			setText(findTF(arg_30_1.tf, "wanted/time2"), math.abs(math.ceil(var_30_1)) .. "S")

			for iter_30_0 = 1, #var_30_2 do
				setImageSprite(findTF(arg_30_1.tf, "wanted/item" .. iter_30_0), LoadSprite("ui/minigameui/idolmasterui_atlas", "wantItem" .. var_30_2[iter_30_0]), true)
			end

			return
		end,
		checkGifts = function(self, arg_31_1)
			local var_31_0 = self:getWantedGifts()

			if var_31_0 then
				for iter_31_0 = 1, #arg_31_1 do
					if not table.contains(var_31_0, arg_31_1[iter_31_0]) then
						return false
					end
				end

				return true
			end

			return false
		end,
		getGiftTime = function(self)
			if #self.fans > 0 and self.fans[1] and self.fans[1].time then
				return self.fans[1].time
			end

			return nil
		end,
		finishGift = function(self)
			if self:getWantedGifts() then
				self.fans[1].leave = true

				self:fanLeave(self.fans[1], var_0_30, function()
					table.remove(self.fans, 1)

					return
				end)
				self:changeCharAction(var_0_17, 1, function()
					self:changeCharAction(var_0_19, 0, nil)

					return
				end)
			end

			return
		end,
		createWantedGifts = function(arg_36_0)
			local var_36_0 = Clone(var_0_15)
			local var_36_1 = {}

			table.insert(var_36_1, var_0_14[math.random(1, #var_0_14)])

			for iter_36_0 = 1, 2 do
				table.insert(var_36_1, (table.remove(var_36_0, math.random(1, #var_36_0))))
			end

			return var_36_1
		end,
		fanLeave = function(self, arg_37_1, arg_37_2, arg_37_3)
			setActive(findTF(arg_37_1.tf, "wanted"), false)

			local var_37_0

			if var_0_29 == arg_37_2 then
				var_37_0 = var_0_24
			elseif var_0_30 then
				var_37_0 = var_0_23

				setText(findTF(arg_37_1.tf, "score"), "+" .. var_0_4)
				setActive(findTF(arg_37_1.tf, "score"), true)
			end

			self:changeFansAction(arg_37_1, var_37_0, 1, function()
				PoolMgr.GetInstance():ReturnSpineChar(arg_37_1.modelData.modelName, arg_37_1.modelData.model)
				self._event:emit(var_0_12, arg_37_2)
				Destroy(arg_37_1.tf)
				arg_37_3()

				return
			end)

			return
		end,
		reset = function(self)
			self:clearFans()

			self.wantedData = {}

			return
		end,
		destroy = function(self)
			if self.modelData then
				PoolMgr.GetInstance():ReturnSpineChar(self.modelData.id, self.modelData.model)
			end

			return
		end
	}

	var_13_0:Ctor()

	return var_13_0
end

local function var_0_41(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	local var_41_0 = {
		Ctor = function(self)
			self._containerTf = arg_41_0
			self._tplGroup = arg_41_1
			self._tplIdol = arg_41_2
			self._tplFans = arg_41_3
			self._event = arg_41_4
			self.groups = {}

			for iter_42_0 = 1, var_0_31 do
				local var_42_0 = tf(Instantiate(self._tplGroup))

				SetParent(var_42_0, self._containerTf)
				table.insert(self.groups, (var_0_40(var_42_0, iter_42_0, self._event)))
			end

			return
		end,
		createIdols = function(self)
			local var_43_0 = self:getRandomIdols()

			for iter_43_0 = 1, #self.groups do
				self.groups[iter_43_0]:createIdol(var_43_0[iter_43_0][1], var_43_0[iter_43_0][2])
			end

			return
		end,
		receiveGift = function(self, arg_44_1, arg_44_2)
			local var_44_0 = false
			local var_44_1
			local var_44_2

			for iter_44_0 = 1, #self.groups do
				if self.groups[iter_44_0]:checkGifts(arg_44_1) then
					var_44_0 = true

					if not var_44_1 then
						var_44_1 = self.groups[iter_44_0]
						var_44_2 = iter_44_0
					elseif var_44_1:getGiftTime() > self.groups[iter_44_0]:getGiftTime() then
						var_44_1 = self.groups[iter_44_0]
						var_44_2 = iter_44_0
					end
				end
			end

			if var_44_1 then
				var_44_1:finishGift()
			end

			if arg_44_2 then
				arg_44_2(var_44_0, var_44_2)
			end

			return
		end,
		getRandomIdols = function(arg_45_0)
			local var_45_0 = {}
			local var_45_1 = Clone(var_0_9)

			if math.random() > 0.6 then
				var_45_0 = Clone(var_0_10)
			end

			for iter_45_0 = #var_45_0 + 1, var_0_31 do
				table.insert(var_45_0, table.remove(var_45_1, math.random(1, #var_45_1)))
			end

			local var_45_2 = {}

			for iter_45_1 = 1, var_0_31 do
				table.insert(var_45_2, table.remove(var_45_0, math.random(1, #var_45_0)))
			end

			return var_45_2
		end,
		getApearTime = function(self)
			if self.lastTime and self.lastTime > 0 then
				for iter_46_0 = 1, #var_0_6 do
					if self.lastTime < var_0_6[iter_46_0][1] then
						return var_0_6[iter_46_0][2]
					end
				end
			end

			return var_0_6[#var_0_6][2]
		end,
		getFansAmount = function(self)
			local var_47_0 = 0

			for iter_47_0 = 1, #self.groups do
				var_47_0 = var_47_0 + self.groups[iter_47_0]:getFansAmount()
			end

			return var_47_0
		end,
		start = function(self)
			self:reset()

			self.createFansTime = nil
			self.lastTime = var_0_3

			for iter_48_0 = 1, 3 do
				self.groups[math.random(1, #self.groups)]:createFans(tf(instantiate(self._tplFans)))
			end

			for iter_48_1 = 1, #self.groups do
				self.groups[iter_48_1]:start()
			end

			return
		end,
		step = function(self, arg_49_1)
			self.lastTime = self.lastTime - Time.deltaTime

			if not self.createFansTime then
				self.createFansTime = arg_49_1 + self:getApearTime() + math.random() * 1
			elseif arg_49_1 > self.createFansTime and self:getFansAmount() <= 10 then
				self.groups[math.random(1, #self.groups)]:createFans(tf(instantiate(self._tplFans)))

				self.createFansTime = arg_49_1 + self:getApearTime() + math.random() * 1
			end

			for iter_49_0 = 1, #self.groups do
				self.groups[iter_49_0]:step(arg_49_1)
			end

			return
		end,
		reset = function(self)
			for iter_50_0 = 1, #self.groups do
				self.groups[iter_50_0]:reset()
			end

			return
		end,
		destroy = function(self)
			for iter_51_0 = 1, #self.groups do
				self.groups[iter_51_0]:destroy()
			end

			return
		end
	}

	var_41_0:Ctor()

	return var_41_0
end

function IdolMasterView:getUIName()
	return "IdolMasterGameUI"
end

function IdolMasterView:getBGM()
	return var_0_1[math.random(1, #var_0_1)]
end

function IdolMasterView:didEnter()
	self:initEvent()
	self:initData()
	self:initUI()
	self:initGameUI()
	self:initTextTip()
	self:updateMenuUI()
	self:openMenuUI()

	return
end

function IdolMasterView:initEvent()
	self:bind(var_0_11, function(arg_56_0, arg_56_1, arg_56_2)
		if self.idolGroupUI then
			self.idolGroupUI:receiveGift(arg_56_1, arg_56_2)
		end

		return
	end)
	self:bind(var_0_12, function(arg_57_0, arg_57_1, arg_57_2)
		if self.gameStartFlag then
			if arg_57_1 == var_0_29 then
				self:loseHeart()
			elseif arg_57_1 == var_0_30 then
				self:addScore(100)
			end
		end

		return
	end)

	return
end

function IdolMasterView:initData()
	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / (Application.targetFrameRate or 60), -1)

	return
end

function IdolMasterView:initUI()
	self.sceneTf = findTF(self._tf, "scene")
	self.clickMask = findTF(self._tf, "clickMask")
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		setActive(self.countUI, false)
		self:gameStart()

		return
	end)

	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	onButton(self, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()

		return
	end, SFX_CANCEL)

	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	onButton(self, findTF(self.pauseUI, "ad/btnOk"), function()
		setActive(self.pauseUI, false)
		self:resumeGame()

		return
	end, SFX_CANCEL)

	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	onButton(self, findTF(self.settlementUI, "ad/btnOver"), function()
		setActive(self.settlementUI, false)
		self:openMenuUI()

		return
	end, SFX_CANCEL)

	self.menuUI = findTF(self._tf, "pop/menuUI")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "battList"), typeof(ScrollRect))
	self.totalTimes = self:getGameTotalTime()

	scrollTo(self.battleScrollRect, 0, 1 - (self:getGameUsedTimes() - 4 < 0 and 0 or self:getGameUsedTimes() - 4) / (self.totalTimes - 4))
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowUp"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowDown"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.handshake_game_help.tip
		})

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnStart"), function()
		if self:getGameUsedTimes() == 0 and not var_0_8 then
			var_0_8 = true

			setActive(self.helpUI, true)
		else
			setActive(self.menuUI, false)
			self:readyStart()
		end

		return
	end, SFX_CANCEL)

	local var_60_0 = findTF(self.menuUI, "tplBattleItem")

	self.battleItems = {}

	for iter_60_0 = 1, self.totalTimes do
		local var_60_1 = tf(instantiate(var_60_0))

		var_60_1.name = "battleItem_" .. iter_60_0

		setParent(var_60_1, findTF(self.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/idolmasterui_atlas", "tx_" .. iter_60_0, function(arg_72_0)
			setImageSprite(findTF(var_60_1, "state_open/icon"), arg_72_0, true)
			setImageSprite(findTF(var_60_1, "state_clear/icon"), arg_72_0, true)
			setImageSprite(findTF(var_60_1, "state_current/icon"), arg_72_0, true)

			return
		end)
		GetSpriteFromAtlasAsync("ui/minigameui/idolmasterui_atlas", "battleDesc" .. iter_60_0, function(arg_73_0)
			setImageSprite(findTF(var_60_1, "state_open/buttomDesc"), arg_73_0, true)
			setImageSprite(findTF(var_60_1, "state_clear/buttomDesc"), arg_73_0, true)
			setImageSprite(findTF(var_60_1, "state_current/buttomDesc"), arg_73_0, true)
			setImageSprite(findTF(var_60_1, "state_closed/buttomDesc"), arg_73_0, true)

			return
		end)
		setActive(var_60_1, true)
		table.insert(self.battleItems, var_60_1)
	end

	self.helpUI = findTF(self._tf, "pop/HelpUI")

	onButton(self, findTF(self.helpUI, "close"), function()
		setActive(self.helpUI, false)
		setActive(self.menuUI, false)
		self:readyStart()

		return
	end, SFX_CANCEL)

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function IdolMasterView:initGameUI()
	self.gameUI = findTF(self._tf, "ui/gameUI")
	self.textScore = findTF(self.gameUI, "top/score")

	onButton(self, findTF(self.gameUI, "topRight/btnStop"), function()
		self:stopGame()
		setActive(self.pauseUI, true)

		return
	end)
	onButton(self, findTF(self.gameUI, "btnLeave"), function()
		self:stopGame()
		setActive(self.leaveUI, true)

		return
	end)

	self.gameTimeM = findTF(self.gameUI, "topRight/time/m")
	self.gameTimeS = findTF(self.gameUI, "topRight/time/s")
	self.heartTfs = {}

	for iter_75_0 = 1, var_0_28 do
		table.insert(self.heartTfs, findTF(self.gameUI, "top/heart" .. iter_75_0 .. "/full"))
	end

	self.scoreTf = findTF(self.gameUI, "top/score")
	self.giftUI = var_0_39(findTF(self._tf, "scene/gift"), findTF(self._tf, "scene/jiujiuWorker"), self)
	self.idolGroupUI = var_0_41(findTF(self._tf, "scene/IdolContainer"), findTF(self._tf, "scene/group"), findTF(self._tf, "scene/Idol"), findTF(self._tf, "scene/fans"), self)

	return
end

function IdolMasterView:initTextTip()
	var_0_34 = i18n("idolmaster_game_tip1") or var_0_34
	var_0_35 = i18n("idolmaster_game_tip2") or var_0_35
	var_0_36 = i18n("idolmaster_game_tip3") or var_0_36
	var_0_37 = i18n("idolmaster_game_tip4") or var_0_37
	var_0_38 = i18n("idolmaster_game_tip5") or var_0_38

	setText(findTF(self.settlementUI, "ad/currentTextDesc"), var_0_36)
	setText(findTF(self.settlementUI, "ad/highTextDesc"), var_0_37)
	setText(findTF(self.gameUI, "top/scoreImg/socre"), var_0_38)
	setText(findTF(self.pauseUI, "ad/tip"), var_0_34)
	setText(findTF(self.leaveUI, "ad/tip"), var_0_35)

	return
end

function IdolMasterView:Update()
	self:AddDebugInput()

	return
end

function IdolMasterView:AddDebugInput()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function IdolMasterView:updateMenuUI()
	local var_81_0 = self:getGameUsedTimes()
	local var_81_1 = self:getGameTimes()

	for iter_81_0 = 1, #self.battleItems do
		setActive(findTF(self.battleItems[iter_81_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_81_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_81_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_81_0], "state_current"), false)

		if iter_81_0 <= var_81_0 then
			setActive(findTF(self.battleItems[iter_81_0], "state_clear"), true)
		elseif iter_81_0 == var_81_0 + 1 and var_81_1 >= 1 then
			setActive(findTF(self.battleItems[iter_81_0], "state_current"), true)
		elseif var_81_0 < iter_81_0 and iter_81_0 <= var_81_0 + var_81_1 then
			setActive(findTF(self.battleItems[iter_81_0], "state_open"), true)
		else
			setActive(findTF(self.battleItems[iter_81_0], "state_closed"), true)
		end
	end

	self.totalTimes = self:getGameTotalTime()

	local var_81_2 = 1 - (self:getGameUsedTimes() - 3 < 0 and 0 or self:getGameUsedTimes() - 3) / (self.totalTimes - 4)

	if var_81_2 > 1 then
		var_81_2 = 1
	end

	scrollTo(self.battleScrollRect, 0, var_81_2)
	setActive(findTF(self.menuUI, "btnStart/tip"), var_81_1 > 0)
	self:CheckGet()

	return
end

function IdolMasterView:CheckGet()
	setActive(findTF(self.menuUI, "got"), false)

	if self:getUltimate() and self:getUltimate() ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if self:getUltimate() == 0 then
		if self:getGameTotalTime() > self:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(self.menuUI, "got"), true)
	end

	return
end

function IdolMasterView:openMenuUI()
	setActive(findTF(self._tf, "scene_front"), false)
	setActive(findTF(self._tf, "scene_background"), false)
	setActive(findTF(self._tf, "scene"), false)
	setActive(self.gameUI, false)
	setActive(self.menuUI, true)

	if self.storyIndex and var_0_7[self.storyIndex] ~= "" and self:getGameUsedTimes() == self.storyIndex then
		pg.NewStoryMgr.GetInstance():Play(var_0_7[self.storyIndex], function()
			return
		end, true)

		self.storyIndex = nil
	end

	self:updateMenuUI()

	return
end

function IdolMasterView:clearUI()
	setActive(self.sceneTf, false)
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)
	setActive(self.menuUI, false)
	setActive(self.gameUI, false)

	return
end

function IdolMasterView:readyStart()
	setActive(self.countUI, true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)
	self.idolGroupUI:createIdols()

	return
end

function IdolMasterView:gameStart()
	setActive(findTF(self._tf, "scene_front"), true)
	setActive(findTF(self._tf, "scene_background"), true)
	setActive(findTF(self._tf, "scene"), true)
	setActive(self.gameUI, true)

	self.gameStartFlag = true
	self.scoreNum = 0
	self.playerPosIndex = 2
	self.gameStepTime = 0
	self.heart = var_0_28
	self.gameTime = var_0_3

	self.idolGroupUI:start()
	self.giftUI:start()
	self:updateGameUI()
	self:timerStart()

	return
end

function IdolMasterView:getGameTimes()
	return self:GetMGHubData().count
end

function IdolMasterView:getGameUsedTimes()
	return self:GetMGHubData().usedtime
end

function IdolMasterView:getUltimate()
	return self:GetMGHubData().ultimate
end

function IdolMasterView:getGameTotalTime()
	return (self:GetMGHubData():getConfig("reward_need"))
end

function IdolMasterView:changeSpeed(arg_92_1)
	return
end

function IdolMasterView:onTimer()
	self:gameStep()

	return
end

function IdolMasterView:gameStep()
	self.gameTime = self.gameTime - Time.deltaTime

	if self.gameTime < 0 then
		self.gameTime = 0
	end

	self.gameStepTime = self.gameStepTime + Time.deltaTime

	if self.idolGroupUI then
		self.idolGroupUI:step(self.gameStepTime)
	end

	self:updateGameUI()

	if self.gameTime <= 0 then
		self:onGameOver()

		return
	end

	return
end

function IdolMasterView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function IdolMasterView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function IdolMasterView:updateGameUI()
	setText(self.textScore, self.scoreNum)

	local var_97_0 = math.floor(math.ceil(self.gameTime) / 60)

	if var_97_0 < 10 then
		var_97_0 = "0" .. var_97_0
	end

	local var_97_1 = math.floor(math.ceil(self.gameTime) % 60)

	if var_97_1 < 10 then
		var_97_1 = "0" .. var_97_1
	end

	for iter_97_0 = 1, #self.heartTfs do
		if iter_97_0 <= self.heart then
			setActive(self.heartTfs[iter_97_0], true)
		else
			setActive(self.heartTfs[iter_97_0], false)
		end
	end

	setText(self.scoreTf, self.scoreNum)
	setText(self.gameTimeM, var_97_0)
	setText(self.gameTimeS, var_97_1)

	return
end

function IdolMasterView:loseHeart()
	if self.heart <= 0 then
		return
	end

	self.heart = self.heart - 1

	self:updateGameUI()

	if self.heart <= 0 then
		self.heart = 0

		self:onGameOver()
	end

	return
end

function IdolMasterView:addScore(arg_99_1)
	self.scoreNum = self.scoreNum + arg_99_1

	if self.scoreNum < 0 then
		self.scoreNum = 0
	end

	return
end

function IdolMasterView:onGameOver()
	if self.settlementFlag then
		return
	end

	self:timerStop()

	self.settlementFlag = true

	setActive(self.clickMask, true)
	LeanTween.delayedCall(go(self._tf), 2, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:showSettlement()

		return
	end))

	return
end

function IdolMasterView:showSettlement()
	setActive(self.settlementUI, true)
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_102_0 = self:GetMGData():GetRuntimeData("elements")
	local var_102_1 = self.scoreNum
	local var_102_2

	if var_102_0 and #var_102_0 > 0 then
		var_102_2 = var_102_0[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_102_2 < var_102_1)

	if var_102_2 <= var_102_1 then
		var_102_2 = var_102_1

		self:StoreDataToServer({
			var_102_1
		})
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_102_2)
	setText(findTF(self.settlementUI, "ad/currentText"), var_102_1)

	if self:getGameTimes() and self:getGameTimes() > 0 then
		self.sendSuccessFlag = true
		self.storyIndex = self:getGameUsedTimes() + 1

		self:SendSuccess(0)
	end

	return
end

function IdolMasterView:resumeGame()
	self.gameStop = false

	setActive(self.leaveUI, false)
	self:changeSpeed(1)
	self:timerStart()

	return
end

function IdolMasterView:stopGame()
	self.gameStop = true

	self:timerStop()
	self:changeSpeed(0)

	return
end

function IdolMasterView:onBackPressed()
	if not self.gameStartFlag then
		self:emit(IdolMasterView.ON_BACK_PRESSED)
	else
		if self.settlementFlag then
			return
		end

		if isActive(self.pauseUI) then
			setActive(self.pauseUI, false)
		end

		self:stopGame()
		setActive(self.leaveUI, true)
	end

	return
end

function IdolMasterView:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	Time.timeScale = 1
	self.timer = nil

	return
end

return IdolMasterView
