local UserConst = require("app.view.module.user.const.UserConst")
local var_0_1 = g.core.model.User
local var_0_2 = g.core.lang
local UserTitleSetPop = class("UserTitleSetPop", require("app.fairyGUI.user.UI_UserTitleSetPop"), function()
	return fgui.GComponent:create({
		resName = "UserTitleSetPop",
		pkgPath = "ui/user/user",
		pkgName = "user"
	}, ...)
end)

function UserTitleSetPop:ctor()
	self:showAtCenter()

	self._isChange = nil
	self._newestTitleIds = nil

	self:addListen(self.m_titleList)
	self.m_titleList:setVirtual(self)
	self.m_titleList:doFairyBatching(false)
	self.m_titleList:setItemRenderer(handler(self, self._onTitleItemRenderer))
	self.m_oneKeyDropBtn:addClickListener(handler(self, self._onClickOneKeyDrop))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirm))

	local var_2_0 = clone(var_0_1:getAllWearingTitleIds())
	local var_2_1 = {}

	for iter_2_0 = 1, UserConst.MAX_TITLE_SLOT do
		table.insert(var_2_1, var_2_0[iter_2_0] or 0)
	end

	for iter_2_1 = #var_2_1 + 1, UserConst.MAX_TITLE_SLOT do
		table.insert(var_2_1, 0)
	end

	self._slotTitleDataCache = var_2_1
	self._allOwnTitlesDataCache = clone(g.core.model.User.UserTitleData:getAllOwnTitle())
	self.m_closeBtn = self.m_popPanel:getChild("closeBtn")

	self:_initMemberData()
	self.m_titleShowComp:setCallBack(handler(self, self._onClickShowIcon))
end

function UserTitleSetPop:_onClickShowIcon(arg_3_1)
	self._titleSelectId = arg_3_1

	self:_switchTitle()
end

function UserTitleSetPop:_initMemberData()
	self._titleSelectId = 0
	self._slotTitleIdBeforeSwitch = 0
	self._isNeedUpdateList = true
end

