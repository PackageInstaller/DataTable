local var_0_0 = {
	function(arg_1_0)
		if NewWarChessData:GetAttribute(arg_1_0) >= 1 then
			return true
		else
			return false
		end
	end,
	function(arg_2_0)
		if NewWarChessData:GetAttribute(arg_2_0) == 0 then
			return true
		else
			return false
		end
	end,
	function()
		if not NewWarChessData:CheckIsAllDie() then
			return true
		else
			return false
		end
	end,
	function()
		if NewWarChessData:CheckIsAllDie() then
			return true
		else
			return false
		end
	end,
	function(arg_5_0, arg_5_1)
		if arg_5_1 <= NewWarChessData:GetAttribute(arg_5_0) then
			return true
		else
			return false
		end
	end,
	function(arg_6_0, arg_6_1)
		if arg_6_1 > NewWarChessData:GetAttribute(arg_6_0) then
			return true
		else
			return false
		end
	end,
	function(arg_7_0)
		if arg_7_0 <= NewWarChessData:GetDiceNum() then
			return true
		else
			return false
		end
	end,
	function(arg_8_0)
		if arg_8_0 > NewWarChessData:GetDiceNum() then
			return true
		else
			return false
		end
	end
}
local var_0_1 = class("NewWarChessChanceItem", ReduxView)

function var_0_1.OnCtor(arg_9_0, arg_9_1)
	arg_9_0.gameObject_ = arg_9_1
	arg_9_0.transform_ = arg_9_1.transform

	arg_9_0:Init()
end

function var_0_1.Init(arg_10_0)
	arg_10_0:InitUI()
	arg_10_0:AddUIListener()
end

function var_0_1.InitUI(arg_11_0)
	arg_11_0:BindCfgUI()

	arg_11_0.stateController_ = ControllerUtil.GetController(arg_11_0.transform_, "status")
end

function var_0_1.AddUIListener(arg_12_0)
	arg_12_0:AddBtnListener(arg_12_0.btn_, nil, function()
		arg_12_0:OnChanceItemClick()
	end)
end

function var_0_1.SetNewChanceHandle(arg_14_0, arg_14_1)
	arg_14_0.executeChanceItemHandle_ = arg_14_1
end

function var_0_1.SetData(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.chanceID_ = arg_15_1
	arg_15_0.chanceItemID_ = arg_15_2
	arg_15_0.chanceItemCfg_ = NewWarChessChanceItemCfg[arg_15_0.chanceItemID_]
	arg_15_0.stateInfo_ = NewWarChessData:GetChanceItemState(arg_15_0.chanceItemID_)
	arg_15_0.realState_ = 0

	if arg_15_0.stateInfo_.ispre == 0 then
		local var_15_0 = arg_15_0.chanceItemCfg_.self_state_event

		if var_15_0[1] then
			if var_15_0[1] == 1 or var_15_0[1] == 2 or var_15_0[1] == 7 or var_15_0[1] == 8 then
				if var_0_0[var_15_0[1]](var_15_0[2]) then
					arg_15_0.realState_ = var_15_0[3]
				else
					arg_15_0.realState_ = arg_15_0.stateInfo_.state
				end
			elseif var_15_0[1] == 3 or var_15_0[1] == 4 then
				if var_0_0[var_15_0[1]]() then
					arg_15_0.realState_ = var_15_0[2]
				else
					arg_15_0.realState_ = arg_15_0.stateInfo_.state
				end
			elseif var_15_0[1] == 5 or var_15_0[1] == 6 then
				if var_0_0[var_15_0[1]](var_15_0[2], var_15_0[3]) then
					arg_15_0.realState_ = var_15_0[4]
				else
					arg_15_0.realState_ = arg_15_0.stateInfo_.state
				end
			end
		else
			arg_15_0.realState_ = arg_15_0.stateInfo_.state
		end
	elseif arg_15_0.stateInfo_.ispre == 1 then
		arg_15_0.realState_ = arg_15_0.stateInfo_.state
	else
		print("123 , 服务地传来的机遇选项机遇是否屏蔽前置条件字段有误")
	end

	arg_15_0:RefreshUI()
end

function var_0_1.RefreshUI(arg_16_0)
	arg_16_0.name_.text = arg_16_0.chanceItemCfg_.name

	if arg_16_0.realState_ == NewChessConst.CHANCE_ITEM_STATUS.HIDE then
		SetActive(arg_16_0.gameObject_, false)
	else
		SetActive(arg_16_0.gameObject_, true)
		arg_16_0.stateController_:SetSelectedIndex(arg_16_0.realState_)
	end

	if arg_16_0.chanceItemCfg_.dice_type ~= 0 then
		SetActive(arg_16_0.diceiconGo_, true)
	else
		SetActive(arg_16_0.diceiconGo_, false)
	end
end

function var_0_1.OnChanceItemClick(arg_17_0)
	if arg_17_0.realState_ == NewChessConst.CHANCE_ITEM_STATUS.NORMAL then
		arg_17_0:ExecuteChanceItemClick()
	elseif arg_17_0.realState_ == NewChessConst.CHANCE_ITEM_STATUS.LOCK then
		ShowTips(arg_17_0.chanceItemCfg_.lock_tips)
	end
end

function var_0_1.ExecuteChanceItemClick(arg_18_0)
	if arg_18_0.chanceItemCfg_.dice_type ~= 0 then
		JumpTools.OpenPageByJump("/newWarChessDiceEventView", {
			chanceID = arg_18_0.chanceID_,
			chanceItemID = arg_18_0.chanceItemID_
		})

		return
	elseif arg_18_0.chanceItemCfg_.jump_event[1] == NewChessConst.CHANCE_JUMP_TYPE.BATTLE then
		NewWarChessAction.SelectChanceItem(arg_18_0.chanceItemID_, {}, function()
			local var_19_0 = arg_18_0.chanceItemCfg_.jump_event[2]

			if not BattleNewWarChessStageCfg[var_19_0] then
				-- block empty
			end

			if NewWarChessData:CheckIsAllDie() then
				ShowTips("ACTIVITY_NEW_WARCHESS_ALL_HERO_DIE")

				return
			end

			manager.NewChessManager:BattleStart(arg_18_0.chanceID_, arg_18_0.chanceItemID_, {}, {})
			gameContext:Go("/sectionSelectHero", {
				section = var_19_0,
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS,
				activityID = NewWarChessData:GetCurrentActivity()
			})
		end)
	else
		NewWarChessAction.SelectChanceItem(arg_18_0.chanceItemID_, {}, function()
			if arg_18_0.executeChanceItemHandle_ then
				arg_18_0.executeChanceItemHandle_(arg_18_0.chanceItemID_)
			else
				print("executeChanceItemHandle_丢失！！")
			end
		end)
	end
end

function var_0_1.SetIsShow(arg_21_0, arg_21_1)
	SetActive(arg_21_0.gameObject_, arg_21_1)
end

function var_0_1.Dispose(arg_22_0)
	arg_22_0.executeChanceItemHandle_ = nil

	Object.Destroy(arg_22_0.gameObject_)
	var_0_1.super.Dispose(arg_22_0)
end

return var_0_1
