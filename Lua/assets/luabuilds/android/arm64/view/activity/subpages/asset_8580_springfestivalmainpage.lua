local SpringFestivalMainPage = class("SpringFestivalMainPage", import(".TemplatePage.PreviewTemplatePage"))
local var_0_1 = {
	2,
	3,
	4,
	8,
	9,
	10,
	14,
	15,
	17,
	18
}
local var_0_2 = 1
local var_0_3 = 3.5

function SpringFestivalMainPage:OnInit()
	SpringFestivalMainPage.super.OnInit(self)

	self.rtPrint = self._tf:Find("AD/print")
	self.prints = {
		self.rtPrint:Find("front"),
		self.rtPrint:Find("back")
	}

	return
end

function SpringFestivalMainPage:OnFirstFlush()
	SpringFestivalMainPage.super.OnFirstFlush(self)
	onButton(self, self.btnList:Find("mountain"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SPRING_FESTIVAL_BACKHILL_2023)

		return
	end, SFX_PANEL)

	self.printCount = 0

	setImageAlpha(self.prints[1], 0)
	setImageAlpha(self.prints[2], 0)

	return
end

function SpringFestivalMainPage:OnUpdateFlush()
	if self.LT then
		for iter_4_0, iter_4_1 in ipairs(self.LT) do
			LeanTween.resume(iter_4_1)
		end
	else
		self.tempImg = nil

		local var_4_0 = true

		local function var_4_2()
			self.LT = {}

			parallelAsync({
				function(arg_6_0)
					self.printCount = self.printCount % #var_0_1 + 1

					LoadSpriteAtlasAsync("clutter/springfestivalmainpage_" .. var_0_1[self.printCount], nil, function(arg_7_0)
						if IsNil(self.rtPrint) then
							return
						else
							self.tempImg = arg_7_0

							arg_6_0()
						end

						return
					end)

					return
				end,
				function(arg_8_0)
					table.insert(self.LT, LeanTween.alpha(self.prints[1], 0, var_0_2):setOnComplete(System.Action(arg_8_0)):setDelay(var_4_0 and 0 or var_0_3).uniqueId)

					return
				end,
				function(arg_9_0)
					table.insert(self.LT, LeanTween.alpha(self.prints[2], 1, var_0_2):setOnComplete(System.Action(arg_9_0)):setDelay(var_4_0 and 0 or var_0_3).uniqueId)

					return
				end
			}, function()
				var_4_0 = false
				self.prints[2], self.prints[1] = self.prints[1], self.prints[2]

				setImageSprite(self.prints[2], self.tempImg, true)
				var_4_2()

				return
			end)

			return
		end

		seriesAsync({
			function(arg_11_0)
				self.printCount = self.printCount % #var_0_1 + 1

				LoadSpriteAtlasAsync("clutter/springfestivalmainpage_" .. var_0_1[self.printCount], nil, function(arg_12_0)
					if IsNil(self.rtPrint) then
						return
					else
						setImageSprite(self.prints[2], arg_12_0, true)
						arg_11_0()
					end

					return
				end)

				return
			end
		}, nil)
	end

	return
end

function SpringFestivalMainPage:OnHideFlush()
	if self.LT then
		for iter_13_0, iter_13_1 in ipairs(self.LT) do
			LeanTween.pause(iter_13_1)
		end
	end

	return
end

function SpringFestivalMainPage:OnDestroy()
	if self.LT then
		for iter_14_0, iter_14_1 in ipairs(self.LT) do
			LeanTween.cancel(iter_14_1)
		end
	end

	return
end

return SpringFestivalMainPage
