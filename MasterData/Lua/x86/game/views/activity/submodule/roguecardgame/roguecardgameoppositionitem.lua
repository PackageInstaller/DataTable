local RogueCardGameOppositionItem = class("RogueCardGameOppositionItem", ReduxView)

function RogueCardGameOppositionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RogueCardGameOppositionItem:Init()
	self:InitUI()
end

function RogueCardGameOppositionItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.lockCon_ = self.controller_:GetController("lock")
end

function RogueCardGameOppositionItem:AddUIListener()
	self:AddBtnListener(self.lockBtn_, nil, function()
		ShowTips("ROGUE_CARD_COLLECT_BOSS_EFFECT_LOCKED_TIPS")
	end)
	self:AddBtnListener(self.unlockBtn_, nil, function()
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
		RogueCardGameData:SetIllustratedRedPoint_Weal(self.id)
	end)
end

function RogueCardGameOppositionItem:RefreshData(arg_7_1)
	self.id = arg_7_1
	self.cfg = RogueCardBossEffectCfg[arg_7_1]

	if RogueCardGameTools.IsUnlockWealWoeById(self.id) then
		self.lockCon_:SetSelectedIndex(1)
		RichTextTools.SetMixedTextWithImage(self.desc_, GetI18NText(self.cfg.desc))

		self.desc_.text = GetI18NText(self.cfg.desc)

		manager.redPoint:SetRedPointIndependent(self.transform_, RogueCardGameData:GetIllustratedRedPoint_Weal(arg_7_1))
	else
		self.lockCon_:SetSelectedIndex(0)

		self.desc_.text = GetTips("CAPTURE_GAME_PRE_SECTION_UNREACHED_SMALL")

		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end
end

function RogueCardGameOppositionItem:Show(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function RogueCardGameOppositionItem:Dispose()
	RogueCardGameOppositionItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return RogueCardGameOppositionItem
