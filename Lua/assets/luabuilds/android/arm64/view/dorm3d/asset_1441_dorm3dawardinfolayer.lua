local Dorm3dAwardInfoLayer = class("Dorm3dAwardInfoLayer", import("view.base.BaseUI"))

function Dorm3dAwardInfoLayer:getUIName()
	return "Dorm3dAwardInfoUI"
end

function Dorm3dAwardInfoLayer:init()
	onButton(self, self._tf:Find("bg"), function()
		if self.inAnimPlaying or self.isCloseAnim then
			return
		end

		self.isCloseAnim = true

		self._tf:GetComponent(typeof(Animation)):Play("anim_educate_awardinfo_award_out")

		return
	end, SFX_CANCEL)
	self._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:closeView()

		return
	end)

	self.tipTF = self._tf:Find("panel/tip")

	setText(self.tipTF, i18n("child_close_tip"))

	self.itemContainer = self._tf:Find("panel/content")

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function Dorm3dAwardInfoLayer:didEnter()
	UIItemList.StaticAlign(self.itemContainer, self.itemContainer:Find("tpl"), #self.contextData.items, function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1

		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = self.contextData.items[arg_6_1]

			updateCustomDrop(arg_6_2, self.contextData.items[arg_6_1])
			onButton(self, arg_6_2, function()
				self:emit(BaseUI.ON_NEW_DROP, {
					style = "dorm",
					drop = var_6_0
				})

				return
			end, SFX_PANEL)
		end

		return
	end)

	self.inAnimPlaying = true

	local var_5_0 = {}

	table.insert(var_5_0, function(arg_8_0)
		self:managedTween(LeanTween.delayedCall, arg_8_0, 0.33, nil)

		return
	end)
	eachChild(self.itemContainer, function(arg_9_0)
		if isActive(arg_9_0) then
			setActive(arg_9_0, false)
			table.insert(var_5_0, function(arg_10_0)
				setActive(arg_9_0, true)
				self:managedTween(LeanTween.delayedCall, arg_10_0, 0.066, nil)

				return
			end)
		end

		return
	end)
	seriesAsync(var_5_0, function()
		self:managedTween(LeanTween.delayedCall, function()
			self.inAnimPlaying = false

			return
		end, 0.066, nil)

		return
	end)
	pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_reward")

	return
end

function Dorm3dAwardInfoLayer:onBackPressed()
	triggerButton(self._tf:Find("bg"))

	return
end

function Dorm3dAwardInfoLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return Dorm3dAwardInfoLayer
