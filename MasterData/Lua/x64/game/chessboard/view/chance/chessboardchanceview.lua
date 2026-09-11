local ChessBoardChanceView = class("ChessBoardChanceView", ReduxView)
local var_0_1 = "D46068"
local var_0_2 = {
	state = {
		empty = "empty",
		name = "state",
		target = "target",
		normal = "normal"
	},
	btnState = {
		enter_event = "enter_event",
		name = "btnState",
		unlock_event = "unlock_event",
		unlock_event_no_gold = "unlock_event_no_gold",
		empty = "empty",
		no_out = "no_out",
		exit_map = "exit_map"
	}
}

function ChessBoardChanceView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_EventPopUI"
end

function ChessBoardChanceView:UIParent()
	return manager.ui.uiPop.transform
end

function ChessBoardChanceView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardChanceView:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controllerexcollection_:GetController(var_0_2.state.name)
	self.btnController_ = self.controllerexcollection_:GetController(var_0_2.btnState.name)
	self.titleController_ = self.controllerexcollection_:GetController("title")
end

function ChessBoardChanceView:AddUIListener()
	self:AddBtnListener(self.fullscreenBtn_, nil, function()
		if self.chanceType == ChessBoardConst.CHANCE_TYPE.RANDON then
			self:OnClickCancelBtn()
		end
	end)
	self:AddBtnListener(self.summer2024_cancelbtnBtn_, nil, function()
		self:OnClickCancelBtn()
	end)
	self:AddBtnListener(self.summer2024_cornerbtnBtn_, nil, function()
		self:OnClickSureBtn()
	end)
	self:AddBtnListener(self.exitBtn_, nil, function()
		JumpTools.OpenPageByJump("/chessBoardExploreView")
	end)
end

function ChessBoardChanceView:OnClickCancelBtn()
	if self.viewType == ChessBoardConst.VIEW_TYPE.NORMAL_CHANCE and self.chanceType == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE or self.viewType == ChessBoardConst.VIEW_TYPE.NORMAL_CHANCE and self.chanceType == ChessBoardConst.CHANCE_TYPE.BATTLE then
		ChessBoardTools.ExitChessBoardScene(false)
	elseif self.chanceType == ChessBoardConst.CHANCE_TYPE.RANDON then
		gameContext:Go("/chessBoardHomeView")
		self:PlayActionByChanceData(self.chanceInfo_)
	else
		ChessBoardAction.FinishChance(self.chanceInfo_.chanceID, 1, 0, function()
			gameContext:Go("/chessBoardHomeView")
		end)
	end
end

