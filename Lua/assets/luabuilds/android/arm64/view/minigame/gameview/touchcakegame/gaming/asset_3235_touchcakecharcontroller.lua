local TouchCakeCharController = class("TouchCakeCharController")
local var_0_1
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = {
	315,
	-315
}

function TouchCakeCharController:Ctor(arg_1_1, arg_1_2)
	var_0_1 = TouchCakeGameVo
	self._content = arg_1_1
	self._event = arg_1_2
	self._char = findTF(self._content, "char")
	self._charAnimUI = GetComponent(self._char, typeof(SpineAnimUI))
	self._guardEffectTf = findTF(self._char, "dangaota_wudihudun")
	self._effectDizziTf = findTF(self._char, "dangaota_xuanyun")

	return
end

function TouchCakeCharController:start()
	self.actionAble = true
	self.freezeTime = -1
	self.direct = -1
	self.guardTime = -1

	self:clearActionDelay()
	self:setAnimation(self._charAnimUI, (self:getCharAnimName(var_0_3, self.direct)))
	setActive(self._guardEffectTf, false)
	setActive(self._effectDizziTf, false)

	return
end

function TouchCakeCharController:step()
	self:applyActionDelay()

	local var_3_1

	self.freezeTime, var_3_1 = self:countDelta(self.freezeTime)

	if var_3_1 then
		self:addActionDelay(var_0_3, function()
			return
		end, function()
			return
		end, 0)
		setActive(self._effectDizziTf, false)
	end

	local var_3_3

	self.guardTime, var_3_3 = self:countDelta(self.guardTime)

	if var_3_3 then
		setActive(self._guardEffectTf, false)
	end

	return
end

function TouchCakeCharController:stop()
	if isActive(self._char) then
		self._charAnimUI:Pause()
	end

	return
end

function TouchCakeCharController:resume()
	if isActive(self._char) then
		self._charAnimUI:Resume()
	end

	return
end

function TouchCakeCharController:applyActionDelay()
	if self.actionDelay then
		local var_8_0 = self.actionDelay

		if not self.actionDelay.start then
			self.actionDelay.start = true

			self:setAnimation(self._charAnimUI, self.actionDelay.action, function()
				if not var_8_0.finish then
					var_8_0.finishCall()

					var_8_0.finish = true
				end

				return
			end, function()
				if var_8_0.actionCall then
					var_8_0.actionCall()
				end

				return
			end)
		end

		if self.actionDelay.time and self.actionDelay.time >= 0 then
			local var_8_2

			var_8_0.time, var_8_2 = self:countDelta(self.actionDelay.time)

			if var_8_2 and not self.actionDelay.finish then
				self.actionDelay.finishCall()

				self.actionDelay.finish = true
			end
		end
	end

	if self.actionDelay and self.actionDelay.finish then
		self.actionDelay = nil
	end

	if not self.actionDelay and #self.actionDelays > 0 then
		self.actionDelay = table.remove(self.actionDelays, 1)

		self:applyActionDelay()
	end

	return
end

function TouchCakeCharController:countDelta(arg_11_1)
	if arg_11_1 and arg_11_1 >= 0 then
		arg_11_1 = arg_11_1 - var_0_1.deltaTime

		if arg_11_1 <= 0 then
			arg_11_1 = -1

			return -1, true
		end
	end

	return arg_11_1, false
end

function TouchCakeCharController:getCharAnimName(arg_12_1, arg_12_2)
	if arg_12_1 == var_0_2 then
		var_12_0 = arg_12_2 == 1 and "left" or "right"

		return "move_" .. var_12_0
	elseif arg_12_1 == var_0_3 then
		return "stand_" .. var_12_0
	elseif arg_12_1 == var_0_4 then
		return "wield_" .. var_12_0
	elseif arg_12_1 == var_0_5 then
		return "yun_" .. var_12_0
	end

	warning("不存在的角色动画类型 =" .. tostring(arg_12_1))

	return "move_" .. var_12_0
