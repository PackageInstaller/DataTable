pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.YongshiDeepLinkingMgr = var_0_10001("YongshiDeepLinkingMgr")

local var_0_1 = var_0.YongshiDeepLinkingMgr
local var_0_2 = true

local function var_0_3(arg_1_0)
	if var_0_2 then
		originalPrint = var_1

		var_1(arg_1_0)
	end

	return
end

function var_0_1.SetData(arg_2_0, arg_2_1)
	var_0_3("SetData......")

	arg_2_0.deepLinking = arg_2_1

	arg_2_0:SwitchScene()

	return
end

function var_0_1.ShouldSwitchScene(arg_3_0)
	if arg_3_0.deepLinking ~= nil then
		var_1_10002 = arg_3_0.deepLinking

		if var_1.IsEmpty(var_1_10002) then
			var_0_3("deepLinking is empty")

			return false
		end

		if not var_0.m02 then
			var_0_3("game is not start")

			return false
		end

		getProxy = var_1
		ContextProxy = var_1_10002

		local var_3_0 = var_1(var_1_10002)

		if not var_1.getCurrentContext(var_3_0) then
			var_0_3("game is not start")

			return false
		end

		local var_3_1 = var_2.mediator

		LoginMediator = var_1_10004

		if var_3_1 == var_1_10004 then
			var_0_3("player is not created")

			return false
		end

		local var_3_2 = var_2.mediator

		CombatLoadMediator = var_1_10004

		if var_3_2 ~= var_1_10004 then
			local var_3_3 = var_2.mediator

			BattleMediator = var_1_10004

			if var_3_3 == var_1_10004 then
				var_0_3("game is in battle")
				arg_3_0:Clear()

				return false
			end

			return true
		end
	end
end

local function var_0_4(arg_4_0, arg_4_1)
	var_0_3("Switch......" .. arg_4_0 .. "-" .. arg_4_1)

	if arg_4_0 == "1" then
		local var_4_0 = var_0.m02
		local var_4_1 = var_2.sendNotification

		GAME = var_4

		local var_4_2 = var_4.GO_SCENE

		SCENE = var_5

		var_4_1(var_4_0, var_4_2, var_5.DOCKYARD)
	end

	return
end

function var_0_1.SwitchScene(arg_5_0)
	var_0_3("SwitchScene......")

	if arg_5_0:ShouldSwitchScene() then
		local var_5_0 = arg_5_0.deepLinking.page
		local var_5_1 = arg_5_0.deepLinking.arg

		var_0_4(var_5_0, var_5_1)
		arg_5_0:Clear()
	end

	return
end

function var_0_1.Clear(arg_6_0)
	var_0_3("Clear......")

	local var_6_0 = arg_6_0.deepLinking

	var_1.Clear(var_6_0)

	arg_6_0.deepLinking = nil

	return
end

return
