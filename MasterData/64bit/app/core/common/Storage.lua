local var_0_0 = {}
local var_0_1 = cc.FileUtils:getInstance()
local var_0_2 = {
	var_0_1:getWritablePath(),
	"/"
}

var_0_2[3] = "userdata"

local var_0_3 = table.concat(var_0_2)

if not var_0_1:isDirectoryExist(var_0_3) then
	var_0_1:createDirectory(var_0_3)
end

function var_0_0:save(arg_1_1, arg_1_2, arg_1_3)
	assert(type(arg_1_1) == "string" and string.len(arg_1_1) > 0, "Invalid file name: " .. tostring(arg_1_1))
	assert(type(arg_1_2) == "table", "Invalid data: " .. tostring(arg_1_2))

	local var_1_0 = json.encode(arg_1_2)

	assert(var_1_0, "Could not encode data with json format !")
	var_0_1:writeStringToFile(var_1_0, self:_getFullPath(arg_1_1, (arg_1_3 ~= nil or nil) and arg_1_3))
end

function var_0_0:load(arg_2_1, arg_2_2)
	assert(type(arg_2_1) == "string" and string.len(arg_2_1) > 0, "Invalid file name: " .. tostring(arg_2_1))

	return json.decodeFileIfExists(self:_getFullPath(arg_2_1, (arg_2_2 ~= nil or nil) and arg_2_2))
end

function var_0_0._getFullPath(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 and g.core.network then
		arg_3_1 = string.format("%d_%s", g.core.network.GameNetProxy:getUserId() or 0, arg_3_1)
	end

	return table.concat({
		table.concat({
			var_0_3,
			"/"
		}),
		arg_3_1
	})
end

function var_0_0:returnFullPath(arg_4_1, arg_4_2)
	return self:_getFullPath(arg_4_1, arg_4_2)
end

return var_0_0
