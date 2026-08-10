local var_0_0 = class("HeroTrustGiftDisplaceItem", ReduxView)

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

	arg_3_0.choiceController = ControllerUtil.GetController(arg_3_0.transform_, "choice")
	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.transform_, "select")
	arg_3_0.loveList = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.m_list, HeroTrustGiftDisplaceHeroItem)
	arg_3_0.item = CommonItemView.New(arg_3_0.m_item, true)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_btn, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.itemId)
		end
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_choiceBtn, function()
		if arg_4_0.callback2_ then
			arg_4_0.callback2_(arg_4_0.itemId)
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.itemId = arg_7_1

	local var_7_0 = clone(ItemTemplateData)

	var_7_0.id = arg_7_1
	var_7_0.number = ItemTools.getItemNum(arg_7_1)

	function var_7_0.clickFun()
		ShowPopItem(POP_ITEM, {
			arg_7_1,
			ItemTools.getItemNum(arg_7_1)
		})
	end

	arg_7_0.item:SetData(var_7_0)

	arg_7_0.m_name.text = ItemTools.getItemName(arg_7_1)
	arg_7_0.heroIds = arg_7_0:GetLikeHeros(arg_7_1)

	arg_7_0.loveList:StartScroll(#arg_7_0.heroIds)
	arg_7_0.choiceController:SetSelectedIndex(arg_7_2 == 0 and 0 or 1)

	arg_7_0.m_choiceLab.text = arg_7_2
end

function var_0_0.SetSelect(arg_9_0, arg_9_1)
	arg_9_0.selectController:SetSelectedIndex(arg_9_1 == arg_9_0.itemId and 1 or 0)
end

function var_0_0.GetLikeHeros(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(HeroRecordCfg.all) do
		local var_10_1 = HeroRecordCfg[iter_10_1]

		if table.indexof(var_10_1.gift_like_id1, arg_10_1) then
			for iter_10_2, iter_10_3 in ipairs(var_10_1.hero_id) do
				if not HeroTools.GetIsHide(iter_10_3) then
					table.insert(var_10_0, iter_10_3)
				end
			end

			break
		end
	end

	return var_10_0
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.item:Dispose()
	arg_11_0.loveList:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.RegistCallBack(arg_12_0, arg_12_1)
	arg_12_0.callback_ = arg_12_1
end

function var_0_0.RegistCallBack2(arg_13_0, arg_13_1)
	arg_13_0.callback2_ = arg_13_1
end

function var_0_0.IndexItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.heroIds[arg_14_1]

	arg_14_2:SetData(var_14_0)
end

return var_0_0
