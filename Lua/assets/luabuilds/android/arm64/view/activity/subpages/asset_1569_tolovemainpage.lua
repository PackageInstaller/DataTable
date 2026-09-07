local ToLoveMainPage = class("ToLoveMainPage", import(".TemplatePage.PreviewTemplatePage"))

ToLoveMainPage.CHARIMG_NUM = 6

function ToLoveMainPage:OnInit()
	self.super.OnInit(self)

	self.charImg = self.bg:Find("character/Image")
	self.skinShop = self.bg:Find("btn_list/skinshop")
	self.build = self.bg:Find("btn_list/build")

	return
end

function ToLoveMainPage:OnFirstFlush()
	self.buildLinkId = self.activity:getConfig("config_client").build_linkId
	self.skinLinkId = self.activity:getConfig("config_client").skin_linkId

	self:initBtn()

	function self.btnFuncList.activity(arg_3_0)
		onButton(self, arg_3_0, function()
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TOLOVE_COLLAB_BACKHILL)

			return
		end)

		return
	end

	eachChild(self.btnList, function(arg_5_0)
		self.btnFuncList[arg_5_0.name](arg_5_0)

		return
	end)

	local var_2_0 = getProxy(ActivityProxy):getActivityById(self.buildLinkId)

	if not var_2_0 or var_2_0:isEnd() then
		setActive(self.build:Find("time"), false)
	else
		setActive(self.build:Find("time"), var_2_0.stopTime - pg.TimeMgr.GetInstance():GetServerTime() < 0)
		setText(self.build:Find("time/Text"), i18n("tolovemainpage_build_countdown"))
	end

	local var_2_3, var_2_4 = pg.TimeMgr.GetInstance():inTime(pg.shop_template[self.skinLinkId].time)

	if var_2_3 then
		local var_2_5 = pg.TimeMgr.GetInstance():Table2ServerTime(var_2_4) - pg.TimeMgr.GetInstance():GetServerTime()

		setActive(self.skinShop:Find("time"), var_2_5 < 0)
		setText(self.skinShop:Find("time/Text"), i18n("tolovemainpage_skin_countdown", math.floor(var_2_5 / 16)))
	else
		setActive(self.skinShop, false)
	end

	GetImageSpriteFromAtlasAsync("ui/activityuipage/tolovemainpage_atlas", "character_" .. math.random(1, ToLoveMainPage.CHARIMG_NUM), self.charImg)

	return
end

return ToLoveMainPage
