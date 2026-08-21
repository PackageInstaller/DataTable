local var_0_0 = class("ClassRoomBuilding", import(".NavalAcademyUpgradableBuilding"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.bubbleImg = arg_1_0.bubble:Find("icon"):GetComponent(typeof(Image))
	arg_1_0.floatImg = arg_1_0.floatTF:GetComponent(typeof(Image))
	arg_1_0.isUpdateIcon = false

	return
end

function var_0_0.UpdateBubble(arg_2_0)
	local var_2_0 = arg_2_0:GetResField()
	local var_2_1 = var_2_0:GetGenResCnt() > 0

	setActive(arg_2_0.bubble, var_2_1)

	if var_2_1 then
		arg_2_0:FloatAni()
	end

	if not arg_2_0.isUpdateIcon then
		local var_2_2 = Item.getConfigData((var_2_0:GetResourceType())).icon

		arg_2_0.bubbleImg.sprite = LoadSprite(var_2_2)
		arg_2_0.floatImg.sprite = LoadSprite(var_2_2)

		onButton(arg_2_0, arg_2_0.bubble, function()
			local var_3_0 = arg_2_0:GetResField()

			arg_2_0:emit(NavalAcademyMediator.ON_GET_CLASS_RES)

			return
		end, SFX_PANEL)

		arg_2_0.isUpdateIcon = true
	end

	return
end

function var_0_0.GetGameObjectName(arg_4_0)
	return "classRoom"
end

function var_0_0.GetTitle(arg_5_0)
	return i18n("school_title_dajiangtang")
end

function var_0_0.OnClick(arg_6_0)
	arg_6_0:emit(NavalAcademyMediator.ON_OPEN_CLASSROOM)

	return
end

function var_0_0.OnInit(arg_7_0)
	var_0_0.super.OnInit(arg_7_0)

	local var_7_0 = arg_7_0:IsUnlock()

	setActive(arg_7_0._tf:Find("name/level"), var_7_0)
	setActive(arg_7_0._tf:Find("name/lock"), not var_7_0)

	return
end

function var_0_0.IsUnlock(arg_8_0)
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "ClassMediator")
end

function var_0_0.GetResField(arg_9_0)
	return arg_9_0.parent.classResField
end

return var_0_0
