class = var_0_10000

local var_0_0 = "GoBackCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = arg_1_1
	local var_1_2

	if not arg_1_1.getType(var_1_1) then
		var_1_2 = 1
	end

	getProxy = var_1_1
	ContextProxy = var_1_10005

	local var_1_3 = var_1_1(var_1_10005)
	local var_1_4 = var_4.popContext(var_1_3)
	local var_1_5
	local var_1_6

	while 0 < var_1_2 do
		if var_4:getContextCount() == 0 then
			break
		elseif var_4:popContext().skipBack then
			var_1_5 = nil
		else
			var_1_2 = var_1_2 - 1
		end
	end

	if var_1_5 then
		var_1_6 = var_1_5.scene
	else
		Context = var_8
		var_1_5 = var_8.New()
		SCENE = var_8
		var_1_6 = var_8.MAINUI
	end

	var_1_5:extendData(var_1_0)

	SCENE = var_8

	var_8.SetSceneInfo(var_1_5, var_1_6)

	local var_1_7 = arg_1_0
	local var_1_8 = arg_1_0.sendNotification

	GAME = var_10

	var_1_8(var_1_7, var_10.LOAD_SCENE, {
		isBack = true,
		prevContext = var_1_4,
		context = var_1_5
	})

	return
end

return var_0_1
