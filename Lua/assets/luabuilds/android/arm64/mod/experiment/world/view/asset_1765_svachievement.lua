local SVAchievement = class("SVAchievement", import("view.base.BaseSubView"))

SVAchievement.HideView = "SVAchievement.HideView"

function SVAchievement:getUIName()
	return "SVAchievement"
end

function SVAchievement:OnLoaded()
	return
end

function SVAchievement:OnInit()
	local var_3_0 = self._tf:Find("display")

	var_3_0.localScale = Vector3.New(self._tf.rect.width / var_3_0.rect.width, self._tf.rect.width / var_3_0.rect.width, 0)
	self.rtDesc = var_3_0:Find("desc")
	self.rtStar = self.rtDesc:Find("star")

	onButton(self, self._tf, function()
		if self.isClosing then
			return
		end

		self:Hide()

		return
	end, SFX_CANCEL)

	return
end

function SVAchievement:OnDestroy()
	return
end

function SVAchievement:Show()
	setAnchoredPosition(self.rtStar, Vector2.New(100, 0))
	setActive(self.rtStar:Find("SVAstar"), false)
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)
	setActive(self._tf, true)

	return
end

function SVAchievement:Hide()
	self.isClosing = true

	local var_7_0 = self.rtDesc:InverseTransformPoint(self.starWorldPos)
	local var_7_1 = {}

	table.insert(var_7_1, function(arg_8_0)
		setActive(self.rtStar:Find("SVAstar"), true)
		LeanTween.moveLocal(go(self.rtStar), Vector3.New(var_7_0.x, var_7_0.y, 0), 0.5):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(arg_8_0))

		return
	end)
	table.insert(var_7_1, function(arg_9_0)
		Timer.New(arg_9_0, 1.1):Start()

		return
	end)
	seriesAsync(var_7_1, function()
		self.isClosing = false

		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
		setActive(self._tf, false)
		self:emit(SVAchievement.HideView)

		return
	end)

	return
end

function SVAchievement:Setup(arg_11_1, arg_11_2)
	setText(self.rtDesc, arg_11_1.config.target_desc)

	self.starWorldPos = arg_11_2

	return
end

return SVAchievement
