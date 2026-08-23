local BagNewEquipInfoComp = class("BagNewEquipInfoComp", require("app.fairyGUI.bagNew.UI_BagNewEquipInfoComp"))

function BagNewEquipInfoComp:ctor()
	self.m_tipsBtn:addClickListener(handler(self, self._onClickDetailBtn))
	self.m_developBtn:addClickListener(handler(self, self._onFunctionTouchClick))
end

function BagNewEquipInfoComp:_onFunctionTouchClick()
	if self._isFrag then
		if self._canCompose then
			self:_onCompose()
		else
			self:_onAcquireClick()
		end
	elseif g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_STRENGTH) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.EQUIP_DEVELOP, 1, self._info.equipId)
	end
end

function BagNewEquipInfoComp:_onClickDetailBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.bagNew.view.popup.BagNewCommonFullAttrPop").new((g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_EQUIP,
		value = self._info.equipData:getCfg().id
	}))), {
		touchDisappear = true
	})
end

function BagNewEquipInfoComp:playEnterAnim()
	self.m_enterTransition:play()
end

function BagNewEquipInfoComp:_onAcquireClick()
	g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
		type = g.core.common.Goods.TYPE_FRAGMENT,
		value = self._info.fragData.info.id,
		size = clone(self._info.fragData).size
	})
end

function BagNewEquipInfoComp:_onCompose()
	if g.core.model.User.equipmentData:getBagLimit() > #g.core.model.User.equipmentData:getEquipList().allIndex then
		local var_6_0 = clone(self._info.fragData)

		if math.floor(var_6_0.size / g.core.config.fragment_info.get(var_6_0.value).combine_num) > 1 then
			local var_6_1 = fgui.UIPackage:createObject("bagNew", "BagOneKeyComposeComp")

			var_6_1:setItemView({
				id = self._info.fragData.value,
				fragmentId = self._info.fragData.info.id,
				num = math.floor(self._info.fragData.size / self._info.fragData.info.combine_num)
			}, 1)
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				titleType = 1,
				title = g.core.lang:get(200504),
				childComp = var_6_1,
				onConfirm = function(self)
					g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
						id = self.fragmentId,
						num = self.num
					})
				end
			}), {
				touchDisappear = true
			})
		else
			g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
				num = 1,
				id = self._info.fragData.info.id
			})
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201548))
	end
end

function BagNewEquipInfoComp:updateEquipInfo(arg_8_1, arg_8_2)
	self._isFrag = arg_8_2
	self._info = arg_8_1

	self.m_infoBaseComp:setData(arg_8_1, arg_8_2)
	self.m_attrComp:updateAttrComp(arg_8_1, arg_8_2)
	self.m_tipsBtn:setVisible(not arg_8_2)
	self.m_typeController:setSelectedIndex(arg_8_2 and 1 or 0)

	if arg_8_2 then
		self.m_progNumText:setText(arg_8_1.progressTxt)

		self._canCompose = arg_8_1.canCompose

		self.m_developBtn:setVisible(true)

		if arg_8_1.canCompose then
			self.m_developBtn:setTitle(g.core.lang:get(200521))
		else
			self.m_developBtn:setTitle(g.core.lang:get(200506))
		end
	elseif arg_8_1.isWear == 1 then
		self.m_developBtn:setTitle(g.core.lang:get(200507))
		self.m_developBtn:setVisible(true)
	else
		self.m_developBtn:setVisible(false)
	end
end

return BagNewEquipInfoComp
