local OsirisPlayGameUnlockPopView = class("OsirisPlayGameUnlockPopView", ReduxView)

function OsirisPlayGameUnlockPopView:UIName()
	return "Widget/System/Activity_Osiris/Activity_Osiris_UnlockPopUI"
end

function OsirisPlayGameUnlockPopView:UIParent()
	return manager.ui.uiPop.transform
end

function OsirisPlayGameUnlockPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function OsirisPlayGameUnlockPopView:InitUI()
	self:BindCfgUI()

	self.tagCon_ = self.tyoeConEx_:GetController("type")
end

function OsirisPlayGameUnlockPopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function OsirisPlayGameUnlockPopView:OnEnter()
	self.heroId = self.params_.heroId

	for iter_7_0 = 1, 3 do
		SetActive(self["genGo_" .. iter_7_0], false)
	end

	self:RefreshView()
end

function OsirisPlayGameUnlockPopView:RefreshView()
	local var_8_0 = ActivityGeneralityCharactorCfg[self.heroId]

	self.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.heroId)

	local var_8_1 = HeroCfg[self.heroId]

	self.campImg_.sprite = getSprite("Atlas/SystemGroupAtlas", string.format("com_white_icon_group_%s_c", HeroCfg[self.heroId].race))
	self.typeText_.text = var_8_0.charactor_type == 1 and GetTips("IS_CAPTAIN") or GetTips("IS_SUPPORT")

	self.tagCon_:SetSelectedIndex(var_8_0.charactor_type == 1 and 1 or 0)

	self.nameText_.text = GetI18NText(var_8_1.name)
	self.sufffixText_.text = GetI18NText(var_8_1.suffix)

	for iter_8_0 = 1, #var_8_0.generality do
		SetActive(self["genGo_" .. iter_8_0], true)

		self["genImg_" .. iter_8_0].sprite = getSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. var_8_0.generality[iter_8_0])
		self["tagText_" .. iter_8_0].text = ActivityGeneralityTagCfg[var_8_0.generality[iter_8_0]].name
	end

	if var_8_0.qte_skill ~= 0 then
		SetActive(self.supportGo_, true)

		self.supportImg_.sprite = getSprite("Atlas/" .. self.heroId, ActivityGeneralityQteCfg[var_8_0.qte_skill].icon)
		self.skillDesc_.text = GetI18NText((ActivityGeneralityQteCfg[var_8_0.qte_skill] or nil) and (ActivityGeneralityQteCfg[var_8_0.qte_skill].desc or ""))
	else
		SetActive(self.supportGo_, false)
	end
end

function OsirisPlayGameUnlockPopView:Dispose()
	OsirisPlayGameUnlockPopView.super.Dispose(self)
end

return OsirisPlayGameUnlockPopView
