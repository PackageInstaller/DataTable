local AffixSelectAffixItemView = class("AffixSelectAffixItemView", ReduxView)

function AffixSelectAffixItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.onItemSelect_ = arg_1_2

	self:Init()
end

function AffixSelectAffixItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AffixSelectAffixItemView:InitUI()
	self:BindCfgUI()

	self.btn_ = self.gameObject_:GetComponent(typeof(Button))
	self.selectController_ = ControllerUtil.GetController(self.gameObject_.transform, "select1")
end

function AffixSelectAffixItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self:SetSelect(not self.isSelect_)

		if self.onItemSelect_ ~= nil then
			self.onItemSelect_(self.affixPoolId_, self.isSelect_)
		end
	end)
end

function AffixSelectAffixItemView:AddEventListeners()
	return
end

function AffixSelectAffixItemView:SetData(arg_7_1, arg_7_2, arg_7_3)
	self.index_ = arg_7_1
	self.affixPoolId_ = arg_7_2
	self.isSelect_ = arg_7_3
	self.cfg_ = ActivityAffixPoolCfg[arg_7_2]

	self:UpdateView()
	self:SetSelect(self.isSelect_)
end

function AffixSelectAffixItemView:SetSelect(arg_8_1)
	self.isSelect_ = arg_8_1

	self.selectController_:SetSelectedState(arg_8_1 and "select" or "normal")
end

function AffixSelectAffixItemView:UpdateView()
	self.numLabel_.text = self.cfg_.point
	self.descLabel_.text = GetI18NText(getAffixDesc(self.cfg_.affix))
end

function AffixSelectAffixItemView:OnEnter()
	self:AddEventListeners()
end

function AffixSelectAffixItemView:OnExit()
	self:RemoveAllEventListener()
end

function AffixSelectAffixItemView:OnMainHomeViewTop()
	return
end

function AffixSelectAffixItemView:Dispose()
	self.data_ = nil
	self.onItemSelect_ = nil

	AffixSelectAffixItemView.super.Dispose(self)
end

return AffixSelectAffixItemView
