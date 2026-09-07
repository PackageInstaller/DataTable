ys = ys or {}

local SeqCenter = class("SeqCenter")

ys.SeqCenter = SeqCenter
SeqCenter._list = nil
SeqCenter._destroyed = false

function SeqCenter:Ctor(arg_1_1)
	self._list = ys.LinkList.New()

	return
end

function SeqCenter:NewSeq(arg_2_1)
	return ys.Sequence.New(arg_2_1, self)
end

function SeqCenter:AddSeq(arg_3_1)
	self._list:AddLast(arg_3_1)

	return
end

function SeqCenter:Update()
	if self._destroyed then
		return
	end

	local var_4_0 = self._list.Head

	while var_4_0 ~= nil do
		var_4_0.Data:Update()

		if self._destroyed then
			return
		end

		if var_4_0.Data:IsFinish() then
			var_4_0 = var_4_0.Next

			self._list:Remove(var_4_0)
		else
			var_4_0 = var_4_0.Next
		end
	end

	return
end

function SeqCenter:Dispose()
	for iter_5_0 = 1, self._list.Count do
		self._list.Head.Data.Dispose()
	end

	self._list = nil
	self._destroyed = true

	return
end

function SeqCenter:IsFinish()
	if self._list == nil then
		return true
	end

	local var_6_0 = self._list.Head

	for iter_6_0 = 1, self._list.Count do
		if not var_6_0.Data:IsFinish() then
			return false
		end

		var_6_0 = var_6_0.Next
	end

	return true
end

return
