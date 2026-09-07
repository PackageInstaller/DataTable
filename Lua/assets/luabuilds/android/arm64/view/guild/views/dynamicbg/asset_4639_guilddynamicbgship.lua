local GuildDynamicBgShip = class("GuildDynamicBgShip")

function GuildDynamicBgShip:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self._go = arg_1_1.go
	self._tf = tf(self._go)
	self.parent = self._tf.parent
	self.path = arg_1_1.path
	self.speed = 1
	self.stepCnt = 0
	self.scale = self._tf.localScale.x
	self.furnitures = arg_1_1.furnitures
	self.interAction = nil
	self.interActionRatio = 16 / GuildConst.MAX_DISPLAY_MEMBER_SHIP
	self.name = arg_1_1.name
	self.isCommander = arg_1_1.isCommander
	self.spineChar = arg_1_1.char

	self:Init(arg_1_1)

	return
end

function GuildDynamicBgShip:Init(arg_2_1)
	self:SetPosition(arg_2_1.grid, true)

	self.nameTF = self._tf:Find("name")
	self.nameTF.localScale = Vector3(1 / self.scale, 1 / self.scale, 1)
	self.nameTF.localPosition = Vector3(0, 300, 0)

	setText(self.nameTF, self.name)

	if self.isCommander then
		self.tagTF = self._tf:Find("tag")
		self.tagTF.localScale = Vector3(1 / self.scale, 1 / self.scale, 1)
		self.tagTF.localPosition = Vector3(0, 380, 0)
	end

	if not arg_2_1.stand then
		self:AddRandomMove()
	end

	return
end

function GuildDynamicBgShip:SetOnMoveCallBack(arg_3_1)
	self.callback = arg_3_1

	return
end

function GuildDynamicBgShip:SetPosition(arg_4_1, arg_4_2)
	if self.exited then
		return
	end

	if self.grid then
		self.grid:UnlockAll()
	end

	self.grid = arg_4_1

	if arg_4_2 then
		self._tf.localPosition = self.grid:GetCenterPosition()

		self:SetAction("stand2")
	end

	if self.callback then
		self.callback()
	end

	return
end

function GuildDynamicBgShip:AddRandomMove()
	self.stepCnt = math.random(1, 10)
	self.timer = Timer.New(function()
		self.timer:Stop()

		self.timer = nil

		self:StartMove()

		return
	end, math.random(1, 8), 1)

	self.timer:Start()

	return
end

function GuildDynamicBgShip:IsCanWalkPonit(arg_7_1)
	if not self.path[arg_7_1.x] then
		return false
	end

	if self.path[arg_7_1.x][arg_7_1.y] then
		return self.path[arg_7_1.x][arg_7_1.y]:CanWalk()
	else
		return false
	end

	return
end

function GuildDynamicBgShip:GetMoveDir(arg_8_1)
	if arg_8_1.position.x < self.grid.position.x then
		return -1
	elseif arg_8_1.position.x > self.grid.position.x then
		return 1
	end

	return self._tf.localScale.x < 0 and -1 or 1
end

