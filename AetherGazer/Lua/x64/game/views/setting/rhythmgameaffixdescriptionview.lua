local var_0_0 = import("game.views.setting.AffixDescriptionView")
local var_0_1 = class("RhythmGameAffixDescriptionView", var_0_0)

function var_0_1.CreatItems(arg_1_0)
	local var_1_0 = 1

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.data) do
		if not arg_1_0.items[var_1_0] then
			local var_1_1 = Object.Instantiate(arg_1_0.m_item, arg_1_0.m_content)

			arg_1_0.items[var_1_0] = {
				go = var_1_1,
				desc = var_1_1.transform:Find("text"):GetComponent("Text"),
				name = var_1_1.transform:Find("title/name"):GetComponent("Text"),
				icon = var_1_1.transform:Find("title/icon"):GetComponent("Image")
			}
		end

		arg_1_0:RenderItme(arg_1_0.items[var_1_0], iter_1_1)

		var_1_0 = var_1_0 + 1
	end

	arg_1_0.emptyController:SetSelectedIndex(4)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_0.m_content)
end

return var_0_1
