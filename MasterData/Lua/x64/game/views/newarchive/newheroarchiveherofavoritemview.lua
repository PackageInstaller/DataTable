local NewHeroArchiveHerofavorItemView = class("NewHeroArchiveHerofavorItemView", ReduxView)

function NewHeroArchiveHerofavorItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index = arg_1_2

	self:Init()
end

function NewHeroArchiveHerofavorItemView:Init()
	self:InitUI()
end

function NewHeroArchiveHerofavorItemView:InitUI()
	self:BindCfgUI()

	self.favorController = ControllerUtil.GetController(self.transform_, "favorability")
end

function NewHeroArchiveHerofavorItemView:OnTop()
	return
end

function NewHeroArchiveHerofavorItemView:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.data = arg_5_1
	self.id = arg_5_2
	self.index = arg_5_3

	self:RefreshUI()
end

function NewHeroArchiveHerofavorItemView:ResetData()
	self.data = nil
end

function NewHeroArchiveHerofavorItemView:RefreshUI(arg_7_1)
	if self.data == nil then
		return
	end

	local var_7_0 = ArchiveData:GetTrustLevel(self.id)

	self.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Itemshead/" .. self.id)

	if var_7_0 > 0 then
		self.favorController:SetSelectedState("3")

		if self.favorExText_ then
			self.favorExText_.text = ArchiveTools.GetTrustLvDes(var_7_0)
		else
			self.favorText_.text = ArchiveTools.GetTrustLvDes(var_7_0)
		end
	else
		if not arg_7_1 then
			self.favorController:SetSelectedState("1")
		else
			self.favorController:SetSelectedState("2")
		end

		if self.favorExText_ then
			self.favorExText_.text = string.format(GetTips("HERO_HEART_CHAIN_LOVE_TIP"), self.data.lv)
		else
			self.favorText_.text = arg_7_1 and string.format(GetTips("HERO_HEART_CHAIN_LOVE_TIP"), self.data.lv) or "Lv." .. self.data.lv
		end
	end

	if not arg_7_1 and self.index > 1 then
		SetActive(self.gameObject_, false)
	else
		SetActive(self.gameObject_, true)
	end

	if self.nameText_ then
		self.nameText_.text = arg_7_1 and HeroCfg[self.id].name or HeroTools.GetHeroName(self.id)
	end
end

function NewHeroArchiveHerofavorItemView:OnExit()
	return
end

function NewHeroArchiveHerofavorItemView:Dispose()
	NewHeroArchiveHerofavorItemView.super.Dispose(self)
end

return NewHeroArchiveHerofavorItemView
