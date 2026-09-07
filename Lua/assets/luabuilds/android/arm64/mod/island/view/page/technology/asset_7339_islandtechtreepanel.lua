local IslandTechTreePanel = class("IslandTechTreePanel", import("view.base.BaseSubView"))

IslandTechTreePanel.VIEW_PADDING = 200
IslandTechTreePanel.ELEMENT_SIZE = {
	x = 410,
	y = 180
}
IslandTechTreePanel.LINE_TYPE = {
	C2 = 3,
	S = 1,
	C1 = 2
}
IslandTechTreePanel.DEFAULT_MAX_Y = 10
IslandTechTreePanel.EDGE_X = 2
IslandTechTreePanel.EDGE_Y = 1
IslandTechTreePanel.FocusPriorities = {
	IslandTechnology.STATUS.RECEIVE,
	IslandTechnology.STATUS.STUDYING,
	IslandTechnology.STATUS.NORMAL,
	IslandTechnology.STATUS.LOCK,
	IslandTechnology.STATUS.FINISHED
}

function IslandTechTreePanel:getUIName()
	return "IslandTechTreePanel"
end

function IslandTechTreePanel:OnLoaded()
	self.treeView = self._tf:Find("view")
	self.showContent = self.treeView:Find("content")
	self.debugContainer = self.showContent:Find("debug")
	self.itemUIList = UIItemList.New(self.showContent:Find("items"), self.showContent:Find("items/tpl"))
	self.lineContainer = self.showContent:Find("lines")
	self.lineTpls = {
		[IslandTechTreePanel.LINE_TYPE.S] = self._tf:Find("line_tpls/s"),
		[IslandTechTreePanel.LINE_TYPE.C1] = self._tf:Find("line_tpls/c1"),
		[IslandTechTreePanel.LINE_TYPE.C2] = self._tf:Find("line_tpls/c2")
	}

	return
end

function IslandTechTreePanel:OnInit()
	self.itemUIList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_4_1, arg_4_2)
		end

		return
	end)

	self.lineDatas = {}
	self.displays = pg.island_technology_template.get_id_list_by_tech_belong[self.contextData.type]
	self.maxX, self.maxY = 0, 0

	for iter_3_0, iter_3_1 in ipairs(self.displays) do
		self.maxX = math.max(self.maxX, pg.island_technology_template[iter_3_1].axis[1])
		self.maxY = math.max(self.maxY, pg.island_technology_template[iter_3_1].axis[2])
	end

	self.maxX = self.maxX + IslandTechTreePanel.EDGE_X
	self.maxY = math.max(IslandTechTreePanel.DEFAULT_MAX_Y, self.maxY + IslandTechTreePanel.EDGE_Y)

	return
end

function IslandTechTreePanel:UpdateItem(arg_5_1, arg_5_2)
	arg_5_2.name = self.displays[arg_5_1 + 1]

	local var_5_0 = self.techAgency:GetTechnology(self.displays[arg_5_1 + 1])

	setAnchoredPosition(arg_5_2, self:GetPositionById(var_5_0.id))
	setActive(arg_5_2:Find("selected"), false)
	IslandTechTreePanel.SetTechName(arg_5_2:Find("name"), var_5_0:getConfig("tech_name"))

	local var_5_1 = var_5_0:GetStatus()
	local var_5_2 = var_5_1 == IslandTechnology.STATUS.FINISHED

	setTextColor(arg_5_2:Find("name/Text"), Color.NewHex(var_5_1 == IslandTechnology.STATUS.FINISHED and "1b3650" or "ffffff"))
	setTextColor(arg_5_2:Find("name/ScrollText"), Color.NewHex(var_5_2 and "1b3650" or "ffffff"))
	LoadImageSpriteAsync("island/IslandTechnology/" .. var_5_0:getConfig("tech_icon"), arg_5_2:Find("icon"), true)
	setImageColor(arg_5_2:Find("icon"), Color.NewHex(var_5_2 and "455a81" or "ffffff"))
	setActive(arg_5_2:Find("icon"), var_5_1 ~= IslandTechnology.STATUS.STUDYING and var_5_1 ~= IslandTechnology.STATUS.RECEIVE)
	eachChild(arg_5_2:Find("back"), function(arg_6_0)
		setActive(arg_6_0, arg_6_0.name == var_5_1)

		return
	end)
	setActive(arg_5_2:Find("back/normal"), not var_5_2 and var_5_1 ~= IslandTechnology.STATUS.STUDYING)
	eachChild(arg_5_2:Find("front"), function(arg_7_0)
		setActive(arg_7_0, arg_7_0.name == var_5_1)

		return
	end)
	onButton(self, arg_5_2, function()
		existCall(self.contextData.onItemClick, var_5_0.id, (self._tf:InverseTransformPoint(arg_5_2.position)))

		return
	end, SFX_PANEL)

	return
end

function IslandTechTreePanel:Show()
	self.super.Show(self)
	self:Flush()
	self:AutoFocus()

	return
end

