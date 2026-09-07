local NewBattleResultStatisticsPage = class("NewBattleResultStatisticsPage", import("view.base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 0
local var_0_4 = 1

function NewBattleResultStatisticsPage:getUIName()
	return "NewBattleResultStatisticsPage"
end

function NewBattleResultStatisticsPage:OnLoaded()
	self.mask = self._tf:Find("mask")
	self.paintingTr = self._tf:Find("painting")
	self.resultPaintingTr = self._tf:Find("result")
	self.topPanel = self._tf:Find("top")
	self.gradeIcon = self._tf:Find("top/grade/icon"):GetComponent(typeof(Image))
	self.gradeTxt = self._tf:Find("top/grade/Text"):GetComponent(typeof(Image))
	self.chapterName = self._tf:Find("top/grade/chapterName"):GetComponent(typeof(Text))
	self.opBonus = self._tf:Find("top/grade/operation_bonus")
	self.playerName = self._tf:Find("top/exp/name"):GetComponent(typeof(Text))
	self.playerLv = self._tf:Find("top/exp/lv"):GetComponent(typeof(Text))
	self.playerExp = self._tf:Find("top/exp/Text"):GetComponent(typeof(Text))
	self.playerExpLabel = self._tf:Find("top/exp/Text/exp_label"):GetComponent(typeof(Text))
	self.playerExpBar = self._tf:Find("top/exp/exp_bar/progress"):GetComponent(typeof(Image))
	self.commmanderContainer = self._tf:Find("top/exp/commanders")
	self.shipContainer = self._tf:Find("left")
	self.rawImage = self._tf:Find("bg"):GetComponent(typeof(RawImage))

	setActive(self.rawImage, false)

	self.blackBg = self._tf:Find("black")
	self.bottomPanel = self._tf:Find("bottom")
	self.confrimBtn = self._tf:Find("bottom/confirmBtn")
	self.statisticsBtn = self._tf:Find("bottom/statisticsBtn")
	self.mainFleetBtn = self._tf:Find("bottom/mainFleetBtn")
	self.subFleetBtn = self._tf:Find("bottom/subFleetBtn")
	self.chatText = self._tf:Find("chat/Text"):GetComponent(typeof(Text))

	setText(self.confrimBtn:Find("Text"), i18n("msgbox_text_confirm"))

	self.cg = GetOrAddComponent(self._tf, typeof(CanvasGroup))
	self.commaderTpls = {}
	self.emptyTpls = {
		self._tf:Find("top/exp/emptycomanders/1"),
		self._tf:Find("top/exp/emptycomanders/2")
	}

	setText(self.emptyTpls[1]:Find("Text"), i18n("series_enemy_empty_commander_main"))
	setText(self.emptyTpls[2]:Find("Text"), i18n("series_enemy_empty_commander_assistant"))

	self.surfaceShipTpls = {}
	self.subShipTpls = {}
	self.animationFlags = {
		[var_0_1] = {
			[var_0_3] = false,
			[var_0_4] = false
		},
		[var_0_2] = {
			[var_0_3] = false,
			[var_0_4] = false
		}
	}
	self.animation = NewBattleResultAnimation.New(self._tf)

	return
end

function NewBattleResultStatisticsPage:OnInit()
	self.teamType = var_0_1
	self.displayMode = var_0_3

	return
end

function NewBattleResultStatisticsPage:SetUp(arg_4_1, arg_4_2)
	seriesAsync({
		function(arg_5_0)
			self.cg.alpha = 0

			self:UpdatePainting(arg_5_0)
			self:UpdateGrade()
			self:UpdateChapterName()
			self:UpdateSwitchBtn()
			self:UpdatePlayer()

			return
		end,
		function(arg_6_0)
			self:LoadBG(arg_6_0)

			return
		end,
		function(arg_7_0)
			self.cg.alpha = 1

			self:PlayEnterAnimation(arg_7_0)

			return
		end,
		function(arg_8_0)
			if arg_4_2 then
				arg_4_2()
			end

			self:InitMainView(arg_8_0)

			return
		end
	}, function()
		self:UpdateMetaBtn()
		self:RegisterEvent(arg_4_1)

		return
	end)

	return
end

function NewBattleResultStatisticsPage:InitMainView(arg_10_1)
	self.isEnter = true

	parallelAsync({
		function(arg_11_0)
			self:UpdateCommanders(arg_11_0)

			return
		end,
		function(arg_12_0)
			self:StartEnterAnimation(arg_12_0)

			return
		end,
		function(arg_13_0)
			self:InitShips(arg_13_0)

			return
		end
	}, arg_10_1)

	return
end

function NewBattleResultStatisticsPage:PlayEnterAnimation(arg_14_1)
	if not getProxy(SettingsProxy):IsDisplayResultPainting() then
		if self.resultPaintingData == nil then
			arg_14_1()

			return
		end

		self.animation:ZoomPainting(self.resultPaintingData, arg_14_1)

		return
	end

	self.blackBg.sizeDelta = pg.UIMgr.GetInstance().uiCamera.gameObject.transform:Find("Canvas").sizeDelta

	if self.effectTr then
		self.effectTr.anchorMax = Vector2(0.5, 0.5)
		self.effectTr.anchorMin = Vector2(0.5, 0.5)
		self.effectTr.sizeDelta = GameObject.Find("UICamera/Canvas").transform.sizeDelta
	end

	setAnchoredPosition(self.topPanel, {
		y = 320
	})
	setAnchoredPosition(self.bottomPanel, {
		y = -320
	})

	self.mask.localPosition = self:GetPaintingPosition()

	if self.animation then
		self.animation:Play(self.resultPaintingData, arg_14_1)
	end

	return
end

function NewBattleResultStatisticsPage:LoadBG(arg_15_1)
	local var_15_0 = self._parentTf:Find("Effect")

	if not IsNil(var_15_0) then
		setParent(var_15_0, self._tf)
		var_15_0:SetSiblingIndex(2)

		self.effectTr = var_15_0

		arg_15_1()
	else
		LoadAnyAsync("BattleResultItems/" .. NewBattleResultUtil.Score2Bg(self.contextData.score), "", nil, function(arg_16_0)
			if self.exited or IsNil(arg_16_0) then
				if arg_15_1 then
					arg_15_1()
				end

				return
			end

			local var_16_0 = Object.Instantiate(arg_16_0, self._tf)

			var_16_0.transform:SetSiblingIndex(2)

			self.effectTr = var_16_0.transform

			if arg_15_1 then
				arg_15_1()
			end

			return
		end)
	end

	return
end

function NewBattleResultStatisticsPage:RegisterEvent(arg_17_1)
	onButton(self, self.mainFleetBtn, function()
		self.teamType = var_0_1

		self:UpdateShips(false)
		self:UpdateCommanders(function()
			return
		end)
		self:UpdateSwitchBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.subFleetBtn, function()
		self.teamType = var_0_2

		self:UpdateShips(false)
		self:UpdateCommanders(function()
			return
		end)
		self:UpdateSwitchBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.statisticsBtn, function()
		self.displayMode = 1 - self.displayMode

		self:UpdateShipDetail()

		return
	end, SFX_PANEL)
	onButton(self, self.confrimBtn, function()
		arg_17_1()

		return
	end, SFX_PANEL)

	if self.contextData.autoSkipFlag then
		onNextTick(function()
			triggerButton(self.confrimBtn)

			return
		end)
	end

	return
end

local function var_0_5(arg_25_0, arg_25_1)
	onButton(arg_25_0, arg_25_1, function()
		setActive(arg_25_1, false)

		if arg_25_0.metaExpView then
			return
		end

		arg_25_0.metaExpView = BattleResultMetaExpView.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)

		arg_25_0.metaExpView:setData(getProxy(MetaCharacterProxy):getLastMetaSkillExpInfoList(), function()
			if arg_25_1 then
				setActive(arg_25_1, true)
			end

			arg_25_0.metaExpView = nil

			return
		end)
		arg_25_0.metaExpView:Reset()
		arg_25_0.metaExpView:Load()
		arg_25_0.metaExpView:ActionInvoke("Show")
		arg_25_0.metaExpView:ActionInvoke("openPanel")

		return
	end, SFX_PANEL)

	return
end

function NewBattleResultStatisticsPage:UpdateMetaBtn()
	local var_28_0 = getProxy(MetaCharacterProxy):getLastMetaSkillExpInfoList()

	if var_28_0 and #var_28_0 > 0 then
		LoadAnyAsync("BattleResultItems/MetaBtn", "", nil, function(arg_29_0)
			if self.exited or IsNil(arg_29_0) then
				return
			end

			var_0_5(self, Object.Instantiate(arg_29_0, self._tf).transform)

			return
		end)
	end

	return
end

function NewBattleResultStatisticsPage:StartEnterAnimation(arg_30_1)
	LeanTween.value(self.topPanel.gameObject, 320, 0, 0.2):setOnUpdate(System.Action_float(function(arg_31_0)
		setAnchoredPosition(self.topPanel, {
			y = arg_31_0
		})

		return
	end))
	LeanTween.value(self.bottomPanel.gameObject, -320, 0, 0.2):setOnUpdate(System.Action_float(function(arg_32_0)
		setAnchoredPosition(self.bottomPanel, {
			y = arg_32_0
		})

		return
	end)):setOnComplete(System.Action(arg_30_1))

	return
end

function NewBattleResultStatisticsPage:GetShipSlotExpandPosition(arg_33_1)
	return Vector2(1300, self:GetShipSlotShrinkPosition(arg_33_1).y)
end

function NewBattleResultStatisticsPage:GetShipSlotShrinkPosition(arg_34_1)
	return Vector2(500, 250) + (arg_34_1 - 1) * Vector2(69.55, -117.7)
end

local function var_0_6(arg_35_0, arg_35_1, arg_35_2)
	local var_35_1 = arg_35_0 and arg_35_0[arg_35_2]

	return (arg_35_1 or var_35_1 or nil) and (arg_35_1 and arg_35_1:getConfig("name") or var_35_1 and i18n("Word_Ship_Exp_Buff"))
end

function NewBattleResultStatisticsPage:GetAnimationFlag()
	if self.contextData.autoSkipFlag then
		return false
	end

	if self.animationFlags[self.teamType][self.displayMode] == false then
		self.animationFlags[self.teamType][self.displayMode] = true
	end

	return not self.animationFlags[self.teamType][self.displayMode]
end

function NewBattleResultStatisticsPage:UpdateShipDetail()
	local var_37_0 = self.teamType == var_0_1
	local var_37_1

	if self.teamType == var_0_1 then
		var_37_1 = self.surfaceShipTpls or self.subShipTpls
	end

	local var_37_2, var_37_3 = NewBattleResultUtil.SeparateSurfaceAndSubShips(self.contextData.oldMainShips)
	local var_37_4 = var_37_0 and var_37_2 or var_37_3
	local var_37_5 = self.displayMode == var_0_3
	local var_37_6 = self.contextData.expBuff
	local var_37_7 = self.contextData.buffShips
	local var_37_8 = NewBattleResultUtil.GetMaxOutput(self.contextData.oldMainShips, self.contextData.statistics)

	self.numeberAnimations = {}

	local var_37_9 = self:GetAnimationFlag()

	for iter_37_0, iter_37_1 in ipairs(var_37_4) do
		local var_37_10 = self.contextData.statistics[iter_37_1.id] or {}
		local var_37_11 = var_37_1[iter_37_0]
		local var_37_12 = self.contextData.newMainShips[iter_37_1.id]

		local function var_37_13()
			setText(var_37_11:Find("atk"), not var_37_5 and (var_37_10.output or 0) or "EXP" .. "<color=#FFDE38>+" .. NewBattleResultUtil.GetShipExpOffset(iter_37_1, var_37_12) .. "</color>")
			setText(var_37_11:Find("killCount"), not var_37_5 and (var_37_10.kill_count or 0) or "Lv." .. var_37_12.level)

			local var_38_4 = var_37_11:Find("dmg/bar"):GetComponent(typeof(Image))

			if not var_37_5 then
				var_38_4.fillAmount = (var_37_10.output or 0) / var_37_8 or var_37_12:getExp() / getExpByRarityFromLv1(var_37_12:getConfig("rarity"), var_37_12.level)
			end

			return
		end

		if var_37_9 then
			local var_37_14 = NewBattleResultShipCardAnimation.New(var_37_11, var_37_5, iter_37_1, self.contextData.newMainShips[iter_37_1.id], var_37_10, var_37_8)

			var_37_14:SetUp(var_37_13)
			table.insert(self.numeberAnimations, var_37_14)
		end

		local var_37_15

		do
			var_37_13()

			var_37_15 = not var_37_5 and i18n("battle_result_kill_count") or iter_37_1:getName()
		end

		setText(var_37_11:Find("kill_count_label"), var_37_15)
		setText(var_37_11:Find("dmg_count_label"), not var_37_5 and i18n("battle_result_dmg") or var_0_6(var_37_7, var_37_6, iter_37_1:getGroupId()) or "")
	end

	return
end

local function var_0_7(arg_39_0, arg_39_1)
	if IsNil((arg_39_1:Find("MVP"))) then
		LoadAnyAsync("BattleResultItems/MVP", "", nil, function(arg_40_0)
			if arg_39_0.exited or IsNil(arg_40_0) then
				return
			end

			Object.Instantiate(arg_40_0, arg_39_1).name = "MVP"

			return
		end)
	end

	if IsNil((arg_39_1:Find("MVPBG"))) then
		LoadAnyAsync("BattleResultItems/MVPBG", "", nil, function(arg_41_0)
			if arg_39_0.exited or IsNil(arg_41_0) then
				return
			end

			local var_41_0 = Object.Instantiate(arg_41_0, arg_39_1)

			var_41_0.name = "MVPBG"

			var_41_0.transform:SetAsFirstSibling()

			return
		end)
	end

	return
end

local function var_0_8(arg_42_0, arg_42_1)
	if IsNil((arg_42_1:Find("LevelUp"))) then
		LoadAnyAsync("BattleResultItems/LevelUp", "", nil, function(arg_43_0)
			if arg_42_0.exited or IsNil(arg_43_0) then
				return
			end

			Object.Instantiate(arg_43_0, arg_42_1).name = "LevelUp"

			return
		end)
	end

	return
end

local function var_0_9(arg_44_0, arg_44_1)
	if IsNil((arg_44_1:Find("Intmacy"))) then
		ResourceMgr.Inst:getAssetAsync("ui/zhandoujiesuan_xingxing", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_45_0)
			if arg_44_0.exited or IsNil(arg_45_0) then
				return
			end

			Object.Instantiate(arg_45_0, arg_44_1).name = "Intmacy"

			return
		end), true, true)
	end

	return
