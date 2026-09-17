NETANALYSIS = {
	package = 0,
	size = 0,
	time = 0
}

local var_0_0
local var_0_1 = false
local var_0_2

local function var_0_3()
	local var_1_0 = io.open("src/netanalysis.json", "r")

	if var_1_0 then
		var_1_0:close()

		return (var_1_0:read("*a"))
	else
		return nil
	end
end

local function var_0_4()
	var_0_2 = io.open("src/netanalysis.json", "w+")

	var_0_2:write((json.encode({
		time = NETANALYSIS.time,
		package = NETANALYSIS.package,
		size = NETANALYSIS.size
	})))
	var_0_2:flush()
	var_0_2:close()
end

function NETANALYSIS.init()
	var_0_0 = os.time()

	local var_2_0 = var_0_3()

	if var_2_0 then
		local var_2_1 = json.decode(var_2_0)

		NETANALYSIS.time = var_2_1.time
		NETANALYSIS.package = var_2_1.package
		NETANALYSIS.size = var_2_1.size
	end
end

function NETANALYSIS.add(arg_4_0)
	if var_0_1 then
		return
	end

	local var_4_0 = os.time()

	NETANALYSIS.time = NETANALYSIS.time + var_4_0 - var_0_0
	NETANALYSIS.package = NETANALYSIS.package + 1
	NETANALYSIS.size = NETANALYSIS.size + arg_4_0
	var_0_0 = var_4_0

	var_0_4()
end

function NETANALYSIS.stop()
	var_0_1 = true
end
