local DormCharacterItem = class("DormCharacterItem", ReduxView)

function DormCharacterItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormCharacterItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.characterStateController = ControllerUtil.GetController(self.transform_, "name")
	self.fatigueController = ControllerUtil.GetController(self.transform_, "fatigue")
	self.positionController = ControllerUtil.GetController(self.transform_, "position")
	self.curPisitionController = ControllerUtil.GetController(self.transform_, "currentPosition")
	self.maskController = ControllerUtil.GetController(self.transform_, "mask")
	self.sameNameController = ControllerUtil.GetController(self.transform_, "sameName")
end

function DormCharacterItem:AddUIListener()
	local var_3_0 = self:FindCom("EventTriggerListener")

	function var_3_0.onPointerDown()
		if not self.canClick and self.downFunc then
			self.downFunc(self.heroID)
		end
	end

	function var_3_0.onBeginDrag(arg_5_0, arg_5_1)
		self:BeginDrag(arg_5_1)
	end

	function var_3_0.onEndDrag(arg_6_0, arg_6_1)
		self:EndDrag(arg_6_1)
	end

	function var_3_0.onDrag(arg_7_0, arg_7_1)
		self:Drag(arg_7_1)
	end

	self:SetListener(var_3_0)
	self:AddBtnListenerScale(self.recallbtnBtn_, nil, function()
		if not self.canClick and self.recallHero then
			self.recallHero(self.heroID)
		end
	end)
end

function DormCharacterItem:RefreshUI(arg_9_1, arg_9_2)
	if DormNpcTools:CheckIDIsNpc(arg_9_1) then
		self:RefreshNpcInfo(arg_9_1, arg_9_2)
	else
		self:RefreshHeroInfo(arg_9_1, arg_9_2)
	end
end

function DormCharacterItem:RefreshNpcInfo(arg_10_1, arg_10_2)
	self.heroID = arg_10_1
	self.iconImg_.sprite = DormNpcTools:GetNpcHeadSprite(arg_10_1)

	if DormNpcTools:GetNpcFatigue(arg_10_1) < 0 then
		self.fatigueController:SetSelectedState("infinitew")
	end
end

local DormEnum = import("game.dorm.DormEnum")
local var_0_2 = {
	[DormEnum.DormHeroState.InCanteenJob] = "canteen",
	[DormEnum.DormHeroState.InCanteenEntrust] = "task",
	[DormEnum.DormHeroState.InPublicDorm] = "lobby",
	[DormEnum.DormHeroState.InIdolTraineeCamp] = "idolCamp"
}
local var_0_3 = {
	[DormEnum.DormHeroState.InCanteenJob] = true,
	[DormEnum.DormHeroState.InCanteenEntrust] = true,
	[DormEnum.DormHeroState.InPublicDorm] = true,
	[DormEnum.DormHeroState.InPrivateDorm] = true,
	[DormEnum.DormHeroState.InIdolTraineeCamp] = true
}

function DormCharacterItem:EnableRecall()
	local var_11_0 = DormData:GetCurrectSceneID()

	if nullable(BackHomeCfg, var_11_0, "type") == DormConst.BACKHOME_TYPE.PublicDorm and DormHeroTools:CheckHeroInRoom(var_11_0, self.archiveID) then
		return true
	end

	return false
end

