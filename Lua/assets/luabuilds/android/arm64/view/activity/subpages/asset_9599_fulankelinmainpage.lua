local FulankelinMainPage = class("FulankelinMainPage", import("view.base.BaseActivityPage"))
local var_0_1 = 71122
local var_0_3 = ActivityConst.Valleyhospital_ACT_ID

function FulankelinMainPage:OnInit()
	self.ad = self._tf:Find("AD")
	self.btnCollect = findTF(self.ad, "btnCollect")
	self.btnSkin = findTF(self.ad, "btnSkin")
	self.btnSkinText = findTF(self.btnSkin, "bgTime/text")
	self.btnAct = findTF(self.ad, "btnAct")
	self.btnActText = findTF(self.btnAct, "bgTime/text")
	self.btnBuild = findTF(self.ad, "btnBuild")
	self.btnBuildText = findTF(self.btnBuild, "bgTime/text")

	GetComponent(self.btnCollect, typeof(Image)):SetNativeSize()
	GetComponent(self.btnSkin, typeof(Image)):SetNativeSize()
	GetComponent(self.btnAct, typeof(Image)):SetNativeSize()
	GetComponent(self.btnBuild, typeof(Image)):SetNativeSize()
	onButton(self, self.btnCollect, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_ALBUM
		})

		return
	end)
	onButton(self, self.btnSkin, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnAct, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CLUE_MAP)

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnBuild, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD
		})

		return
	end, SFX_CONFIRM)

	return
end

function FulankelinMainPage:OnDataSetting()
	return
end

function FulankelinMainPage:OnFirstFlush()
	self:updateUI()

	return
end

function FulankelinMainPage:OnUpdateFlush()
	self:updateUI()

	return
end

function FulankelinMainPage:updateUI()
	local var_9_0, var_9_1 = pg.TimeMgr.GetInstance():inTime(pg.shop_template[var_0_1].time)
	local var_9_2

	if var_9_1 then
		var_9_2 = skinCommdityTimeStamp((pg.TimeMgr.GetInstance():Table2ServerTime(var_9_1)))
	end

	local var_9_3, var_9_4 = pg.TimeMgr.GetInstance():inTime(pg.activity_template[var_0_3].time)
	local var_9_5

	if var_9_4 then
		var_9_5 = skinCommdityTimeStamp((pg.TimeMgr.GetInstance():Table2ServerTime(var_9_4)))
	end

	if var_9_2 then
		setText(self.btnSkinText, var_9_2)
	else
		setActive(findTF(self.btnSkin, "bgTime"), false)
	end

	setText(self.btnActText, "")

	if var_9_5 then
		setText(self.btnBuildText, var_9_5)
	else
		setActive(findTF(self.btnBuild, "bgTime"), false)
	end

	return
end

return FulankelinMainPage
