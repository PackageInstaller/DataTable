ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleBuffEvent
local var_0_2 = ys.Battle.BattleUnitEvent
local var_0_4 = ys.Battle.BattleDataFunction

ys.Battle.BattleEffectComponent = class("BattleEffectComponent")
ys.Battle.BattleEffectComponent.__name = "BattleEffectComponent"

function ys.Battle.BattleEffectComponent.Ctor(arg_1_0, arg_1_1)
	var_0_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._owner = arg_1_1
	arg_1_0._blinkIDList = {}
	arg_1_0._buffLastEffects = {}
	arg_1_0._currentLastFXID = nil
	arg_1_0._effectIndex = 0
	arg_1_0._effectList = {}

	return
end

function ys.Battle.BattleEffectComponent:SwitchOwner(arg_2_1, arg_2_2)
	self._owner = arg_2_1

	for iter_2_0, iter_2_1 in pairs(self._blinkIDList) do
		if arg_2_2[iter_2_1] then
			self._blinkIDList[iter_2_0] = arg_2_2[iter_2_1]
		end
	end

	return
end

function ys.Battle.BattleEffectComponent:ClearEffect()
	for iter_3_0, iter_3_1 in pairs(self._blinkIDList) do
		self._owner:RemoveBlink(iter_3_1)
	end

	self._blinkIDList = {}

	return
end

function ys.Battle.BattleEffectComponent:Dispose()
	for iter_4_0, iter_4_1 in pairs(self._blinkIDList) do
		self._owner:RemoveBlink(iter_4_1)
	end

	self._effectList = nil
	self._buffLastEffects = nil

	var_0_0.EventListener.DetachEventListener(self)

	return
end

function ys.Battle.BattleEffectComponent.GetFXPool(arg_5_0)
	return var_0_0.Battle.BattleFXPool.GetInstance()
end

function ys.Battle.BattleEffectComponent:SetUnitDataEvent(arg_6_1)
	arg_6_1:RegisterEventListener(self, var_0_1.BUFF_CAST, self.onBuffCast)
	arg_6_1:RegisterEventListener(self, var_0_1.BUFF_ATTACH, self.onBuffAdd)
	arg_6_1:RegisterEventListener(self, var_0_1.BUFF_STACK, self.onBuffStack)
	arg_6_1:RegisterEventListener(self, var_0_1.BUFF_REMOVE, self.onBuffRemove)
	arg_6_1:RegisterEventListener(self, var_0_2.ADD_EFFECT, self.onAddEffect)
	arg_6_1:RegisterEventListener(self, var_0_2.CANCEL_EFFECT, self.onCancelEffect)
	arg_6_1:RegisterEventListener(self, var_0_2.DEACTIVE_EFFECT, self.onDeactiveEffect)

	return
end

function ys.Battle.BattleEffectComponent.RemoveUnitEvent(arg_7_0, arg_7_1)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_1.BUFF_ATTACH)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_1.BUFF_CAST)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_1.BUFF_STACK)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_1.BUFF_REMOVE)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_2.ADD_EFFECT)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_2.CANCEL_EFFECT)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_2.DEACTIVE_EFFECT)

	return
end

function ys.Battle.BattleEffectComponent:Update(arg_8_1)
	self._dir = self._owner:GetUnitData():GetDirection()

	for iter_8_0, iter_8_1 in pairs(self._effectList) do
		iter_8_1.currentTime = arg_8_1 - iter_8_1.startTime

		self:updateEffect(iter_8_1)
	end

	return
end

function ys.Battle.BattleEffectComponent:onAddEffect(arg_9_1)
	self:addEffect(arg_9_1.Data)

	return
end

function ys.Battle.BattleEffectComponent:onCancelEffect(arg_10_1)
	self:cancelEffect(arg_10_1.Data)

	return
end

function ys.Battle.BattleEffectComponent:onDeactiveEffect(arg_11_1)
	self:deactiveEffect(arg_11_1.Data)

	return
end

function ys.Battle.BattleEffectComponent:onBuffAdd(arg_12_1)
	self:DoWhenAddBuff(arg_12_1)

	return
end

function ys.Battle.BattleEffectComponent:onBuffCast(arg_13_1)
	self:addBlink(arg_13_1.Data.buff_id)

	return
end

function ys.Battle.BattleEffectComponent:DoWhenAddBuff(arg_14_1)
	self:addInitFX(arg_14_1.Data.buff_id)
	self:addLastFX(arg_14_1.Data.buff_id)
	self:updateLastFXStackText(arg_14_1.Data.buff_id)

	return
end

function ys.Battle.BattleEffectComponent:onBuffStack(arg_15_1)
	self:DoWhenStackBuff(arg_15_1)

	return
end

