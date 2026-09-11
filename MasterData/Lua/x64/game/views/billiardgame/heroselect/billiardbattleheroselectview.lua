local BilliardBattleHeroSelectView = class("BilliardBattleHeroSelectView", ReduxView)

function BilliardBattleHeroSelectView:UIName()
	return "Widget/System/Activity_SummerPub/BilliardGame/BilliardGame_BattlePopUI"
end

function BilliardBattleHeroSelectView:UIParent()
	return manager.ui.uiPop.transform
end

function BilliardBattleHeroSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BilliardBattleHeroSelectView:InitUI()
	self:BindCfgUI()

	self.heroLuaList = LuaList.New(handler(self, self.OnRenderItem), self.heroListObj_, BilliardBattleHeroPopModule)
	self.mainController = self.controller_:GetController("mode")
	self.btnController = self.enterController_:GetController("statelock01")
	self.exchangeContext = self:BuildExchangeContext()
	self.teamHeroSlots = {
		BilliardBattleTeamHeroModule.New(self.teamHeroObj1_, self.exchangeContext, 1),
		BilliardBattleTeamHeroModule.New(self.teamHeroObj2_, self.exchangeContext, 2),
		(BilliardBattleTeamHeroModule.New(self.teamHeroObj3_, self.exchangeContext, 3))
	}

	self:InitPanel()
end

function BilliardBattleHeroSelectView:BuildExchangeContext()
	local var_5_0 = self

	return {
		curStage = -1,
		curSelectedHero = -1,
		slots = {},
		reverseMap = {},
		IsInExchange = function(self)
			return self.waitExchangeId ~= nil
		end,
		GetExchangeHeroId = function(self)
			return self.waitExchangeId
		end,
		GetSlotCount = function(self)
			local var_8_0 = 0

			for iter_8_0 = 1, 3 do
				if self:GetSlotHero(iter_8_0) then
					var_8_0 = var_8_0 + 1
				end
			end

			return var_8_0
		end,
		ExchangeSlot = function(self, arg_9_1)
			self:RemoveHero((self:GetSlotHero(arg_9_1)))
			self:AddHeroToSlot(self.waitExchangeId)

			self.waitExchangeId = nil

			manager.notify:Invoke(BilliardGameEvent.BILLIARD_POP_VIEW_EXCHANGE_HERO)
			var_5_0:ChangeExchangeBtnStatus()
		end,
		AddHeroToSlot = function(self, arg_10_1, arg_10_2)
			local var_10_0 = arg_10_2 or -1

			if (arg_10_2 or -1) == -1 then
				for iter_10_0 = 1, 3 do
					if not self:GetSlotHero(iter_10_0) then
						var_10_0 = iter_10_0

						break
					end
				end
			end

			if var_10_0 == -1 then
				return
			end

			if self.slots[var_10_0] then
				self:RemoveHero(self.slots[var_10_0])
			end

			self.slots[var_10_0] = arg_10_1
			self.reverseMap[arg_10_1] = var_10_0

			manager.notify:Invoke(BilliardGameEvent.BILLIARD_POP_VIEW_ADD_HERO, arg_10_1)
			var_5_0:ChangeExchangeBtnStatus()
		end,
		RemoveHero = function(self, arg_11_1)
			if self.reverseMap[arg_11_1] then
				self.slots[self.reverseMap[arg_11_1]] = nil
				self.reverseMap[arg_11_1] = nil

				manager.notify:Invoke(BilliardGameEvent.BILLIARD_POP_VIEW_REMOVE_HERO, arg_11_1)
			end

			var_5_0:ChangeExchangeBtnStatus()
		end,
		GetSlotHero = function(self, arg_12_1)
			return self.slots[arg_12_1]
		end,
		IsHeroInSlot = function(self, arg_13_1)
			if self.reverseMap[arg_13_1] then
				return true
			end

			return false
		end,
		IsHeroInSelected = function(self, arg_14_1)
			return self.curSelectedHero == arg_14_1
		end,
		SelectHero = function(arg_15_0, arg_15_1)
			arg_15_0.curSelectedHero = arg_15_1

			var_5_0:RenderSelectHeroInfo()
			var_5_0:ChangeExchangeBtnStatus()
			manager.notify:Invoke(BilliardGameEvent.BILLIARD_POP_VIEW_SELECT_HERO, arg_15_1)
		end,
		SlotIsFull = function(self)
			if self:GetSlotHero(1) and self:GetSlotHero(2) and self:GetSlotHero(3) then
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
		SaveSlot = function(self)
			local var_18_0 = {
				-1,
				-1,
				-1
			}

			for iter_18_0 = 1, 3 do
				var_18_0[iter_18_0] = not self:GetSlotHero(iter_18_0) and -1 or self:GetSlotHero(iter_18_0)
			end

			saveData("BilliardSaveSlot", "slot", var_18_0)
		end,
		RecoverSlot = function(self)
			local var_19_0 = getData("BilliardSaveSlot", "slot")

			if var_19_0 then
				if var_19_0[1] and var_19_0[1] ~= -1 then
					self:AddHeroToSlot(var_19_0[1], 1)
				end

				if var_19_0[2] and var_19_0[2] ~= -1 then
					self:AddHeroToSlot(var_19_0[2], 2)
				end

				if var_19_0[3] and var_19_0[3] ~= -1 then
					self:AddHeroToSlot(var_19_0[3], 3)
				end
			end
		end
	}
end

