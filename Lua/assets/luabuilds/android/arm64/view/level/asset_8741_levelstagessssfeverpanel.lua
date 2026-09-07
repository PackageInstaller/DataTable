local LevelStageSSSSFeverPanel = class("LevelStageSSSSFeverPanel", import("view.base.BaseSubPanel"))

function LevelStageSSSSFeverPanel:getUIName()
	return "LevelStageSSSSFeverPanel"
end

LevelStageSSSSFeverPanel.stepCount = 10
LevelStageSSSSFeverPanel.enemyCount = 4

local var_0_1 = {
	liuhua = {
		9401,
		9403,
		9406,
		9409,
		9412,
		9415
	},
	mengya = {
		9421,
		9423,
		9426,
		9429,
		9432,
		9435
	},
	qianlai = {
		9441,
		9443,
		9446,
		9449,
		9452,
		9455
	}
}
local var_0_2 = {
	qian = {
		9461,
		9463,
		9466,
		9469,
		9472,
		9475
	},
	he = {
		9481,
		9483,
		9486,
		9489,
		9492,
		9495
	}
}

function LevelStageSSSSFeverPanel:OnInit()
	self.barGroup1 = self:GetBarTFGroup(self._tf:Find("Bar1"))
	self.barGroup2 = self:GetBarTFGroup(self._tf:Find("Bar2"))
	self.banner = self._tf:Find("Banner")

	setActive(self.banner, false)

	self.buff2Character = {}

	for iter_2_0, iter_2_1 in pairs(var_0_1) do
		for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
			self.buff2Character[iter_2_3] = iter_2_0
		end
	end

	self.buff2Enemy = {}

	for iter_2_4, iter_2_5 in pairs(var_0_2) do
		for iter_2_6, iter_2_7 in ipairs(iter_2_5) do
			self.buff2Enemy[iter_2_7] = iter_2_4
		end
	end

	self.loader = AutoLoader.New()
	self.animations = AsyncExcutionRequestPackage.New({})
	self.PanelAnimations = AsyncExcutionRequestPackage.New({})
	self.cleanActions = {}

	return
end

function LevelStageSSSSFeverPanel:GetIcon(arg_3_1, arg_3_2)
	local var_3_0

	if arg_3_2 then
		var_3_0 = self.buff2Character or self.buff2Enemy
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.buff_list) do
		if var_3_0[iter_3_1] then
			return var_3_0[iter_3_1]
		end
	end

	return ""
end

function LevelStageSSSSFeverPanel:GetBarTFGroup(arg_4_1)
	return {
		main = arg_4_1,
		fillImg = arg_4_1:Find("Fill"),
		ratioText = arg_4_1:Find("Text"),
		iconImg = arg_4_1:Find("Icon")
	}
end

local var_0_3 = {
	1590001,
	1590051
}

function LevelStageSSSSFeverPanel:UpdateView(arg_5_1, arg_5_2)
	if table.contains(var_0_3, arg_5_1.id) then
		self:Hide()
		existCall(arg_5_2)

		return
	end

	self:UpdateKaijuBar(arg_5_1)
	self:UpdateSyberSquadBar(arg_5_1)
	self.animations:Resume()
	self.PanelAnimations:Insert(function(arg_6_0)
		existCall(arg_5_2)
		arg_6_0()

		return
	end)
	self.PanelAnimations:Resume()

	return
end

function LevelStageSSSSFeverPanel:UpdateKaijuBar(arg_7_1)
	local var_7_0 = getProxy(ChapterProxy)
	local var_7_1 = var_7_0:GetExtendChapterData(arg_7_1.id, "FleetMoveDistance")
	local var_7_2 = arg_7_1.moveStep
	local var_7_3 = arg_7_1:isLoop() and 0 or LevelStageSSSSFeverPanel.stepCount
	local var_7_4 = math.min(arg_7_1.moveStep / var_7_0, 1)
	local var_7_5 = self.barGroup1.fillImg
	local var_7_6 = self.barGroup1.fillImg:GetComponent(typeof(Image))
	local var_7_7 = self.barGroup1.ratioText

	if var_7_1 and var_7_2 <= var_7_3 then
		self.animations:Insert(function(arg_8_0)
			local var_8_0 = (var_7_2 - var_7_1) / var_7_3

			LeanTween.value(go(var_7_5), 0, 1, (math.min(var_7_1, var_7_3 - (var_7_2 - var_7_1)))):setOnUpdate(System.Action_float(function(arg_9_0)
				local var_9_0 = Mathf.Lerp(var_8_0, var_7_4, arg_9_0)

				var_7_6.fillAmount = var_9_0

				setText(var_7_7, string.format("%02d%%", math.floor(var_9_0 * 100)))

				return
			end)):setOnComplete(System.Action(arg_8_0))

			return
		end)
	end

	local var_7_8 = self:GetIcon(arg_7_1, false)

	self.animations:Insert(function(arg_10_0)
		var_7_6.fillAmount = var_7_4

		setText(var_7_7, string.format("%02d%%", math.floor(var_7_4 * 100)))

		if var_7_4 >= 1 then
			self.loader:GetSpriteQuiet("ui/LevelStageSSSSFeverPanel_atlas", "icon_" .. var_7_8, self.barGroup1.iconImg, true)
		end

		arg_10_0()

		return
	end)

	if var_7_1 and var_7_3 > var_7_2 - var_7_1 and var_7_3 <= var_7_2 then
		self.PanelAnimations:Insert(function(arg_11_0)
			self:ShowPanel(var_7_8, "Kaiju", arg_11_0, var_7_8 == "he" and "" or "2")

			return
		end)
	end

	return