function ChessBoardChanceView:OnClickSureBtn()
	if self.viewType == ChessBoardConst.VIEW_TYPE.UNLOCK_CHANCE then
		if manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD") < self.chanceCfg.cost then
			ShowTips("CHESSBOARD_NEED_GOLD")
		else
			ChessBoardAction.UnlockChance(self.chanceInfo_.chanceID, function()
				if ChessBoardChanceCfg[self.chanceInfo_.chanceID].type == ChessBoardConst.CHANCE_TYPE.ARENA then
					local var_13_0 = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_ARENA_DICE_NUM") - ChessBoardAttributeCfg.CHESSBOARD_ATTRIBUTE_ID_ARENA_DICE_NUM.default

					manager.story:StartChessStoryWithBackground(ChessBoardChanceCfg[self.chanceInfo_.chanceID].params[3][var_13_0 + 1] and ChessBoardChanceCfg[self.chanceInfo_.chanceID].params[3][var_13_0 + 1] or ChessBoardChanceCfg[self.chanceInfo_.chanceID].params[3][#ChessBoardChanceCfg[self.chanceInfo_.chanceID].params[3]], function(arg_14_0)
						self:UnlockChance()
					end)
				elseif ChessBoardChanceCfg[self.chanceInfo_.chanceID].unlock_story > 0 then
					manager.story:StartChessStoryWithBackground(ChessBoardChanceCfg[self.chanceInfo_.chanceID].unlock_story, function(arg_15_0)
						self:UnlockChance()
					end)
				else
					self:UnlockChance()
				end
			end)
		end
	elseif self.chanceType == ChessBoardConst.CHANCE_TYPE.TELEPORT or self.chanceType == ChessBoardConst.CHANCE_TYPE.TARGET then
		ChessBoardAction.FinishChance(self.chanceInfo_.chanceID, 0, 0, function()
			gameContext:Go("/chessBoardHomeView")
		end)
	elseif self.chanceType == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE or self.chanceType == ChessBoardConst.CHANCE_TYPE.BATTLE or self.chanceType == ChessBoardConst.CHANCE_TYPE.BLISTER or self.chanceType == ChessBoardConst.CHANCE_TYPE.RHYTHM or self.chanceType == ChessBoardConst.CHANCE_TYPE.DUCK or self.chanceType == ChessBoardConst.CHANCE_TYPE.MONSTER_COSPLAY or self.chanceType == ChessBoardConst.CHANCE_TYPE.TANGRAM then
		if ChessBoardChanceCfg[self.chanceInfo_.chanceID].play_start_story > 0 then
			manager.story:StartChessStoryWithBackground(ChessBoardChanceCfg[self.chanceInfo_.chanceID].play_start_story, function(arg_17_0)
				manager.ChessBoardManager:BattleStart(self.chanceInfo_.chanceID)
				ChessBoardTools.StartChanceGame(self.chanceInfo_.chanceID)
			end)
		else
			manager.ChessBoardManager:BattleStart(self.chanceInfo_.chanceID)
			ChessBoardTools.StartChanceGame(self.chanceInfo_.chanceID)
		end
	end
end

function ChessBoardChanceView:UnlockChance()
	manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD", -ChessBoardChanceCfg[self.chanceInfo_.chanceID].cost)

	if ChessBoardChanceCfg[self.chanceInfo_.chanceID].type == ChessBoardConst.CHANCE_TYPE.TARGET or ChessBoardChanceCfg[self.chanceInfo_.chanceID].type == ChessBoardConst.CHANCE_TYPE.TELEPORT then
		ChessBoardAction.FinishChance(self.chanceInfo_.chanceID, 0, 0)
		gameContext:Go("/chessBoardHomeView")
	else
		self.viewType = ChessBoardConst.VIEW_TYPE.NORMAL_CHANCE

		if self.chanceType == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE or self.chanceType == ChessBoardConst.CHANCE_TYPE.BATTLE or self.chanceType == ChessBoardConst.CHANCE_TYPE.BLISTER or self.chanceType == ChessBoardConst.CHANCE_TYPE.RHYTHM or self.chanceType == ChessBoardConst.CHANCE_TYPE.QTE or self.chanceType == ChessBoardConst.CHANCE_TYPE.DUCK or self.chanceType == ChessBoardConst.CHANCE_TYPE.MONSTER_COSPLAY or self.chanceType == ChessBoardConst.CHANCE_TYPE.TANGRAM then
			gameContext:Go("/chessBoardBattleChanceView", {
				chanceID = self.chanceID
			})
		elseif self.chanceType == ChessBoardConst.CHANCE_TYPE.ARENA then
			gameContext:Go("/chessBoardHomeView")
			ChessBoardTools.OpenChanceView(self.chanceID, false)
		else
			self:ChangeViewShowState()
		end
	end
end

function ChessBoardChanceView:PlayPropTips(arg_19_1, arg_19_2, arg_19_3)
	arg_19_3 = arg_19_3 or 1

	local var_19_0 = arg_19_2.chancePropList[arg_19_3 + 2]

	if arg_19_2.chancePropList[arg_19_3 + 2] then
		if arg_19_1 then
			manager.ChessBoardManager:AddTmpHeroProp(var_19_0)
		else
			manager.ChessBoardManager:RemoveHeroProp(var_19_0)
		end

		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.GET_PROP, {
			propID = var_19_0,
			isGet = arg_19_1,
			callback = function()
				self:PlayPropTips(arg_19_1, arg_19_2, arg_19_3 + 1)
			end
		})
	end

	if arg_19_3 + 2 == #arg_19_2.chancePropList then
		manager.ChessBoardManager:AddDelayTimer(1, function()
			ChessBoardAction.FinishChance(arg_19_2.chanceID, 0, 0)
		end)
	end
end

