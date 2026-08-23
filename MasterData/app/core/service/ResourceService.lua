local ResourceService = class("ResourceService")

function ResourceService:ctor()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH, self._onFlush, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, self._onFormationChanged, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NEW_SCENE_SKIN_GO, self._showGotoTips, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NEWITEM_GET_NTF, self._onRcvNewItems, self)
end

function ResourceService:_onFlush(arg_2_1, arg_2_2, arg_2_3)
	g.core.resource.ResourceManager:refreshKnightCache()
end

function ResourceService:_onFormationChanged(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.tp == 1 then
		g.core.resource.ResourceManager:refreshKnightCache()
	end
end

function ResourceService:_showGotoTips()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.MAINSCENE_SKIN) then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.component.BaseAssistPopComp").new({
			text = g.core.lang:get(1189),
			handler_ok = function()
				return
			end
		})))
	end
end

function ResourceService:_onRcvNewItems(arg_6_1, arg_6_2)
	if not arg_6_2 then
		return
	end

	for iter_6_0 = 1, #arg_6_2 do
		if not g.core.model.User.bagData:isSceneskinGet() then
			g.core.model.User.bagData:checkSceneskinItem(arg_6_2[iter_6_0].id)
		end
	end
end

return ResourceService
