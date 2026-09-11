local SpringFestivalZumaBuffNodeView = class("SpringFestivalZumaBuffNodeView", ReduxView)

function SpringFestivalZumaBuffNodeView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.parent_ = arg_1_2

	self:Init()
end

function SpringFestivalZumaBuffNodeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SpringFestivalZumaBuffNodeView:InitUI()
	self:BindCfgUI()

	self.showBuffInfoController = self.controller_:GetController("showBuffInfo")
	self.buffIndexController = self.controller_:GetController("buffIndex")
	self.showBuffItemController = self.controller_:GetController("showBuffItem")
end

function SpringFestivalZumaBuffNodeView:AddUIListener()
	self:AddBtnListener(self.buffItemBtn_, nil, function()
		if self.isGameStart == false then
			return
		end

		self:showBuffInfoNode(true)
	end)
	self:AddBtnListener(self.clickAreaBtn_, nil, function()
		self:showBuffInfoNode(false)

		if not self.isPlayStartEffect then
			self.parent_:PlayStartEffect()

			self.isPlayStartEffect = true
		end
	end)
end

function SpringFestivalZumaBuffNodeView:OnEnter()
	self.isPlayStartEffect = false

	self:SetGameStartState(false)
	self:RefreshUI()
end

function SpringFestivalZumaBuffNodeView:SetGameStartState(arg_8_1)
	self.isGameStart = arg_8_1
end

function SpringFestivalZumaBuffNodeView:GetIsShowBuffNode()
	return self.randomIndex > 0
end

function SpringFestivalZumaBuffNodeView:RefreshUI()
	local var_10_0 = ZumaData:GetEndlessMapRandIndex()

	self.randomIndex = var_10_0

	if var_10_0 <= 0 then
		self.showBuffItemController:SetSelectedState("false")
		self:showBuffInfoNode(false)

		return
	end

	local var_10_1 = ActivityZumaEffectCfg[2503].effect_value[var_10_0]

	self.buffIndexController:SetSelectedIndex(var_10_0 - 1)

	local var_10_2 = -1

	for iter_10_0, iter_10_1 in pairs((ZumaData:GetRandomTalentList())) do
		if #ActivityZumaTalentCfg[iter_10_1].effect_list > 0 and ActivityZumaTalentCfg[iter_10_1].effect_list[1] == var_10_1 then
			var_10_2 = iter_10_1
		end
	end

	if var_10_2 > 0 then
		self:showBuffInfoNode(true)

		self.nameText_.text = GetI18NText(ActivityZumaTalentCfg[var_10_2].name)
		self.infoText_.text = GetI18NText(ActivityZumaTalentCfg[var_10_2].desc)

		self.showBuffItemController:SetSelectedState("true")
	end
end

function SpringFestivalZumaBuffNodeView:showBuffInfoNode(arg_11_1)
	self.showBuffInfoController:SetSelectedState(arg_11_1 and "true" or "false")

	if not arg_11_1 then
		ZumaLuaBridge.ReStartZumaGame()
	else
		ZumaLuaBridge.PauseZumaGame()
	end
end

function SpringFestivalZumaBuffNodeView:OnExit()
	return
end

function SpringFestivalZumaBuffNodeView:Dispose()
	SpringFestivalZumaBuffNodeView.super.Dispose(self)
end

return SpringFestivalZumaBuffNodeView
