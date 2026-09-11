local PolyhedronBattleTipItem = class("PolyhedronBattleTipItem", ReduxView)

function PolyhedronBattleTipItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronBattleTipItem:Init()
	self:InitUI()
end

function PolyhedronBattleTipItem:InitUI()
	self:BindCfgUI()
end

function PolyhedronBattleTipItem:SetData(arg_4_1)
	self.tipsinfo_ = arg_4_1

	if self.tipsinfo_.attribute_id == PolyhedronAttributeIdCfg.GAME_POLYHEDRON_ATTRIBUTE_BOSS_EVENT_AFTER_EVENT_ADD_REBORN_TIMES.id then
		self.m_tip.text = string.format(GetTips("POLYHEDRON_RESURRECTION_TIMES"), self.tipsinfo_.delta or 1)
	end

	if self.tipsinfo_.attribute_id == PolyhedronAttributeIdCfg.GAME_POLYHEDRON_ATTRIBUTE_ARTIFACT_LEVEL_BONUS_COLD_DOWN.id or self.tipsinfo_.attribute_id == PolyhedronAttributeIdCfg.GAME_POLYHEDRON_ATTRIBUTE_BOSS_EVENT_AFTER_EVENT_ARTIFACT_STRENGTH_RATE.id then
		self.m_tip.text = string.format(GetTips("POLYHEDRON_TREASURE_LEVEL"), GetI18NText(AffixTypeCfg[arg_4_1.target_id].name), (not self.tipsinfo_.delta or nil) and 1)
	end

	if self.tipsinfo_.attribute_id == PolyhedronAttributeIdCfg.GAME_POLYHEDRON_ATTRIBUTE_HERO_ATTRIBUTE_BONUS_COLD_DOWN.id then
		self.m_tip.text = GetI18NText(PolyhedronEffectCfg[arg_4_1.target_id].desc)
	end
end

function PolyhedronBattleTipItem:SetDisposeHandler(arg_5_1)
	self.disposeHandler_ = arg_5_1
end

function PolyhedronBattleTipItem:SetIsShow(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)

	self.isShow_ = arg_6_1

	if arg_6_1 then
		self.transform_:SetAsLastSibling()
		self.m_animator:Play("ani")
		self:StartTimer()
	end
end

function PolyhedronBattleTipItem:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:StopTimer()
			self:SetIsShow(false)
			self.disposeHandler_(self.tipsinfo_)
		end, 3, 1)
	end

	self.timer_:Start()
end

function PolyhedronBattleTipItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function PolyhedronBattleTipItem:OnExit()
	self:StopTimer()
	self:SetIsShow(false)
	self.disposeHandler_(self.tipsinfo_)
end

function PolyhedronBattleTipItem:GetIsShow()
	return self.isShow_
end

function PolyhedronBattleTipItem:Dispose()
	PolyhedronBattleTipItem.super.Dispose(self)
end

return PolyhedronBattleTipItem