function ys.Battle.BattleEffectComponent:DoWhenStackBuff(arg_16_1)
	self:addInitFX(arg_16_1.Data.buff_id)

	local var_16_0 = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_16_1.Data.buff_id)

	if var_16_0.last_effect_stack_list and self:checkLastFXID(arg_16_1.Data.buff_id, arg_16_1.Data.stack_count) ~= self._currentLastFXID then
		self:switchLastFX(arg_16_1.Data.buff_id, arg_16_1.Data.stack_count)
	end

	if var_16_0.last_effect ~= "" and var_16_0.last_effect_stack then
		if #self._buffLastEffects[arg_16_1.Data.buff_id] < arg_16_1.Data.stack_count then
			self:addLastFX(arg_16_1.Data.buff_id)
		elseif arg_16_1.Data.stack_count < #self._buffLastEffects[arg_16_1.Data.buff_id] then
			while #self._buffLastEffects[arg_16_1.Data.buff_id] - arg_16_1.Data.stack_count > 0 do
				self:removeLastFX(arg_16_1.Data.buff_id)
			end
		end
	end

	self:updateLastFXStackText(arg_16_1.Data.buff_id)

	return
end

function ys.Battle.BattleEffectComponent:onBuffRemove(arg_17_1)
	if self._buffLastEffects[arg_17_1.Data.buff_id] then
		local var_17_0 = #self._buffLastEffects[arg_17_1.Data.buff_id]

		while var_17_0 > 0 do
			self:removeLastFX(arg_17_1.Data.buff_id)

			var_17_0 = var_17_0 - 1
		end
	end

	if self._blinkIDList[arg_17_1.Data.buff_id] then
		self._owner:RemoveBlink(self._blinkIDList[arg_17_1.Data.buff_id])

		self._blinkIDList[arg_17_1.Data.buff_id] = nil
	end

	return
end

function ys.Battle.BattleEffectComponent:addInitFX(arg_18_1)
	local var_18_0 = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_18_1)

	if var_18_0.init_effect and var_18_0.init_effect ~= "" then
		local var_18_1 = var_18_0.init_effect

		if var_18_0.skin_adapt then
			var_18_1 = var_0_4.SkinAdaptFXID(var_18_1, self._owner:GetUnitData():GetSkinID())
		end

		self._owner:AddFX(var_18_1)
	end

	return
end

function ys.Battle.BattleEffectComponent:removeLastFX(arg_19_1)
	if self._buffLastEffects[arg_19_1] ~= nil and #self._buffLastEffects[arg_19_1] > 0 then
		self._owner:RemoveFX((table.remove(self._buffLastEffects[arg_19_1])))
	end

	return
end

function ys.Battle.BattleEffectComponent:switchLastFX(arg_20_1, arg_20_2)
	local var_20_0 = self:checkLastFXID(arg_20_1, arg_20_2)

	if self._currentLastFXID then
		self:removeLastFX(arg_20_1)
	end

	if var_20_0 then
		local var_20_1 = self._buffLastEffects[arg_20_1] or {}

		table.insert(var_20_1, (self:generateLastFX(var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_20_1), var_20_0)))

		self._buffLastEffects[arg_20_1] = var_20_1
	end

	return
end

function ys.Battle.BattleEffectComponent.checkLastFXID(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0

	for iter_21_0, iter_21_1 in pairs(var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_21_1).last_effect_stack_list) do
		if iter_21_0 <= arg_21_2 then
			var_21_0 = iter_21_1
		end
	end

	return var_21_0
end

function ys.Battle.BattleEffectComponent:addLastFX(arg_22_1)
	local var_22_0 = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_22_1)

	if var_22_0.last_effect ~= nil and var_22_0.last_effect ~= "" then
		local var_22_1 = self._buffLastEffects[arg_22_1] or {}

		table.insert(var_22_1, (self:generateLastFX(var_22_0, var_22_0.last_effect)))

		self._buffLastEffects[arg_22_1] = var_22_1
	end

	return
end

function ys.Battle.BattleEffectComponent:updateLastFXStackText(arg_23_1)
	local var_23_0 = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_23_1).last_effect_stack_text

	if type(var_23_0) ~= "table" then
		return
	end

	local var_23_1 = var_23_0.node

	if type(var_23_0.node) ~= "string" or var_23_1 == "" then
		return
	end

	local var_23_2 = self._owner:GetUnitData():GetBuff(arg_23_1)

	if not var_23_2 then
		return
	end

	local var_23_3 = "X" .. (var_23_2:GetStack() or 1)

	if not self._buffLastEffects[arg_23_1] then
		return
	end

	for iter_23_0, iter_23_1 in ipairs(self._buffLastEffects[arg_23_1]) do
		if iter_23_1 then
			local var_23_4 = iter_23_1.transform:Find(var_23_1)

			if var_23_4 then
				setText(var_23_4, var_23_3)
			end
		end
	end

	return
end

