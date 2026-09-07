local MainBuffView = class("MainBuffView", import("...base.MainBaseView"))

function MainBuffView:Ctor(arg_1_1, arg_1_2)
	MainBuffView.super.Ctor(self, arg_1_1, arg_1_2)

	self.buffs = {
		arg_1_1:Find("buff").gameObject
	}
	self.skinFreeUsageTag = nil
	self.timers = {}
	self.buffOffsetX = 20
	self.noTagStartPos = 285
	self.hasTagStartPos = 390
	self.tagPos = Vector3(-169, -18, 0)

	self:bind(MiniGameProxy.ON_HUB_DATA_UPDATE, function(arg_2_0)
		self:Refresh()

		return
	end)
	self:bind(GAME.SEND_MINI_GAME_OP_DONE, function(arg_3_0)
		self:Refresh()

		return
	end)

	return
end

function MainBuffView:CollectBuffs()
	local var_4_0 = BuffHelper.GetBuffsForMainUI()
	local MainUIVirtualIconData = import("GameCfg.activity.MainUIVirtualIconData")

	for iter_4_0, iter_4_1 in ipairs(MainUIVirtualIconData.CurrentIconList) do
		if MainUIVirtualIconData[iter_4_1]:CheckExist() then
			table.insert(var_4_0, MainUIVirtualIconData[iter_4_1])
		end
	end

	return var_4_0
end

function MainBuffView:Init()
	local var_5_0 = self:CollectBuffs()
	local var_5_1 = self:ShouldFreeUsageSkinTag()

	self._tf.anchoredPosition = Vector3((var_5_1 or nil) and (self.hasTagStartPos or self.noTagStartPos), self._tf.anchoredPosition.y, 0)

	if var_5_1 then
		self:UpdateFreeUsageSkinTag()
	elseif self.skinFreeUsageTag then
		setActive(self.skinFreeUsageTag, false)
	end

	self:ClearTimers()
	self:UpdateBuffs(var_5_0)

	self.buffList = var_5_0
	self.showTag = var_5_1

	return
end

function MainBuffView:Refresh()
	local var_6_0 = self:CollectBuffs()
	local var_6_1 = self:ShouldFreeUsageSkinTag()

	self:Init()

	return
end

function MainBuffView:ShouldFreeUsageSkinTag()
	for iter_7_0, iter_7_1 in pairs((getProxy(ShipSkinProxy):getRawData())) do
		if iter_7_1:isExpireType() and not iter_7_1:isExpired() then
			return true
		end
	end

	return false
end

function MainBuffView:UpdateFreeUsageSkinTag()
	local var_8_0 = self.skinFreeUsageTag or Object.Instantiate(self.buffs[1], self.buffs[1].transform.parent).transform

	self.skinFreeUsageTag = var_8_0

	local var_8_1 = var_8_0:GetComponent(typeof(Image))

	var_8_1.sprite = GetSpriteFromAtlas("ui/mainui_atlas", "huanzhuangtiyan")

	var_8_1:SetNativeSize()
	onButton(self, var_8_0, function()
		self:emit(NewMainScene.ON_SKIN_FREEUSAGE_DESC, (self:GetFreeUsageSkins()))

		return
	end, SFX_PANEL)

	var_8_0.anchoredPosition = self.tagPos

	setActive(self.skinFreeUsageTag, true)

	return
end

function MainBuffView:GetFreeUsageSkins()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs((getProxy(ShipSkinProxy):getRawData())) do
		if iter_10_1:isExpireType() and not iter_10_1:isExpired() then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function MainBuffView:GetTpl(arg_11_1)
	if not self.buffs[arg_11_1] then
		local var_11_0 = Object.Instantiate(self.buffs[1], self.buffs[1].transform.parent)

		var_11_0.transform.anchoredPosition = Vector3(self.buffs[1].transform.anchoredPosition.x + (arg_11_1 - 1) * (self.buffs[1].transform.sizeDelta.x + self.buffOffsetX), self.buffs[1].transform.anchoredPosition.y, 0)
		self.buffs[arg_11_1] = var_11_0
	end

	return self.buffs[arg_11_1]
end

function MainBuffView:UpdateBuffs(arg_12_1)
	for iter_12_0 = #self.buffs, #arg_12_1 + 1, -1 do
		if self.buffs[iter_12_0] then
			setActive(self.buffs[iter_12_0], false)
		end
	end

	for iter_12_1, iter_12_2 in ipairs(arg_12_1) do
		local var_12_0 = self:GetTpl(iter_12_1)

		if iter_12_2.IsVirtualIcon then
			self:UpdateVirtualBuff(var_12_0, iter_12_2)
		else
			self:UpdateBuff(var_12_0, iter_12_2)
			self:AddEndTimer(var_12_0, iter_12_2)
		end
	end

	return
end

function MainBuffView:UpdateVirtualBuff(arg_13_1, arg_13_2)
	LoadImageSpriteAtlasAsync("ui/mainui_atlas", arg_13_2.Image, arg_13_1)
	onButton(self, arg_13_1, function()
		self.buffDesMsgbox = self.buffDesMsgbox or MainBuffDesMsgbox.New(pg.UIMgr.GetInstance().UIMain)

		self.buffDesMsgbox:ExecuteAction("Show", ActivityConst.DOA_PT_ID)

		return
	end, SFX_PANEL)
	setActive(arg_13_1, true)

	return
end

function MainBuffView:UpdateBuff(arg_15_1, arg_15_2)
	LoadImageSpriteAsync(arg_15_2:getConfig("icon"), arg_15_1)
	onButton(self, arg_15_1, function()
		local var_16_0 = pg.UIMgr.GetInstance().UIMain:InverseTransformPoint(arg_15_1.transform.position)

		self:emit(NewMainScene.ON_BUFF_DESC, arg_15_2, Vector3(var_16_0.x, var_16_0.y - 55, 0))

		return
	end, SFX_PANEL)
	setActive(arg_15_1, true)

	return
end

function MainBuffView:AddEndTimer(arg_17_1, arg_17_2)
	self.timers[arg_17_1] = Timer.New(function()
		setActive(arg_17_1, false)

		return
	end, arg_17_2:getLeftTime(), 1)

	self.timers[arg_17_1]:Start()

	return
end

function MainBuffView:ClearTimers()
	for iter_19_0, iter_19_1 in pairs(self.timers) do
		iter_19_1:Stop()
	end

	self.timers = {}

	return
end

function MainBuffView:GetDirection()
	return Vector2(0, 1)
end

function MainBuffView:Disable()
	if self.buffDesMsgbox then
		self.buffDesMsgbox:Destroy()

		self.buffDesMsgbox = nil
	end

	return
end

function MainBuffView:Dispose()
	MainBuffView.super.Dispose(self)

	if self.skinFreeUsageTag then
		Destroy(self.skinFreeUsageTag.gameObject)

		self.skinFreeUsageTag = nil
	end

	self:ClearTimers()

	if self.buffDesMsgbox then
		self.buffDesMsgbox:Destroy()

		self.buffDesMsgbox = nil
	end

	return
end

return MainBuffView
