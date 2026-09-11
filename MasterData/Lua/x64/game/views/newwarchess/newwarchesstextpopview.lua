local NewWarChessTextPopView = class("NewWarChessTextPopView", ReduxView)

function NewWarChessTextPopView:UIName()
	return "UI/NewWarChess/NewWarChessTextPopUI"
end

function NewWarChessTextPopView:UIParent()
	return manager.ui.uiMain.transform
end

function NewWarChessTextPopView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function NewWarChessTextPopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		JumpTools.Back()

		if self.params_.callBack then
			self.params_.callBack()
		end
	end)
end

function NewWarChessTextPopView:OnEnter()
	self.ID_ = self.params_.ID

	local var_6_0 = NewWarChessContentCfg[self.ID_]

	if NewWarChessContentCfg[self.ID_].icon and var_6_0.icon ~= 0 then
		SetActive(self.itemGo_, true)

		self.itemiconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/NewWarChess/Item/" .. var_6_0.icon)
	else
		SetActive(self.itemGo_, false)
	end

	self.textnameText_.text = var_6_0.name
	self.textinfoText_.text = var_6_0.content
end

function NewWarChessTextPopView:OnExit()
	return
end

function NewWarChessTextPopView:Dispose()
	NewWarChessTextPopView.super.Dispose(self)
end

return NewWarChessTextPopView
