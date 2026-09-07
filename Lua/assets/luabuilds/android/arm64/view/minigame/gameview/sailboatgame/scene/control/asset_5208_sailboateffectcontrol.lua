local SailBoatEffectControl = class("SailBoatEffectControl")
local var_0_1

function SailBoatEffectControl:Ctor(arg_1_1, arg_1_2)
	var_0_1 = SailBoatGameVo
	self._tf = arg_1_1
	self._event = arg_1_2
	self._content = findTF(self._tf, "scene_front/content")
	self._effects = {}
	self._effectPool = {}

	return
end

function SailBoatEffectControl:start()
	for iter_2_0 = #self._effects, 1, -1 do
		local var_2_0 = table.remove(self._effects, iter_2_0)

		setActive(var_2_0.tf, false)
		table.insert(self._effectPool, var_2_0)
	end

	return
end

function SailBoatEffectControl:step(arg_3_1)
	return
end

function SailBoatEffectControl:getEffect(arg_4_1)
	if #self._effectPool > 0 then
		for iter_4_0 = 1, #self._effectPool do
			if #self._effectPool[iter_4_0].name == arg_4_1 then
				return (table.remove(self._effectPool, iter_4_0))
			end
		end
	end

	local var_4_0 = var_0_1.GetGameEffectTf(arg_4_1)
	local var_4_1 = {
		tf = var_4_0,
		name = arg_4_1
	}

	GetComponent(findTF(var_4_0, "img"), typeof(DftAniEvent)):SetEndEvent(function()
		self:effectEnd(var_4_1)

		return
	end)

	return var_4_1
end

function SailBoatEffectControl:onEventCall(arg_6_1, arg_6_2)
	if arg_6_1 == SailBoatGameEvent.CREATE_EFFECT then
		self:createEffect(arg_6_2.effect, arg_6_2.direct, arg_6_2.position, arg_6_2.content)
	end

	return
end

function SailBoatEffectControl:createEffect(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = self:getEffect(arg_7_1)

	if arg_7_2 then
		var_7_0.tf.localScale = arg_7_2
	end

	if arg_7_3 then
		var_7_0.tf.anchoredPosition = arg_7_3
	end

	if arg_7_4 then
		SetParent(var_7_0.tf, arg_7_4)
	else
		SetParent(var_7_0.tf, self._content)
	end

	setActive(var_7_0.tf, true)
	table.insert(self._effects, var_7_0)

	return
end

function SailBoatEffectControl:effectEnd(arg_8_1)
	for iter_8_0 = 1, #self._effects do
		if self._effects[iter_8_0] == arg_8_1 then
			local var_8_0 = table.remove(self._effects, iter_8_0)

			setActive(var_8_0.tf, false)
			table.insert(self._effectPool, var_8_0)

			return
		end
	end

	return
end

function SailBoatEffectControl:dispose()
	return
end

function SailBoatEffectControl:clear()
	return
end

return SailBoatEffectControl
