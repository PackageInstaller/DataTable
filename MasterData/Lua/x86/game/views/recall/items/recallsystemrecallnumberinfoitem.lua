local RecallSystemRecallNumberInfoItem = class("RecallSystemRecallNumberInfoItem", ReduxView)

function RecallSystemRecallNumberInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RecallSystemRecallNumberInfoItem:Init()
	self:InitUI()
end

function RecallSystemRecallNumberInfoItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(self.copyBrn_, nil, function()
		ShowTips("COPY_SUCCESS")

		UnityEngine.GUIUtility.systemCopyBuffer = self.data.user_id
	end)
end

function RecallSystemRecallNumberInfoItem:SetData(arg_5_1)
	self.data = arg_5_1

	self:UpdateView()
end

function RecallSystemRecallNumberInfoItem:UpdateView()
	self.recallNameTxt_.text = self.data.base_info.nick
	self.recallUIDTxt_.text = self.data.user_id
	self.recallHeadshotImg_.sprite = ItemTools.getItemSprite(self.data.base_info.icon)

	self.recallHeadshotImg_:SetNativeSize()

	self.serverName.text = string.format(GetTips("RECALLED_SERVER_NAME"), self.data.server_name)
end

function RecallSystemRecallNumberInfoItem:OnEnter()
	return
end

function RecallSystemRecallNumberInfoItem:OnExit()
	return
end

function RecallSystemRecallNumberInfoItem:Dispose()
	RecallSystemRecallNumberInfoItem.super.Dispose(self)
end

return RecallSystemRecallNumberInfoItem
