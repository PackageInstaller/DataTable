local var_0_0 = class("IslandTechnologyPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandTechnologyUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.rtTop = arg_2_0._tf:Find("top")

	setText(arg_2_0.rtTop:Find("title/Text"), i18n("island_technology_title"))

	arg_2_0.centreToggleTF = arg_2_0._tf:Find("adapt/types/1")
	arg_2_0.centreTipTF = arg_2_0.centreToggleTF:Find("tip")

	local var_2_0 = arg_2_0._tf:Find("adapt/types/content")

	arg_2_0.typeUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	local var_2_1 = arg_2_0._tf:Find("adapt/pages")

	arg_2_0.pages = {}

	local var_2_2 = setmetatable({
		onItemClick = function(arg_3_0, arg_3_1)
			arg_2_0.detailPanel:ExecuteAction("Show", arg_3_0, arg_3_1)

			return
		end
	}, {
		__index = arg_2_0.contextData
	})

	arg_2_0.pages[IslandTechBelong.CENTRE] = IslandTechCentrePanel.New(var_2_1, arg_2_0.event, var_2_2)

	for iter_2_0, iter_2_1 in ipairs(IslandTechBelong.COMMON_SHOW_TYPES) do
		arg_2_0.pages[iter_2_1] = IslandTechTreePanel.New(var_2_1, arg_2_0.event, setmetatable({
			type = iter_2_1
		}, {
			__index = var_2_2
		}))
	end

	arg_2_0.quickPanel = IslandTechQuickPanel.New(arg_2_0._tf, arg_2_0.event, setmetatable({
		onGetAwardDone = function(arg_4_0)
			arg_2_0:OpenPage(IslandTechAwardPage, arg_4_0)

			return
		end
	}, {
		__index = arg_2_0.contextData
	}))

	arg_2_0.quickPanel:RegisterView(arg_2_0.viewComponent)

	arg_2_0.detailPanel = IslandTechDetailPanel.New(arg_2_0._tf, arg_2_0.event, setmetatable({
		onSelecteShip = function(arg_5_0)
			arg_2_0:OpenPage(IslandShipSelectPage, {
				needWorkSpeed = true,
				showType = IslandSelectShipCard.SHOW_TYPE.PlACE,
				attrType = pg.island_formula[arg_5_0].attribute,
				confirmFunc = function(arg_6_0)
					arg_2_0.detailPanel:ExecuteAction("OnShipSelected", arg_6_0[1])

					return
				end,
				placeId = IslandProductConst.TechnologyPlaceId,
				energyCost = pg.island_formula[arg_5_0].stamina_cost
			})

			return
		end,
		onFinishImmd = function(arg_7_0)
			arg_2_0:emit(IslandMediator.ON_FINISH_TECH_IMMD, arg_7_0, function()
				arg_2_0:OpenPage(IslandTechAwardPage, arg_7_0)

				return
			end)

			return
		end,
		onGetAwardDone = function(arg_9_0)
			arg_2_0:OpenPage(IslandTechAwardPage, arg_9_0)

			return
		end,
		openTicketPage = function(arg_10_0)
			arg_2_0:OpenPage(IslandTicketUsePage, IslandUseTicketCommand.TYPES.APPOINT, arg_10_0)

			return
		end,
		ShowMsgBox = function(arg_11_0, arg_11_1)
			arg_2_0:ShowMsgBox(arg_11_1)

			return
		end
	}, {
		__index = arg_2_0.contextData
	}))

	arg_2_0.detailPanel:RegisterView(arg_2_0.viewComponent)

	return
end

function var_0_0.OnInit(arg_12_0)
	onButton(arg_12_0, arg_12_0.rtTop:Find("title/help"), function()
		arg_12_0:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = i18n("island_helpbtn_technology")
		})

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.rtTop:Find("back"), function()
		arg_12_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.rtTop:Find("home"), function()
		arg_12_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	onToggle(arg_12_0, arg_12_0.centreToggleTF, function(arg_16_0)
		if arg_16_0 and arg_12_0.curPage ~= IslandTechBelong.CENTRE then
			arg_12_0.curPage = IslandTechBelong.CENTRE

			arg_12_0:SwitchPage()
		end

		return
	end, SFX_PANEL)

	arg_12_0.commonTypes = IslandTechBelong.COMMON_SHOW_TYPES

	arg_12_0.typeUIList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventInit then
			arg_12_0:InitTypeItem(arg_17_1, arg_17_2)
		elseif arg_17_0 == UIItemList.EventUpdate then
			arg_12_0:UpdateTypeItem(arg_17_1, arg_17_2)
		end

		return
	end)

	return
end

function var_0_0.AddListeners(arg_18_0)
	arg_18_0:AddListener(GAME.ISLAND_UNLOCK_TECH_DONE, arg_18_0.Flush)
	arg_18_0:AddListener(GAME.ISLAND_START_DELEGATION_DONE, arg_18_0.Flush)
	arg_18_0:AddListener(GAME.ISLAND_FINISH_TECH_IMMD_DONE, arg_18_0.CheckAutoUnlock)
	arg_18_0:AddListener(GAME.ISLAND_FINISH_DELEGATION_DONE, arg_18_0.Flush)
	arg_18_0:AddListener(GAME.ISLAND_GET_DELEGATION_AWARD_DONE, arg_18_0.CheckAutoUnlock)

	return
