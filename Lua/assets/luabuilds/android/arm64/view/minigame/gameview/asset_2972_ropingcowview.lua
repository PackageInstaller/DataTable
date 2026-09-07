local IdolMasterView = class("IdolMasterView", import("..BaseMiniGameView"))
local var_0_1 = "backyard"
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_5 = 60
local var_0_6 = 100
local var_0_7 = 10
local var_0_8 = {
	{
		20,
		3
	},
	{
		40,
		4
	},
	{
		60,
		5
	},
	{
		10000,
		5
	}
}
local var_0_9 = {
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
	},
	{
		10700061,
		10700060
	},
	{
		10700071,
		10700070
	}
}
local var_0_10 = {
	{
		10700011,
		10700010
	},
	{
		10700021,
		10700020
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
local var_0_18 = "stand2"
local var_0_19 = "normal"
local var_0_20 = "work"
local var_0_21 = "wrong"
local var_0_22 = "end1"
local var_0_23 = "end2"
local var_0_24 = "gift"
local var_0_25 = "normal"
local var_0_26 = "walk"
local var_0_27 = 3
local var_0_28 = "type_fans_fail"
local var_0_29 = "type_fans_success"
local var_0_30 = 4
local var_0_31 = {
	Vector3(160, 160),
	Vector3(160, -30),
	Vector3(160, -210),
	Vector3(160, -400)
}
local var_0_32 = 350

local function var_0_33(arg_1_0, arg_1_1, arg_1_2)
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
					model = self.model,
					anim = arg_3_0:GetComponent(typeof(SpineAnimUI)),
					name = var_2_0
				}

				self:changeWorkerAction(var_0_19, 0, nil)

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
						self.wokerSpine.anim:SetAction(var_0_19, 0)
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
				self:changeWorkerAction(var_0_20, 1)
			else
				table.remove(self.selectedGifts, var_7_1)
			end

			if #self.selectedGifts >= var_0_16 then
				self._event:emit(var_0_11, Clone(self.selectedGifts), function(arg_8_0)
					if not arg_8_0 then
						self:changeWorkerAction(var_0_21, 1)
					end

					return
				end)

				self.selectedGifts = {}

				self:moveJiujiu(-1)
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
		moveJiujiu = function(self, arg_11_1)
			if arg_11_1 == -1 then
				self._workerTf.anchoredPosition = Vector3.New(-290, 30, 0)
				self._workerTf.localScale = Vector3.New(-1, 1, 1)
			else
				local var_11_0 = self._workerTf.parent:InverseTransformPoint(self.gifts[arg_11_1].tf.position)

				var_11_0.x = var_11_0.x + 22
				var_11_0.y = var_11_0.y - 50
				self._workerTf.anchoredPosition = var_11_0
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

local function var_0_34(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {
		Ctor = function(self)
			self._groupTf = arg_13_1
			self._groupIndex = arg_13_2
			self._groupTf.anchoredPosition = var_0_31[arg_13_2]
			self._event = arg_13_3
			self.modelData = {}

			SetActive(self._groupTf, true)
			self:createIdol(arg_13_0[1], arg_13_0[2])

			self.fans = {}
			self.wantedData = {}

			return
		end,
		createIdol = function(arg_15_0, arg_15_1, arg_15_2)
			PoolMgr.GetInstance():GetSpineChar(Ship.New({
				configId = arg_15_1,
				skin_id = arg_15_2
			}):getPrefab(), true, function(arg_16_0)
				arg_16_0.transform.localScale = Vector3.one
				arg_16_0.transform.localPosition = Vector3.zero

				arg_16_0.transform:SetParent(findTF(arg_15_0._groupTf, "idolPos"), false)

				arg_15_0.modelData = {
					model = arg_15_0.model,
					id = arg_15_1,
					skinId = arg_15_2,
					anim = arg_16_0:GetComponent(typeof(SpineAnimUI))
				}

				arg_15_0:changeCharAction(var_0_18, 0, nil)

				return
			end)

			return
		end,
		changeCharAction = function(self, arg_17_1, arg_17_2, arg_17_3)
			if self.modelData.actionName == arg_17_1 then
				return
			end

			self.modelData.actionName = arg_17_1

			self.modelData.anim:SetActionCallBack(nil)
			self.modelData.anim:SetAction(arg_17_1, 0)
			self.modelData.anim:SetActionCallBack(function(arg_18_0)
				if arg_18_0 == "finish" then
					if arg_17_2 == 1 then
						self.modelData.anim:SetActionCallBack(nil)
						self.modelData.anim:SetAction(var_0_18, 0)
					end

					if arg_17_3 then
						arg_17_3()
					end
				end

				return
			end)

			if arg_17_2 ~= 1 and arg_17_3 then
				arg_17_3()
			end

			return
		end,
		createFans = function(self, arg_19_1)
			SetActive(arg_19_1, true)
			SetParent(arg_19_1, findTF(self._groupTf, "fansPos"))

			if #self.fans > 0 then
				self.fans[#self.fans].tf.anchoredPosition.x = self.fans[#self.fans].tf.anchoredPosition.x + var_0_32 + math.random() * 200 + 22
				arg_19_1.anchoredPosition = Vector3.New(self.fans[#self.fans].tf.anchoredPosition.x, self.fans[#self.fans].tf.anchoredPosition.y, self.fans[#self.fans].tf.anchoredPosition.z)
			else
				arg_19_1.anchoredPosition = Vector3.New((#self.fans + 1) * var_0_32 + 200, 0, 0)
			end

			table.insert(self.fans, {
				tf = arg_19_1,
				speed = math.random() + 2.5
			})

			local var_19_0 = self.fans[#self.fans]
			local var_19_1 = "jiu-fan" .. math.random(1, 4)

			PoolMgr.GetInstance():GetSpineChar(var_19_1, true, function(arg_20_0)
				arg_20_0.transform.localScale = Vector3.one
				arg_20_0.transform.localPosition = Vector3.zero

				arg_20_0.transform:SetParent(findTF(var_19_0.tf, "spinePos"), false)

				var_19_0.modelData = {
					model = arg_20_0,
					anim = arg_20_0:GetComponent(typeof(SpineAnimUI)),
					modelName = var_19_1
				}

				return
			end)

			return
		end,
		changeFansAction = function(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
			if not arg_21_1.modelData or arg_21_1.modelData.actionName == arg_21_2 then
				return
			end

			arg_21_1.modelData.actionName = arg_21_2

			arg_21_1.modelData.anim:SetActionCallBack(nil)
			arg_21_1.modelData.anim:SetAction(arg_21_2, 0)
			arg_21_1.modelData.anim:SetActionCallBack(function(arg_22_0)
				if arg_22_0 == "finish" then
					if arg_21_3 == 1 then
						arg_21_1.modelData.anim:SetActionCallBack(nil)
						arg_21_1.modelData.anim:SetAction(var_0_25, 0)
					end

					if arg_21_4 then
						arg_21_4()
					end
				end

				return
			end)

			if arg_21_3 ~= 1 and arg_21_4 then
				arg_21_4()
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
			for iter_24_0 = 1, #self.fans do
				PoolMgr.GetInstance():ReturnSpineChar(self.fans[iter_24_0].modelData.modelName, self.fans[iter_24_0].modelData.model)
				Destroy(self.fans[iter_24_0].tf)
			end

			self.fans = {}

			return
		end,
		start = function(arg_25_0)
			return
		end,
		step = function(self, arg_26_1)
			self.stepTime = arg_26_1

			for iter_26_0 = #self.fans, 1, -1 do
				if self.fans[iter_26_0].tf.anchoredPosition.x > (iter_26_0 - 1) * var_0_32 then
					self.fans[iter_26_0].tf.anchoredPosition.x = self.fans[iter_26_0].tf.anchoredPosition.x - self.fans[iter_26_0].speed
					self.fans[iter_26_0].tf.anchoredPosition = self.fans[iter_26_0].tf.anchoredPosition

					self:changeFansAction(self.fans[iter_26_0], var_0_26, 0, nil)
				elseif iter_26_0 == 1 and not self.fans[iter_26_0].leave then
					if self.fans[iter_26_0].gifts == nil then
						self.fans[iter_26_0].gifts = self:createWantedGifts()
						self.fans[iter_26_0].time = arg_26_1 + var_0_7

						setImageSprite(findTF(self.fans[iter_26_0].tf, "score/pack"), (LoadSprite("ui/minigameui/idolmasterui_atlas", "pack" .. self.fans[iter_26_0].gifts[1])))
						self:changeFansAction(self.fans[iter_26_0], var_0_24, 0, nil)
					end
				elseif not self.fans[iter_26_0].leave then
					self:changeFansAction(self.fans[iter_26_0], var_0_25, 0, nil)
				end
			end

			if #self.fans > 0 then
				local var_26_1 = self.fans[1]

				if self.fans[1].time and arg_26_1 > var_26_1.time and not var_26_1.leave then
					var_26_1.leave = true

					self:fanLeave(var_26_1, var_0_28, function()
						table.remove(self.fans, 1)

						return
					end)
				else
					self:showFansWanted(var_26_1)
				end

				var_26_1.tf:SetSiblingIndex(#self.fans - 1)
			end

			return
		end,
		showFansWanted = function(self, arg_28_1)
			if arg_28_1.leave then
				return
			end

			local var_28_0 = arg_28_1.time

			if not arg_28_1.time then
				return
			end

			local var_28_1 = math.ceil(var_28_0 - self.stepTime) < 0 and 0 or var_28_0 - self.stepTime
			local var_28_2 = arg_28_1.gifts
			local var_28_3 = var_28_1 <= 5

			setActive(findTF(arg_28_1.tf, "wanted"), true)
			setActive(findTF(arg_28_1.tf, "wanted/bg1"), not var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/bgTime1"), not var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/time1"), not var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/bg2"), var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/bgTime2"), var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/time1"), var_28_3)

			if var_28_1 < 0 then
				var_28_1 = 0
			end

			setText(findTF(arg_28_1.tf, "wanted/time1"), math.abs(math.ceil(var_28_1)) .. "S")
			setText(findTF(arg_28_1.tf, "wanted/time2"), math.abs(math.ceil(var_28_1)) .. "S")

			for iter_28_0 = 1, #var_28_2 do
				setImageSprite(findTF(arg_28_1.tf, "wanted/item" .. iter_28_0), (LoadSprite("ui/minigameui/idolmasterui_atlas", "wantItem" .. var_28_2[iter_28_0])))
			end

			return
		end,
		checkGifts = function(self, arg_29_1)
			local var_29_0 = self:getWantedGifts()

			if var_29_0 then
				for iter_29_0 = 1, #arg_29_1 do
					if not table.contains(var_29_0, arg_29_1[iter_29_0]) then
						return false
					end
				end

				self.fans[1].leave = true

				self:fanLeave(self.fans[1], var_0_29, function()
					table.remove(self.fans, 1)

					return
				end)

				return true
			end

			return false
		end,
		createWantedGifts = function(arg_31_0)
			local var_31_0 = Clone(var_0_15)
			local var_31_1 = {}

			table.insert(var_31_1, var_0_14[math.random(1, #var_0_14)])

			for iter_31_0 = 1, 2 do
				table.insert(var_31_1, (table.remove(var_31_0, math.random(1, #var_31_0))))
			end

			return var_31_1
		end,
		fanLeave = function(self, arg_32_1, arg_32_2, arg_32_3)
			setActive(findTF(arg_32_1.tf, "wanted"), false)

			local var_32_0

			if var_0_28 == arg_32_2 then
				var_32_0 = var_0_23
			elseif var_0_29 then
				var_32_0 = var_0_22

				setText(findTF(arg_32_1.tf, "score"), "+" .. var_0_6)
				setActive(findTF(arg_32_1.tf, "score"), true)
			end

			self:changeFansAction(arg_32_1, var_32_0, 1, function()
				PoolMgr.GetInstance():ReturnSpineChar(arg_32_1.modelData.modelName, arg_32_1.modelData.model)
				self._event:emit(var_0_12, arg_32_2)
				Destroy(arg_32_1.tf)
				arg_32_3()

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

local function var_0_35(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = {
		Ctor = function(self)
			self._containerTf = arg_36_0
			self._tplGroup = arg_36_1
			self._tplIdol = arg_36_2
			self._tplFans = arg_36_3
			self._event = arg_36_4
			self.groups = {}

			local var_37_0 = self:getRandomIdols()

			for iter_37_0 = 1, var_0_30 do
				local var_37_1 = tf(Instantiate(self._tplGroup))

				SetParent(var_37_1, self._containerTf)
				table.insert(self.groups, (var_0_34(var_37_0[iter_37_0], var_37_1, iter_37_0, self._event)))
			end

			return
		end,
		receiveGift = function(self, arg_38_1, arg_38_2)
			local var_38_0 = false

			for iter_38_0 = 1, #self.groups do
				if self.groups[iter_38_0]:checkGifts(arg_38_1) then
					var_38_0 = true

					break
				end
			end

			if arg_38_2 then
				arg_38_2(var_38_0)
			end

			return
		end,
		getRandomIdols = function(arg_39_0)
			local var_39_0 = {}
			local var_39_1 = Clone(var_0_9)

			for iter_39_0 = 1, var_0_30 do
				local var_39_2 = false

				if iter_39_0 == var_0_30 then
					var_39_2 = true

					for iter_39_1, iter_39_2 in ipairs(var_0_10) do
						if table.contains(var_39_0, iter_39_2) then
							var_39_2 = false
						end
					end
				end

				if var_39_2 then
					table.insert(var_39_0, var_0_10[math.random(1, #var_0_10)])
				else
					table.insert(var_39_0, table.remove(var_39_1, math.random(1, #var_39_1)))
				end
			end

			return var_39_0
		end,
		getApearTime = function(self)
			if self.runTime and self.runTime > 0 then
				for iter_40_0 = 1, #var_0_8 do
					if self.runTime < var_0_8[iter_40_0][1] then
						return var_0_8[iter_40_0][2]
					end
				end
			end

			return var_0_8[#var_0_8][2]
		end,
		start = function(self)
			self:reset()

			self.createFansTime = nil
			self.lastTime = var_0_5

			for iter_41_0 = 1, 3 do
				self.groups[math.random(1, #self.groups)]:createFans(tf(instantiate(self._tplFans)))
			end

			for iter_41_1 = 1, #self.groups do
				self.groups[iter_41_1]:start()
			end

			return
		end,
		step = function(self, arg_42_1)
			self.lastTime = self.lastTime - Time.deltaTime

			local var_42_0 = self:getApearTime()

			if not self.createFansTime then
				self.createFansTime = arg_42_1 + var_42_0 + math.random() * 1
			elseif arg_42_1 > self.createFansTime then
				self.groups[math.random(1, #self.groups)]:createFans(tf(instantiate(self._tplFans)))

				self.createFansTime = arg_42_1 + var_42_0 + math.random() * 1
			end

			for iter_42_0 = 1, #self.groups do
				self.groups[iter_42_0]:step(arg_42_1)
			end

			return
		end,
		reset = function(self)
			for iter_43_0 = 1, #self.groups do
				self.groups[iter_43_0]:reset()
			end

			return
		end,
		destroy = function(self)
			for iter_44_0 = 1, #self.groups do
				self.groups[iter_44_0]:destroy()
			end

			return
		end
	}

	var_36_0:Ctor()

	return var_36_0
end

function IdolMasterView:getUIName()
	return "IdolMasterGameUI"
end

function IdolMasterView:getBGM()
	return var_0_1
end

function IdolMasterView:didEnter()
	self:initEvent()
	self:initData()
	self:initUI()
	self:initGameUI()
	self:updateMenuUI()
	self:openMenuUI()

	return
end

function IdolMasterView:initEvent()
	self:bind(var_0_11, function(arg_49_0, arg_49_1, arg_49_2)
		if self.idolGroupUI then
			self.idolGroupUI:receiveGift(arg_49_1, arg_49_2)
		end

		return
	end)
	self:bind(var_0_12, function(arg_50_0, arg_50_1, arg_50_2)
		if self.gameStartFlag then
			if arg_50_1 == var_0_28 then
				self:loseHeart()
			elseif arg_50_1 == var_0_29 then
				self:addScore(100)
			end
		end

		return
	end)

	return
end

function IdolMasterView:initData()
	local var_51_0 = Application.targetFrameRate or 60

	self.storylist = self:GetMGHubData():GetSimpleValue("story")
	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / var_51_0, -1)

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
			helps = pg.gametip.cowboy_tips.tip
		})

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnStart"), function()
		setActive(self.menuUI, false)
		self:readyStart()

		return
	end, SFX_CANCEL)

	local var_53_0 = findTF(self.menuUI, "tplBattleItem")

	self.battleItems = {}

	for iter_53_0 = 1, self.totalTimes do
		local var_53_1 = tf(instantiate(var_53_0))

		var_53_1.name = "battleItem_" .. iter_53_0

		setParent(var_53_1, findTF(self.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/idolmasterui_atlas", "tx_" .. iter_53_0, function(arg_65_0)
			setImageSprite(findTF(var_53_1, "state_open/icon"), arg_65_0, true)
			setImageSprite(findTF(var_53_1, "state_clear/icon"), arg_65_0, true)
			setImageSprite(findTF(var_53_1, "state_current/icon"), arg_65_0, true)

			return
		end)
		GetSpriteFromAtlasAsync("ui/minigameui/idolmasterui_atlas", "battleDesc" .. iter_53_0, function(arg_66_0)
			setImageSprite(findTF(var_53_1, "state_open/buttomDesc"), arg_66_0, true)
			setImageSprite(findTF(var_53_1, "state_clear/buttomDesc"), arg_66_0, true)
			setImageSprite(findTF(var_53_1, "state_current/buttomDesc"), arg_66_0, true)
			setImageSprite(findTF(var_53_1, "state_closed/buttomDesc"), arg_66_0, true)

			return
		end)
		setActive(var_53_1, true)
		table.insert(self.battleItems, var_53_1)
	end

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

	for iter_67_0 = 1, var_0_27 do
		table.insert(self.heartTfs, findTF(self.gameUI, "top/heart" .. iter_67_0 .. "/full"))
	end

	self.scoreTf = findTF(self.gameUI, "top/score")
	self.giftUI = var_0_33(findTF(self._tf, "scene/gift"), findTF(self._tf, "scene/jiujiuWorker"), self)
	self.idolGroupUI = var_0_35(findTF(self._tf, "scene/IdolContainer"), findTF(self._tf, "scene/group"), findTF(self._tf, "scene/Idol"), findTF(self._tf, "scene/fans"), self)

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
	local var_72_0 = self:getGameUsedTimes()
	local var_72_1 = self:getGameTimes()

	for iter_72_0 = 1, #self.battleItems do
		setActive(findTF(self.battleItems[iter_72_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_72_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_72_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_72_0], "state_current"), false)

		if iter_72_0 <= var_72_0 then
			setActive(findTF(self.battleItems[iter_72_0], "state_clear"), true)
		elseif iter_72_0 == var_72_0 + 1 and var_72_1 >= 1 then
			setActive(findTF(self.battleItems[iter_72_0], "state_current"), true)
		elseif var_72_0 < iter_72_0 and iter_72_0 <= var_72_0 + var_72_1 then
			setActive(findTF(self.battleItems[iter_72_0], "state_open"), true)
		else
			setActive(findTF(self.battleItems[iter_72_0], "state_closed"), true)
		end
	end

	self.totalTimes = self:getGameTotalTime()

	local var_72_2 = 1 - (self:getGameUsedTimes() - 3 < 0 and 0 or self:getGameUsedTimes() - 3) / (self.totalTimes - 4)

	if var_72_2 > 1 then
		var_72_2 = 1
	end

	scrollTo(self.battleScrollRect, 0, var_72_2)
	setActive(findTF(self.menuUI, "btnStart/tip"), var_72_1 > 0)
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
	self.heart = var_0_27
	self.gameTime = var_0_5

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

function IdolMasterView:changeSpeed(arg_82_1)
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

	local var_87_0 = math.floor(math.ceil(self.gameTime) / 60)

	if var_87_0 < 10 then
		var_87_0 = "0" .. var_87_0
	end

	local var_87_1 = math.floor(math.ceil(self.gameTime) % 60)

	if var_87_1 < 10 then
		var_87_1 = "0" .. var_87_1
	end

	for iter_87_0 = 1, #self.heartTfs do
		if iter_87_0 <= self.heart then
			setActive(self.heartTfs[iter_87_0], true)
		else
			setActive(self.heartTfs[iter_87_0], false)
		end
	end

	setText(self.scoreTf, self.scoreNum)
	setText(self.gameTimeM, var_87_0)
	setText(self.gameTimeS, var_87_1)

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

function IdolMasterView:addScore(arg_89_1)
	self.scoreNum = self.scoreNum + arg_89_1

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

	local var_92_0 = self:GetMGData():GetRuntimeData("elements")
	local var_92_1 = self.scoreNum
	local var_92_2

	if var_92_0 and #var_92_0 > 0 then
		var_92_2 = var_92_0[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_92_2 < var_92_1)

	if var_92_2 <= var_92_1 then
		var_92_2 = var_92_1

		self:StoreDataToServer({
			var_92_1
		})
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_92_2)
	setText(findTF(self.settlementUI, "ad/currentText"), var_92_1)

	if self:getGameTimes() and self:getGameTimes() > 0 then
		local var_92_3 = self:getGameUsedTimes() + 1
		local var_92_4 = pg.NewStoryMgr.GetInstance()

		if self.storylist[var_92_3] then
			local var_92_5 = self.storylist[var_92_3][1] or nil

			if var_92_5 and not var_92_4:IsPlayed(var_92_5) then
				var_92_4:Play(var_92_5)
			end
		end

		self.sendSuccessFlag = true

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
