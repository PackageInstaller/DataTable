local MainActTestBtn = class("MainActTestBtn", import(".MainBaseActivityBtn"))
local var_0_1 = true

function MainActTestBtn:InShowTime()
	self.config = {
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

function MainActTestBtn:CustomOnClick()
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.DREAMLAND)

	return
end

return MainActTestBtn
