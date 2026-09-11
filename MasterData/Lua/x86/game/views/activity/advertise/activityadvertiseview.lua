local ActvitiyAdvertiseView = class("ActvitiyAdvertiseView", ReduxView)

function ActvitiyAdvertiseView:UIName()
	return "Widget/System/Activity/ActivityAdvertiseParentUI"
end

function ActvitiyAdvertiseView:UIParent()
	return manager.ui.uiPop.transform
end

function ActvitiyAdvertiseView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function ActvitiyAdvertiseView:OnEnter()
	if #ActivityAdvertiseTools.GetOpenActivityCfgIDList() <= 0 then
		self:Back()

		return
	end

	self:CreateItem()
end

function ActvitiyAdvertiseView:OnExit()
	self:DestroyItem()
end

function ActvitiyAdvertiseView:CreateItem()
	self.itemView_ = ActivityAdvertiseItem.New(self.itemParent_)
end

function ActvitiyAdvertiseView:DestroyItem()
	if self.itemView_ then
		self.itemView_:Dispose()

		self.itemView_ = nil
	end
end

function ActvitiyAdvertiseView:Dispose()
	ActvitiyAdvertiseView.super.Dispose(self)
end

function ActvitiyAdvertiseView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		SDKTools.SendMessageToSDK("activity_publicize_page_jump", {
			opt = 2,
			activity_id = (self.itemView_ and self.itemView_.cfgID_ or nil) and ActivityAdvertiseCfg[self.itemView_.cfgID_] and ActivityAdvertiseCfg[self.itemView_.cfgID_].activity_id
		})

		if ActivityAdvertiseTools.NeedShowAdvertise() then
			self:DestroyItem()
			self:CreateItem()
		else
			self:Back()
		end
	end)
end

function ActvitiyAdvertiseView:Cacheable()
	return false
end

return ActvitiyAdvertiseView
