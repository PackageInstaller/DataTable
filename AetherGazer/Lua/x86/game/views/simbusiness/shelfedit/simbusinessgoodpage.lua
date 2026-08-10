local var_0_0 = class("SimBusinessGoodPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.itemLable = SimBusinessSellGoodSmallItem.New(arg_2_0.lableGo)
	arg_2_0.goodItem = SimBusinessShowItem.New(arg_2_0.showGo)
	arg_2_0.btnController = arg_2_0.controller:GetController("state")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshView(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1
	arg_4_0.cfg = SimBusinessGoodsCfg[arg_4_1]

	if arg_4_0.cfg then
		arg_4_0.name.text = arg_4_0.cfg.name

		arg_4_0.itemLable:RefreshView(arg_4_0.cfg.type, SimBusinessConst.ShowItmeType.good)

		arg_4_0.skill.text = arg_4_0.cfg.sell_ability_addition
		arg_4_0.skillDesc.text = arg_4_0.cfg.special_effect_desc

		arg_4_0.goodItem:RefreshView(arg_4_1, SimBusinessConst.ShowItmeType.good)
		arg_4_0:RefreshBtnState()

		local var_4_0 = SimBusinessData:GetSimBusinessFundItemID()

		arg_4_0.iconImg_.sprite = ItemTools.getItemSprite(var_4_0)

		return true
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		if arg_5_0.id and SimBusinessTools.GetGoodsReadyToUnlock(arg_5_0.id) then
			SimBusinessAction.UnlockGoods({
				arg_5_0.id
			})
		end
	end)

	if arg_5_0.resetBtn_ then
		arg_5_0:AddBtnListener(arg_5_0.resetBtn_, nil, function()
			SimBusinessAction.RevokeUnlockGoods({
				arg_5_0.id
			}, function(arg_8_0, arg_8_1)
				local var_8_0 = SimBusinessGame.GetInstance()
				local var_8_1

				if SimBusinessTools.IsChallengeLevel(var_8_0.stage) then
					var_8_1 = SimBusinessGame.CalcShelfLayout()

					if not arg_8_1.is_unlock then
						SimBusinessTools.ClearLocalShelfGoods(var_8_1, arg_8_1.goods_id_list)
					end
				end

				var_8_0:InitShelfLayout(var_8_0.stage, var_8_1)
			end)
		end)
	end
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.RefreshBtnState(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = SimBusinessTools.GetGoodLockState(arg_10_0.id)

	if var_10_0 then
		arg_10_0.cost.text = arg_10_0.cfg.unlock_cost

		if var_10_1 == SimBusinessTools.State.LOCK_BY_LEVEL then
			arg_10_0.btnController:SetSelectedState("lock")

			if var_10_2 ~= nil then
				arg_10_0.lockDesc.text = GetTipsF("SIM_BUSINESS_GOODS_UNLOCK_LEVEL_LIMIT", var_10_2)
			else
				arg_10_0.lockDesc.text = GetTips("SIM_BUSINESS_GOODS_CAN_NOT_UNLOCK")
			end
		elseif var_10_1 == SimBusinessTools.State.LOCK_BY_COST then
			if var_10_2 then
				arg_10_0.btnController:SetSelectedState("deficient")
			else
				arg_10_0.btnController:SetSelectedState("up")
			end
		end
	else
		arg_10_0.btnController:SetSelectedState("max")
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.goodItem:Dispose()
	arg_11_0.itemLable:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
