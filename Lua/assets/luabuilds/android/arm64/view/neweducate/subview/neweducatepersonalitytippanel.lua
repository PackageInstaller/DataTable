local var_0_0 = class("NewEducatePersonalityTipPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "NewEducatePersonalityTipPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.animCom = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.animEvent = arg_2_0._tf:GetComponent(typeof(DftAniEvent))
	arg_2_0.personalityTF = arg_2_0._tf:Find("personality")

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0:OverlayPanel(arg_3_0._tf, {
		groupDelta = 2,
		pbList = {
			arg_3_0.resTF
		}
	})

	local var_3_0 = arg_3_0.contextData.char:getConfig("personality_tag_icon")

	LoadImageSpriteAsync("neweducateicon/" .. underscore.detect(var_3_0, function(arg_4_0)
		return arg_4_0[1] == "tag1"
	end)[2], arg_3_0.personalityTF:Find("tag1"), true)
	LoadImageSpriteAsync("neweducateicon/" .. underscore.detect(var_3_0, function(arg_5_0)
		return arg_5_0[1] == "tag2"
	end)[2], arg_3_0.personalityTF:Find("tag2"), true)

	return
end

function var_0_0.FlushPersonality(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:Show()

	local var_6_0

	if arg_6_1 <= 0 or not arg_6_0.personalityTF:Find("tag2") then
		var_6_0 = arg_6_0.personalityTF:Find("tag1")
	end

	seriesAsync({
		function(arg_7_0)
			if arg_6_1 > 0 then
				local var_7_0 = arg_6_0.contextData.char:GetPersonalityTagTip(2) or arg_6_0.contextData.char:GetPersonalityTagTip(1)

				setText(var_6_0:Find("Text"), var_7_0 .. "+" .. math.abs(arg_6_1))
				setActive(var_6_0, true)
				arg_6_0.animEvent:SetEndEvent(function()
					arg_6_0.animEvent:SetEndEvent(nil)
					arg_7_0()

					return
				end)
				arg_6_0.animCom:Play("Anim_educate_personality_show")

				return
			end
		end,
		function(arg_9_0)
			local var_9_0 = arg_6_0.contextData.char:GetPersonalityTag()

			if var_9_0 ~= arg_6_2 then
				setActive(arg_6_0.personalityTF:Find("tag1"), true)
				setText(arg_6_0.personalityTF:Find("tag1/Text"), i18n("child2_personal_change"))
				setActive(arg_6_0.personalityTF:Find("tag2"), true)
				setText(arg_6_0.personalityTF:Find("tag2/Text"), i18n("child2_personal_change"))
				arg_6_0.animEvent:SetEndEvent(function()
					arg_6_0.animEvent:SetEndEvent(nil)
					arg_9_0()

					return
				end)
				arg_6_0.animCom:Play(var_9_0 == "tag1" and "Anim_educate_personality_2to1" or "Anim_educate_personality_1to2")
			else
				arg_9_0()
			end

			return
		end
	}, function()
		arg_6_0:Hide()

		return
	end)

	return
end

function var_0_0.OnDestroy(arg_12_0)
	arg_12_0:UnOverlayPanel(arg_12_0._tf)

	return
end

return var_0_0
