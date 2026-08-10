local var_0_0 = class("GuildActivitySPDispatchItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "select")
	arg_3_0.dispatchTypeController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "dispatchType")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = GuildActivitySPData:GetCurRunActivityID()
		local var_5_1 = GuildActivitySPData:GetCurRateID(var_5_0)
		local var_5_2 = ActivityClubSPLevelSettingCfg[var_5_1]
		local var_5_3 = table.indexof(var_5_2.dispatch, arg_4_0.catId_)
		local var_5_4 = false

		if var_5_3 then
			var_5_4 = true
		end

		if not var_5_4 then
			local var_5_5 = GuildActivitySPData:GetCatUnlockLevel(arg_4_0.catId_)

			ShowTips(string.format(GetTips("ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP"), tostring(var_5_5)))

			return
		end

		if arg_4_0.selectHandler_ ~= nil then
			arg_4_0.selectHandler_(arg_4_0.index_, arg_4_0.nodeId_)
		end
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(arg_7_1 and "true" or "false")
end

function var_0_0.SetSelectHandler(arg_8_0, arg_8_1)
	arg_8_0.selectHandler_ = arg_8_1
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.index_ = arg_9_1
	arg_9_0.nodeId_ = arg_9_3
	arg_9_0.nodeData_ = GuildActivitySPData:GetNodeData(arg_9_3)
	arg_9_0.nodeCfg_ = ActivityClubSPCfg[arg_9_3]
	arg_9_0.cfg_ = ChipCfg[arg_9_2]
	arg_9_0.catId_ = arg_9_2

	arg_9_0:UpdateView()

	local var_9_0 = GuildActivitySPData:GetCurMainActivityID()
	local var_9_1 = GuildActivitySpTools.GetCurCurrencyID(var_9_0, 1)

	arg_9_0.iconImg_.sprite = ItemTools.getItemSprite(tonumber(var_9_1))
end

function var_0_0.UpdateView(arg_10_0)
	arg_10_0.energyLabel_.text = arg_10_0.nodeCfg_.token_get
	arg_10_0.nameLabel_.text = arg_10_0.cfg_.suit_name

	local var_10_0 = ChipCfg[arg_10_0.catId_]

	arg_10_0.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", var_10_0.picture_id)

	local var_10_1, var_10_2 = GuildActivitySPData:IsCatDispatched(arg_10_0.catId_)

	if var_10_1 then
		local var_10_3 = ActivityClubSPCfg[var_10_2]
		local var_10_4 = GuildActivitySPData:GetNodeData(var_10_2)

		arg_10_0.energyLabel_.text = "+" .. var_10_3.token_get .. "/"
		arg_10_0.levelLabel_.text = "Lv." .. var_10_3.level

		arg_10_0.statusController_:SetSelectedState("dispatch")

		arg_10_0.grideName.text = GetTips(GuildActivitySPConst.NodeType[var_10_3.type])
	else
		local var_10_5 = GuildActivitySPData:GetCurRunActivityID()
		local var_10_6 = GuildActivitySPData:GetCurRateID(var_10_5)
		local var_10_7 = ActivityClubSPLevelSettingCfg[var_10_6]
		local var_10_8 = table.indexof(var_10_7.dispatch, arg_10_0.catId_)
		local var_10_9 = false

		if var_10_8 then
			var_10_9 = true
		end

		if var_10_9 then
			arg_10_0.statusController_:SetSelectedState("notdispatched")
		else
			arg_10_0.statusController_:SetSelectedState("lock")

			local var_10_10 = GuildActivitySPData:GetCatUnlockLevel(arg_10_0.catId_)

			arg_10_0.lockLabel_.text = string.format(GetTips("ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP"), tostring(var_10_10))
		end
	end
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.data_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
