local var_0_0 = class("CustomCenterSceneDetailTagItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddToggleListener(arg_3_0.toggle_, function(arg_4_0)
		if arg_4_0 then
			if arg_3_0.onSelect then
				arg_3_0:onSelect()
			end
		elseif not arg_3_0.toggle_.group:AnyTogglesOn() and arg_3_0.onClear then
			arg_3_0:onClear()
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	local var_5_0 = HomeSceneTagCfg[arg_5_1]

	arg_5_0.cfg = var_5_0
	arg_5_0.text_.text = var_5_0.tag_desc
	arg_5_0.icon_.sprite = getSprite("Atlas/MainAtlas", var_5_0.tag_icon)

	arg_5_0:Show(true)
end

function var_0_0.SetOnSelectCallback(arg_6_0, arg_6_1)
	arg_6_0.onSelect = arg_6_1
end

function var_0_0.SetOnClearCallback(arg_7_0, arg_7_1)
	arg_7_0.onClear = arg_7_1
end

function var_0_0.Select(arg_8_0, arg_8_1)
	arg_8_0.toggle.isOn = arg_8_1
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

return var_0_0
