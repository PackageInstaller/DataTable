local AbleFragmentConvertPop = class("AbleFragmentConvertPop", require("app.fairyGUI.infoPop.UI_AbleFragmentConvertPop"), function()
	return fgui.GComponent:create({
		resName = "AbleFragmentConvertPop",
		pkgPath = "ui/infoPop/infoPop",
		pkgName = "infoPop"
	})
end)

AbleFragmentConvertPop.KNIGHT = 1
AbleFragmentConvertPop.UNITETOKEN = 2
AbleFragmentConvertPop.ARTIFACT = 3
AbleFragmentConvertPop.PET = 4
AbleFragmentConvertPop.PRECIOUS = 5
AbleFragmentConvertPop.SUCCUBA = 6
AbleFragmentConvertPop.ABLEFRAGMENT = 7
AbleFragmentConvertPop.CONVERT = 1
AbleFragmentConvertPop.BREAKTHROUGH = 2

function AbleFragmentConvertPop:ctor(arg_2_1)
	self:showAtCenter()

	self._fragmentId = arg_2_1.id
	self._needFragmentNum = arg_2_1.num
	self._curSelectFragmentNum = 1
	self._maxFragmentNum = 0
	self._type = arg_2_1.type
	self._state = arg_2_1.state or 1
	self._name = arg_2_1.name
	self._ableFragmentId = 0
	self._alReadyAddFragmentNum = 0
	self._ableFragmentmNum = 0
	self._knightStruct = arg_2_1.knight
	self._goods1 = arg_2_1.goods1
	self._goods2 = arg_2_1.goods2

	self:_addListener()
end

function AbleFragmentConvertPop:onLoad()
	self:_initView()

	if self._type == AbleFragmentConvertPop.ABLEFRAGMENT then
		self.m_subAddNumComp:initMinMaxNum({
			cur = 1,
			min = 1,
			max = self._maxFragmentNum,
			callback = handler(self, self._updateCurSelectFragmentNum)
		})
	else
		self.m_subAddNumComp:initMinMaxNum({
			min = 1,
			max = self._maxFragmentNum,
			cur = self._maxFragmentNum,
			callback = handler(self, self._updateCurSelectFragmentNum)
		})
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_TRANSFORM, self._onRcvItemTransform, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_STARINCREASE, self._onRcvKnihgtStarUp, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_REBORN_EXECUTE, self._onRcvRebornExecute, self)
end

function AbleFragmentConvertPop:_addListener()
	self.m_confirmBtn:addClickListener(handler(self, self._onClickTransform))
end

