local var_0_0 = class("WSMapLeft", import("...BaseEntity"))

var_0_0.Fields = {
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
var_0_0.Listeners = {
	onUpdateShipHpRate = "OnUpdateShipHpRate",
	onUpdateFleetOrder = "OnUpdateFleetOrder",
	onUpdateFleetBar = "OnUpdateFleetBar",
	onUpdateCatSalvage = "OnUpdateCatSalvage",
	onUpdateShipBroken = "OnUpdateShipBroken",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}
var_0_0.EventSelectFleet = "WSMapLeft.EventSelectFleet"

function var_0_0.Setup(arg_1_0)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.delayCallFuncs = {}

	arg_1_0:Init()
	arg_1_0:AddWorldListener()
	arg_1_0:UpdateAllCatSalvage()

	return
end

function var_0_0.Dispose(arg_2_0)
	local function var_2_0(arg_3_0)
		LeanTween.cancel(go(arg_3_0))
		LeanTween.cancel(go(arg_3_0:Find("text")))

		return
	end

	eachChild(arg_2_0.rtMain, function(arg_4_0)
		local var_4_0 = arg_4_0:Find("HP_POP")

		var_2_0(var_4_0:Find("heal"))
		var_2_0(var_4_0:Find("normal"))

		return
	end)
	eachChild(arg_2_0.rtVanguard, function(arg_5_0)
		local var_5_0 = arg_5_0:Find("HP_POP")

		var_2_0(var_5_0:Find("heal"))
		var_2_0(var_5_0:Find("normal"))

		return
	end)
	arg_2_0:RemoveWorldListener()
	arg_2_0:RemoveFleetListener(arg_2_0.fleet)
	arg_2_0:RemoveMapListener()
	pg.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_0.Init(arg_6_0)
	arg_6_0.rtBG = arg_6_0.transform:Find("bg")
	arg_6_0.rtFleet = arg_6_0.rtBG:Find("fleet")
	arg_6_0.rtMain = arg_6_0.rtFleet:Find("main")
	arg_6_0.rtVanguard = arg_6_0.rtFleet:Find("vanguard")
	arg_6_0.rtShip = arg_6_0.rtFleet:Find("shiptpl")
	arg_6_0.btnCollapse = arg_6_0.rtBG:Find("collapse")
	arg_6_0.rtArrow = arg_6_0.btnCollapse:Find("arrow")
	arg_6_0.rtFleetBar = arg_6_0.transform:Find("other/fleet_bar")
	arg_6_0.toggleMask = arg_6_0.transform:Find("mask")
	arg_6_0.toggleList = arg_6_0.toggleMask:Find("list")
	arg_6_0.toggles = {}

	for iter_6_0 = 0, arg_6_0.toggleList.childCount - 1 do
		table.insert(arg_6_0.toggles, arg_6_0.toggleList:GetChild(iter_6_0))
	end

	arg_6_0.rtSubBar = arg_6_0.transform:Find("other/sub_bar")
	arg_6_0.rtAmmo = arg_6_0.rtSubBar:Find("text")
	arg_6_0.rtSalvageList = arg_6_0.transform:Find("other/salvage_list")

	setActive(arg_6_0.rtShip, false)
	setActive(arg_6_0.toggleMask, false)
	setActive(arg_6_0.rtSubBar, false)
	onButton(arg_6_0, arg_6_0.btnCollapse, function()
		arg_6_0:Collpase()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.rtFleetBar, function()
		arg_6_0:ShowToggleMask(function(arg_9_0)
			arg_6_0:DispatchEvent(var_0_0.EventSelectFleet, arg_9_0)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.toggleMask, function()
		arg_6_0:HideToggleMask()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.AddWorldListener(arg_11_0)
	underscore.each(nowWorld():GetNormalFleets(), function(arg_12_0)
		arg_12_0:AddListener(WorldMapFleet.EventUpdateCatSalvage, arg_11_0.onUpdateCatSalvage)

		return
	end)

	return
end

function var_0_0.RemoveWorldListener(arg_13_0)
	underscore.each(nowWorld():GetNormalFleets(), function(arg_14_0)
		arg_14_0:RemoveListener(WorldMapFleet.EventUpdateCatSalvage, arg_13_0.onUpdateCatSalvage)

		return
	end)

	return
end

function var_0_0.UpdateMap(arg_15_0, arg_15_1)
	arg_15_0:RemoveMapListener()

	arg_15_0.map = arg_15_1

	arg_15_0:AddMapListener()
	arg_15_0:OnUpdateSelectedFleet()
	arg_15_0:OnUpdateSubmarineSupport()

	return
end

function var_0_0.AddMapListener(arg_16_0)
	if arg_16_0.map then
		arg_16_0.map:AddListener(WorldMap.EventUpdateFIndex, arg_16_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_0.RemoveMapListener(arg_17_0)
	if arg_17_0.map then
		arg_17_0.map:RemoveListener(WorldMap.EventUpdateFIndex, arg_17_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_0.AddFleetListener(arg_18_0, arg_18_1)
	if arg_18_1 then
		arg_18_1:AddListener(WorldMapFleet.EventUpdateShipOrder, arg_18_0.onUpdateFleetOrder)
		arg_18_1:AddListener(WorldMapFleet.EventUpdateBuff, arg_18_0.onUpdateFleetBar)
		_.each(arg_18_1:GetShips(true), function(arg_19_0)
			arg_19_0:AddListener(WorldMapShip.EventHpRantChange, arg_18_0.onUpdateShipHpRate)
			arg_19_0:AddListener(WorldMapShip.EventUpdateBroken, arg_18_0.onUpdateShipBroken)

			return
		end)
	end

	return
end

function var_0_0.RemoveFleetListener(arg_20_0, arg_20_1)
	if arg_20_1 then
		arg_20_1:RemoveListener(WorldMapFleet.EventUpdateShipOrder, arg_20_0.onUpdateFleetOrder)
		arg_20_1:RemoveListener(WorldMapFleet.EventUpdateBuff, arg_20_0.onUpdateFleetBar)
		_.each(arg_20_1:GetShips(true), function(arg_21_0)
			arg_21_0:RemoveListener(WorldMapShip.EventHpRantChange, arg_20_0.onUpdateShipHpRate)
			arg_21_0:RemoveListener(WorldMapShip.EventUpdateBroken, arg_20_0.onUpdateShipBroken)

			return
		end)
	end

	return
end

function var_0_0.OnUpdateSelectedFleet(arg_22_0)
	local var_22_0 = arg_22_0.map:GetFleet()

	if arg_22_0.fleet ~= var_22_0 then
		arg_22_0:RemoveFleetListener(arg_22_0.fleet)

		arg_22_0.fleet = var_22_0

		arg_22_0:AddFleetListener(arg_22_0.fleet)

		arg_22_0.delayCallFuncs = {}

		arg_22_0:UpdateShipList(arg_22_0.rtMain, arg_22_0.fleet:GetTeamShips(TeamType.Main, true))
		arg_22_0:UpdateShipList(arg_22_0.rtVanguard, arg_22_0.fleet:GetTeamShips(TeamType.Vanguard, true))
		setImageSprite(arg_22_0.rtFleetBar:Find("text_selected/x"), getImageSprite(arg_22_0.toggles[var_22_0.index]:Find("text_selected/x")))
		arg_22_0:OnUpdateFleetBar(nil, var_22_0)
	end

	return
end

function var_0_0.UpdateAllCatSalvage(arg_23_0)
	local var_23_0 = nowWorld():GetNormalFleets()
	local var_23_1 = arg_23_0.rtSalvageList:GetChild(0)

	for iter_23_0 = arg_23_0.rtSalvageList.childCount + 1, #var_23_0 do
		cloneTplTo(var_23_1, arg_23_0.rtSalvageList, var_23_1.name)
	end

	for iter_23_1 = #var_23_0 + 1, arg_23_0.rtSalvageList.childCount do
		setActive(arg_23_0.rtSalvageList:GetChild(iter_23_1 - 1), false)
	end

	underscore.each(var_23_0, function(arg_24_0)
		arg_23_0:OnUpdateCatSalvage(nil, arg_24_0)

		return
	end)

	return
end

function var_0_0.OnUpdateCatSalvage(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_2:IsCatSalvage()
	local var_25_1 = arg_25_0.rtSalvageList:GetChild(arg_25_2.index - 1)

	setActive(var_25_1, var_25_0)

	if var_25_0 then
		GetImageSpriteFromAtlasAsync("commandericon/" .. arg_25_2:GetDisplayCommander():getPainting(), "", var_25_1:Find("icon"))
		setActive(var_25_1:Find("rarity"), arg_25_2:GetRarityState() > 0)
		setActive(var_25_1:Find("doing"), arg_25_2.catSalvageStep < #arg_25_2.catSalvageList)
		setSlider(var_25_1:Find("doing/Slider"), 0, #arg_25_2.catSalvageList, arg_25_2.catSalvageStep)
		setActive(var_25_1:Find("finish"), arg_25_2.catSalvageStep == #arg_25_2.catSalvageList)
	end

	onButton(arg_25_0, var_25_1, function()
		arg_25_0.onClickSalvage(arg_25_2.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateSubmarineSupport(arg_27_0)
	local var_27_0 = nowWorld()

	setActive(arg_27_0.rtSubBar, var_27_0:IsSubmarineSupporting())

	local var_27_1 = var_27_0:GetSubmarineFleet()

	if var_27_1 then
		local var_27_2, var_27_3 = var_27_1:GetAmmo()

		setText(arg_27_0.rtAmmo, var_27_2 .. "/" .. var_27_3)
		setGray(arg_27_0.rtSubBar, var_27_1:GetAmmo() <= 0, true)
	end

	return
end

function var_0_0.OnUpdateFleetOrder(arg_28_0)
	arg_28_0.delayCallFuncs = {}

	arg_28_0:UpdateShipList(arg_28_0.rtMain, arg_28_0.fleet:GetTeamShips(TeamType.Main, true))
	arg_28_0:UpdateShipList(arg_28_0.rtVanguard, arg_28_0.fleet:GetTeamShips(TeamType.Vanguard, true))

	return
end

function var_0_0.GetShipObject(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in pairs({
		[TeamType.Main] = arg_29_0.rtMain,
		[TeamType.Vanguard] = arg_29_0.rtVanguard
	}) do
		for iter_29_2, iter_29_3 in ipairs((arg_29_0.fleet:GetTeamShips(iter_29_0, true))) do
			if arg_29_1.id == iter_29_3.id then
				return iter_29_1:GetChild(iter_29_2 - 1)
			end
		end
	end

	return
end

function var_0_0.OnUpdateShipHpRate(arg_30_0, arg_30_1, arg_30_2)
	assert(arg_30_0:GetShipObject(arg_30_2), "can not find this ship in display fleet: " .. arg_30_2.id)
	table.insert(arg_30_0.delayCallFuncs[arg_30_2.id], function()
		arg_30_0:ShipDamageDisplay(arg_30_2, var_0, true)

		return
	end)

	if not arg_30_0.delayCallFuncs[arg_30_2.id].isDoing then
		table.remove(arg_30_0.delayCallFuncs[arg_30_2.id], 1)()
	end

	return
end

function var_0_0.OnUpdateShipBroken(arg_32_0, arg_32_1, arg_32_2)
	setActive(arg_32_0:GetShipObject(arg_32_2):Find("broken"), arg_32_2:IsBroken())

	return
end

function var_0_0.OnUpdateFleetBar(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_2:GetWatchingBuff()

	setActive(arg_33_0.rtFleetBar:Find("watching_buff"), var_33_0)

	if var_33_0 then
		if #var_33_0.config.icon > 0 then
			GetImageSpriteFromAtlasAsync("world/watchingbuff/" .. var_33_0.config.icon, "", arg_33_0.rtFleetBar:Find("watching_buff"))
		else
			setImageSprite(arg_33_0.rtFleetBar:Find("watching_buff"), nil)
		end
	end

	return
end

function var_0_0.UpdateShipList(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = UIItemList.New(arg_34_1, arg_34_0.rtShip)

	var_34_0:make(function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_0 == UIItemList.EventUpdate then
			local var_35_0 = arg_34_2[arg_35_1 + 1]

			updateShip(arg_35_2, WorldConst.FetchShipVO(arg_34_2[arg_35_1 + 1].id))
			onButton(arg_34_0, arg_35_2:Find("agony"), function()
				if arg_34_0.onAgonyClickEnabled then
					arg_34_0.onAgonyClick()
				end

				return
			end, SFX_PANEL)

			arg_34_0.delayCallFuncs[arg_34_2[arg_35_1 + 1].id] = {}

			arg_34_0:ShipDamageDisplay(arg_34_2[arg_35_1 + 1], arg_35_2)

			local var_35_1 = GetOrAddComponent(arg_35_2, "UILongPressTrigger").onLongPressed

			pg.DelegateInfo.Add(arg_34_0, var_35_1)
			var_35_1:RemoveAllListeners()
			var_35_1:AddListener(function()
				arg_34_0.onLongPress(var_35_0)

				return
			end)
		end

		return
	end)
	var_34_0:align(#arg_34_2)

	return
end

function var_0_0.ShipDamageDisplay(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_2:Find("HP_POP")

	setActive(var_38_0, true)
	setActive(var_38_0:Find("heal"), false)
	setActive(var_38_0:Find("normal"), false)

	local var_38_1 = arg_38_2:Find("blood")

	if arg_38_3 then
		local var_38_2 = calcFloor((arg_38_1.hpRant - var_38_1:GetComponent(typeof(Slider)).value) / 16 * WorldConst.FetchShipVO(arg_38_1.id):getShipProperties()[AttributeType.Durability])

		if var_38_2 > 0 then
			(function(arg_39_0, arg_39_1)
				setActive(arg_39_0, true)
				setText(findTF(arg_39_0, "text"), arg_39_1)
				setTextAlpha(findTF(arg_39_0, "text"), 0)

				arg_38_0.delayCallFuncs[arg_38_1.id].isDoing = true

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

					if not arg_38_0.delayCallFuncs[arg_38_1.id] then
						return
					end

					arg_38_0.delayCallFuncs[arg_38_1.id].isDoing = false

					if #arg_38_0.delayCallFuncs[arg_38_1.id] > 0 then
						table.remove(arg_38_0.delayCallFuncs[arg_38_1.id], 1)()
					end

					return
				end)

				return
			end)(findTF(var_38_0, "heal"), var_38_2)
		elseif var_38_2 < 0 then
			(function(arg_44_0)
				LeanTween.moveX(arg_44_0, arg_44_0.transform.localPosition.x, 0.05):setEase(LeanTweenType.easeInOutSine):setLoopPingPong(4)
				LeanTween.alpha(findTF(arg_44_0, "red"), 0.5, 0.4)
				LeanTween.alpha(findTF(arg_44_0, "red"), 0, 0.4):setDelay(0.4)

				return
			end)(arg_38_2)
			;(function(arg_39_0, arg_39_1)
				setActive(arg_39_0, true)
				setText(findTF(arg_39_0, "text"), arg_39_1)
				setTextAlpha(findTF(arg_39_0, "text"), 0)

				arg_38_0.delayCallFuncs[arg_38_1.id].isDoing = true

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

					if not arg_38_0.delayCallFuncs[arg_38_1.id] then
						return
					end

					arg_38_0.delayCallFuncs[arg_38_1.id].isDoing = false

					if #arg_38_0.delayCallFuncs[arg_38_1.id] > 0 then
						table.remove(arg_38_0.delayCallFuncs[arg_38_1.id], 1)()
					end

					return
				end)

				return
			end)(findTF(var_38_0, "normal"), var_38_2)
		end
	end

	local var_38_3 = var_38_1:Find("fillarea/green")
	local var_38_4 = var_38_1:Find("fillarea/red")
	local var_38_5 = not arg_38_1:IsHpSafe()

	setActive(var_38_3, not var_38_5)
	setActive(var_38_4, var_38_5)

	var_38_1:GetComponent(typeof(Slider)).fillRect = var_38_5 and var_38_4 or var_38_3

	setSlider(var_38_1, 0, 10000, arg_38_1.hpRant)
	setActive(arg_38_2:Find("agony"), var_38_5)
	setActive(arg_38_2:Find("broken"), arg_38_1:IsBroken())

	return
end

function var_0_0.ShowToggleMask(arg_45_0, arg_45_1)
	arg_45_0.toggleList.position.x = arg_45_0.rtFleetBar.position.x
	arg_45_0.toggleList.position = arg_45_0.toggleList.position

	setActive(arg_45_0.toggleMask, true)

	local var_45_0 = arg_45_0.map:GetNormalFleets()

	for iter_45_0, iter_45_1 in ipairs(arg_45_0.toggles) do
		local var_45_1 = var_45_0[iter_45_0]

		setActive(iter_45_1, var_45_0[iter_45_0])

		if var_45_1 then
			local var_45_2 = iter_45_0 == arg_45_0.map.findex
			local var_45_3 = var_45_1:GetWatchingBuff()

			setActive(iter_45_1:Find("selected"), iter_45_0 == arg_45_0.map.findex)
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

			onButton(arg_45_0, iter_45_1, function()
				arg_45_0:HideToggleMask()
				arg_45_1(var_45_1)

				return
			end, SFX_UI_TAG)
		end
	end

	return
end

function var_0_0.HideToggleMask(arg_47_0)
	setActive(arg_47_0.toggleMask, false)

	return
end

function var_0_0.Collpase(arg_48_0)
	setActive(arg_48_0.rtFleet, not isActive(arg_48_0.rtFleet))

	arg_48_0.rtArrow.localScale.x = -arg_48_0.rtArrow.localScale.x
	arg_48_0.rtArrow.localScale = arg_48_0.rtArrow.localScale

	return
end

return var_0_0
