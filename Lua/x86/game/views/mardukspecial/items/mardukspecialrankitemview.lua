local var_0_0 = class("MardukSpecialRankItemView", ReduxView)

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

	arg_3_0.heroCountController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "heroCount")
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
	arg_7_0.icon_.sprite = ItemTools.getItemSprite(arg_7_0.data_.portrait)
	arg_7_0.frame_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_7_0.data_.frame)
	arg_7_0.name_.text = GetI18NText(arg_7_0.data_.nick)
	arg_7_0.score_.text = arg_7_0.data_.score
	arg_7_0.rank_.text = arg_7_0.data_.rank

	if arg_7_0.data_.rank <= 3 then
		arg_7_0.rankController_:SetSelectedState(tostring(arg_7_0.data_.rank))
	else
		arg_7_0.rankController_:SetSelectedState("0")
	end

	local var_7_0 = arg_7_0.data_:GetSingleSelectHeroList()

	arg_7_0.heroCountController_:SetSelectedState(tostring(#var_7_0))

	for iter_7_0 = 1, 3 do
		local var_7_1 = arg_7_0["m_heroIcon_" .. iter_7_0].gameObject
		local var_7_2 = arg_7_0["m_heroIcon_" .. iter_7_0]

		if var_7_0[iter_7_0] then
			local var_7_3 = var_7_0[iter_7_0]
			local var_7_4 = var_7_3.skin_id

			if var_7_4 == 0 then
				var_7_4 = var_7_3.hero_id
			end

			var_7_2.sprite = ItemTools.getItemSprite(var_7_4)
		end
	end
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
