local var_0_0 = {
	"<color=#ff7d36>军事委托</color>从这里进入",
	"前往<color=#ff7d36>军事委托</color>",
	"这里显示着今日的所有委托，<color=#ff7d36>每个委托耗时不同，消耗与奖励也不同</color>",
	"点击看看详细要求吧",
	"点击这里能看到当前的<color=#ff7d36>紧急委托</color>",
	"<color=#ff7d36>紧急委托会在出击战斗时随机出现</color>，并且有时间限制，记得查看哦"
}

return {
	id = "SYG003",
	events = {
		{
			alpha = 0.284,
			style = {
				mode = 2,
				dir = 1,
				posY = 89.6,
				posX = 186.59,
				text = var_0_0[1]
			},
			ui = {
				pathIndex = -1,
				dynamicPath = function()
					getProxy = var_1_10000
					SettingsProxy = var_1_10001

					local var_1_0 = var_1_10000(var_1_10001)

					if var_0.IsMellowStyle(var_1_0) then
						return "/OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/right/1/battle"
					else
						return "/OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/right/combatBtn"
					end

					return
				end,
				onClick = function()
					pg = var_1_10000

					local var_2_0 = var_1_10000.m02
					local var_2_1 = var_0.sendNotification

					GAME = var_1_10002

					local var_2_2 = var_1_10002.GO_SCENE

					SCENE = var_1_10003

					var_2_1(var_2_0, var_2_2, var_1_10003.LEVEL, {
						mapIdx = 1,
						noRecord = true
					})

					return
				end,
				triggerType = {
					1
				},
				fingerPos = {
					posY = -4.24,
					posX = 28.95
				}
			}
		},
		{
			alpha = 0.485,
			style = {
				mode = 2,
				dir = 1,
				posY = 0,
				posX = 0,
				text = var_0_0[2]
			},
			ui = {
				pathIndex = -1,
				path = "/UICamera/Canvas/UIMain/LevelMainScene(Clone)/main/right_chapter/event_btns/event_container/btn_task",
				triggerType = {
					1
				},
				fingerPos = {
					posY = 0,
					posX = 65.6
				}
			}
		},
		{
			alpha = 0.563,
			style = {
				mode = 2,
				dir = -1,
				posY = 0,
				posX = 0,
				text = var_0_0[3]
			}
		},
		{
			alpha = 0.636,
			style = {
				mode = 2,
				dir = 1,
				posY = -69.9,
				posX = -271.7,
				text = var_0_0[4]
			},
			ui = {
				pathIndex = 0,
				delay = 1,
				eventIndex = 1,
				path = "/UICamera/Canvas/UIMain/EventUI(Clone)/scrollRect$/content",
				triggerType = {
					1
				},
				fingerPos = {
					posY = 0,
					posX = 65.6
				}
			}
		},
		{
			alpha = 0.419,
			style = {
				mode = 2,
				dir = -1,
				posY = 175.56,
				posX = -231.6,
				text = var_0_0[5]
			},
			ui = {
				pathIndex = -1,
				path = "/UICamera/Canvas/UIMain/EventUI(Clone)/blur_panel/adapt/left_length/frame/scroll_rect/tagRoot/urgency_btn",
				triggerType = {
					2
				},
				fingerPos = {
					posY = -28.49,
					posX = 58.24
				}
			}
		},
		{
			alpha = 0.351,
			style = {
				mode = 2,
				dir = -1,
				posY = 0,
				posX = 0,
				text = var_0_0[6]
			}
		}
	}
}
