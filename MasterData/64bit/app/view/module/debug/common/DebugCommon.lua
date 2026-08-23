local var_0_0 = {
	getExtensions = function(self)
		return self:match(".+%.(%w+)$")
	end
}

function var_0_0.getPaths(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = arg_2_1 or {}

	for iter_2_0 in lfs.dir(arg_2_0) do
		if iter_2_0 ~= "." and iter_2_0 ~= ".." then
			local var_2_1 = arg_2_0 .. "/" .. iter_2_0

			if lfs.attributes(arg_2_0 .. "/" .. iter_2_0).mode == "directory" then
				var_0_0.getPaths(var_2_1, var_2_0, arg_2_2, arg_2_3, arg_2_4)
			elseif var_0_0.getExtensions(var_2_1) == arg_2_2 then
				local var_2_2 = ""
				local var_2_3

				if arg_2_4 then
					var_2_2 = arg_2_4
				else
					var_2_2 = lfs.currentdir() .. "/res/common/"
					var_2_3 = var_2_1
				end

				local var_2_4 = string.sub(var_2_1, string.len(var_2_2) + 1)
				local var_2_5 = string.sub(var_2_4, string.find(var_2_4, "/") + 1)

				if string.find(var_2_4, "battle") then
					var_2_5 = string.sub(var_2_5, string.find(var_2_5, "/") + 1)
				end

				if not string.find(var_2_5, "_bg") then
					if arg_2_3 then
						var_2_5 = string.split(var_2_5, "/")[1]
						var_2_5 = string.split(var_2_5, ".")[1]
					end

					table.insert(var_2_0, var_2_5)
				end
			end
		end
	end

	return var_2_0
end

function var_0_0.getPathsWithExt(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = lfs.currentdir()
	local var_3_1 = not arg_3_3 and var_3_0 .. "/res_en/common/" or var_3_0 .. "/res/common/"

	return (var_0_0.getPaths(var_3_1 .. arg_3_0, {}, arg_3_1, arg_3_2, var_3_1))
end

function var_0_0.getSrcPathsWithExt(arg_4_0, arg_4_1, arg_4_2)
	return (var_0_0.getScrPaths(lfs.currentdir() .. "/src/app/view/" .. arg_4_0, {}, arg_4_1, arg_4_2))
end

function var_0_0.getScrPaths(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_1 or {}

	for iter_5_0 in lfs.dir(arg_5_0) do
		if iter_5_0 ~= "." and iter_5_0 ~= ".." then
			if lfs.attributes(arg_5_0 .. "/" .. iter_5_0).mode == "directory" then
				var_0_0.getScrPaths(arg_5_0 .. "/" .. iter_5_0, var_5_0, arg_5_2, arg_5_3)
			elseif var_0_0.getExtensions(arg_5_0 .. "/" .. iter_5_0) == arg_5_2 then
				local var_5_1 = string.sub(arg_5_0 .. "/" .. iter_5_0, string.len(lfs.currentdir() .. "/src/app/view/") + 1)
				local var_5_2 = string.sub(var_5_1, string.find(var_5_1, "/") + 1)

				if arg_5_3 then
					local var_5_3 = string.split(var_5_2, "/")

					var_5_2 = var_5_3[#var_5_3]
					var_5_2 = string.split(var_5_3[#var_5_3], ".")[1]
				end

				table.insert(var_5_0, var_5_2)
			end
		end
	end

	return var_5_0
end

function var_0_0.getClearPaths(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1 or {}

	for iter_6_0 in lfs.dir(arg_6_0) do
		if iter_6_0 ~= "." and iter_6_0 ~= ".." then
			if lfs.attributes(arg_6_0 .. "/" .. iter_6_0).mode == "directory" then
				var_0_0.getClearPaths(arg_6_0 .. "/" .. iter_6_0, var_6_0, arg_6_2)
			elseif var_0_0.getExtensions(arg_6_0 .. "/" .. iter_6_0) == arg_6_2 or not arg_6_2 then
				table.insert(var_6_0, arg_6_0 .. "/" .. iter_6_0)
			end
		end
	end

	return var_6_0
end

function var_0_0.checkAnimExist(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or {}

	for iter_7_0 = 1, #arg_7_1 do
		if arg_7_0 == arg_7_1[iter_7_0] then
			return true
		end
	end

	return false
end

function var_0_0.checkIconExist(arg_8_0)
	return cc.FileUtils:getInstance():isFileExist((g.core.common.Path:getSkillIconById(arg_8_0)))
end

function var_0_0.isDebugUpgradeClose()
	local var_9_0 = cc.FileUtils:getInstance()
	local var_9_1 = json.decodeFileIfExists(var_9_0:getWritablePath() .. "/userdata/upgrade_ignore.json")

	if ((not var_9_0 or nil) and {}).ignore then
		return true
	end

	return false
end

function var_0_0.setDebugUpgradeClose(arg_10_0)
	cc.FileUtils:getInstance():writeStringToFile(json.encode({
		ignore = arg_10_0
	}), cc.FileUtils:getInstance():getWritablePath() .. "/userdata/upgrade_ignore.json")
end

local var_0_1

function var_0_0.getDebugGlobalValueByKey(arg_11_0)
	var_0_1 = var_0_1 or g.core.common.Storage:load("debug_game_setting_key.json", false) or {}

	return var_0_1[arg_11_0]
end

function var_0_0.setDebugGlobalValueByKey(arg_12_0, arg_12_1)
	var_0_1 = var_0_1 or {}
	var_0_1[arg_12_0] = arg_12_1

	g.core.common.Storage:save("debug_game_setting_key.json", var_0_1, false)
end

return var_0_0
