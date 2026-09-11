local HodurMainlineStageItem = class("HodurMainlineStageItem", ReduxView)

function HodurMainlineStageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function HodurMainlineStageItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.mainControllerEx_:GetController("state")
	self.selectController_ = self.mainControllerEx_:GetController("select")
	self.lineController_ = self.mainControllerEx_:GetController("line")
end

function HodurMainlineStageItem:SetData(arg_3_1)
	self.stageID_ = arg_3_1

	self:RefreshUI()
end

function HodurMainlineStageItem:RefreshUI()
	self.bossHeadImg_1.sprite = getSpriteWithoutAtlas(HodurConst.BOSS_IMG_PATH .. ActivityHodurCfg[self.stageID_].boss_img)
	self.bossHeadImg_2.sprite = getSpriteWithoutAtlas(HodurConst.BOSS_IMG_PATH .. ActivityHodurCfg[self.stageID_].boss_img)
end

function HodurMainlineStageItem:SetActive(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function HodurMainlineStageItem:Dispose()
	HodurMainlineStageItem.super.Dispose(self)
end

return HodurMainlineStageItem
