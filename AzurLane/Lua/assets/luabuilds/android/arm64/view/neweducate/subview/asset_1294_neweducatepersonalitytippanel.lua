class = var_0_10000

local var_0_0 = "NewEducatePersonalityTipPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducatePersonalityTipPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10004
	Animation = var_1_10006
	arg_2_0.animCom = var_2_1(var_2_0, var_1_10004(var_1_10006))

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_2_0.animEvent = var_2_3(var_2_2, var_4(var_1_10006))

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

	underscore = var_1_10002

	local var_3_2 = var_1_10002.detect(var_3_1, function(arg_4_0)
		return arg_4_0[1] == "tag1"
	end)[2]

	LoadImageSpriteAsync = var_3_0

	local var_3_3 = "neweducateicon/" .. var_3_2
	local var_3_4 = arg_3_0.personalityTF

	var_3_0(var_3_3, var_6.Find(var_3_4, "tag1"), true)

	underscore = var_3_0

	local var_3_5 = var_3_0.detect(var_3_1, function(arg_5_0)
		return arg_5_0[1] == "tag2"
	end)[2]

	LoadImageSpriteAsync = var_4

	local var_3_6 = "neweducateicon/" .. var_3_5
	local var_3_7 = arg_3_0.personalityTF

	var_4(var_3_6, var_7.Find(var_3_7, "tag2"), true)

	return
end

function var_0_1.FlushPersonality(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:Show()

	if arg_6_1 > 0 then
		local var_6_0 = arg_6_0.personalityTF
		local var_6_2

		if not var_3.Find(var_6_0, "tag2") then
			local var_6_1 = arg_6_0.personalityTF

			var_6_2 = var_3.Find(var_6_1, "tag1")
		end

		seriesAsync = var_1_10004

		var_1_10004({
			function(arg_7_0)
				local var_7_0 = arg_6_1

				if 0 < var_7_0 then
					local var_7_1 = arg_6_0.contextData.char
					local var_7_3

					if not var_1.GetPersonalityTagTip(var_7_1, 2) then
						local var_7_2 = arg_6_0.contextData.char

						var_7_3 = var_1.GetPersonalityTagTip(var_7_2, 1)
					end

					setText = var_2

					local var_7_4 = var_6_2
					local var_7_5 = var_4.Find(var_7_4, "Text")
					local var_7_6 = var_7_3
					local var_7_7 = "+"

					math = var_7

					var_2(var_7_5, var_7_6 .. var_7_7 .. var_7.abs(arg_6_1))

					setActive = var_2

					var_2(var_6_2, true)

					local var_7_8 = arg_6_0.animEvent

					var_2.SetEndEvent(var_7_8, function()
						local var_8_0 = arg_6_0.animEvent

						var_0.SetEndEvent(var_8_0, nil)
						arg_7_0()

						return
					end)

					local var_7_9 = arg_6_0.animCom

					var_2.Play(var_7_9, "Anim_educate_personality_show")

					return
				end
			end,
			function(arg_9_0)
				local var_9_0 = arg_6_0.contextData.char

				if var_1.GetPersonalityTag(var_9_0) ~= arg_6_2 then
					setActive = var_2

					local var_9_1 = arg_6_0.personalityTF

					var_2(var_4.Find(var_9_1, "tag1"), true)

					setText = var_2

					local var_9_2 = arg_6_0.personalityTF
					local var_9_3 = var_4.Find(var_9_2, "tag1/Text")

					i18n = var_5

					var_2(var_9_3, var_5("child2_personal_change"))

					setActive = var_2

					local var_9_4 = arg_6_0.personalityTF

					var_2(var_4.Find(var_9_4, "tag2"), true)

					setText = var_2

					local var_9_5 = arg_6_0.personalityTF
					local var_9_6 = var_4.Find(var_9_5, "tag2/Text")

					i18n = var_5

					var_2(var_9_6, var_5("child2_personal_change"))

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
