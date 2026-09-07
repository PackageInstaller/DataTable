local BoatAdChar = class("BoatAdChar")
local var_0_1
local var_0_2
local var_0_3 = 0.5

function BoatAdChar:Ctor(arg_1_1, arg_1_2)
	var_0_1 = BoatAdGameVo
	var_0_2 = BoatAdGameConst
	self._tf = arg_1_1
	self._eventCallback = arg_1_2
	self._collider = GetComponent(findTF(self._tf, "bound"), typeof(BoxCollider2D))
	self.imgTf = findTF(self._tf, "img")
	self._charSpineAnim = GetComponent(findTF(self.imgTf, "char"), typeof(SpineAnimUI))
	self._yanwuTf = findTF(self.imgTf, "yanwu")
	self._yanwuAnimUI = GetComponent(self._yanwuTf, typeof(SpineAnimUI))
	self._hpTf = findTF(self._tf, "hp")

	setActive(self._tf, false)

	self._playerAnimator = GetComponent(self._tf, typeof(Animator))
	self.battleEffectTf = findTF(self._tf, "battleEffect")
	self.battleEffectSpine1 = GetComponent(findTF(self.battleEffectTf, "spine1"), typeof(SpineAnimUI))
	self.battleEffectSpine2 = GetComponent(findTF(self.battleEffectTf, "spine2"), typeof(SpineAnimUI))
	self.guardTf = findTF(self._tf, "guard")

	return
end

function BoatAdChar:setData(arg_2_1)
	self._data = arg_2_1
	self._baseSpeed = self:getConfig("speed")
	self._baseHp = self:getConfig("hp")

	return
end

function BoatAdChar:setContent(arg_3_1)
	self._content = arg_3_1

	SetParent(self._tf, arg_3_1)

	return
end

function BoatAdChar:changeDirect(arg_4_1, arg_4_2)
	self._directX = arg_4_1
	self._directY = arg_4_2
	self.imgTf.localEulerAngles = self._battleHp > 0 and Vector3(0, 0, 0) or self._directX < 0 and Vector3(0, 0, 3) or self._directX > 0 and Vector3(0, 0, -3) or Vector3(0, 0, 0)

	return
end

function BoatAdChar:getWorld()
	return self._tf.position
end

function BoatAdChar:start()
	self._directX = 0
	self._directY = 0

	setActive(self._tf, true)

	self._tf.anchoredPosition = self:getConfig("start_pos")
	self._speed = Vector2(0, 0)
	self._speed.x = self._baseSpeed.x
	self._speed.y = self._baseSpeed.y
	self._hp = self._baseHp
	self._timeForDead = nil
	self._battleHp = 0
	self.colliderLine = 0
	self.guardTime = 0
	self.stopFlag = false

	self:updateCharMoveCount()
	self:updateUI()
	self:updateChange(false)

	self.stepSound = 0

	return
end

function BoatAdChar:step(arg_7_1)
	self.stepSound = self.stepSound - arg_7_1

	if self._battleHp > 0 then
		local var_7_1

		if self._battleHp > self._battleSubHp then
			var_7_1 = self._battleSubHp or self._battleHp
		end

		self._battleHp = self._battleHp - var_7_1

		self:subHp(var_7_1)

		if self._hp <= 0 then
			self._hp = 0
			self._battleHp = 0
		end

		self:updateUI()

		if self.stepSound <= 0 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1.SFX_SOUND_BATTLE)

			self.stepSound = var_0_3
		end
	end

	if self:getLife() and self._battleHp == 0 then
		local var_7_3 = self:getNextPosition(self._directX, self._directY)

		if math.abs(var_7_3.x) > var_0_2.player_width / 2 + 50 or math.abs(var_7_3.y) > var_0_2.player_height / 2 + 50 then
			-- block empty
		else
			self._tf.anchoredPosition = var_7_3

			self:updateCharMoveCount()
		end
	end

	if self.guardTime and self.guardTime > 0 and self._battleHp <= 0 then
		self.guardTime = self.guardTime - arg_7_1

		if self.guardTime <= 0 then
			self.guardTime = 0

			self:updateGuard()
		end
	end

	if self:getLife() and self._battleHp <= 0 and self._changeIndex ~= self:getCharChange() then
		self:updateChange(true)
	end

	return
