local var_0_0 = class("ChessBoardChanceView", ReduxView)
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

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_EventPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateController_ = arg_4_0.controllerexcollection_:GetController(var_0_2.state.name)
	arg_4_0.btnController_ = arg_4_0.controllerexcollection_:GetController(var_0_2.btnState.name)
	arg_4_0.titleController_ = arg_4_0.controllerexcollection_:GetController("title")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.fullscreenBtn_, nil, function()
		if arg_5_0.chanceType == ChessBoardConst.CHANCE_TYPE.RANDON then
			arg_5_0:OnClickCancelBtn()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.summer2024_cancelbtnBtn_, nil, function()
		arg_5_0:OnClickCancelBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.summer2024_cornerbtnBtn_, nil, function()
		arg_5_0:OnClickSureBtn()
	end)
	arg_5_0:AddBtnListener(arg_5_0.exitBtn_, nil, function()
		JumpTools.OpenPageByJump("/chessBoardExploreView")
	end)
end

function var_0_0.OnClickCancelBtn(arg_10_0)
	if arg_10_0.viewType == ChessBoardConst.VIEW_TYPE.NORMAL_CHANCE and arg_10_0.chanceType == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE or arg_10_0.viewType == ChessBoardConst.VIEW_TYPE.NORMAL_CHANCE and arg_10_0.chanceType == ChessBoardConst.CHANCE_TYPE.BATTLE then
		ChessBoardTools.ExitChessBoardScene(false)
	elseif arg_10_0.chanceType == ChessBoardConst.CHANCE_TYPE.RANDON then
		local var_10_0 = arg_10_0.chanceInfo_

		gameContext:Go("/chessBoardHomeView")
		arg_10_0:PlayActionByChanceData(var_10_0)
	else
		ChessBoardAction.FinishChance(arg_10_0.chanceInfo_.chanceID, 1, 0, function()
			gameContext:Go("/chessBoardHomeView")
		end)
	end
end

