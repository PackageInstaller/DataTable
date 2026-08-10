local var_0_0 = require("cjson")
local var_0_1 = {}
local var_0_2 = {}

function CheckVersion(arg_1_0, arg_1_1)
	CheckManagers()
	Debug.Log("开始检查版本信息")
	manager.ui:UIEventEnabled(false)
	SendMessageToSDKWithCallBack("{\"messageType\" : \"GetUpdateInfo\"}", "UpdateInfoGet", function()
		manager.ui:UIEventEnabled(true)
		Debug.Log("结束检查版本信息")

		if IsVersionNeedUpdate() then
			ShowNeedUpdateWindow()

			if arg_1_1 then
				arg_1_1()
			end
		else
			arg_1_0()
		end
	end)
end

function UpdateInfoGet(arg_3_0, arg_3_1)
	var_0_1 = var_0_0.decode(arg_3_0 or "{}") or {}
	var_0_2 = var_0_0.decode(arg_3_1 or "{}") or {}
end

function IsVersionNeedUpdate()
	local var_4_0 = LuaForUtil.GetResourceVersionName()

	if var_4_0 and var_4_0 ~= "" and var_0_1 and var_0_1.versionName then
		local var_4_1 = string.sub(var_4_0, 2)
		local var_4_2 = string.split(var_4_1, ".")
		local var_4_3 = var_0_1.versionName
		local var_4_4 = string.sub(var_4_3, 2)
		local var_4_5 = string.split(var_4_4, ".")

		for iter_4_0 = 1, 3 do
			local var_4_6 = tonumber(var_4_2[iter_4_0])
			local var_4_7 = tonumber(var_4_5[iter_4_0])

			if var_4_7 < var_4_6 then
				return false
			elseif var_4_6 < var_4_7 then
				return true
			end
		end
	end

	return false
end

function ShowNeedUpdateWindow()
	GameToSDK.UpUserEvent("{\"eventType\" : \"End\"}")

	if whereami == "battle" then
		CheckManagers()
	end

	ShowMessageBox({
		isTop = true,
		ButtonType = "SingleBtn",
		title = GetTips("PROMPT"),
		content = GetTips("CHECK_UPDATE_NOTE"),
		OkCallback = function()
			LuaHelper.Quit()
		end,
		CancelCallback = function()
			return
		end
	})
end
