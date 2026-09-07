local MainActFeastBtn = class("MainActFeastBtn", import(".MainBaseActivityBtn"))

function MainActFeastBtn:InShowTime()
	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST)

	self.config = {
		param = "0",
		name = "event_minigame",
		text_pic = "text_event_minigame",
		type = 0,
		pic = "event_minigame",
		id = 20,
		group_id = 5,
		order = 1,
		time = {
			"default"
		}
	}

	return var_1_0 and not var_1_0:isEnd()
end

function MainActFeastBtn:CustomOnClick()
	self:emit(NewMainMediator.GO_SCENE, SCENE.FEAST)

	return
end

return MainActFeastBtn
