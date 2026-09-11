local ChooseStickerTemplateView = class("ChooseStickerTemplateView", ReduxView)

function ChooseStickerTemplateView:UIName()
	return "Widget/System/UserInfor/paster/StickerChooseTemplateUI"
end

function ChooseStickerTemplateView:UIParent()
	return manager.ui.uiMain.transform
end

function ChooseStickerTemplateView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ChooseStickerTemplateView:InitUI()
	self:BindCfgUI()

	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.scrollList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, StickerTemplateItem)
end

function ChooseStickerTemplateView:IndexItem(arg_5_1, arg_5_2)
	local var_5_0 = self.list_[arg_5_1]

	arg_5_2:RefreshUI(self.list_[arg_5_1], self.bgID_)

	if var_5_0 == self.chooseID_ then
		arg_5_2:SetState("use")
	else
		arg_5_2:SetState("change")
	end

	arg_5_2:SetSelected(var_5_0 == self.curID_)
	arg_5_2:RegistClickFunc(function()
		self:SetTemplateID(var_5_0)
	end)
end

function ChooseStickerTemplateView:AddUIListeners()
	self:AddBtnListener(self.changeBtn_, nil, function()
		self.params_.temp.info[self.index_].viewID = self.curID_

		self:Back(1, {
			resetSize = true,
			type = 2,
			tempInfo = self.params_.temp,
			index = self.index_
		})
	end)
end

function ChooseStickerTemplateView:OnEnter()
	self.index_ = self.params_.index
	self.chooseID_ = self.params_.chooseID
	self.bgID_ = self.params_.temp.stickerBg
	self.list_ = StickViewTemplateCfg.all

	self:RefreshUI()
end

function ChooseStickerTemplateView:RefreshUI()
	self.bg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Sticker/stickerBtn/Sticker_big_" .. self.bgID_)

	self:Sortlist()
	self:SetTemplateID(self.chooseID_)
	self.scrollList_:StartScroll(#self.list_, table.indexof(self.list_, self.chooseID_))
end

function ChooseStickerTemplateView:Sortlist()
	table.sort(self.list_, function(arg_12_0, arg_12_1)
		if arg_12_0 == self.chooseID_ or arg_12_1 == self.chooseID_ then
			return arg_12_0 == self.chooseID_
		end

		return arg_12_0 < arg_12_1
	end)
end

function ChooseStickerTemplateView:SetTemplateID(arg_13_1)
	self.curID_ = arg_13_1

	self:RefreshInfo()
	self.scrollList_:Refresh()
end

function ChooseStickerTemplateView:RefreshInfo()
	self.show_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Sticker/stickerBtn/Sticker_template_" .. self.curID_)

	if self.curID_ == self.chooseID_ then
		self.stateCon_:SetSelectedState("use")
	else
		self.stateCon_:SetSelectedState("change")
	end
end

function ChooseStickerTemplateView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:Back(1, {
			type = 2,
			tempInfo = self.params_.temp
		})
	end)
end

function ChooseStickerTemplateView:OnExit()
	return
end

function ChooseStickerTemplateView:Dispose()
	self:RemoveAllListeners()

	if self.scrollList_ then
		self.scrollList_:Dispose()

		self.scrollList_ = nil
	end

	ChooseStickerTemplateView.super.Dispose(self)
end

return ChooseStickerTemplateView