function DormCharacterItem:RefreshHeroInfo(arg_12_1, arg_12_2)
	if arg_12_1 then
		self.heroID = arg_12_1
		self.archiveID = DormData:GetHeroArchiveID(arg_12_1)

		local var_12_0 = DormData:GetHeroTemplateInfo(self.heroID)

		if var_12_0 then
			self.iconImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_12_1)

			if not self.showFatigue then
				self.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]

				local var_12_1 = var_12_0:GetFatigue()

				self.curText_.text = var_12_1
				self.progressImg_.fillAmount = 1 - math.min(var_12_1 / GameSetting.canteen_hero_fatigue_max.value[1], 1)

				if var_12_0:GetFatigue() <= GameDisplayCfg.dorm_hero_fatigue_level.value[1] then
					self.fatigueController:SetSelectedState("low")
				else
					self.fatigueController:SetSelectedState("suff")
				end
			else
				self.fatigueController:SetSelectedState("none")
			end

			if not self.showState then
				self.state = var_12_0:GetHeroState()

				local var_12_2 = nullable(var_0_2, self.state) or "dorm"

				self.curPisitionController:SetSelectedState(var_12_2)

				if var_12_2 == "dorm" then
					self.postextText_.text = GetTips("DORM_HERO_AT_DORM")
				elseif var_12_2 == "lobby" then
					self.postextText_.text = GetTips("DORM_HERO_AT_LOBBY")
				elseif var_12_2 == "canteen" then
					self.postextText_.text = GetTips("DORM_HERO_AT_CANTEEN")
				elseif var_12_2 == "task" then
					self.postextText_.text = GetTips("DORM_HERO_AT_TASK")
				elseif var_12_2 == "idolCamp" then
					self.postextText_.text = GetTips("DORM_HERO_AT_IDOLCAMP")
				end

				self.positionController:SetSelectedState(nullable(var_0_3, self.state) and "busy" or "normal")
			else
				self.positionController:SetSelectedState("normal")
			end

			if not self.canClick then
				if self.selFunc then
					self.selFunc(self.heroID, arg_12_2, self.characterStateController)
				else
					self.characterStateController:SetSelectedState("normal")
					self.sameNameController:SetSelectedState("false")

					if self.archiveID == DormData:GetHeroArchiveID(arg_12_2) then
						if arg_12_2 == self.heroID then
							if self:EnableRecall() then
								self.characterStateController:SetSelectedState("select_recall")
							else
								self.characterStateController:SetSelectedState("select")
							end
						else
							self.positionController:SetSelectedState("normal")
							self.sameNameController:SetSelectedState("true")
						end
					end
				end
			end

			self.maskController:SetSelectedState("false")

			if self.maskFunc and self.maskFunc(self.heroID) then
				self.maskController:SetSelectedState("true")
			end
		end
	end
end

function DormCharacterItem:SetCanClickAndState(arg_13_1, arg_13_2, arg_13_3)
	self.showState = arg_13_1
	self.canClick = arg_13_2
	self.showFatigue = arg_13_3
end

function DormCharacterItem:RefreshState()
	self.state = DormData:GetHeroTemplateInfo(self.heroID):GetHeroState()

	local var_14_0 = nullable(var_0_2, self.state) or "dorm"

	self.curPisitionController:SetSelectedState(var_14_0)

	if var_14_0 == "dorm" then
		self.postextText_.text = GetTips("DORM_HERO_AT_DORM")
	elseif var_14_0 == "lobby" then
		self.postextText_.text = GetTips("DORM_HERO_AT_LOBBY")
	elseif var_14_0 == "canteen" then
		self.postextText_.text = GetTips("DORM_HERO_AT_CANTEEN")
	elseif var_14_0 == "task" then
		self.postextText_.text = GetTips("DORM_HERO_AT_TASK")
	elseif var_14_0 == "idolCamp" then
		self.postextText_.text = GetTips("DORM_HERO_AT_IDOLCAMP")
	end

	self.positionController:SetSelectedState(nullable(var_0_3, self.state) and "busy" or "normal")
end

function DormCharacterItem:RecallHero(arg_15_1)
	self.recallHero = arg_15_1
end

function DormCharacterItem:SetOnPointerDown(arg_16_1)
	self.downFunc = arg_16_1
end

function DormCharacterItem:ShowMaskCallBack(arg_17_1)
	if arg_17_1 then
		self.maskFunc = arg_17_1
	end
end

function DormCharacterItem:SelCallBack(arg_18_1)
	if arg_18_1 then
		self.selFunc = arg_18_1
	end
end

function DormCharacterItem:Dispose()
	self:RemoveAllListeners()

	if not self.canClick and self.onClickCom_ then
		self.onClickCom_.onValueChanged:RemoveAllListeners()
	end

	DormCharacterItem.super.Dispose(self)
end

function DormCharacterItem:BeginDrag(arg_20_1)
	manager.notify:CallUpdateFunc("OnBeginDragHeroItem", arg_20_1)
end

function DormCharacterItem:Drag(arg_21_1)
	manager.notify:CallUpdateFunc("OnDragHeroItem", arg_21_1)
end

function DormCharacterItem:EndDrag(arg_22_1)
	manager.notify:CallUpdateFunc("OnEndDragHeroItem", arg_22_1)
end

return DormCharacterItem
