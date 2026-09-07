local OreContainerControl = class("OreContainerControl")

OreContainerControl.BREAK_MOVE_TIME = 0.5

function OreContainerControl:Ctor(arg_1_1, arg_1_2)
	self.binder = arg_1_1
	self._tf = arg_1_2

	self:Init()

	return
end

function OreContainerControl:Init()
	self:AddListener()

	self.deliverSpeed = 50
	self.mainTF = self._tf:Find("Container_1/break")

	return
end

function OreContainerControl:AddListener()
	self.binder:bind(OreGameConfig.EVENT_DELIVER, function(arg_4_0, arg_4_1)
		self:PlayDeliverAnim(arg_4_1.status, arg_4_1.pos, arg_4_1.oreTF)

		return
	end)
	self.binder:bind(OreGameConfig.EVENT_PLAY_CONTAINER_HIT, function(arg_5_0, arg_5_1)
		self:PlayHitAnim(arg_5_1.status, arg_5_1.pos, arg_5_1.hitPos, arg_5_1.oreTF)

		return
	end)

	return
end

OreContainerControl.DeliveOffsetY = {
	-7,
	-7,
	-16
}

function OreContainerControl:PlayDeliverAnim(arg_6_1, arg_6_2, arg_6_3)
	self.mainTF = self._tf:Find("Container_" .. arg_6_1 .. "/deliver")

	setAnchoredPosition(self.mainTF, {
		x = arg_6_2.x,
		y = arg_6_2.y + OreContainerControl.DeliveOffsetY[arg_6_1]
	})
	setActive(self.mainTF, true)

	local var_6_0 = self.mainTF:Find("ore/pos")

	removeAllChildren(var_6_0)
	cloneTplTo(arg_6_3, var_6_0)
	self.mainTF:Find("BK/Image"):GetComponent(typeof(Animator)):Play("Deliver_2_Lift_BK")
	self.mainTF:Find("FR/Image"):GetComponent(typeof(Animator)):Play("Deliver_2_Lift_FR")

	self.deliverTime = 0

	return
end

OreContainerControl.moveRata = {
	1,
	1.2,
	1.5
}

function OreContainerControl:PlayHitAnim(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_1 == OreAkashiControl.STATUS_NULL then
		return
	end

	self.mainTF = self._tf:Find("Container_" .. arg_7_1 .. "/break")

	setAnchoredPosition(self.mainTF, arg_7_2)
	setActive(self.mainTF, true)

	local var_7_0 = self.mainTF.parent:Find("ore/pos")

	removeAllChildren(var_7_0)

	self.orePosList = {}
	self.oreTFs = cloneTplTo(arg_7_4, var_7_0):Find("oreTF")
	self.hitPos = {
		x = -arg_7_3.x * OreContainerControl.moveRata[arg_7_1],
		y = -arg_7_3.y * OreContainerControl.moveRata[arg_7_1]
	}

	setAnchoredPosition(var_7_0, Vector2(arg_7_2.x + self.hitPos.x, arg_7_2.y + self.hitPos.y))
	self.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play("Break")

	self.breakTime = 0

	eachChild(self.oreTFs, function(arg_8_0)
		self.orePosList[arg_8_0.name] = {
			x = math.random(50) - 25,
			y = math.random(50) - 25
		}

		return
	end)

	return
end

function OreContainerControl:Reset()
	self.deliverTime = nil
	self.breakTime = nil
	self.oreTFs = nil

	setActive(self.mainTF, false)
	setActive(self.mainTF.parent:Find("ore/pos"), false)
	removeAllChildren(self.mainTF.parent:Find("ore/pos"))
	setAnchoredPosition(self.mainTF, Vector2(0, 0))

	return
end

function OreContainerControl:OnTimer(arg_10_1)
	if self.deliverTime then
		setAnchoredPosition(self.mainTF, {
			x = self.mainTF.anchoredPosition.x,
			y = self.mainTF.anchoredPosition.y - arg_10_1 * self.deliverSpeed
		})

		self.deliverTime = self.deliverTime + arg_10_1

		if self.mainTF.anchoredPosition.y < -230 then
			removeAllChildren(self.mainTF:Find("ore/pos"))
			self:Reset()
		end
	end

	if self.breakTime then
		setAnchoredPosition(self.mainTF, {
			x = self.mainTF.anchoredPosition.x + self.hitPos.x * arg_10_1 / OreContainerControl.BREAK_MOVE_TIME,
			y = self.mainTF.anchoredPosition.y + self.hitPos.y * arg_10_1 / OreContainerControl.BREAK_MOVE_TIME
		})

		self.breakTime = self.breakTime + arg_10_1

		if self.breakTime >= OreContainerControl.BREAK_MOVE_TIME / 3 then
			if not isActive(self.mainTF.parent:Find("ore/pos")) then
				setActive(self.mainTF.parent:Find("ore/pos"), true)
			end

			eachChild(self.oreTFs, function(arg_11_0)
				setAnchoredPosition(arg_11_0, {
					x = arg_11_0.anchoredPosition.x + self.orePosList[arg_11_0.name].x * arg_10_1 / (OreContainerControl.BREAK_MOVE_TIME * 2 / 3),
					y = arg_11_0.anchoredPosition.y + self.orePosList[arg_11_0.name].y * arg_10_1 / (OreContainerControl.BREAK_MOVE_TIME * 2 / 3)
				})

				return
			end)
		end

		if self.breakTime >= OreContainerControl.BREAK_MOVE_TIME then
			self:Reset()
		end
	end

	return
end

return OreContainerControl