function BilliardBattleHeroSelectView:AddUIListener()
	self.AddBtnListener(self, self.entraceBtn_, self, function()
		self:EntraceBattle()
	end)
	self.AddBtnListener(self, self.maskBtn_, self, function()
		self:Back()
	end)
	self.AddBtnListener(self, self.disBtn_, self, function()
		ShowTips(GetTips("NYA_SUMMER_PINBALL_HERO_INSUFFICIENT_TIP"))
	end)
end

function BilliardBattleHeroSelectView:OnEnter()
	self.exchangeContext:Reset()
	self:InitPanelView()

	self.heroLuaList = self.heroLuaList or LuaList.New(handler(self, self.OnRenderItem), self.heroListObj_, BilliardBattleHeroPopModule)
	self.heroList = self:GetAllRenderHero()

	self.heroLuaList:StartScroll(#self.heroList)

	self.stage_id = self.params_.stageID
	self.levelID = self.params_.levelID
	self.isEasy = self.params_.isEasy

	self.mainController:SetSelectedState(self.isEasy and "Ordinary" or "Difficult")

	self.stageBg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_SummerPub/BilliardGame/Stage/" .. SummerPubLevelCfg[self.levelID].background_1)

	self.exchangeContext:SelectHero(self.heroList[1])

	self.bgImg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/BilliardGame/BilliardGamebg_0" .. SummerPubLevelCfg[self.levelID].area)

	self:ChangeExchangeBtnStatus()
	self.exchangeContext:RecoverSlot()
end

function BilliardBattleHeroSelectView:InitPanelView()
	self.teamHeroSlots[1]:OnRender()
	self.teamHeroSlots[2]:OnRender()
	self.teamHeroSlots[3]:OnRender()
	self:InitPanel()
end

function BilliardBattleHeroSelectView:InitPanel()
	self.startGameTxt_.text = GetI18NText(GetTips("MATRIX_PREPARE_START_CHALLENGE"))
	self.startGame2Txt_.text = GetI18NText(GetTips("MATRIX_PREPARE_START_CHALLENGE"))
	self.skillTxt_.text = ""
end

function BilliardBattleHeroSelectView:OnRenderItem(arg_27_1, arg_27_2)
	self.exchangeContext.curStage = self.stage_id

	arg_27_2:OnRenderHero(self.heroList[arg_27_1], self.exchangeContext)
end

function BilliardBattleHeroSelectView:GetAllRenderHero()
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(SummerPubHeroCfg.all) do
		if (SummerPubHeroCfg[iter_28_1].type == 2 or SummerPubHeroCfg[iter_28_1].type == 3) and SummerPubData:isUnlockPartner(iter_28_1) then
			table.insert(var_28_0, iter_28_1)
		end
	end

	return var_28_0
end

function BilliardBattleHeroSelectView:EntraceBattle()
	if not self.exchangeContext.slots[1] or not self.exchangeContext.slots[2] or not self.exchangeContext.slots[3] then
		ShowTips(GetTips("NYA_SUMMER_PINBALL_HERO_INSUFFICIENT_TIP"))

		return
	end

	self:Back()

	if self.stage_id == 40301 and SummerPubData:GetPinballClearNumByStageID(40301) == 0 then
		LaunchBilliardGame(self.levelID, self.stage_id, {
			40301,
			40302,
			40303
		})

		return
	end

	LaunchBilliardGame(self.levelID, self.stage_id, {
		self.exchangeContext.slots[1],
		self.exchangeContext.slots[2],
		self.exchangeContext.slots[3]
	})
end

function BilliardBattleHeroSelectView:RenderSelectHeroInfo()
	self.titleTxt_.text = SummerPubHeroCfg[self.exchangeContext.curSelectedHero].hero_name
	self.healthTxt_.text = SummerPubHeroCfg[self.exchangeContext.curSelectedHero].base_attribute[2]
	self.attackTxt_.text = SummerPubHeroCfg[self.exchangeContext.curSelectedHero].base_attribute[1]
	self.hungryTxt_.text = SummerPubHeroCfg[self.exchangeContext.curSelectedHero].base_attribute[3]

	if BilliardSkillCfg[SummerPubHeroCfg[self.exchangeContext.curSelectedHero].skill] then
		self.skillTxt_.text = BilliardSkillCfg[SummerPubHeroCfg[self.exchangeContext.curSelectedHero].skill].skill_desc
	end
end

function BilliardBattleHeroSelectView:ChangeExchangeBtnStatus()
	self.stageTxt_.text = GetI18NText(GetTips("BILLIARD_GAME_ENTER_CAMP")) .. " " .. self.exchangeContext:GetSlotCount() .. "/3"

	if self.exchangeContext:GetSlotCount() == 3 then
		self.btnController:SetSelectedState("normal01")
		SetActive(self.tipsObj_, false)
	else
		self.btnController:SetSelectedState("lock01")
		SetActive(self.tipsObj_, true)
	end
end

function BilliardBattleHeroSelectView:OnExit()
	BilliardBattleHeroSelectView.super.OnExit(self)
	self.exchangeContext:SaveSlot()
	self.heroLuaList:Dispose()

	self.heroLuaList = nil
end

function BilliardBattleHeroSelectView:Dispose()
	self.teamHeroSlots[1]:Dispose()
	self.teamHeroSlots[2]:Dispose()
	self.teamHeroSlots[3]:Dispose()

	self.teamHeroSlots = nil

	if self.heroLuaList then
		self.heroLuaList:Dispose()

		self.heroLuaList = nil
	end

	BilliardBattleHeroSelectView.super.Dispose(self)
end

return BilliardBattleHeroSelectView
