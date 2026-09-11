local SimBusinessClientPage = class("SimBusinessClientPage", ReduxView)

function SimBusinessClientPage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SimBusinessClientPage:Init()
	self:InitUI()
end

function SimBusinessClientPage:InitUI()
	self:BindCfgUI()

	self.itemLable = SimBusinessSellGoodSmallItem.New(self.lableGo)
	self.clientItem = SimBusinessGuestInfoItem.New(self.clientGo)
end

function SimBusinessClientPage:RefreshView(arg_4_1, arg_4_2)
	self.id = arg_4_1
	self.cfg = SimBusinessGuestCfg[arg_4_1]

	if self.cfg then
		self.name.text = self.cfg.name

		self.itemLable:RefreshView(self.cfg.love_type, SimBusinessConst.ShowItmeType.good)
		self.clientItem:RefreshData({
			id = arg_4_1
		}, nil, false, false)

		if arg_4_2 then
			self.needNum.text = arg_4_2
		end

		self.skillTex.text = self.cfg.skill_desc
	end
end

function SimBusinessClientPage:OnExit()
	return
end

function SimBusinessClientPage:Dispose()
	self.clientItem:Dispose()
	self.itemLable:Dispose()
	SimBusinessClientPage.super.Dispose(self)
end

return SimBusinessClientPage
