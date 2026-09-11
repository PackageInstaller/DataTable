local ReversePacmanTechnologyPlayerSkillView = class("ReversePacmanTechnologyPlayerSkillView", import("..roleSkill.ReversePacmanTechnologyRoleSkillView"))

function ReversePacmanTechnologyPlayerSkillView:Init()
	self.itemList = {}

	for iter_1_0, iter_1_1 in ipairs(ReversePacmanTools.GetActivity():getConfig("config_client").playerSkillShopIDList) do
		self.itemList[iter_1_0] = self:GetItemClass().New(Object.Instantiate(self.uiSkillItem, self.uiSkillParent), self, iter_1_1)
	end

	setText(self.uiFrontText, i18n("reverse_pacman_owned"))
	setImageSprite(self.uiIconImage, GetSpriteFromAtlas(ReversePacmanTools.GetTechnologyPTDrop():getIcon(), ""))
	onButton(self, self.uiCurrencyBtn, function()
		local var_2_0 = ReversePacmanTools.GetTechnologyPTDrop()
		local var_2_1 = {
			viewComponent = ReversePacmanItemPopScene,
			mediator = ReversePacmanItemPopMediator
		}
		local var_2_2 = {
			dropType = var_2_0.type,
			dropID = var_2_0.id,
			count = var_2_0:getOwnedCount()
		}
		local var_2_3 = ReversePacmanTools.GetActivity():getConfig("config_client").pt_link

		var_2_3 = var_2_3 or 240
		var_2_2.limitItemGuideID = var_2_3
		var_2_1.data = var_2_2

		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New(var_2_1))

		return
	end, SFX_PANEL)

	return
end

function ReversePacmanTechnologyPlayerSkillView:GetItemClass()
	return ReversePacmanTechnologyPlayerSkillItem
end

return ReversePacmanTechnologyPlayerSkillView
