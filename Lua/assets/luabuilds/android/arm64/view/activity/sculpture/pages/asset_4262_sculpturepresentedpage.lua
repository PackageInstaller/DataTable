local SculpturePresentedPage = class("SculpturePresentedPage", import("view.base.BaseSubView"))

function SculpturePresentedPage:getUIName()
	return "SculpturePresentedUI"
end

function SculpturePresentedPage:OnLoaded()
	self.container = self._tf:Find("frame/container")
	self.sendBtn = self._tf:Find("frame/btn")

	setAnchoredPosition(self.container, {
		x = 0,
		y = -80
	})

	return
end

function SculpturePresentedPage:OnInit()
	return
end

function SculpturePresentedPage:Show(arg_4_1, arg_4_2, arg_4_3)
	self:Clear()
	SculpturePresentedPage.super.Show(self)

	self.id = arg_4_1
	self.activity = arg_4_2

	if arg_4_3 then
		arg_4_3()
	end

	seriesAsync({
		function(arg_5_0)
			self:LoadSculpture(arg_5_0)

			return
		end
	}, function()
		self:RegisterEvent()

		return
	end)
	pg.BgmMgr.GetInstance():Push(self.__cname, "story-richang-8")

	return
end

function SculpturePresentedPage:LoadSculpture(arg_7_1)
	local var_7_0 = "gift_" .. self.activity:GetResorceName(self.id)

	PoolMgr.GetInstance():GetSpineChar(var_7_0, true, function(arg_8_0)
		arg_8_0.transform:SetParent(self.container)

		arg_8_0.transform.localScale = Vector3.one
		arg_8_0.transform.localPosition = Vector3(0, 0, 0)

		arg_8_0:GetComponent(typeof(SpineAnimUI)):SetAction("normal", 0)

		self.charName = var_7_0
		self.charGo = arg_8_0

		if arg_7_1 then
			arg_7_1()
		end

		return
	end)

	return
end

function SculpturePresentedPage:RegisterEvent()
	onButton(self, self.sendBtn, function()
		self:emit(SculptureScene.OPEN_GRATITUDE_PAGE, self.id)

		return
	end, SFX_PANEL)

	return
end

function SculpturePresentedPage:Clear()
	if self.charGo then
		PoolMgr.GetInstance():ReturnSpineChar(self.charName, self.charGo)
	end

	return
end

function SculpturePresentedPage:Hide()
	SculpturePresentedPage.super.Hide(self)
	pg.BgmMgr.GetInstance():Pop(self.__cname)

	return
end

function SculpturePresentedPage:OnDestroy()
	self:Clear()

	return
end

return SculpturePresentedPage
