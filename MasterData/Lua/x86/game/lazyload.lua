require("game/ConfigOptimization")

local var_0_0 = singletonClass("LazyLoad")

function var_0_0.Ctor(arg_1_0)
	_G.globleDefine = {}
	_G.globleModulesRegister = {}

	setmetatable(_G, {
		__index = function(self, arg_2_1)
			local var_2_0 = self.globleDefine[arg_2_1]

			if self.globleDefine[arg_2_1] == nil then
				if self.globleModulesRegister[arg_2_1] then
					var_2_0 = import_and_optimize_config(self.globleModulesRegister[arg_2_1])

					if var_2_0 == nil then
						print(debug.traceback("create a nil module moduleName = " .. arg_2_1))
					end

					self.globleDefine[arg_2_1] = var_2_0
				end

				rawset(self, arg_2_1, var_2_0)
			end

			return var_2_0
		end
	})
end

function var_0_0.registerModules(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == nil or arg_3_2 == nil then
		print("LazyLoad:registerModules fail " .. tostring(arg_3_1) .. " : " .. tostring(arg_3_2))

		return
	end

	if _G.globleModulesRegister[arg_3_1] then
		print("LazyLoad moduleName is exist :" .. arg_3_1)
	end

	_G.globleModulesRegister[arg_3_1] = arg_3_2
end

return var_0_0
