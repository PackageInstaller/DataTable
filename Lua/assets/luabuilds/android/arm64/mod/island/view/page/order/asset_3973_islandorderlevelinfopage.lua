local IslandOrderLevelInfoPage = class("IslandOrderLevelInfoPage", import("...base.IslandBasePage"))

function IslandOrderLevelInfoPage:getUIName()
	return "IslandOrderLevelInfoUI"
end

function IslandOrderLevelInfoPage:OnLoaded()
	self.levelTxt = self._tf:Find("frame/animroot/level"):GetComponent(typeof(Text))
	self.expTr = self._tf:Find("frame/animroot/slider")
	self.expTxt = self._tf:Find("frame/animroot/exp"):GetComponent(typeof(Text))
	self.cntTxt = self._tf:Find("frame/bg/Image/cnt"):GetComponent(typeof(Text))
	self.uiItemList = UIItemList.New(self._tf:Find("frame/animroot/rect/content"), self._tf:Find("frame/animroot/rect/content/tpl"))
	self.canvasGroup = GetOrAddComponent(self._tf, typeof(CanvasGroup))

	return
end

function IslandOrderLevelInfoPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandOrderLevelInfoPage:AddListeners()
	self:AddListener(IslandOrderAgency.ORDER_FINISH_UPDATE, self.OnReset)

	return
end

function IslandOrderLevelInfoPage:RemoveListeners()
	self:RemoveListener(IslandOrderAgency.ORDER_FINISH_UPDATE, self.OnReset)

	return
end

function IslandOrderLevelInfoPage:OnReset()
	self:Flush()

	return
end

function IslandOrderLevelInfoPage:Show()
	IslandOrderLevelInfoPage.super.Show(self)
	self:Flush()

	return
end

function IslandOrderLevelInfoPage:Flush()
	local var_9_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	self:FlushCnt(var_9_0)
	self:FlushLevelInfo(var_9_0)
	self:FlushList(var_9_0)

	return
end

function IslandOrderLevelInfoPage:FlushCnt(arg_10_1)
	self.cntTxt.text = i18n("island_order_leftcnt_dispaly", arg_10_1:GetLeftUrgentCnt())

	return
end

function IslandOrderLevelInfoPage:FlushLevelInfo(arg_11_1)
	self.levelTxt.text = "Lv." .. arg_11_1:GetLevel()

	if arg_11_1:IsMaxLevel() then
		setSlider(self.expTr, 0, 1, 1)

		self.expTxt.text = "MAX"
	else
		local var_11_0 = arg_11_1:GetExp()
		local var_11_1 = math.max(1, arg_11_1:GetNextTargetExp())

		setSlider(self.expTr, 0, 1, var_11_0 / var_11_1)

		self.expTxt.text = "<size=60><color=#ffaf1b>" .. var_11_0 .. "</color></size><color=#979797>/" .. var_11_1 .. "</color>"
	end

	return
end

function IslandOrderLevelInfoPage:FlushList(arg_12_1)
	local var_12_0 = pg.island_order_favor.all
	local var_12_1 = 1

	self.uiItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			self:UpdateCard(arg_12_1, arg_13_2, var_12_0[arg_13_1 + 1])

			if arg_12_1:IsGotAward(var_12_0[arg_13_1 + 1]) then
				var_12_1 = arg_13_1 + 1
			end
		end

		return
	end)
	self.uiItemList:align(#pg.island_order_favor.all)
	scrollTo(self.uiItemList.container.parent, 0, 1)
	self:ScrollTo(1, pg.island_order_favor.all)

	return
end

function IslandOrderLevelInfoPage:ScrollTo(arg_14_1, arg_14_2)
	onNextTick(function()
		self.uiItemList.container.localPosition = Vector3(self.uiItemList.container.localPosition.x - math.abs(self.uiItemList.container:GetChild((math.min(arg_14_1, #arg_14_2 * 0.5 - 1))).localPosition.x - self.uiItemList.container:GetChild(0).localPosition.x), self.uiItemList.container.localPosition.y, 0)

		return
	end)

	return
end

function IslandOrderLevelInfoPage:UpdateCard(arg_16_1, arg_16_2, arg_16_3)
	self:UpdateAwards(arg_16_2, arg_16_3)

	local var_16_0 = arg_16_1:IsGotAward(arg_16_3)
	local var_16_1 = arg_16_1:CanGetAward(arg_16_3)
	local var_16_2 = var_16_1 or var_16_0

	setActive(arg_16_2:Find("got"), var_16_0)
	setActive(arg_16_2:Find("finish"), var_16_2)
	setText(arg_16_2:Find("num"), setColorStr((arg_16_3 < 10 or nil) and ("0" .. arg_16_3 or arg_16_3), var_16_2 and "#FFFFFF" or "#979797"))
	onButton(self, arg_16_2, function()
		if var_16_1 and not var_16_0 then
			self:emit(IslandMediator.ON_GET_ORDER_EXP_AWARD, arg_16_3)
		end

		return
	end, SFX_PANEL)

	return
end

function IslandOrderLevelInfoPage:UpdateAwards(arg_18_1, arg_18_2)
	local var_18_0 = pg.island_order_favor[arg_18_2].award_display
	local var_18_1 = UIItemList.New(arg_18_1:Find("awards"), arg_18_1:Find("awards/IslandItemTpl"))

	var_18_1:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_19_2, (Drop.Create(var_18_0[arg_19_1 + 1])))
		end

		return
	end)
	var_18_1:align(math.min(2, #pg.island_order_favor[arg_18_2].award_display))

	return
end

function IslandOrderLevelInfoPage:OnDestroy()
	return
end

return IslandOrderLevelInfoPage
