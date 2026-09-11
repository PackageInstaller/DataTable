local RogueCardJokerCardItem = class("RogueCardJokerCardItem", ReduxView)

function RogueCardJokerCardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RogueCardJokerCardItem:Init()
	self:InitUI()

	self.lookTipsCon_ = self.controller_:GetController("looktips")
	self.selectCon_ = self.controller_:GetController("select")
	self.modeCon_ = self.controller_:GetController("Mode")
	self.cardsuitCon_ = self.controller_:GetController("cardsuit")
	self.wuchangsuitCon_ = self.controller_:GetController("wuchangsuit")
	self.employCon_ = self.controller_:GetController("employ")
	self.failureCon_ = self.controller_:GetController("failure")
	self.sealCon_ = self.controller_:GetController("Seal")
	self.reinforceCon_ = self.controller_:GetController("reinforce")
	self.lockCon_ = self.controller_:GetController("lock")
	self.newCon_ = self.controller_:GetController("new")
end

function RogueCardJokerCardItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function RogueCardJokerCardItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
		RogueCardGameData:SetIllustratedRedPoint_JockerWuchang(self.id)

		if self.clickHandle_ then
			self.selectCon_:SetSelectedIndex(1)
			self.clickHandle_(self.id, self.index)
		end
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		if self.clickHandle_ then
			self.selectCon_:SetSelectedIndex(1)
			self.clickHandle_(self.id, self.index)
		end
	end)
end

function RogueCardJokerCardItem:SetData(arg_7_1, arg_7_2)
	self.id = arg_7_1
	self.index = arg_7_2

	local var_7_0 = RogueCardItemCfg[arg_7_1]

	if RogueCardGameTools.IsUnlockWcCard(self.id) then
		self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. var_7_0.icon)

		self.lockCon_:SetSelectedIndex(1)
		manager.redPoint:SetRedPointIndependent(self.transform_, RogueCardGameData:GetIllustratedRedPoint_JockerWuchang(arg_7_1))
	else
		self.lockCon_:SetSelectedIndex(0)
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end

	if var_7_0.type == 1 then
		self.wuchangsuitCon_:SetSelectedIndex(var_7_0.rare == 1 and 1 or 3)
	else
		self.wuchangsuitCon_:SetSelectedIndex(var_7_0.rare == 1 and 0 or 2)
	end
end

function RogueCardJokerCardItem:SetSelected(arg_8_1)
	self.selectCon_:SetSelectedIndex(self.index == arg_8_1 and 1 or 0)
end

function RogueCardJokerCardItem:SetClickHandle(arg_9_1)
	self.clickHandle_ = arg_9_1
end

function RogueCardJokerCardItem:Dispose()
	RogueCardJokerCardItem.super.Dispose(self)
end

return RogueCardJokerCardItem
