local var_0_0 = {
	"让我们打开<color=#ff7d36>任务日志</color>",
	"领取<color=#ff7d36>任务奖励</color>"
}

return {
	id = "S011",
	events = {
		{
			alpha = 0.325,
			style = {
				mode = 2,
				dir = 1,
				posY = -123,
				posX = 87.7,
				text = var_0_0[1]
			},
			ui = {
				pathIndex = -1,
				dynamicPath = function()
					getProxy = var_1_10000
					SettingsProxy = var_1_10002

					local var_1_0 = var_1_10000(var_1_10002)

					if var_0.IsMellowStyle(var_1_0) then
						return "/OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/bottom/frame/task"
					else
						return "/OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/bottom/taskButton"
					end

					return
				end,
				triggerType = {
					1
				},
				fingerPos = {
					posY = -21.7,
					posX = 36.96
				}
			}
		},
		{
			alpha = 0.375,
			waitScene = "TaskScene",
			ui = {
				pathIndex = -1,
				path = "/UICamera/Canvas/UIMain/TaskScene(Clone)/blur_panel/adapt/left_length/frame/tagRoot/scenario",
				triggerType = {
					2
				},
				fingerPos = {
					posY = -50,
					posX = 40
				}
			}
		},
		{
			alpha = 0.375,
			waitScene = "TaskScene",
			style = {
				mode = 2,
				dir = 1,
				posY = 183,
				posX = 474,
				text = var_0_0[2]
			},
			ui = {
				delay = 1,
				pathIndex = -1,
				path = "/UICamera/Canvas/UIMain/TaskScene(Clone)/pages/TaskListPage(Clone)/right_panel/content/0/frame/get_btn",
				triggerType = {
					1
				}
			}
		}
	}
}
