local GameHallContainerUI = class("GameHallContainerUI")
local var_0_1 = 4
local var_0_2 = Vector3(0.7, 0.7, 0.7)
local var_0_3 = "mingshi"
local var_0_4 = 0.1
local var_0_5 = 100
local var_0_6 = 4
local var_0_7
local var_0_8
local var_0_9 = 3256
local var_0_10 = 1920
local var_0_11 = {
	{
		"item3",
		"item3/spine"
	}
}
local var_0_12 = {
	{
		bound = "item1/spine/bound",
		pos = "item1/spine/pos",
		spine = "item1/spine"
	},
	{
		bound = "item2/spine2/bound",
		pos = "item2/spine2/pos",
		spine = "item2/spine2"
	},
	{
		bound = "item2/spine3/bound",
		pos = "item2/spine3/pos",
		spine = "item2/spine3"
	},
	{
		bound = "item4/spine1/bound",
		pos = "item4/spine1/pos",
		spine = "item4/spine1"
	},
	{
		bound = "item4/spine2/bound",
		pos = "item4/spine2/pos",
		spine = "item4/spine2"
	},
	{
		bound = "item6/spine1/bound",
		pos = "item6/spine1/pos",
		spine = "item6/spine1"
	},
	{
		bound = "item6/spine2/bound",
		pos = "item6/spine2/pos",
		spine = "item6/spine2"
	}
}

