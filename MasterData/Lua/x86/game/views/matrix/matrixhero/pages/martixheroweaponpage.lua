local MatrixHeroAttributePage = class("MatrixHeroAttributePage", ReduxView)

function MatrixHeroAttributePage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function MatrixHeroAttributePage:Init()
	self:InitUI()

	self.nullController_ = ControllerUtil.GetController(self.transform_, "null")
end

function MatrixHeroAttributePage:InitUI()
	self:BindCfgUI()

	self.detailView_ = WeaponServantDetailView.New(self.m_detailGo)

	if self.detailView_.btnlook1Btn_ then
		SetActive(self.detailView_.btnlook1Btn_.gameObject, false)
	end
end

function MatrixHeroAttributePage:SetMatirxHeroInfo(arg_4_1)
	self.heroId_ = arg_4_1

	local var_4_0 = self:GetHeroData(arg_4_1)
	local var_4_1 = var_4_0:GetWeaponServantEffect()

	if var_4_1 ~= 0 then
		self.detailView_:SetDescBtn(true)
		self.detailView_:SetWeaponServantData({
			locked = 0,
			uid = 0,
			id = var_4_1,
			stage = var_4_0:GetWeaponServantEffectLevel()
		})
		self.detailView_:RefreshEffectText(2)
		self.nullController_:SetSelectedIndex(0)

		self.m_countLab.text = "1/1"
	else
		self.nullController_:SetSelectedIndex(1)

		self.m_countLab.text = "0/1"
	end
end

function MatrixHeroAttributePage:OnEnter()
	if self.detailView_ then
		self.detailView_:OnEnter()
	end
end

function MatrixHeroAttributePage:OnExit()
	if self.detailView_ then
		self.detailView_:OnExit()
	end
end

function MatrixHeroAttributePage:Hide()
	SetActive(self.gameObject_, false)
end

function MatrixHeroAttributePage:Show()
	SetActive(self.gameObject_, true)
end

function MatrixHeroAttributePage:Dispose()
	self:RemoveAllListeners()

	self.handler_ = nil

	if self.detailView_ then
		self.detailView_:Dispose()

		self.detailView_ = nil
	end

	MatrixHeroAttributePage.super.Dispose(self)
end

function MatrixHeroAttributePage:GetHeroData(arg_10_1)
	return MatrixData:GetHeroData(arg_10_1)
end

return MatrixHeroAttributePage