end

local function var_0_10(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	local var_46_0 = arg_46_1:Find("mask/icon"):GetComponent(typeof(Image))

	var_46_0.sprite = LoadSprite("herohrzicon/" .. arg_46_2:getPainting())
	var_46_0.gameObject.transform.sizeDelta = Vector2(432, 96)

	setImageSprite(arg_46_1:Find("type"), GetSpriteFromAtlas("shiptype", shipType2print(arg_46_2:getShipType())), true)

	local var_46_1 = arg_46_2:getMaxStar()
	local var_46_2 = UIItemList.New(arg_46_1:Find("stars"), arg_46_1:Find("stars/star_tpl"))
	local var_46_3 = var_46_1 - arg_46_2:getStar()

	var_46_2:make(function(arg_47_0, arg_47_1, arg_47_2)
		if arg_47_0 == UIItemList.EventUpdate then
			local var_47_0 = arg_47_1 + 1 <= var_46_3

			SetActive(arg_47_2:Find("empty"), arg_47_1 + 1 <= var_46_3)
			SetActive(arg_47_2:Find("star"), not var_47_0)
		end

		return
	end)
	var_46_2:align(var_46_1)

	if arg_46_3 then
		var_0_7(arg_46_0, arg_46_1)
	end

	if arg_46_4 then
		var_0_8(arg_46_0, arg_46_1)
	end

	if arg_46_5 then
		onDelayTick(function()
			if arg_46_0.exited then
				return
			end

			var_0_9(arg_46_0, arg_46_1)

			return
		end, 1)
	end

	return
end

function NewBattleResultStatisticsPage:InitShips(arg_49_1)
	self:UpdateShips(true, arg_49_1)

	return
end

function NewBattleResultStatisticsPage:UpdateShips(arg_50_1, arg_50_2)
	local var_50_0

	if self.teamType == var_0_1 then
		var_50_0 = self.surfaceShipTpls or self.subShipTpls

		local var_50_1

		if self.teamType == var_0_1 then
			var_50_1 = self.subShipTpls or self.surfaceShipTpls
		end
	end

	local var_50_2, var_50_3 = NewBattleResultUtil.SeparateSurfaceAndSubShips(self.contextData.oldMainShips)
	local var_50_4 = self.teamType == var_0_1 and var_50_2 or var_50_3

	self:LoadShipTpls(var_50_0, self.teamType == var_0_1 and var_50_2 or var_50_3, function()
		for iter_51_0, iter_51_1 in ipairs(var_50_4) do
			var_50_0[iter_51_0]:GetComponent(typeof(CanvasGroup)).alpha = 1
			var_50_0[iter_51_0].anchoredPosition = self:GetShipSlotExpandPosition(iter_51_0)

			local var_51_0 = self.contextData.newMainShips[iter_51_1.id]

			var_0_10(self, var_50_0[iter_51_0], iter_51_1, self.contextData.statistics.mvpShipID and self.contextData.statistics.mvpShipID == iter_51_1.id, var_51_0.level > iter_51_1.level, var_51_0:getIntimacy() > iter_51_1:getIntimacy())
		end

		self:UpdateShipDetail()
		self:StartShipsEnterAnimation(var_50_0, arg_50_1 and 0.6 or 0, arg_50_2)

		return
	end)

	for iter_50_0, iter_50_1 in ipairs(var_50_1) do
		iter_50_1:GetComponent(typeof(CanvasGroup)).alpha = 0
	end

	return
end

function NewBattleResultStatisticsPage:LoadShipTpls(arg_52_1, arg_52_2, arg_52_3)
	local var_52_0 = {}

	if #arg_52_1 < #arg_52_2 then
		table.insert(var_52_0, function(arg_53_0)
			LoadAnyAsync("BattleResultItems/Ship", "", nil, function(arg_54_0)
				if self.exited then
					arg_53_0()

					return
				end

				arg_53_0(arg_54_0)

				return
			end)

			return
		end)
		table.insert(var_52_0, function(arg_55_0, arg_55_1)
			if not arg_55_1 then
				arg_55_0()

				return
			end

			for iter_55_0 = #arg_52_1 + 1, #arg_52_2 do
				local var_55_0 = Object.Instantiate(arg_55_1, self.shipContainer).transform

				var_55_0:GetComponent(typeof(CanvasGroup)).alpha = 0

				table.insert(arg_52_1, var_55_0)
			end

			arg_55_0()

			return
		end)
	end

	seriesAsync(var_52_0, arg_52_3)

	return
end

function NewBattleResultStatisticsPage:StartShipsEnterAnimation(arg_56_1, arg_56_2, arg_56_3)
	if arg_56_2 <= 0 then
		for iter_56_0, iter_56_1 in ipairs(arg_56_1) do
			iter_56_1.anchoredPosition = self:GetShipSlotShrinkPosition(iter_56_0)
		end

		return
	end

	local var_56_0 = {}

	for iter_56_2, iter_56_3 in ipairs(arg_56_1) do
		local var_56_1 = iter_56_3:GetComponent(typeof(CanvasGroup))

		var_56_1.alpha = 0

		local var_56_2 = self:GetShipSlotExpandPosition(iter_56_2)
		local var_56_3 = self:GetShipSlotShrinkPosition(iter_56_2)

		table.insert(var_56_0, function(arg_57_0)
			if self.exited then
				return
			end

			var_56_1.alpha = 1

			LeanTween.value(iter_56_3.gameObject, var_56_2.x, var_56_3.x, arg_56_2 - (iter_56_2 - 1) * 0.1):setOnUpdate(System.Action_float(function(arg_58_0)
				iter_56_3.anchoredPosition = Vector3(arg_58_0, iter_56_3.anchoredPosition.y, 0)

				return
			end))
			onDelayTick(arg_57_0, 0.1)

			return
		end)
	end

	seriesAsync(var_56_0, arg_56_3)

	return
end

function NewBattleResultStatisticsPage:UpdateSwitchBtn()
	local var_59_0 = NewBattleResultUtil.HasSubShip(self.contextData.oldMainShips)
	local var_59_1 = NewBattleResultUtil.HasSurfaceShip(self.contextData.oldMainShips)

	setActive(self.mainFleetBtn, self.teamType == var_0_2 and var_59_1 and var_59_0)
	setActive(self.subFleetBtn, self.teamType == var_0_1 and var_59_1 and var_59_0)

	if not var_59_1 then
		self.teamType = var_0_2
	end

	return
end

function NewBattleResultStatisticsPage:UpdateMvpPainting(arg_60_1)
	local var_60_0, var_60_1, var_60_2, var_60_3 = NewBattleResultUtil.SeparateMvpShip(self.contextData.oldMainShips, self.contextData.statistics.mvpShipID, self.contextData.statistics._flagShipID)

	var_60_3 = var_60_3 or self.contextData.oldMainShips[#self.contextData.oldMainShips - 1]

	local var_60_4 = self.resultPaintingTr
	local var_60_5 = var_60_3:getPainting()

	setPaintingPrefabAsync(self.resultPaintingTr, var_60_5, "jiesuan", function()
		ShipExpressionHelper.SetExpression(findTF(var_60_4, "fitter"):GetChild(0), var_60_5, ShipWordHelper.WORD_TYPE_MVP, var_60_3:getCVIntimacy())
		self:RecordPainting(arg_60_1)

		return
	end)
	self:DisplayShipDialogue(var_60_3)

	return
end

function NewBattleResultStatisticsPage:RecordPainting(arg_62_1)
	onNextTick(function()
		local var_63_0 = self.resultPaintingTr:Find("fitter"):GetChild(0)

		if not IsNil(var_63_0) then
			self.resultPaintingData = {
				position = Vector2(var_63_0.position.x, var_63_0.position.y),
				pivot = rtf(var_63_0).pivot,
				scale = Vector2(var_63_0.localScale.x, var_63_0.localScale.y)
			}

			SetParent(var_63_0, self.paintingTr:Find("painting/fitter"), true)
		end

		arg_62_1()

		return
	end)

	return
end

function NewBattleResultStatisticsPage:UpdateFailedPainting(arg_64_1)
	LoadAnyAsync("BattleResultItems/FailedPainting", "", nil, function(arg_65_0)
		if self.exited or IsNil(arg_65_0) then
			arg_64_1()

			return
		end

		Object.Instantiate(arg_65_0, self.paintingTr).transform:SetAsFirstSibling()
		arg_64_1()

		return
	end)
	self:DisplayShipDialogue(self.contextData.oldMainShips[math.random(#self.contextData.oldMainShips)])

	return
end

function NewBattleResultStatisticsPage:GetPaintingPosition()
	return (NewBattleResultDisplayPaintingsPage.StaticGetFinalExpandPosition(#self.contextData.oldMainShips))
end

function NewBattleResultStatisticsPage:UpdatePaintingPosition()
	self.paintingTr.localPosition = self:GetPaintingPosition()

	return
end

function NewBattleResultStatisticsPage:UpdatePainting(arg_68_1)
	self:UpdatePaintingPosition()

	if self.contextData.score > 1 then
		self:UpdateMvpPainting(arg_68_1)
	else
		self:UpdateFailedPainting(arg_68_1)
	end

	return
end

function NewBattleResultStatisticsPage:DisplayShipDialogue(arg_69_1)
	local var_69_1

	if self.contextData.score > 1 then
		local var_69_3, var_69_4

		var_69_3, var_69_4, var_69_1 = ShipWordHelper.GetWordAndCV(arg_69_1.skinId, ShipWordHelper.WORD_TYPE_MVP, nil, nil, arg_69_1:getCVIntimacy())
	else
		local var_69_5, var_69_6

		var_69_5, var_69_6, var_69_1 = ShipWordHelper.GetWordAndCV(arg_69_1.skinId, ShipWordHelper.WORD_TYPE_LOSE, nil, nil, arg_69_1:getCVIntimacy())
	end

	self.chatText.text = var_69_1

	if #var_69_1 > CHAT_POP_STR_LEN then
		self.chatText.alignment = TextAnchor.MiddleLeft or TextAnchor.MiddleCenter
	end

	self:PlayMvpShipVoice()

	return
end

function NewBattleResultStatisticsPage:PlayMvpShipVoice()
	if not self.contextData.statistics.mvpShipID or type(self.contextData.statistics.mvpShipID) == "number" and self.contextData.statistics.mvpShipID <= 0 then
		return
	end

	local var_70_0 = _.detect(self.contextData.oldMainShips, function(arg_71_0)
		return arg_71_0.id == self.contextData.statistics.mvpShipID
	end)

	assert(var_70_0)

	local var_70_3

	if self.contextData.score > 1 then
		local var_70_4, var_70_5

		var_70_4, var_70_3, var_70_5 = ShipWordHelper.GetWordAndCV(var_70_0.skinId, ShipWordHelper.WORD_TYPE_MVP, nil, nil, var_70_0:getCVIntimacy())
	else
		local var_70_6, var_70_7

		var_70_6, var_70_3, var_70_7 = ShipWordHelper.GetWordAndCV(var_70_0.skinId, ShipWordHelper.WORD_TYPE_LOSE)
	end

	if var_70_3 then
		self:StopVoice()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_70_3, function(arg_72_0)
			self._currentVoice = arg_72_0

			return
		end)
	end

	return
end

function NewBattleResultStatisticsPage:StopVoice()
	if self._currentVoice then
		self._currentVoice:PlaybackStop()

		self._currentVoice = nil
	end

	return
end

function NewBattleResultStatisticsPage:UpdateGrade()
	local var_74_0, var_74_1 = NewBattleResultUtil.Score2Grade(self.contextData.score, self.contextData._scoreMark)

	LoadImageSpriteAsync(var_74_0, self.gradeIcon, false)
	LoadImageSpriteAsync(var_74_1, self.gradeTxt, false)

	return
end

function NewBattleResultStatisticsPage:UpdateChapterName()
	self.chapterName.text = NewBattleResultUtil.GetChapterName(self.contextData)

	setActive(self.opBonus, NewBattleResultUtil.IsOpBonus(self.contextData.extraBuffList))

	return
end

function NewBattleResultStatisticsPage:UpdatePlayer()
	local var_76_0 = self.contextData.oldPlayer
	local var_76_1 = getProxy(PlayerProxy):getRawData()

	self.playerName.text = var_76_1:GetName()

	local function var_76_2()
		self.playerLv.text = "Lv." .. var_76_1.level
		self.playerExp.text = "+" .. NewBattleResultUtil.GetPlayerExpOffset(var_76_0, var_76_1)
		self.playerExpLabel.text = "EXP"
		self.playerExpBar.fillAmount = var_76_1.level == var_76_1:getMaxLevel() and 1 or var_76_1.exp / getConfigFromLevel1(pg.user_level, var_76_1.level).exp_interval

		return
	end

	if not self.contextData.autoSkipFlag then
		local var_76_3 = NewBattleResultPlayerAniamtion.New(self.playerLv, self.playerExp, self.playerExpBar, var_76_1, self.contextData.oldPlayer)

		var_76_3:SetUp(var_76_2)

		self.playerAniamtion = var_76_3
	else
		var_76_2()
	end

	return
end

local function var_0_11(arg_78_0, arg_78_1, arg_78_2)
	GetImageSpriteFromAtlasAsync("commandericon/" .. arg_78_2:getPainting(), "", arg_78_0:Find("icon"))
	setText(arg_78_0:Find("name_text"), arg_78_2:getName())
	setText(arg_78_0:Find("lv_text"), "Lv." .. arg_78_2.level)
	setText(arg_78_0:Find("exp"), "+" .. arg_78_1.exp)

	arg_78_0:Find("exp_bar/progress"):GetComponent(typeof(Image)).fillAmount = arg_78_2:isMaxLevel() and 1 or arg_78_1.curExp / arg_78_2:getNextLevelExp()

	return
end

function NewBattleResultStatisticsPage:UpdateCommanders(arg_79_1)
	local var_79_0 = self.contextData.commanderExps or {}
	local var_79_1

	if self.teamType == var_0_1 then
		var_79_1 = var_79_0.surfaceCMD or var_79_0.submarineCMD
	end

	var_79_1 = var_79_1 or {}

	local function var_79_2()
		for iter_80_0 = 1, #var_79_1 do
			local var_80_0 = getProxy(CommanderProxy):getCommanderById(var_79_1[iter_80_0].commander_id)

			setActive(self.commaderTpls[iter_80_0], true)
			var_0_11(self.commaderTpls[iter_80_0], var_79_1[iter_80_0], var_80_0)
		end

		for iter_80_1 = #self.commaderTpls, #var_79_1 + 1, -1 do
			setActive(self.commaderTpls[iter_80_1], false)
		end

		return
	end

	for iter_79_0 = 1, #self.emptyTpls do
		setActive(self.emptyTpls[iter_79_0], var_79_1[iter_79_0] == nil)
	end

	self:LoadCommanderTpls(#var_79_1, var_79_2)
	arg_79_1()

	return
end

function NewBattleResultStatisticsPage:LoadCommanderTpls(arg_81_1, arg_81_2)
	local var_81_0 = {}

	if arg_81_1 > #self.commaderTpls then
		table.insert(var_81_0, function(arg_82_0)
			LoadAnyAsync("BattleResultItems/Commander", "", nil, function(arg_83_0)
				if self.exited then
					arg_82_0()

					return
				end

				arg_82_0(arg_83_0)

				return
			end)

			return
		end)
		table.insert(var_81_0, function(arg_84_0, arg_84_1)
			if not arg_84_1 then
				arg_84_0()

				return
			end

			for iter_84_0 = #self.commaderTpls + 1, arg_81_1 do
				table.insert(self.commaderTpls, Object.Instantiate(arg_84_1, self.commmanderContainer).transform)
			end

			arg_84_0()

			return
		end)
	end

	seriesAsync(var_81_0, arg_81_2)

	return
end

function NewBattleResultStatisticsPage:onBackPressed()
	if self.metaExpView then
		self.metaExpView:closePanel()

		self.metaExpView = nil

		return true
	end

	return false
end

function NewBattleResultStatisticsPage:OnDestroy()
	self.exited = true

	if self.metaExpView then
		self.metaExpView:Destroy()

		self.metaExpView = nil
	end

	if self:isShowing() then
		self:Hide()
	end

	if self.animation then
		self.animation:Dispose()
	end

	self.animation = nil

	if LeanTween.isTweening(self.topPanel.gameObject) then
		LeanTween.cancel(self.topPanel.gameObject)
	end

	if LeanTween.isTweening(self.bottomPanel.gameObject) then
		LeanTween.cancel(self.bottomPanel.gameObject)
	end

	if self.surfaceShipTpls then
		for iter_86_0, iter_86_1 in ipairs(self.surfaceShipTpls) do
			if LeanTween.isTweening(iter_86_1.gameObject) then
				LeanTween.cancel(iter_86_1.gameObject)
			end
		end
	end

	if self.subShipTpls then
		for iter_86_2, iter_86_3 in ipairs(self.subShipTpls) do
			if LeanTween.isTweening(iter_86_3.gameObject) then
				LeanTween.cancel(iter_86_3.gameObject)
			end
		end
	end

	if self.numeberAnimations then
		for iter_86_4, iter_86_5 in ipairs(self.numeberAnimations) do
			iter_86_5:Dispose()
		end
	end

	if self.playerAniamtion then
		self.playerAniamtion:Dispose()

		self.playerAniamtion = nil
	end

	return
end

return NewBattleResultStatisticsPage
