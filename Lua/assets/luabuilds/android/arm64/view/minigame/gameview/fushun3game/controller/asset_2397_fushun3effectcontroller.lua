local Fushun3EffectController = class("Fushun3EffectController")

function Fushun3EffectController:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._effectTpl = arg_1_1
	self._effectPos = arg_1_2
	self._event = arg_1_3
	self._effects = {}
	self._effectPool = {}

	return
end

function Fushun3EffectController:start()
	for iter_2_0 = #self._effects, 1, -1 do
		self:returnEffectToPool(table.remove(self._effects, iter_2_0))
	end

	return
end

function Fushun3EffectController:step()
	return
end

function Fushun3EffectController:returnEffectToPool(arg_4_1)
	setActive(arg_4_1.tf, false)
	table.insert(self._effectPool, arg_4_1)

	return
end

function Fushun3EffectController:addEffectByName(arg_5_1, arg_5_2)
	if not arg_5_1 then
		return
	end

	local var_5_0 = self:getOrCreateEffect(nil, arg_5_1)

	if var_5_0 then
		self:addEffectToTarget(var_5_0, arg_5_2)
		table.insert(self._effects, var_5_0)
	end

	return
end

function Fushun3EffectController:addEffectByAnim(arg_6_1, arg_6_2)
	if not arg_6_1 then
		return
	end

	local var_6_0 = self:getOrCreateEffect(arg_6_1)

	if var_6_0 then
		self:addEffectToTarget(var_6_0, arg_6_2)
		table.insert(self._effects, var_6_0)
	end

	return
end

function Fushun3EffectController:addEffectToTarget(arg_7_1, arg_7_2)
	if arg_7_1.data.parent then
		SetParent(arg_7_1.tf, arg_7_2)

		arg_7_1.tf.localScale = arg_7_2.localScale
		arg_7_1.tf.anchoredPosition = Vector2(0, 0)

		setActive(arg_7_1.tf, true)
		table.insert(self._effects, arg_7_1)
	else
		setParent(arg_7_1.tf, self._effectPos)

		arg_7_1.tf.localScale = Fushun3GameConst.game_scale_v3
		arg_7_1.tf.position = arg_7_2.position

		setActive(arg_7_1.tf, true)
	end

	return
end

function Fushun3EffectController:getOrCreateEffect(arg_8_1, arg_8_2)
	for iter_8_0 = 1, #self._effectPool do
		if arg_8_1 and self._effectPool[iter_8_0].data.trigger == arg_8_1 or arg_8_2 and self._effectPool[iter_8_0].data.name == arg_8_2 then
			return table.remove(self._effectPool, iter_8_0)
		end
	end

	return self:instiateEffect((self:getEffectData(arg_8_1, arg_8_2)))
end

function Fushun3EffectController:instiateEffect(arg_9_1)
	if arg_9_1 then
		local var_9_0 = tf(instantiate(findTF(self._effectTpl, arg_9_1.name)))
		local var_9_1 = {
			tf = var_9_0,
			data = arg_9_1
		}

		GetOrAddComponent(findTF(var_9_0, "efAnim"), typeof(DftAniEvent)):SetEndEvent(function()
			self:removeEffect(var_9_1)

			return
		end)

		return var_9_1
	end

	return
end

function Fushun3EffectController:removeEffect(arg_11_1)
	for iter_11_0 = #self._effects, 1, -1 do
		if self._effects[iter_11_0] == arg_11_1 then
			setActive(self._effects[iter_11_0].tf, false)
			self:returnEffectToPool(table.remove(self._effects, iter_11_0))
		end
	end

	return
end

function Fushun3EffectController:getEffectData(arg_12_1, arg_12_2)
	if arg_12_1 then
		for iter_12_0 = 1, #Fushun3GameConst.effect_data do
			if Fushun3GameConst.effect_data[iter_12_0].trigger == arg_12_1 then
				return Clone(Fushun3GameConst.effect_data[iter_12_0])
			end
		end
	elseif arg_12_2 then
		for iter_12_1 = 1, #Fushun3GameConst.effect_data do
			if Fushun3GameConst.effect_data[iter_12_1].name == arg_12_2 then
				return Clone(Fushun3GameConst.effect_data[iter_12_1])
			end
		end
	end

	return
end

return Fushun3EffectController
