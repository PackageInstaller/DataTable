local BaseReactor = class("BaseReactor")

function BaseReactor:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.responder = arg_1_3
	self._tf = arg_1_2
	self.callDic = {}
	self.rangeDic = {}

	self:Init(arg_1_1)
	self.responder:CreateCall(self)

	return
end

function BaseReactor:Init(arg_2_1)
	return
end

function BaseReactor:Register(arg_3_1, arg_3_2, arg_3_3)
	assert(arg_3_3)

	self.callDic[arg_3_1] = arg_3_2
	self.rangeDic[arg_3_1] = underscore.map(arg_3_3, function(arg_4_0)
		return NewPos(unpack(arg_4_0))
	end)

	self.responder:AddListener(arg_3_1, self, self.rangeDic[arg_3_1])

	return
end

function BaseReactor:Deregister(arg_5_1)
	self.responder:RemoveListener(arg_5_1, self, self.rangeDic[arg_5_1])

	self.callDic[arg_5_1] = nil
	self.rangeDic[arg_5_1] = nil

	return
end

function BaseReactor:DeregisterAll()
	for iter_6_0, iter_6_1 in pairs(self.callDic) do
		self:Deregister(iter_6_0)
	end

	return
end

function BaseReactor:Calling(arg_7_1, arg_7_2, arg_7_3)
	self.responder:EventCall(arg_7_1, arg_7_2, self, arg_7_3)

	return
end

function BaseReactor:React(arg_8_1, arg_8_2)
	if not self.callDic[arg_8_1] then
		return
	end

	self.callDic[arg_8_1](unpack(arg_8_2))

	return
end

function BaseReactor:Destroy(arg_9_1)
	self:DeregisterAll()
	self.responder:DestroyCall(self, defaultValue(arg_9_1, true) and RyzaMiniGameConfig.GetDestroyPoint(self) or 0)

	self.responder = nil
	self.callDic = nil
	self.rangeDic = nil

	Destroy(self._tf)

	return
end

return BaseReactor
