local WSMapLeft = class("WSMapLeft", import("...BaseEntity"))

WSMapLeft.Fields = {
	map = "table",
	rtShip = "userdata",
	rtArrow = "userdata",
	delayCallFuncs = "table",
	toggles = "table",
	rtFleet = "userdata",
	rtAmmo = "userdata",
	toggleSelected = "userdata",
	onAgonyClick = "function",
	rtSubBar = "userdata",
	btnCollapse = "userdata",
	rtFleetBar = "userdata",
	toggleMask = "userdata",
	rtBG = "userdata",
	fleet = "table",
	transform = "userdata",
	onAgonyClickEnabled = "boolean",
	world = "table",
	rtVanguard = "userdata",
	rtSalvageList = "userdata",
	toggleList = "userdata",
	onLongPress = "function",
	onClickSalvage = "function",
	rtMain = "userdata"
}
WSMapLeft.Listeners = {
	onUpdateShipHpRate = "OnUpdateShipHpRate",
	onUpdateFleetOrder = "OnUpdateFleetOrder",
	onUpdateFleetBar = "OnUpdateFleetBar",
	onUpdateCatSalvage = "OnUpdateCatSalvage",
	onUpdateShipBroken = "OnUpdateShipBroken",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}
WSMapLeft.EventSelectFleet = "WSMapLeft.EventSelectFleet"

function WSMapLeft:Setup()
	pg.DelegateInfo.New(self)

	self.delayCallFuncs = {}

	self:Init()
	self:AddWorldListener()
	self:UpdateAllCatSalvage()

	return
end

function WSMapLeft:Dispose()
	local function var_2_0(arg_3_0)
		LeanTween.cancel(go(arg_3_0))
		LeanTween.cancel(go(arg_3_0:Find("text")))

		return
	end

	eachChild(self.rtMain, function(arg_4_0)
		local var_4_0 = arg_4_0:Find("HP_POP")

		var_2_0(var_4_0:Find("heal"))
		var_2_0(var_4_0:Find("normal"))

		return
	end)
	eachChild(self.rtVanguard, function(arg_5_0)
		local var_5_0 = arg_5_0:Find("HP_POP")

		var_2_0(var_5_0:Find("heal"))
		var_2_0(var_5_0:Find("normal"))

		return
	end)
	self:RemoveWorldListener()
	self:RemoveFleetListener(self.fleet)
	self:RemoveMapListener()
	pg.DelegateInfo.Dispose(self)
	self:Clear()

	return
end

