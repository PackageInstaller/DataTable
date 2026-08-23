local var_0_0 = g.core.model.User.preciousData
local var_0_1 = g.core.const.ConstMgr.PreciousConst
local PreciousRotateComp = class("PreciousRotateComp", require("app.fairyGUI.precious.UI_PreciousRotateComp"))

function PreciousRotateComp:ctor()
	self._preciousSuit = nil

	for iter_1_0 = 1, var_0_1.PRECIOUS_INSUIT_MAXNUM do
		self["m_preciousComp" .. iter_1_0]:addClickListener(handler(self, self._onClickSubComp))
	end
end

function PreciousRotateComp:updateView(arg_2_1, arg_2_2)
	self._selectAdvId = arg_2_2
	self._preciousSuit = arg_2_1

	self:updateSelectedComp()
end

function PreciousRotateComp:playEffect()
	self.m_changeTransition:setHook("change", handler(self, self.updateSelectedComp))
	self.m_changeTransition:play()
end

function PreciousRotateComp:updateSelectedComp()
	local var_4_0 = self._preciousSuit:getCfg()

	self._list = {}

	for iter_4_0 = 1, var_0_1.PRECIOUS_INSUIT_MAXNUM do
		if var_4_0["precious_id_" .. iter_4_0] == self._selectAdvId then
			table.insert(self._list, 1, var_4_0["precious_id_" .. iter_4_0])
		else
			table.insert(self._list, var_4_0["precious_id_" .. iter_4_0])
		end
	end

	for iter_4_1 = 1, #self._list do
		local var_4_1 = self["m_preciousComp" .. iter_4_1]

		self["m_preciousComp" .. iter_4_1]:updateMainComp((var_0_0:getPreciousByAdvId(self._list[iter_4_1])))
		var_4_1:setSelected(iter_4_1 == 1)
	end
end

function PreciousRotateComp:_onClickSubComp(arg_5_1)
	local var_5_0 = arg_5_1:getSender():getName()
	local var_5_1 = self._list[tonumber(string.sub(var_5_0, #var_5_0))]
	local var_5_2 = var_0_0:getPreciousByAdvId(var_5_1)

	if var_5_2 then
		local var_5_3 = var_5_2:getPreciousStatus()

		if var_5_3 == var_0_1.PRECIOUS_STATUS.CANCOMPOSE then
			g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
				num = 1,
				id = var_5_2:getCfg().fragment_id
			})
		elseif var_5_3 == var_0_1.PRECIOUS_STATUS.NOGET then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.precious.view.PreciousInfoPop").new({
				preciousStruct = var_5_2
			}), {
				hideContinue = true,
				touchDisappear = true
			})
		else
			if var_5_1 == self._selectAdvId then
				return
			end

			self._selectAdvId = var_5_1

			self:dispatchCompEvent("PRECIOUS_UPDATE_RIGHTCOMP", var_5_2)
		end
	end
end

return PreciousRotateComp
