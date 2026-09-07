local SenrankaguraMainPage = class("SenrankaguraMainPage", import(".TemplatePage.PreviewTemplatePage"))

SenrankaguraMainPage.SWITCH_INTERVAL = 6
SenrankaguraMainPage.SWITCH_TIME = 0.5
SenrankaguraMainPage.SWITCH_WIDTH = 367
SenrankaguraMainPage.TACHIE_DELAY = 0.03

function SenrankaguraMainPage:OnInit()
	self.bg = self._tf:Find("AD/mask")
	self.btnList = self.bg:Find("btn_list")
	self.main = self.bg:Find("main")
	self.totalNum = self.main.childCount
	self.randomList = {}
	self.children = {}

	for iter_1_0 = 1, self.totalNum do
		local var_1_0 = self.main:GetChild(iter_1_0 - 1)

		table.insert(self.children, var_1_0)
		setActive(var_1_0, false)

		if PLATFORM_CODE ~= PLATFORM_CH then
			local var_1_1 = findTF(var_1_0, "hx")

			if var_1_1 then
				setActive(var_1_1, false)
			end
		end
	end

	return
end

function SenrankaguraMainPage:OnFirstFlush()
	SenrankaguraMainPage.super.OnFirstFlush(self)
	onButton(self, self.btnList:Find("mountain"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SENRANKAGURA_BACKHILL)

		return
	end, SFX_PANEL)

	for iter_2_0 = 1, self.totalNum do
		table.insert(self.randomList, iter_2_0)
	end

	shuffle(self.randomList)

	self.index = 1

	setActive(self.children[self.randomList[self.index]], true)

	self.LTList = {}

	function self.Interval()
		table.insert(self.LTList, LeanTween.delayedCall(go(self._tf), SenrankaguraMainPage.SWITCH_INTERVAL, System.Action(self.FadeIn)).uniqueId)

		return
	end

	function self.FadeIn()
		self.index = self.index % self.totalNum + 1

		local var_5_0 = SenrankaguraMainPage.SWITCH_WIDTH

		setActive(self.children[self.randomList[self.index]], true)

		local var_5_1 = {
			0,
			SenrankaguraMainPage.TACHIE_DELAY,
			SenrankaguraMainPage.TACHIE_DELAY
		}

		table.insert(self.LTList, LeanTween.delayedCall(go(self._tf), SenrankaguraMainPage.SWITCH_TIME + SenrankaguraMainPage.TACHIE_DELAY, System.Action(self.Interval)).uniqueId)
		table.Foreach({
			findTF(self.children[self.randomList[self.index]], "bg"),
			findTF(self.children[self.randomList[self.index]], "tachie"),
			findTF(self.children[self.randomList[self.index]], "hx")
		}, function(arg_6_0, arg_6_1)
			setImageAlpha(arg_6_1, 0)

			local var_6_0 = rtf(arg_6_1).anchoredPosition.x

			setAnchoredPosition(arg_6_1, {
				x = var_5_0 + var_6_0
			})

			local function var_6_1()
				table.insert(self.LTList, LeanTween.alpha(arg_6_1, 1, SenrankaguraMainPage.SWITCH_TIME):setEase(LeanTweenType.easeOutSine).uniqueId)
				table.insert(self.LTList, LeanTween.moveX(rtf(arg_6_1), 0 + var_6_0, SenrankaguraMainPage.SWITCH_TIME):setEase(LeanTweenType.easeOutSine).uniqueId)

				return
			end

			if var_5_1[arg_6_0] > 0 then
				table.insert(self.LTList, LeanTween.delayedCall(go(arg_6_1), var_5_1[arg_6_0], System.Action(var_6_1)).uniqueId)
			else
				var_6_1()
			end

			return
		end)
		table.Foreach({
			findTF(self.children[self.randomList[self.index]], "bg"),
			findTF(self.children[self.randomList[self.index]], "tachie"),
			findTF(self.children[self.randomList[self.index]], "hx")
		}, function(arg_8_0, arg_8_1)
			local var_8_0 = rtf(arg_8_1).anchoredPosition.x

			local function var_8_1()
				setAnchoredPosition(arg_8_1, {
					x = var_8_0
				})

				return
			end

			local function var_8_2()
				table.insert(self.LTList, LeanTween.alpha(arg_8_1, 0, SenrankaguraMainPage.SWITCH_TIME):setEase(LeanTweenType.easeOutSine).uniqueId)
				table.insert(self.LTList, LeanTween.moveX(rtf(arg_8_1), -var_5_0 + var_8_0, SenrankaguraMainPage.SWITCH_TIME):setOnComplete(System.Action(var_8_1)):setEase(LeanTweenType.easeOutSine).uniqueId)

				return
			end

			if var_5_1[arg_8_0] > 0 then
				table.insert(self.LTList, LeanTween.delayedCall(go(arg_8_1), var_5_1[arg_8_0], System.Action(var_8_2)).uniqueId)
			else
				var_8_2()
			end

			return
		end)

		return
	end

	self.Interval()

	return
end

function SenrankaguraMainPage:OnDestroy()
	for iter_11_0, iter_11_1 in ipairs(self.LTList or {}) do
		LeanTween.cancel(iter_11_1)
	end

	return
end

return SenrankaguraMainPage
