local GetSkinView = class("GetSkinView", ReduxView)

function GetSkinView:UIName()
	return "UI/Obtain/Skin/SkinAUI"
end

function GetSkinView:UIParent()
	return manager.ui.uiPop.transform
end

function GetSkinView:Init()
	self:InitUI()
end

function GetSkinView:InitUI()
	self:BindCfgUI()
	self:AddListeners()
end

function GetSkinView:AddListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self.playableDirector_.time >= self:GetTimeLineEndTime() then
			self:Back()
			self.callback_()
		else
			self.playableDirector_.time = self:GetTimeLineEndTime()
		end
	end)
end

function GetSkinView:GetTimeLineEndTime()
	return 6.27
end

function GetSkinView:OnEnter()
	self.skinID_ = self.params_.skinID
	self.portrait_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. SkinCfg[self.skinID_].picture_id)
	self.name_.text = ItemTools.getItemName(self.skinID_)

	self.playableDirector_:Evaluate()
	self.playableDirector_:Play()

	self.callback_ = self.params_.callback

	SetActive(self.gameObject_, true)
end

function GetSkinView:OnExit()
	if self.playableDirector_.time < self:GetTimeLineEndTime() then
		self.playableDirector_.time = self.playableDirector_.duration
	end
end

function GetSkinView:Dispose()
	self:RemoveAllListeners()
	GetSkinView.super.Dispose(self)
end

return GetSkinView
