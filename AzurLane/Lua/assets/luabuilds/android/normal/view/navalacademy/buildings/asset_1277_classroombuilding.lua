class = var_0_10000

local var_0_0 = "ClassRoomBuilding"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NavalAcademyUpgradableBuilding"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.bubble
	local var_1_1 = var_2.Find(var_1_0, "icon")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.bubbleImg = var_1_2(var_1_1, var_4(var_1_10005))

	local var_1_3 = arg_1_0.floatTF
	local var_1_4 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.floatImg = var_1_4(var_1_3, var_4(var_1_10005))
	arg_1_0.isUpdateIcon = false

	return
end

function var_0_1.UpdateBubble(arg_2_0)
	local var_2_0 = arg_2_0:GetResField()
	local var_2_1 = var_1.GetGenResCnt(var_2_0)
	local var_2_2 = 0 < var_2_1

	setActive = var_3

	var_3(arg_2_0.bubble, var_2_2)

	if var_2_2 then
		arg_2_0:FloatAni()
	end

	if not arg_2_0.isUpdateIcon then
		local var_2_3 = var_1
		local var_2_4 = var_1.GetResourceType(var_2_3)

		Item = var_2_3

		local var_2_5 = var_2_3.getConfigData(var_2_4).icon
		local var_2_6 = arg_2_0.bubbleImg

		LoadSprite = var_1_10006
		var_2_6.sprite = var_1_10006(var_2_5)

		local var_2_7 = arg_2_0.floatImg

		LoadSprite = var_6
		var_2_7.sprite = var_6(var_2_5)
		onButton = var_2_7

		local var_2_8 = arg_2_0
		local var_2_9 = arg_2_0.bubble

		local function var_2_10()
			local var_3_0 = arg_2_0
			local var_3_1 = var_0.GetResField(var_3_0)
			local var_3_2 = arg_2_0
			local var_3_3 = var_1.emit

			NavalAcademyMediator = var_2_10003

			var_3_3(var_3_2, var_2_10003.ON_GET_CLASS_RES)

			return
		end

		SFX_PANEL = var_1_10009

		var_2_7(var_2_8, var_2_9, var_2_10, var_1_10009)

		arg_2_0.isUpdateIcon = true
	end

	return
end

function var_0_1.GetGameObjectName(arg_4_0)
	return "classRoom"
end

function var_0_1.GetTitle(arg_5_0)
	i18n = var_1_10001

	return var_1_10001("school_title_dajiangtang")
end

function var_0_1.OnClick(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.emit

	NavalAcademyMediator = var_1_10003

	var_6_1(var_6_0, var_1_10003.ON_OPEN_CLASSROOM)

	return
end

function var_0_1.OnInit(arg_7_0)
	var_0_1.super.OnInit(arg_7_0)

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.IsUnlock(var_7_0)

	setActive = var_7_0

	local var_7_2 = arg_7_0._tf

	var_7_0(var_3.Find(var_7_2, "name/level"), var_7_1)

	setActive = var_7_0

	local var_7_3 = arg_7_0._tf

	var_7_0(var_3.Find(var_7_3, "name/lock"), not var_7_1)

	return
end

function var_0_1.IsUnlock(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.SystemOpenMgr.GetInstance()
	local var_8_1 = var_1.isOpenSystem

	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_8_2 = var_1_10003(var_1_10004)

	return var_8_1(var_8_0, var_3.getRawData(var_8_2).level, "ClassMediator")
end

function var_0_1.GetResField(arg_9_0)
	return arg_9_0.parent.classResField
end

return var_0_1
