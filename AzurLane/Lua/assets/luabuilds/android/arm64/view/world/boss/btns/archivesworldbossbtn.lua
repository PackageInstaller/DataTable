class = var_0_10000

local var_0_0 = var_0_10000("ArchivesWorldbossBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.GetComponent

	typeof = var_1_10006
	Image = var_1_10008
	arg_1_0.img = var_1_1(var_1_0, var_1_10006(var_1_10008))
	arg_1_0.event = arg_1_2

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_3.Find(var_1_2, "Text")
	local var_1_4 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.iconText = var_1_4(var_1_3, var_6(var_1_10008))

	local var_1_5 = arg_1_0._tf

	arg_1_0.tip = var_3.Find(var_1_5, "tip")
	onButton = var_3

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0._tf

	local function var_1_8()
		local var_2_0 = arg_1_0.event
		local var_2_1 = var_0.emit

		WorldBossScene = var_2_10003

		local var_2_2 = var_2_10003.ON_SWITCH

		WorldBossScene = var_2_10004

		var_2_1(var_2_0, var_2_2, var_2_10004.PAGE_ARCHIVES_LIST)

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_1_6, var_1_7, var_1_8, var_1_10008)

	return
end

function var_0_0.Flush(arg_3_0)
	WorldBossConst = var_1_10001

	local var_3_0 = var_1_10001.GetAchieveState()

	WorldBossConst = var_1_10002

	if var_3_0 == var_1_10002.ACHIEVE_STATE_STARTING then
		WorldBossConst = var_1_10003
		var_1_10003 = var_1_10003.GetArchivesId()
		WorldBossConst = var_1_10004

		local var_3_1 = var_1_10004.BossId2MetaId(var_1_10003)

		getProxy = var_1_10005
		MetaCharacterProxy = var_1_10007

		local var_3_2 = var_1_10005(var_1_10007)
		local var_3_3 = var_5.getMetaProgressVOByID(var_3_2, var_3_1).metaPtData

		var_1_10006 = var_1_10006.GetResProgress(var_3_3)

		local var_3_4 = arg_3_0.iconText
		local var_3_5 = var_1_10006
		local var_3_6 = "/"
		local var_3_7 = var_5.metaPtData

		var_3_4.text = var_3_5 .. var_3_6 .. var_10.GetTotalResRequire(var_3_7)

		local var_3_8 = arg_3_0.img

		GetSpriteFromAtlas = var_8
		var_3_8.sprite = var_8("MetaWorldboss/" .. var_3_1, "btn")
	else
		var_1_10003 = arg_3_0.iconText
		var_1_10003.text = ""
		var_1_10003 = arg_3_0.img
		LoadSprite = var_4
		var_1_10003.sprite = var_4("MetaWorldboss/extra_btn")
	end

	setActive = var_1_10003

	local var_3_9 = arg_3_0.tip

	WorldBossConst = var_1_10006

	var_1_10003(var_3_9, var_1_10006.AnyArchivesBossCanGetAward())

	return
end

function var_0_0.Dispose(arg_4_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_4_0)

	return
end

return var_0_0
