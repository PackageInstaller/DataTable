local FountainBuiding = class("FountainBuiding", import(".NavalAcademyBuilding"))

function FountainBuiding:GetGameObjectName()
	return "fountain"
end

function FountainBuiding:GetTitle()
	return i18n("school_title_shoucang")
end

function FountainBuiding:OnClick()
	self:emit(NavalAcademyMediator.ON_OPEN_COLLECTION)

	return
end

function FountainBuiding:IsTip()
	if getProxy(CollectionProxy):unclaimTrophyCount() > 0 then
		return true
	else
		local var_4_0 = getProxy(LoveLetterProxy)

		return var_4_0:IsTipLevelUp() or var_4_0:IsTipAllLevelReward()
	end

	return
end

return FountainBuiding
