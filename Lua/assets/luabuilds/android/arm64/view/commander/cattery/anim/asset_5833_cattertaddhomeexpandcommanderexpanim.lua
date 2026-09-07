local CattertAddHomeExpAndCommanderExpAnim = class("CattertAddHomeExpAndCommanderExpAnim", import(".CatteryAddHomeExpAnim"))

function CattertAddHomeExpAndCommanderExpAnim:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.expSlider = findTF(self._tf, "home/slider"):GetComponent(typeof(Slider))
	self.levelTxt = findTF(self._tf, "home/level"):GetComponent(typeof(Text))
	self.expTxt = findTF(self._tf, "home/exp"):GetComponent(typeof(Text))
	self.addition = findTF(self._tf, "home/addition")
	self.additionExpTxt = self.addition:Find("Text"):GetComponent(typeof(Text))
	self.uilist = UIItemList.New(findTF(self._tf, "commanders"), findTF(self._tf, "commanders/tpl"))
	self.cards = {}

	self.uilist:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			self:UpdateCommander(arg_2_2, self.displays[arg_2_1 + 1])
		end

		return
	end)

	self.animRiseH = self.addition.localPosition.y

	setActive(self._tf, false)

	return
end

function CattertAddHomeExpAndCommanderExpAnim:RefreshAward()
	return
end

function CattertAddHomeExpAndCommanderExpAnim:Action(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	self.commanderExps = arg_4_1

	parallelAsync({
		function(arg_5_0)
			CattertAddHomeExpAndCommanderExpAnim.super.Action(self, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_5_0)

			return
		end,
		function(arg_6_0)
			self:InitCommanders()
			self:DoCommandersAnim(arg_6_0)

			return
		end
	}, arg_4_5)

	return
end

function CattertAddHomeExpAndCommanderExpAnim:HideOrShowAddition(arg_7_1)
	setActive(self.addition, arg_7_1 > 0)

	return
end

function CattertAddHomeExpAndCommanderExpAnim:GetAwardOffset()
	return 473
end

function CattertAddHomeExpAndCommanderExpAnim:InitCommanders()
	self.displays = {}

	for iter_9_0, iter_9_1 in pairs((getProxy(CommanderProxy):GetCommanderHome():GetCatteries())) do
		table.insert(self.displays, iter_9_1)
	end

	table.sort(self.displays, function(arg_10_0, arg_10_1)
		return arg_10_0:GetCommanderId() > arg_10_1:GetCommanderId()
	end)
	self.uilist:align(#self.displays)

	return
end

function CattertAddHomeExpAndCommanderExpAnim:DoCommandersAnim(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(self.cards) do
		table.insert(var_11_0, function(arg_12_0)
			iter_11_1:Action(arg_12_0)

			return
		end)
	end

	parallelAsync(var_11_0, arg_11_1)

	return
end

function CattertAddHomeExpAndCommanderExpAnim:UpdateCommander(arg_13_1, arg_13_2)
	local var_13_0 = self.cards[arg_13_1]

	if not self.cards[arg_13_1] then
		var_13_0 = CatteryAnimCard.New(arg_13_1)
		self.cards[arg_13_1] = var_13_0
	end

	local var_13_2 = _.detect(self.commanderExps, function(arg_14_0)
		return arg_14_0.id == arg_13_2.id
	end)

	var_13_0:Update(arg_13_2, (var_13_2 or nil) and var_13_2.value)

	return
end

function CattertAddHomeExpAndCommanderExpAnim:Clear()
	CattertAddHomeExpAndCommanderExpAnim.super.Clear(self)

	for iter_15_0, iter_15_1 in pairs(self.cards) do
		iter_15_1:Clear()
	end

	return
end

function CattertAddHomeExpAndCommanderExpAnim:Dispose()
	CattertAddHomeExpAndCommanderExpAnim.super.Dispose(self)

	for iter_16_0, iter_16_1 in pairs(self.cards) do
		iter_16_1:Dispose()
	end

	self.cards = nil

	return
end

return CattertAddHomeExpAndCommanderExpAnim
