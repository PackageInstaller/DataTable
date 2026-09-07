local LinerPassTimePage = class("LinerPassTimePage", import("view.base.BaseSubView"))

LinerPassTimePage.ANIM_TIME = 0.75
LinerPassTimePage.DELAY_TIME = 0.5

function LinerPassTimePage:getUIName()
	return "LinerPassTimePage"
end

function LinerPassTimePage:OnLoaded()
	self.rotateTF = self._tf:Find("progress/Image")
	self.dayTF = self._tf:Find("time/day")

	setText(self.dayTF, "DAY")

	self.beforeDay = self._tf:Find("time/day_1")
	self.afterDay = self._tf:Find("time/day_2")
	self.pointTF = self._tf:Find("time/point")
	self.pointAfterTF = self._tf:Find("time/point_after")
	self.timeAnim = self._tf:Find("time"):GetComponent(typeof(Animation))
	self.anim = self._tf:GetComponent(typeof(Animation))
	self.animEvent = self._tf:GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:Hide()

		return
	end)

	return
end

function LinerPassTimePage:OnInit()
	return
end

function LinerPassTimePage:ShowAnim(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_1:GetDayByIdx(arg_5_3)
	local var_5_1 = arg_5_1:GetTimeByIdx(arg_5_2)
	local var_5_2 = arg_5_1:GetTimeByIdx(arg_5_3)
	local var_5_3

	if var_5_1:GetType() == LinerTime.TYPE.STORY then
		var_5_3 = var_5_0 - 1 or var_5_0
	end

	setText(self.beforeDay, string.format("%02d", var_5_3))
	setText(self.afterDay, string.format("%02d", var_5_3))
	setText(self.pointTF, var_5_1:GetStartTimeDesc())
	setText(self.pointAfterTF, var_5_1:GetStartTimeDesc())

	local var_5_4 = var_5_1:GetTime()[1]
	local var_5_5 = var_5_2:GetTime()[1]
	local var_5_6 = var_5_3 == var_5_0 and "anim_passtime_change" or "anim_passtime_change1"
	local var_5_7 = math.floor(((var_5_4 > 3 and var_5_4 or var_5_4 + 24) - 8) * 180 / 19)
	local var_5_8 = math.floor(((var_5_5 > 3 and var_5_5 or var_5_5 + 24) - 8) * 180 / 19)

	setLocalEulerAngles(self.rotateTF, {
		z = -var_5_7
	})
	self:Show()
	seriesAsync({
		function(arg_6_0)
			self:managedTween(LeanTween.delayedCall, function()
				arg_6_0()

				return
			end, 0.4, nil)

			return
		end,
		function(arg_8_0)
			if var_5_7 > var_5_8 then
				self:managedTween(LeanTween.delayedCall, function()
					setLocalEulerAngles(self.rotateTF, {
						z = -var_5_8
					})
					arg_8_0()
					setText(self.afterDay, string.format("%02d", var_5_0))
					setText(self.pointAfterTF, var_5_2:GetStartTimeDesc())
					self.timeAnim:Play(var_5_6)

					return
				end, LinerPassTimePage.ANIM_TIME, nil)
			else
				self:managedTween(LeanTween.value, nil, go(self.rotateTF), var_5_7, var_5_8, LinerPassTimePage.ANIM_TIME):setOnUpdate(System.Action_float(function(arg_10_0)
					setLocalEulerAngles(self.rotateTF, {
						z = -arg_10_0
					})

					return
				end)):setEase(LeanTweenType.easeInOutCubic):setOnComplete(System.Action(function()
					arg_8_0()

					return
				end))
				setText(self.afterDay, string.format("%02d", var_5_0))
				setText(self.pointAfterTF, var_5_2:GetStartTimeDesc())
				self.timeAnim:Play(var_5_6)
			end

			return
		end,
		function(arg_12_0)
			self:managedTween(LeanTween.delayedCall, function()
				arg_12_0()

				return
			end, LinerPassTimePage.DELAY_TIME, nil)

			return
		end
	}, function()
		if arg_5_4 then
			arg_5_4()
		end

		self.anim:Play("anim_passtime_out")

		return
	end)

	return
end

function LinerPassTimePage:Show()
	LinerPassTimePage.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function LinerPassTimePage:Hide()
	LinerPassTimePage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function LinerPassTimePage:OnDestroy()
	return
end

return LinerPassTimePage
