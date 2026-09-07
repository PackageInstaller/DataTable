local MainRankBtn = class("MainRankBtn", import(".MainBaseBtn"))

function MainRankBtn:OnClick()
	self:emit(NewMainMediator.GO_SCENE, SCENE.BILLBOARD, {
		index = PowerRank.TYPE_POWER
	})

	return
end

function MainRankBtn:Flush()
	setActive(self._tf, (self:IsActive()))

	return
end

function MainRankBtn:IsActive()
	return getProxy(PlayerProxy):getRawData().level >= pg.open_systems_limited[6].level
end

return MainRankBtn
