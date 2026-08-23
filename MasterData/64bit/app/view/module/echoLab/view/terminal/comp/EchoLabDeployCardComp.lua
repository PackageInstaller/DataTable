local var_0_0 = g.core.const.ConstMgr.EchoLabConst
local var_0_1 = g.core.model.User.echoLabData
local var_0_2 = g.core.config.palace_info
local EchoLabDeployCardComp = class("EchoLabDeployCardComp", require("app.fairyGUI.echoLab.UI_EchoLabDeployCardComp"))

function EchoLabDeployCardComp:ctor()
	self._ctrlType = 0
	self._cardType = 0
	self._unlockGrade = 0

	self:addClickListener(handler(self, self._onClickCard))
end

function EchoLabDeployCardComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PALACE_USECOMPOSE, handler(self, self._onPalaceUseCompose), self)
end

function EchoLabDeployCardComp:updateDeployCardComp(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self._ctrlType = arg_3_2
	self._cardType = arg_3_3
	self._curPos = arg_3_1

	self.m_qualityLoader:setURL("ui://base_new/pic_echo_pinzhi0")
	self.m_qualityLoader1:setURL("ui://base_new/pic_echo_pinzhi0_1")

	if var_0_2.get((var_0_1:getPalaceId()))[var_0_0.EMBRYO_SLOT_FIELDS[arg_3_2].name .. "_slot_num"] < arg_3_1 then
		self.m_stateController:setSelectedIndex(0)

		self._unlockGrade = var_0_1:getUnlockSlotGrade(var_0_0.EMBRYO_SLOT_FIELDS[arg_3_2].name .. "_slot_num", arg_3_1)

		self.m_lockText:setText(g.core.lang:get(408516, {
			level = self._unlockGrade
		}))
	elseif var_0_1:isLineUpByTypeAndPos(arg_3_3, arg_3_1) then
		self.m_stateController:setSelectedIndex(1)

		local var_3_0 = var_0_1:getCardStructByTypeAndPos(arg_3_3, arg_3_1)

		if var_3_0 then
			local var_3_1 = var_3_0:getCardQuality()

			self.m_qualityLoader:setURL("ui://base_new/pic_echo_pinzhi" .. var_3_1)
			self.m_qualityLoader1:setURL("ui://base_new/pic_echo_pinzhi" .. var_3_1 .. "_1")
			self.m_picComp:setIcon(var_3_0:getPicResUrl())
			self.m_picComp:getChild("icon"):setScale(var_0_0.EMBRYO_SLOT_FIELDS[arg_3_2].scale)
			self.m_nameTxt:setText(var_3_0:getCardName())

			local var_3_2 = var_3_0:getLineUpAttrInfo()
			local var_3_3, var_3_4 = g.core.lang:getAttr(var_3_2.type, var_3_2.value, false)

			self.m_descTxt:setText(var_3_3 .. var_3_4)

			if var_3_0:getCardType() ~= g.core.common.Goods.TYPE_SKIN then
				self.m_starComp:setVisible(true)
				self.m_starComp:initStar({
					style = 1,
					gap = 0,
					index = 3,
					num = var_3_0:getStar()
				})
			else
				self.m_starComp:setVisible(false)
			end
		end
	else
		self.m_stateController:setSelectedIndex(2)
		self.m_addEff:removeAllEffect()
		self.m_addEff:addEffectSpine({
			name = "eff_ui_echoLab_add",
			isLoop = true,
			anim = "play"
		})
	end

	if arg_3_4 and arg_3_1 == arg_3_4 then
		self.m_isSelectController:setSelectedIndex(1)
	else
		self.m_isSelectController:setSelectedIndex(0)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			ctrlType = self._ctrlType,
			cardType = self._cardType,
			curPos = self._curPos
		}
	})
end

function EchoLabDeployCardComp:_onClickCard(arg_4_1)
	local var_4_0 = arg_4_1:getSender():getName()
	local var_4_1 = tonumber(string.sub(var_4_0, #var_4_0))

	if self.m_stateController:getSelectedIndex() == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(408533, {
			level = self._unlockGrade
		}))

		return
	else
		if not g.core.module.ModuleManager:isCurModule(g.view.entrance.ECHOLAB_LINEUP) then
			g.core.module.ModuleManager:pushModule(g.view.entrance.ECHOLAB_LINEUP, {
				type = self._ctrlType,
				cardType = self._cardType,
				selectPos = var_4_1
			})
		end

		self:dispatchCompEvent("select_embryo_slot_pos", {
			pos = var_4_1
		})
	end
end

function EchoLabDeployCardComp:_onPalaceUseCompose(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if self._curPos == arg_5_4.pos then
		self.m_cardEff:removeAllEffect()
		self.m_cardEff:addEffectSpine({
			name = "eff_ui_echoLab_card",
			isLoop = false,
			anim = "play"
		})
	end
end

return EchoLabDeployCardComp
