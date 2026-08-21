local var_0_0 = class("PolyhedronBattleTipItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.tipsinfo_ = arg_4_1

	if arg_4_0.tipsinfo_.attribute_id == PolyhedronAttributeIdCfg.GAME_POLYHEDRON_ATTRIBUTE_BOSS_EVENT_AFTER_EVENT_ADD_REBORN_TIMES.id then
		local var_4_0 = arg_4_0.tipsinfo_.delta or 1

		arg_4_0.m_tip.text = string.format(GetTips("POLYHEDRON_RESURRECTION_TIMES"), var_4_0)
	end

	if arg_4_0.tipsinfo_.attribute_id == PolyhedronAttributeIdCfg.GAME_POLYHEDRON_ATTRIBUTE_ARTIFACT_LEVEL_BONUS_COLD_DOWN.id or arg_4_0.tipsinfo_.attribute_id == PolyhedronAttributeIdCfg.GAME_POLYHEDRON_ATTRIBUTE_BOSS_EVENT_AFTER_EVENT_ARTIFACT_STRENGTH_RATE.id then
		local var_4_1 = AffixTypeCfg[arg_4_1.target_id].name
		local var_4_2 = arg_4_0.tipsinfo_.delta or 1

		arg_4_0.m_tip.text = string.format(GetTips("POLYHEDRON_TREASURE_LEVEL"), GetI18NText(var_4_1), var_4_2)
	end

	if arg_4_0.tipsinfo_.attribute_id == PolyhedronAttributeIdCfg.GAME_POLYHEDRON_ATTRIBUTE_HERO_ATTRIBUTE_BONUS_COLD_DOWN.id then
		arg_4_0.m_tip.text = GetI18NText(PolyhedronEffectCfg[arg_4_1.target_id].desc)
	end
end

function var_0_0.SetDisposeHandler(arg_5_0, arg_5_1)
	arg_5_0.disposeHandler_ = arg_5_1
end

function var_0_0.SetIsShow(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)

	arg_6_0.isShow_ = arg_6_1

	if arg_6_1 then
		arg_6_0.transform_:SetAsLastSibling()
		arg_6_0.m_animator:Play("ani")
		arg_6_0:StartTimer()
	end
end

function var_0_0.StartTimer(arg_7_0)
	if arg_7_0.timer_ == nil then
		arg_7_0.timer_ = Timer.New(function()
			arg_7_0:StopTimer()
			arg_7_0:SetIsShow(false)
			arg_7_0.disposeHandler_(arg_7_0.tipsinfo_)
		end, 3, 1)
	end

	arg_7_0.timer_:Start()
end

function var_0_0.StopTimer(arg_9_0)
	if arg_9_0.timer_ then
		arg_9_0.timer_:Stop()

		arg_9_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:StopTimer()
	arg_10_0:SetIsShow(false)
	arg_10_0.disposeHandler_(arg_10_0.tipsinfo_)
end

function var_0_0.GetIsShow(arg_11_0)
	return arg_11_0.isShow_
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
