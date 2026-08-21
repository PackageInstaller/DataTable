-- chunkname: @IQIGame\\UI\\Battle\\BattleGuideTemplate\\BattleGuideTemplateBase.lua

local BattleGuideTemplateBase = {}

function BattleGuideTemplateBase.New(view, subClass)
	local obj = Clone(subClass)

	obj:Init(view)

	return obj
end

function BattleGuideTemplateBase:Init(view)
	self.view = view

	self:__Init()
end

function BattleGuideTemplateBase:__Init()
	return
end

function BattleGuideTemplateBase:Show(guideData)
	self.guideData = guideData

	self.view.gameObject:SetActive(true)
	self:__Show()
end

function BattleGuideTemplateBase:__Show()
	return
end

function BattleGuideTemplateBase:Hide()
	self:__Hide()

	self.guideData = nil

	self.view.gameObject:SetActive(false)
end

function BattleGuideTemplateBase:__Hide()
	return
end

function BattleGuideTemplateBase:Dispose()
	self:__Dispose()

	self.view = nil
end

function BattleGuideTemplateBase:__Dispose()
	return
end

return BattleGuideTemplateBase
