local var_0_0 = g.core.const.ConstMgr.AncientsConst
local AncientsFormationLayer = class("AncientsFormationLayer", require("app.fairyGUI.ancients.UI_AncientsFormationLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/ancients/ancients",
		resName = "AncientsFormationLayer",
		pkgName = "ancients",
		isFullScreen = true
	}, ...)
end)

function AncientsFormationLayer:ctor(arg_2_1)
	self.m_topBarComp:setResInfoById(var_0_0.TopBarId)

	self._formationType = arg_2_1.formationType
	self._dungeonId = 1
	self._formationIndex = 1
	self._clickSave = false

	self:_initView()
end

function AncientsFormationLayer:_initView()
	self.m_saveBtn:addClickListener(handler(self, self._onSaveBtnClicked))
	self:addBg("bg/ancients/bg_jxmy_bianduijmbg.jpg")
	self.m_tabBtn:updateView(1, self._formationType)
	self.m_enterTransition:play()
end

function AncientsFormationLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, self._onSaveSucc, self)
	self:_updateFormationView()
end

function AncientsFormationLayer:_onSaveBtnClicked()
	if not g.core.model.User.mulFormationData:getFormationStruct(self._formationType, self._formationIndex):isFormationValid() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428822))

		return
	end

	if self._cdSchedule then
		g.core.module.ModuleManager:tip(g.core.lang:get(2502))

		return
	end

	self:_doSaveFormation()
end

function AncientsFormationLayer:_doSaveFormation()
	if not g.core.model.User.mulFormationData:isModified(self._formationType) then
		g.core.module.ModuleManager:tip(g.core.lang:get(432002))
	end

	if not g.core.model.User.mulFormationData:getFormationStruct(self._formationType, self._formationIndex):isKnightNumValid() then
		g.core.module.ModuleManager:tip(g.core.lang:get(432002))
	elseif not g.core.model.User.mulFormationData:isModified(self._formationType) then
		g.core.module.ModuleManager:tip(g.core.lang:get(432002))
	else
		self._clickSave = true

		self.m_teamFormationComp:sendC2SFormationSave()
	end
end

function AncientsFormationLayer:_updateFormationView()
	self.m_teamFormationComp:updateComp(self._formationType, self._formationIndex)
end

function AncientsFormationLayer:_onSaveSucc(arg_8_1, arg_8_2, arg_8_3)
	if self._clickSave then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.MUL_CHANGE_ALL, false)
		g.core.module.ModuleManager:tip(g.core.lang:get(432002))
	end

	self._clickSave = false
end

return AncientsFormationLayer
