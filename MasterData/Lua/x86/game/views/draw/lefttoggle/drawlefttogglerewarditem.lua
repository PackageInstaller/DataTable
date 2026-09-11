local DrawLeftToggleRewardItem = class("DrawLeftToggleRewardItem", ReduxView)

function DrawLeftToggleRewardItem:UIName()
	return "Widget/System/Pool/ExtractReturnMarkNew"
end

function DrawLeftToggleRewardItem:Ctor(arg_2_1)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), arg_2_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controllerEx_:GetController("sel")
end

function DrawLeftToggleRewardItem:Dispose()
	DrawLeftToggleRewardItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transfrom_ = nil
end

function DrawLeftToggleRewardItem:AddListeners()
	return
end

function DrawLeftToggleRewardItem:SetData(arg_5_1)
	self.icon_.sprite = getSprite("Atlas/PoolAtlas", ActivityDrawBonusCfg[arg_5_1].pool_tag_img)

	self:Show(true)
end

function DrawLeftToggleRewardItem:RefreshSelectState(arg_6_1)
	if arg_6_1 then
		self.selectController_:SetSelectedState("on")
	else
		self.selectController_:SetSelectedState("off")
	end
end

function DrawLeftToggleRewardItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

return DrawLeftToggleRewardItem
