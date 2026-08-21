local var_0_0 = class("IlluMusicSongItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.handler = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.expand = false
	arg_2_0.rectTransform = arg_2_0.gameObject_:GetComponent(typeof(RectTransform))
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.expandController = ControllerUtil.GetController(arg_3_0.transform_, "expand")
	arg_3_0.playController = ControllerUtil.GetController(arg_3_0.transform_, "play")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_expandBtn, nil, function()
		arg_4_0:SetExpand(not arg_4_0.expand)
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_playBtn, nil, function()
		if arg_4_0.handler and arg_4_0.handler.PlayMusic then
			arg_4_0.handler:PlayMusic(arg_4_0.id)
		end
	end)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	arg_7_0.id = arg_7_1

	local var_7_0 = MusicRecordCfg[arg_7_1]

	arg_7_0.m_info.text = GetI18NText(var_7_0.detail)

	local var_7_1 = var_7_0.musicName
	local var_7_2 = UnityEngine.TextGenerator.New()
	local var_7_3 = arg_7_0.m_title.transform.rect.size
	local var_7_4 = arg_7_0.m_title:GetGenerationSettings(var_7_3)
	local var_7_5 = arg_7_0.m_title.pixelsPerUnit
	local var_7_6 = GetI18NText(var_7_1)
	local var_7_7 = var_7_2:GetPreferredWidth(var_7_6, var_7_4) / var_7_5

	if var_7_7 > var_7_3.x then
		var_7_6 = var_7_6 .. "..."

		local var_7_8 = utf8len(var_7_6)

		while var_7_7 > var_7_3.x do
			if var_7_8 <= 4 then
				var_7_6 = GetI18NText(var_7_1)

				break
			end

			var_7_8 = var_7_8 - 1 - 3
			var_7_6 = utf8sub(var_7_6, 1, var_7_8) .. "..."
			var_7_7 = var_7_2:GetPreferredWidth(var_7_6, var_7_4) / var_7_5
		end
	end

	arg_7_0.m_title.text = var_7_6

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.m_info.transform)
	arg_7_0:SetExpand(arg_7_0.expand)
end

function var_0_0.RefreshSongsState(arg_8_0, arg_8_1)
	arg_8_0.playController:SetSelectedIndex(arg_8_0.id == arg_8_1 and 1 or 0)
end

function var_0_0.GetMusicId(arg_9_0)
	return arg_9_0.id
end

function var_0_0.SetActive(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

function var_0_0.SetExpand(arg_11_0, arg_11_1)
	arg_11_0.expand = arg_11_1

	if arg_11_1 then
		arg_11_0.expandController:SetSelectedIndex(1)
	else
		arg_11_0.expandController:SetSelectedIndex(0)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.m_info.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.transform_)

	if arg_11_0.handler and arg_11_0.handler.ForceRebuild then
		arg_11_0.handler:ForceRebuild()
	end
end

function var_0_0.GetAnchoredPosition(arg_12_0)
	return arg_12_0.rectTransform.anchoredPosition
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
