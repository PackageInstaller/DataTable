local CombineGameFactorItem = class("CombineGameFactorItem", ReduxView)

function CombineGameFactorItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function CombineGameFactorItem:Init()
	self:InitUI()
end

function CombineGameFactorItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.selectController = ControllerUtil.GetController(self.gameObject_.transform, "select")
end

function CombineGameFactorItem:AddUIListener()
	if self.selectBtn_ then
		self:AddBtnListener(self.selectBtn_, nil, function()
			self.register(self.index, self.factorId, self.selectController)
		end)
	end
end

function CombineGameFactorItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.index = arg_6_1
	self.factorId = arg_6_2
	self.register = arg_6_3
	self.cfg = ActivityCombineFactorCfg[arg_6_2]
	self.isSelect = arg_6_4

	self:UpdateView()
end

function CombineGameFactorItem:UpdateView()
	self.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. self.cfg.icon)
	self.descTxt_.text = GetI18NText(self.cfg.description)

	if self.cfg.score > 0 then
		self.scoreTxt_.text = "+" .. self.cfg.score or self.cfg.score
	end

	if self.selectController then
		self.selectController:SetSelectedState(self.isSelect and "true" or "false")
	end
end

function CombineGameFactorItem:OnEnter()
	self:UpdateView()
end

function CombineGameFactorItem:Dispose()
	CombineGameFactorItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGameFactorItem
