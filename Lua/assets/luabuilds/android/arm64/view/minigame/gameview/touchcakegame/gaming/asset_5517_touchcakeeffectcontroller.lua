local TouchCakeEffectController = class("TouchCakeEffectController")
local var_0_1
local var_0_2 = 6

function TouchCakeEffectController:Ctor(arg_1_1, arg_1_2)
	var_0_1 = TouchCakeGameVo
	self._content = arg_1_1
	self._event = arg_1_2
	self._boomTf = var_0_1.GetTplItemFromPool("BoomTpl", self._content)
	self._boomSpineAnims = {}

	for iter_1_0 = 1, var_0_2 do
		table.insert(self._boomSpineAnims, GetComponent(findTF(self._boomTf, "spine_" .. iter_1_0), typeof(SpineAnimUI)))
	end

	return
end

function TouchCakeEffectController:start()
	setActive(self._boomTf, false)

	self._boomTime = 0
	self._delayBoomTime = 0

	return
end

function TouchCakeEffectController:step()
	local var_3_1

	self._delayBoomTime, var_3_1 = self:countDelta(self._delayBoomTime)

	if var_3_1 then
		setActive(self._boomTf, true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1.SFX_COUNT_CLICK3)

		for iter_3_0, iter_3_1 in ipairs(self._boomSpineAnims) do
			self:setAnimation(iter_3_1, "action", nil, "normal")
		end
	end

	local var_3_3

	self._boomTime, var_3_3 = self:countDelta(self._boomTime)

	if var_3_3 then
		self._boomTime = 0

		for iter_3_2, iter_3_3 in ipairs(self._boomSpineAnims) do
			self:setAnimation(iter_3_3, "action_end", function()
				if isActive(self._boomTf) then
					setActive(self._boomTf, false)
				end

				return
			end)
		end
	end

	return
end

function TouchCakeEffectController:countDelta(arg_5_1)
	if arg_5_1 and arg_5_1 > 0 then
		arg_5_1 = arg_5_1 - var_0_1.deltaTime

		if arg_5_1 <= 0 then
			arg_5_1 = 0

			return 0, true
		end
	end

	return arg_5_1, false
end

function TouchCakeEffectController:stop()
	if isActive(self._boomTf) then
		for iter_6_0, iter_6_1 in ipairs(self._boomSpineAnims) do
			iter_6_1:Pause()
		end
	end

	return
end

function TouchCakeEffectController:resume()
	if isActive(self._boomTf) then
		for iter_7_0, iter_7_1 in ipairs(self._boomSpineAnims) do
			iter_7_1:Resume()
		end
	end

	return
end

function TouchCakeEffectController:clear()
	return
end

function TouchCakeEffectController:showBoom(arg_9_1, arg_9_2)
	self._delayBoomTime = arg_9_2
	self._boomTime = arg_9_1

	return
end

function TouchCakeEffectController:setAnimation(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_1:SetActionCallBack(nil)
	arg_10_1:SetAction(arg_10_2, 0)
	arg_10_1:SetActionCallBack(function(arg_11_0)
		if arg_11_0 == "finish" then
			if arg_10_4 then
				arg_10_1:SetAction(arg_10_4, 0)
			end

			arg_10_1:SetActionCallBack(nil)

			if arg_10_3 then
				arg_10_3()
			end
		end

		return
	end)

	return
end

function TouchCakeEffectController:dispose()
	return
end

return TouchCakeEffectController