end

function BoatAdChar:getGuard()
	return self.guardTime > 0
end

function BoatAdChar:addGuard(arg_9_1)
	self.guardTime = arg_9_1

	self:updateGuard()

	return
end

function BoatAdChar:subHp(arg_10_1)
	if not self:getGuard() then
		self._hp = self._hp - arg_10_1
	end

	if self._hp < 0 then
		self._hp = 0
	end

	self:updateUI()

	return
end

function BoatAdChar:updateGuard()
	if not self.stopFlag then
		setActive(self.guardTf, self.guardTime > 0)
	end

	return
end

function BoatAdChar:updateChange(arg_12_1)
	self._changeIndex = self:getCharChange()

	if arg_12_1 then
		setActive(self._yanwuTf, true)
		self:setAnimation(self._yanwuAnimUI, "normal", function()
			setActive(self._yanwuTf, false)

			return
		end)
		self:setAnimation(self._charSpineAnim, "normal" .. self._changeIndex)
	else
		setActive(self._yanwuTf, false)
		self:setAnimation(self._charSpineAnim, "normal" .. self._changeIndex)
	end

	return
end

function BoatAdChar:getCharChange()
	local var_14_0 = 1

	for iter_14_0 = 1, #BoatAdGameConst.char_change_hp do
		if self._hp >= BoatAdGameConst.char_change_hp[iter_14_0] then
			var_14_0 = iter_14_0 + 1
		end
	end

	return var_14_0
end

