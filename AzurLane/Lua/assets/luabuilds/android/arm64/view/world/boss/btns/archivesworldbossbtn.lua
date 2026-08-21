local var_0_0 = class("ArchivesWorldbossBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1
	arg_1_0.img = arg_1_0._tf:GetComponent(typeof(Image))
	arg_1_0.event = arg_1_2
	arg_1_0.iconText = arg_1_0._tf:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.tip = arg_1_0._tf:Find("tip")

	onButton(arg_1_0, arg_1_0._tf, function()
		arg_1_0.event:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_ARCHIVES_LIST)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Flush(arg_3_0)
	if WorldBossConst.GetAchieveState() == WorldBossConst.ACHIEVE_STATE_STARTING then
		local var_3_0 = WorldBossConst.BossId2MetaId((WorldBossConst.GetArchivesId()))
		local var_3_1 = getProxy(MetaCharacterProxy):getMetaProgressVOByID(var_3_0)

		arg_3_0.iconText.text = var_3_1.metaPtData:GetResProgress() .. "/" .. var_3_1.metaPtData:GetTotalResRequire()
		arg_3_0.img.sprite = GetSpriteFromAtlas("MetaWorldboss/" .. var_3_0, "btn")
	else
		arg_3_0.iconText.text = ""
		arg_3_0.img.sprite = LoadSprite("MetaWorldboss/extra_btn")
	end

	setActive(arg_3_0.tip, WorldBossConst.AnyArchivesBossCanGetAward())

	return
end

function var_0_0.Dispose(arg_4_0)
	pg.DelegateInfo.Dispose(arg_4_0)

	return
end

return var_0_0
