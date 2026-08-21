local var_0_0 = class("RechargeRecommendBgItemView", ReduxView)

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
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		OperationRecorder.RecordButtonTouch("shop_recommend_right_" .. arg_4_0.cfg_.goods_id)

		local var_5_0 = arg_4_0.cfg_.jump

		if arg_4_0.cfg_.goods_id == 0 then
			-- block empty
		end

		local var_5_1 = arg_4_0.cfg_
		local var_5_2 = var_5_1.time[1]
		local var_5_3 = false

		if not var_5_2 or #var_5_2[1] < 3 or #var_5_2[2] < 3 then
			var_5_3 = true
		end

		local var_5_4 = var_5_1.time[2]

		if not var_5_4 or #var_5_4[1] < 3 or #var_5_4[2] < 3 then
			var_5_3 = true
		end

		if not var_5_3 then
			local var_5_5 = TimeMgr.GetInstance():parseTimeFromConfig(var_5_1.time[1])
			local var_5_6 = TimeMgr.GetInstance():parseTimeFromConfig(var_5_1.time[2])
			local var_5_7 = TimeMgr.GetInstance():GetServerTime()

			var_5_3 = var_5_7 < var_5_6 and var_5_5 <= var_5_7 and true or false
		end

		local var_5_8

		if arg_4_0.cfg_.jump2 ~= "" then
			if #arg_4_0.cfg_.jump2 == 5 then
				var_5_8 = arg_4_0.cfg_.jump2[5]
				var_5_3 = ShopTools.IsGoodCanDisplay(var_5_8, arg_4_0.cfg_.jump2[2])
			elseif #arg_4_0.cfg_.jump2 == 3 then
				var_5_8 = arg_4_0.cfg_.jump2[3]
				var_5_3 = ShopTools.IsGoodCanDisplay(var_5_8, arg_4_0.cfg_.jump2[2])
			end
		end

		if var_5_8 then
			local var_5_9, var_5_10 = ShopTools.IsShopSuspended(var_5_8)

			if var_5_9 then
				ShowTips(var_5_10)

				return
			end
		end

		if var_5_3 then
			JumpTools.JumpToPage2(var_5_0, function()
				if arg_4_0.cfg_.jump2 ~= nil and arg_4_0.cfg_.jump2 ~= "" then
					JumpTools.JumpToPage(arg_4_0.cfg_.jump2)
				end
			end)
		else
			ShowTips("GOODS_HAS_BEEN_REMOVED")
		end
	end)

	if arg_4_0.infoBtn_ then
		arg_4_0:AddBtnListener(arg_4_0.infoBtn_, nil, function()
			local var_7_0 = arg_4_0.cfg_.info_desc
			local var_7_1 = ""

			if var_7_0[1] == 1 then
				var_7_1 = RechargeShopDescriptionCfg[var_7_0[2]].desc2
			else
				print("未支持对应类型的说明文本", var_7_0[1])
			end

			JumpTools.OpenPageByJump("gameHelp", {
				title = GetTips("SHOP_GIFT_DESCRIBE"),
				content = var_7_1
			})
		end)
	end
end

function var_0_0.AddEventListeners(arg_8_0)
	return
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.index_ = arg_9_1
	arg_9_0.cfg_ = arg_9_2

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	if arg_10_0.timeGo_ then
		SetActive(arg_10_0.timeGo_, arg_10_0.cfg_.show_time ~= "")

		arg_10_0.timeTxt_.text = arg_10_0.cfg_.show_time

		if arg_10_0.dlcImg_ then
			arg_10_0.dlcImg_.spriteSync = ItemTools.getItemSprite(arg_10_0.cfg_.new_currency_dlc_icon[1])
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

function var_0_0.Hide(arg_14_0)
	SetActive(arg_14_0.gameObject_, false)
end

function var_0_0.Show(arg_15_0)
	SetActive(arg_15_0.gameObject_, true)
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.data_ = nil

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
