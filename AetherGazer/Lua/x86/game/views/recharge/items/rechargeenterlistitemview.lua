local var_0_0 = class("RechargeEnterListItemView", ReduxView)

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

	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickListener_ ~= nil then
			arg_4_0.clickListener_(arg_4_0.index_)
		end
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.RegisterClickListener(arg_7_0, arg_7_1)
	arg_7_0.clickListener_ = arg_7_1
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.index_ = arg_8_1

	if arg_8_0.id_ ~= nil then
		manager.redPoint:unbindUIandKey(arg_8_0.noticeContainer_, RedPointConst.RECHARGE_RECOMMEND .. arg_8_0.id_, {
			x = 0,
			y = 0
		})
	end

	arg_8_0.id_ = arg_8_2

	manager.redPoint:bindUIandKey(arg_8_0.noticeContainer_, RedPointConst.RECHARGE_RECOMMEND .. arg_8_0.id_, {
		x = 0,
		y = 0
	})

	arg_8_0.cfg_ = RechargeRecommendCfg[arg_8_0.id_]

	arg_8_0:UpdateView()
end

function var_0_0.UpdateView(arg_9_0)
	arg_9_0.titleLabel_.text = arg_9_0.cfg_.title
	arg_9_0.subTitleLabel_.text = arg_9_0.cfg_.sub_title
	arg_9_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/RechargeRecommend/icons/" .. arg_9_0.cfg_.icon)
end

function var_0_0.GetIndex(arg_10_0)
	return arg_10_0.index_
end

function var_0_0.SetSelect(arg_11_0, arg_11_1)
	if arg_11_1 and arg_11_0.id_ ~= nil then
		ShopAction.ReadRedPoint(arg_11_0.id_)
	end

	arg_11_0.selectController_:SetSelectedState(arg_11_1 and "on" or "off")
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:AddEventListeners()
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.data_ = nil

	if arg_15_0.id_ ~= nil then
		manager.redPoint:unbindUIandKey(arg_15_0.noticeContainer_, RedPointConst.RECHARGE_RECOMMEND .. arg_15_0.id_, {
			x = 0,
			y = 0
		})
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
