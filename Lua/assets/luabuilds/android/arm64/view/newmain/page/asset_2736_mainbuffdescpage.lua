local MainBuffDescPage = class("MainBuffDescPage", import("view.base.BaseSubView"))

function MainBuffDescPage:Ctor(arg_1_1, arg_1_2, arg_1_3)
	MainBuffDescPage.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)
	self:bind(NewMainScene.ON_BUFF_DESC, function(arg_2_0, arg_2_1, arg_2_2)
		self:ExecuteAction("Show", arg_2_1, arg_2_2)

		return
	end)

	return
end

function MainBuffDescPage:getUIName()
	return "MainUIBuffDescWindow"
end

function MainBuffDescPage:OnLoaded()
	self.descTxt = self._tf:Find("Text"):GetComponent(typeof(Text))

	return
end

function MainBuffDescPage:Show(arg_5_1, arg_5_2)
	MainBuffDescPage.super.Show(self)
	self:RemoveDescTimer()
	self:AddCloseTimer()
	self:UpdateDesc(arg_5_1)

	self._tf.localPosition = arg_5_2
	self._parentTf = self._tf.parent

	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function MainBuffDescPage:UpdateDesc(arg_6_1)
	if arg_6_1:getConfig("max_time") <= 0 then
		self.descTxt.text = arg_6_1:getConfig("desc")

		return
	end

	self.descTimer = Timer.New(function()
		self:UpdateDescPreSce(arg_6_1)

		return
	end, 1, -1)

	self.descTimer:Start()
	self.descTimer.func()

	return
end

function MainBuffDescPage:UpdateDescPreSce(arg_8_1)
	local var_8_0 = arg_8_1.timestamp - pg.TimeMgr.GetInstance():GetServerTime()

	if var_8_0 > 0 then
		self.descTxt.text = string.gsub(arg_8_1:getConfig("desc"), "$1", (pg.TimeMgr.GetInstance():DescCDTime(var_8_0)))
	else
		self:Hide()
	end

	return
end

function MainBuffDescPage:RemoveDescTimer()
	if self.descTimer then
		self.descTimer:Stop()

		self.descTimer = nil
	end

	return
end

function MainBuffDescPage:AddCloseTimer()
	self:RemoveCloseTimer()

	self.timer = Timer.New(function()
		self:Hide()

		return
	end, 7, 1)

	self.timer:Start()

	return
end

function MainBuffDescPage:RemoveCloseTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function MainBuffDescPage:Hide()
	MainBuffDescPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	self:RemoveCloseTimer()
	self:RemoveDescTimer()

	return
end

function MainBuffDescPage:Disable()
	if self:GetLoaded() and self:isShowing() then
		self:Hide()
	end

	return
end

function MainBuffDescPage:OnDestroy()
	self:RemoveCloseTimer()
	self:RemoveDescTimer()

	return
end

return MainBuffDescPage
