local RogueCardGameCardBuffStyleItem = class("RogueCardGameCardBuffStyleItem", ReduxView)

function RogueCardGameCardBuffStyleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RogueCardGameCardBuffStyleItem:Init()
	self:InitUI()

	self.lookTipsCon_ = self.controller_:GetController("looktips")
	self.selectCon_ = self.controller_:GetController("select")
	self.qualityCon_ = self.controller_:GetController("quality")
	self.lockCon_ = self.controller_:GetController("lock")
	self.newCon_ = self.controller_:GetController("new")
end

function RogueCardGameCardBuffStyleItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function RogueCardGameCardBuffStyleItem:AddUIListener()
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

function RogueCardGameCardBuffStyleItem:SetData(arg_7_1, arg_7_2)
	self.id = arg_7_1
	self.index = arg_7_2

	if RogueCardGameTools.IsUnlockCardBuff(self.id) then
		self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. RogueCardEnhanceCfg[arg_7_1].pic)

		self.lockCon_:SetSelectedIndex(1)
		manager.redPoint:SetRedPointIndependent(self.transform_, RogueCardGameData:GetIllustratedRedPoint_Enhance(arg_7_1))
	else
		self.lockCon_:SetSelectedIndex(0)
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end
end

function RogueCardGameCardBuffStyleItem:SetSelected(arg_8_1)
	self.selectCon_:SetSelectedIndex(self.index == arg_8_1 and 1 or 0)
end

function RogueCardGameCardBuffStyleItem:SetClickHandle(arg_9_1)
	self.clickHandle_ = arg_9_1
end

function RogueCardGameCardBuffStyleItem:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

function RogueCardGameCardBuffStyleItem:Dispose()
	RogueCardGameCardBuffStyleItem.super.Dispose(self)
end

return RogueCardGameCardBuffStyleItem
