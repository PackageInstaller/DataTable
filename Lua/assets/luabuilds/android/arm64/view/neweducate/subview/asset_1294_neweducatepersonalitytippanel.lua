local NewEducatePersonalityTipPanel = class("NewEducatePersonalityTipPanel", import("view.base.BaseSubView"))

function NewEducatePersonalityTipPanel:getUIName()
	return "NewEducatePersonalityTipPanel"
end

function NewEducatePersonalityTipPanel:OnLoaded()
	self.animCom = self._tf:GetComponent(typeof(Animation))
	self.animEvent = self._tf:GetComponent(typeof(DftAniEvent))
	self.personalityTF = self._tf:Find("personality")

	return
end

function NewEducatePersonalityTipPanel:OnInit()
	self:OverlayPanel(self._tf, {
		groupDelta = 2,
		pbList = {
			self.resTF
		}
	})

	local var_3_0 = self.contextData.char:getConfig("personality_tag_icon")

	LoadImageSpriteAsync("neweducateicon/" .. underscore.detect(var_3_0, function(arg_4_0)
		return arg_4_0[1] == "tag1"
	end)[2], self.personalityTF:Find("tag1"), true)
	LoadImageSpriteAsync("neweducateicon/" .. underscore.detect(var_3_0, function(arg_5_0)
		return arg_5_0[1] == "tag2"
	end)[2], self.personalityTF:Find("tag2"), true)

	return
end

function NewEducatePersonalityTipPanel:FlushPersonality(arg_6_1, arg_6_2)
	self:Show()

	if arg_6_1 > 0 then
		local var_6_0 = self.personalityTF:Find("tag2") or self.personalityTF:Find("tag1")
	end

	seriesAsync({
		function(arg_7_0)
			setText(var_6_0:Find("Text"), ((arg_6_1 > 0 or nil) and (self.contextData.char:GetPersonalityTagTip(2) or self.contextData.char:GetPersonalityTagTip(1))) .. "+" .. math.abs(arg_6_1))
			setActive(var_6_0, true)
			self.animEvent:SetEndEvent(function()
				self.animEvent:SetEndEvent(nil)
				arg_7_0()

				return
			end)
			self.animCom:Play("Anim_educate_personality_show")

			return
		end,
		function(arg_9_0)
			local var_9_0 = self.contextData.char:GetPersonalityTag()

			if var_9_0 ~= arg_6_2 then
				setActive(self.personalityTF:Find("tag1"), true)
				setText(self.personalityTF:Find("tag1/Text"), i18n("child2_personal_change"))
				setActive(self.personalityTF:Find("tag2"), true)
				setText(self.personalityTF:Find("tag2/Text"), i18n("child2_personal_change"))
				self.animEvent:SetEndEvent(function()
					self.animEvent:SetEndEvent(nil)
					arg_9_0()

					return
				end)
				self.animCom:Play(var_9_0 == "tag1" and "Anim_educate_personality_2to1" or "Anim_educate_personality_1to2")
			else
				arg_9_0()
			end

			return
		end
	}, function()
		self:Hide()

		return
	end)

	return
end

function NewEducatePersonalityTipPanel:OnDestroy()
	self:UnOverlayPanel(self._tf)

	return
end

return NewEducatePersonalityTipPanel
