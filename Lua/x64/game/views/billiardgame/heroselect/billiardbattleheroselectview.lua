local var_0_0 = class("BilliardBattleHeroSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/BilliardGame/BilliardGame_BattlePopUI"
end

local var_0_1 = {
	Exchange = "BILLIARD_GAME_EXCHANGE_CAMP",
	EnterCamp = "BILLIARD_GAME_ENTER_CAMP",
	ExitCamp = "BILLIAR_GAME_EXIT_CAMP"
}

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.heroLuaList = LuaList.New(handler(arg_4_0, arg_4_0.OnRenderItem), arg_4_0.heroListObj_, BilliardBattleHeroPopModule)
	arg_4_0.mainController = arg_4_0.controller_:GetController("mode")
	arg_4_0.btnController = arg_4_0.enterController_:GetController("statelock01")
	arg_4_0.exchangeContext = arg_4_0:BuildExchangeContext()
	arg_4_0.teamHeroSlots = {
		BilliardBattleTeamHeroModule.New(arg_4_0.teamHeroObj1_, arg_4_0.exchangeContext, 1),
		BilliardBattleTeamHeroModule.New(arg_4_0.teamHeroObj2_, arg_4_0.exchangeContext, 2),
		(BilliardBattleTeamHeroModule.New(arg_4_0.teamHeroObj3_, arg_4_0.exchangeContext, 3))
	}

	arg_4_0:InitPanel()
end

function var_0_0.BuildExchangeContext(arg_5_0)
	local var_5_0 = arg_5_0

	return {
		curStage = -1,
		curSelectedHero = -1,
		slots = {},
		reverseMap = {},
		IsInExchange = function(arg_6_0)
			return arg_6_0.waitExchangeId ~= nil
		end,
		GetExchangeHeroId = function(arg_7_0)
			return arg_7_0.waitExchangeId
		end,
		GetSlotCount = function(arg_8_0)
			local var_8_0 = 0

			for iter_8_0 = 1, 3 do
				if arg_8_0:GetSlotHero(iter_8_0) then
					var_8_0 = var_8_0 + 1
				end
			end

			return var_8_0
		end,
		ExchangeSlot = function(arg_9_0, arg_9_1)
			local var_9_0 = arg_9_0:GetSlotHero(arg_9_1)

			arg_9_0:RemoveHero(var_9_0)
			arg_9_0:AddHeroToSlot(arg_9_0.waitExchangeId)

			arg_9_0.waitExchangeId = nil

			manager.notify:Invoke(BilliardGameEvent.BILLIARD_POP_VIEW_EXCHANGE_HERO)
			var_5_0:ChangeExchangeBtnStatus()
		end,
		AddHeroToSlot = function(arg_10_0, arg_10_1, arg_10_2)
			local var_10_0 = arg_10_2 or -1

			if var_10_0 == -1 then
				for iter_10_0 = 1, 3 do
					if not arg_10_0:GetSlotHero(iter_10_0) then
						var_10_0 = iter_10_0

						break
					end
				end
			end

			if var_10_0 == -1 then
				return
			end

			if arg_10_0.slots[var_10_0] then
				arg_10_0:RemoveHero(arg_10_0.slots[var_10_0])
			end

			arg_10_0.slots[var_10_0] = arg_10_1
			arg_10_0.reverseMap[arg_10_1] = var_10_0

			manager.notify:Invoke(BilliardGameEvent.BILLIARD_POP_VIEW_ADD_HERO, arg_10_1)
			var_5_0:ChangeExchangeBtnStatus()
		end,
		RemoveHero = function(arg_11_0, arg_11_1)
			if arg_11_0.reverseMap[arg_11_1] then
				arg_11_0.slots[arg_11_0.reverseMap[arg_11_1]] = nil
				arg_11_0.reverseMap[arg_11_1] = nil

				manager.notify:Invoke(BilliardGameEvent.BILLIARD_POP_VIEW_REMOVE_HERO, arg_11_1)
			end

			var_5_0:ChangeExchangeBtnStatus()
		end,
		GetSlotHero = function(arg_12_0, arg_12_1)
			return arg_12_0.slots[arg_12_1]
		end,
		IsHeroInSlot = function(arg_13_0, arg_13_1)
			if arg_13_0.reverseMap[arg_13_1] then
				return true
			end

			return false
		end,
		IsHeroInSelected = function(arg_14_0, arg_14_1)
			return arg_14_0.curSelectedHero == arg_14_1
		end,
		SelectHero = function(arg_15_0, arg_15_1)
			arg_15_0.curSelectedHero = arg_15_1

			var_5_0:RenderSelectHeroInfo()
			var_5_0:ChangeExchangeBtnStatus()
			manager.notify:Invoke(BilliardGameEvent.BILLIARD_POP_VIEW_SELECT_HERO, arg_15_1)
		end,
		SlotIsFull = function(arg_16_0)
			if arg_16_0:GetSlotHero(1) and arg_16_0:GetSlotHero(2) and arg_16_0:GetSlotHero(3) then
				return true
			end

			return false
		end,
		Reset = function(arg_17_0)
			arg_17_0.slots = {}
			arg_17_0.waitExchangeId = nil
			arg_17_0.reverseMap = {}
			arg_17_0.curSelectedHero = -1
		end,
		SaveSlot = function(arg_18_0)
			local var_18_0 = {
				-1,
				-1,
				-1
			}

			for iter_18_0 = 1, 3 do
				if not arg_18_0:GetSlotHero(iter_18_0) then
					var_18_0[iter_18_0] = -1
				else
					var_18_0[iter_18_0] = arg_18_0:GetSlotHero(iter_18_0)
				end
			end

			saveData("BilliardSaveSlot", "slot", var_18_0)
		end,
		RecoverSlot = function(arg_19_0)
			local var_19_0 = getData("BilliardSaveSlot", "slot")

			if var_19_0 then
				if var_19_0[1] and var_19_0[1] ~= -1 then
					arg_19_0:AddHeroToSlot(var_19_0[1], 1)
				end

				if var_19_0[2] and var_19_0[2] ~= -1 then
					arg_19_0:AddHeroToSlot(var_19_0[2], 2)
				end

				if var_19_0[3] and var_19_0[3] ~= -1 then
					arg_19_0:AddHeroToSlot(var_19_0[3], 3)
				end
			end
		end
	}
end

function var_0_0.AddUIListener(arg_20_0)
	arg_20_0:AddBtnListener(arg_20_0.entraceBtn_, arg_20_0, function()
		arg_20_0:EntraceBattle()
	end)
	arg_20_0:AddBtnListener(arg_20_0.maskBtn_, arg_20_0, function()
		arg_20_0:Back()
	end)
	arg_20_0:AddBtnListener(arg_20_0.disBtn_, arg_20_0, function()
		ShowTips(GetTips("NYA_SUMMER_PINBALL_HERO_INSUFFICIENT_TIP"))
	end)
end

function var_0_0.OnEnter(arg_24_0)
	arg_24_0.exchangeContext:Reset()
	arg_24_0:InitPanelView()

	if not arg_24_0.heroLuaList then
		arg_24_0.heroLuaList = LuaList.New(handler(arg_24_0, arg_24_0.OnRenderItem), arg_24_0.heroListObj_, BilliardBattleHeroPopModule)
	end

	arg_24_0.heroList = arg_24_0:GetAllRenderHero()

	arg_24_0.heroLuaList:StartScroll(#arg_24_0.heroList)

	arg_24_0.stage_id = arg_24_0.params_.stageID
	arg_24_0.levelID = arg_24_0.params_.levelID
	arg_24_0.isEasy = arg_24_0.params_.isEasy

	arg_24_0.mainController:SetSelectedState(arg_24_0.isEasy and "Ordinary" or "Difficult")

	local var_24_0 = SummerPubLevelCfg[arg_24_0.levelID]

	arg_24_0.stageBg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_SummerPub/BilliardGame/Stage/" .. var_24_0.background_1)

	arg_24_0.exchangeContext:SelectHero(arg_24_0.heroList[1])

	local var_24_1 = "TextureBg/Activity_SummerPub/BilliardGame/BilliardGamebg_0" .. var_24_0.area

	arg_24_0.bgImg_.sprite = pureGetSpriteWithoutAtlas(var_24_1)

	arg_24_0:ChangeExchangeBtnStatus()
	arg_24_0.exchangeContext:RecoverSlot()
end

function var_0_0.InitPanelView(arg_25_0)
	arg_25_0.teamHeroSlots[1]:OnRender()
	arg_25_0.teamHeroSlots[2]:OnRender()
	arg_25_0.teamHeroSlots[3]:OnRender()
	arg_25_0:InitPanel()
end

function var_0_0.InitPanel(arg_26_0)
	arg_26_0.startGameTxt_.text = GetI18NText(GetTips("MATRIX_PREPARE_START_CHALLENGE"))
	arg_26_0.startGame2Txt_.text = GetI18NText(GetTips("MATRIX_PREPARE_START_CHALLENGE"))
	arg_26_0.skillTxt_.text = ""
end

function var_0_0.OnRenderItem(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.exchangeContext.curStage = arg_27_0.stage_id

	arg_27_2:OnRenderHero(arg_27_0.heroList[arg_27_1], arg_27_0.exchangeContext)
end

function var_0_0.GetAllRenderHero(arg_28_0)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(SummerPubHeroCfg.all) do
		if (SummerPubHeroCfg[iter_28_1].type == 2 or SummerPubHeroCfg[iter_28_1].type == 3) and SummerPubData:isUnlockPartner(iter_28_1) then
			table.insert(var_28_0, iter_28_1)
		end
	end

	return var_28_0
end

function var_0_0.EntraceBattle(arg_29_0)
	if not arg_29_0.exchangeContext.slots[1] or not arg_29_0.exchangeContext.slots[2] or not arg_29_0.exchangeContext.slots[3] then
		ShowTips(GetTips("NYA_SUMMER_PINBALL_HERO_INSUFFICIENT_TIP"))

		return
	end

	arg_29_0:Back()

	if arg_29_0.stage_id == 40301 and SummerPubData:GetPinballClearNumByStageID(40301) == 0 then
		LaunchBilliardGame(arg_29_0.levelID, arg_29_0.stage_id, {
			40301,
			40302,
			40303
		})

		return
	end

	LaunchBilliardGame(arg_29_0.levelID, arg_29_0.stage_id, {
		arg_29_0.exchangeContext.slots[1],
		arg_29_0.exchangeContext.slots[2],
		arg_29_0.exchangeContext.slots[3]
	})
end

function var_0_0.RenderSelectHeroInfo(arg_30_0)
	local var_30_0 = SummerPubHeroCfg[arg_30_0.exchangeContext.curSelectedHero]
	local var_30_1 = BilliardSkillCfg[var_30_0.skill]

	arg_30_0.titleTxt_.text = var_30_0.hero_name
	arg_30_0.healthTxt_.text = var_30_0.base_attribute[2]
	arg_30_0.attackTxt_.text = var_30_0.base_attribute[1]
	arg_30_0.hungryTxt_.text = var_30_0.base_attribute[3]

	if var_30_1 then
		arg_30_0.skillTxt_.text = var_30_1.skill_desc
	end
end

function var_0_0.ChangeExchangeBtnStatus(arg_31_0)
	local var_31_0 = arg_31_0.exchangeContext

	arg_31_0.stageTxt_.text = GetI18NText(GetTips("BILLIARD_GAME_ENTER_CAMP")) .. " " .. arg_31_0.exchangeContext:GetSlotCount() .. "/3"

	if arg_31_0.exchangeContext:GetSlotCount() == 3 then
		arg_31_0.btnController:SetSelectedState("normal01")
		SetActive(arg_31_0.tipsObj_, false)
	else
		arg_31_0.btnController:SetSelectedState("lock01")
		SetActive(arg_31_0.tipsObj_, true)
	end
end

function var_0_0.OnExit(arg_32_0)
	var_0_0.super.OnExit(arg_32_0)
	arg_32_0.exchangeContext:SaveSlot()
	arg_32_0.heroLuaList:Dispose()

	arg_32_0.heroLuaList = nil
end

function var_0_0.Dispose(arg_33_0)
	arg_33_0.teamHeroSlots[1]:Dispose()
	arg_33_0.teamHeroSlots[2]:Dispose()
	arg_33_0.teamHeroSlots[3]:Dispose()

	arg_33_0.teamHeroSlots = nil

	if arg_33_0.heroLuaList then
		arg_33_0.heroLuaList:Dispose()

		arg_33_0.heroLuaList = nil
	end

	var_0_0.super.Dispose(arg_33_0)
end

return var_0_0
