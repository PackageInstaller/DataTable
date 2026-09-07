local SelectTechnologyLayer = class("SelectTechnologyLayer", import("..base.BaseUI"))

function SelectTechnologyLayer:getUIName()
	return "SelectTechnologyUI"
end

function SelectTechnologyLayer:ResUISettings()
	return true
end

function SelectTechnologyLayer:setPlayer(arg_3_1)
	self.playerVO = arg_3_1

	return
end

function SelectTechnologyLayer:init()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	self.bg = self._tf:Find("frame/bg")
	self.bluePrintBtn = self.bg:Find("blueprint_btn")
	self.bluePrintBtnTip = self.bluePrintBtn:Find("tip")
	self.technologyBtn = self.bg:Find("technology_btn")
	self.technologyBtnTip = self.technologyBtn:Find("tip")
	self.fleetBtn = self.bg:Find("fleet_btn")
	self.fleetBtnTip = self.fleetBtn:Find("tip")
	self.transformBtn = self.bg:Find("transform_btn")
	self.transformBtnTip = self.transformBtn:Find("tip")

	setActive(self.transformBtn, not LOCK_EQUIPMENT_TRANSFORM)

	self.metaBtn = self.bg:Find("meta_btn")
	self.metaBtnTip = self.metaBtn:Find("tip")

	setActive(self.metaBtn, true)

	self.helpBtn = self._tf:Find("help_btn")
	self.lockedTpl = self._tf:Find("lockedTpl")
	self.backBtn = self._tf:Find("blur_panel/adapt/top/back")

	if not OPEN_TEC_TREE_SYSTEM then
		setActive(self.fleetBtn, false)
	end

	return
end

function SelectTechnologyLayer:didEnter()
	self:checkSystemOpen("ShipBluePrintMediator", self.bluePrintBtn)
	self:checkSystemOpen("TechnologyMediator", self.technologyBtn)
	self:checkSystemOpen("EquipmentTransformTreeMediator", self.transformBtn)
	self:checkSystemOpen("MetaCharacterMediator", self.metaBtn)
	onButton(self, self.fleetBtn, function()
		self:emit(TechnologyConst.OPEN_TECHNOLOGY_TREE_SCENE)

		return
	end, SFX_PANEL)
	onButton(self, self.bluePrintBtn, function()
		self:emit(SelectTechnologyMediator.ON_BLUEPRINT)

		return
	end, SFX_PANEL)
	onButton(self, self.technologyBtn, function()
		self:emit(SelectTechnologyMediator.ON_TECHNOLOGY)

		return
	end, SFX_PANEL)
	onButton(self, self.transformBtn, function()
		self:emit(SelectTechnologyMediator.ON_TRANSFORM_EQUIPMENT)

		return
	end, SFX_PANEL)
	onButton(self, self.metaBtn, function()
		if isActive(self.metaBtn:Find("word")) then
			self:emit(SelectTechnologyMediator.ON_META)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("meta_sys_lock_tip"))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:emit(SelectTechnologyLayer.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		local var_12_0 = pg.SystemOpenMgr.GetInstance():isOpenSystem(self.playerVO.level, "ShipBluePrintMediator") and "help_technolog" or "help_technolog0"

		if pg.gametip[var_12_0] then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip[var_12_0].tip
			})
		end

		return
	end, SFX_PANEL)

	return
end

function SelectTechnologyLayer:checkSystemOpen(arg_13_1, arg_13_2)
	if arg_13_1 == "MetaCharacterMediator" then
		local var_13_0 = true

		setActive(arg_13_2:Find("word"), true)
		setGray(arg_13_2, not var_13_0)

		arg_13_2:GetComponent(typeof(Image)).color = Color.New(1, 1, 1, var_13_0 and 1 or 0.7)

		local var_13_1 = arg_13_2:Find("locked")

		if var_13_1 then
			setActive(var_13_1, false)
		end

		if not var_13_0 then
			if IsNil(var_13_1) then
				var_13_1 = cloneTplTo(self.lockedTpl, arg_13_2)
				var_13_1.localPosition = Vector3.zero
			end

			setActive(var_13_1, true)
		end

		return
	end

	local var_13_2 = pg.SystemOpenMgr.GetInstance():isOpenSystem(self.playerVO.level, arg_13_1)

	setActive(arg_13_2:Find("word"), var_13_2)
	setGray(arg_13_2, not var_13_2)

	arg_13_2:GetComponent(typeof(Image)).color = Color.New(1, 1, 1, var_13_2 and 1 or 0.7)

	local var_13_3 = arg_13_2:Find("locked")

	if var_13_3 then
		setActive(var_13_3, false)
	end

	if not var_13_2 then
		if IsNil(var_13_3) then
			var_13_3 = cloneTplTo(self.lockedTpl, arg_13_2)
			var_13_3.localPosition = Vector3.zero
		end

		setActive(var_13_3, true)
	end

	return
end

function SelectTechnologyLayer:notifyTechnology(arg_14_1)
	setActive(self.technologyBtnTip, arg_14_1)

	return
end

function SelectTechnologyLayer:notifyBlueprint(arg_15_1)
	setActive(self.bluePrintBtnTip, arg_15_1)

	return
end

function SelectTechnologyLayer:notifyFleet(arg_16_1)
	setActive(self.fleetBtnTip, arg_16_1)

	return
end

function SelectTechnologyLayer:notifyTransform(arg_17_1)
	setActive(self.transformBtnTip, arg_17_1)

	return
end

function SelectTechnologyLayer:notifyMeta(arg_18_1)
	setActive(self.metaBtnTip, arg_18_1)

	return
end

function SelectTechnologyLayer:willExit()
	return
end

return SelectTechnologyLayer
