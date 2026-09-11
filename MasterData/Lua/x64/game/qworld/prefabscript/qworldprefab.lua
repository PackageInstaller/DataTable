local QWorldPrefab = class("QWorldPrefab")

function QWorldPrefab:Ctor(arg_1_1, arg_1_2)
	self.name = arg_1_1 or ""
	self.fn = arg_1_2
end

return QWorldPrefab
