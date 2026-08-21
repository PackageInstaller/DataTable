local var_0_0 = class("LevelStageSSSSFeverPanel", import("view.base.BaseSubPanel"))

function var_0_0.getUIName(arg_1_0)
	return "LevelStageSSSSFeverPanel"
end

var_0_0.stepCount = 10
var_0_0.enemyCount = 4

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

function var_0_0.OnInit(arg_2_0)
	arg_2_0.barGroup1 = arg_2_0:GetBarTFGroup(arg_2_0._tf:Find("Bar1"))
	arg_2_0.barGroup2 = arg_2_0:GetBarTFGroup(arg_2_0._tf:Find("Bar2"))
	arg_2_0.banner = arg_2_0._tf:Find("Banner")

	setActive(arg_2_0.banner, false)

	arg_2_0.buff2Character = {}

	for iter_2_0, iter_2_1 in pairs(var_0_1) do
		for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
			arg_2_0.buff2Character[iter_2_3] = iter_2_0
		end
	end

	arg_2_0.buff2Enemy = {}

	for iter_2_4, iter_2_5 in pairs(var_0_2) do
		for iter_2_6, iter_2_7 in ipairs(iter_2_5) do
			arg_2_0.buff2Enemy[iter_2_7] = iter_2_4
		end
	end

	arg_2_0.loader = AutoLoader.New()
	arg_2_0.animations = AsyncExcutionRequestPackage.New({})
	arg_2_0.PanelAnimations = AsyncExcutionRequestPackage.New({})
	arg_2_0.cleanActions = {}

	return
end

function var_0_0.GetIcon(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 then
		local var_3_0 = arg_3_0.buff2Character or arg_3_0.buff2Enemy

		for iter_3_0, iter_3_1 in ipairs(arg_3_1.buff_list) do
			if var_3_0[iter_3_1] then
				return var_3_0[iter_3_1]
			end
		end

		return ""
	end
end

function var_0_0.GetBarTFGroup(arg_4_0, arg_4_1)
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

function var_0_0.UpdateView(arg_5_0, arg_5_1, arg_5_2)
	if table.contains(var_0_3, arg_5_1.id) then
		arg_5_0:Hide()
		existCall(arg_5_2)

		return
	end

	arg_5_0:UpdateKaijuBar(arg_5_1)
	arg_5_0:UpdateSyberSquadBar(arg_5_1)
	arg_5_0.animations:Resume()
	arg_5_0.PanelAnimations:Insert(function(arg_6_0)
		existCall(arg_5_2)
		arg_6_0()

		return
	end)
	arg_5_0.PanelAnimations:Resume()

	return
end

function var_0_0.UpdateKaijuBar(arg_7_0, arg_7_1)
	local var_7_9000
	local var_7_0 = getProxy(ChapterProxy)
	local var_7_1 = var_7_0.GetExtendChapterData(var_7_9000, arg_7_1.id, "FleetMoveDistance")
	local var_7_2 = arg_7_1.moveStep
	local var_7_3 = arg_7_1:isLoop() and 0 or var_0_0.stepCount
	local var_7_4 = math.min(arg_7_1.moveStep / var_7_0, 1)
	local var_7_5 = arg_7_0.barGroup1.fillImg:GetComponent(typeof(Image))
	local var_7_6 = arg_7_0.barGroup1.ratioText

	if var_7_1 and var_7_2 <= var_7_3 then
		arg_7_0.animations:Insert(function(arg_8_0)
			local var_8_0 = (var_7_2 - var_7_1) / var_7_3

			LeanTween.value(go(var_0), 0, 1, (math.min(var_7_1, var_7_3 - (var_7_2 - var_7_1)))):setOnUpdate(System.Action_float(function(arg_9_0)
				local var_9_0 = Mathf.Lerp(var_8_0, var_7_4, arg_9_0)

				var_7_5.fillAmount = var_9_0

				setText(var_7_6, string.format("%02d%%", math.floor(var_9_0 * 100)))

				return
			end)):setOnComplete(System.Action(arg_8_0))

			return
		end)
	end

	local var_7_7 = arg_7_0:GetIcon(arg_7_1, false)

	arg_7_0.animations:Insert(function(arg_10_0)
		var_7_5.fillAmount = var_7_4

		setText(var_7_6, string.format("%02d%%", math.floor(var_7_4 * 100)))

		if var_7_4 >= 1 then
			arg_7_0.loader:GetSpriteQuiet("ui/LevelStageSSSSFeverPanel_atlas", "icon_" .. var_7_7, arg_7_0.barGroup1.iconImg, true)
		end

		arg_10_0()

		return
	end)

	if var_7_1 and var_7_3 > var_7_2 - var_7_1 and var_7_3 <= var_7_2 then
		arg_7_0.PanelAnimations:Insert(function(arg_11_0)
			arg_7_0:ShowPanel(var_7_7, "Kaiju", arg_11_0, var_7_7 == "he" and "" or "2")

			return
		end)
	end

	return
end

function var_0_0.UpdateSyberSquadBar(arg_12_0, arg_12_1)
	local var_12_9000
	local var_12_0 = getProxy(ChapterProxy)
	local var_12_1 = var_12_0.GetLastDefeatedEnemy(var_12_9000, arg_12_1.id)
	local var_12_2 = arg_12_1.defeatEnemies
	local var_12_3 = arg_12_1:isLoop() and 0 or var_0_0.enemyCount
	local var_12_4 = math.min(arg_12_1.defeatEnemies / var_12_0, 1)
	local var_12_5 = arg_12_0.barGroup2.fillImg:GetComponent(typeof(Image))
	local var_12_6 = arg_12_0.barGroup2.ratioText

	if var_12_1 and var_12_2 <= var_12_3 then
		arg_12_0.animations:Insert(function(arg_13_0)
			local var_13_0 = math.max(var_12_2 - 1, 0) / var_12_3

			LeanTween.value(go(var_0), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_14_0)
				local var_14_0 = Mathf.Lerp(var_13_0, var_12_4, arg_14_0)

				var_12_5.fillAmount = var_14_0

				setText(var_12_6, string.format("%02d%%", math.floor(var_14_0 * 100)))

				return
			end)):setOnComplete(System.Action(arg_13_0))

			return
		end)
	end

	local var_12_7 = arg_12_0:GetIcon(arg_12_1, true)

	arg_12_0.animations:Insert(function(arg_15_0)
		var_12_5.fillAmount = var_12_4

		setText(var_12_6, string.format("%02d%%", math.floor(var_12_4 * 100)))

		if var_12_4 >= 1 then
			arg_12_0.loader:GetSpriteQuiet("ui/LevelStageSSSSFeverPanel_atlas", "icon_" .. var_12_7, arg_12_0.barGroup2.iconImg, true)
		end

		arg_15_0()

		return
	end)

	if var_12_1 and var_12_2 == var_12_3 then
		arg_12_0.PanelAnimations:Insert(function(arg_16_0)
			arg_12_0:ShowPanel(var_12_7, "SyberSquad", arg_16_0)

			return
		end)
	end

	return
