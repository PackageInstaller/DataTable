local CastleGameRemind = class("CastleGameRemind")

CastleGameRemind.remind_type_1 = "remind_type_1"
CastleGameRemind.remind_type_2 = "remind_type_2"
CastleGameRemind.remind_type_3 = "remind_type_3"
CastleGameRemind.remind_type_4 = "remind_type_4"

local var_0_1 = {
	{
		tpl = "remind_1",
		type = CastleGameRemind.remind_type_1
	},
	{
		tpl = "remind_2",
		type = CastleGameRemind.remind_type_2
	},
	{
		tpl = "remind_3",
		type = CastleGameRemind.remind_type_3
	},
	{
		tpl = "remind_4",
		type = CastleGameRemind.remind_type_4
	}
}

function CastleGameRemind:Ctor(arg_1_1, arg_1_2)
	self._tplContent = arg_1_1
	self._event = arg_1_2
	self.remindPool = {}
	self.reminds = {}

	return
end

function CastleGameRemind:setContent(arg_2_1)
	if not arg_2_1 then
		print("地板的容器不能为nil")

		return
	end

	self._content = arg_2_1

	return
end

function CastleGameRemind:start()
	for iter_3_0 = #self.reminds, 1, -1 do
		self:returnRemind((table.remove(self.reminds, iter_3_0)))
	end

	return
end

function CastleGameRemind:step()
	for iter_4_0 = #self.reminds, 1, -1 do
		if self.reminds[iter_4_0].removeTime and self.reminds[iter_4_0].removeTime > 0 then
			self.reminds[iter_4_0].removeTime = self.reminds[iter_4_0].removeTime - CastleGameVo.deltaTime

			if self.reminds[iter_4_0].removeTime <= 0 then
				self.reminds[iter_4_0].removeTime = nil

				self:returnRemind((table.remove(self.reminds, iter_4_0)))
			end
		end
	end

	return
end

function CastleGameRemind:addRemind(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = self:getRemindByType(arg_5_3)

	var_5_0.removeTime = CastleGameVo.item_ready_time

	setActive(var_5_0.tf, false)
	setActive(var_5_0.tf, true)

	var_5_0.tf.anchoredPosition = CastleGameVo.GetRotationPosByWH(arg_5_1, arg_5_2)

	table.insert(self.reminds, var_5_0)

	return
end

function CastleGameRemind:getRemindByType(arg_6_1)
	local var_6_0

	for iter_6_0 = 1, #self.remindPool do
		if self.remindPool[iter_6_0].type == arg_6_1 then
			var_6_0 = table.remove(self.remindPool, iter_6_0)

			return var_6_0
		end
	end

	if not var_6_0 then
		for iter_6_1 = 1, #var_0_1 do
			if arg_6_1 == var_0_1[iter_6_1].type then
				local var_6_1 = tf(instantiate(findTF(self._tplContent, var_0_1[iter_6_1].tpl)))

				setParent(var_6_1, self._content)

				return {
					tf = var_6_1,
					dft = GetComponent(findTF(var_6_1, "zPos"), typeof(DftAniEvent)),
					type = arg_6_1
				}
			end
		end
	end

	return
end

function CastleGameRemind:returnRemind(arg_7_1)
	setActive(arg_7_1.tf, false)

	arg_7_1.removeTime = nil

	table.insert(self.remindPool, arg_7_1)

	return
end

function CastleGameRemind:clear()
	return
end

return CastleGameRemind
