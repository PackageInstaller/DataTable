local var_0_0 = g.core.model.User.newSlgData
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local NewSlgMiniMapBuildComp = class("NewSlgMiniMapBuildComp")

function NewSlgMiniMapBuildComp:ctor()
	self._typeCtrl = self:getController("type")
	self._hasBubbleCtrl = self:getController("has_bubble")
	self._buildType = nil
	self._buildInfo = nil

	self:addClickListener(handler(self, self._onClick))

	self._attackFlag = self:getChild("attackFlag")
	self._effHolder = self:getChild("Comp_place")
	self._listFarmIcon = self:getChild("List_farmIcon")

	self._listFarmIcon:setIniter(self)
	self._listFarmIcon:setItemRenderer(handler(self, self._onRenderListFarmIconCell))
end

function NewSlgMiniMapBuildComp:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_SETCITYDECLARATION, handler(self, self._onUpdateView), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_CITYDECLARENTF, handler(self, self._onUpdateView), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_CITYOCCUPIERNTF, handler(self, self._onUpdateView), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_CITYBEDECLAREDNTF, handler(self, self._onUpdateView), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_GETSMALLMAPINFO, handler(self, self._onUpdateView), self)
end

function NewSlgMiniMapBuildComp:_onUpdateView()
	self:updateView(self._buildType, self._info)
end

function NewSlgMiniMapBuildComp:updateView(arg_4_1, arg_4_2)
	self._buildType = arg_4_1
	self._info = arg_4_2

	self._hasBubbleCtrl:setSelectedIndex(0)
	self._attackFlag:setVisible(false)
	self._effHolder:removeAllEffect()

	if arg_4_1 == g.core.const.ConstMgr.NewSlgConst.COMP_TYPE.CITY then
		local var_4_0 = arg_4_2.value
		local var_4_1 = var_0_0:getCityOccupyAllianceId(arg_4_2.value)

		if var_4_1 > 0 then
			local var_4_2 = g.core.model.User.allianceData:getAllianceId()

			self._typeCtrl:setSelectedIndex(var_4_1 == var_4_2 and (g.core.model.User.newSlgData:getSName() == "S2" and 7 or 4) or 6)

			if #var_0_0:getCityDeclaredAlliances(var_4_0) > 0 and var_0_0:getCityInfoById(var_4_0).level ~= 1 then
				self._effHolder:addEffectSpine({
					name = "eff_ui_newSlg_beHit",
					isLoop = true,
					remove = false,
					anim = var_4_1 == var_4_2 and "play_b" or "play_r"
				})
			end
		else
			self._typeCtrl:setSelectedIndex(3)
		end

		if (var_0_0:isCityDeclared(var_4_0) or #var_0_0:getCityDeclaredAlliances(var_4_0) ~= 0) and var_0_0:getCityDeclaration(var_4_0) ~= "" then
			self._hasBubbleCtrl:setSelectedIndex(1)
		end

		self._farmArr = var_0_0:getFarmArrBelongCity(var_4_0)

		if #self._farmArr > 0 then
			self._listFarmIcon:setVisible(true)
			self._listFarmIcon:setNumItems(#self._farmArr)
		end
	elseif arg_4_1 == g.core.const.ConstMgr.NewSlgConst.COMP_TYPE.GATE then
		self._typeCtrl:setSelectedIndex(var_0_0:isGateCanPass(arg_4_2.value) and 5 or 2)
	elseif arg_4_1 == g.core.const.ConstMgr.NewSlgConst.COMP_TYPE.PLAYER_CASTLE then
		self._typeCtrl:setSelectedIndex(1)
	end

	self._buildInfo = arg_4_2
	self._buildType = arg_4_1
end

function NewSlgMiniMapBuildComp:_onClick()
	self:dispatchCompEvent("NewSlgMiniMapBuildComp_click", {
		buildType = self._buildType,
		buildInfo = self._buildInfo,
		comp = self
	})
end

function NewSlgMiniMapBuildComp:_onRenderListFarmIconCell(arg_6_1, arg_6_2)
	local var_6_0 = var_0_0:getFarmDataById(self._farmArr[arg_6_1 + 1].id)

	if not var_6_0 then
		return
	end

	if var_6_0.isOccupying then
		arg_6_2:getController("state"):setSelectedIndex(1)
	else
		arg_6_2:getController("state"):setSelectedIndex(0)
	end
end

return NewSlgMiniMapBuildComp
