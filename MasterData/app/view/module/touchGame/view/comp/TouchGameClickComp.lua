local var_0_0 = require("app.view.battle.const.BattleConst").SPINE_ACTION_TYPE
local TouchGameClickComp = class("TouchGameClickComp", require("app.fairyGUI.touchGame.UI_TouchGameClickComp"))

function TouchGameClickComp:ctor()
	self._info = nil
	self._index = 0
	self._initialRadius = self:getSize().width / 2

	self:addClickListener(handler(self, self._onClick))

	self._effect = self.m_effectHolder:addEffectSpine({
		isLoop = true,
		name = "eff_ui_dungeon_cureclick"
	})
end

function TouchGameClickComp:updateInfo(arg_2_1)
	self._index = arg_2_1.index

	if arg_2_1 and arg_2_1.info then
		self._info = arg_2_1.info

		local var_2_0 = tonumber(self._info.radius)

		self:setSize(var_2_0 * 2, var_2_0 * 2)
		self:setPosition(cc.p(tonumber(self._info.pos_x), tonumber(self._info.pos_y)))
		self:setVisible(true)
		self._effect:setScale(var_2_0 / self._initialRadius)
	else
		self._info = nil

		self:setVisible(false)
	end
end

function TouchGameClickComp:_onClick(arg_3_1)
	if self._info then
		self:setVisible(false)
		self:dispatchCompEvent("TouchGameClickComp_OnClick", {
			info = self._info,
			index = self._index,
			clickWorldPos = self:getParent():displayObject():convertToWorldSpace(self:getPosition())
		})
	end
end

function TouchGameClickComp:doAutoAction()
	self:_onClick()
end

return TouchGameClickComp
