local var_0_0 = g.core.model.User.skinData
local var_0_1 = g.core.config.skin_info
local var_0_2 = g.core.config.knight_info
local KnightSkinBookLayer = class("KnightSkinBookLayer", require("app.fairyGUI.knightSkinBook.UI_KnightSkinBookLayer"), function()
	return fgui.GComponent:create({
		pkgName = "knightSkinBook",
		isFullScreen = true,
		pkgPath = "ui/knightSkinBook/knightSkinBook",
		resName = "KnightSkinBookLayer"
	}, ...)
end)

function KnightSkinBookLayer:ctor()
	self._allInfo = {}
	self._infoList = {}
	self._isOnlyShowOwn = true
	self._screenParam = nil
	self._themeIndex = 0

	self:addBg("bg/shop/bg_pifutujian.jpg")
	self.m_skinList:setVirtual()
	self.m_skinList:doFairyBatching(false)
	self.m_skinList:setItemRenderer(handler(self, self._onRendererSkin))
	self.m_skinList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickSkin))
	self.m_screenBtn:addClickListener(handler(self, self._onClickScreen))
	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancel))
	self.m_checkBtn:addClickListener(handler(self, self._onClickCheck))
end

function KnightSkinBookLayer:_onRendererSkin(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._infoList[arg_3_1 + 1])
end

function KnightSkinBookLayer:_onClickSkin(arg_4_1)
	g.core.module.ModuleManager:pushModule({
		modType = 1,
		create = function(arg_5_0)
			return require("app.view.module.knightSkinBook.view.KnightSkinBookShowLayer").new(...)
		end
	}, (var_0_1.get(self._infoList[arg_4_1:getDataValue() + 1].id)))
end

function KnightSkinBookLayer:_onClickScreen()
	local var_6_0 = require("app.view.module.recharge.view.SkinScreenPop").new({
		index = self._themeIndex
	})

	self:addListen(var_6_0)
	g.core.module.ModuleManager:pushPopup(var_6_0)
end

function KnightSkinBookLayer:_onClickCancel()
	self:_onClickScreen()
end

function KnightSkinBookLayer:_onClickCheck()
	self._isOnlyShowOwn = self.m_checkBtn:isSelected()

	self:updateView()
end

function KnightSkinBookLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SKIN_SCREEN, handler(self, self._onSkinScreen), self)

	self._allInfo = var_0_0:getAllKnightSkin()

	self.m_checkBtn:setSelected(self._isOnlyShowOwn)
	self:updateView()
end

function KnightSkinBookLayer:_onSkinScreen(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self._screenParam = arg_10_4

	if next(arg_10_4.theme) == nil then
		self.m_stateController:setSelectedIndex(0)
	else
		self.m_stateController:setSelectedIndex(1)

		for iter_10_0, iter_10_1 in pairs(arg_10_4.theme) do
			self.m_cancelBtn:setTitle(g.core.config.skin_theme_info.get(iter_10_1).name)
		end
	end

	self:updateView()
end

function KnightSkinBookLayer:updateView()
	self:_getShowSkin()

	if #self._infoList > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_skinList:setNumItems(#self._infoList)
		self.m_skinList:transitionShowCells("enter_right", 0.03)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function KnightSkinBookLayer:_getShowSkin()
	self._infoList = {}

	for iter_12_0, iter_12_1 in pairs(self._allInfo) do
		if (self._isOnlyShowOwn or nil) and var_0_0:getSkinState(iter_12_1.id) == 1 and (self._screenParam ~= nil or nil) and self:_isInScreen(iter_12_1, self._screenParam) then
			table.insert(self._infoList, iter_12_1)
		end
	end

	var_0_0:newSortWeight(self._infoList)
end

function KnightSkinBookLayer:_isInScreen(arg_13_1, arg_13_2)
	local var_13_0 = false
	local var_13_1 = false
	local var_13_2 = false

	if next(arg_13_2.quality) == nil then
		var_13_0 = true
	else
		for iter_13_0, iter_13_1 in pairs(arg_13_2.quality) do
			if arg_13_1.quality == iter_13_1 then
				var_13_0 = true

				break
			end
		end
	end

	if next(arg_13_2.camp) == nil then
		var_13_1 = true
	else
		local var_13_3 = var_0_2.get(arg_13_1.knight_advance_id).group

		for iter_13_2, iter_13_3 in pairs(arg_13_2.camp) do
			if var_13_3 == iter_13_3 then
				var_13_1 = true

				break
			end
		end
	end

	if next(arg_13_2.theme) == nil then
		var_13_2 = true
	else
		local var_13_4 = arg_13_1.theme

		for iter_13_4, iter_13_5 in pairs(arg_13_2.theme) do
			if tonumber(var_13_4) == iter_13_5 then
				var_13_2 = true

				break
			end
		end
	end

	return var_13_0 and var_13_1 and var_13_2
end

function KnightSkinBookLayer:receiveCompEvent(arg_14_1)
	if arg_14_1 == "REFRESH_SKIN_INDEX" then
		self._themeIndex = ({
			...
		})[1].index
	end
end

return KnightSkinBookLayer
