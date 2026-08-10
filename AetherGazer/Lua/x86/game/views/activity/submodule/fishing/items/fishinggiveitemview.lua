local var_0_0 = class("FishingGiveItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:AddEventListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.fishListGo_, FishIcon)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetId(arg_4_0.data_.fishList[arg_4_1], 1)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.giveBtn_, nil, function()
		if FishingData:IsFriendGiveMax(arg_5_0.friendInfo_.user_id) then
			ShowTips("DAILY_GIVE_RARE_FISH_LIMIT_TIP")

			return
		end

		JumpTools.OpenPageByJump("fishingGivePop", {
			data = arg_5_0.data_
		})
	end)
end

function var_0_0.AddEventListeners(arg_7_0)
	return
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_9_0)
	return
end

function var_0_0.SetData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.data_ = arg_10_1
	arg_10_0.friendInfo_ = arg_10_2

	arg_10_0:UpdateView()
end

function var_0_0.UpdateView(arg_11_0)
	arg_11_0.playerNameLabel_.text = GetI18NText(arg_11_0.friendInfo_.nick)
	arg_11_0.playerHeadIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_11_0.friendInfo_.icon)

	arg_11_0.uiList_:StartScroll(#arg_11_0.data_.fishList)

	if FishingData:IsFriendGiveMax(arg_11_0.data_.friendId) then
		arg_11_0.statusController_:SetSelectedState("full")
	else
		arg_11_0.statusController_:SetSelectedState("normal")
	end
end

function var_0_0.OnEnter(arg_12_0)
	return
end

function var_0_0.OnExit(arg_13_0)
	return
end

function var_0_0.OnMainHomeViewTop(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllEventListener()

	if arg_15_0.uiList_ then
		arg_15_0.uiList_:Dispose()

		arg_15_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
