local IchiBanPopView = class("IchiBanPopView", ReduxView)

function IchiBanPopView:UIName()
	return IchiBanTools.GetCfg(IchiBanTeaserCfg[self.params_.id].activity_id).pop_prefab_path
end

function IchiBanPopView:UIParent()
	return manager.ui.uiPop.transform
end

function IchiBanPopView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function IchiBanPopView:OnEnter()
	self.id_ = self.params_.id
	self.nameText_.text = IchiBanTeaserCfg[self.id_].clue_title
	self.descText_.text = IchiBanTeaserCfg[self.id_].clue_desc
	self.iconImg_.sprite = pureGetSpriteWithoutAtlas(IchiBanTeaserCfg[self.id_].clue_pic)
end

function IchiBanPopView:OnExit()
	return
end

function IchiBanPopView:Dispose()
	IchiBanPopView.super.Dispose(self)
end

function IchiBanPopView:AddListeners()
	self:AddBtnListener(self.exitBtn_, nil, function()
		self:Back()
	end)
end

return IchiBanPopView
