local HeroAstrolabeBaseInfoView = class("HeroAstrolabeBaseInfoView", ReduxView)

function HeroAstrolabeBaseInfoView:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function HeroAstrolabeBaseInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroAstrolabeBaseInfoView:AddUIListener()
	return
end

function HeroAstrolabeBaseInfoView:InitUI()
	self:BindCfgUI()
end

function HeroAstrolabeBaseInfoView:Dispose()
	if self.itemS_ then
		for iter_5_0, iter_5_1 in ipairs(self.itemS_) do
			for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
				iter_5_3:Dispose()
			end
		end
	end

	self.itemSGo_ = nil
	self.itemS_ = nil
	self.astrolabeInfo_ = nil

	HeroAstrolabeBaseInfoView.super.Dispose(self)
end

return HeroAstrolabeBaseInfoView
