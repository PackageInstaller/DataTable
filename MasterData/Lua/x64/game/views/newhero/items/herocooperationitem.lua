local HeroCooperationItem = class("HeroCooperationItem", ReduxView)

function HeroCooperationItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:InitUI()
	self:AddUIListeners()
end

function HeroCooperationItem:InitUI()
	self.list = {}
	self.ownController = self.controller_:GetController("own")
	self.showController = self.controller_:GetController("show")
	self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function HeroCooperationItem:AddUIListeners()
	self:AddBtnListener(self.selectBtn_, nil, function()
		self.clickCallBack(self.data.id)

		if self.showController:GetSelectedState() == "true" then
			self.showController:SetSelectedState("false")
			self.animator_:Play("EsotericVideo_02")
		else
			SetActive(self.emptyGo, true)
			AnimatorTools.PlayAnimatorWithCallback(self.animator_, "EsotericVideo", function()
				SetActive(self.emptyGo, false)
			end, false)
			self.showController:SetSelectedState("true")
		end
	end)
	self:AddBtnListener(self.unSelectBtn_, nil, function()
		self.clickCallBack(self.data.id)

		if self.showController:GetSelectedState() == "true" then
			self.showController:SetSelectedState("false")
			self.animator_:Play("EsotericVideo_02")
		else
			SetActive(self.emptyGo, true)
			AnimatorTools.PlayAnimatorWithCallback(self.animator_, "EsotericVideo", function()
				SetActive(self.emptyGo, false)
			end, false)
			self.showController:SetSelectedState("true")
		end
	end)
end

function HeroCooperationItem:indexItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.comboSkillData[arg_8_1], self.callBack, self.data.id)
end

function HeroCooperationItem:SetData(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	self.data = arg_9_1
	self.callBack = arg_9_2
	self.selectHeroId = arg_9_3
	self.clickCallBack = arg_9_4
	self.index = arg_9_5
	self.emptyGo = arg_9_6
	self.heroInfo = self.heroViewProxy_:GetHeroData(self.data.id)
	self.comboSkillData = ComboSkillTools.GetHeroComboSkill(self.data.id)
	self.skinID = self.heroViewProxy_:GetHeroUsingSkinInfo(self.data.id).id

	self:UpdateView()
end

function HeroCooperationItem:UpdateView()
	self.unSelectImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.skinID)
	self.selectImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.skinID)
	self.unSelectName_.text = GetI18NText(HeroCfg[self.data.id].name)
	self.selectName_.text = GetI18NText(HeroCfg[self.data.id].name)

	local var_10_0 = #(self.comboSkillData or {})

	for iter_10_0 = 1, #(self.comboSkillData or {}) do
		if self.list[iter_10_0] == nil then
			if self["item" .. iter_10_0 .. "Go_"] == nil then
				local var_10_1 = GameObject.Instantiate(self.item1Go_)

				var_10_1.transform:SetParent(self.item1Go_.transform.parent, false)

				self["item" .. iter_10_0 .. "Go_"] = var_10_1
			end

			self.list[iter_10_0] = HeroCooperationItemItem.New(self["item" .. iter_10_0 .. "Go_"])
		end

		self.list[iter_10_0]:SetData(self.comboSkillData[iter_10_0], self.callBack, self.data.id)
		SetActive(self["item" .. iter_10_0 .. "Go_"], true)
	end

	for iter_10_1 = var_10_0 + 1, math.max(#self.list, 5) do
		SetActive(self["item" .. iter_10_1 .. "Go_"], false)
	end

	if self.data.id == self.selectHeroId then
		self.animator_:Play("EsotericVideo")
	elseif self.showController:GetSelectedState() == "true" then
		self.animator_:Play("none")
	end

	self.showController:SetSelectedState(tostring(self.data.id == self.selectHeroId))
	self.ownController:SetSelectedState(tostring(self.heroInfo.unlock == 1))

	self.selectHeroId = nil

	if var_10_0 <= 3 then
		self.scroll_.movementType = ScrollRect.MovementType.Clamped or ScrollRect.MovementType.Elastic
	end
end

function HeroCooperationItem:Dispose()
	for iter_11_0, iter_11_1 in pairs(self.list) do
		iter_11_1:Dispose()
	end

	HeroCooperationItem.super.Dispose(self)
end

return HeroCooperationItem
