local AirForceOfDragonEmperyUI = class("AirForceOfDragonEmperyUI", import("view.base.BaseUI"))

function AirForceOfDragonEmperyUI:getUIName()
	return "AirForceOfDragonEmperyUI"
end

local var_0_1 = {
	"J-20",
	"J-10",
	"J-15",
	"FC-1",
	"FC-31"
}
local var_0_2 = {
	"fighterplane_J20_tip",
	"fighterplane_J10_tip",
	"fighterplane_J15_tip",
	"fighterplane_FC1_tip",
	"fighterplane_FC31_tip"
}

function AirForceOfDragonEmperyUI:init()
	self.itemList = {}

	for iter_2_0 = 0, self._tf:Find("List").childCount - 1 do
		local var_2_0 = self._tf:Find("List"):GetChild(iter_2_0)

		setImageAlpha(var_2_0:Find("Button"), 0.5)
		table.insert(self.itemList, var_2_0)
	end

	self.currentNameImage = self._tf:Find("FighterName")
	self.currentFighterImage = self._tf:Find("FighterImage")
	self.currentFighterDesc = self._tf:Find("FighterProgress")

	setImageAlpha(self.currentNameImage, 0)
	setImageAlpha(self.currentFighterImage, 0)

	self.BattleTimes = self._tf:Find("BattleTimes")
	self.loader = AutoLoader.New()

	return
end

function AirForceOfDragonEmperyUI:SetActivityData(arg_3_1)
	self.activity = arg_3_1

	return
end

function AirForceOfDragonEmperyUI:GetFighterData(arg_4_1)
	return self.activity:getKVPList(1, arg_4_1) or 0, self.activity:getKVPList(2, arg_4_1) == 1
end

function AirForceOfDragonEmperyUI:GetActivityProgress()
	local var_5_0 = 0

	for iter_5_0 = 1, self.activity:GetLevelCount() do
		var_5_0 = var_5_0 + (self.activity:getKVPList(1, iter_5_0) or 0)
	end

	local var_5_1 = pg.TimeMgr.GetInstance()

	return var_5_0, (math.min((var_5_1:DiffDay(self.activity.data1, var_5_1:GetServerTime()) + 1) * self.activity:GetPerDayCount(), (self.activity:GetMaxProgress())))
end

