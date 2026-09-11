local RogueCardGameCardBuffItem = class("RogueCardGameCardBuffItem", ReduxView)

function RogueCardGameCardBuffItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RogueCardGameCardBuffItem:Init()
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

function RogueCardGameCardBuffItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function RogueCardGameCardBuffItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
		RogueCardGameData:SetIllustratedRedPoint_Enhance(self.id)

		if self.clickHandle_ then
			self.selectCon_:SetSelectedIndex(1)
			self.clickHandle_(self.id, self.index)
		end
	end)
	self:AddBtnListener(self.btn_2, nil, function()
		if self.clickHandle_ then
			self.selectCon_:SetSelectedIndex(1)
			self.clickHandle_(self.id, self.index)
		end
	end)
end

function RogueCardGameCardBuffItem:SetData(arg_7_1, arg_7_2)
	self.id = arg_7_1
	self.index = arg_7_2

	if RogueCardGameTools.IsUnlockCardBuff(self.id) then
		if RogueCardEnhanceCfg[arg_7_1].type == 2 then
			self.sealCon_:SetSelectedIndex(1)
			SetActive(self.icon_.gameObject, false)

			self.sealIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. RogueCardEnhanceCfg[arg_7_1].pic)
		else
			self.sealCon_:SetSelectedIndex(0)
			SetActive(self.icon_.gameObject, true)

			self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. RogueCardEnhanceCfg[arg_7_1].pic)
		end

		self.lockCon_:SetSelectedIndex(1)
		manager.redPoint:SetRedPointIndependent(self.transform_, RogueCardGameData:GetIllustratedRedPoint_Enhance(arg_7_1))
	else
		self.lockCon_:SetSelectedIndex(0)
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end
end

function RogueCardGameCardBuffItem:SetSelected(arg_8_1)
	self.selectCon_:SetSelectedIndex(self.index == arg_8_1 and 1 or 0)
end

function RogueCardGameCardBuffItem:SetClickHandle(arg_9_1)
	self.clickHandle_ = arg_9_1
end

function RogueCardGameCardBuffItem:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

function RogueCardGameCardBuffItem:Dispose()
	RogueCardGameCardBuffItem.super.Dispose(self)
end

return RogueCardGameCardBuffItem
