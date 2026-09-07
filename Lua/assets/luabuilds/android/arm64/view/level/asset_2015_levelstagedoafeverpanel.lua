local LevelStageDOAFeverPanel = class("LevelStageDOAFeverPanel", import("view.base.BaseSubPanel"))

LevelStageDOAFeverPanel.PAINTING_RANGE = {
	1,
	7
}

function LevelStageDOAFeverPanel:getUIName()
	return "LevelStageDOAFeverPanel"
end

function LevelStageDOAFeverPanel:OnInit()
	self.fillImg = self._tf:Find("Fill")
	self.maxImg = self._tf:Find("Max")

	setActive(self.maxImg, false)

	self.ratioText = self._tf:Find("Text")
	self.banner = self._tf:Find("Banner")

	setActive(self.banner, false)

	self.fillAnim = self.fillImg:Find("Anim")

	return
end

function LevelStageDOAFeverPanel:UpdateView(arg_3_1, arg_3_2)
	local var_3_0 = getProxy(ChapterProxy):GetLastDefeatedEnemy(arg_3_1.id)
	local var_3_1 = arg_3_1.defeatEnemies
	local var_3_2 = pg.gameset.doa_fever_count.key_value
	local var_3_3 = arg_3_1.defeatEnemies / pg.gameset.doa_fever_count.key_value
	local var_3_4 = pg.gameset.doa_fever_count.key_value <= arg_3_1.defeatEnemies

	seriesAsync({
		function(arg_4_0)
			LeanTween.cancel(go(self.fillImg), true)

			if not var_3_0 or var_3_1 > var_3_2 then
				arg_4_0()

				return
			end

			setActive(self.maxImg, false)
			setActive(self.fillImg, true)
			setActive(self.ratioText, true)
			setActive(self.fillAnim, true)

			local var_4_0 = math.max(var_3_1 - 1, 0)
			local var_4_1 = self.fillImg:GetComponent(typeof(Image))
			local var_4_2 = self.fillImg.rect.height
			local var_4_3 = self.fillImg.rect.height
			local var_4_4 = self.fillAnim.rect.height
			local var_4_5 = 3.115264797507788

			LeanTween.value(go(self.fillImg), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_5_0)
				local var_5_0 = Mathf.Lerp(var_4_0, var_3_1, arg_5_0) / var_3_2

				self.fillAnim.anchoredPosition = Vector2(0, var_5_0 * var_4_2)
				self.fillAnim.sizeDelta = Vector2(math.sqrt(math.max(var_4_3 * var_4_3 - var_5_0 * var_4_2 * (var_5_0 * var_4_2), 0)) * var_4_5, math.min(1.5 - arg_5_0, 1) * var_4_4)
				var_4_1.fillAmount = var_5_0

				setText(self.ratioText, string.format("%02d.%d%%", math.floor(var_5_0 * 100), math.round(var_5_0 * 1000) % 10))

				return
			end)):setOnComplete(System.Action(arg_4_0))

			return
		end,
		function(arg_6_0)
			setActive(self.fillImg, not var_3_4)
			setActive(self.ratioText, not var_3_4)
			setActive(self.maxImg, var_3_4)
			setActive(self.fillAnim, false)

			self.fillImg:GetComponent(typeof(Image)).fillAmount = var_3_3

			setText(self.ratioText, string.format("%02d.%d%%", math.floor(var_3_3 * 100), math.round(var_3_3 * 1000) % 10))

			if var_3_0 and var_3_1 == var_3_2 then
				self.viewParent:emit(LevelUIConst.FROZEN)
				pg.UIMgr.GetInstance():OverlayPanel(self.banner)

				local var_6_0 = self.banner:Find("Main/Painting")
				local var_6_1 = var_6_0:GetComponent(typeof(Image))

				setImageSprite(var_6_0, LoadSprite("ui/LevelStageDOAFeverPanel_atlas", tostring((math.random(self.PAINTING_RANGE[1], self.PAINTING_RANGE[2])))), true)
				setActive(self.banner, true)

				var_6_1.enabled = true

				local function var_6_2()
					var_6_1.enabled = false
					var_6_1.sprite = nil

					pg.UIMgr.GetInstance():UnOverlayPanel(self.banner, self._tf)
					setActive(self.banner, false)
					self.viewParent:emit(LevelUIConst.UN_FROZEN)
					arg_6_0()

					return
				end

				self.banner:GetComponent(typeof(DftAniEvent)):SetEndEvent(var_6_2)
				onButton(self, self.banner, var_6_2)
			else
				arg_6_0()
			end

			return
		end,
		arg_3_2
	})

	return
end

return LevelStageDOAFeverPanel
