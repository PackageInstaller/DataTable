local var_0_0 = import("game.views.newHero.HeroPageBase")
local var_0_1 = class("HeroChipPage", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.chipCout_ = 4

	arg_1_0:Init()
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.isSelfController_ = arg_2_0.controller_:GetController("isSelf")
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.chipItem_ = {}

	for iter_3_0 = 1, arg_3_0.chipCout_ do
		local var_3_0 = Object.Instantiate(arg_3_0.chipItemGo_, arg_3_0.chipContent_, false)

		arg_3_0.chipItem_[iter_3_0] = NewHeroChipPageItem.New(var_3_0)
	end
end

function var_0_1.AddUIListener(arg_4_0)
	return
end

function var_0_1.OnEnter(arg_5_0, arg_5_1)
	arg_5_0.heroViewProxy_ = arg_5_1
end

function var_0_1.CameraEnter(arg_6_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		6,
		0
	})
end

function var_0_1.UpdateView(arg_7_0)
	if ChipTools.GetHeroChipIDList(arg_7_0.heroInfo_.id) then
		local var_7_0
		local var_7_1 = arg_7_0:GetChipIDList()

		if not var_7_1 then
			return
		end

		local var_7_2 = {}

		for iter_7_0, iter_7_1 in pairs(ChipTools.GetHeroChipIDList(arg_7_0.heroInfo_.id)) do
			var_7_2[ChipCfg[iter_7_1].role_type_id] = true
		end

		for iter_7_2 = 1, 4 do
			arg_7_0.chipItem_[iter_7_2]:SetData(var_7_1[iter_7_2], arg_7_0.heroInfo_.id, iter_7_2, arg_7_0.extra_)
			arg_7_0.chipItem_[iter_7_2]:BindRedPoint()

			if var_7_2[iter_7_2] then
				arg_7_0.chipItem_[iter_7_2]:SetIsShow(true)
			else
				arg_7_0.chipItem_[iter_7_2]:SetIsShow(false)
			end
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.contentTrans_)
		arg_7_0:CheckLocked()
	end
end

function var_0_1.GetChipIDList(arg_8_0)
	return ChipData:GetEnableHeroChipIdByHeroId(arg_8_0.heroInfo_.id)
end

function var_0_1.CheckLocked(arg_9_0)
	arg_9_0.isSelfController_:SetSelectedState(arg_9_0.heroViewProxy_.isSelf and "true" or "false")
end

function var_0_1.OnExit(arg_10_0)
	for iter_10_0 = 1, 4 do
		arg_10_0.chipItem_[iter_10_0]:UnBindRedPoint()
	end
end

function var_0_1.SetHeroInfo(arg_11_0, arg_11_1)
	arg_11_0.heroInfo_ = arg_11_1
end

function var_0_1.Show(arg_12_0)
	var_0_1.super.Show(arg_12_0)
	arg_12_0:UpdateView()
end

function var_0_1.Dispose(arg_13_0)
	var_0_1.super.Dispose(arg_13_0)

	for iter_13_0, iter_13_1 in pairs(arg_13_0.chipItem_) do
		iter_13_1:UnBindRedPoint()
		iter_13_1:Dispose()
	end

	arg_13_0.chipItem_ = nil
end

return var_0_1
