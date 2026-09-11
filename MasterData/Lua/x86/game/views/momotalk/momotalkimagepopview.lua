local MomoTalkImagePopView = class("MomoTalkImagePopView", ReduxView)

function MomoTalkImagePopView:UIName()
	return "Widget/System/Momotalk/MomotalkImagePopUI"
end

function MomoTalkImagePopView:UIParent()
	return manager.ui.uiPop.transform
end

function MomoTalkImagePopView:Init()
	self:BindCfgUI()

	if self.controller_ then
		self.stateController_ = self.controller_:GetController("state")
	end

	self:AddListeners()
end

function MomoTalkImagePopView:AddListeners()
	if self.fullScreenBtn_ then
		self:AddBtnListener(self.fullScreenBtn_, nil, function()
			self:Back()
		end)
	end
end

function MomoTalkImagePopView:OnEnter()
	self:RefreshImage((self.params_ or {}).contentID)
end

function MomoTalkImagePopView:RefreshImage(arg_7_1)
	local var_7_0 = ChatContentCfg[arg_7_1 or 0]

	if ChatContentCfg[arg_7_1 or 0] then
		local var_7_2

		if not var_7_0.type then
			var_7_2 = nil == MomoTalkConst.MSG_TYPE.STICKER and "face" or "image"
		end

		local var_7_3

		if nil == MomoTalkConst.MSG_TYPE.STICKER then
			var_7_3 = self.faceImg_ or self.normalImg_
		end
	end

	local var_7_4 = MomoTalkTools.GetImageSpritePath(var_7_0)

	if self.stateController_ then
		self.stateController_:SetSelectedState(var_7_2)
	end

	if var_7_3 then
		var_7_3.sprite = var_7_4 and pureGetSpriteWithoutAtlas(var_7_4) or nil
	end
end

return MomoTalkImagePopView
