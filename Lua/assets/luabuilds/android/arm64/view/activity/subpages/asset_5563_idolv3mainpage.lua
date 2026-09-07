local IdolV3MainPage = class("IdolV3MainPage", import(".TemplatePage.PreviewTemplatePage"))
local var_0_1 = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6"
}
local var_0_2 = 2
local var_0_3 = 0.4

function IdolV3MainPage:OnInit()
	IdolV3MainPage.super.OnInit(self)

	self.paintTF = self.bg:Find("Image")

	return
end

function IdolV3MainPage:OnUpdateFlush()
	self.timer = Timer.New(function()
		self:ShowNextPainting()

		return
	end, var_0_2 + var_0_3, -1)

	self.timer:Start()

	return
end

function IdolV3MainPage:ShowNextPainting()
	self.curIndex = self.curIndex or 1
	self.curIndex = self.curIndex + 1

	if self.curIndex > #var_0_1 then
		self.curIndex = 1
	end

	local var_4_0 = var_0_1[self.curIndex]

	seriesAsync({
		function(arg_5_0)
			self:managedTween(LeanTween.value, nil, go(self.paintTF), 1, 0, var_0_3 / 2):setOnUpdate(System.Action_float(function(arg_6_0)
				GetOrAddComponent(self.paintTF, typeof(CanvasGroup)).alpha = arg_6_0

				return
			end)):setOnComplete(System.Action(function()
				arg_5_0()

				return
			end))

			return
		end,
		function(arg_8_0)
			GetSpriteFromAtlasAsync("ui/activityuipage/idolv3mainpage_atlas", var_4_0, function(arg_9_0)
				self.paintTF:GetComponent(typeof(Image)).sprite = arg_9_0

				arg_8_0()

				return
			end)

			return
		end,
		function(arg_10_0)
			self:managedTween(LeanTween.value, nil, go(self.paintTF), 0, 1, var_0_3 / 2):setOnUpdate(System.Action_float(function(arg_11_0)
				GetOrAddComponent(self.paintTF, typeof(CanvasGroup)).alpha = arg_11_0

				return
			end)):setOnComplete(System.Action(function()
				arg_10_0()

				return
			end))

			return
		end
	})

	return
end

function IdolV3MainPage:OnHideFlush()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:cleanManagedTween()

	return
end

function IdolV3MainPage:OnDestroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

return IdolV3MainPage
