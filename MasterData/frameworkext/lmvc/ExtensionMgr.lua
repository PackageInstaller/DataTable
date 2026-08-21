module("frameworkext.lmvc.extension.ExtensionMgr", package.seeall)

local var_0_0 = class("ExtensionMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._agents = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._setting = arg_2_1
end

function var_0_0._initExtension(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._setting[arg_3_1]

	if not var_3_0 then
		return
	end

	local var_3_1 = 0
	local var_3_2 = 0
	local var_3_3 = getglobal("_G")
	local var_3_4 = var_3_0.configs

	if var_3_4 then
		local var_3_5 = #var_3_4

		for iter_3_0 = 1, var_3_5 do
			if var_3_3[var_3_4[iter_3_0]] then
				local var_3_6 = var_3_3[var_3_4[iter_3_0]].instance

				if var_3_6 then
					var_3_6:onInit()

					local var_3_7 = var_3_6:getNames()

					if var_3_7 then
						local var_3_8 = #var_3_7

						for iter_3_1 = 1, var_3_8 do
							ConfigMgr.instance:requestConfig(var_3_7[iter_3_1], var_3_6)
						end
					end
				else
					printError("Cannot find config instance:", var_3_4[iter_3_0])
				end
			else
				printError("Cannot find config class:", var_3_4[iter_3_0])
			end
		end
	end

	local var_3_9 = var_3_0.models

	if var_3_9 then
		local var_3_10 = #var_3_9

		for iter_3_2 = 1, var_3_10 do
			if var_3_3[var_3_9[iter_3_2]] then
				local var_3_11 = var_3_3[var_3_9[iter_3_2]].instance

				if var_3_11 then
					var_3_11:onInit()
				else
					printError("Cannot find model instance:", var_3_9[iter_3_2])
				end
			else
				printError("Cannot find model class:", var_3_9[iter_3_2])
			end
		end
	end

	local var_3_12 = var_3_0.agents

	if var_3_12 then
		local var_3_13 = {}

		arg_3_0._agents[arg_3_1] = var_3_13

		local var_3_14 = #var_3_12

		for iter_3_3 = 1, var_3_14 do
			if var_3_3[var_3_12[iter_3_3]] then
				local var_3_15 = var_3_3[var_3_12[iter_3_3]].instance

				if var_3_15 then
					var_3_15:setExtId(arg_3_1)
					var_3_15:onInit()
					table.insert(var_3_13, var_3_15)
				else
					printError("Cannot find agent instance:", var_3_12[iter_3_3])
				end
			else
				printError("Cannot find agent class:", var_3_12[iter_3_3])
			end
		end
	end

	local var_3_16 = var_3_0.controllers

	if var_3_16 then
		local var_3_17 = #var_3_16

		for iter_3_4 = 1, var_3_17 do
			if var_3_3[var_3_16[iter_3_4]] then
				local var_3_18 = var_3_3[var_3_16[iter_3_4]].instance

				if var_3_18 then
					var_3_18:onInit()
				else
					printError("Cannot find controller instance:", var_3_16[iter_3_4])
				end
			else
				printError("Cannot find controller class:", var_3_16[iter_3_4])
			end
		end
	end
end

function var_0_0._lateInitExtension(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._setting[arg_4_1]

	if not var_4_0 then
		return
	end

	local var_4_1 = getglobal("_G")
	local var_4_2 = 0
	local var_4_3 = var_4_0.models

	if var_4_3 then
		local var_4_4 = #var_4_3

		for iter_4_0 = 1, var_4_4 do
			if var_4_1[var_4_3[iter_4_0]] then
				local var_4_5 = var_4_1[var_4_3[iter_4_0]].instance

				if var_4_5 then
					var_4_5:onLateInit()
				else
					printError("Cannot find model instance:", var_4_3[iter_4_0])
				end
			else
				printError("Cannot find model class:", var_4_3[iter_4_0])
			end
		end
	end

	local var_4_6 = var_4_0.controllers

	if var_4_6 then
		local var_4_7 = #var_4_6

		for iter_4_1 = 1, var_4_7 do
			if var_4_1[var_4_6[iter_4_1]] then
				local var_4_8 = var_4_1[var_4_6[iter_4_1]].instance

				if var_4_8 then
					var_4_8:onLateInit()
				else
					printError("Cannot find controller instance:", var_4_6[iter_4_1])
				end
			else
				printError("Cannot find controller class:", var_4_6[iter_4_1])
			end
		end
	end
end

function var_0_0._resetExtension(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._setting[arg_5_1]

	if not var_5_0 then
		return
	end

	local var_5_1 = 0
	local var_5_2 = getglobal("_G")
	local var_5_3 = var_5_0.models

	if var_5_3 then
		local var_5_4 = #var_5_3

		for iter_5_0 = 1, var_5_4 do
			var_5_2[var_5_3[iter_5_0]].instance:onReset()
		end
	end

	local var_5_5 = var_5_0.controllers

	if var_5_5 then
		local var_5_6 = #var_5_5

		for iter_5_1 = 1, var_5_6 do
			var_5_2[var_5_5[iter_5_1]].instance:onReset()
		end
	end
end

function var_0_0.getAgents(arg_6_0, arg_6_1)
	return arg_6_0._agents[arg_6_1]
end

function var_0_0.buildExtensions(arg_7_0, arg_7_1)
	local var_7_0 = #arg_7_1

	for iter_7_0 = 1, var_7_0 do
		arg_7_0:_initExtension(arg_7_1[iter_7_0])
	end

	for iter_7_1 = 1, var_7_0 do
		arg_7_0:_lateInitExtension(arg_7_1[iter_7_1])
	end
end

function var_0_0.buildAllExtensions(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._setting) do
		arg_8_0:_initExtension(iter_8_0)
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_0._setting) do
		arg_8_0:_lateInitExtension(iter_8_2)
	end
end

function var_0_0.resetAllExtensions(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._setting) do
		arg_9_0:_resetExtension(iter_9_0)
	end
end

function var_0_0.dispatchServerErrorMsg(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	arg_10_0:_handleMsg(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
end

function var_0_0._handleMsg(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = arg_11_0:getAgents(arg_11_1)

	if var_11_0 then
		local var_11_1
		local var_11_2 = #var_11_0

		for iter_11_0 = 1, var_11_2 do
			var_11_1 = var_11_0[iter_11_0][arg_11_4]

			if var_11_1 then
				if enableDebug then
					trycall(var_11_1, var_11_0[iter_11_0], arg_11_3, arg_11_5)

					break
				end

				var_11_1(var_11_0[iter_11_0], arg_11_3, arg_11_5)

				break
			end
		end

		if not var_11_1 then
			printWarn("No handler for proto structName=" .. arg_11_4)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
