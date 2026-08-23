local var_0_0 = g.core.model.User.dungeonData
local var_0_1 = g.core.const.ConstMgr.DungeonConst
local DungeonPreRegistrationPop = class("DungeonPreRegistrationPop", require("app.fairyGUI.dungeon.UI_DungeonPreRegistrationPop"), function()
	return fgui.GComponent:create({
		resName = "DungeonPreRegistrationPop",
		pkgPath = "ui/dungeon/dungeon",
		pkgName = "dungeon"
	})
end)

function DungeonPreRegistrationPop:ctor()
	self:showAtCenter()

	self._registAward = {}
	self._touchcomp = nil

	self.m_registList:setVirtual()
	self.m_registList:setItemRenderer(handler(self, self._onRegistItemRender))
	self.m_gotoMailBtn:addClickListener(handler(self, self._onClickGoToMailBtn))
	self:_initMainView()
end

function DungeonPreRegistrationPop:_initMainView()
	self._registAward = var_0_0:getRegistrationAwardData()

	self.m_registList:setNumItems(#self._registAward)

	local var_3_0 = var_0_0:getLastPassedChapter()

	self.m_curNumTxt:setText(var_3_0)
	self.m_maxNumTxt:setText("/" .. var_0_1.OPEN_REGISTRATION_CHAPTER)
	self.m_knightLoader:setURL("ui://dungeon/pic_juese_" .. (g.core.config.parameter_info.get(22002).parameter or 1))

	local var_3_1 = var_3_0 >= var_0_1.OPEN_REGISTRATION_CHAPTER

	self.m_isPassController:setSelectedIndex(var_3_0 >= var_0_1.OPEN_REGISTRATION_CHAPTER and 1 or 0)
	self.m_enterTransition:play(function()
		if var_3_1 then
			self:addTouchComp()
		end
	end)
end

function DungeonPreRegistrationPop:_onRegistItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateAwardCell(self._registAward[arg_5_1 + 1])
end

function DungeonPreRegistrationPop:_onClickGoToMailBtn()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	g.core.module.ModuleManager:pushModule(g.view.entrance.MAIL)
end

function DungeonPreRegistrationPop:uniqueStyleOutTrans(arg_7_1)
	self.m_backTransition:play(arg_7_1)
end

function DungeonPreRegistrationPop:addTouchComp()
	fgui.UIPackage:addPackage("ui/guide/guide")

	local var_8_0 = fgui.UIPackage:createObject("guide", "GuideTouchComp")

	var_8_0:setTouchable(false)
	var_8_0:setScaleX(-1)
	var_8_0:updateView()
	var_8_0:setPosition(self.m_pos:getPosition())
	self:getView():addChild(var_8_0)
end

return DungeonPreRegistrationPop
