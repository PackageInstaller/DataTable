local AssignedShipForBuildURScene = class("AssignedShipForBuildURScene", import("view.base.BaseUI"))

function AssignedShipForBuildURScene:getUIName()
	return "AssignedShipBuildURUI"
end

function AssignedShipForBuildURScene:setItemVO(arg_2_1)
	self.itemVO = arg_2_1

	return
end

function AssignedShipForBuildURScene:preload(arg_3_1)
	self.shipUsageDic = {}
	self.ids = underscore.map(self.contextData.itemVO:getConfig("usage_arg"), function(arg_4_0)
		self.shipUsageDic[pg.item_usage_invitation[arg_4_0].ship_id] = arg_4_0

		return pg.item_usage_invitation[arg_4_0].ship_id
	end)
	self.iconSprites = {}

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self.ids) do
		table.insert(var_3_0, function(arg_5_0)
			GetSpriteFromAtlasAsync("RegularExchangeIcon", tostring(iter_3_1), function(arg_6_0)
				self.iconSprites[iter_3_1] = arg_6_0

				arg_5_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_3_0, arg_3_1)

	return
end

function AssignedShipForBuildURScene:init()
	self.backBtn = self._tf:Find("top/bg/btn_back")

	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)

	local var_7_0 = self._tf:Find("select/view/container")

	self.iconList = UIItemList.New(var_7_0, var_7_0:Find("tpl"))

	self.iconList:make(function(arg_9_0, arg_9_1, arg_9_2)
		arg_9_1 = arg_9_1 + 1

		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = Ship.New({
				configId = self.ids[arg_9_1]
			})

			setImageSprite(arg_9_2:Find("Image"), self.iconSprites[var_9_0.configId], true)
			setActive(arg_9_2:Find("noget"), not getProxy(CollectionProxy):getShipGroup(var_9_0:getGroupId()))
			onToggle(self, arg_9_2, function(arg_10_0)
				if arg_10_0 then
					self:setSelectedShip(var_9_0)
				end

				return
			end, SFX_PANEL)
			triggerToggle(arg_9_2, arg_9_1 == 1)
		end

		return
	end)

	self.btnConfirm = self._tf:Find("select/operation/confirm")

	onButton(self, self.btnConfirm, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("handbook_ur_double_check", self.shipVO:getName()),
			onYes = function()
				self:emit(AssignedShipMediator.ON_USE_ITEM, self.itemVO.id, 1, {
					self.shipUsageDic[self.shipVO:GetConfigID()]
				})

				return
			end
		})

		return
	end, SFX_CONFIRM)

	self.rtName = self._tf:Find("select/name_bg")
	self.rtPaint = self._tf:Find("main/paint")

	return
end

function AssignedShipForBuildURScene:setSelectedShip(arg_13_1)
	if self.shipVO then
		retPaintingPrefab(self.rtPaint, self.shipVO:getPainting())
	end

	self.shipVO = arg_13_1

	GetImageSpriteFromAtlasAsync("shiptype", ShipType.Type2BattlePrint(arg_13_1:getShipType()), self.rtName:Find("shiptype/Image"), true)
	setText(self.rtName:Find("name"), arg_13_1:getName())
	setText(self.rtName:Find("english"), string.upper(arg_13_1:getConfig("english_name")))
	setPaintingPrefabAsync(self.rtPaint, arg_13_1:getPainting(), "huode")

	return
end

function AssignedShipForBuildURScene:flush()
	self.iconList:align(#self.ids)

	return
end

function AssignedShipForBuildURScene:didEnter()
	self:flush()

	return
end

function AssignedShipForBuildURScene:willExit()
	self.iconSprites = nil

	if self.shipVO then
		retPaintingPrefab(self.rtPaint, self.shipVO:getPainting())
	end

	return
end

return AssignedShipForBuildURScene
