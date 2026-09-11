local ChatBaseItemView = class("ChatBaseItemView", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function ChatBaseItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:Init()
	self:AddListeners()
	self:Show(true)
end

function ChatBaseItemView:Show(arg_2_1)
	SetActive(self.gameObject_, arg_2_1)
end

function ChatBaseItemView:Init()
	return
end

function ChatBaseItemView:AddListeners()
	return
end

function ChatBaseItemView:Dispose()
	self:RemoveAllListeners()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	ChatBaseItemView.super.Dispose(self)
end

return ChatBaseItemView
