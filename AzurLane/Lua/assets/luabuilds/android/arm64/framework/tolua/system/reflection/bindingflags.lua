System = var_0_10000

if var_0_10000.Reflection == nil then
	System = var_0
	var_0.Reflection = {}
end

local function var_0_0(...)
	local var_1_0 = {
		...
	}
	local var_1_1 = 0

	for iter_1_0 = 1, #var_1_0 do
		var_1_1 = var_1_1 + var_1_0[iter_1_0]
	end

	return var_1_1
end

local var_0_1 = {
	Default = 0,
	SetField = 2048,
	GetField = 1024,
	Instance = 4,
	GetProperty = 4096,
	SuppressChangeType = 131072,
	NonPublic = 32,
	PutRefDispProperty = 32768,
	Static = 8,
	IgnoreReturn = 16777216,
	OptionalParamBinding = 262144,
	FlattenHierarchy = 64,
	ExactBinding = 65536,
	Public = 16,
	InvokeMethod = 256,
	SetProperty = 8192,
	DeclaredOnly = 2,
	CreateInstance = 512,
	PutDispProperty = 16384,
	IgnoreCase = 1
}

System = var_0_10002

local var_0_2 = var_0_10002.Reflection

var_0_2.BindingFlags = var_0_1
System = var_0_2
var_0_2.Reflection.BindingFlags.GetMask = var_0_0

return var_0_1