end

function var_0_0.ShowPanel(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_0:emit(LevelUIConst.FROZEN)
	pg.UIMgr.GetInstance():BlurPanel(arg_17_0.banner)

	local var_17_0 = arg_17_0.banner:Find(arg_17_2)
	local var_17_1 = var_17_0:Find("Character")
	local var_17_2 = var_17_1:GetComponent(typeof(Image))

	arg_17_0.loader:GetSpriteQuiet("ui/LevelStageSSSSFeverPanel_atlas", arg_17_1, var_17_1, true)
	setActive(arg_17_0.banner, true)
	setAnchoredPosition(var_17_0, {
		x = 2436
	})
	setActive(var_17_0, true)

	var_17_1:GetComponent(typeof(Image)).enabled = true

	if arg_17_4 ~= nil then
		setActive(var_17_0:Find("Word"), false)
		setActive(var_17_0:Find("Word2"), false)
		setActive(var_17_0:Find("Word" .. arg_17_4), true)
	end

	local var_17_3 = var_17_0:GetComponent(typeof(DftAniEvent))

	local function var_17_5()
		table.removebyvalue(arg_17_0.cleanActions, var_17_5)
		var_17_3:SetEndEvent(nil)

		var_17_2.enabled = false
		var_17_2.sprite = nil

		pg.UIMgr.GetInstance():UnOverlayPanel(arg_17_0.banner, arg_17_0._tf)
		setActive(arg_17_0.banner, false)
		setActive(var_17_0, false)
		arg_17_0:emit(LevelUIConst.UN_FROZEN)

		return
	end

	var_17_3:SetEndEvent(function()
		var_17_5()
		existCall(arg_17_3)

		return
	end)
	onButton(arg_17_0, arg_17_0.banner, function()
		var_17_5()
		existCall(arg_17_3)

		return
	end)
	table.insert(arg_17_0.cleanActions, function()
		table.removebyvalue(arg_17_0.cleanActions, var_17_5)
		var_17_3:SetEndEvent(nil)

		var_17_2.enabled = false
		var_17_2.sprite = nil

		pg.UIMgr.GetInstance():UnOverlayPanel(arg_17_0.banner, arg_17_0._tf)
		setActive(arg_17_0.banner, false)
		setActive(var_17_0, false)
		arg_17_0:emit(LevelUIConst.UN_FROZEN)

		return
	end)

	return
end

function var_0_0.CloseActions(arg_20_0)
	if arg_20_0.animations and not arg_20_0.animations.stopped then
		arg_20_0.animations:Stop()
	end

	arg_20_0.animations = nil

	if arg_20_0.PanelAnimations and not arg_20_0.PanelAnimations.stopped then
		arg_20_0.PanelAnimations:Stop()
	end

	arg_20_0.PanelAnimations = nil

	if arg_20_0.cleanActions then
		_.each(arg_20_0.cleanActions, function(arg_21_0)
			arg_21_0()

			return
		end)
	end

	arg_20_0.cleanActions = nil

	arg_20_0.loader:ClearRequests()

	return
end

function var_0_0.OnHide(arg_22_0)
	arg_22_0:CloseActions()

	return
end

return var_0_0