function AirForceOfDragonEmperyUI:didEnter()
	onButton(self, self._tf:Find("Back"), function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self._tf:Find("Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.fighterplane_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Battle"), function()
		local var_9_0 = self.contextData.index

		local function var_9_1()
			local var_10_0 = self.activity:getConfig("config_client").stages
			local var_10_1 = math.floor(#var_10_0 / self.activity:GetLevelCount())

			self:emit(AirForceOfDragonEmperyMediator.ON_BATTLE, var_10_0[math.random(var_10_1 * (var_9_0 - 1) + 1, (math.min(var_10_1 * (var_9_0 - 1) + 1 + var_10_1 - 1, #var_10_0)))])

			return
		end

		if self:GetFighterData(self.contextData.index) >= self.activity:GetPerLevelProgress() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("fighterplane_complete_tip"),
				onYes = var_9_1
			})
		else
			var_9_1()
		end

		return
	end, SFX_FIGHTER_BATTLE)

	for iter_6_0, iter_6_1 in ipairs(self.itemList) do
		onButton(self, iter_6_1, function()
			self:SwitchIndex(iter_6_0)

			return
		end, SFX_FIGHTER_SWITCH)
	end

	self.contextData.index = nil

	self:SwitchIndex(self.contextData.index or PlayerPrefs.GetInt("AirFightIndex_" .. getProxy(PlayerProxy):getRawData().id, 1))
	self:UpdateView()

	return
end

function AirForceOfDragonEmperyUI:willExit()
	PlayerPrefs.SetInt("AirFightIndex_" .. getProxy(PlayerProxy):getRawData().id, self.contextData.index)
	PlayerPrefs.Save()
	LeanTween.cancel(go(self.currentNameImage))
	LeanTween.cancel(go(self.currentFighterImage))
	LeanTween.cancel(go(self.currentFighterDesc:Find("Desc/Text")))
	LeanTween.cancel(go(self.currentFighterDesc:Find("Progress")))
	self.loader:Clear()

	return
end

function AirForceOfDragonEmperyUI:UpdateView()
	for iter_13_0, iter_13_1 in ipairs(self.itemList) do
		local var_13_0, var_13_1 = self:GetFighterData(iter_13_0)

		UIItemList.StaticAlign(self.itemList[iter_13_0]:Find("Progress"), self.itemList[iter_13_0]:Find("Progress"):GetChild(0), var_13_0)
	end

	self:UpdateFighter(self.contextData.index)

	local var_13_2, var_13_3 = self:GetActivityProgress()

	setText(self.BattleTimes, var_13_3 - var_13_2)
	self:CheckActivityUpdate()

	return
end

function AirForceOfDragonEmperyUI:SwitchIndex(arg_14_1)
	if arg_14_1 == nil or arg_14_1 == self.contextData.index then
		return
	end

	if self.contextData.index then
		setActive(self.itemList[self.contextData.index]:Find("Selected"), false)
		setImageAlpha(self.itemList[self.contextData.index]:Find("Button"), 0.5)
	end

	self.contextData.index = arg_14_1

	setActive(self.itemList[self.contextData.index]:Find("Selected"), true)
	setImageAlpha(self.itemList[self.contextData.index]:Find("Button"), 1)
	self:UpdateFighter(arg_14_1)
	;(function()
		local var_15_0
		local var_15_1 = self.currentFighterImage:GetComponent(typeof(Image))
		local var_15_2 = tf(self.currentFighterImage)

		LeanTween.cancel(go(self.currentFighterImage))

		local var_15_3
		local var_15_4 = self.currentNameImage:GetComponent(typeof(Image))
		local var_15_5 = tf(self.currentNameImage)

		LeanTween.cancel(go(self.currentNameImage))
		parallelAsync({
			function(arg_16_0)
				if var_15_1.color.a < 0.05 then
					arg_16_0()

					return
				end

				LeanTween.alpha(var_15_2, 0, var_15_1.color.a * 0.2):setOnComplete(System.Action(arg_16_0))

				return
			end,
			function(arg_17_0)
				if var_15_4.color.a < 0.05 then
					arg_17_0()

					return
				end

				LeanTween.alpha(var_15_5, 0, var_15_4.color.a * 0.2):setOnComplete(System.Action(arg_17_0))

				return
			end,
			function(arg_18_0)
				self.loader:GetSpriteDirect("ui/AirForceOfDragonEmperyUI_atlas", var_0_1[arg_14_1], function(arg_19_0)
					var_15_0 = arg_19_0

					arg_18_0()

					return
				end, self.currentFighterImage)

				return
			end,
			function(arg_20_0)
				self.loader:GetSpriteDirect("ui/AirForceOfDragonEmperyUI_atlas", var_0_1[arg_14_1] .. "_BG", function(arg_21_0)
					var_15_3 = arg_21_0

					arg_20_0()

					return
				end, self.currentNameImage)

				return
			end
		}, function()
			var_15_1.enabled = true
			var_15_1.sprite = var_15_0

			LeanTween.alpha(var_15_2, 1, 0.2)

			var_15_4.enabled = true
			var_15_4.sprite = var_15_3

			LeanTween.alpha(var_15_5, 1, 0.2)

			return
		end)

		return
	end)()
	;(function()
		local var_23_0 = self.currentFighterDesc:Find("Desc/Text")

		LeanTween.cancel(var_23_0)
		var_23_0:GetComponent("ScrollText"):SetText(i18n(var_0_2[arg_14_1]))
		LeanTween.textAlpha(var_23_0, 1, 0.5):setFrom(0)

		return
	end)()

	local var_14_0, var_14_1 = self:GetFighterData(arg_14_1)
	local var_14_2 = self.currentFighterDesc:Find("Progress")
	local var_14_3 = self.activity:GetPerLevelProgress()

	UIItemList.StaticAlign(var_14_2, var_14_2:GetChild(0), var_14_3, function(arg_24_0, arg_24_1, arg_24_2)
		if not arg_24_0 == UIItemList.EventUpdate then
			return
		end

		setActive(arg_24_2:GetChild(0), arg_24_1 + 1 <= var_14_0)

		arg_24_2:GetChild(0).localScale = Vector3(0, 1, 1)

		return
	end)
	LeanTween.cancel(go(var_14_2))
	LeanTween.value(go(var_14_2), 0, 1, var_14_3 * 0.2):setOnUpdate(System.Action_float(function(arg_25_0)
		for iter_25_0 = 0, 2 do
			var_14_2:GetChild(iter_25_0):GetChild(0).localScale = Vector3(math.clamp(var_14_3 * arg_25_0 - iter_25_0, 0, 1), 1, 1)
		end

		return
	end))
	self.loader:GetSprite("ui/AirForceOfDragonEmperyUI_atlas", var_0_1[arg_14_1] .. "_Text", self.currentFighterDesc:Find("Name"), true)

	return
end

function AirForceOfDragonEmperyUI:UpdateFighter(arg_26_1)
	local var_26_0, var_26_1 = self:GetFighterData(arg_26_1)

	UIItemList.StaticAlign(self.itemList[arg_26_1]:Find("Progress"), self.itemList[arg_26_1]:Find("Progress"):GetChild(0), var_26_0)

	local var_26_2 = self.activity:getConfig("config_client").awards[arg_26_1]
	local var_26_3 = {
		type = var_26_2[1],
		id = var_26_2[2],
		count = var_26_2[3]
	}

	updateDrop(self.currentFighterDesc:Find("Item"), var_26_3)
	setActive(self.currentFighterDesc:Find("ItemMask"), var_26_1)
	onButton(self, self.currentFighterDesc:Find("Item"), function()
		self:emit(BaseUI.ON_DROP, var_26_3)

		return
	end, SFX_PANEL)

	return
end

function AirForceOfDragonEmperyUI:CheckActivityUpdate()
	local var_28_0 = self.activity:GetPerLevelProgress()

	for iter_28_0 = 1, self.activity:GetLevelCount() do
		local var_28_1, var_28_2 = self:GetFighterData(iter_28_0)

		if var_28_0 <= var_28_1 and not var_28_2 then
			self:emit(AirForceOfDragonEmperyMediator.ON_ACTIVITY_OPREATION, {
				cmd = 2,
				activity_id = self.activity.id,
				arg1 = iter_28_0
			})

			return
		end
	end

	return
end

return AirForceOfDragonEmperyUI
