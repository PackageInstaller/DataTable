local OsirisRecallItem = class("OsirisRecallItem", ReduxView)

function OsirisRecallItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function OsirisRecallItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function OsirisRecallItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "Item")
end

function OsirisRecallItem:AddUIListener()
	self:AddBtnListener(self.m_button, nil, function()
		manager.story:StartStoryById(self.id, function()
			return
		end)
	end)
end

function OsirisRecallItem:SetData(arg_7_1)
	self.id = arg_7_1

	if PlayerData:GetPlayerInfo().storylist[arg_7_1] or false then
		self.m_button.interactable = true

		self.stateController:SetSelectedIndex(0)
	else
		self.m_button.interactable = false

		self.stateController:SetSelectedIndex(1)
	end

	self.m_name.text = StoryCfg[arg_7_1] and GetI18NText(StoryCfg[arg_7_1].name) or ""
end

function OsirisRecallItem:Dispose()
	OsirisRecallItem.super.Dispose(self)
end

return OsirisRecallItem