function var_0_0.OnClickSureBtn(arg_12_0)
	if arg_12_0.viewType == ChessBoardConst.VIEW_TYPE.UNLOCK_CHANCE then
		if manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD") < arg_12_0.chanceCfg.cost then
			ShowTips("CHESSBOARD_NEED_GOLD")
		else
			ChessBoardAction.UnlockChance(arg_12_0.chanceInfo_.chanceID, function()
				local var_13_0 = ChessBoardChanceCfg[arg_12_0.chanceInfo_.chanceID]

				if var_13_0.type == ChessBoardConst.CHANCE_TYPE.ARENA then
					local var_13_1 = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_ARENA_DICE_NUM") - ChessBoardAttributeCfg.CHESSBOARD_ATTRIBUTE_ID_ARENA_DICE_NUM.default
					local var_13_2

					if var_13_0.params[3][var_13_1 + 1] then
						var_13_2 = var_13_0.params[3][var_13_1 + 1]
					else
						var_13_2 = var_13_0.params[3][#var_13_0.params[3]]
					end

					manager.story:StartChessStoryWithBackground(var_13_2, function(arg_14_0)
						arg_12_0:UnlockChance()
					end)
				elseif var_13_0.unlock_story > 0 then
					manager.story:StartChessStoryWithBackground(var_13_0.unlock_story, function(arg_15_0)
						arg_12_0:UnlockChance()
					end)
				else
					arg_12_0:UnlockChance()
				end
			end)
		end
	elseif arg_12_0.chanceType == ChessBoardConst.CHANCE_TYPE.TELEPORT or arg_12_0.chanceType == ChessBoardConst.CHANCE_TYPE.TARGET then
		ChessBoardAction.FinishChance(arg_12_0.chanceInfo_.chanceID, 0, 0, function()
			gameContext:Go("/chessBoardHomeView")
		end)
	elseif arg_12_0.chanceType == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE or arg_12_0.chanceType == ChessBoardConst.CHANCE_TYPE.BATTLE or arg_12_0.chanceType == ChessBoardConst.CHANCE_TYPE.BLISTER or arg_12_0.chanceType == ChessBoardConst.CHANCE_TYPE.RHYTHM or arg_12_0.chanceType == ChessBoardConst.CHANCE_TYPE.DUCK or arg_12_0.chanceType == ChessBoardConst.CHANCE_TYPE.MONSTER_COSPLAY or arg_12_0.chanceType == ChessBoardConst.CHANCE_TYPE.TANGRAM then
		local var_12_0 = ChessBoardChanceCfg[arg_12_0.chanceInfo_.chanceID]

		if var_12_0.play_start_story > 0 then
			manager.story:StartChessStoryWithBackground(var_12_0.play_start_story, function(arg_17_0)
				manager.ChessBoardManager:BattleStart(arg_12_0.chanceInfo_.chanceID)
				ChessBoardTools.StartChanceGame(arg_12_0.chanceInfo_.chanceID)
			end)
		else
			manager.ChessBoardManager:BattleStart(arg_12_0.chanceInfo_.chanceID)
			ChessBoardTools.StartChanceGame(arg_12_0.chanceInfo_.chanceID)
		end
	end
end

function var_0_0.UnlockChance(arg_18_0)
	local var_18_0 = ChessBoardChanceCfg[arg_18_0.chanceInfo_.chanceID]

	manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD", -var_18_0.cost)

	if var_18_0.type == ChessBoardConst.CHANCE_TYPE.TARGET or var_18_0.type == ChessBoardConst.CHANCE_TYPE.TELEPORT then
		ChessBoardAction.FinishChance(arg_18_0.chanceInfo_.chanceID, 0, 0)
		gameContext:Go("/chessBoardHomeView")
	else
		arg_18_0.viewType = ChessBoardConst.VIEW_TYPE.NORMAL_CHANCE

		if arg_18_0.chanceType == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE or arg_18_0.chanceType == ChessBoardConst.CHANCE_TYPE.BATTLE or arg_18_0.chanceType == ChessBoardConst.CHANCE_TYPE.BLISTER or arg_18_0.chanceType == ChessBoardConst.CHANCE_TYPE.RHYTHM or arg_18_0.chanceType == ChessBoardConst.CHANCE_TYPE.QTE or arg_18_0.chanceType == ChessBoardConst.CHANCE_TYPE.DUCK or arg_18_0.chanceType == ChessBoardConst.CHANCE_TYPE.MONSTER_COSPLAY or arg_18_0.chanceType == ChessBoardConst.CHANCE_TYPE.TANGRAM then
			gameContext:Go("/chessBoardBattleChanceView", {
				chanceID = arg_18_0.chanceID
			})
		elseif arg_18_0.chanceType == ChessBoardConst.CHANCE_TYPE.ARENA then
			gameContext:Go("/chessBoardHomeView")
			ChessBoardTools.OpenChanceView(arg_18_0.chanceID, false)
		else
			arg_18_0:ChangeViewShowState()
		end
	end
end

function var_0_0.PlayPropTips(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_3 = arg_19_3 or 1

	local var_19_0 = arg_19_2.chancePropList[arg_19_3 + 2]

	if var_19_0 then
		if arg_19_1 then
			manager.ChessBoardManager:AddTmpHeroProp(var_19_0)
		else
			manager.ChessBoardManager:RemoveHeroProp(var_19_0)
		end

		manager.notify:CallUpdateFunc(CHESSBOARD_TIPS_SHOW, ChessBoardConst.TIPS_TYPE.GET_PROP, {
			propID = var_19_0,
			isGet = arg_19_1,
			callback = function()
				arg_19_0:PlayPropTips(arg_19_1, arg_19_2, arg_19_3 + 1)
			end
		})
	end

	if arg_19_3 + 2 == #arg_19_2.chancePropList then
		manager.ChessBoardManager:AddDelayTimer(1, function()
			ChessBoardAction.FinishChance(arg_19_2.chanceID, 0, 0)
		end)
	end
end

function var_0_0.PlayActionByChanceData(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.chancePropList[2]
	local var_22_1 = arg_22_1.chancePropList[3]
	local var_22_2 = ChessBoardConst.ACTIONTYPE.ALL

	if var_22_0 == ChessBoardConst.RANDOM_CHANCE_TYPE.SUB_GOLD then
		var_22_2 = var_22_1 > 0 and ChessBoardConst.ACTIONTYPE.HAPPY or ChessBoardConst.ACTIONTYPE.SAD

		ChessBoardAction.FinishChance(arg_22_1.chanceID, 0, 0, function()
			manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD", var_22_1)
		end)
	elseif var_22_0 == ChessBoardConst.RANDOM_CHANCE_TYPE.ADD_PROP then
		arg_22_0:PlayPropTips(true, arg_22_1)

		var_22_2 = ChessBoardConst.ACTIONTYPE.HAPPY
	elseif var_22_0 == ChessBoardConst.RANDOM_CHANCE_TYPE.REMOVE_PROP then
		arg_22_0:PlayPropTips(false, arg_22_1)

		var_22_2 = ChessBoardConst.ACTIONTYPE.SAD
	elseif var_22_0 == ChessBoardConst.RANDOM_CHANCE_TYPE.ADD_BUFF then
		local var_22_3 = ChessBoardChanceCfg[arg_22_0.chanceID].params[arg_22_1.chancePropList[1]][2]

		ChessBoardAction.FinishChance(arg_22_1.chanceID, 0, 0, function()
			manager.ChessBoardManager:AddBuff(0, var_22_3)
		end)
	elseif var_22_0 == ChessBoardConst.RANDOM_CHANCE_TYPE.NPC_STOP_MOVE then
		ChessBoardAction.FinishChance(arg_22_1.chanceID, 0, 0, function()
			ShowTips("CHESSBOARD_DUCK_STOP")
		end)
	elseif var_22_0 == ChessBoardConst.RANDOM_CHANCE_TYPE.NEW_NPC then
		local var_22_4 = ChessBoardChanceCfg[arg_22_0.chanceID].params[arg_22_1.chancePropList[1]]
		local var_22_5 = var_22_4[2]
		local var_22_6 = var_22_4[3]
		local var_22_7 = var_22_4[4]
		local var_22_8 = var_22_4[5]
		local var_22_9 = ChessBoardNPCPoolCfg[var_22_7]
		local var_22_10 = {
			id = arg_22_1.chancePropList[3],
			typeID = var_22_7,
			pos = {}
		}

		var_22_10.pos.x = var_22_5
		var_22_10.pos.z = var_22_6
		var_22_10.dir = var_22_8
		var_22_10.attribute = {}

		for iter_22_0, iter_22_1 in pairs(var_22_9.init_attribute_list) do
			var_22_10.attribute[iter_22_1[1]] = iter_22_1[2]
		end

		var_22_10.buffList = {}

		ChessBoardAction.FinishChance(arg_22_1.chanceID, 0, 0, function()
			manager.ChessBoardManager:AddNPC(var_22_10)
			ShowTips("CHESSBOARD_NEW_DUCK")
			manager.ChessBoardManager:PlayPortHeroEffect(var_22_5, var_22_6)
		end)
	elseif var_22_0 == ChessBoardConst.RANDOM_CHANCE_TYPE.CHANGE_GRID then
		local var_22_11 = ChessBoardChanceCfg[arg_22_0.chanceID].params[arg_22_1.chancePropList[1]]
		local var_22_12 = var_22_11[2]
		local var_22_13 = var_22_11[3]
		local var_22_14 = var_22_11[4]

		ChessBoardAction.FinishChance(arg_22_1.chanceID, 0, 0, function()
			manager.ChessBoardManager:ChangeGridByExtentID(var_22_12, var_22_13, var_22_14, false)
		end)
	else
		ChessBoardAction.FinishChance(arg_22_1.chanceID, 0, 0)
	end

	if var_22_2 ~= ChessBoardConst.ACTIONTYPE.ALL then
		manager.ChessBoardManager:PlayEntityAction(0, var_22_2)
	end
end

function var_0_0.OnEnter(arg_28_0)
	arg_28_0:InitData()
	arg_28_0:ChangeViewShowState()

	arg_28_0.goldText_.text = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD")
end

function var_0_0.InitData(arg_29_0)
	arg_29_0.viewType = arg_29_0.params_.viewType or ChessBoardConst.VIEW_TYPE.NORMAL_CHANCE
	arg_29_0.chanceInfo_ = manager.ChessBoardManager:GetCurChanceInfo()
	arg_29_0.chanceID = arg_29_0.chanceInfo_ and arg_29_0.chanceInfo_.chanceID or nil
	arg_29_0.chanceCfg = ChessBoardChanceCfg[arg_29_0.chanceID]
	arg_29_0.chanceType = arg_29_0.chanceCfg and arg_29_0.chanceCfg.type or nil
end

function var_0_0.RefreshLockInfoUI(arg_30_0)
	if arg_30_0.chanceCfg.cost > manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD") then
		arg_30_0.costText_.text = "<color=#" .. var_0_1 .. ">" .. arg_30_0.chanceCfg.cost .. "</color>"
	else
		arg_30_0.costText_.text = arg_30_0.chanceCfg.cost
	end
end

function var_0_0.RefreshInfoUI(arg_31_0)
	local var_31_0 = ChessBoardChanceCfg[arg_31_0.chanceID]

	arg_31_0.iconImg_.sprite = ChessBoardTools.GetChanceImage(var_31_0.params_image[1])
	arg_31_0.nameText_.text = arg_31_0.chanceCfg.name
	arg_31_0.descText_.text = arg_31_0.chanceCfg.description

	if arg_31_0.chanceType == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE or arg_31_0.chanceType == ChessBoardConst.CHANCE_TYPE.TARGET or arg_31_0.chanceType == ChessBoardConst.CHANCE_TYPE.BATTLE then
		arg_31_0.titleController_:SetSelectedState("story")
	elseif arg_31_0.chanceType == ChessBoardConst.CHANCE_TYPE.TELEPORT then
		arg_31_0.titleController_:SetSelectedState("special")
	elseif arg_31_0.chanceType == ChessBoardConst.CHANCE_TYPE.RANDON then
		arg_31_0.titleController_:SetSelectedState("random")
	else
		arg_31_0.titleController_:SetSelectedState("story")
	end
end

function var_0_0.RefreshTargetUI(arg_32_0)
	arg_32_0.checkPointText_.text = arg_32_0.chanceCfg.description
end

function var_0_0.RefreshRandomUI(arg_33_0)
	local var_33_0 = arg_33_0.chanceInfo_.chancePropList
	local var_33_1 = var_33_0[1]
	local var_33_2 = var_33_0[2]
	local var_33_3 = ChessBoardChanceCfg[arg_33_0.chanceInfo_.chanceID]

	arg_33_0.iconImg_.sprite = ChessBoardTools.GetChanceImage(var_33_3.params_image[var_33_1])
	arg_33_0.nameText_.text = arg_33_0.chanceCfg.params_title[var_33_1]
	arg_33_0.descText_.text = arg_33_0.chanceCfg.params_des[var_33_1]

	if var_33_2 then
		if var_33_2 == ChessBoardConst.RANDOM_CHANCE_TYPE.SUB_GOLD then
			arg_33_0.stateController_:SetSelectedState(var_0_2.state.empty)
		else
			arg_33_0.stateController_:SetSelectedState(var_0_2.state.empty)
		end
	end
end

function var_0_0.ChangeViewShowState(arg_34_0)
	arg_34_0:RefreshInfoUI()

	if arg_34_0.viewType == ChessBoardConst.VIEW_TYPE.UNLOCK_CHANCE then
		arg_34_0.stateController_:SetSelectedState(var_0_2.state.normal)

		if not arg_34_0.chanceCfg or not arg_34_0.chanceCfg.cost then
			local var_34_0 = 0
		end

		if manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD") < arg_34_0.chanceCfg.cost then
			arg_34_0.btnController_:SetSelectedState(var_0_2.btnState.unlock_event_no_gold)
		else
			arg_34_0.btnController_:SetSelectedState(var_0_2.btnState.unlock_event)
		end

		arg_34_0:RefreshLockInfoUI()
	elseif arg_34_0.chanceType == ChessBoardConst.CHANCE_TYPE.WHACK_MOLE or arg_34_0.chanceType == ChessBoardConst.CHANCE_TYPE.BATTLE then
		arg_34_0.stateController_:SetSelectedState(var_0_2.state.empty)
		arg_34_0.btnController_:SetSelectedState(var_0_2.btnState.exit_map)
	elseif arg_34_0.chanceType == ChessBoardConst.CHANCE_TYPE.TELEPORT then
		arg_34_0.stateController_:SetSelectedState(var_0_2.state.empty)
		arg_34_0:RefreshTargetUI()
		arg_34_0.btnController_:SetSelectedState(var_0_2.btnState.unlock_event)
	elseif arg_34_0.chanceType == ChessBoardConst.CHANCE_TYPE.RANDON then
		arg_34_0:RefreshRandomUI()
		arg_34_0.btnController_:SetSelectedState(var_0_2.btnState.empty)
	elseif arg_34_0.chanceType == ChessBoardConst.CHANCE_TYPE.TARGET then
		arg_34_0.stateController_:SetSelectedState(var_0_2.state.empty)
		arg_34_0.btnController_:SetSelectedState(var_0_2.btnState.no_out)
	end
end

function var_0_0.Dispose(arg_35_0)
	arg_35_0.super.Dispose(arg_35_0)
end

return var_0_0