function GameHallContainerUI:Ctor(arg_1_1)
	var_0_7 = {
		var_0_10 - var_0_9 + (pg.UIMgr.GetInstance().uiCamera.gameObject.transform:Find("Canvas").sizeDelta.x - var_0_10),
		0
	}
	var_0_8 = {
		0,
		0
	}
	self.container = arg_1_1
	self.content = findTF(self.container, "content")
	self.pos = findTF(self.content, "pos")
	self.boundContainer = findTF(self.content, "bound")
	self.charContentEvents = {}
	self.charContentCollider = {}
	self.items = {}

	for iter_1_0 = 0, self.pos.childCount - 1 do
		table.insert(self.items, self.pos:GetChild(iter_1_0))
	end

	self.sitItems = {}

	for iter_1_1 = 1, #var_0_12 do
		local var_1_0 = GetComponent(findTF(self.pos, var_0_12[iter_1_1].bound), typeof(BoxCollider2D))

		table.insert(self.sitItems, {
			sit = false,
			pos = findTF(self.pos, var_0_12[iter_1_1].pos),
			min = self.pos:InverseTransformPoint(var_1_0.bounds.min),
			max = self.pos:InverseTransformPoint(var_1_0.bounds.max),
			anim = GetComponent(findTF(self.pos, var_0_12[iter_1_1].spine), typeof(SpineAnimUI))
		})
	end

	local var_1_1 = getProxy(BayProxy):getShips()
	local var_1_2 = {}

	for iter_1_2 = 1, #var_1_1 do
		if not table.contains(var_1_2, var_1_1[iter_1_2].name) then
			table.insert(var_1_2, var_1_1[iter_1_2]:getPrefab())
		end
	end

	if var_0_1 > #var_1_2 then
		var_0_1 = #var_1_2
	end

	self.chars = {}

	for iter_1_3 = 1, var_0_1 do
		local var_1_3 = iter_1_3
		local var_1_4 = SpineAnimChar.New()

		var_1_4:SetPaint((table.remove(var_1_2, math.random(1, #var_1_2))))
		var_1_4:Load(true, function(arg_2_0)
			arg_2_0:SetAction("stand2", 0)
			arg_2_0:SetParent(self.pos)
			arg_2_0:SetLocalScale(var_0_2)

			local var_2_0 = GetComponent(findTF(self.boundContainer, tostring(var_1_3)), typeof(BoxCollider2D))
			local var_2_1 = self.pos:InverseTransformPoint(var_2_0.bounds.min)
			local var_2_2 = self.pos:InverseTransformPoint(var_2_0.bounds.max)

			arg_2_0:SetAnchoredPosition(self:getTargetPos(var_2_1, var_2_2))
			table.insert(self.chars, {
				model = arg_2_0,
				vel = Vector2(0, 0),
				bound = {
					var_2_1.x,
					var_2_1.y,
					var_2_2.x,
					var_2_2.y
				},
				min = var_2_1,
				max = var_2_2,
				pos = arg_2_0:GetAnchoredPosition(),
				curScale = arg_2_0:GetLocalScale()
			})
			table.insert(self.items, tf(arg_2_0:GetModel()))

			return
		end)
	end

	self.bataiTf = findTF(self.pos, "batai")
	self.coinChar = nil

	PoolMgr.GetInstance():GetSpineChar(var_0_3, true, function(arg_3_0)
		self.coinChar = tf(arg_3_0)

		tf(arg_3_0):GetComponent(typeof(SpineAnimUI)):SetAction("stand2", 0)
		setParent(tf(arg_3_0), findTF(self.bataiTf, "char"))
		setLocalScale(arg_3_0, var_0_2)

		return
	end)

	self.content.anchoredPosition = Vector2(0, 0)

	local var_1_5 = GetOrAddComponent(self.content, typeof(EventTriggerListener))

	self.velocityXSmoothing = Vector2(0, 0)
	self.offsetPosition = self.content.anchoredPosition

	var_1_5:AddBeginDragFunc(function(arg_4_0, arg_4_1)
		self.prevPosition = arg_4_1.position
		self.scenePosition = self.content.anchoredPosition
		self.velocityXSmoothing = Vector2(0, 0)
		self.offsetPosition = self.content.anchoredPosition

		return
	end)
	var_1_5:AddDragFunc(function(arg_5_0, arg_5_1)
		self.offsetPosition.x = arg_5_1.position.x - self.prevPosition.x + self.scenePosition.x
		self.offsetPosition.y = arg_5_1.position.y - self.prevPosition.y + self.scenePosition.y

		if self.offsetPosition.x > var_0_7[2] then
			self.offsetPosition.x = var_0_7[2] or self.offsetPosition.x
		end

		if self.offsetPosition.x < var_0_7[1] then
			self.offsetPosition.x = var_0_7[1] or self.offsetPosition.x
		end

		if self.offsetPosition.y > var_0_8[2] then
			self.offsetPosition.y = var_0_8[2] or self.offsetPosition.y
		end

		if self.offsetPosition.y < var_0_8[1] then
			self.offsetPosition.y = var_0_8[1] or self.offsetPosition.y
		end

		return
	end)
	var_1_5:AddDragEndFunc(function(arg_6_0, arg_6_1)
		return
	end)

	self.clickItems = {}

	for iter_1_4 = 1, #var_0_11 do
		local var_1_6 = findTF(self.pos, var_0_11[iter_1_4][1])
		local var_1_7 = GetComponent(findTF(self.pos, var_0_11[iter_1_4][2]), typeof(SpineAnimUI))

		table.insert(self.clickItems, {
			time = 0,
			tf = var_1_6,
			anim = var_1_7
		})
		onButton(self._event, var_1_6, function()
			if self:checkClickTime(var_1_7) then
				self:setAnimAction(var_1_7, "action", 1, "normal")
			end

			return
		end)
	end

	return
end

function GameHallContainerUI:setCharSit(arg_8_1, arg_8_2)
	if arg_8_1.sitFlag or arg_8_2.sitFlag then
		return
	end

	local var_8_0 = arg_8_1.model

	arg_8_1.model:SetLocalScale(var_0_2)
	self:setCharAction(var_8_0, "sit", 0, nil)
	self:setAnimAction(arg_8_2.anim, "sit", 0, nil)

	arg_8_1.curAction = "sit"
	arg_8_2.curAction = "sit"
	arg_8_1.target = nil
	arg_8_1.sitItem = arg_8_2
	arg_8_1.sitFlag = true
	arg_8_1.time = math.random(10, 20)
	arg_8_1.vel = Vector2(0, 0)
	arg_8_2.sitFlag = true

	arg_8_1.model:SetParent(arg_8_2.pos)
	arg_8_1.model:SetAnchoredPosition(Vector2(0, 0))

	return
end

function GameHallContainerUI:stopCharSit(arg_9_1)
	arg_9_1.sitItem.sitFlag = false

	self:setCharAction(arg_9_1.model, "walk", 0, nil)
	self:setAnimAction(arg_9_1.sitItem.anim, "normal", 0, nil)

	arg_9_1.sitItem = nil
	arg_9_1.sitFlag = false

	arg_9_1.model:SetParent(self.pos)
	arg_9_1.model:SetAnchoredPosition(arg_9_1.pos)

	return
end

function GameHallContainerUI:checkClickTime(arg_10_1)
	for iter_10_0 = 1, #self.clickItems do
		if self.clickItems[iter_10_0].anim == arg_10_1 and (self.clickItems[iter_10_0].time == 0 or Time.realtimeSinceStartup > self.clickItems[iter_10_0].time) then
			self.clickItems[iter_10_0].time = Time.realtimeSinceStartup + 2

			return true
		end
	end

	return false
end

function GameHallContainerUI:step()
	self.content.anchoredPosition, self.velocityXSmoothing = Vector2.SmoothDamp(self.content.anchoredPosition, self.offsetPosition, self.velocityXSmoothing, var_0_4)

	for iter_11_0 = 1, #self.chars do
		local var_11_0 = self.chars[iter_11_0]

		if not self.chars[iter_11_0].time or self.chars[iter_11_0].time <= 0 then
			if var_11_0.sitFlag then
				self:stopCharSit(var_11_0)
			elseif math.random(1, 10) > 5 then
				local var_11_1 = self:getTargetPos(var_11_0.min, var_11_0.max)

				var_11_0.vel, var_11_0.target = self:getVel(self.chars[iter_11_0].pos, var_11_1), var_11_1
			end

			var_11_0.time = math.random(1, var_0_6)
		end

		if var_11_0.target and not var_11_0.sitFlag then
			local var_11_2 = {
				var_11_0.vel.x * var_0_5 * Time.deltaTime,
				var_11_0.vel.y * var_0_5 * Time.deltaTime
			}

			if var_11_2[1] ~= 0 then
				var_11_0.pos.x = var_11_0.pos.x + var_11_2[1]
			end

			if var_11_2[2] ~= 0 then
				var_11_0.pos.y = var_11_0.pos.y + var_11_2[2]
			end

			local var_11_3 = var_11_0.bound

			if var_11_0.pos.x < var_11_0.bound[1] then
				var_11_0.pos.x = var_11_3[1]
				var_11_0.vel.x = 0
			end

			if var_11_0.pos.x > var_11_3[3] then
				var_11_0.pos.x = var_11_3[3]
				var_11_0.vel.x = 0
			end

			if var_11_0.pos.y < var_11_3[2] then
				var_11_0.pos.y = var_11_3[2]
				var_11_0.vel.y = 0
			end

			if var_11_0.pos.y > var_11_3[4] then
				var_11_0.pos.y = var_11_3[4]
				var_11_0.vel.y = 0
			end

			var_11_0.model:SetAnchoredPosition(var_11_0.pos)

			if math.abs(var_11_0.target.x - var_11_0.pos.x) < 10 then
				var_11_0.vel.x = 0
			end

			if math.abs(var_11_0.target.y - var_11_0.pos.y) < 10 then
				var_11_0.vel.y = 0
			end
		end

		local var_11_5 = true

		if var_11_0.vel.x == 0 and var_11_0.vel.y == 0 then
			var_11_0.time = var_11_0.time - Time.deltaTime
			var_11_5 = false
		end

		if not var_11_5 and var_11_0.target then
			var_11_0.target = nil
		end

		if not var_11_0.sitFlag and not var_11_5 then
			var_11_0.ableSit = true
		end

		if var_11_0.vel.x ~= 0 then
			if math.sign(var_11_0.curScale.x) ~= (var_11_0.vel.x > 0 and 1 or -1) then
				var_11_0.curScale.x = (var_11_0.vel.x > 0 and 1 or -1) * var_0_2.x

				var_11_0.model:SetLocalScale(var_11_0.curScale)
			end
		end

		if var_11_5 then
			if var_11_0.curAction ~= "walk" then
				var_11_0.curAction = "walk"

				var_11_0.model:SetAction("walk", 0)
			end
		elseif var_11_0.sitFlag then
			if var_11_0.curAction ~= "sit" then
				var_11_0.curAction = "sit"

				var_11_0.model:SetAction("sit", 0)
			end
		elseif var_11_0.curAction ~= "stand2" then
			var_11_0.curAction = "stand2"

			var_11_0.model:SetAction("stand2", 0)
		end

		if var_11_5 then
			self:checkCharSit(var_11_0)
		end
	end

	table.sort(self.items, function(arg_12_0, arg_12_1)
		if arg_12_0.anchoredPosition.y < arg_12_1.anchoredPosition.y then
			return true
		end

		return
	end)

	for iter_11_1, iter_11_2 in ipairs(self.items) do
		iter_11_2:SetAsFirstSibling()
	end

	return
end

function GameHallContainerUI:checkCharSit(arg_13_1)
	if not arg_13_1.ableSit then
		return
	end

	local var_13_0 = arg_13_1.pos

	for iter_13_0 = 1, #self.sitItems do
		if var_13_0.x > self.sitItems[iter_13_0].min.x and var_13_0.x < self.sitItems[iter_13_0].max.x and var_13_0.y > self.sitItems[iter_13_0].min.y and var_13_0.y < self.sitItems[iter_13_0].max.y then
			if math.random(1, 10) > 7 then
				print("角色想坐下")
				self:setCharSit(arg_13_1, self.sitItems[iter_13_0])
			else
				arg_13_1.ableSit = false

				print("角色不想坐下")
			end
		end
	end

	return
end

function GameHallContainerUI:getVel(arg_14_1, arg_14_2)
	local var_14_0 = math.atan(math.abs(arg_14_2.y - arg_14_1.y) / math.abs(arg_14_2.x - arg_14_1.x))

	return Vector2(math.cos(var_14_0) * (arg_14_2.x > arg_14_1.x and 1 or -1), math.sin(var_14_0) * (arg_14_2.y > arg_14_1.y and 1 or -1))
end

function GameHallContainerUI:setCharAction(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_1:SetActionCallBack(nil)
	arg_15_1:SetAction(arg_15_2, 0)
	arg_15_1:SetActionCallBack(function(arg_16_0)
		if arg_16_0 == "finish" and arg_15_3 == 1 then
			arg_15_1:SetActionCallBack(nil)
			arg_15_1:SetAction(arg_15_4, 0)
		end

		return
	end)

	return
end

function GameHallContainerUI:setAnimAction(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_1:SetActionCallBack(nil)
	arg_17_1:SetAction(arg_17_2, 0)
	arg_17_1:SetActionCallBack(function(arg_18_0)
		if arg_18_0 == "finish" and arg_17_3 == 1 then
			arg_17_1:SetActionCallBack(nil)
			arg_17_1:SetAction(arg_17_4, 0)
		end

		return
	end)

	return
end

function GameHallContainerUI:getTargetPos(arg_19_1, arg_19_2)
	return Vector2(arg_19_1.x + math.random(1, tonumber(arg_19_2.x) - tonumber(arg_19_1.x)), arg_19_1.y + math.random(1, tonumber(arg_19_2.y) - tonumber(arg_19_1.y)))
end

function GameHallContainerUI:isPointInMatrix(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	return self:getCross(arg_20_1, arg_20_2, arg_20_5) * self:getCross(arg_20_3, arg_20_4, arg_20_5) >= 0 and self:getCross(arg_20_2, arg_20_3, arg_20_5) * self:getCross(arg_20_4, arg_20_1, arg_20_5) >= 0
end

function GameHallContainerUI:Dispose()
	if self.coinChar then
		PoolMgr.GetInstance():ReturnSpineChar(var_0_3, go(self.coinChar))

		self.coinChar = nil
	end

	if self.chars and #self.chars > 0 then
		for iter_21_0 = 1, #self.chars do
			self.chars[iter_21_0].model:Dispose()
		end

		self.chars = nil
	end

	return
end

return GameHallContainerUI
