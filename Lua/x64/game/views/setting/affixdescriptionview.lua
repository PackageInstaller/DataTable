local var_0_0 = class("AffixDescriptionView", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.hander_ = arg_2_1
	arg_2_0.transform_ = arg_2_2.transform
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.data = arg_2_3

	arg_2_0:Init()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.emptyController = ControllerUtil.GetController(arg_3_0.transform_, "empty")
	arg_3_0.items = {}

	arg_3_0:CreatItems()
end

function var_0_0.CreatItems(arg_4_0)
	local var_4_0 = 1
	local var_4_1 = false
	local var_4_2 = false

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.data) do
		local var_4_3 = iter_4_1[3] == 3

		var_4_1 = var_4_1 or var_4_3
		var_4_2 = var_4_2 or not var_4_3

		if not arg_4_0.items[var_4_0] then
			local var_4_4 = Object.Instantiate(arg_4_0.m_item, var_4_3 and arg_4_0.m_playerContent or arg_4_0.m_monsterContent)

			arg_4_0.items[var_4_0] = {
				go = var_4_4,
				desc = var_4_4.transform:Find("text"):GetComponent("Text"),
				name = var_4_4.transform:Find("title/name"):GetComponent("Text"),
				icon = var_4_4.transform:Find("title/icon"):GetComponent("Image")
			}
		end

		arg_4_0:RenderItme(arg_4_0.items[var_4_0], iter_4_1)

		var_4_0 = var_4_0 + 1
	end

	if var_4_1 and var_4_2 then
		arg_4_0.emptyController:SetSelectedIndex(0)
	elseif var_4_2 then
		arg_4_0.emptyController:SetSelectedIndex(1)
	elseif var_4_1 then
		arg_4_0.emptyController:SetSelectedIndex(2)
	else
		arg_4_0.emptyController:SetSelectedIndex(3)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.m_content)
end

function var_0_0.RenderItme(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1.icon.sprite = getAffixSprite(arg_5_2)
	arg_5_1.name.text = getAffixName(arg_5_2)
	arg_5_1.desc.text = getAffixDesc(arg_5_2)

	SetActive(arg_5_1.go, true)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.items = {}

	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.hander_ = nil
	arg_6_0.data = nil
end

return var_0_0
