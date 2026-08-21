local var_0_0 = class("MainActTestBtn", import(".MainBaseActivityBtn"))
local var_0_1 = true

function var_0_0.InShowTime(arg_1_0)
	arg_1_0.config = {
		param = "0",
		name = "event_all",
		time = "always",
		text_pic = "text_event_all",
		type = 0,
		pic = "event_all_default",
		id = 9,
		group_id = 1,
		order = 99
	}

	return var_0_1
end

function var_0_0.CustomOnClick(arg_2_0)
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.DREAMLAND)

	return
end

return var_0_0