function GuildDynamicBgShip:StartMove()
	local var_9_0 = _.select(self.grid:GetAroundGrids(), function(arg_10_0)
		return self:IsCanWalkPonit(arg_10_0)
	end)

	if not var_9_0 or #var_9_0 == 0 then
		self:AddRandomMove()
	else
		self.stepCnt = self.stepCnt - 1

		local var_9_1 = var_9_0[math.random(1, #var_9_0)]

		self:UpdateShipDir((self:GetMoveDir(self.path[var_9_1.x][var_9_1.y])))
		self:MoveToGrid(self.path[var_9_1.x][var_9_1.y])
	end

	return
end

function GuildDynamicBgShip:MoveToGrid(arg_11_1)
	local function var_11_0()
		self:SetAction("stand2")

		self.idleTimer = Timer.New(function()
			self.idleTimer:Stop()

			self.idleTimer = nil

			self:AddRandomMove()

			return
		end, math.random(3, 8), 1)

		self.idleTimer:Start()

		return
	end

	self:MoveNext(arg_11_1, false, function()
		if self.stepCnt ~= 0 then
			self:StartMove()

			return
		end

		local var_14_0, var_14_1 = self:CanInterAction(self.interActionRatio)

		if var_14_0 then
			self:MoveToFurniture(var_14_1)
		else
			var_11_0()
		end

		return
	end)

	return
end

function GuildDynamicBgShip:MoveNext(arg_15_1, arg_15_2, arg_15_3)
	if not arg_15_2 and not arg_15_1:CanWalk() then
		return
	end

	if self.exited then
		return
	end

	arg_15_1:Lock()
	self:SetAction("walk")
	self:UpdateShipDir((self:GetMoveDir(arg_15_1)))

	local var_15_0 = arg_15_1:GetCenterPosition()

	LeanTween.moveLocal(self._go, Vector3(var_15_0.x, var_15_0.y, 0), 1 / self.speed):setOnComplete(System.Action(function()
		if self.exited then
			return
		end

		self:SetPosition(arg_15_1)
		arg_15_3()

		return
	end))

	return
end

function GuildDynamicBgShip:MoveLeft()
	local var_17_0 = Vector2(self.grid.position.x - 1, self.grid.position.y)
	local var_17_1 = self.path[var_17_0.x] and self.path[var_17_0.x][var_17_0.y]

	if var_17_1 then
		self:MoveNext(var_17_1, false, function()
			self:SetAction("stand2")

			return
		end)
	end

	return
end

function GuildDynamicBgShip:MoveRight()
	local var_19_0 = Vector2(self.grid.position.x + 1, self.grid.position.y)
	local var_19_1 = self.path[var_19_0.x] and self.path[var_19_0.x][var_19_0.y]

	if var_19_1 then
		self:MoveNext(var_19_1, false, function()
			self:SetAction("stand2")

			return
		end)
	end

	return
end

function GuildDynamicBgShip:MoveDown()
	local var_21_0 = Vector2(self.grid.position.x, self.grid.position.y - 1)
	local var_21_1 = self.path[var_21_0.x] and self.path[var_21_0.x][var_21_0.y]

	if var_21_1 then
		self:MoveNext(var_21_1, false, function()
			self:SetAction("stand2")

			return
		end)
	end

	return
end

function GuildDynamicBgShip:MoveUp()
	local var_23_0 = Vector2(self.grid.position.x, self.grid.position.y + 1)
	local var_23_1 = self.path[var_23_0.x] and self.path[var_23_0.x][var_23_0.y]

	if var_23_1 then
		self:MoveNext(var_23_1, false, function()
			self:SetAction("stand2")

			return
		end)
	end

	return
end

function GuildDynamicBgShip:SetAction(arg_25_1)
	if self.actionName == arg_25_1 then
		return
	end

	self.actionName = arg_25_1

	self.spineChar:SetAction(arg_25_1, 0)
	self:NorDirByFather()

	return
end

function GuildDynamicBgShip:SetAsLastSibling()
	self._tf:SetAsLastSibling()

	return
end

function GuildDynamicBgShip:MoveToFurniture(arg_27_1)
	local var_27_0 = arg_27_1[1]

	arg_27_1[1]:Lock()

	for iter_27_0, iter_27_1 in ipairs(arg_27_1[2]) do
		self.path[iter_27_1.x][iter_27_1.y]:Lock()
	end

	self:MoveByPath(arg_27_1[2], function()
		self:InterActionFurniture(var_27_0)

		return
	end)

	return
end

function GuildDynamicBgShip:UpdateNameAndTagDir(arg_29_1)
	if self.nameTF then
		self.nameTF.localScale = Vector3(1 / self.scale * arg_29_1, 1 / self.scale, 1)
	end

	if self.isCommander and self.tagTF then
		self.tagTF.localScale = Vector3(1 / self.scale * arg_29_1, 1 / self.scale, 1)
	end

	return
end

function GuildDynamicBgShip:UpdateShipDir(arg_30_1)
	self._tf.localScale = Vector3(arg_30_1 * self.scale, self.scale, self.scale)

	self:UpdateNameAndTagDir(arg_30_1)

	return
end

function GuildDynamicBgShip:NorDirByFather()
	self:UpdateNameAndTagDir(self._tf.localScale.x < 0 and -1 or 1)

	return
end

function GuildDynamicBgShip:InterActionFurniture(arg_32_1)
	setParent(self._tf, arg_32_1._tf)

	local var_32_0 = arg_32_1:GetInteractionDir()

	self:UpdateShipDir(var_32_0)

	self._tf.anchoredPosition = arg_32_1:GetInterActionPos()

	local var_32_1

	if GuildDynamicFurniture.INTERACTION_MODE_SIT == arg_32_1:GetInterActionMode() then
		var_32_1 = "sit"
	end

	assert(var_32_1)
	self:SetAction(var_32_1)
	self:UpdateShipDir(var_32_0)
	self:CancelInterAction(arg_32_1)

	return
end

function GuildDynamicBgShip:CancelInterAction(arg_33_1)
	self.interActionTimer = Timer.New(function()
		self.interActionTimer:Stop()

		self.interActionTimer = nil

		arg_33_1:Unlock()
		setParent(self._tf, self.parent)
		assert(self.grid)
		self:SetPosition(self.grid, true)
		self:NorDirByFather()
		self:AddRandomMove()

		return
	end, math.random(15, 30), 1)

	self.interActionTimer:Start()

	return
end

function GuildDynamicBgShip:MoveByPath(arg_35_1, arg_35_2)
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
		table.insert(var_35_0, function(arg_36_0)
			if self.exited then
				return
			end

			self:MoveNext(self.path[iter_35_1.x][iter_35_1.y], true, arg_36_0)

			return
		end)
	end

	seriesAsync(var_35_0, arg_35_2)

	return
end

function GuildDynamicBgShip:SearchPoint(arg_37_1, arg_37_2)
	local function var_37_0(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
		if _.any(arg_38_0, function(arg_39_0)
			return arg_38_2 == arg_39_0.point
		end) or _.any(arg_38_1, function(arg_40_0)
			return arg_38_2 == arg_40_0
		end) then
			return false
		end

		if self.path[arg_38_2.x] then
			return self.path[arg_38_2.x][arg_38_2.y] and self.path[arg_38_2.x][arg_38_2.y]:CanWalk()
		end

		return false
	end

	local function var_37_1(arg_41_0)
		local var_41_0 = {}

		table.insert(var_41_0, Vector2(arg_41_0.x + 1, arg_41_0.y))
		table.insert(var_41_0, Vector2(arg_41_0.x - 1, arg_41_0.y))
		table.insert(var_41_0, Vector2(arg_41_0.x, arg_41_0.y + 1))
		table.insert(var_41_0, Vector2(arg_41_0.x, arg_41_0.y - 1))

		return var_41_0
	end

	local function var_37_2(arg_42_0, arg_42_1, arg_42_2)
		return math.abs(arg_42_2.x - arg_42_0.x) + math.abs(arg_42_2.y - arg_42_0.y) < math.abs(arg_42_2.x - arg_42_1.x) + math.abs(arg_42_2.y - arg_42_1.y)
	end

	local var_37_3 = {}
	local var_37_4 = {}
	local var_37_5 = {}
	local var_37_6

	table.insert(var_37_3, {
		parent = 0,
		point = arg_37_1
	})

	while #var_37_3 > 0 do
		local var_37_7 = table.remove(var_37_3, 1)

		if var_37_7.point == arg_37_2 then
			var_37_6 = var_37_7

			break
		end

		table.insert(var_37_4, var_37_7.point)

		for iter_37_0, iter_37_1 in ipairs(var_37_1(var_37_7.point)) do
			if var_37_0(var_37_3, var_37_4, iter_37_1, arg_37_2) then
				table.insert(var_37_3, {
					point = iter_37_1,
					parent = var_37_7
				})
			else
				if iter_37_1 == arg_37_2 then
					var_37_6 = var_37_7

					break
				end

				table.insert(var_37_4, iter_37_1)
			end
		end

		table.sort(var_37_3, function(arg_43_0, arg_43_1)
			return var_37_2(arg_43_0.point, arg_43_1.point, arg_37_2)
		end)
	end

	if var_37_6 then
		while var_37_6.parent ~= 0 do
			table.insert(var_37_5, 1, var_37_6.point)

			var_37_6 = var_37_6.parent
		end
	end

	return var_37_5
end

function GuildDynamicBgShip:CanInterAction(arg_44_1)
	if arg_44_1 < math.random(1, 10000) then
		return false
	end

	local var_44_0 = {}

	for iter_44_0, iter_44_1 in ipairs(self.furnitures) do
		if not iter_44_1:BeLock() then
			table.insert(var_44_0, iter_44_1)
		end
	end

	if #var_44_0 == 0 then
		return false
	end

	local var_44_1 = var_44_0[math.random(1, #var_44_0)]
	local var_44_2

	for iter_44_2, iter_44_3 in ipairs((var_44_1:GetOccupyGrid())) do
		if math.abs(self.grid.position.x - iter_44_3.position.x) + math.abs(self.grid.position.y - iter_44_3.position.y) < 999999 then
			var_44_2 = iter_44_3.position
		end
	end

	local var_44_5 = self:SearchPoint(self.grid.position, var_44_2)

	if not var_44_5 or #var_44_5 == 0 then
		return false
	end

	return true, {
		var_44_1,
		var_44_5
	}
end

function GuildDynamicBgShip:Dispose()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.idleTimer then
		self.idleTimer:Stop()

		self.idleTimer = nil
	end

	if self.interActionTimer then
		self.interActionTimer:Stop()

		self.interActionTimer = nil
	end

	if not IsNil(self._go) and LeanTween.isTweening(self._go) then
		LeanTween.cancel(self._go)
	end

	if self.spineChar then
		self.spineChar:Dispose()

		self.spineChar = nil
	end

	Destroy(self.nameTF)

	if self.isCommander then
		Destroy(self.tagTF)
	end

	self.actionName = nil

	self:SetOnMoveCallBack()

	self.exited = true

	return
end

return GuildDynamicBgShip
