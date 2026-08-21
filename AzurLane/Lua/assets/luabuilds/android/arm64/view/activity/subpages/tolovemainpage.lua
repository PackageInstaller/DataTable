local var_0_0 = class("ToLoveMainPage", import(".TemplatePage.PreviewTemplatePage"))

var_0_0.CHARIMG_NUM = 6

function var_0_0.OnInit(arg_1_0)
	arg_1_0.super.OnInit(arg_1_0)

	arg_1_0.charImg = arg_1_0.bg:Find("character/Image")
	arg_1_0.skinShop = arg_1_0.bg:Find("btn_list/skinshop")
	arg_1_0.build = arg_1_0.bg:Find("btn_list/build")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0.buildLinkId = arg_2_0.activity:getConfig("config_client").build_linkId
	arg_2_0.skinLinkId = arg_2_0.activity:getConfig("config_client").skin_linkId

	arg_2_0:initBtn()

	function arg_2_0.btnFuncList.activity(arg_3_0)
		onButton(arg_2_0, arg_3_0, function()
			arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TOLOVE_COLLAB_BACKHILL)

			return
		end)

		return
	end

	eachChild(arg_2_0.btnList, function(arg_5_0)
		arg_2_0.btnFuncList[arg_5_0.name](arg_5_0)

		return
	end)

	local var_2_0 = getProxy(ActivityProxy):getActivityById(arg_2_0.buildLinkId)
	local var_2_1, var_2_2, var_2_3

	if not var_2_0 or var_2_0:isEnd() then
		setActive(arg_2_0.build:Find("time"), false)

		goto label_2_0

		var_2_1 = pg.TimeMgr.GetInstance()
		var_2_2 = setActive
		var_2_3 = arg_2_0.build:Find("time")
	end

	var_2_2(var_2_3, var_2_0.stopTime - var_2_1:GetServerTime() < 0)
	setText(arg_2_0.build:Find("time/Text"), i18n("tolovemainpage_build_countdown"))

	::label_2_0::

	local var_2_4, var_2_5 = pg.TimeMgr.GetInstance():inTime(pg.shop_template[arg_2_0.skinLinkId].time)

	if var_2_4 then
		local var_2_6 = pg.TimeMgr.GetInstance():Table2ServerTime(var_2_5) - pg.TimeMgr.GetInstance():GetServerTime()

		setActive(arg_2_0.skinShop:Find("time"), var_2_6 < 0)
		setText(arg_2_0.skinShop:Find("time/Text"), i18n("tolovemainpage_skin_countdown", math.floor(var_2_6 / 16)))
	else
		setActive(arg_2_0.skinShop, false)
	end

	GetImageSpriteFromAtlasAsync("ui/activityuipage/tolovemainpage_atlas", "character_" .. math.random(1, var_0_0.CHARIMG_NUM), arg_2_0.charImg)

	return
end

return var_0_0
