class = var_0_10000

local var_0_0 = "IslandQTEMiniGameLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "IslandQTEGameUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	eachChild = var_1

	var_1(arg_2_0._tf, function(arg_3_0)
		setActive = var_2_10001

		var_2_10001(arg_3_0, arg_3_0.name == arg_2_0.contextData.mark)

		if arg_3_0.name == arg_2_0.contextData.mark then
			arg_2_0.rtGame = arg_3_0
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_4_0)
	switch = var_1_10001

	var_1_10001(arg_4_0.contextData.mark, {
		Qgame1 = function()
			local var_5_0 = arg_4_0.rtGame
			local var_5_1 = var_0.Find(var_5_0, "content")

			math = var_5_0

			local var_5_2 = var_5_0.random(3, 7)
			local var_5_3 = {}
			local var_5_4 = {}

			for iter_5_0 = var_5_1.childCount, 1, -1 do
				table = var_2_10008

				var_2_10008.insert(var_5_4, iter_5_0)
			end

			local var_5_5 = arg_4_0.rtGame
			local var_5_6 = var_4.Find(var_5_5, "res")

			for iter_5_1 = 1, var_5_2 do
				table = var_2_10009
				var_2_10009 = var_2_10009.remove

				local var_5_7 = var_5_4

				math = var_2_10011
				var_2_10009 = var_2_10009(var_5_7, var_2_10011.random(#var_5_4))
				table = var_5_7

				var_5_7.insert(var_5_3, var_2_10009)

				cloneTplTo = var_10

				local var_5_8 = var_5_6

				var_2_10011 = var_5_6.Find
				math = var_2_10013
				var_2_10011 = var_2_10011(var_5_8, var_2_10013.random(var_5_6.childCount))
				var_2_10013 = var_5_1

				local var_5_9 = var_10(var_2_10011, var_5_1.GetChild(var_2_10013, var_2_10009 - 1))

				var_2_10013 = var_10.Find(var_5_9, "Image")

				local var_5_10 = var_2_10011.GetComponent

				typeof = var_14
				DftAniEvent = var_2_10015
				var_2_10013 = var_5_10(var_2_10013, var_14(var_2_10015))

				var_12.SetEndEvent(var_2_10013, function(arg_6_0)
					var_5_2 = var_5_2 - 1
					table = var_1

					var_1.removebyvalue(var_5_3, var_2_10009)

					Destroy = var_1

					var_1(var_0)

					if var_5_2 == 0 then
						if arg_4_0.timer then
							local var_6_0 = arg_4_0.timer

							var_1.Stop(var_6_0)

							arg_4_0.timer = nil
						end

						local var_6_1 = arg_4_0

						var_1.finishGame(var_6_1)
					end

					return
				end)

				onButton = var_12
				var_2_10013 = arg_4_0

				local var_5_11 = var_2_10011

				function var_2_10015()
					SetCompomentEnabled = var_3_10000

					local var_7_0 = var_2_10011

					typeof = var_3_10002
					Animator = var_3_10003

					var_3_10000(var_7_0, var_3_10002(var_3_10003), true)

					return
				end

				SFX_PANEL = var_2_10016

				var_12(var_2_10013, var_5_11, var_2_10015, var_2_10016)
			end

			setText = var_5

			local var_5_12 = arg_4_0.rtGame
			local var_5_13 = var_6.Find(var_5_12, "btn_hint/Text")

			i18n = var_5_12

			var_5(var_5_13, var_5_12("islandnode_tips2"))

			onButton = var_5

			local var_5_14 = arg_4_0
			local var_5_15 = arg_4_0.rtGame
			local var_5_16 = var_7.Find(var_5_15, "btn_hint")

			local function var_5_17()
				local var_8_0 = 10
				local var_8_1 = arg_4_0

				Timer = var_3_10002
				var_8_1.timer = var_3_10002.New(function()
					local var_9_3

					if var_8_0 == 0 then
						setText = var_9_3

						local var_9_0 = arg_4_0.rtGame
						local var_9_1 = var_1.Find(var_9_0, "btn_hint/Text")

						i18n = var_9_0

						var_9_3(var_9_1, var_9_0("islandnode_tips2"))

						setButtonEnabled = var_9_3

						local var_9_2 = arg_4_0.rtGame

						var_9_3(var_1.Find(var_9_2, "btn_hint"), true)

						var_9_3 = arg_4_0
						var_9_3.timer = nil
					else
						setText = var_9_3

						local var_9_4 = arg_4_0.rtGame
						local var_9_5 = var_1.Find(var_9_4, "btn_hint/Text")

						setColorStr = var_9_4
						i18n = var_3

						local var_9_6 = var_3("islandnode_tips2")

						string = var_4

						var_9_3(var_9_5, var_9_4(var_9_6 .. var_4.format("(%ds)", var_8_0), "#4E4E4EFF"))

						var_8_0 = var_8_0 - 1
					end

					return
				end, 1, var_8_0)

				arg_4_0.timer.func()

				local var_8_2 = arg_4_0.timer

				var_1.Start(var_8_2)

				setButtonEnabled = var_1

				local var_8_3 = arg_4_0.rtGame

				var_1(var_2.Find(var_8_3, "btn_hint"), false)

				setActive = var_1

				local var_8_4 = var_5_1
				local var_8_5 = var_2.GetChild(var_8_4, var_5_3[1] - 1)
				local var_8_6 = var_2.GetChild(var_8_5, 0)

				var_1(var_2.Find(var_8_6, "light"), true)

				return
			end

			SFX_CONFIRM = var_9

			var_5(var_5_14, var_5_16, var_5_17, var_9)

			return
		end,
		Qgame2 = function()
			local var_10_0 = 1
			local var_10_1 = 0
			local var_10_2 = arg_4_0.rtGame
			local var_10_3 = var_2.Find(var_10_2, "char")
			local var_10_4 = var_2.GetChild

			math = var_2_10005

			local var_10_5 = var_10_4(var_10_3, var_2_10005.random(var_2.childCount) - 1)

			eachChild = var_10_3

			var_10_3(var_2, function(arg_11_0)
				setActive = var_3_10001

				var_3_10001(arg_11_0, arg_11_0 == var_10_5)

				return
			end)

			local var_10_6 = {}
			local var_10_7 = arg_4_0.rtGame

			var_10_6[1] = var_5.Find(var_10_7, "vine")

			local var_10_8 = arg_4_0.rtGame

			var_10_6[2] = var_5.Find(var_10_8, "vine_f")
			var_10_6[3] = var_10_5
			ipairs = var_5

			for iter_10_0, iter_10_1 in var_5(var_10_6) do
				SetActionCallback = var_2_10010

				var_2_10010(iter_10_1, function(arg_12_0)
					if arg_12_0 == "finish" and var_10_0 == 3 then
						var_10_1 = var_10_1 - 1

						if var_10_1 == 0 then
							local var_12_0 = arg_4_0

							var_1.finishGame(var_12_0, 0)
						end
					end

					return
				end)
			end

			local var_10_9 = 0
			local var_10_10 = 0

			local function var_10_11()
				if (var_10_9 - var_10_10) * (var_10_9 - var_10_10) < 0.010000000000000002 then
					var_10_1 = var_10_1 + 1

					if var_10_1 >= 3 then
						setButtonEnabled = var_0

						local var_13_0 = arg_4_0.rtGame

						var_0(var_1.Find(var_13_0, "btn_l"), false)

						setButtonEnabled = var_0

						local var_13_1 = arg_4_0.rtGame

						var_0(var_1.Find(var_13_1, "btn_r"), false)

						var_10_0 = 3
						ipairs = var_0

						for iter_13_0, iter_13_1 in var_0(var_10_6) do
							SetAction = var_3_10005

							var_3_10005(iter_13_1, "hd_action" .. var_10_0)
						end
					end
				end

				return
			end

			onButton = iter_10_0

			local var_10_12 = arg_4_0
			local var_10_13 = arg_4_0.rtGame
			local var_10_14 = var_10.Find(var_10_13, "btn_l")

			local function var_10_15()
				if var_10_0 == 1 then
					var_10_0 = 2
					ipairs = var_0

					for iter_14_0, iter_14_1 in var_0(var_10_6) do
						SetAction = var_3_10005

						var_3_10005(iter_14_1, "hd_action" .. var_10_0)
					end
				end

				Time = var_0
				var_10_9 = var_0.realtimeSinceStartup

				var_10_11()

				return
			end

			SFX_PANEL = var_12

			iter_10_0(var_10_12, var_10_14, var_10_15, var_12)

			onButton = iter_10_0

			local var_10_16 = arg_4_0
			local var_10_17 = arg_4_0.rtGame
			local var_10_18 = var_10.Find(var_10_17, "btn_r")

			local function var_10_19()
				if var_10_0 == 1 then
					var_10_0 = 2
					ipairs = var_0

					for iter_15_0, iter_15_1 in var_0(var_10_6) do
						SetAction = var_3_10005

						var_3_10005(iter_15_1, "hd_action" .. var_10_0)
					end
				end

				Time = var_0
				var_10_10 = var_0.realtimeSinceStartup

				var_10_11()

				return
			end

			SFX_PANEL = var_12

			iter_10_0(var_10_16, var_10_18, var_10_19, var_12)

			onButton = iter_10_0

			local var_10_20 = arg_4_0
			local var_10_21 = arg_4_0.rtGame
			local var_10_22 = var_10.Find(var_10_21, "btn_back")

			local function var_10_23()
				local var_16_0 = arg_4_0

				var_0.closeView(var_16_0)

				return
			end

			SFX_CANCEL = var_12

			iter_10_0(var_10_20, var_10_22, var_10_23, var_12)

			IsUnityEditor = iter_10_0

			if iter_10_0 and not arg_4_0.handle then
				local var_10_24 = arg_4_0

				UpdateBeat = var_10_20
				var_10_24.handle = var_10_20:CreateListener(function(arg_17_0)
					Input = var_3_10001

					local var_17_0 = var_3_10001.GetKeyUp

					KeyCode = var_3_10002

					local var_17_1, var_17_2

					if var_17_0(var_3_10002.F) then
						var_17_1 = arg_17_0.rtGame
						var_17_1 = var_17_2.Find(var_17_1, "btn_l")
						var_17_2 = var_17_2.GetComponent
						typeof = var_3
						Button = var_3_10004

						if var_17_2(var_17_1, var_3(var_3_10004)).interactable then
							triggerButton = var_17_2

							local var_17_3 = arg_17_0.rtGame

							var_17_2(var_17_1.Find(var_17_3, "btn_l"))
						end
					end

					Input = var_17_2

					local var_17_4 = var_17_2.GetKeyUp

					KeyCode = var_17_1

					if var_17_4(var_17_1.J) then
						local var_17_5 = arg_17_0.rtGame
						local var_17_6 = var_1.Find(var_17_5, "btn_r")
						local var_17_7 = var_1.GetComponent

						typeof = var_3
						Button = var_3_10004

						if var_17_7(var_17_6, var_3(var_3_10004)).interactable then
							triggerButton = var_1

							local var_17_8 = arg_17_0.rtGame

							var_1(var_2.Find(var_17_8, "btn_r"))
						end
					end

					return
				end, arg_4_0)
				UpdateBeat = var_10_24

				var_10_24:AddListener(arg_4_0.handle)
			end

			return
		end,
		Qgame3 = function()
			local var_18_0 = 0.5
			local var_18_1 = {
				{
					1,
					2,
					3
				},
				{
					1,
					3,
					2
				},
				{
					2,
					1,
					3
				},
				{
					2,
					3,
					1
				},
				{
					3,
					1,
					2
				},
				{
					3,
					2,
					1
				}
			}

			math = var_2

			local var_18_2 = var_2.random(3)
			local var_18_3 = 3
			local var_18_4 = 0
			local var_18_5
			local var_18_6 = 0
			local var_18_7 = 1
			local var_18_8
			local var_18_9 = {}

			for iter_18_0 = 1, 3 do
				table = var_2_10014
				var_2_10014 = var_2_10014.insert

				local var_18_10 = var_18_9
				local var_18_11 = arg_4_0.rtGame

				var_2_10014(var_18_10, var_16.Find(var_18_11, iter_18_0))

				onButton = var_2_10014

				local var_18_12 = arg_4_0
				local var_18_13 = var_18_9[iter_18_0]
				local var_18_14 = var_16.Find(var_18_13, "click")

				local function var_18_15()
					if var_18_8 then
						LeanTween = var_0

						var_0.cancel(var_18_8)
					end

					setCanvasGroupAlpha = var_0

					local var_19_0 = arg_4_0.rtGame

					var_0(var_1.Find(var_19_0, "Image"), 1)

					setActive = var_0

					local var_19_1 = arg_4_0.rtGame

					var_0(var_1.Find(var_19_1, "Text"), true)

					var_18_5 = iter_18_0

					if iter_18_0 == var_18_2 then
						SetAction = var_0

						var_0(var_18_9[iter_18_0], "action3")

						setText = var_0

						local var_19_2 = arg_4_0.rtGame
						local var_19_3 = var_1.Find(var_19_2, "Text")

						i18n = var_19_2

						var_0(var_19_3, var_19_2("islandnode_tips4"))
					else
						SetAction = var_0

						var_0(var_18_9[iter_18_0], "action4")

						setText = var_0

						local var_19_4 = arg_4_0.rtGame
						local var_19_5 = var_1.Find(var_19_4, "Text")

						i18n = var_19_4

						var_0(var_19_5, var_19_4("islandnode_tips5"))
					end

					ipairs = var_0

					for iter_19_0, iter_19_1 in var_0(var_18_9) do
						setButtonEnabled = var_3_10005

						var_3_10005(iter_19_1:Find("click"), false)
					end

					return
				end

				SFX_PANEL = var_18

				var_2_10014(var_18_12, var_18_14, var_18_15, var_18)

				setButtonEnabled = var_2_10014

				local var_18_16 = var_18_9[iter_18_0]

				var_2_10014(var_15.Find(var_18_16, "click"), false)

				SetActionCallback = var_2_10014

				var_2_10014(var_18_9[iter_18_0], function(arg_20_0)
					if arg_20_0 == "finish" then
						if iter_18_0 == var_18_5 then
							local var_20_0 = arg_4_0

							var_1.finishGame(var_20_0, var_18_2 == var_18_5 and 1 or 0)
						elseif var_18_6 > 0 or var_18_4 == 5 then
							return
						else
							local var_20_1 = var_18_3

							if 1 < var_20_1 then
								var_18_3 = var_18_3 - 1
							else
								var_18_4 = var_18_4 + 1
								var_18_3 = 3

								local function var_20_2()
									local var_21_0 = var_18_7
									local var_21_1 = var_18_7

									math = var_4_10002
									var_18_7 = (var_21_1 + var_4_10002.random(#var_18_1 - 1) - 1) % #var_18_1 + 1
									ipairs = var_1

									for iter_21_0, iter_21_1 in var_1(var_18_1[var_18_7]) do
										var_18_6 = var_18_6 + 1

										local var_21_2 = {}

										if iter_21_1 ~= var_18_1[var_21_0][iter_21_0] then
											SetAction = var_7

											var_7(var_18_9[iter_21_0], iter_21_1 > var_18_1[var_21_0][iter_21_0] and "move_right" or "move_left")

											table = var_7

											var_7.insert(var_21_2, function(arg_22_0)
												LeanTween = var_5_10001

												local var_22_0 = var_5_10001.moveX(var_18_9[iter_21_0], (iter_21_1 - 2) * 350, var_18_0)
												local var_22_1 = var_1.setOnComplete

												System = var_3

												var_22_1(var_22_0, var_3.Action(arg_22_0))

												return
											end)
										end

										seriesAsync = var_7

										var_7(var_21_2, function()
											SetAction = var_5_10000

											var_5_10000(var_18_9[iter_21_0], "normal1")

											var_18_6 = var_18_6 - 1

											return
										end)
									end

									return
								end

								switch = var_2

								var_2(var_18_4, {
									function()
										for iter_24_0 = 1, 3 do
											SetAction = var_4_10004

											var_4_10004(var_18_9[iter_24_0], iter_24_0 == var_18_2 and "action1" or "action2", false)
										end

										return
									end,
									var_20_2,
									var_20_2,
									var_20_2,
									function()
										for iter_25_0 = 1, 3 do
											setButtonEnabled = var_4_10004

											local var_25_0 = var_18_9[iter_25_0]

											var_4_10004(var_5.Find(var_25_0, "click"), true)
										end

										LeanTween = var_0

										local var_25_1 = var_0.alphaCanvas
										local var_25_2 = arg_4_0.rtGame
										local var_25_3 = var_1.Find(var_25_2, "Image")
										local var_25_4 = var_1.GetComponent

										typeof = var_3
										CanvasGroup = var_4_10004
										var_18_8 = var_25_1(var_25_4(var_25_3, var_3(var_4_10004)), 1, 0.5).uniqueId

										return
									end
								})
							end
						end
					end

					return
				end)

				SetAction = var_2_10014

				var_2_10014(var_18_9[iter_18_0], iter_18_0 == var_18_2 and "normal2" or "normal1")
			end

			setText = var_10

			local var_18_17 = arg_4_0.rtGame
			local var_18_18 = var_11.Find(var_18_17, "Image/Text")

			i18n = var_18_17

			var_10(var_18_18, var_18_17("islandnode_tips3"))

			setCanvasGroupAlpha = var_10

			local var_18_19 = arg_4_0.rtGame

			var_10(var_11.Find(var_18_19, "Image"), 0)

			setActive = var_10

			local var_18_20 = arg_4_0.rtGame

			var_10(var_11.Find(var_18_20, "Text"), false)

			return
		end,
		Qgame4 = function()
			local var_26_0 = 5
			local var_26_1 = 0
			local var_26_2 = arg_4_0.rtGame
			local var_26_3 = var_2.Find(var_26_2, "vine")
			local var_26_4 = var_2.GetChild

			math = var_2_10005

			local var_26_5 = var_26_4(var_26_3, var_2_10005.random(var_2.childCount) - 1)

			eachChild = var_26_3

			var_26_3(var_2, function(arg_27_0)
				setActive = var_3_10001

				var_3_10001(arg_27_0, arg_27_0 == var_26_5)

				return
			end)

			SetAction = var_26_3

			var_26_3(var_26_5, "action1")

			SetActionCallback = var_26_3

			var_26_3(var_26_5, function(arg_28_0)
				if arg_28_0 == "finish" and var_26_0 == 0 then
					local var_28_0 = arg_4_0

					var_1.finishGame(var_28_0, 0)
				end

				return
			end)

			onButton = var_26_3

			local var_26_6 = arg_4_0
			local var_26_7 = arg_4_0.rtGame
			local var_26_8 = var_6.Find(var_26_7, "btn")

			local function var_26_9()
				Time = var_3_10000

				if var_3_10000.realtimeSinceStartup - var_26_1 < 1 then
					var_26_0 = var_26_0 - 1

					if var_26_0 > 0 then
						-- block empty
					else
						setButtonEnabled = var_1

						local var_29_0 = arg_4_0.rtGame

						var_1(var_2.Find(var_29_0, "btn"), false)

						SetAction = var_1

						var_1(var_26_5, "action2")
					end
				else
					var_26_0 = 4
				end

				var_26_1 = var_0

				return
			end

			SFX_PANEL = var_8

			var_26_3(var_26_6, var_26_8, var_26_9, var_8)

			return
		end,
		Qgame5 = function()
			local var_30_0 = 10
			local var_30_1 = 3
			local var_30_2 = 30
			local var_30_3 = 60

			setLocalEulerAngles = var_2_10004

			local var_30_4 = arg_4_0.rtGame

			var_2_10004(var_5.Find(var_30_4, "hitter/hit_prefect"), {
				z = var_30_2 / 2
			})

			local var_30_5 = arg_4_0.rtGame
			local var_30_6 = var_4.Find(var_30_5, "hitter/hit_prefect")
			local var_30_7 = var_4.GetComponent

			typeof = var_6
			Image = var_7

			local var_30_8 = var_30_7(var_30_6, var_6(var_7))

			var_30_8.fillAmount = var_30_2 / 360
			setLocalEulerAngles = var_30_8

			local var_30_9 = arg_4_0.rtGame

			var_30_8(var_5.Find(var_30_9, "hitter/hit_good"), {
				z = var_30_3 / 2
			})

			local var_30_10 = arg_4_0.rtGame
			local var_30_11 = var_4.Find(var_30_10, "hitter/hit_good")
			local var_30_12 = var_4.GetComponent

			typeof = var_6
			Image = var_7
			var_30_12(var_30_11, var_6(var_7)).fillAmount = var_30_3 / 360

			local var_30_13 = arg_4_0.rtGame
			local var_30_14 = var_4.Find(var_30_13, "char")
			local var_30_15 = var_4.GetChild

			math = var_7

			local var_30_16 = var_30_15(var_30_14, var_7.random(var_4.childCount) - 1)

			eachChild = var_30_14

			var_30_14(var_4, function(arg_31_0)
				setActive = var_3_10001

				var_3_10001(arg_31_0, arg_31_0 == var_30_16)

				return
			end)

			SetAction = var_30_14

			var_30_14(var_30_16, "kaorouaction1")

			local var_30_17 = 3
			local var_30_18 = {
				[0] = 0
			}

			for iter_30_0 = 1, var_30_17 do
				table = var_2_10012

				var_2_10012.insert(var_30_18, var_30_18[iter_30_0 - 1] + var_30_0 / 3 - 0.1)
			end

			local var_30_19 = arg_4_0.rtGame
			local var_30_20 = var_8.Find(var_30_19, "Slider")
			local var_30_21 = var_8.Find(var_30_20, "content").rect.width

			UIItemList = var_11

			local var_30_22 = var_11.New(var_9, var_9:Find("mark"))

			var_11.make(var_30_22, function(arg_32_0, arg_32_1, arg_32_2)
				arg_32_1 = arg_32_1 + 1
				UIItemList = var_3_10003

				if arg_32_0 == var_3_10003.EventUpdate then
					arg_32_2.name = arg_32_1
					setAnchoredPosition = var_3

					var_3(arg_32_2, {
						x = var_30_21 * var_30_18[arg_32_1] / var_30_0
					})
				end

				return
			end)
			var_11:align(#var_30_18)

			local var_30_23 = 0
			local var_30_24
			local var_30_25

			LeanTween = var_15

			local var_30_26 = var_15.value

			go = var_2_10016

			local var_30_27 = var_30_26(var_2_10016(var_30_16), 0, var_30_0, var_30_0)
			local var_30_28 = var_15.setOnUpdate

			System = var_17

			local var_30_29 = var_30_28(var_30_27, var_17.Action_float(function(arg_33_0)
				setSlider = var_3_10001

				var_3_10001(var_0, 0, var_30_0, arg_33_0)

				if var_30_18[1] and var_30_18[1] <= arg_33_0 then
					table = var_1

					var_1.remove(var_30_18, 1)

					LeanTween = var_1

					var_1.pause(var_30_24)

					local function var_33_0(arg_34_0)
						if var_30_25 then
							LeanTween = var_1

							var_1.cancel(var_30_25)

							var_30_25 = nil
						end

						setActive = var_1

						local var_34_0 = arg_4_0.rtGame

						var_1(var_2.Find(var_34_0, "hitter"), false)

						setActive = var_1

						local var_34_1 = arg_4_0.rtGame

						var_1(var_2.Find(var_34_1, "click"), false)

						var_30_23 = var_30_23 + arg_34_0
						LeanTween = var_1

						var_1.resume(var_30_24)

						return
					end

					setActive = var_2

					local var_33_1 = arg_4_0.rtGame

					var_2(var_3.Find(var_33_1, "hitter"), true)

					local var_33_2 = arg_4_0.rtGame
					local var_33_3 = var_2.Find(var_33_2, "hitter/pointer")

					LeanTween = var_33_2

					local var_33_4 = var_33_2.value

					go = var_4

					local var_33_5 = var_33_4(var_4(var_33_3), 73.44, -73.44, var_30_1)
					local var_33_6 = var_3.setOnUpdate

					System = var_5

					local var_33_7 = var_33_6(var_33_5, var_5.Action_float(function(arg_35_0)
						setLocalEulerAngles = var_4_10001

						var_4_10001(var_33_3, {
							z = arg_35_0
						})

						return
					end))
					local var_33_8 = var_3.setOnComplete

					System = var_5
					var_30_25 = var_33_8(var_33_7, var_5.Action(function()
						var_33_0(0)

						return
					end)).uniqueId
					setActive = var_3

					local var_33_9 = arg_4_0.rtGame

					var_3(var_4.Find(var_33_9, "click"), true)

					onButton = var_3

					local var_33_10 = arg_4_0
					local var_33_11 = arg_4_0.rtGame
					local var_33_12 = var_5.Find(var_33_11, "click")

					local function var_33_13()
						math = var_4_10000

						local var_37_0 = var_4_10000.min

						math = var_4_10001

						local var_37_1 = var_4_10001.abs(var_33_3.localEulerAngles.z)

						math = var_2

						if var_37_0(var_37_1, var_2.abs(var_33_3.localEulerAngles.z - 360)) > var_30_3 / 2 then
							var_33_0(0)
						elseif var_0 > var_30_2 / 2 then
							var_33_0(1)
						else
							var_33_0(2)
						end

						return
					end

					SFX_PANEL = var_7

					var_3(var_33_10, var_33_12, var_33_13, var_7)
				end

				return
			end))
			local var_30_30 = var_15.setOnComplete

			System = var_17
			var_30_24 = var_30_30(var_30_29, var_17.Action(function()
				math = var_3_10000

				local var_38_0 = 2 * var_3_10000.floor(var_30_23 / (var_30_17 + var_30_17)) + (var_30_23 % (var_30_17 + var_30_17) > 0 and 1 or 0)

				SetAction = var_1

				var_1(var_30_16, "kaorouaction" .. 4 - var_38_0, false)

				SetActionCallback = var_1

				var_1(var_30_16, function(arg_39_0)
					if arg_39_0 == "finish" then
						local var_39_0 = arg_4_0

						var_1.finishGame(var_39_0, var_38_0)
					end

					return
				end)

				return
			end)).uniqueId
			setActive = var_15

			local var_30_31 = arg_4_0.rtGame

			var_15(var_16.Find(var_30_31, "hitter"), false)

			setActive = var_15

			local var_30_32 = arg_4_0.rtGame

			var_15(var_16.Find(var_30_32, "click"), false)

			return
		end
	})

	return
end

function var_0_1.finishGame(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0
	local var_40_1 = arg_40_0.emit

	IslandQTEMiniGameMediator = var_1_10004

	var_40_1(var_40_0, var_1_10004.GAME_FINISH, arg_40_1 or 0)
	arg_40_0:closeView()

	return
end

function var_0_1.onBackPressed(arg_41_0)
	return
end

function var_0_1.willExit(arg_42_0)
	pg = var_1_10001

	local var_42_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_42_0, arg_42_0._tf)

	if arg_42_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_42_0.handle)

		arg_42_0.handle = nil
	end

	return
end

return var_0_1
