local UserConst = require("app.view.module.user.const.UserConst")
local var_0_1 = g.core.model.User
local UserTitleComp = class("UserTitleComp", require("app.fairyGUI.user.UI_UserTitleComp"))

function UserTitleComp:ctor()
	self._titlesData = {}
	self._isFirstEnter = true
	self._selectedTitleType = UserConst.TITLE_TYPE_INDEX.ALL
	self._isUpdateEver = false

	self.m_attrBtn:addClickListener(handler(self, self._onClickInfoComp))
	self.m_titleList:setVirtual(self)
	self.m_titleList:doFairyBatching(false)
	self.m_titleList:setItemRenderer(handler(self, self._onTitleItemRenderer))
	self.m_titleTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTitleStyle))
end

function UserTitleComp:onLoad()
	return
end

function UserTitleComp:updateComp()
	self._isUpdateEver = true
	self._titlesData = g.core.model.User.UserTitleData:getTitleDataByType(self._selectedTitleType)

	self:_updateTitleList()

	if self._isFirstEnter then
		self._isFirstEnter = false

		self:_updateCollectProgress()
	end
end

function UserTitleComp:_updateCollectProgress()
	self.m_totalNum:setText("/" .. #self._titlesData)
	self.m_curCollectNum:setText(#var_0_1:getAllTitles())
end

function UserTitleComp:_updateTitleList()
	self.m_titleList:setNumItems(#self._titlesData)
	self.m_titleList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
end

function UserTitleComp:_onTitleItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._titlesData[arg_6_1 + 1], UserConst.TITLE_MODE.READ_MODE)
end

function UserTitleComp:_onClickInfoComp()
	if #var_0_1:getAllTitles() > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.user.view.UserTitleAttrPop").new(), {
			touchDisappear = true
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(105505))
	end
end

function UserTitleComp:_onChangeTitleStyle()
	self._selectedTitleType = self.m_titleTypeController:getSelectedIndex()

	self:updateComp()
end

function UserTitleComp:onUnload()
	if self._isUpdateEver then
		for iter_9_0, iter_9_1 in ipairs(self._titlesData) do
			if iter_9_1.isOwn and not g.core.model.User.UserTitleData:judgeUserTitleNewSetting(iter_9_1.cfgData.id) then
				g.core.model.User.UserTitleData:setUserTitleNewSettingRecord(iter_9_1.cfgData.id)
			end
		end
	end
end

return UserTitleComp
