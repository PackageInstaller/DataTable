local var_0_0 = class("GuildActivitySPRecordItemView", ReduxView)

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

	arg_3_0.rankController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "rank")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.AddEventListeners(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index_ = arg_6_1
	arg_6_0.data_ = arg_6_2

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	if arg_7_0.index_ < 4 then
		arg_7_0.rankController_:SetSelectedState(tostring(arg_7_0.index_ - 1))
	else
		arg_7_0.rankController_:SetSelectedState("3")
	end

	arg_7_0.m_rankText.text = arg_7_0.index_
	arg_7_0.m_icon.sprite = ItemTools.getItemSprite(arg_7_0.data_.icon)
	arg_7_0.m_name.text = arg_7_0.data_.name
	arg_7_0.m_scoreText.text = arg_7_0.data_.damage
	arg_7_0.m_frame.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_7_0.data_.icon_frame)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:AddEventListeners()
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.data_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