function ChessBoardChanceView:PlayActionByChanceData(arg_22_1)
	local var_22_0 = arg_22_1.chancePropList[3]
	local var_22_1 = ChessBoardConst.ACTIONTYPE.ALL

	if arg_22_1.chancePropList[2] == ChessBoardConst.RANDOM_CHANCE_TYPE.SUB_GOLD then
		var_22_1 = arg_22_1.chancePropList[3] > 0 and ChessBoardConst.ACTIONTYPE.HAPPY or ChessBoardConst.ACTIONTYPE.SAD

		ChessBoardAction.FinishChance(arg_22_1.chanceID, 0, 0, function()
			manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD", var_22_0)
		end)
	elseif arg_22_1.chancePropList[2] == ChessBoardConst.RANDOM_CHANCE_TYPE.ADD_PROP then
		self:PlayPropTips(true, arg_22_1)

		var_22_1 = ChessBoardConst.ACTIONTYPE.HAPPY
	elseif arg_22_1.chancePropList[2] == ChessBoardConst.RANDOM_CHANCE_TYPE.REMOVE_PROP then
		self:PlayPropTips(false, arg_22_1)

		var_22_1 = ChessBoardConst.ACTIONTYPE.SAD
	elseif arg_22_1.chancePropList[2] == ChessBoardConst.RANDOM_CHANCE_TYPE.ADD_BUFF then
		local var_22_2 = ChessBoardChanceCfg[self.chanceID].params[arg_22_1.chancePropList[1]][2]

		ChessBoardAction.FinishChance(arg_22_1.chanceID, 0, 0, function()
			manager.ChessBoardManager:AddBuff(0, var_22_2)
		end)
	elseif arg_22_1.chancePropList[2] == ChessBoardConst.RANDOM_CHANCE_TYPE.NPC_STOP_MOVE then
		ChessBoardAction.FinishChance(arg_22_1.chanceID, 0, 0, function()
			ShowTips("CHESSBOARD_DUCK_STOP")
		end)
	elseif arg_22_1.chancePropList[2] == ChessBoardConst.RANDOM_CHANCE_TYPE.NEW_NPC then
		local var_22_3 = ChessBoardChanceCfg[self.chanceID].params[arg_22_1.chancePropList[1]][2]
		local var_22_4 = ChessBoardChanceCfg[self.chanceID].params[arg_22_1.chancePropList[1]][3]
		local var_22_5 = {
			id = arg_22_1.chancePropList[3],
			typeID = ChessBoardChanceCfg[self.chanceID].params[arg_22_1.chancePropList[1]][4],
			pos = {}
		}

		var_22_5.pos.x = ChessBoardChanceCfg[self.chanceID].params[arg_22_1.chancePropList[1]][2]
		var_22_5.pos.z = ChessBoardChanceCfg[self.chanceID].params[arg_22_1.chancePropList[1]][3]
		var_22_5.dir = ChessBoardChanceCfg[self.chanceID].params[arg_22_1.chancePropList[1]][5]
		var_22_5.attribute = {}

		for iter_22_0, iter_22_1 in pairs(ChessBoardNPCPoolCfg[ChessBoardChanceCfg[self.chanceID].params[arg_22_1.chancePropList[1]][4]].init_attribute_list) do
			var_22_5.attribute[iter_22_1[1]] = iter_22_1[2]
		end

		var_22_5.buffList = {}

		ChessBoardAction.FinishChance(arg_22_1.chanceID, 0, 0, function()
			manager.ChessBoardManager:AddNPC(var_22_5)
			ShowTips("CHESSBOARD_NEW_DUCK")
			manager.ChessBoardManager:PlayPortHeroEffect(var_22_3, var_22_4)
		end)
	elseif arg_22_1.chancePropList[2] == ChessBoardConst.RANDOM_CHANCE_TYPE.CHANGE_GRID then
		local var_22_6 = ChessBoardChanceCfg[self.chanceID].params[arg_22_1.chancePropList[1]][2]
		local var_22_7 = ChessBoardChanceCfg[self.chanceID].params[arg_22_1.chancePropList[1]][3]
		local var_22_8 = ChessBoardChanceCfg[self.chanceID].params[arg_22_1.chancePropList[1]][4]

		ChessBoardAction.FinishChance(arg_22_1.chanceID, 0, 0, function()
			manager.ChessBoardManager:ChangeGridByExtentID(var_22_6, var_22_7, var_22_8, false)
		end)
	else
		ChessBoardAction.FinishChance(arg_22_1.chanceID, 0, 0)
	end

	if var_22_1 ~= ChessBoardConst.ACTIONTYPE.ALL then
		manager.ChessBoardManager:PlayEntityAction(0, var_22_1)
	end
end

function ChessBoardChanceView:OnEnter()
	self:InitData()
	self:ChangeViewShowState()

	self.goldText_.text = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD")
end

