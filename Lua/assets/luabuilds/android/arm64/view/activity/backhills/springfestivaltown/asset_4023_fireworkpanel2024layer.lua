local FireworkPanel2024Layer = class("FireworkPanel2024Layer", import("view.base.BaseUI"))

function FireworkPanel2024Layer:getUIName()
	return "FireworkPanelUI"
end

function FireworkPanel2024Layer:init()
	self.leftPanel = self._tf:Find("main/left_panel")
	self.rightPanel = self._tf:Find("main/right_panel")
	self.fireBtn = self.rightPanel:Find("fire_btn")

	setText(self.rightPanel:Find("tip"), i18n("activity_yanhua_tip7"))

	self.leftItem = self.leftPanel:Find("scrollrect/content/item_tpl")
	self.leftItems = self.leftPanel:Find("scrollrect/content")
	self.leftUIList = UIItemList.New(self.leftItems, self.leftItem)
	self.rightItem = self.rightPanel:Find("content/item_tpl")
	self.rightItems = self.rightPanel:Find("content")
	self.rightUIList = UIItemList.New(self.rightItems, self.rightItem)
	self.arrowsTF = self.rightPanel:Find("arrows")

	self:initData()

	return
end

function FireworkPanel2024Layer:initData()
	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FIREWORK)

	assert(var_3_0 and not var_3_0:isEnd(), "烟花活动(type92)已结束")

	self.unlockCount = var_3_0:getData1()
	self.unlockIds = var_3_0:getData1List()
	self.allIds = pg.activity_template[var_3_0.id].config_data[3]
	self.actId = var_3_0.id
	self.playerId = getProxy(PlayerProxy):getData().id
	self.orderIds = self:getLocalData()

	return
end

function FireworkPanel2024Layer:getLocalData()
	local var_4_0 = {}

	for iter_4_0 = 1, #self.allIds do
		local var_4_1 = PlayerPrefs.GetInt("fireworks_" .. self.actId .. "_" .. self.playerId .. "_pos_" .. iter_4_0)

		if var_4_1 ~= 0 then
			table.insert(var_4_0, var_4_1)
		end
	end

	return var_4_0
end

function FireworkPanel2024Layer:setLocalData()
	for iter_5_0 = 1, #self.allIds do
		PlayerPrefs.SetInt("fireworks_" .. self.actId .. "_" .. self.playerId .. "_pos_" .. iter_5_0, self.orderIds[iter_5_0] or 0)
	end

	return
end

function FireworkPanel2024Layer:didEnter()
	onButton(self, self._tf:Find("main/mask"), function()
		self:emit(FireworkPanel2024Layer.ON_CLOSE)

		return
	end)
	onButton(self, self.rightPanel:Find("close_btn"), function()
		self:emit(FireworkPanel2024Layer.ON_CLOSE)

		return
	end)
	onButton(self, self.fireBtn, function()
		self:emit(FireworkPanel2024Layer.ON_CLOSE)

		return
	end)
	self:initLeft()
	self:initRight()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function FireworkPanel2024Layer:initLeft()
	setActive(self.leftPanel:Find("empty"), #self.unlockIds == 0)
	setActive(self.leftPanel:Find("scrollrect"), #self.unlockIds > 0)
	self.leftUIList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = "lock"

			if arg_11_1 + 1 <= #self.unlockIds then
				var_11_0 = tostring(self.unlockIds[arg_11_1 + 1])
			end

			arg_11_2.name = var_11_0

			if var_11_0 == "lock" then
				setActive(arg_11_2:Find("firework"), false)
			else
				local var_11_1 = tonumber(arg_11_2.name)

				setActive(arg_11_2:Find("firework"), true)

				local var_11_2 = table.contains(self.orderIds, var_11_1)

				setActive(arg_11_2:Find("firework/selected"), var_11_2)
				GetImageSpriteFromAtlasAsync(Item.getConfigData(var_11_1).icon, "", (arg_11_2:Find("firework/icon")))
				onButton(self, arg_11_2, function()
					self:onLeftClick(var_11_1, var_11_2)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	self.leftUIList:align(#self.allIds)

	return
end

function FireworkPanel2024Layer:initRight()
	for iter_13_0 = 1, #self.allIds - 2 do
		cloneTplTo(self.arrowsTF:Find("tpl"), self.arrowsTF)
	end

	self.rightUIList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = "null"

			if arg_14_1 + 1 <= #self.orderIds then
				var_14_0 = tostring(self.orderIds[arg_14_1 + 1])
			end

			arg_14_2.name = var_14_0

			local var_14_1 = arg_14_2:Find("icon")

			setActive(arg_14_2:Find("add"), var_14_0 == "null")

			if var_14_0 == "null" then
				setActive(var_14_1, false)
			else
				local var_14_2 = tonumber(arg_14_2.name)

				setActive(var_14_1, true)
				GetImageSpriteFromAtlasAsync(Item.getConfigData(var_14_2).icon, "", var_14_1)
				onButton(self, var_14_1, function()
					self:onRightClick(var_14_2)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	self.rightUIList:align(#self.allIds)

	return
end

function FireworkPanel2024Layer:onLeftClick(arg_16_1, arg_16_2)
	if arg_16_2 then
		table.removebyvalue(self.orderIds, arg_16_1)
	else
		table.insert(self.orderIds, arg_16_1)
	end

	self:setLocalData()
	self.leftUIList:align(#self.allIds)
	self.rightUIList:align(#self.allIds)

	return
end

function FireworkPanel2024Layer:onRightClick(arg_17_1)
	table.removebyvalue(self.orderIds, arg_17_1)
	self:setLocalData()
	self.leftUIList:align(#self.allIds)
	self.rightUIList:align(#self.allIds)

	return
end

function FireworkPanel2024Layer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.contextData.onExit then
		self.contextData.onExit()
	end

	return
end

return FireworkPanel2024Layer
