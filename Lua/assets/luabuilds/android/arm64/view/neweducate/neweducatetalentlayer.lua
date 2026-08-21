local var_0_0 = class("NewEducateTalentLayer", import("view.newEducate.base.NewEducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "NewEducateTalentUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.animCom = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.animEvent = arg_2_0._tf:GetComponent(typeof(DftAniEvent))

	arg_2_0.animEvent:SetTriggerEvent(function()
		arg_2_0.animEvent:SetEndEvent(nil)
		arg_2_0:RefreshView()

		return
	end)

	arg_2_0.rootTF = arg_2_0._tf:Find("root")
	arg_2_0.bgTF = arg_2_0.rootTF:Find("bg")

	local var_2_0 = arg_2_0.rootTF:Find("window/content")

	arg_2_0.uiList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	arg_2_0.uiList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_4_2.name = arg_4_1 + 1

			arg_2_0:UpdateItem(arg_2_0.talentList[arg_4_1 + 1], arg_4_2)
		end

		return
	end)

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:OverlayPanel(arg_5_0._tf, {
		groupDelta = 1,
		pbList = {
			arg_5_0.bgTF
		}
	})
	NewEducateGuideSequence.CheckGuide(arg_5_0.__cname)

	return
end

function var_0_0.GetRarityBg(arg_6_0, arg_6_1)
	return switch(arg_6_1, {
		[NewEducateBuff.RARITY.BLUE] = function()
			return "bg_blue"
		end,
		[NewEducateBuff.RARITY.PURPLE] = function()
			return "bg_purple"
		end,
		[NewEducateBuff.RARITY.GOLD] = function()
			return "bg_gold"
		end,
		[NewEducateBuff.RARITY.COLOURS] = function()
			return "bg_colours"
		end
	})
end

function var_0_0.UpdateItem(arg_11_0, arg_11_1, arg_11_2)
	setText(arg_11_2:Find("name/Text"), pg.child2_benefit_list[arg_11_1].name)
	setText(arg_11_2:Find("desc/Text"), pg.child2_benefit_list[arg_11_1].desc)
	LoadImageSpriteAtlasAsync("ui/neweducatetalentui_atlas", arg_11_0:GetRarityBg(pg.child2_benefit_list[arg_11_1].rare), arg_11_2, true)
	LoadImageSpriteAsync("neweducateicon/" .. pg.child2_benefit_list[arg_11_1].item_icon, arg_11_2:Find("icon"), true)

	local var_11_0 = not table.contains(arg_11_0.reTalentList, arg_11_1)

	setGray(arg_11_2:Find("refresh_btn"), not var_11_0)
	onButton(arg_11_0, arg_11_2:Find("refresh_btn"), function()
		if arg_11_0.isPlaying then
			return
		end

		if not var_11_0 then
			return
		end

		arg_11_0:emit(NewEducateTalentMediator.ON_REFRESH_TALENT, arg_11_1, tonumber(arg_11_2.name))

		return
	end, SFX_PANEL)
	setText(arg_11_2:Find("refresh_btn/Text"), var_11_0 and 1 or 0)
	onButton(arg_11_0, arg_11_2, function()
		if arg_11_0.isPlaying then
			return
		end

		arg_11_0:emit(NewEducateTalentMediator.ON_SELECT_TALENT, arg_11_1, tonumber(arg_11_2.name))

		return
	end, SFX_PANEL)

	return
end

function var_0_0.RefreshView(arg_14_0)
	local var_14_0 = arg_14_0.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.TALENT)

	arg_14_0.talentList = var_14_0:GetTalents()
	arg_14_0.reTalentList = var_14_0:GetReTalents()

	arg_14_0.uiList:align(#arg_14_0.talentList)

	return
end

function var_0_0.OnRefreshTalent(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.TALENT)

	arg_15_0.talentList = var_15_0:GetTalents()
	arg_15_0.reTalentList = var_15_0:GetReTalents()

	eachChild(arg_15_0.uiList.container, function(arg_16_0)
		if tonumber(arg_16_0.name) == arg_15_1 then
			local var_16_0 = arg_16_0:GetComponent(typeof(DftAniEvent))

			arg_16_0:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
				var_16_0:SetTriggerEvent(nil)

				arg_15_0.isPlaying = false

				arg_15_0:UpdateItem(arg_15_2, arg_16_0)

				return
			end)
			arg_16_0:GetComponent(typeof(Animation)):Play("Anim_educate_talent_tpl_change")

			arg_15_0.isPlaying = true
		end

		return
	end)

	return
end

function var_0_0.OnSelectedDone(arg_18_0, arg_18_1)
	seriesAsync({
		function(arg_19_0)
			if #arg_18_1.drops > 0 then
				arg_18_0:emit(var_0_0.ON_DROP, {
					items = arg_18_1.drops,
					removeFunc = function()
						arg_19_0()

						return
					end
				})
			else
				arg_19_0()
			end

			return
		end
	}, function()
		arg_18_0.animEvent:SetEndEvent(function()
			arg_18_0.animEvent:SetEndEvent(nil)

			arg_18_0.isPlaying = false

			arg_18_0:closeView()

			return
		end)
		arg_18_0.animCom:Play("Anim_educate_talent_select")

		arg_18_0.isPlaying = true

		eachChild(arg_18_0.uiList.container, function(arg_23_0)
			if tonumber(arg_23_0.name) ~= arg_18_1.idx then
				arg_23_0:GetComponent(typeof(Animation)):Play("Anim_educate_talent_tpl_out")
			end

			return
		end)

		return
	end)

	return
end

function var_0_0.onBackPressed(arg_24_0)
	return
end

function var_0_0.willExit(arg_25_0)
	arg_25_0:UnOverlayPanel(arg_25_0._tf)
	existCall(arg_25_0.contextData.onExit)

	return
end

return var_0_0
