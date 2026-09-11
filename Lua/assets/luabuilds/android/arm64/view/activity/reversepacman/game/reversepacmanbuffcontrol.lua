local ReversePacmanBuffControl = class("ReversePacmanBuffControl")
local var_0_1 = 155

function ReversePacmanBuffControl:Ctor(arg_1_1, arg_1_2)
	self.binder = arg_1_1
	self._tf = arg_1_2
	self._tpls = self._tf:Find("tpls")
	self.container = self._tf:Find("map")
	self.selectPanel = self._tf:Find("map/select")

	setActive(self.selectPanel, false)

	self.bubbleTF = self._tf:Find("map/bubble")

	setActive(self.bubbleTF, false)

	self.uiList = UIItemList.New(self._tf:Find("buffs/list"), self._tf:Find("buffs/list/tpl"))

	return
end

function ReversePacmanBuffControl:SetUp(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.map = arg_2_3
	self.gameController = arg_2_4
	self.buffIds = {}
	self.buffCntDic = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if iter_2_1 ~= 0 then
			table.insert(self.buffIds, iter_2_1)

			self.buffCntDic[iter_2_1] = arg_2_2[iter_2_0]
		end
	end

	self.uiList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			self:UpdataBuffTpl(self.buffIds[arg_3_1 + 1], arg_3_2)
		end

		return
	end)
	self.uiList:align(#self.buffIds)
	self:AddListener()

	return
end

function ReversePacmanBuffControl:AddListener()
	onButton(self.binder, self.selectPanel:Find("cancel"), function()
		self:HideSelectPanel()

		return
	end)
	onButton(self.binder, self.selectPanel:Find("ok/sure"), function()
		if not self.gameController:CanCastBuff(self.selectedId, self.selectCell) then
			return
		end

		self:CastBuff(self.selectedId, self.selectCell)
		self.binder:emit(ReversePacmanConst.EVENT.CAST, {
			buffId = self.selectedId,
			cell = self.selectCell
		})

		return
	end)
	self.binder:bind(ReversePacmanConst.EVENT.PICK, function(arg_7_0, arg_7_1)
		self:ShowBubble(arg_7_1.buff.id, (self.map:GetCellByLocalPos({
			x = arg_7_1.ship.x,
			y = arg_7_1.ship.y
		})))

		return
	end)
	self:AddDragMove()

	return
end

function ReversePacmanBuffControl:AddDragMove()
	local var_8_0 = GetOrAddComponent(self.selectPanel:Find("move"), typeof(EventTriggerListener))
	local var_8_1 = GameObject.Find("UICamera"):GetComponent(typeof(Camera))

	local function var_8_2(arg_9_0)
		local var_9_0 = LuaHelper.ScreenToLocal(self.container, arg_9_0, var_8_1)
		local var_9_1 = self.map:GetCellByLocalPos({
			x = var_9_0.x,
			y = var_9_0.y + var_0_1
		})

		if not var_9_1 then
			return
		end

		self:SetSelectCell(var_9_1)

		return
	end

	var_8_0:AddBeginDragFunc(function(arg_10_0, arg_10_1)
		var_8_2(arg_10_1.position)

		return
	end)
	var_8_0:AddDragFunc(function(arg_11_0, arg_11_1)
		var_8_2(arg_11_1.position)

		return
	end)

	return
end

function ReversePacmanBuffControl:SetSelectCell(arg_12_1)
	self.selectCell = arg_12_1

	setLocalPosition(self.selectPanel, self.map:GetLocalPosInMap(arg_12_1.x, arg_12_1.y))

	local var_12_0 = self.gameController:CanCastBuff(self.selectedId, arg_12_1)

	setActive(self.selectPanel:Find("ok"), var_12_0)
	setActive(self.selectPanel:Find("no"), not var_12_0)

	return
end

function ReversePacmanBuffControl:UpdataBuffTpl(arg_13_1, arg_13_2)
	arg_13_2.name = arg_13_1

	setText(arg_13_2:Find("name"), pg.activity_chasing_skill[arg_13_1].name)
	LoadImageSpriteAsync(pg.activity_chasing_skill[arg_13_1].icon, arg_13_2:Find("icon"))

	local var_13_0 = self.buffCntDic[arg_13_1]

	setText(arg_13_2:Find("icon/corner/Text"), self.buffCntDic[arg_13_1])
	setTextColor(arg_13_2:Find("icon/corner/Text"), var_13_0 > 0 and Color.NewHex("#FFFFFF") or Color.NewHex("#FF6D6D"))
	setTextColor(arg_13_2:Find("name"), var_13_0 > 0 and Color.NewHex("#FFFFFF") or Color.NewHex("#7C7E81"))
	onButton(self.binder, arg_13_2, function()
		if var_13_0 <= 0 then
			return
		end

		if LeanTween.isTweening(go(arg_13_2:Find("icon/mask"))) then
			return
		end

		self:ShowSelectPanel(arg_13_1)

		return
	end)

	return
end

function ReversePacmanBuffControl:ShowSelectPanel(arg_15_1)
	self.selectedId = arg_15_1

	local var_15_0 = self.selectPanel:Find("icon")

	LoadImageSpriteAtlasAsync("ui/reversepacmanui_atlas", "game_icon_buff_" .. self.selectedId, var_15_0, true)
	setImageAlpha(var_15_0, 1)
	blinkAni(go(var_15_0), 0.2)
	self:SetSelectCell(self.map:GetCenterCell())
	setActive(self.selectPanel, true)

	return
end

function ReversePacmanBuffControl:HideSelectPanel()
	setActive(self.selectPanel, false)

	local var_16_0 = self.selectPanel:Find("icon")

	if LeanTween.isTweening(go(var_16_0)) then
		LeanTween.cancel(go(var_16_0))
	end

	return
end

function ReversePacmanBuffControl:CastBuff(arg_17_1, arg_17_2)
	if arg_17_1 == ReversePacmanConst.BUFF.BLOCK then
		self:ShowBubble(arg_17_1, arg_17_2)
	end

	self:SetBuffCD(arg_17_1)
	self:HideSelectPanel()

	return
end

function ReversePacmanBuffControl:GetBubbleTip(arg_18_1)
	if arg_18_1 == ReversePacmanConst.BUFF.BLOCK then
		return i18n("reverse_pacman_cast_block")
	elseif arg_18_1 == ReversePacmanConst.BUFF.SPEED then
		return i18n("reverse_pacman_pick_speed")
	elseif arg_18_1 == ReversePacmanConst.BUFF.GIANT then
		return i18n("reverse_pacman_pick_giant")
	end

	return ""
end

function ReversePacmanBuffControl:ShowBubble(arg_19_1, arg_19_2, arg_19_3)
	if LeanTween.isTweening(go(self.bubbleTF)) then
		LeanTween.cancel(go(self.bubbleTF))
	end

	setActive(self.bubbleTF, true)
	setText(self.bubbleTF:Find("Text"), self:GetBubbleTip(arg_19_1))

	local var_19_0 = self.map:GetLocalPosInMap(arg_19_2.x, arg_19_2.y)

	setLocalPosition(self.bubbleTF, var_19_0)
	setCanvasGroupAlpha(self.bubbleTF, 1)

	local var_19_1 = self.gameController:GetGameplayDuration(1)

	LeanTween.moveLocalY(go(self.bubbleTF), var_19_0.y + 80, var_19_1):setEase(LeanTweenType.easeOutCubic)
	LeanTween.alphaCanvas(GetOrAddComponent(self.bubbleTF, typeof(CanvasGroup)), 0, var_19_1 * 0.6):setDelay(var_19_1 * 0.4):setOnComplete(System.Action(function()
		setActive(self.bubbleTF, false)

		return
	end))

	return
end

function ReversePacmanBuffControl:SetBuffCD(arg_21_1)
	self.buffCntDic[arg_21_1] = self.buffCntDic[arg_21_1] - 1

	local var_21_0 = self.uiList.container:Find(tostring(arg_21_1))

	if self.buffCntDic[arg_21_1] <= 0 then
		self:UpdataBuffTpl(arg_21_1, var_21_0)

		return
	end

	local var_21_1 = self.gameController:GetGameplayDuration(pg.activity_chasing_skill[arg_21_1].cd)
	local var_21_2 = var_21_0:Find("icon/mask")
	local var_21_3 = var_21_2:GetComponent(typeof(Image))

	setActive(var_21_2, true)
	setTextColor(var_21_0:Find("name"), Color.NewHex("#7C7E81"))
	LeanTween.value(go(var_21_2), 1, 0, var_21_1):setOnUpdate(System.Action_float(function(arg_22_0)
		var_21_3.fillAmount = arg_22_0

		return
	end)):setOnComplete(System.Action(function()
		setActive(var_21_2, false)
		self:UpdataBuffTpl(arg_21_1, var_21_0)

		return
	end))

	return
end

function ReversePacmanBuffControl:Update(arg_24_1)
	return
end

function ReversePacmanBuffControl:Dispose()
	self.uiList:eachActive(function(arg_26_0, arg_26_1)
		if LeanTween.isTweening(go(arg_26_1:Find("icon/mask"))) then
			LeanTween.cancel(go(arg_26_1:Find("icon/mask")))
		end

		return
	end)

	if LeanTween.isTweening(go(self.bubbleTF)) then
		LeanTween.cancel(go(self.bubbleTF))
	end

	return
end

return ReversePacmanBuffControl
