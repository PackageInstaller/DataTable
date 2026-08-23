local NewSlgS2AdditionBtn = class("NewSlgS2AdditionBtn")

function NewSlgS2AdditionBtn:ctor()
	self:setVisible(false)
	self:addClickListener(handler(self, self._onClick))
end

function NewSlgS2AdditionBtn:updateView(arg_2_1)
	self._scoreAdd = g.core.model.User.newSlgData:getScoreAddition()
	self._resAdd = g.core.model.User.newSlgData:getResAddition(arg_2_1.pid)

	self:setVisible(false)

	if self._resAdd > 0 or self._scoreAdd > 0 then
		self:setVisible(true)
	end
end

function NewSlgS2AdditionBtn:getAllAddArr()
	local var_3_0 = {}

	if self._resAdd > 0 then
		table.insert(var_3_0, {
			tp = 1,
			value = self._resAdd
		})
	end

	if self._scoreAdd > 0 then
		table.insert(var_3_0, {
			tp = 2,
			value = self._scoreAdd
		})
	end

	return var_3_0
end

function NewSlgS2AdditionBtn:_onClick()
	return
end

return NewSlgS2AdditionBtn
