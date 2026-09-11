local AutoChessHeroUpgradePopItem = class("AutoChessHeroUpgradePopItem", ReduxView)

function AutoChessHeroUpgradePopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()

	self.isSelect_ = false
	self.isNeedClick_ = true
end

function AutoChessHeroUpgradePopItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AutoChessHeroUpgradePopItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.controllerEx_:GetController("select")
	self.gradeController_ = self.controllerEx_:GetController("grade")
end

function AutoChessHeroUpgradePopItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCb then
			self:clickCb()
		end
	end)
	TerminologyTools.AddTerminologyHandler(self, self.buffDescText_, nil, handler(self, self.TerminologyDefaultHandler))
end

function AutoChessHeroUpgradePopItem:TerminologyDefaultHandler(arg_6_1)
	if #arg_6_1 <= 0 or not self.isSelect_ and self.isNeedClick_ then
		if self.clickCb then
			self:clickCb()
		end
	else
		TerminologyTools.TerminologyDefaultHandler(arg_6_1)
	end
end

function AutoChessHeroUpgradePopItem:SetData(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	self.isAttr_ = arg_7_1
	self.index_ = arg_7_2
	self.gameType_ = AutoChessData:GetCurGameType()

	self.gradeController_:SetSelectedIndex(arg_7_4 - 1)

	if arg_7_1 then
		self.nowAttkText_.text = arg_7_5.attributeData.atk
		self.nowHPText_.text = arg_7_5.attributeData.hp
		self.addAttkText_.text = arg_7_3.atk
		self.addHPText_.text = arg_7_3.hp
	else
		local var_7_0 = AutoChessBuffCfg[tonumber(arg_7_3)]

		if var_7_0 then
			AutoChessTools.GetChessBuffDesc(AutoChessData:GetPlayerChessData(self.gameType_), tonumber(arg_7_3), self.buffDescText_)

			self.skillIcon_.sprite = AutoChessTools.GetBuffIcon(var_7_0.icon)
		end
	end
end

function AutoChessHeroUpgradePopItem:SetClickCb(arg_8_1)
	self.clickCb = arg_8_1
end

function AutoChessHeroUpgradePopItem:SetNotClick(arg_9_1)
	self.isNeedClick_ = arg_9_1
end

function AutoChessHeroUpgradePopItem:SetSelect(arg_10_1)
	self.isSelect_ = arg_10_1

	self.selectController_:SetSelectedState(tostring(arg_10_1))
end

return AutoChessHeroUpgradePopItem
