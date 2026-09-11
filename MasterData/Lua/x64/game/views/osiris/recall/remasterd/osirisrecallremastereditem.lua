local OsirisRecallRemasteredItem = class("OsirisRecallRemasteredItem", (import("game.views.osiris.recall.OsirisRecallItem")))

function OsirisRecallRemasteredItem:AddUIListener()
	self:AddBtnListener(self.m_button, nil, function()
		saveData("osirisExtraStory", "osiris_" .. self.id, 1)
		self:RefreshNotice()
		manager.notify:Invoke(PLAY_EXTRA_STORY_START)
		manager.story:StartStoryById(self.id, function()
			manager.notify:Invoke(PLAY_EXTRA_STORY_OVER)
		end)
	end)
end

function OsirisRecallRemasteredItem:SetData(arg_4_1)
	self.id = arg_4_1
	self.m_button.interactable = true

	self.stateController:SetSelectedIndex(0)

	self.m_name.text = StoryCfg[arg_4_1] and GetI18NText(StoryCfg[arg_4_1].name) or ""

	self:RefreshNotice()
end

function OsirisRecallRemasteredItem:RefreshNotice()
	if getData("osirisExtraStory", "osiris_" .. self.id) then
		SetActive(self.noticeGo_, false)
	else
		SetActive(self.noticeGo_, true)
	end
end

return OsirisRecallRemasteredItem
