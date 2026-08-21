local var_0_0 = class("PolyhedronBattleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/PolyhedronBattle/PolyhedronBattleUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.headList = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = arg_4_0["m_role" .. iter_4_0]

		table.insert(arg_4_0.headList, polyhedronBattleHeadItem.New(var_4_0))
	end

	arg_4_0.tipsItems_ = {}
	arg_4_0.tipsDispose_ = handler(arg_4_0, arg_4_0.OnTipsDispose)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_teamBtn, nil, function()
		JumpTools.OpenPageByJump("polyhedronTeamInfo")
	end)
end

function var_0_0.OnTop(arg_7_0)
	return
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
	arg_8_0:CheckTeamRedPoint()
	PolyhedronData:ResetCacheTipInfoIndex()
	arg_8_0:StartTimer()
end

function var_0_0.CheckTeamRedPoint(arg_9_0)
	local var_9_0 = arg_9_0.polyhedronInfo:GetFightHeroList()
	local var_9_1 = arg_9_0.polyhedronInfo:GetHeroList()
	local var_9_2 = #var_9_0 < 3
	local var_9_3 = false

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_4 = arg_9_0.polyhedronInfo:GetHeroPolyData(iter_9_1)

		if table.indexof(var_9_0, iter_9_1) then
			if var_9_4:IsDead() then
				var_9_2 = true
			end
		elseif not var_9_4:IsDead() then
			var_9_3 = true
		end
	end

	if var_9_2 and var_9_3 then
		manager.redPoint:SetRedPointIndependent(arg_9_0.m_teamBtn.transform, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_9_0.m_teamBtn.transform, false)
	end
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = PolyhedronData:GetPolyhedronInfo()

	arg_10_0.polyhedronInfo = var_10_0

	local var_10_1 = var_10_0:GetTierId()
	local var_10_2 = PolyhedronTierCfg[var_10_1]

	arg_10_0.m_stageName.text = GetI18NText(var_10_2.tier) .. "-" .. GetI18NText(var_10_2.level)

	local var_10_3 = var_10_0:GetDifficulty()

	arg_10_0.m_difficultyLab.text = GetI18NText(var_10_3)

	local var_10_4 = var_10_0:GetFightHeroList()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.headList) do
		local var_10_5 = var_10_4[iter_10_0] or 0

		iter_10_1:SetData(var_10_0, var_10_5)
	end

	arg_10_0.coinId = var_10_0:GetPolyhedronCoinId()
	arg_10_0.m_coinIcon.sprite = ItemTools.getItemLittleSprite(arg_10_0.coinId)
	arg_10_0.m_coinLab.text = GetI18NText(arg_10_0.polyhedronInfo:GetCoinCount())
end

function var_0_0.OnUpdate(arg_11_0)
	arg_11_0.m_coinLab.text = GetI18NText(arg_11_0.polyhedronInfo:GetCoinCount())

	arg_11_0:CheckTeamRedPoint()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:StopTimer()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:StopTimer()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.headList) do
		iter_13_1:Dispose()
	end

	arg_13_0.headList = nil

	var_0_0.super.Dispose(arg_13_0)

	for iter_13_2, iter_13_3 in pairs(arg_13_0.tipsItems_) do
		iter_13_3:Dispose()
	end

	arg_13_0.creatFlag = false
end

function var_0_0.OnPolyhedronGameUpdate(arg_14_0)
	arg_14_0:RefreshUI()
end

function var_0_0.OnPolyhedronProcessUpdate(arg_15_0)
	arg_15_0:RefreshUI()
end

function var_0_0.StartTimer(arg_16_0)
	if arg_16_0.timer_ == nil then
		arg_16_0.timer_ = Timer.New(function()
			arg_16_0:UpdateTimer()
		end, 1, -1)
	end

	arg_16_0.timer_:Start()
end

function var_0_0.UpdateTimer(arg_18_0)
	local var_18_0 = PolyhedronData:GetTipsData()

	if var_18_0 then
		arg_18_0:CreatTips(var_18_0)
	end
end

function var_0_0.CreatTips(arg_19_0, arg_19_1)
	if not arg_19_0.creatFlag then
		for iter_19_0, iter_19_1 in pairs(arg_19_0.tipsItems_) do
			if not iter_19_1:GetIsShow() then
				iter_19_1:SetData(arg_19_1)
				iter_19_1:SetIsShow(true)
				LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.contentTrans_)

				arg_19_0.creatFlag = true

				return
			end
		end

		local var_19_0 = GameObject.Instantiate(arg_19_0.tipsGo_, arg_19_0.contentTrans_)
		local var_19_1 = PolyhedronBattleTipItem.New(var_19_0)

		var_19_1:SetDisposeHandler(arg_19_0.tipsDispose_)
		var_19_1:SetData(arg_19_1)
		var_19_1:SetIsShow(true)
		table.insert(arg_19_0.tipsItems_, var_19_1)
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.contentTrans_)

		arg_19_0.creatFlag = true
	end
end

function var_0_0.StopTimer(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end

	for iter_20_0, iter_20_1 in pairs(arg_20_0.tipsItems_) do
		iter_20_1:OnExit()
	end
end

function var_0_0.OnTipsDispose(arg_21_0, arg_21_1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.contentTrans_)
end

return var_0_0
