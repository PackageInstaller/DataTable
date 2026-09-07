local EducateBagLayer = class("EducateBagLayer", import(".base.EducateBaseUI"))
local var_0_1 = "FFFFFF"
local var_0_2 = "939495"

function EducateBagLayer:getUIName()
	return "EducateBagUI"
end

function EducateBagLayer:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function EducateBagLayer:initData()
	self.itemVOs = getProxy(EducateProxy):GetItemList()

	return
end

function EducateBagLayer:findUI()
	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(EducateBagLayer.ON_CLOSE)

		return
	end)

	self.windowTF = self._tf:Find("anim_root/window")

	setText(self.windowTF:Find("title/Text"), i18n("child_btn_bag"))

	self.closeBtn = self.windowTF:Find("close_btn")
	self.togglesTF = self.windowTF:Find("toggles")
	self.itemView = self.windowTF:Find("item_scrollview")
	self.emptyTF = self.windowTF:Find("empty")

	setText(self.emptyTF:Find("Text"), i18n("child_bag_empty_tip"))

	return
end

function EducateBagLayer:addListener()
	onButton(self, self._tf:Find("anim_root/bg"), function()
		self:_close()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:_close()

		return
	end, SFX_PANEL)
	eachChild(self.togglesTF, function(arg_9_0)
		setText(arg_9_0:Find("Text"), i18n("child_item_type" .. arg_9_0.name))
		onToggle(self, arg_9_0, function(arg_10_0)
			local var_10_0

			if arg_10_0 then
				var_10_0 = var_0_1 or var_0_2
			end

			setImageColor(arg_9_0:Find("icon"), Color.NewHex(var_10_0))
			setTextColor(arg_9_0:Find("Text"), Color.NewHex(var_10_0))

			if arg_10_0 then
				self.anim:Play("anim_educate_bag_change")
				self:updateItems(tonumber(arg_9_0.name))
			end

			return
		end)

		return
	end)

	return
end

function EducateBagLayer:didEnter()
	self:OverlayPanel(self._tf, {
		groupDelta = 1
	})
	self:initItems()
	triggerToggle(self.togglesTF:Find("0"), true)

	return
end

function EducateBagLayer:initItems()
	self.itemRect = self.itemView:GetComponent("LScrollRect")

	function self.itemRect.onInitItem(arg_13_0)
		self:initItem(arg_13_0)

		return
	end

	function self.itemRect.onUpdateItem(arg_14_0, arg_14_1)
		self:updateItem(arg_14_0, arg_14_1)

		return
	end

	function self.itemRect.onReturnItem(arg_15_0, arg_15_1)
		self:returnItem(arg_15_0, arg_15_1)

		return
	end

	return
end

function EducateBagLayer:updateItems(arg_16_1)
	self.showVOs = {}
	self.showVOs = underscore.select(self.itemVOs, function(arg_17_0)
		return arg_17_0:IsShow() and (arg_16_1 == 0 or arg_17_0:GetType() == arg_16_1)
	end)

	table.sort(self.showVOs, CompareFuncs({
		function(arg_18_0)
			return arg_18_0:CanUse() and 1 or 0
		end,
		function(arg_19_0)
			return -arg_19_0:GetRarity()
		end,
		function(arg_20_0)
			return -arg_20_0.count
		end,
		function(arg_21_0)
			return -arg_21_0.id
		end
	}))
	self.itemRect:SetTotalCount(#self.showVOs, -1)
	setActive(self.emptyTF, #self.showVOs <= 0)

	return
end

function EducateBagLayer:initItem(arg_22_1)
	return
end

function EducateBagLayer:updateItem(arg_23_1, arg_23_2)
	local var_23_0 = self.showVOs[arg_23_1 + 1]:GetShowInfo()

	EducateHelper.UpdateDropShow(arg_23_2, var_23_0)
	onButton(self, arg_23_2, function()
		self:emit(EducateBagLayer.EDUCATE_ON_ITEM, {
			drop = var_23_0
		})

		return
	end, SFX_PANEL)

	return
end

function EducateBagLayer:returnItem(arg_25_1, arg_25_2)
	removeOnButton(arg_25_2)

	return
end

function EducateBagLayer:_close()
	self.anim:Play("anim_educate_bag_out")

	return
end

function EducateBagLayer:onBackPressed()
	self:_close()

	return
end

function EducateBagLayer:willExit()
	self.animEvent:SetEndEvent(nil)
	self:UnOverlayPanel(self._tf)

	return
end

return EducateBagLayer
