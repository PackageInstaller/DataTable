local var_0_0 = class("PolyhedronArtifactAtlasIItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		if arg_4_0.state == 2 then
			JumpTools.OpenPageByJump("polyhedronArtifactTips", {
				artifact_id = arg_4_0.artifact_id
			})
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.artifact_id = arg_6_1

	local var_6_0 = PolyhedronArtifactCfg[arg_6_1]

	arg_6_0.m_name.text = GetI18NText(var_6_0.name)
	arg_6_0.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. var_6_0.icon)
	arg_6_0.state = PolyhedronData:GetArtifaceAtlasState(arg_6_1)

	if arg_6_0.state == 0 then
		arg_6_0.m_des.text = GetTips("POLYHEDRON_HANDBOOK_NOT_COLLECT")

		arg_6_0.stateController:SetSelectedIndex(1)
	else
		if arg_6_0.state == 1 then
			arg_6_0.stateController:SetSelectedIndex(2)
		else
			arg_6_0.stateController:SetSelectedIndex(0)
		end

		arg_6_0.m_des.text = var_6_0.note or ""
	end

	arg_6_0:SetActive(true)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.m_descTrans_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.m_descPanelTrans_)

	local var_6_1 = 0

	arg_6_0.transform_:SetSizeDeltaY(arg_6_0.m_descPanelTrans_:GetSizeDeltaY(var_6_1))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.transform_)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

return var_0_0
