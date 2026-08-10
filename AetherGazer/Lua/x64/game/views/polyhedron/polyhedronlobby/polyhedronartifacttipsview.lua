local var_0_0 = class("PolyhedronArtifactTipsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/PolyhedronTreasureUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_mask, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.id = arg_8_0.params_.artifact_id

	local var_8_0 = PolyhedronArtifactCfg[arg_8_0.id]

	arg_8_0.m_name.text = GetI18NText(var_8_0.name)
	arg_8_0.m_story.text = GetI18NText(var_8_0.story) or ""
	arg_8_0.affix_id = var_8_0.affix_id
	arg_8_0.max_level = math.min(var_8_0.max_level, AffixTypeCfg[arg_8_0.affix_id].max_level)

	for iter_8_0 = 1, arg_8_0.max_level do
		if not arg_8_0.list[iter_8_0] then
			arg_8_0.list[iter_8_0] = PolyhedronArtifactTipsItem.New(arg_8_0.m_explainGo, arg_8_0.m_content)
		end

		arg_8_0.list[iter_8_0]:SetData(arg_8_0.affix_id, iter_8_0)
	end

	for iter_8_1 = arg_8_0.max_level + 1, #arg_8_0.list do
		arg_8_0.list[iter_8_1]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.m_content)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.m_contentw)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.list) do
		iter_10_1:Dispose()
	end

	arg_10_0.list = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