end

function TouchCakeCharController:setAnimation(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_1:SetActionCallBack(nil)
	arg_13_1:SetAction(arg_13_2, 0)
	arg_13_1:SetActionCallBack(function(arg_14_0)
		if arg_14_0 == "action" and arg_13_4 then
			arg_13_4()
		end

		if arg_14_0 == "finish" then
			arg_13_1:SetActionCallBack(nil)

			if arg_13_3 then
				arg_13_3()
			end
		end

		return
	end)

	return
end

function TouchCakeCharController:onTouchLeft()
	if not self:getTouchAble() then
		return
	end

	self.actionAble = false

	self:touchAction(-1)

	return
end

function TouchCakeCharController:onTouchRight()
	if not self:getTouchAble() then
		return
	end

	self.actionAble = false

	self:touchAction(1)

	return
end

function TouchCakeCharController:touchAction(arg_17_1)
	if self.direct ~= arg_17_1 then
		self.direct = arg_17_1

		self:hideEffect()
		self:addActionDelay(var_0_2, function()
			self:showEffect()
			self._event(TouchCakeScene.EVENT_ACTION_WIELD, self.direct, function()
				return
			end)

			return
		end, function()
			self:setAnimation(self._charAnimUI, (self:getCharAnimName(var_0_3, self.direct)))

			return
		end)
	else
		self:addActionDelay(var_0_4, function()
			self._event(TouchCakeScene.EVENT_ACTION_WIELD, self.direct, function()
				return
			end)

			return
		end, function()
			self:setAnimation(self._charAnimUI, (self:getCharAnimName(var_0_3, self.direct)))

			return
		end)
	end

	return
end

function TouchCakeCharController:addActionDelay(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	table.insert(self.actionDelays, {
		action = self:getCharAnimName(arg_24_1, self.direct),
		time = arg_24_4,
		actionCall = arg_24_2,
		finishCall = arg_24_3
	})

	return
end

function TouchCakeCharController:hideEffect()
	setActive(self._guardEffectTf, false)
	setActive(self._effectDizziTf, false)

	return
end

function TouchCakeCharController:showEffect()
	if self.freezeTime > 0 then
		setActive(self._effectDizziTf, true)

		local var_26_0 = self._effectDizziTf.anchoredPosition

		if self.direct == -1 then
			var_26_0.x = var_0_6[1] or var_0_6[2]
		end

		self._effectDizziTf.anchoredPosition = var_26_0
	end

	if self.guardTime > 0 then
		setActive(self._guardEffectTf, true)

		local var_26_1 = self._guardEffectTf.anchoredPosition

		if self.direct == -1 then
			var_26_1.x = var_0_6[1] or var_0_6[2]
		end

		self._guardEffectTf.anchoredPosition = var_26_1
	end

	return
end

function TouchCakeCharController:guard(arg_27_1)
	self.guardTime = arg_27_1

	self:showEffect()

	return
end

function TouchCakeCharController:getGuard()
	return self.guardTime and self.guardTime > 0
end

function TouchCakeCharController:dizzi(arg_29_1)
	if self.guardTime and self.guardTime > 0 then
		return false
	end

	self:clearActionDelay()

	self.freezeTime = arg_29_1

	self:showEffect()
	self:addActionDelay(var_0_5, function()
		return
	end, function()
		return
	end)

	return true
end

function TouchCakeCharController:getDirect()
	return self.direct
end

function TouchCakeCharController:clearActionDelay()
	self.actionDelay = nil
	self.actionDelays = {}

	return
end

function TouchCakeCharController:getTouchAble()
	if self.actionDelay then
		return false
	end

	if self.freezeTime > 0 then
		return false
	end

	return true
end

function TouchCakeCharController:clear()
	return
end

function TouchCakeCharController:dispose()
	return
end

return TouchCakeCharController