end

function var_0_0.RemoveListeners(arg_19_0)
	arg_19_0:RemoveListener(GAME.ISLAND_UNLOCK_TECH_DONE, arg_19_0.Flush)
	arg_19_0:RemoveListener(GAME.ISLAND_START_DELEGATION_DONE, arg_19_0.Flush)
	arg_19_0:RemoveListener(GAME.ISLAND_FINISH_TECH_IMMD_DONE, arg_19_0.CheckAutoUnlock)
	arg_19_0:RemoveListener(GAME.ISLAND_FINISH_DELEGATION_DONE, arg_19_0.Flush)
	arg_19_0:RemoveListener(GAME.ISLAND_GET_DELEGATION_AWARD_DONE, arg_19_0.CheckAutoUnlock)

	return
end

function var_0_0.InitTypeItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.commonTypes[arg_20_1 + 1]

	arg_20_2.name = arg_20_0.commonTypes[arg_20_1 + 1]

	setText(arg_20_2:Find("unsel"), IslandTechBelong.Names[arg_20_0.commonTypes[arg_20_1 + 1]])
	setText(arg_20_2:Find("sel/content/Text"), IslandTechBelong.Names[arg_20_0.commonTypes[arg_20_1 + 1]])
	LoadImageSpriteAsync("island/islandtechnology/tech_type_" .. IslandTechBelong.Fields[arg_20_0.commonTypes[arg_20_1 + 1]], arg_20_2:Find("sel/content/Image"), true)
	onToggle(arg_20_0, arg_20_2, function(arg_21_0)
		if arg_21_0 and arg_20_0.curPage ~= var_20_0 then
			arg_20_0.curPage = var_20_0

			arg_20_0:SwitchPage()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateTypeItem(arg_22_0, arg_22_1, arg_22_2)
	setActive(arg_22_2:Find("unsel/tip"), arg_22_0:IsReceiveByType(arg_22_0.commonTypes[arg_22_1 + 1]))
	setActive(arg_22_2:Find("sel/tip"), arg_22_0:IsReceiveByType(arg_22_0.commonTypes[arg_22_1 + 1]))

	return
end

function var_0_0.IsReceiveByType(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.techAgency:GetTechnologys()) do
		if iter_23_1:getConfig("tech_belong") == arg_23_1 and iter_23_1:GetStatus() == IslandTechnology.STATUS.RECEIVE then
			return true
		end
	end

	return false
end

function var_0_0.FlushCentreTip(arg_24_0)
	setActive(arg_24_0.centreTipTF, arg_24_0:IsReceiveByType(IslandTechBelong.CENTRE))

	return
end

function var_0_0.SwitchPage(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.pages) do
		if iter_25_0 == arg_25_0.curPage then
			iter_25_1:ExecuteAction("Show")
		else
			iter_25_1:ExecuteAction("Hide")
		end
	end

	return
end

function var_0_0.OnShow(arg_26_0)
	triggerToggle(arg_26_0.centreToggleTF, true)
	arg_26_0.quickPanel:ExecuteAction("Show")
	arg_26_0:CheckAutoUnlock()

	return
end

function var_0_0.CheckAutoUnlock(arg_27_0)
	getProxy(IslandProxy):GetIsland():GetTechnologyAgency():TryAutoUnlock(function()
		arg_27_0:Flush()

		return
	end)

	return
end

function var_0_0.Flush(arg_29_0)
	arg_29_0.techAgency = getProxy(IslandProxy):GetIsland():GetTechnologyAgency()

	arg_29_0.typeUIList:align(#arg_29_0.commonTypes)
	arg_29_0:FlushCentreTip()
	arg_29_0.pages[arg_29_0.curPage]:ExecuteAction("Flush")
	arg_29_0.quickPanel:ExecuteAction("Flush")

	if arg_29_0.detailPanel:isShowing() then
		arg_29_0.detailPanel:ExecuteAction("Flush")
	end

	return
end

function var_0_0.OnHide(arg_30_0)
	arg_30_0.quickPanel:ExecuteAction("Hide")
	arg_30_0.detailPanel:ExecuteAction("Hide")

	return
end

function var_0_0.OnDisable(arg_31_0)
	arg_31_0:OnHide()

	return
end

function var_0_0.OnDestroy(arg_32_0)
	if arg_32_0.quickPanel then
		arg_32_0.quickPanel:Destroy()

		arg_32_0.quickPanel = nil
	end

	if arg_32_0.detailPanel then
		arg_32_0.detailPanel:Destroy()

		arg_32_0.detailPanel = nil
	end

	for iter_32_0, iter_32_1 in pairs(arg_32_0.pages) do
		if iter_32_1 then
			iter_32_1:Destroy()

			iter_32_1 = nil
		end
	end

	return
end

return var_0_0
