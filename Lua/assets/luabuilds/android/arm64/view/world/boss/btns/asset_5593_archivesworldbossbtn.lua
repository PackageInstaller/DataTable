local ArchivesWorldbossBtn = class("ArchivesWorldbossBtn")

function ArchivesWorldbossBtn:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self._tf = arg_1_1
	self.img = self._tf:GetComponent(typeof(Image))
	self.event = arg_1_2
	self.iconText = self._tf:Find("Text"):GetComponent(typeof(Text))
	self.tip = self._tf:Find("tip")

	onButton(self, self._tf, function()
		self.event:emit(WorldBossScene.ON_SWITCH, WorldBossScene.PAGE_ARCHIVES_LIST)

		return
	end, SFX_PANEL)

	return
end

function ArchivesWorldbossBtn:Flush()
	if WorldBossConst.GetAchieveState() == WorldBossConst.ACHIEVE_STATE_STARTING then
		local var_3_0 = WorldBossConst.BossId2MetaId((WorldBossConst.GetArchivesId()))
		local var_3_1 = getProxy(MetaCharacterProxy):getMetaProgressVOByID(var_3_0)

		self.iconText.text = var_3_1.metaPtData:GetResProgress() .. "/" .. var_3_1.metaPtData:GetTotalResRequire()
		self.img.sprite = GetSpriteFromAtlas("MetaWorldboss/" .. var_3_0, "btn")
	else
		self.iconText.text = ""
		self.img.sprite = LoadSprite("MetaWorldboss/extra_btn")
	end

	setActive(self.tip, WorldBossConst.AnyArchivesBossCanGetAward())

	return
end

function ArchivesWorldbossBtn:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return ArchivesWorldbossBtn