function WSMapLeft:Init()
	self.rtBG = self.transform:Find("bg")
	self.rtFleet = self.rtBG:Find("fleet")
	self.rtMain = self.rtFleet:Find("main")
	self.rtVanguard = self.rtFleet:Find("vanguard")
	self.rtShip = self.rtFleet:Find("shiptpl")
	self.btnCollapse = self.rtBG:Find("collapse")
	self.rtArrow = self.btnCollapse:Find("arrow")
	self.rtFleetBar = self.transform:Find("other/fleet_bar")
	self.toggleMask = self.transform:Find("mask")
	self.toggleList = self.toggleMask:Find("list")
	self.toggles = {}

	for iter_6_0 = 0, self.toggleList.childCount - 1 do
		table.insert(self.toggles, self.toggleList:GetChild(iter_6_0))
	end

	self.rtSubBar = self.transform:Find("other/sub_bar")
	self.rtAmmo = self.rtSubBar:Find("text")
	self.rtSalvageList = self.transform:Find("other/salvage_list")

	setActive(self.rtShip, false)
	setActive(self.toggleMask, false)
	setActive(self.rtSubBar, false)
	onButton(self, self.btnCollapse, function()
		self:Collpase()

		return
	end, SFX_PANEL)
	onButton(self, self.rtFleetBar, function()
		self:ShowToggleMask(function(arg_9_0)
			self:DispatchEvent(WSMapLeft.EventSelectFleet, arg_9_0)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.toggleMask, function()
		self:HideToggleMask()

		return
	end, SFX_PANEL)

	return
end

function WSMapLeft:AddWorldListener()
	underscore.each(nowWorld():GetNormalFleets(), function(arg_12_0)
		arg_12_0:AddListener(WorldMapFleet.EventUpdateCatSalvage, self.onUpdateCatSalvage)

		return
	end)

	return
end

function WSMapLeft:RemoveWorldListener()
	underscore.each(nowWorld():GetNormalFleets(), function(arg_14_0)
		arg_14_0:RemoveListener(WorldMapFleet.EventUpdateCatSalvage, self.onUpdateCatSalvage)

		return
	end)

	return
end

function WSMapLeft:UpdateMap(arg_15_1)
	self:RemoveMapListener()

	self.map = arg_15_1

	self:AddMapListener()
	self:OnUpdateSelectedFleet()
	self:OnUpdateSubmarineSupport()

	return
end

function WSMapLeft:AddMapListener()
	if self.map then
		self.map:AddListener(WorldMap.EventUpdateFIndex, self.onUpdateSelectedFleet)
	end

	return
end

function WSMapLeft:RemoveMapListener()
	if self.map then
		self.map:RemoveListener(WorldMap.EventUpdateFIndex, self.onUpdateSelectedFleet)
	end

	return
end

function WSMapLeft:AddFleetListener(arg_18_1)
	if arg_18_1 then
		arg_18_1:AddListener(WorldMapFleet.EventUpdateShipOrder, self.onUpdateFleetOrder)
		arg_18_1:AddListener(WorldMapFleet.EventUpdateBuff, self.onUpdateFleetBar)
		_.each(arg_18_1:GetShips(true), function(arg_19_0)
			arg_19_0:AddListener(WorldMapShip.EventHpRantChange, self.onUpdateShipHpRate)
			arg_19_0:AddListener(WorldMapShip.EventUpdateBroken, self.onUpdateShipBroken)

			return
		end)
	end

	return
end

function WSMapLeft:RemoveFleetListener(arg_20_1)
	if arg_20_1 then
		arg_20_1:RemoveListener(WorldMapFleet.EventUpdateShipOrder, self.onUpdateFleetOrder)
		arg_20_1:RemoveListener(WorldMapFleet.EventUpdateBuff, self.onUpdateFleetBar)
		_.each(arg_20_1:GetShips(true), function(arg_21_0)
			arg_21_0:RemoveListener(WorldMapShip.EventHpRantChange, self.onUpdateShipHpRate)
			arg_21_0:RemoveListener(WorldMapShip.EventUpdateBroken, self.onUpdateShipBroken)

			return
		end)
	end

	return
end

function WSMapLeft:OnUpdateSelectedFleet()
	local var_22_0 = self.map:GetFleet()

	if self.fleet ~= var_22_0 then
		self:RemoveFleetListener(self.fleet)

		self.fleet = var_22_0

		self:AddFleetListener(self.fleet)

		self.delayCallFuncs = {}

		self:UpdateShipList(self.rtMain, self.fleet:GetTeamShips(TeamType.Main, true))
		self:UpdateShipList(self.rtVanguard, self.fleet:GetTeamShips(TeamType.Vanguard, true))
		setImageSprite(self.rtFleetBar:Find("text_selected/x"), getImageSprite(self.toggles[var_22_0.index]:Find("text_selected/x")))
		self:OnUpdateFleetBar(nil, var_22_0)
	end

	return
end

function WSMapLeft:UpdateAllCatSalvage()
	local var_23_0 = nowWorld():GetNormalFleets()
	local var_23_1 = self.rtSalvageList:GetChild(0)

	for iter_23_0 = self.rtSalvageList.childCount + 1, #var_23_0 do
		cloneTplTo(var_23_1, self.rtSalvageList, var_23_1.name)
	end

	for iter_23_1 = #var_23_0 + 1, self.rtSalvageList.childCount do
		setActive(self.rtSalvageList:GetChild(iter_23_1 - 1), false)
	end

	underscore.each(var_23_0, function(arg_24_0)
		self:OnUpdateCatSalvage(nil, arg_24_0)

		return
	end)

	return
end

function WSMapLeft:OnUpdateCatSalvage(arg_25_1, arg_25_2)
	local var_25_0 = arg_25_2:IsCatSalvage()
	local var_25_1 = self.rtSalvageList:GetChild(arg_25_2.index - 1)

	setActive(var_25_1, var_25_0)

	if var_25_0 then
		GetImageSpriteFromAtlasAsync("commandericon/" .. arg_25_2:GetDisplayCommander():getPainting(), "", var_25_1:Find("icon"))
		setActive(var_25_1:Find("rarity"), arg_25_2:GetRarityState() > 0)
		setActive(var_25_1:Find("doing"), arg_25_2.catSalvageStep < #arg_25_2.catSalvageList)
		setSlider(var_25_1:Find("doing/Slider"), 0, #arg_25_2.catSalvageList, arg_25_2.catSalvageStep)
		setActive(var_25_1:Find("finish"), arg_25_2.catSalvageStep == #arg_25_2.catSalvageList)
	end

	onButton(self, var_25_1, function()
		self.onClickSalvage(arg_25_2.id)

		return
	end, SFX_PANEL)

	return
end

function WSMapLeft:OnUpdateSubmarineSupport()
	local var_27_0 = nowWorld()

	setActive(self.rtSubBar, var_27_0:IsSubmarineSupporting())

	local var_27_1 = var_27_0:GetSubmarineFleet()

	if var_27_1 then
		local var_27_2, var_27_3 = var_27_1:GetAmmo()

		setText(self.rtAmmo, var_27_2 .. "/" .. var_27_3)
		setGray(self.rtSubBar, var_27_1:GetAmmo() <= 0, true)
	end

	return
end

function WSMapLeft:OnUpdateFleetOrder()
	self.delayCallFuncs = {}

	self:UpdateShipList(self.rtMain, self.fleet:GetTeamShips(TeamType.Main, true))
	self:UpdateShipList(self.rtVanguard, self.fleet:GetTeamShips(TeamType.Vanguard, true))

	return
end

function WSMapLeft:GetShipObject(arg_29_1)
	for iter_29_0, iter_29_1 in pairs({
		[TeamType.Main] = self.rtMain,
		[TeamType.Vanguard] = self.rtVanguard
	}) do
		for iter_29_2, iter_29_3 in ipairs((self.fleet:GetTeamShips(iter_29_0, true))) do
			if arg_29_1.id == iter_29_3.id then
				return iter_29_1:GetChild(iter_29_2 - 1)
			end
		end
	end

	return
end

function WSMapLeft:OnUpdateShipHpRate(arg_30_1, arg_30_2)
	local var_30_0 = self:GetShipObject(arg_30_2)

	assert(var_30_0, "can not find this ship in display fleet: " .. arg_30_2.id)
	table.insert(self.delayCallFuncs[arg_30_2.id], function()
		self:ShipDamageDisplay(arg_30_2, var_30_0, true)

		return
	end)

	if not self.delayCallFuncs[arg_30_2.id].isDoing then
		table.remove(self.delayCallFuncs[arg_30_2.id], 1)()
	end

	return
end

function WSMapLeft:OnUpdateShipBroken(arg_32_1, arg_32_2)
	setActive(self:GetShipObject(arg_32_2):Find("broken"), arg_32_2:IsBroken())

	return
end

function WSMapLeft:OnUpdateFleetBar(arg_33_1, arg_33_2)
	local var_33_0 = arg_33_2:GetWatchingBuff()

	setActive(self.rtFleetBar:Find("watching_buff"), var_33_0)

	if var_33_0 then
		if #var_33_0.config.icon > 0 then
			GetImageSpriteFromAtlasAsync("world/watchingbuff/" .. var_33_0.config.icon, "", self.rtFleetBar:Find("watching_buff"))
		else
			setImageSprite(self.rtFleetBar:Find("watching_buff"), nil)
		end
	end

	return
end

function WSMapLeft:UpdateShipList(arg_34_1, arg_34_2)
	local var_34_0 = UIItemList.New(arg_34_1, self.rtShip)

	var_34_0:make(function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_0 == UIItemList.EventUpdate then
			local var_35_0 = arg_34_2[arg_35_1 + 1]

			updateShip(arg_35_2, WorldConst.FetchShipVO(arg_34_2[arg_35_1 + 1].id))
			onButton(self, arg_35_2:Find("agony"), function()
				if self.onAgonyClickEnabled then
					self.onAgonyClick()
				end

				return
			end, SFX_PANEL)

			self.delayCallFuncs[arg_34_2[arg_35_1 + 1].id] = {}

			self:ShipDamageDisplay(arg_34_2[arg_35_1 + 1], arg_35_2)

			local var_35_1 = GetOrAddComponent(arg_35_2, "UILongPressTrigger").onLongPressed

			pg.DelegateInfo.Add(self, var_35_1)
			var_35_1:RemoveAllListeners()
			var_35_1:AddListener(function()
				self.onLongPress(var_35_0)

				return
			end)
		end

		return
	end)
	var_34_0:align(#arg_34_2)

	return
end

function WSMapLeft:ShipDamageDisplay(arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_2:Find("HP_POP")

	setActive(var_38_0, true)
	setActive(var_38_0:Find("heal"), false)
	setActive(var_38_0:Find("normal"), false)

	local var_38_1 = arg_38_2:Find("blood")

	if arg_38_3 then
		local var_38_2 = calcFloor((arg_38_1.hpRant - var_38_1:GetComponent(typeof(Slider)).value) / 16 * WorldConst.FetchShipVO(arg_38_1.id):getShipProperties()[AttributeType.Durability])

		local function var_38_3(arg_39_0, arg_39_1)
			setActive(arg_39_0, true)
			setText(findTF(arg_39_0, "text"), arg_39_1)
			setTextAlpha(findTF(arg_39_0, "text"), 0)

			self.delayCallFuncs[arg_38_1.id].isDoing = true

			parallelAsync({
				function(arg_40_0)
					LeanTween.moveY(arg_39_0, 60, 1):setOnComplete(System.Action(arg_40_0))

					return
				end,
				function(arg_41_0)
					LeanTween.textAlpha(findTF(arg_39_0, "text"), 1, 0.3):setOnComplete(System.Action(function()
						LeanTween.textAlpha(findTF(arg_39_0, "text"), 0, 0.5):setDelay(0.4):setOnComplete(System.Action(arg_41_0))

						return
					end))

					return
				end
			}, function()
				arg_39_0.localPosition = Vector3(0, 0, 0)

				if not self.delayCallFuncs[arg_38_1.id] then
					return
				end

				self.delayCallFuncs[arg_38_1.id].isDoing = false

				if #self.delayCallFuncs[arg_38_1.id] > 0 then
					table.remove(self.delayCallFuncs[arg_38_1.id], 1)()
				end

				return
			end)

			return
		end

		if var_38_2 > 0 then
			var_38_3(findTF(var_38_0, "heal"), var_38_2)
		elseif var_38_2 < 0 then
			(function(arg_44_0)
				LeanTween.moveX(arg_44_0, arg_44_0.transform.localPosition.x, 0.05):setEase(LeanTweenType.easeInOutSine):setLoopPingPong(4)
				LeanTween.alpha(findTF(arg_44_0, "red"), 0.5, 0.4)
				LeanTween.alpha(findTF(arg_44_0, "red"), 0, 0.4):setDelay(0.4)

				return
			end)(arg_38_2)
			var_38_3(findTF(var_38_0, "normal"), var_38_2)
		end
	end

	local var_38_4 = var_38_1:Find("fillarea/green")
	local var_38_5 = var_38_1:Find("fillarea/red")
	local var_38_6 = not arg_38_1:IsHpSafe()

	setActive(var_38_4, not var_38_6)
	setActive(var_38_5, var_38_6)

	var_38_1:GetComponent(typeof(Slider)).fillRect = var_38_6 and var_38_5 or var_38_4

	setSlider(var_38_1, 0, 10000, arg_38_1.hpRant)
	setActive(arg_38_2:Find("agony"), var_38_6)
	setActive(arg_38_2:Find("broken"), arg_38_1:IsBroken())

	return
end

function WSMapLeft:ShowToggleMask(arg_45_1)
	self.toggleList.position.x = self.rtFleetBar.position.x
	self.toggleList.position = self.toggleList.position

	setActive(self.toggleMask, true)

	local var_45_0 = self.map:GetNormalFleets()

	for iter_45_0, iter_45_1 in ipairs(self.toggles) do
		local var_45_1 = var_45_0[iter_45_0]

		setActive(iter_45_1, var_45_0[iter_45_0])

		if var_45_1 then
			local var_45_2 = iter_45_0 == self.map.findex
			local var_45_3 = var_45_1:GetWatchingBuff()

			setActive(iter_45_1:Find("selected"), iter_45_0 == self.map.findex)
			setActive(iter_45_1:Find("text"), not var_45_2)
			setActive(iter_45_1:Find("text_selected"), var_45_2)
			setActive(iter_45_1:Find("watching_buff"), var_45_3)

			if var_45_3 then
				if #var_45_3.config.icon > 0 then
					GetImageSpriteFromAtlasAsync("world/watchingbuff/" .. var_45_3.config.icon, "", iter_45_1:Find("watching_buff"))
				else
					setImageSprite(iter_45_1:Find("watching_buff"), nil)
				end
			end

			onButton(self, iter_45_1, function()
				self:HideToggleMask()
				arg_45_1(var_45_1)

				return
			end, SFX_UI_TAG)
		end
	end

	return
end

function WSMapLeft:HideToggleMask()
	setActive(self.toggleMask, false)

	return
end

function WSMapLeft:Collpase()
	setActive(self.rtFleet, not isActive(self.rtFleet))

	self.rtArrow.localScale.x = -self.rtArrow.localScale.x
	self.rtArrow.localScale = self.rtArrow.localScale

	return
end

return WSMapLeft
