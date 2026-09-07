local RectKeyInfo = class("RectKeyInfo")

function RectKeyInfo:Ctor()
	self._inPutKeyDic = {}

	return
end

function RectKeyInfo:setKeyPress(arg_2_1, arg_2_2)
	self:getKeyData(arg_2_1).status = arg_2_2

	self:setKeyData(arg_2_1, arg_2_2)

	if self._triggerCallback then
		self._triggerCallback(arg_2_1, arg_2_2)
	end

	return
end

function RectKeyInfo:setTriggerCallback(arg_3_1)
	self._triggerCallback = arg_3_1

	return
end

function RectKeyInfo:setKeyData(arg_4_1, arg_4_2)
	for iter_4_0 = 1, #self._inPutKeyDic do
		if self._inPutKeyDic[iter_4_0].code == arg_4_1 then
			self._inPutKeyDic[iter_4_0].status = arg_4_2
		end
	end

	return
end

function RectKeyInfo:getKeyData(arg_5_1)
	if not arg_5_1 then
		return
	end

	local var_5_0

	for iter_5_0 = 1, #self._inPutKeyDic do
		if self._inPutKeyDic[iter_5_0].code == arg_5_1 then
			var_5_0 = self._inPutKeyDic[iter_5_0]
		end
	end

	if not var_5_0 then
		var_5_0 = {
			status = false,
			code = arg_5_1
		}

		table.insert(self._inPutKeyDic, var_5_0)
	end

	return var_5_0
end

function RectKeyInfo:getKeyCode(arg_6_1)
	if not arg_6_1 then
		return nil
	end

	local var_6_0

	for iter_6_0 = 1, #self._inPutKeyDic do
		if self._inPutKeyDic[iter_6_0].code == arg_6_1 then
			var_6_0 = self._inPutKeyDic[iter_6_0]
		end
	end

	if not var_6_0 then
		var_6_0 = {
			status = false,
			code = arg_6_1
		}

		table.insert(self._inPutKeyDic, var_6_0)
	end

	return var_6_0.status
end

return RectKeyInfo
