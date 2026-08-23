local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareExploreOtherFormationPop = class("FogNightmareExploreOtherFormationPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreOtherFormationPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareExploreOtherFormationPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = true,
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareExploreOtherFormationPop:ctor(arg_2_1)
	self._curTabIndex = arg_2_1.tabIdx or 1
	self._formations = arg_2_1.formations
	self._userInfo = arg_2_1.user
	self._waveState = {}

	for iter_2_0, iter_2_1 in ipairs(self._formations) do
		self._waveState[iter_2_0] = false
	end

	self._skillComps = {}
	self._tabPosX = self.m_tabList:getPosition().x + self.m_tabList:getSize().width

	self:_initView()
	self:showAtCenter()
end

function FogNightmareExploreOtherFormationPop:_initView()
	self:addBg("bg/fogNightmare/bg_wjmy_bz_wenli.png", false, nil, 1)
	self.m_topBarComp:setResInfoById(var_0_0.HelpConst.HELP_TYPE.FOG_NIGHTMARE_FORMATION)
	self.m_tabList:setVirtual(self)
	self.m_tabList:doFairyBatching(false)
	self.m_tabList:setItemRenderer(handler(self, self._onTabItemRender))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabItemSelected))
	self.m_tabList:setNumItems(#self._formations)
	self.m_leftBtn:addClickListener(handler(self, self._onClickLeftBtn))
	self.m_rightBtn:addClickListener(handler(self, self._onClickRightBtn))
	self:_updateUserUI()
	self:_initFormatUniteIcon()
	self.m_knightsComp:setPlusUIEnable(false)
end

function FogNightmareExploreOtherFormationPop:_initFormatUniteIcon()
	self.m_leftBottomComp:initUI()
	self.m_leftBottomComp:setBtnDraggable(false)
end

function FogNightmareExploreOtherFormationPop:_onTabItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateComp(arg_5_1 + 1, false, self._waveState[arg_5_1 + 1])
end

function FogNightmareExploreOtherFormationPop:_onTabItemSelected()
	local var_6_0 = self.m_tabList:getSelectedIndex() + 1

	if self._waveState[var_6_0] then
		var_0_1:tip(g.core.lang:get(500171))
		self.m_tabList:setSelectedIndex(self._curTabIndex - 1)

		return
	end

	for iter_6_0, iter_6_1 in ipairs((self.m_tabList:getChildren())) do
		if iter_6_0 == var_6_0 then
			iter_6_1:playBtnEffect()
		else
			iter_6_1:closeBtnEffect()
		end
	end

	if self._curTabIndex == var_6_0 then
		return
	end

	self._curTabIndex = var_6_0

	self:_onChangeFormation()
end

function FogNightmareExploreOtherFormationPop:_updateUserUI()
	self.m_userIcon:updateAsUser(self._userInfo)
	self.m_nameText:setText(self._userInfo.name)
	self.m_levelText:setText(g.core.lang:get(2052, {
		level = self._userInfo.level
	}))
end

function FogNightmareExploreOtherFormationPop:_addCustomEvent()
	return
end

function FogNightmareExploreOtherFormationPop:onLoad()
	self:_addCustomEvent()

	self._curTabIndex = nil

	self.m_tabList:setSelectedIndex(self._curTabIndex - 1)
	self:_onTabItemSelected()
	self:updateView(true)
end

function FogNightmareExploreOtherFormationPop:updateView(arg_10_1)
	self:_updateCurFormation(arg_10_1)
	self:_updateTokenBtn()
	self:updatePreciousSuitBtn()
end

function FogNightmareExploreOtherFormationPop:updatePreciousSuitBtn()
	if not self._preciousSuitBtn then
		self._preciousSuitBtn = fgui.UIPackage:createObject("base_new", "BasePreciousSuitBtn")

		self:addChild(self._preciousSuitBtn)
		self._preciousSuitBtn:setPosition(display.width - 126, display.height - 294)
	end

	self._preciousSuitBtn:setOtherUserData(self:getCurFormation():getOtherUserSuit())
end

function FogNightmareExploreOtherFormationPop:_onChangeFormation()
	self:updateView(true)
	self:_checkBtnState()
end

function FogNightmareExploreOtherFormationPop:_checkBtnState()
	if self._curTabIndex > 1 and not self._waveState[self._curTabIndex - 1] then
		self.m_isShowLeftController:setSelectedIndex(1)
	else
		self.m_isShowLeftController:setSelectedIndex(0)
	end

	if self._curTabIndex + 1 <= #self._waveState and not self._waveState[self._curTabIndex + 1] then
		self.m_isShowRightController:setSelectedIndex(1)
	else
		self.m_isShowRightController:setSelectedIndex(0)
	end
end

function FogNightmareExploreOtherFormationPop:_updateCurFormation(arg_14_1)
	if self._isTouched and self._curTabIndex == self._touchFormationIndex then
		self.m_knightsComp:updateComp(self:getCurFormation(), self._curTabIndex, arg_14_1, self._touchIndex)
	else
		self.m_knightsComp:updateComp(self:getCurFormation(), self._curTabIndex, arg_14_1)
	end
end

function FogNightmareExploreOtherFormationPop:_updateTokenBtn()
	local var_15_0 = {}

	var_15_0.uniteTokens = self:getCurFormation():getUniteTokenList()
	var_15_0.pets = self:getCurFormation():getPetList()
	var_15_0.succubas = self:getCurFormation():getOtherUserSuccuba()

	self.m_leftBottomComp:setIsOther(true)
	self.m_leftBottomComp:updateComp(var_15_0, self._curTabIndex)
end

function FogNightmareExploreOtherFormationPop:getCurFormation()
	return self._formations[self._curTabIndex]
end

function FogNightmareExploreOtherFormationPop:_onClickLeftBtn()
	self.m_tabList:setSelectedIndex(math.max(0, self._curTabIndex - 1 - 1))
	self:_onTabItemSelected()
end

function FogNightmareExploreOtherFormationPop:_onClickRightBtn()
	self.m_tabList:setSelectedIndex(math.min(#self._waveState - 1, self._curTabIndex - 1 + 1))
	self:_onTabItemSelected()
end

function FogNightmareExploreOtherFormationPop:onUnload()
	return
end

function FogNightmareExploreOtherFormationPop:receiveCompEvent(arg_20_1, arg_20_2)
	local var_20_0 = self:getCurFormation()

	if arg_20_1 == "clickAddKnight" then
		self._targetPos = arg_20_2.pos

		local var_20_1 = var_20_0:getKnight(self._targetPos)

		if not var_20_1 then
			var_0_1:tip(g.core.lang:get(500229))

			return
		end

		local var_20_2 = {
			value = var_20_1:getBaseId(),
			type = g.core.common.Goods.TYPE_KNIGHT,
			struct = var_20_1
		}

		var_20_2.isFogNightPop = true
		var_20_2.isOthers = true

		if var_20_1:isMain() then
			var_20_1:setIsOtherUser(true, self._userInfo.name)
		end

		g.core.common.GlobalFunc.pushInfoPop(var_20_2)

		return true
	elseif arg_20_1 == "clickAddDev" then
		self._targetPos = arg_20_2.pos

		local var_20_3 = var_20_0:getKnight(self._targetPos)

		if not var_20_3 then
			return
		end

		if var_0_2.KNIGHT_DEVELOP_KEY.ARTIFACT == arg_20_2.devKey then
			local var_20_4 = var_20_3:getDevelopStruct(arg_20_2.devKey)

			if not var_20_4 then
				var_0_1:tip(g.core.lang:get(500230))

				return
			end

			g.core.common.GlobalFunc.pushInfoPop({
				value = var_20_4:getArtifactBaseId(),
				type = g.core.common.Goods.TYPE_ARTIFACT
			})
		end

		return true
	elseif arg_20_1 == "onClickedKeepsake" then
		self._targetPos = arg_20_2.pos

		local var_20_5 = var_20_0:getKnight(self._targetPos)

		if not var_20_5 then
			return
		end

		if not var_20_5:getDevelopStruct(var_0_2.KNIGHT_DEVELOP_KEY.KEEPSAKE) then
			return
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareKnightKeepsakeInfoPop"):new(true), {
			ignoreTouch = false,
			hideContinue = false,
			touchDisappear = true
		})

		return true
	elseif arg_20_1 == "clickAddUnite" then
		self._targetPos = arg_20_2.pos

		local var_20_6 = var_20_0:getUniteToken(self._targetPos)

		if not var_20_6 then
			var_0_1:tip(g.core.lang:get(500231))

			return
		end

		g.core.common.GlobalFunc.pushInfoPop({
			value = var_20_6:getAdvanceId(),
			type = g.core.common.Goods.TYPE_UNITETOKEN
		})

		return true
	elseif arg_20_1 == "clickAddPet" then
		self._targetPos = arg_20_2.pos

		local var_20_7 = var_20_0:getPet(self._targetPos)

		if not var_20_7 then
			var_0_1:tip(g.core.lang:get(500246))

			return
		end

		g.core.common.GlobalFunc.pushInfoPop({
			value = var_20_7:getAdvanceId(),
			type = g.core.common.Goods.TYPE_PET
		})

		return true
	end

	return false
end

return FogNightmareExploreOtherFormationPop
