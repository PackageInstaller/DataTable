local HomeLandGuideTouchComp = class("HomeLandGuideTouchComp", require("app.fairyGUI.homeLand.UI_HomeLandGuideTouchComp"))

function HomeLandGuideTouchComp:ctor()
	if GUIDE_EDIT or g.core.guide.GuideProxy:isGuideRunning() then
		local var_1_0 = {
			handler(self, self._onOpenTissueClick),
			handler(self, self._onOpenHonorRoomClick),
			handler(self, self._onOpenFurnitureClick),
			handler(self, self._onOpenTrainClick),
			handler(self, self._onOpenFavoriteClick),
			(handler(self, self._onOpenGeneClick))
		}

		for iter_1_0 = 1, 6 do
			self["m_touch" .. iter_1_0]:addClickListener(var_1_0[iter_1_0])
		end
	else
		self:setVisible(false)
	end
end

function HomeLandGuideTouchComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_FINISH, handler(self, self._onGuideEnd), self)
end

function HomeLandGuideTouchComp:_onGuideEnd()
	self:setVisible(false)
end

function HomeLandGuideTouchComp:_onOpenTrainClick()
	g.core.network.GameNetProxy:send_C2S_HomeLandTrain_GetInfo({})
end

function HomeLandGuideTouchComp:_onOpenFavoriteClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_FAVO_MAIN) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.KNIGHT_FAVO_MAIN)
	end
end

function HomeLandGuideTouchComp:_onOpenGeneClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.GENE) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.GENE)
	end
end

function HomeLandGuideTouchComp:_onOpenTissueClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_SHOWROOM) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.SHOW_ROOM)
	end
end

function HomeLandGuideTouchComp:_onOpenHonorRoomClick()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.KINGDOM_FATE) and g.view.entrance.WARRIOR then
		g.core.module.ModuleManager:pushModule(g.view.entrance.WARRIOR)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(105024))
	end
end

function HomeLandGuideTouchComp:_onOpenFurnitureClick()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_FURNITURE) then
		g.core.network.GameNetProxy:send_C2S_FurnitureRoom_GetInfo({})
	end
end

return HomeLandGuideTouchComp
