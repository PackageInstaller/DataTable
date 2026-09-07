local EscapeManorCollectPage = class("EscapeManorCollectPage", import("view.activity.CorePage.DOA.DOACoreActivityCollectPage"))

function EscapeManorCollectPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.btnList = self.bg:Find("btn_list")
	self.itemPanel = self.bg:Find("item_panel")
	self.togglesTF = self.itemPanel:Find("toggles")
	self.content = self.itemPanel:Find("item_list/content")
	self.itemList = UIItemList.New(self.content, self.content:Find("tpl"))
	self.msgBox = EscapeManorCollectMsgBox.New(self._tf, self.event)

	return
end

function EscapeManorCollectPage:AddSpecialBtnListener()
	local var_2_0 = self.activity:getConfig("config_client")

	self.furnitureThemeBtn = self.btnList:Find("furniture_theme")

	if self.furnitureThemeBtn and var_2_0.furniture_theme_link then
		onButton(self, self.furnitureThemeBtn, function()
			self:DoSkip(var_2_0.furniture_theme_link[1], var_2_0.furniture_theme_link[2])

			return
		end, SFX_PANEL)
	end

	self.equipSkinBoxBtn = self.btnList:Find("equip_skin_box")

	if self.equipSkinBoxBtn and var_2_0.equipskin_box_link then
		local var_2_1 = Drop.New({
			type = var_2_0.equipskin_box_link.drop_type,
			id = var_2_0.equipskin_box_link.drop_id
		}):getOwnedCount()

		onButton(self, self.equipSkinBoxBtn, function()
			self.msgBox:ExecuteAction("Show", {
				drop_type = var_2_0.equipskin_box_link.drop_type,
				drop_id = var_2_0.equipskin_box_link.drop_id,
				count = var_2_1,
				skipable_list = var_2_0.equipskin_box_link.list
			})

			return
		end, SFX_PANEL)
	end

	return
end

function EscapeManorCollectPage:UpdatePage(arg_5_1)
	self.curPage = arg_5_1
	self.showDataList = Clone(self.dataList)

	table.sort(self.showDataList, CompareFuncs({
		function(arg_6_0)
			return arg_6_0.count < arg_6_0.config.count and 0 or 1
		end,
		function(arg_7_0)
			return arg_7_0.config.order
		end,
		function(arg_8_0)
			return arg_8_0.id
		end
	}))
	self.itemList:align(#self.showDataList)

	return
end

function EscapeManorCollectPage:OnUpdateItem(arg_9_1, arg_9_2)
	local var_9_0 = self.showDataList[arg_9_1 + 1]
	local var_9_1 = arg_9_2:Find("icon_mask/icon")
	local var_9_2 = {
		type = self.showDataList[arg_9_1 + 1].config.type,
		id = self.showDataList[arg_9_1 + 1].config.drop_id
	}

	updateDrop(var_9_1, var_9_2)
	onButton(self, var_9_1, function()
		self:OnClickItem(var_9_0)

		return
	end, SFX_PANEL)
	changeToScrollText(arg_9_2:Find("name_mask/name"), Drop.New({
		type = var_9_0.config.type,
		id = var_9_0.config.drop_id
	}):getName())
	self:RefreshCountText(var_9_0, arg_9_2)

	GetOrAddComponent(arg_9_2:Find("owner"), typeof(CanvasGroup)).alpha = var_9_0.count == var_9_0.config.count and 0.5 or 1

	setActive(arg_9_2:Find("new"), var_9_0.config.is_new == "1")

	if var_9_2.type == 4 then
		setActive(arg_9_2:Find("got"), var_9_0.count >= 1)
	else
		setActive(arg_9_2:Find("got"), var_9_0.count == var_9_0.config.count)
	end

	return
end

return EscapeManorCollectPage