function AbleFragmentConvertPop:_initView()
	if self._state == AbleFragmentConvertPop.CONVERT then
		self.m_stateController:setSelectedIndex(0)
	elseif self._state == AbleFragmentConvertPop.BREAKTHROUGH then
		self.m_stateController:setSelectedIndex(1)
	end

	if self._type == AbleFragmentConvertPop.ABLEFRAGMENT then
		self.m_typeController:setSelectedIndex(6)
		self.m_icon1:updateIcon({
			type = self._goods1.type,
			value = self._goods1.value,
			size = self._curSelectFragmentNum,
			numCost = self._goods1.size
		})
		self.m_icon2:updateIcon({
			type = self._goods2.type,
			value = self._goods2.value,
			size = self._curSelectFragmentNum
		})

		self._maxFragmentNum = self._goods1.size
	else
		local var_5_0 = g.core.model.User.ableFragmentData
		local var_5_1
		local var_5_2 = g.core.config.fragment_info.get(self._fragmentId)

		if self._type == AbleFragmentConvertPop.UNITETOKEN then
			var_5_1 = var_5_0:getAbleFragmentUniteTokenList(var_5_2.quality, var_5_2.rare)

			self.m_typeController:setSelectedIndex(1)
		elseif self._type == AbleFragmentConvertPop.ARTIFACT then
			var_5_1 = var_5_0:getAbleFragmentArtifactList(var_5_2.quality, var_5_2.rare)

			self.m_typeController:setSelectedIndex(2)
		elseif self._type == AbleFragmentConvertPop.PET then
			var_5_1 = var_5_0:getAbleFragmentPetsList(var_5_2.quality, var_5_2.rare)

			self.m_typeController:setSelectedIndex(3)
		elseif self._type == AbleFragmentConvertPop.PRECIOUS then
			var_5_1 = var_5_0:getAbleFragmentPreciousList(var_5_2.quality, var_5_2.rare)

			self.m_typeController:setSelectedIndex(4)
		elseif self._type == AbleFragmentConvertPop.SUCCUBA then
			var_5_1 = var_5_0:getAbleFragmentSuccubaList(var_5_2.quality, var_5_2.rare)

			self.m_typeController:setSelectedIndex(5)
		else
			var_5_1 = var_5_0:getAbleFragmentKnightList(var_5_2.quality, var_5_2.rare)

			self.m_typeController:setSelectedIndex(0)
		end

		local var_5_3 = 0

		self._maxFragmentNum = self._needFragmentNum - self._alReadyAddFragmentNum

		if #var_5_1 > 0 then
			if self._maxFragmentNum > var_5_1[1].num then
				self._maxFragmentNum = var_5_1[1].num
			end

			var_5_3 = var_5_1[1].num
			self._ableFragmentId = var_5_1[1].id
			self._ableFragmentmNum = var_5_1[1].num
		else
			self._maxFragmentNum = 0
			var_5_3 = 0
			self._ableFragmentmNum = 0
		end

		if var_5_3 == 0 or self._alReadyAddFragmentNum == self._needFragmentNum then
			self.m_confirmBtn:setGrayed(true)
		else
			self.m_confirmBtn:setGrayed(false)
		end

		local var_5_4 = var_5_3 == 0

		if self._name then
			self.m_nameText:setText(self._name)
		end

		self.m_valueText:setText(self._needFragmentNum - self._alReadyAddFragmentNum)
		self.m_icon1:updateIcon({
			shadow = false,
			type = g.core.common.Goods.TYPE_ITEM,
			value = self._ableFragmentId,
			size = self._curSelectFragmentNum,
			numCost = var_5_3,
			isRed = var_5_4
		})
		self.m_icon2:updateIcon({
			type = g.core.common.Goods.TYPE_FRAGMENT,
			value = self._fragmentId,
			size = self._curSelectFragmentNum
		})
	end
end

function AbleFragmentConvertPop:_onRcvItemTransform(arg_6_1, arg_6_2, arg_6_3)
	self._alReadyAddFragmentNum = self._alReadyAddFragmentNum + self._curSelectFragmentNum
	self._curSelectFragmentNum = 1

	self:_initView()
	g.core.module.ModuleManager:awardSummary(arg_6_3.awards, true, nil, g.core.lang:get(300001))
	g.core.module.ModuleManager:popModule()
end

function AbleFragmentConvertPop:_onRcvKnihgtStarUp()
	g.core.module.ModuleManager:popModule()
end

function AbleFragmentConvertPop:_onRcvRebornExecute(arg_8_1, arg_8_2, arg_8_3)
	g.core.module.ModuleManager:popModule()
end

function AbleFragmentConvertPop:_onClickTransform()
	if self._state == AbleFragmentConvertPop.CONVERT then
		if self._type == AbleFragmentConvertPop.ABLEFRAGMENT then
			g.core.network.GameNetProxy:send_C2S_Reborn_Execute({
				sys_type = g.core.const.ConstMgr.RebornConst.TYPE_CUSTOM_FRAG,
				op_type = g.core.const.ConstMgr.RebornConst.OP_TYPE_SUBQULITY,
				ids = {
					self._goods1.value
				},
				nums = {
					self._curSelectFragmentNum
				}
			})
		else
			g.core.network.GameNetProxy:send_C2S_Item_Transform({
				id = self._fragmentId,
				size = self._curSelectFragmentNum
			})
		end
	elseif self._state == AbleFragmentConvertPop.BREAKTHROUGH then
		g.core.network.GameNetProxy:send_C2S_Knight_StarIncrease({
			id = self._knightStruct:getServerId(),
			all_purpose_frag_num = self._needFragmentNum
		})
	end
end

function AbleFragmentConvertPop:_updateCurSelectFragmentNum(arg_10_1)
	self._curSelectFragmentNum = arg_10_1

	self:_initView()
end

return AbleFragmentConvertPop
