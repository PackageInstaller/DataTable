local RegressionNewPage = class("RegressionNewPage", ReduxView)

function RegressionNewPage:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("UI/ReturnUI/RegressionNewUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionNewPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionNewPage:InitUI()
	self:BindCfgUI()
end

function RegressionNewPage:Adapt()
	self.m_rectTransform.sizeDelta = Vector2.New(self.m_contentTransform.rect.size.x, self.m_rectTransform.rect.size.y * (self.m_contentTransform.rect.size.x / self.m_rectTransform.rect.size.x))
end

function RegressionNewPage:AddUIListener()
	return
end

function RegressionNewPage:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function RegressionNewPage:SetData()
	local var_7_0 = RegressionData:GetUrl()

	SetForceShowQuanquan(true)
	self:GetImageByUrl(var_7_0, function(arg_8_0, arg_8_1)
		SetForceShowQuanquan(false)

		if arg_8_0 ~= var_7_0 then
			return
		end

		if self.gameObject_ == nil then
			return
		end

		self.m_bg.sprite = arg_8_1

		self.m_bg:SetNativeSize()
		self:Adapt()
	end)
end

function RegressionNewPage:GetImageByUrl(arg_9_1, arg_9_2)
	if string.find(arg_9_1, "game://") then
		getSpriteWithoutAtlasAsync(string.gsub(arg_9_1, "game://", ""), function(arg_10_0)
			arg_9_2(arg_9_1, arg_10_0)
		end)
	else
		BulletinBoardMgr.inst:GetSprite("mail", arg_9_1, function(arg_11_0)
			arg_9_2(arg_9_1, arg_11_0)
		end)
	end
end

function RegressionNewPage:Dispose()
	RegressionNewPage.super.Dispose(self)
end

return RegressionNewPage