function IslandTechTreePanel:Flush()
	self.techAgency = getProxy(IslandProxy):GetIsland():GetTechnologyAgency()

	if not self.idx2pos then
		self:InitTreeCS(self.maxX, self.maxY)
	end

	self.itemUIList:align(#self.displays)

	return
end

function IslandTechTreePanel:InitTreeCS(arg_11_1, arg_11_2)
	self.gridSize = {
		x = IslandTechTreePanel.ELEMENT_SIZE.x / 2,
		y = IslandTechTreePanel.ELEMENT_SIZE.y / 2
	}

	setSizeDelta(self.showContent, {
		x = self.gridSize.x * arg_11_1 + IslandTechTreePanel.VIEW_PADDING,
		y = self.gridSize.y * arg_11_2
	})

	self.idx2pos = {}

	for iter_11_0, iter_11_1 in pairs(self:GetTechTreeLineData()) do
		for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
			self:UpdateLineTpl(iter_11_0, iter_11_3)
		end
	end

	return
end

function IslandTechTreePanel:GetPositionById(arg_12_1)
	return {
		x = self.gridSize.x * pg.island_technology_template[arg_12_1].axis[1],
		y = -self.gridSize.y * pg.island_technology_template[arg_12_1].axis[2]
	}
end

function IslandTechTreePanel:UpdateLineTpl(arg_13_1, arg_13_2)
	local var_13_0 = self:GetPositionById(arg_13_1)
	local var_13_1 = self:GetPositionById(arg_13_2)
	local var_13_2 = self:GetLineOutPutPos(var_13_0)
	local var_13_3 = self:GetLineInPutPos(var_13_1)

	if var_13_0.y == var_13_1.y then
		local var_13_4 = cloneTplTo(self.lineTpls[IslandTechTreePanel.LINE_TYPE.S], self.lineContainer)

		setLocalPosition(var_13_4, var_13_2)
		setSizeDelta(var_13_4, {
			x = var_13_3.x - var_13_2.x,
			y = var_13_4.sizeDelta.y
		})
	else
		local var_13_5 = math.abs(var_13_3.y - var_13_2.y)
		local var_13_6 = cloneTplTo(self.lineTpls[(var_13_5 <= IslandTechTreePanel.ELEMENT_SIZE.y / 2 or nil) and (IslandTechTreePanel.LINE_TYPE.C1 or IslandTechTreePanel.LINE_TYPE.C2)], self.lineContainer)

		setLocalScale(var_13_6, {
			y = var_13_1.y > var_13_0.y and -1 or 1
		})
		setLocalPosition(var_13_6, var_13_2)
		setSizeDelta(var_13_6, {
			x = var_13_3.x - var_13_2.x,
			y = var_13_5 + 6
		})
	end

	return
end

function IslandTechTreePanel:GetLineOutPutPos(arg_14_1)
	return {
		x = arg_14_1.x + 205,
		y = arg_14_1.y
	}
end

function IslandTechTreePanel:GetLineInPutPos(arg_15_1)
	return {
		x = arg_15_1.x - 210,
		y = arg_15_1.y
	}
end

function IslandTechTreePanel:GetTechTreeLineData()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(pg.island_technology_template.get_id_list_by_tech_belong[self.contextData.type]) do
		local var_16_1 = {}

		for iter_16_2, iter_16_3 in ipairs(pg.island_technology_template[iter_16_1].sys_unlock) do
			if iter_16_3[1] == IslandTechnology.UNLOCK_TYPE.FINISH_TECHNOLOGY then
				table.insert(var_16_1, iter_16_3[2])
			end
		end

		for iter_16_4, iter_16_5 in ipairs(var_16_1) do
			assert(pg.island_technology_template[iter_16_5], iter_16_1 .. "科研配置了不存在的前置科研id: " .. iter_16_5)

			if pg.island_technology_template[iter_16_5].tech_belong == self.contextData.type then
				var_16_0[iter_16_5] = var_16_0[iter_16_5] or {}

				if not table.contains(var_16_0[iter_16_5], iter_16_1) then
					table.insert(var_16_0[iter_16_5], iter_16_1)
				end
			end
		end
	end

	return var_16_0
end

function IslandTechTreePanel:AutoFocus()
	scrollTo(self.treeView, math.max(self:GetPositionById((self:GetFocusTechId())).x - IslandTechTreePanel.ELEMENT_SIZE.x / 2, 0) / self.showContent.rect.width, 0)

	return
end

function IslandTechTreePanel:GetFocusTechId()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(self.displays) do
		local var_18_1 = self.techAgency:GetTechnology(iter_18_1):GetStatus()

		var_18_0[var_18_1] = var_18_0[var_18_1] or {}

		table.insert(var_18_0[var_18_1], iter_18_1)
	end

	for iter_18_2, iter_18_3 in ipairs(IslandTechTreePanel.FocusPriorities) do
		if var_18_0[iter_18_3] and #var_18_0[iter_18_3] > 0 then
			table.sort(var_18_0[iter_18_3], CompareFuncs({
				function(arg_19_0)
					return self:GetPositionById(arg_19_0).x
				end,
				function(arg_20_0)
					return arg_20_0
				end
			}))

			return var_18_0[iter_18_3][1]
		end
	end

	return self.displays[1]
end

function IslandTechTreePanel:OnDestroy()
	return
end

function IslandTechTreePanel:SetTechName(arg_22_1)
	local var_22_0 = GetPerceptualSize(arg_22_1)

	GetComponent(self:Find("Text"), typeof(Text)).fontSize = var_22_0 > 8 and 28 or 32

	setActive(self:Find("Text"), var_22_0 <= 10)
	setActive(self:Find("ScrollText"), var_22_0 > 10)

	if var_22_0 > 10 then
		setScrollText(self:Find("ScrollText"), arg_22_1)
	else
		setText(self:Find("Text"), arg_22_1)
	end

	return
end

return IslandTechTreePanel
