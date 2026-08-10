local var_0_0 = class("PolyhedronRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/PolyhedronBattle/PolyhedronRewardUI"
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

	arg_4_0.rewardList = LuaList.New(handler(arg_4_0, arg_4_0.indexRewardItem), arg_4_0.m_rewardList, PolyhedronRewardItem)
	arg_4_0.hasGiveUpRewadController = ControllerUtil.GetController(arg_4_0.transform_, "hasGiveUpRewad")
	arg_4_0.refreshController = ControllerUtil.GetController(arg_4_0.transform_, "refresh")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_confirmBtn, nil, function()
		arg_5_0:OnRewardAction()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_giveUpBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("POLYHEDRON_SHOP_GIVE_UP"), arg_5_0.polyhedronInfo:GetRewardGiveUpCoin()),
			OkCallback = function()
				PolyhedronAction.QueryRewardPolyhedron(0)
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_refreshBtn, nil, function()
		PolyhedronAction.QueryResetRewardPolyhedron()
	end)
end

function var_0_0.OnUpdate(arg_10_0)
	arg_10_0:RefreshUI()
end

function var_0_0.OnEnter(arg_11_0)
	SetActive(arg_11_0.effectGo_, false)
	arg_11_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.selectItemIndex = -1
	arg_12_0.m_confirmBtn.interactable = false

	local var_12_0 = PolyhedronData:GetPolyhedronInfo()

	arg_12_0.polyhedronInfo = var_12_0
	arg_12_0.rewardArray = var_12_0:GetRewardList()

	local var_12_1 = #arg_12_0.rewardArray

	if var_12_1 > 0 then
		local var_12_2 = arg_12_0.rewardArray[1].class

		arg_12_0.m_title.text = arg_12_0:GetRewardTitleitemType(var_12_2)

		if var_12_2 == PolyhedronConst.ITEM_TYPE.ARTIFACT then
			arg_12_0.hasGiveUpRewadController:SetSelectedIndex(1)

			arg_12_0.m_giveUpLab.text = string.format(GetTips("POLYHEDRON_SHOP_GIVE_UP"), arg_12_0.polyhedronInfo:GetRewardGiveUpCoin())

			local var_12_3 = var_12_0:GetRollRewardCount()

			if var_12_3 == 0 then
				arg_12_0.refreshController:SetSelectedIndex(0)
			else
				arg_12_0.refreshController:SetSelectedIndex(1)
			end

			arg_12_0.m_refreshCount.text = "x" .. var_12_3
		else
			arg_12_0.hasGiveUpRewadController:SetSelectedIndex(0)
			arg_12_0.refreshController:SetSelectedIndex(0)
		end
	else
		arg_12_0.hasGiveUpRewadController:SetSelectedIndex(0)
		arg_12_0.refreshController:SetSelectedIndex(0)

		arg_12_0.m_title.text = ""
	end

	if var_12_1 == 1 then
		arg_12_0.selectItemIndex = 1
		arg_12_0.m_confirmBtn.interactable = true
	end

	arg_12_0.rewardList:StartScroll(var_12_1)
end

function var_0_0.GetRewardTitleitemType(arg_13_0, arg_13_1)
	if arg_13_1 == PolyhedronConst.ITEM_TYPE.ARTIFACT then
		return GetTips("POLYHEDRON_REWARD_TITLE_ARTIFACT")
	elseif arg_13_1 == PolyhedronConst.ITEM_TYPE.ARTIFACT_UP_LEVEL then
		return GetTips("POLYHEDRON_REWARD_TITLE_ARTIFACT_UP")
	elseif arg_13_1 == PolyhedronConst.ITEM_TYPE.COIN then
		return GetTips("POLYHEDRON_REWARD_TITLE_COIN")
	elseif arg_13_1 == PolyhedronConst.ITEM_TYPE.HERO then
		return GetTips("POLYHEDRON_REWARD_TITLE_ROLE")
	elseif arg_13_1 == PolyhedronConst.ITEM_TYPE.BUFF then
		return GetTips("POLYHEDRON_REWARD_TITLE_EFFECT")
	elseif arg_13_1 == PolyhedronConst.ITEM_TYPE.BLOOD then
		return GetTips("POLYHEDRON_REWARD_TITLE_BLOOD")
	else
		return ""
	end
end

function var_0_0.OnExit(arg_14_0)
	SetActive(arg_14_0.effectGo_, false)
	UpdatePolyhedronBattleHpUI()
end

function var_0_0.indexRewardItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.rewardArray[arg_15_1]

	arg_15_2:RegistCallBack(handler(arg_15_0, arg_15_0.OnRewardItemClick))
	arg_15_2:SetData(arg_15_0.polyhedronInfo, var_15_0, arg_15_1)
	arg_15_2:SetSelected(arg_15_0.selectItemIndex)
end

function var_0_0.OnRewardItemClick(arg_16_0, arg_16_1)
	if arg_16_1 == arg_16_0.selectItemIndex then
		return
	end

	arg_16_0.selectItemIndex = arg_16_1

	local var_16_0 = arg_16_0.rewardList:GetItemList()

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		iter_16_1:SetSelected(arg_16_0.selectItemIndex)
	end

	arg_16_0.m_confirmBtn.interactable = true

	if arg_16_0.rewardArray[arg_16_0.selectItemIndex].class == PolyhedronConst.ITEM_TYPE.BLOOD then
		SetActive(arg_16_0.effectGo_, true)
	end
end

function var_0_0.OnRewardAction(arg_17_0)
	if arg_17_0.selectItemIndex == -1 then
		return
	end

	PolyhedronAction.QueryRewardPolyhedron(arg_17_0.selectItemIndex)
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.rewardList:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
