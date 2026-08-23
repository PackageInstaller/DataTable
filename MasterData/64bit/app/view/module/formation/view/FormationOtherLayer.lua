local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local FormationOtherLayer = class("FormationOtherLayer", require("app.fairyGUI.formation.UI_FormationOtherLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/formation/formation",
		resName = "FormationOtherLayer",
		pkgName = "formation",
		isFullScreen = true
	})
end)

function FormationOtherLayer:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.title then
		self.m_topBar:setTitle(arg_2_1.title)
	end

	if arg_2_1 and arg_2_1.posHpList then
		self._posHpList = arg_2_1.posHpList
	end

	if arg_2_1.preFormationParam and arg_2_1.preFormationParam ~= "" then
		self._preFormationString = arg_2_1.preFormationParam
	elseif arg_2_1.data then
		self._data = arg_2_1.data
	else
		self._uid = arg_2_1.id
	end

	self:_initView()
end

function FormationOtherLayer:_initView()
	self:addBg("bg/formation/pic_bz_beijing.jpg")
	self.m_topBar:setResInfoById(75)
	self.m_preComp:setSize(display.width, display.height)
	self.m_mainComp:setSize(display.width, display.height)
end

function FormationOtherLayer:onLoad()
	if self._data then
		self:_onPlayShowUI()
	elseif self._preFormationString ~= nil then
		self:_onPlayShowUI()
	else
		var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GET_USER_DETAIL_INFO, handler(self, self._onNetReceived), self)
		g.core.network.GameNetProxy:send_C2S_GetUserDetailInfo({
			tp = 0,
			player_id = self._uid
		})
	end
end

function FormationOtherLayer:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "FormationOtherLayer_name" then
		self.m_topBar:setTitle(arg_5_2.name)
	end
end

function FormationOtherLayer:_onNetReceived()
	self._data = g.core.model.User.friendData:getPlayerInfo().formationData

	self:_onPlayShowUI()
end

function FormationOtherLayer:_onPlayShowUI()
	self:updateView()
	self.m_enterTransition:play()
end

function FormationOtherLayer:_isMainF()
	return self._data ~= nil
end

function FormationOtherLayer:updateView()
	if self:_isMainF() then
		self.m_mainStateController:setSelectedIndex(0)
		self.m_mainComp:updateOtherUser(self._data)
	else
		self.m_mainStateController:setSelectedIndex(1)
		self.m_preComp:updateOtherUserView(self._preFormationString)
	end

	self:updatePreciousSuitBtn()
end

function FormationOtherLayer:updatePreciousSuitBtn()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PRECIOUS) then
		if not self._preciousSuitBtn then
			self._preciousSuitBtn = fgui.UIPackage:createObject("base_new", "BasePreciousSuitBtn")

			self:addChild(self._preciousSuitBtn)
			self._preciousSuitBtn:setPosition(70, 430)
		end

		if self:_isMainF() then
			self._preciousSuitBtn:setOtherUserData(self._data.preciousSuit)
		else
			self._preciousSuitBtn:setOtherUserData(g.core.model.User.formationData:getPreFormationByString(self._preFormationString):getOtherPreciousSuitDict())
		end
	end
end

return FormationOtherLayer
