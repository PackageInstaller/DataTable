local var_0_0 = import("game.views.osiris.recall.OsirisRecallItem")
local var_0_1 = class("OsirisRecallRemasteredItem", var_0_0)

function var_0_1.AddUIListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.m_button, nil, function()
		saveData("osirisExtraStory", "osiris_" .. arg_1_0.id, 1)
		arg_1_0:RefreshNotice()
		manager.notify:Invoke(PLAY_EXTRA_STORY_START)
		manager.story:StartStoryById(arg_1_0.id, function()
			manager.notify:Invoke(PLAY_EXTRA_STORY_OVER)
		end)
	end)
end

function var_0_1.SetData(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1
	arg_4_0.m_button.interactable = true

	arg_4_0.stateController:SetSelectedIndex(0)

	local var_4_0 = StoryCfg[arg_4_1]

	arg_4_0.m_name.text = var_4_0 and GetI18NText(var_4_0.name) or ""

	arg_4_0:RefreshNotice()
end

function var_0_1.RefreshNotice(arg_5_0)
	if getData("osirisExtraStory", "osiris_" .. arg_5_0.id) then
		SetActive(arg_5_0.noticeGo_, false)
	else
		SetActive(arg_5_0.noticeGo_, true)
	end
end

return var_0_1
