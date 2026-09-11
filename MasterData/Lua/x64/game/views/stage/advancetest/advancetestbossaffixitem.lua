local AdvanceTestBossAffixItem = class("AdvanceTestBossAffixItem", ReduxView)

function AdvanceTestBossAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AdvanceTestBossAffixItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdvanceTestBossAffixItem:InitUI()
	self:BindCfgUI()
end

function AdvanceTestBossAffixItem:AddUIListener()
	return
end

function AdvanceTestBossAffixItem:AddEventListeners()
	return
end

function AdvanceTestBossAffixItem:SetData(arg_6_1)
	self.icon_.sprite = getAffixSprite(ActivityAffixPoolCfg[arg_6_1].affix)
	self.affixText_.text = getAffixDesc(ActivityAffixPoolCfg[arg_6_1].affix)
end

function AdvanceTestBossAffixItem:OnEnter()
	self:AddEventListeners()
end

function AdvanceTestBossAffixItem:OnExit()
	self:RemoveAllEventListener()
end

function AdvanceTestBossAffixItem:OnMainHomeViewTop()
	return
end

function AdvanceTestBossAffixItem:Dispose()
	AdvanceTestBossAffixItem.super.Dispose(self)
end

return AdvanceTestBossAffixItem
