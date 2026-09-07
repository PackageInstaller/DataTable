local OreMinersControl = class("OreMinersControl")

function OreMinersControl:Ctor(arg_1_1, arg_1_2)
	self.binder = arg_1_1
	self._tf = arg_1_2
	self.tpl = findTF(self._tf, "tpl")

	self:Init()

	return
end

function OreMinersControl:Init()
	self.minerList = {}

	eachChild(findTF(self._tf, "pos"), function(arg_3_0)
		table.insert(self.minerList, OreMiner.New(self.binder, cloneTplTo(self.tpl, arg_3_0, arg_3_0.name), 1.5 + math.random()))

		return
	end)

	return
end

function OreMinersControl:Reset()
	for iter_4_0, iter_4_1 in ipairs(self.minerList) do
		iter_4_1:Reset()
	end

	return
end

function OreMinersControl:OnTimer(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self.minerList) do
		iter_5_1:OnTimer(arg_5_1)
	end

	return
end

return OreMinersControl
