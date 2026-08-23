local var_0_0 = g.core.model.User.goldSavingData
local BaseGoldSavingBtn = class("BaseGoldSavingBtn", require("app.fairyGUI.base_new.UI_BaseGoldSavingBtn"))
local var_0_2 = {
	"LINE_UP",
	"KNIGHT_DEVELOP",
	"DUNGEON",
	"DUNGEON_STAGE",
	"BIO_MAIN",
	"BIO_STAGE",
	"WUSH",
	"HOME"
}

function BaseGoldSavingBtn:ctor()
	self._showSelf = false

	self:setVisible(self._showSelf)
	self:_initView()
end

function BaseGoldSavingBtn:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH, handler(self, self._onStateFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_FLUSH, handler(self, self._onRecGoldSavingFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_PAY, handler(self, self._onRecGoldSavingPay), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, self._onModuleExit, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GOLD_SAVING_EXIT_FLUSH, self._onDungeonBattleClose, self)

	self._showSelf = self:moduleCheck()

	self:setVisible(self._showSelf)
	self:_updateView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GOLD_SAVING_SHOW_NEW)
	self:updateAction()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self
	})
end

function BaseGoldSavingBtn:_onModuleExit()
	self._showSelf = self:moduleCheck() and var_0_0:isShowEntrance()

	if self._showSelf then
		self:updateAction()
	end

	self:setVisible(self._showSelf)
end

function BaseGoldSavingBtn:_onDungeonBattleClose()
	self:updateAction()

	self._showSelf = self:moduleCheck() and var_0_0:isShowEntrance()

	self:setVisible(self._showSelf)
end

function BaseGoldSavingBtn:moduleCheck()
	local var_5_0 = g.core.module.ModuleManager:getCurModule()
	local var_5_1 = false

	if var_5_0 then
		for iter_5_0 = 1, #var_0_2 do
			if var_5_0.name == var_0_2[iter_5_0] then
				var_5_1 = true

				break
			end
		end
	end

	return var_5_1
end

function BaseGoldSavingBtn:updateAction()
	local var_6_0 = var_0_0:getProgress()

	if var_0_0:getPreProgress() == -1 then
		var_0_0:setPreProgress(var_6_0)
	end

	local var_6_1 = var_0_0:getPreProgress()

	if var_6_1 ~= var_6_0 and var_6_0 ~= 0 then
		self.m_upNumText:setText((var_6_0 - var_6_1 > 0 or nil) and ("+" .. var_6_0 - var_6_1 or ""))
		self.m_textupTransition:play()
		var_0_0:setPreProgress(var_6_0)
	end
end

function BaseGoldSavingBtn:_initView()
	self.m_goldSavingBtn:addClickListener(handler(self, self._onClickGoldSaving))
end

function BaseGoldSavingBtn:_onStateFlush()
	self:_updateView()
end

function BaseGoldSavingBtn:_onRecGoldSavingFlush()
	self:_updateView()
end

function BaseGoldSavingBtn:_onRecGoldSavingPay()
	self:_updateView()
end

function BaseGoldSavingBtn:_updateView()
	self:removeEffect()

	local var_11_0 = var_0_0:isShowEntrance()

	if self._showSelf or not var_11_0 then
		self:setVisible(var_11_0)
	end

	if not var_11_0 then
		return
	end

	local var_11_1 = var_0_0:getMaxProgress()

	if var_0_0:canGetNewGift() then
		self.m_progStatusController:setSelectedIndex(1)

		self._spineNode = self.m_effComp:addEffectSpine({
			anim = "play",
			name = "eff_ui_goldSaving_iconidle",
			isLoop = true
		})
	else
		self.m_progStatusController:setSelectedIndex(0)
		self.m_progComp:setPercent({
			cur = var_0_0:getProgress(),
			max = var_11_1
		})
	end
end

function BaseGoldSavingBtn:removeEffect()
	if self._spineNode then
		self._spineNode:removeFromParent()

		self._spineNode = nil
	end
end

function BaseGoldSavingBtn:_onClickGoldSaving()
	if var_0_0:isShowEntrance() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.GOLD_SAVING)
	end
end

function BaseGoldSavingBtn:onUnLoad()
	return
end

return BaseGoldSavingBtn
