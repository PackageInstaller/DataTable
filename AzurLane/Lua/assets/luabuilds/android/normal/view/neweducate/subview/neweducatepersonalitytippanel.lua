class = var_0_10000

local var_0_0 = "NewEducatePersonalityTipPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducatePersonalityTipPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10003
	Animation = var_1_10004
	arg_2_0.animCom = var_2_1(var_2_0, var_1_10003(var_1_10004))

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.animEvent = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf

	arg_2_0.personalityTF = var_1.Find(var_2_4, "personality")

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0:OverlayPanel(arg_3_0._tf, {
		groupDelta = 2,
		pbList = {
			arg_3_0.resTF
		}
	})

	local var_3_0 = arg_3_0.contextData.char
	local var_3_1 = var_1.getConfig(var_3_0, "personality_tag_icon")

	underscore = var_3_0

	local var_3_2 = var_3_0.detect(var_3_1, function(arg_4_0)
		return arg_4_0[1] == "tag1"
	end)[2]

	LoadImageSpriteAsync = var_3

	local var_3_3 = "neweducateicon/" .. var_3_2
	local var_3_4 = arg_3_0.personalityTF

	var_3(var_3_3, var_5.Find(var_3_4, "tag1"), true)

	underscore = var_3

	local var_3_5 = var_3.detect(var_3_1, function(arg_5_0)
		return arg_5_0[1] == "tag2"
	end)[2]

	LoadImageSpriteAsync = var_4

	local var_3_6 = "neweducateicon/" .. var_3_5
	local var_3_7 = arg_3_0.personalityTF

	var_4(var_3_6, var_6.Find(var_3_7, "tag2"), true)

	return
end

function var_0_1.FlushPersonality(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0

	arg_6_0.Show(var_6_0)

	if arg_6_1 > 0 then
		var_6_0 = arg_6_0.personalityTF

		local var_6_1

		if not var_3.Find(var_6_0, "tag2") then
			var_6_0 = arg_6_0.personalityTF
			var_6_1 = var_3.Find(var_6_0, "tag1")
		end

		seriesAsync = var_6_0

		var_6_0({
			function(arg_7_0)
				local var_7_0 = arg_6_1

				if 0 < var_7_0 then
					local var_7_1 = arg_6_0.contextData.char
					local var_7_2

					if not var_1.GetPersonalityTagTip(var_7_1, 2) then
						var_7_1 = arg_6_0.contextData.char
						var_7_2 = var_1.GetPersonalityTagTip(var_7_1, 1)
					end

					setText = var_7_1

					local var_7_3 = var_6_1
					local var_7_4 = var_3.Find(var_7_3, "Text")
					local var_7_5 = var_7_2
					local var_7_6 = "+"

					math = var_2_10006

					var_7_1(var_7_4, var_7_5 .. var_7_6 .. var_2_10006.abs(arg_6_1))

					setActive = var_7_1

					var_7_1(var_6_1, true)

					local var_7_7 = arg_6_0.animEvent

					var_2.SetEndEvent(var_7_7, function()
						local var_8_0 = arg_6_0.animEvent

						var_0.SetEndEvent(var_8_0, nil)
						arg_7_0()

						return
					end)

					local var_7_8 = arg_6_0.animCom

					var_2.Play(var_7_8, "Anim_educate_personality_show")

					return
				end
			end,
			function(arg_9_0)
				local var_9_0 = arg_6_0.contextData.char

				if var_1.GetPersonalityTag(var_9_0) ~= arg_6_2 then
					setActive = var_2

					local var_9_1 = arg_6_0.personalityTF

					var_2(var_3.Find(var_9_1, "tag1"), true)

					setText = var_2

					local var_9_2 = arg_6_0.personalityTF
					local var_9_3 = var_3.Find(var_9_2, "tag1/Text")

					i18n = var_9_2

					var_2(var_9_3, var_9_2("child2_personal_change"))

					setActive = var_2

					local var_9_4 = arg_6_0.personalityTF

					var_2(var_3.Find(var_9_4, "tag2"), true)

					setText = var_2

					local var_9_5 = arg_6_0.personalityTF
					local var_9_6 = var_3.Find(var_9_5, "tag2/Text")

					i18n = var_9_5

					var_2(var_9_6, var_9_5("child2_personal_change"))

					local var_9_7 = arg_6_0.animEvent

					var_2.SetEndEvent(var_9_7, function()
						local var_10_0 = arg_6_0.animEvent

						var_0.SetEndEvent(var_10_0, nil)
						arg_9_0()

						return
					end)

					local var_9_8 = var_1 == "tag1" and "Anim_educate_personality_2to1" or "Anim_educate_personality_1to2"
					local var_9_9 = arg_6_0.animCom

					var_3.Play(var_9_9, var_9_8)
				else
					arg_9_0()
				end

				return
			end
		}, function()
			local var_11_0 = arg_6_0

			var_0.Hide(var_11_0)

			return
		end)

		return
	end
end

function var_0_1.OnDestroy(arg_12_0)
	arg_12_0:UnOverlayPanel(arg_12_0._tf)

	return
end

return var_0_1
