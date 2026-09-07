local CourtYardComfortablePage = class("CourtYardComfortablePage", import("view.base.BaseSubView"))

function CourtYardComfortablePage:getUIName()
	return "CourtYardComfortablePanel"
end

function CourtYardComfortablePage:OnLoaded()
	self.closeBtn = self._tf:Find("frame/close")
	self.subTitleTxt = self._tf:Find("frame/view/subtitle2/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("frame/view/subtitle1/Text"), i18n("backyard_backyardScene_comforChatContent1"))

	self.expressionTxt = self._tf:Find("frame/view/express/Text"):GetComponent(typeof(Text))
	self.comfortableImg = self._tf:Find("frame/view/express/icon"):GetComponent(typeof(Image))
	self.comfortableBg = self._tf:Find("frame/view/express"):GetComponent(typeof(Image))
	self.uiItemList = UIItemList.New(self._tf:Find("frame/view/list/content"), self._tf:Find("frame/view/list/content/tpl"))
	self.animation = self._tf:Find("frame/view"):GetComponent(typeof(Animation))
	self.dftAniEvent = self._tf:Find("frame/view"):GetComponent(typeof(DftAniEvent))
	self.foldBtn = self._tf:Find("frame/view/fold")
	self.arr = self._tf:Find("frame/view/fold/up")
	self.subTitle = self._tf:Find("frame/view/subtitle2")
	self.expAdditionTxt = self._tf:Find("frame/exp/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("frame/exp"), i18n("courtyard_label_comfortable_addition"))
	setText(self._tf:Find("frame/title"), i18n("word_comfort_level"))

	return
end

function CourtYardComfortablePage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	local var_3_0 = false

	onButton(self, self.foldBtn, function()
		var_3_0 = not var_3_0

		if var_3_0 then
			setActive(self.subTitle, true)
		end

		self.dftAniEvent:SetEndEvent(function()
			self.dftAniEvent:SetEndEvent(nil)
			setActive(self.subTitle, false)

			return
		end)
		self.animation:Play(var_3_0 and "anim_courtyard_comfortable_viewin" or "anim_courtyard_comfortable_viewhide")

		return
	end, SFX_PANEL)

	return
end

function CourtYardComfortablePage:Show(arg_8_1)
	CourtYardComfortablePage.super.Show(self)

	self.dorm = arg_8_1

	local var_8_0 = arg_8_1:getComfortable()

	self:FlushSubTitle()
	self:FlushExpression(var_8_0)
	self:FlushList()
	self:FlushAddition(var_8_0)

	return
end

function CourtYardComfortablePage:FlushSubTitle()
	self.subTitleTxt.text = i18n("backyard_backyardScene_comforChatContent2", self.dorm.level - 1)

	return
end

function CourtYardComfortablePage:FlushExpression(arg_10_1)
	local var_10_0 = self.dorm:GetComfortableLevel(arg_10_1)

	self.expressionTxt.text = i18n("backyard_backyardScene_expression_label_" .. var_10_0)

	LoadSpriteAtlasAsync("ui/CourtyardUI_atlas", "express_" .. var_10_0, function(arg_11_0)
		if self.exited then
			return
		end

		self.comfortableImg.sprite = arg_11_0

		self.comfortableImg:SetNativeSize()

		return
	end)

	self.comfortableBg.color = self.dorm:GetComfortableColor(var_10_0)

	return
end

local var_0_1 = {
	i18n("word_wallpaper"),
	i18n("word_furniture"),
	i18n("word_decorate"),
	i18n("word_floorpaper"),
	i18n("word_mat"),
	i18n("word_wall"),
	i18n("word_collection")
}

function CourtYardComfortablePage:FlushList()
	local var_12_0 = self.dorm:getConfig("comfortable_count")

	self.uiItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = arg_13_1 + 1

			LoadSpriteAtlasAsync("ui/CourtyardUI_atlas", "icon_" .. arg_13_1 + 1, function(arg_14_0)
				if self.exited then
					return
				end

				local var_14_0 = arg_13_2:Find("icon"):GetComponent(typeof(Image))

				var_14_0.sprite = arg_14_0

				var_14_0:SetNativeSize()

				return
			end)
			setText(arg_13_2:Find("name"), var_0_1[var_13_0])
			setText(arg_13_2:Find("Text"), "X" .. var_12_0[var_13_0][2])

			local var_13_1 = var_13_0 % 2 ~= 0

			setActive(arg_13_2:Find("line"), var_13_0 % 2 ~= 0)
			setActive(arg_13_2:Find("bg"), var_13_1)
		end

		return
	end)
	self.uiItemList:align(7)

	return
end

function CourtYardComfortablePage:FlushAddition(arg_15_1)
	self.expAdditionTxt.text = string.format("%d", (pg.gameset.dorm_exp_ratio_comfort_degree.key_value + arg_15_1 ~= 0 or nil) and arg_15_1 / (pg.gameset.dorm_exp_ratio_comfort_degree.key_value + arg_15_1) * 100) .. "%"

	return
end

function CourtYardComfortablePage:OnDestroy()
	self.dftAniEvent:SetTriggerEvent(nil)

	self.exited = true

	return
end

return CourtYardComfortablePage