function BoatAdChar:setAnimation(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
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

function BoatAdChar:updateUI()
	if self._battleHp > 0 and not isActive(self.battleEffectTf) then
		setActive(self.battleEffectTf, true)
		self:setAnimation(self.battleEffectSpine1, "normal")
		self:setAnimation(self.battleEffectSpine2, "normal")
	elseif self._battleHp <= 0 and isActive(self.battleEffectTf) then
		setActive(self.battleEffectTf, false)
	end

	setText(self._hpTf, self._hp)
	self:updateGuard()

	return
end

function BoatAdChar:updateCharMoveCount()
	local var_18_0
	local var_18_1

	for iter_18_0, iter_18_1 in ipairs(BoatAdGameConst.move_line_width) do
		if not var_18_1 then
			var_18_1 = math.abs(self._tf.anchoredPosition.x - iter_18_1)
			var_18_0 = iter_18_0
		elseif var_18_1 > math.abs(self._tf.anchoredPosition.x - iter_18_1) then
			var_18_1 = math.abs(self._tf.anchoredPosition.x - iter_18_1)
			var_18_0 = iter_18_0
		end
	end

	if self.moveCount ~= var_18_0 then
		print("设置角色moveCount" .. var_18_0)
	end

	self.moveCount = var_18_0

	return
end

function BoatAdChar:setLine(arg_19_1)
	self.colliderLine = arg_19_1

	return
end

function BoatAdChar:getLine()
	return self.colliderLine
end

function BoatAdChar:getMoveCount()
	return self.moveCount
end

function BoatAdChar:battle(arg_22_1, arg_22_2)
	self._battleHp = arg_22_1
	self._battleBoss = arg_22_2

	if arg_22_2 then
		self._battleSubHp = var_0_2.battle_sub_hp_boss or var_0_2.battle_sub_hp
	end

	return
end

function BoatAdChar:getBattle()
	return self._battleHp > 0
end

function BoatAdChar:getHpPos()
	return self._hpTf.position
end

function BoatAdChar:getNextPosition(arg_25_1, arg_25_2)
	local var_25_0 = 0

	if arg_25_1 ~= 0 then
		var_25_0 = self._speed.x * arg_25_1 * var_0_1.deltaTime
	end

	local var_25_1 = 0

	if arg_25_2 ~= 0 then
		var_25_1 = self._speed.y * arg_25_2 * var_0_1.deltaTime
	end

	local var_25_2 = self._tf.anchoredPosition

	if var_25_0 ~= 0 or var_25_1 ~= 0 then
		var_25_2.x = var_25_2.x + var_25_0
		var_25_2.y = var_25_2.y + var_25_1

		return var_25_2
	end

	return var_25_2
end

function BoatAdChar:getTf()
	return self._tf
end

function BoatAdChar:getHp()
	return self._hp
end

function BoatAdChar:getColliderData()
	local var_28_0 = self._content:InverseTransformPoint(self._collider.bounds.min)

	if not self._boundData then
		local var_28_1 = self._content:InverseTransformPoint(self._collider.bounds.max)

		self._boundData = {
			width = math.floor(var_28_1.x - var_28_0.x),
			height = math.floor(var_28_1.y - var_28_0.y)
		}
	end

	return var_28_0, self._boundData
end

function BoatAdChar:flash()
	self._playerAnimator:SetTrigger("flash")

	return
end

function BoatAdChar:changeHp(arg_30_1, arg_30_2)
	if arg_30_1 ~= 0 then
		local var_30_0 = self._hp

		if arg_30_2 == BoatAdGameConst.hp_type_sub then
			var_30_0 = self._hp + arg_30_1
		elseif arg_30_2 == BoatAdGameConst.hp_type_mul then
			var_30_0 = self._hp * arg_30_1
		elseif arg_30_2 == BoatAdGameConst.hp_type_div then
			var_30_0 = self._hp / arg_30_1
		end

		local var_30_1 = math.floor(var_30_0)

		if var_30_1 < self._hp then
			self:flash()
		end

		self._hp = self:getGuard() and var_30_1 <= self._hp and self._hp or var_30_1

		self:updateUI()

		if self._changeIndex ~= self:getCharChange() then
			self:updateChange(true)
		end
	end

	return
end

function BoatAdChar:getWorldColliderData()
	self._worldBoundData = self._worldBoundData or {
		width = self._collider.bounds.max.x - self._collider.bounds.min.x,
		height = self._collider.bounds.max.y - self._collider.bounds.min.y
	}

	return self._collider.bounds.min, self._worldBoundData
end

function BoatAdChar:getLife()
	return self._hp > 0
end

function BoatAdChar:getColliderMinPosition()
	self._minPosition = self._minPosition or self._tf:InverseTransformPoint(self._collider.bounds.min)

	return self._minPosition
end

function BoatAdChar:getBoundData()
	local var_34_0 = self._content:InverseTransformPoint(self._collider.bounds.min)

	if not self._boundData then
		local var_34_1 = self._content:InverseTransformPoint(self._collider.bounds.max)

		self._boundData = {
			width = math.floor(var_34_1.x - var_34_0.x),
			height = math.floor(var_34_1.y - var_34_0.y)
		}
	end

	return self._boundData
end

function BoatAdChar:getPosition()
	return self._tf.anchoredPosition
end

function BoatAdChar:getGroup()
	return self:getConfig("group")
end

function BoatAdChar:clear()
	self._battleHp = 0

	self:updateUI()

	return
end

function BoatAdChar:stop()
	self.stopFlag = true

	setActive(self.guardTf, false)

	return
end

function BoatAdChar:resume()
	self.stopFlag = false

	self:updateGuard()

	return
end

function BoatAdChar:getMinMaxPosition()
	return self._collider.bounds.min, self._collider.bounds.max
end

function BoatAdChar:getConfig(arg_41_1)
	return self._data[arg_41_1]
end

function BoatAdChar:checkPositionInRange(arg_42_1)
	if math.abs(self._tf.anchoredPosition.x - arg_42_1.x) < self:getConfig("range") and math.abs(self._tf.anchoredPosition.y - arg_42_1.y) < self:getConfig("range") then
		return true
	end

	return false
end

function BoatAdChar:dispose()
	return
end

return BoatAdChar
