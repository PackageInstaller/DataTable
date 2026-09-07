local AttireFramePanel = class("AttireFramePanel", import("...base.BaseSubView"))

function AttireFramePanel:Card()
	local var_1_0 = {}

	function var_1_0:isEmpty()
		return not self.attireFrame or self.attireFrame.id == -1
	end

	local function var_1_1(arg_4_0, arg_4_1, arg_4_2)
		arg_4_0.state = arg_4_1:getState()

		_.each(arg_4_0.tags, function(arg_5_0)
			setActive(arg_5_0, false)

			return
		end)
		setActive(arg_4_0.mask, arg_4_0.state == AttireFrame.STATE_LOCK)
		setActive(arg_4_0.tags[1], arg_4_0.state == AttireFrame.STATE_UNLOCK and arg_4_2:getAttireByType(arg_4_1:getType()) == arg_4_1.id)
		setActive(arg_4_0.tags[2], arg_4_0.state == AttireFrame.STATE_UNLOCK and arg_4_1:isNew())

		return
	end

	function var_1_0:Update(arg_6_1, arg_6_2, arg_6_3)
		self:UpdateSelected(false)

		self.attireFrame = arg_6_1

		local var_6_0 = self:isEmpty()

		if not var_6_0 then
			var_1_1(self, arg_6_1, arg_6_2)
		end

		setActive(self.infoTF, not var_6_0)
		setActive(self.emptyTF, var_6_0)
		setActive(self.print5, not arg_6_3)
		setActive(self.print6, not arg_6_3)

		return
	end

	function var_1_0.LoadPrefab(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_7_1:getType()
		local var_7_1 = arg_7_1:getPrefabName()

		PoolMgr.GetInstance():GetPrefab(arg_7_1:getIcon(), var_7_1, true, function(arg_8_0)
			if not arg_7_0.icon then
				local var_8_0

				if var_7_0 == AttireConst.TYPE_ICON_FRAME then
					var_8_0 = IconFrame.GetIcon(var_7_1)
				elseif var_7_0 == AttireConst.TYPE_CHAT_FRAME then
					var_8_0 = ChatFrame.GetIcon(var_7_1)
				end

				PoolMgr.GetInstance():ReturnPrefab(var_8_0, var_7_1, arg_8_0)
			else
				arg_8_0.name = var_7_1

				setParent(arg_8_0, arg_7_0.icon, false)

				local var_8_1 = arg_7_1:getState() == AttireFrame.STATE_LOCK

				arg_7_2(arg_8_0)
			end

			return
		end)

		return
	end

	function var_1_0:ReturnIconFrame(arg_9_1)
		eachChild(self.icon, function(arg_10_0)
			local var_10_0 = arg_10_0.gameObject.name
			local var_10_1

			if arg_9_1 == AttireConst.TYPE_ICON_FRAME then
				var_10_1 = IconFrame.GetIcon(var_10_0)
			elseif arg_9_1 == AttireConst.TYPE_CHAT_FRAME then
				var_10_1 = ChatFrame.GetIcon(var_10_0)
			end

			assert(var_10_1)
			PoolMgr.GetInstance():ReturnPrefab(var_10_1, var_10_0, arg_10_0.gameObject)

			return
		end)

		return
	end

	function var_1_0:UpdateSelected(arg_11_1)
		setActive(self.mark, arg_11_1)

		return
	end

	function var_1_0.Dispose(arg_12_0)
		return
	end

	;(function(arg_2_0)
		arg_2_0._go = self
		arg_2_0._tf = tf(self)
		arg_2_0.mark = arg_2_0._tf:Find("info/mark")
		arg_2_0.print5 = arg_2_0._tf:Find("prints/line5")
		arg_2_0.print6 = arg_2_0._tf:Find("prints/line6")
		arg_2_0.emptyTF = arg_2_0._tf:Find("empty")
		arg_2_0.infoTF = arg_2_0._tf:Find("info")
		arg_2_0.tags = {
			arg_2_0._tf:Find("info/tags/e"),
			arg_2_0._tf:Find("info/tags/new")
		}
		arg_2_0.icon = arg_2_0._tf:Find("info/icon")
		arg_2_0.mask = arg_2_0._tf:Find("info/mask")

		return
	end)(var_1_0)

	return var_1_0
end

function AttireFramePanel:getUIName()
	assert(false)

	return
end

function AttireFramePanel:GetData()
	assert(false)

	return
end

function AttireFramePanel:OnInit()
	self.listPanel = self._tf:Find("list_panel")
	self.scolrect = self.listPanel:Find("scrollrect"):GetComponent("LScrollRect")

	function self.scolrect.onInitItem(arg_16_0)
		self:OnInitItem(arg_16_0)

		return
	end

	function self.scolrect.onUpdateItem(arg_17_0, arg_17_1)
		self:OnUpdateItem(arg_17_0, arg_17_1)

		return
	end

	function self.scolrect.onReturnItem(arg_18_0, arg_18_1)
		self:OnReturnItem(arg_18_0, arg_18_1)

		return
	end

	self.cards = {}
	self.descPanel = AttireDescPanel.New((self._tf:Find("desc_panel")))
	self.totalCount = self._tf:Find("total_count/Text"):GetComponent(typeof(Text))

	return
end

function AttireFramePanel:OnInitItem(arg_19_1)
	assert(false)

	return
end

function AttireFramePanel:OnUpdateItem(arg_20_1, arg_20_2)
	local var_20_0 = self.cards[arg_20_2]
	local var_20_2
	local var_20_1

	if not self.cards[arg_20_2] then
		self:OnInitItem(arg_20_2)

		var_20_0 = self.cards[arg_20_2]
		var_20_1 = self.scolrect.content:GetComponent(typeof(GridLayoutGroup))
		var_20_2 = arg_20_1 < var_20_1.constraintCount
	end

	var_20_0:Update(self.displayVOs[arg_20_1 + 1], self.playerVO, var_20_2, arg_20_1, var_20_1.constraintCount)

	return
end

function AttireFramePanel:OnReturnItem(arg_21_1, arg_21_2)
	return
end

function AttireFramePanel:Update(arg_22_1, arg_22_2)
	self.playerVO = arg_22_2
	self.rawAttireVOs = arg_22_1

	local var_22_0, var_22_1 = self:GetDisplayVOs()

	self.displayVOs = var_22_0

	self:Filter()

	self.totalCount.text = var_22_1

	return
end

function AttireFramePanel:GetDisplayVOs()
	local var_23_0 = {}
	local var_23_1 = 0

	for iter_23_0, iter_23_1 in pairs(self:GetData()) do
		table.insert(var_23_0, iter_23_1)

		if iter_23_1:getState() == AttireFrame.STATE_UNLOCK and iter_23_1.id > 0 then
			var_23_1 = var_23_1 + 1
		end
	end

	return var_23_0, var_23_1
end

function AttireFramePanel:Filter()
	if #self.displayVOs == 0 then
		return
	end

	local var_24_0 = self.playerVO:getAttireByType(self.displayVOs[1]:getType())

	table.sort(self.displayVOs, function(arg_25_0, arg_25_1)
		local var_25_0 = var_24_0 == arg_25_1.id and 1 or 0

		if (var_24_0 == arg_25_0.id and 1 or 0) == 1 then
			return true
		elseif var_25_0 == 1 then
			return false
		end

		local var_25_1 = arg_25_0:getState()
		local var_25_2 = arg_25_1:getState()

		if var_25_1 == var_25_2 then
			return arg_25_0.id < arg_25_1.id
		else
			return var_25_2 < var_25_1
		end

		return
	end)

	local var_24_1 = self.scolrect.content:GetComponent(typeof(GridLayoutGroup)).constraintCount
	local var_24_2 = var_24_1 - #self.displayVOs % var_24_1

	if var_24_2 == var_24_1 then
		var_24_2 = 0
	end

	local var_24_3 = var_24_1 * self:GetColumn()

	if var_24_3 > #self.displayVOs then
		var_24_2 = var_24_3 - #self.displayVOs
	end

	for iter_24_0 = 1, var_24_2 do
		table.insert(self.displayVOs, {
			id = -1
		})
	end

	self.scolrect:SetTotalCount(#self.displayVOs, 0)

	return
end

function AttireFramePanel:UpdateDesc(arg_26_1)
	if arg_26_1:isEmpty() then
		return
	end

	self.descPanel = self.descPanel or AttireDescPanel.New(self.descPanelTF)

	self.descPanel:Update(arg_26_1.attireFrame, self.playerVO)
	onButton(self, self.descPanel.applyBtn, function()
		self:emit(AttireMediator.ON_APPLY, arg_26_1.attireFrame:getType(), arg_26_1.attireFrame.id)

		return
	end, SFX_PANEL)

	return
end

function AttireFramePanel:OnDestroy()
	self.descPanel:Dispose()

	return
end

return AttireFramePanel