function UserTitleSetPop:onLoad()
	self:_updateView()
	self.m_isEmptyController:setSelectedIndex(#self._allOwnTitlesDataCache > 0 and 0 or 1)
end

function UserTitleSetPop:_updateView()
	self.m_titleShowComp:updateComp(self._slotTitleDataCache)
	self:_updateChooseNm()

	if self._isNeedUpdateList then
		self._isNeedUpdateList = false

		self:_updateTitleList()
	end

	local var_6_0, var_6_1 = self:_compareSlotChangedBeforeSave()

	self._isChange = var_6_0
	self._newestTitleIds = var_6_1

	if var_6_0 and self.m_closeBtn.setClickCallBack then
		self.m_closeBtn:setClickCallBack(handler(self, self._confirmToClose))
	else
		self.m_closeBtn:setClickCallBack(nil)
	end
end

function UserTitleSetPop:_updateTitleList()
	self.m_titleList:setNumItems(#self._allOwnTitlesDataCache)
end

function UserTitleSetPop:_onTitleItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateCell(self._allOwnTitlesDataCache[arg_8_1 + 1], UserConst.TITLE_MODE.EDIT_MODE, self._titleSelectId)
end

function UserTitleSetPop:_updateChooseNm()
	self.m_selectNum:setText(var_0_2:get(105501, {
		num = self:_getWearingNm(),
		totalNum = UserConst.MAX_TITLE_SLOT
	}))
end

function UserTitleSetPop:_getWearingNm()
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(self._slotTitleDataCache) do
		if iter_10_1 and iter_10_1 ~= 0 then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0
end

function UserTitleSetPop:_isTitleAtSlot()
	for iter_11_0, iter_11_1 in ipairs(self._slotTitleDataCache) do
		if iter_11_1 ~= 0 and iter_11_1 == self._titleSelectId then
			return true
		end
	end

	return false
end

function UserTitleSetPop:_switchTitle()
	if not self:_isTitleAtSlot() then
		local var_12_0 = false

		for iter_12_0 = 1, UserConst.MAX_TITLE_SLOT do
			if not self._slotTitleDataCache[iter_12_0] or self._slotTitleDataCache[iter_12_0] == 0 then
				self._slotTitleDataCache[iter_12_0] = self._titleSelectId
				var_12_0 = true

				break
			end
		end

		if var_12_0 then
			self._isNeedUpdateList = true

			for iter_12_1, iter_12_2 in ipairs(self._allOwnTitlesDataCache) do
				if iter_12_2.cfgData.id == self._titleSelectId then
					iter_12_2.weared = true

					break
				end
			end
		end
	else
		local var_12_1 = false
		local var_12_2 = clone(self._slotTitleDataCache)
		local var_12_3 = {}

		for iter_12_3 = 1, UserConst.MAX_TITLE_SLOT do
			local var_12_4 = var_12_2[iter_12_3] or 0

			if var_12_4 == self._titleSelectId then
				var_12_1 = true
			elseif var_12_4 > 0 then
				table.insert(var_12_3, var_12_4)
			end
		end

		for iter_12_4 = #var_12_3 + 1, UserConst.MAX_TITLE_SLOT do
			table.insert(var_12_3, 0)
		end

		self._slotTitleDataCache = var_12_3

		if var_12_1 then
			self._isNeedUpdateList = true

			for iter_12_5, iter_12_6 in ipairs(self._allOwnTitlesDataCache) do
				if iter_12_6.cfgData.id == self._titleSelectId then
					iter_12_6.weared = false

					break
				end
			end
		end
	end

	self:_updateView()
end

function UserTitleSetPop:receiveCompEvent(arg_13_1, arg_13_2)
	if arg_13_1 == "Choose_Own_Title" then
		self._titleSelectId = arg_13_2.titleId

		self:_switchTitle()
	elseif arg_13_1 == "Choose_Own_Title_Down" then
		self._titleSelectId = arg_13_2.titleId

		self:_switchTitle()
	end
end

function UserTitleSetPop:_compareSlotChangedBeforeSave()
	local var_14_0 = false
	local var_14_1 = {}
	local var_14_2 = clone(var_0_1:getAllWearingTitleIds())

	for iter_14_0 = 1, UserConst.MAX_TITLE_SLOT do
		local var_14_4 = self._slotTitleDataCache[iter_14_0] or 0

		if (var_14_2[iter_14_0] or 0) ~= var_14_4 then
			var_14_0 = true
		end

		table.insert(var_14_1, var_14_4)
	end

	return var_14_0, var_14_1
end

function UserTitleSetPop:_onClickOneKeyDrop()
	if #self._slotTitleDataCache < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(105503))

		return
	end

	self:_initMemberData()

	self._slotTitleDataCache = {}
	self._allOwnTitlesDataCache = g.core.model.User.UserTitleData:resetAllOwnTitle(self._allOwnTitlesDataCache)

	self:_updateView()
end

function UserTitleSetPop:_onClickConfirm()
	if self._isChange then
		g.core.network.GameNetProxy:send_C2S_Title_Wear({
			title_ids = self._newestTitleIds
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(105504))
	end

	g.core.module.ModuleManager:popComponent()
end

function UserTitleSetPop:_confirmToClose()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = var_0_2:get(105518),
		desc = var_0_2:get(105519),
		onConfirm = handler(self, function()
			g.core.module.ModuleManager:popComponent()
		end)
	}))
end

function UserTitleSetPop:onUnload()
	if #self._allOwnTitlesDataCache > 0 then
		for iter_19_0, iter_19_1 in ipairs(self._allOwnTitlesDataCache) do
			if not g.core.model.User.UserTitleData:judgeUserTitleNewSetting(iter_19_1.cfgData.id) then
				g.core.model.User.UserTitleData:setUserTitleNewSettingRecord(iter_19_1.cfgData.id)
			end
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_USER_TITLE_SET_REFRESH_POINT, {})
end

return UserTitleSetPop
