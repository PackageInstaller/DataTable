local WorldBossEntrancePage = class("WorldBossEntrancePage", import("....base.BaseSubView"))

function WorldBossEntrancePage:getUIName()
	return "WorldBossEntranceUI"
end

function WorldBossEntrancePage:Setup(arg_2_1)
	self.proxy = arg_2_1

	return
end

function WorldBossEntrancePage:OnLoaded()
	self.currentTr = self._tf:Find("current")
	self.pastTr = self._tf:Find("past")
	self.currTimeTxt = self.currentTr:Find("time"):GetComponent(typeof(Text))
	self.currConsumeTxt = self.currentTr:Find("consume"):GetComponent(typeof(Text))
	self.currAccTxt = self.currentTr:Find("acc"):GetComponent(typeof(Text))
	self.pastConsumeTxt = self.pastTr:Find("consume"):GetComponent(typeof(Text))
	self.pastAccTxt = self.pastTr:Find("acc"):GetComponent(typeof(Text))
	self.currProgressTr = self._tf:Find("current_progress")
	self.pastProgressTr = self._tf:Find("past_progress")
	self.currProgressTxt = self._tf:Find("current_progress/value"):GetComponent(typeof(Text))
	self.pastProgressTxt = self._tf:Find("past_progress/value"):GetComponent(typeof(Text))
	self.backBtn = self._tf:Find("blur_panel/adapt/top/back")

	local var_3_0 = self._tf:Find("current"):GetComponent(typeof(Image))

	var_3_0.sprite = GetSpriteFromAtlas("MetaWorldboss/" .. WorldBossConst.GetCurrBossGroup(), "cur")

	var_3_0:SetNativeSize()
	setText(self._tf:Find("tip/Text"), i18n("world_boss_item_usage_tip"))
	setText(self.currentTr:Find("label"), i18n("world_boss_current_boss_label"))
	setText(self.currentTr:Find("label1"), i18n("world_boss_current_boss_label1"))
	setText(self.pastTr:Find("label"), i18n("world_boss_current_boss_label"))
	setText(self.pastTr:Find("label1"), i18n("world_boss_current_boss_label1"))

	self.pastLabels = {
		self.pastTr:Find("label"),
		self.pastTr:Find("label1"),
		self.pastTr:Find("label2"),
		self.pastTr:Find("label3")
	}

	return
end

function WorldBossEntrancePage:OnInit()
	onButton(self, self.backBtn, function()
		self:emit(BaseUI.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.currentTr, function()
		self:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_CURRENT)

		return
	end, SFX_PANEL)
	onButton(self, self.pastTr, function()
		self:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_ARCHIVES)

		return
	end, SFX_PANEL)
	onButton(self, self.currProgressTr, function()
		local var_8_0 = WorldBossConst.GetCurrBossItemInfo()

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_DROP_ITEM,
			name = var_8_0.name,
			content = var_8_0.display,
			iconPath = var_8_0.icon,
			frame = var_8_0.rarity
		})

		return
	end, SFX_PANEL)
	onButton(self, self.pastProgressTr, function()
		local var_9_0 = WorldBossConst.GetAchieveBossItemInfo()

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_DROP_ITEM,
			name = var_9_0.name,
			content = var_9_0.display,
			iconPath = var_9_0.icon,
			frame = var_9_0.rarity
		})

		return
	end, SFX_PANEL)

	return
end

function WorldBossEntrancePage:Update()
	self:UpdateCurrent()
	self:UpdatePast()
	self:Show()

	return
end

function WorldBossEntrancePage:UpdateCurrent()
	self:ClearTimer()

	local function var_11_1()
		local var_12_0, var_12_1 = WorldBossConst.GetCurrBossLeftDay()

		self.currTimeTxt.text = i18n("world_boss_lefttime", var_12_0)

		if var_12_1 > 0 then
			self.timer = Timer.New(function()
				var_11_1()

				return
			end, var_12_1, 1)

			self.timer:Start()
		end

		return
	end

	;(nil)()

	local var_11_2, var_11_3, var_11_4 = WorldBossConst.GetCurrBossConsume()

	self.currConsumeTxt.text = var_11_2
	self.currAccTxt.text = "<color=#ffdf5d>" .. WorldBossConst.GetCurrBossItemAcc() .. "</color>/" .. var_11_3
	self.currProgressTxt.text = WorldBossConst.GetCurrBossItemProgress() .. "/" .. var_11_4

	return
end

function WorldBossEntrancePage:UpdatePast()
	local var_14_0, var_14_1, var_14_2 = WorldBossConst.GetAchieveBossConsume()

	self.pastProgressTxt.text = WorldBossConst.GetAchieveBossItemProgress() .. "/" .. var_14_2

	local var_14_3 = WorldBossConst.GetAchieveState()
	local var_14_4 = self.pastTr:GetComponent(typeof(Image))
	local var_14_5

	if WorldBossConst.ACHIEVE_STATE_STARTING == var_14_3 then
		self.pastAccTxt.text = "<color=#ffdf5d>" .. WorldBossConst.GetSummonPtOldAcc() .. "</color>/" .. var_14_1
		self.pastConsumeTxt.text = var_14_0
		var_14_5 = "useitem_archives"
		var_14_4.sprite = GetSpriteFromAtlas("MetaWorldboss" .. "/" .. WorldBossConst.BossId2MetaId(WorldBossConst.GetArchivesId()), "useitem_archives")

		var_14_4:SetNativeSize()
	else
		self.pastAccTxt.text = ""
		self.pastConsumeTxt.text = ""

		if WorldBossConst.ACHIEVE_STATE_NOSTART == var_14_3 then
			var_14_5 = "extra_unselect"
		elseif WorldBossConst.ACHIEVE_STATE_CLEAR == var_14_3 then
			var_14_5 = "extra_clear"
		end

		var_14_4.sprite = LoadSprite("MetaWorldboss/" .. var_14_5)

		var_14_4:SetNativeSize()
	end

	for iter_14_0, iter_14_1 in ipairs(self.pastLabels) do
		setActive(iter_14_1, WorldBossConst.ACHIEVE_STATE_STARTING == var_14_3)
	end

	return
end

function WorldBossEntrancePage:ClearTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function WorldBossEntrancePage:OnDestroy()
	self:ClearTimer()

	return
end

return WorldBossEntrancePage
