local var_0_0 = class("OathEquityItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.lockStateController_ = arg_2_0.controller_:GetController("lock")
	arg_2_0.rewardStateController_ = arg_2_0.controller_:GetController("rewardState")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.goBtn_, nil, function()
		arg_3_0:OnClickGoBtn()
	end)
end

function var_0_0.OnClickGoBtn(arg_5_0)
	local var_5_0 = WeddingRightCfg[arg_5_0.equityID]
	local var_5_1 = var_5_0.type

	if var_5_1 == OathConst.OATH_EQUITY_DISPLAY_TYPE.PIC then
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = false,
			pages = var_5_0.pic
		})
	elseif var_5_1 == OathConst.OATH_EQUITY_DISPLAY_TYPE.JUMP then
		arg_5_0:Back()
		JumpTools.JumpToPage2(var_5_0.jump)
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.equityID = arg_6_1

	arg_6_0:RefreshEquityUI()
end

function var_0_0.UpdateLockState(arg_7_0)
	local var_7_0 = WeddingRightCfg[arg_7_0.equityID]

	if OathCollectionContentData:GetOathLevel(var_7_0.hero_id) >= var_7_0.level then
		arg_7_0.isLock = false

		arg_7_0.lockStateController_:SetSelectedState("unlock")
	else
		arg_7_0.isLock = true

		arg_7_0.lockStateController_:SetSelectedState("lock")
	end
end

function var_0_0.RefreshEquityUI(arg_8_0)
	local var_8_0 = WeddingRightCfg[arg_8_0.equityID]

	arg_8_0:UpdateLockState()
	arg_8_0:UpdateTypeContent(var_8_0.type)

	arg_8_0.equityText_.text = var_8_0.desc
end

function var_0_0.UpdateTypeContent(arg_9_0, arg_9_1)
	if arg_9_1 == OathConst.OATH_EQUITY_DISPLAY_TYPE.PIC then
		arg_9_0.rewardStateController_:SetSelectedState("goto")
	elseif arg_9_1 == OathConst.OATH_EQUITY_DISPLAY_TYPE.JUMP then
		if arg_9_0.isLock then
			arg_9_0.rewardStateController_:SetSelectedState("none")
		else
			arg_9_0.rewardStateController_:SetSelectedState("goto")
		end
	elseif arg_9_1 == OathConst.OATH_EQUITY_DISPLAY_TYPE.PROP then
		arg_9_0.rewardStateController_:SetSelectedState("prop")
		arg_9_0:RefreshPropShow()
	elseif arg_9_1 == OathConst.OATH_EQUITY_DISPLAY_TYPE.TEXT then
		arg_9_0.rewardStateController_:SetSelectedState("none")
	end
end

function var_0_0.RefreshPropShow(arg_10_0)
	local var_10_0 = WeddingRightCfg[arg_10_0.equityID].reward

	arg_10_0:InitRewardItemList()

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_1 = arg_10_0.rewardItemList_[iter_10_0]

		if var_10_1 then
			local var_10_2 = clone(ItemTemplateData)

			var_10_2.id = iter_10_1[1]
			var_10_2.number = iter_10_1[2]

			function var_10_2.clickFun(arg_11_0)
				ShowPopItem(POP_ITEM, {
					arg_11_0.id,
					arg_11_0.number
				})
			end

			var_10_1:SetData(var_10_2)
		end
	end

	for iter_10_2 = #var_10_0 + 1, #arg_10_0.rewardItemList_ do
		local var_10_3 = arg_10_0.rewardItemList_[iter_10_2]

		if var_10_3 then
			var_10_3:SetData(nil)
		end
	end
end

function var_0_0.InitRewardItemList(arg_12_0)
	if arg_12_0.rewardItemList_ then
		return
	end

	arg_12_0.rewardItemList_ = {}

	for iter_12_0 = 1, arg_12_0.rewardTrs_.childCount do
		local var_12_0 = arg_12_0.rewardTrs_:GetChild(iter_12_0 - 1).gameObject
		local var_12_1 = CommonItemView.New(var_12_0)

		arg_12_0.rewardItemList_[iter_12_0] = var_12_1
	end
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.rewardItemList_ or {}) do
		iter_13_1:Dispose()

		iter_13_1 = nil
	end

	arg_13_0.rewardItemList_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
