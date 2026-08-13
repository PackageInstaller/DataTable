return {
	id = "NG0043",
	events = {
		{
			alpha = 0.6,
			style = {
				text = "距离投票开始还有时间，再去其他区域逛逛吧！（提示：点击带有！的区域）",
				mode = 1,
				dir = -1,
				posY = 250,
				posX = -92,
				uiFunc = function()
					local var_1_0 = {}

					pg = var_1_10001

					local var_1_1 = var_1_10001.NewStoryMgr.GetInstance()
					local var_1_2 = var_1.IsPlayed

					VoteStoryUtil = var_1_10003

					local var_1_3 = var_1_10003.GetStoryNameByType

					VoteStoryUtil = var_1_10004

					if not var_1_2(var_1_1, var_1_3(var_1_10004.ENTER_MAIN_STAGE)) then
						table = var_1

						var_1.insert(var_1_0, {
							path = "/UICamera/Canvas/UIMain/VoteEntranceUI(Clone)/bg/main/title"
						})

						table = var_1

						var_1.insert(var_1_0, {
							path = "/UICamera/Canvas/UIMain/VoteEntranceUI(Clone)/bg/main/tip"
						})
					end

					pg = var_1

					local var_1_4 = var_1.NewStoryMgr.GetInstance()
					local var_1_5 = var_1.IsPlayed

					VoteStoryUtil = var_3

					local var_1_6 = var_3.GetStoryNameByType

					VoteStoryUtil = var_4

					if not var_1_5(var_1_4, var_1_6(var_4.ENTER_SUB_STAGE)) then
						table = var_1

						var_1.insert(var_1_0, {
							path = "/UICamera/Canvas/UIMain/VoteEntranceUI(Clone)/bg/sub/title"
						})

						table = var_1

						var_1.insert(var_1_0, {
							path = "/UICamera/Canvas/UIMain/VoteEntranceUI(Clone)/bg/sub/tip"
						})
					end

					pg = var_1

					local var_1_7 = var_1.NewStoryMgr.GetInstance()
					local var_1_8 = var_1.IsPlayed

					VoteStoryUtil = var_3

					local var_1_9 = var_3.GetStoryNameByType

					VoteStoryUtil = var_4

					if not var_1_8(var_1_7, var_1_9(var_4.ENTER_EXCHANGE)) then
						table = var_1

						var_1.insert(var_1_0, {
							path = "/UICamera/Canvas/UIMain/VoteEntranceUI(Clone)/bg/exchange/title"
						})

						table = var_1

						var_1.insert(var_1_0, {
							path = "/UICamera/Canvas/UIMain/VoteEntranceUI(Clone)/bg/exchange/tip"
						})
					end

					pg = var_1

					local var_1_10 = var_1.NewStoryMgr.GetInstance()
					local var_1_11 = var_1.IsPlayed

					VoteStoryUtil = var_3

					local var_1_12 = var_3.GetStoryNameByType

					VoteStoryUtil = var_4

					if not var_1_11(var_1_10, var_1_12(var_4.ENTER_SCHEDULE)) then
						table = var_1

						var_1.insert(var_1_0, {
							path = "/UICamera/Canvas/UIMain/VoteEntranceUI(Clone)/bg/billboard/title"
						})

						table = var_1

						var_1.insert(var_1_0, {
							path = "/UICamera/Canvas/UIMain/VoteEntranceUI(Clone)/bg/billboard/tip"
						})
					end

					pg = var_1

					local var_1_13 = var_1.NewStoryMgr.GetInstance()
					local var_1_14 = var_1.IsPlayed

					VoteStoryUtil = var_3

					local var_1_15 = var_3.GetStoryNameByType

					VoteStoryUtil = var_4

					if not var_1_14(var_1_13, var_1_15(var_4.ENTER_HALL)) then
						table = var_1

						var_1.insert(var_1_0, {
							path = "/UICamera/Canvas/UIMain/VoteEntranceUI(Clone)/bg/honor/title"
						})

						table = var_1

						var_1.insert(var_1_0, {
							path = "/UICamera/Canvas/UIMain/VoteEntranceUI(Clone)/bg/honor/tip"
						})
					end

					return var_1_0
				end
			}
		}
	}
}
