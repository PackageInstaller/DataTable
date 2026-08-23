local var_0_0 = g.core.model.User
local var_0_1 = g.core.model.User.userActiveSceneData
local UserConst = require("app.view.module.user.const.UserConst")
local AssistantChangeSceneComp = class("AssistantChangeSceneComp", require("app.fairyGUI.assistant.UI_AssistantChangeSceneComp"), function()
	return fgui.GComponent:create({
		resName = "AssistantChangeSceneComp",
		pkgPath = "ui/assistant/assistant",
		isFullScreen = true,
		pkgName = "assistant"
	})
end)

function AssistantChangeSceneComp:ctor(arg_2_1)
	self._mainSceneData = nil
	self._curSelectIndex = 0
	self._advanceId = arg_2_1 and arg_2_1.advanceId
	self.m_inTransition = self:getView():getTransition("in")
	self.m_outTransition = self:getView():getTransition("out")

	self:_initComp()
	self:_addListener()
end

function AssistantChangeSceneComp:onLoad()
	self:_addNetWorkListener()
	self:_updateComp()
	self.m_inTransition:play()
end

function AssistantChangeSceneComp:_initComp()
	self:_initData()
	self:_initUI()
end

function AssistantChangeSceneComp:onUnload()
	g.core.model.User.userActiveSceneData:saveAllSceneOld()
	self:dispatchCompEvent("AssistantChangeScene_Quit")
end

function AssistantChangeSceneComp:_initData()
	return
end

function AssistantChangeSceneComp:_initUI()
	self.m_sceneList:setVirtual()
	self.m_sceneList:setItemRenderer(handler(self, self._onSceneRenderer))
end

function AssistantChangeSceneComp:_addListener()
	self.m_sceneList:addClickListener(handler(self, self._selectedScene))
	self.m_saveBtn:addClickListener(handler(self, self._onClickSave))
	self.m_quitBtn:addClickListener(handler(self, self._onClickClose))
end

function AssistantChangeSceneComp:_addNetWorkListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BG_BOOK_SETUSE, handler(self, self._onRecBookSetUse), self)
end

function AssistantChangeSceneComp:_updateComp()
	self._mainSceneData = var_0_1:getAllSceneBgData((self._advanceId or nil) and g.core.model.User:getNominateInfo(self._advanceId).bg)

	self.m_sceneList:setNumItems(#self._mainSceneData)
	self.m_sceneList:setSelectedIndex(0)

	self._curSelectIndex = 0

	self.m_sceneList:transitionShowCells("listCardAUiRightIn02", 0.06)
end

function AssistantChangeSceneComp:_onSceneRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateComp(self._mainSceneData[arg_11_1 + 1], self._advanceId)
end

function AssistantChangeSceneComp:_selectedScene()
	local var_12_0 = self.m_sceneList:getSelectedIndex()

	if self._mainSceneData[var_12_0 + 1].isUnlock then
		self._curSelectIndex = var_12_0

		self:dispatchCompEvent("AssistantChangeScene_SelectedScene", {
			scenePic = self._mainSceneData[var_12_0 + 1].cfg.pic
		})
	else
		self.m_sceneList:setSelectedIndex(self._curSelectIndex)
		g.core.module.ModuleManager:tip(g.core.lang:get(100538))
	end
end

function AssistantChangeSceneComp:_checkSelNewInfo()
	local var_13_0 = self.m_sceneList:getSelectedIndex()

	if var_13_0 >= 0 then
		return var_0_0.userActiveSceneData:getSceneId() ~= self._mainSceneData[var_13_0 + 1].cfg.id, self._mainSceneData[var_13_0 + 1]
	end

	return false, nil
end

function AssistantChangeSceneComp:_onClickSave()
	local var_14_0, var_14_1 = self:_checkSelNewInfo()

	if self._advanceId then
		if g.core.model.User:isInNominateList(self._advanceId) == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(100545))
		else
			g.core.model.User:updateNominateInfo(self._advanceId, {
				bg = var_14_1.cfg.id
			})
			g.core.module.ModuleManager:tip(g.core.lang:get(100529))
			self.m_sceneList:setNumItems(#self._mainSceneData)
			g.core.network.GameNetProxy:send_C2S_ShowKnight_Set({
				show_knights = g.core.model.User:packNominateServerList()
			})
		end

		return
	end

	if var_14_0 then
		g.core.network.GameNetProxy:send_C2S_BgBook_SetUse({
			id = var_14_1.cfg.id
		})
	end
end

function AssistantChangeSceneComp:_onClickClose()
	if self._advanceId then
		self:playOutTrans()

		return
	end

	local var_15_0, var_15_1 = self:_checkSelNewInfo()

	if var_15_0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(112503),
			desc = g.core.lang:get(112504),
			onConfirm = handler(self, self.playOutTrans)
		}), {
			touchDisappear = true
		})
	else
		self:playOutTrans()
	end
end

function AssistantChangeSceneComp:playOutTrans()
	self.m_outTransition:play(handler(self, function()
		self:dispatchCompEvent("Assistant_popComp")
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end))
end

function AssistantChangeSceneComp:_onRecBookSetUse(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_4 then
		var_0_0.userActiveSceneData:setSceneId(arg_18_4.id)
		g.core.module.ModuleManager:tip(g.core.lang:get(100529))
		self.m_sceneList:setNumItems(#self._mainSceneData)
	end
end

return AssistantChangeSceneComp