function ChessBoardChanceView:InitData()
	self.viewType = self.params_.viewType or ChessBoardConst.VIEW_TYPE.NORMAL_CHANCE
	self.chanceInfo_ = manager.ChessBoardManager:GetCurChanceInfo()

	if self.chanceInfo_ then
		self.chanceID = self.chanceInfo_.chanceID or nil
	end

	self.chanceCfg = ChessBoardChanceCfg[self.chanceID]

	if self.chanceCfg then
		self.chanceType = self.chanceCfg.type or nil
	end
end

function ChessBoardChanceView:RefreshLockInfoUI()
	self.costText_.text = self.chanceCfg.cost > manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD") and "<color=#" .. var_0_1 .. ">" .. self.chanceCfg.cost .. "</color>" or self.chanceCfg.cost
end

function ChessBoardChanceView:RefreshInfoUI()
	self.iconImg_.sprite = ChessBoardTools.GetChanceImage(ChessBoardChanceCfg[self.chanceID].params_image[1])
	self.nameText_.text = self.chanceCfg.name
	self.descText_.text = self.chanceCfg.description

	if self.chanceType == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE or self.chanceType == ChessBoardConst.CHANCE_TYPE.TARGET or self.chanceType == ChessBoardConst.CHANCE_TYPE.BATTLE then
		self.titleController_:SetSelectedState("story")
	elseif self.chanceType == ChessBoardConst.CHANCE_TYPE.TELEPORT then
		self.titleController_:SetSelectedState("special")
	elseif self.chanceType == ChessBoardConst.CHANCE_TYPE.RANDON then
		self.titleController_:SetSelectedState("random")
	else
		self.titleController_:SetSelectedState("story")
	end
end

function ChessBoardChanceView:RefreshTargetUI()
	self.checkPointText_.text = self.chanceCfg.description
end

function ChessBoardChanceView:RefreshRandomUI()
	self.iconImg_.sprite = ChessBoardTools.GetChanceImage(ChessBoardChanceCfg[self.chanceInfo_.chanceID].params_image[self.chanceInfo_.chancePropList[1]])
	self.nameText_.text = self.chanceCfg.params_title[self.chanceInfo_.chancePropList[1]]
	self.descText_.text = self.chanceCfg.params_des[self.chanceInfo_.chancePropList[1]]

	if self.chanceInfo_.chancePropList[2] then
		if self.chanceInfo_.chancePropList[2] == ChessBoardConst.RANDOM_CHANCE_TYPE.SUB_GOLD then
			self.stateController_:SetSelectedState(var_0_2.state.empty)
		else
			self.stateController_:SetSelectedState(var_0_2.state.empty)
		end
	end
end

function ChessBoardChanceView:ChangeViewShowState()
	self:RefreshInfoUI()

	if self.viewType == ChessBoardConst.VIEW_TYPE.UNLOCK_CHANCE then
		self.stateController_:SetSelectedState(var_0_2.state.normal)

		if not self.chanceCfg or not self.chanceCfg.cost then
			-- block empty
		end

		if manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD") < self.chanceCfg.cost then
			self.btnController_:SetSelectedState(var_0_2.btnState.unlock_event_no_gold)
		else
			self.btnController_:SetSelectedState(var_0_2.btnState.unlock_event)
		end

		self:RefreshLockInfoUI()
	elseif self.chanceType == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE or self.chanceType == ChessBoardConst.CHANCE_TYPE.BATTLE then
		self.stateController_:SetSelectedState(var_0_2.state.empty)
		self.btnController_:SetSelectedState(var_0_2.btnState.exit_map)
	elseif self.chanceType == ChessBoardConst.CHANCE_TYPE.TELEPORT then
		self.stateController_:SetSelectedState(var_0_2.state.empty)
		self:RefreshTargetUI()
		self.btnController_:SetSelectedState(var_0_2.btnState.unlock_event)
	elseif self.chanceType == ChessBoardConst.CHANCE_TYPE.RANDON then
		self:RefreshRandomUI()
		self.btnController_:SetSelectedState(var_0_2.btnState.empty)
	elseif self.chanceType == ChessBoardConst.CHANCE_TYPE.TARGET then
		self.stateController_:SetSelectedState(var_0_2.state.empty)
		self.btnController_:SetSelectedState(var_0_2.btnState.no_out)
	end
end

function ChessBoardChanceView:Dispose()
	self.super.Dispose(self)
end

return ChessBoardChanceView