function ys.Battle.BattleEffectComponent:generateLastFX(arg_24_1, arg_24_2)
	self._currentLastFXID = arg_24_2

	local var_24_0 = self._owner:AddFX(arg_24_2)

	if arg_24_1.last_effect_cld_scale or arg_24_1.last_effect_cld_angle then
		local var_24_1

		for iter_24_0, iter_24_1 in ipairs(arg_24_1[buffLv] or arg_24_1.effect_list) do
			if iter_24_1.arg_list.cld_data then
				var_24_1 = iter_24_1

				break
			end
		end

		if var_24_1 then
			if arg_24_1.last_effect_cld_scale then
				local var_24_2 = var_24_0.transform.localScale

				if var_24_1.arg_list.cld_data.box.range then
					var_24_2.x = var_24_2.x * var_24_1.arg_list.cld_data.box.range
					var_24_2.y = var_24_2.y * var_24_1.arg_list.cld_data.box.range
					var_24_2.z = var_24_2.z * var_24_1.arg_list.cld_data.box.range
				else
					var_24_2.x = var_24_2.x * var_24_1.arg_list.cld_data.box[1]
					var_24_2.y = var_24_2.y * var_24_1.arg_list.cld_data.box[2]
					var_24_2.z = var_24_2.z * var_24_1.arg_list.cld_data.box[3]
				end

				var_24_0.transform.localScale = var_24_2
			end

			if arg_24_1.last_effect_cld_angle then
				var_24_0.transform:Find("scale/sector"):GetComponent(typeof(Renderer)).material:SetInt("_AngleControl", (360 - var_24_1.arg_list.cld_data.angle) * 0.5 - 5)
			end

			if arg_24_1.last_effect_bound_bone then
				local var_24_3 = self._owner:GetBoneList()[arg_24_1.last_effect_bound_bone]

				if var_24_3 then
					var_24_0.transform.localPosition = var_24_3[1]
				end
			end
		end
	end

	var_24_0:SetActive(true)

	return var_24_0
end

function ys.Battle.BattleEffectComponent:addBlink(arg_25_1)
	local var_25_0 = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_25_1)

	if var_25_0.blink then
		self._blinkIDList[arg_25_1] = self._owner:AddBlink(var_25_0.blink[1], var_25_0.blink[2], var_25_0.blink[3], var_25_0.blink[4], var_25_0.blink[5])
	end

	return
end

function ys.Battle.BattleEffectComponent:addEffect(arg_26_1)
	local var_26_0 = arg_26_1.index or self:getIndex()
	local var_26_1 = self._effectList[var_26_0]

	if self._effectList[var_26_0] then
		var_26_1.effect_go:SetActive(true)

		var_26_1.effect_tf.localScale = var_26_1.effect_tf.localScale
	else
		local var_26_2 = self._owner:AddFX(arg_26_1.effect)

		if not var_26_2 then
			return
		end

		local var_26_3 = {
			currentTime = 0,
			effect_go = var_26_2,
			effect_tf = var_26_2.transform,
			posFun = arg_26_1.posFun,
			rotationFun = arg_26_1.rotationFun
		}

		var_26_3.startTime = pg.TimeMgr.GetInstance():GetCombatTime()
		var_26_3.fillFunc = arg_26_1.fillFunc
		self._effectList[var_26_0] = var_26_3

		self:updateEffect(var_26_3)
		pg.EffectMgr.GetInstance():PlayBattleEffect(var_26_2, var_26_2.transform.localPosition, false, function(arg_27_0)
			self._owner:RemoveFX(var_26_2)

			self._effectList[var_26_0] = nil

			return
		end)
	end

	return
end

function ys.Battle.BattleEffectComponent:cancelEffect(arg_28_1)
	if self._effectList[arg_28_1.index] then
		self._owner:RemoveFX(self._effectList[arg_28_1.index].effect_go)

		self._effectList[arg_28_1.index] = nil
	end

	return
end

function ys.Battle.BattleEffectComponent:deactiveEffect(arg_29_1)
	if self._effectList[arg_29_1.index] then
		self._effectList[arg_29_1.index].effect_go:SetActive(false)
	end

	return
end

function ys.Battle.BattleEffectComponent:getIndex()
	self._effectIndex = self._effectIndex + 1

	return self._effectIndex
end

function ys.Battle.BattleEffectComponent:updateEffect(arg_31_1)
	if arg_31_1.posFun then
		arg_31_1.effect_tf.localPosition = arg_31_1.posFun(arg_31_1.currentTime)
	end

	if arg_31_1.rotationFun then
		local var_31_0 = arg_31_1.rotationFun(arg_31_1.currentTime)

		if self._dir == var_0_0.Battle.BattleConst.UnitDir.LEFT then
			var_31_0.y = var_31_0.y - 180
		end

		arg_31_1.effect_tf.localEulerAngles = var_31_0
	end

	if arg_31_1.fillFunc then
		self._characterScaleX = self._characterScaleX or self._owner:GetTf().localScale.x
		self._characterScaleZ = self._characterScaleZ or self._owner:GetTf().localScale.z

		local var_31_1, var_31_2, var_31_3 = arg_31_1.fillFunc()

		arg_31_1.effect_tf.position = var_31_1
		arg_31_1.effect_tf.localScale = Vector3(var_31_2 / self._characterScaleX, 0, var_31_3 / self._characterScaleZ)
	end

	return
end

return