end

function LevelStageSSSSFeverPanel:UpdateSyberSquadBar(arg_12_1)
	local var_12_0 = getProxy(ChapterProxy)
	local var_12_1 = var_12_0:GetLastDefeatedEnemy(arg_12_1.id)
	local var_12_2 = arg_12_1.defeatEnemies
	local var_12_3 = arg_12_1:isLoop() and 0 or LevelStageSSSSFeverPanel.enemyCount
	local var_12_4 = math.min(arg_12_1.defeatEnemies / var_12_0, 1)
	local var_12_5 = self.barGroup2.fillImg
	local var_12_6 = self.barGroup2.fillImg:GetComponent(typeof(Image))
	local var_12_7 = self.barGroup2.ratioText

	if var_12_1 and var_12_2 <= var_12_3 then
		self.animations:Insert(function(arg_13_0)
			local var_13_0 = math.max(var_12_2 - 1, 0) / var_12_3

			LeanTween.value(go(var_12_5), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_14_0)
				local var_14_0 = Mathf.Lerp(var_13_0, var_12_4, arg_14_0)

				var_12_6.fillAmount = var_14_0

				setText(var_12_7, string.format("%02d%%", math.floor(var_14_0 * 100)))

				return
			end)):setOnComplete(System.Action(arg_13_0))

			return
		end)
	end

	local var_12_8 = self:GetIcon(arg_12_1, true)

	self.animations:Insert(function(arg_15_0)
		var_12_6.fillAmount = var_12_4

		setText(var_12_7, string.format("%02d%%", math.floor(var_12_4 * 100)))

		if var_12_4 >= 1 then
			self.loader:GetSpriteQuiet("ui/LevelStageSSSSFeverPanel_atlas", "icon_" .. var_12_8, self.barGroup2.iconImg, true)
		end

		arg_15_0()

		return
	end)

	if var_12_1 and var_12_2 == var_12_3 then
		self.PanelAnimations:Insert(function(arg_16_0)
			self:ShowPanel(var_12_8, "SyberSquad", arg_16_0)

			return
		end)
	end

	return
end

function LevelStageSSSSFeverPanel:ShowPanel(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	self:emit(LevelUIConst.FROZEN)
	pg.UIMgr.GetInstance():BlurPanel(self.banner)

	local var_17_0 = self.banner:Find(arg_17_2)
	local var_17_1 = var_17_0:Find("Character")
	local var_17_2 = var_17_1:GetComponent(typeof(Image))

	self.loader:GetSpriteQuiet("ui/LevelStageSSSSFeverPanel_atlas", arg_17_1, var_17_1, true)
	setActive(self.banner, true)
	setAnchoredPosition(var_17_0, {
		x = 2436
	})
	setActive(var_17_0, true)

	var_17_2.enabled = true

	if arg_17_4 ~= nil then
		setActive(var_17_0:Find("Word"), false)
		setActive(var_17_0:Find("Word2"), false)
		setActive(var_17_0:Find("Word" .. arg_17_4), true)
	end

	local var_17_3 = var_17_0:GetComponent(typeof(DftAniEvent))

	local function var_17_5()
		table.removebyvalue(self.cleanActions, var_17_5)
		var_17_3:SetEndEvent(nil)

		var_17_2.enabled = false
		var_17_2.sprite = nil

		pg.UIMgr.GetInstance():UnOverlayPanel(self.banner, self._tf)
		setActive(self.banner, false)
		setActive(var_17_0, false)
		self:emit(LevelUIConst.UN_FROZEN)

		return
	end

	local function var_17_6()
		var_17_5()
		existCall(arg_17_3)

		return
	end

	var_17_3:SetEndEvent(var_17_6)
	onButton(self, self.banner, var_17_6)
	table.insert(self.cleanActions, var_17_5)

	return
end

function LevelStageSSSSFeverPanel:CloseActions()
	if self.animations and not self.animations.stopped then
		self.animations:Stop()
	end

	self.animations = nil

	if self.PanelAnimations and not self.PanelAnimations.stopped then
		self.PanelAnimations:Stop()
	end

	self.PanelAnimations = nil

	if self.cleanActions then
		_.each(self.cleanActions, function(arg_21_0)
			arg_21_0()

			return
		end)
	end

	self.cleanActions = nil

	self.loader:ClearRequests()

	return
end

function LevelStageSSSSFeverPanel:OnHide()
	self:CloseActions()

	return
end

return LevelStageSSSSFeverPanel
