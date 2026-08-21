-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Helper\\QQGameHelper.lua

local WebView = require("SDK/Plugin/WebView")
local EventConst = require("EventConst")
local QQGameHelper = {}
local self = QQGameHelper

self.APP_URL = "https://minigame.qq.com/plat/social_hall/app_frame/index_v4.html"
self.OFFICIAL_URL = "https://gamevip.qq.com/?ADTAG=VIP.WEB.GNSBT"
self.APP_ID = 1111188313

function QQGameHelper.joinVip()
	local args = {}

	args.appid = self.APP_ID
	args.param = "blueVip"

	local url = ClientUtils.composeGetUrl(self.APP_URL, args)

	WebView.openWebView(url)
end

function QQGameHelper.joinVipYear()
	local args = {}

	args.appid = self.APP_ID
	args.param = "YearBlueVip"

	local url = ClientUtils.composeGetUrl(self.APP_URL, args)

	WebView.openWebView(url)
end

function QQGameHelper.pay(paramStr)
	local args = {}

	args.appid = self.APP_ID
	args.param = paramStr

	local url = ClientUtils.composeGetUrl(self.APP_URL, args)

	self._payUrl = url

	WebView.openWebView(url)
	self.ensureEventRegistered()
end

function QQGameHelper.ensureEventRegistered()
	if not self.eventRegistered then
		EventCenter.addEventListener(EventConst.RECHARGE_DELIVER, self.onRechargeDelivered)

		self.eventRegistered = true
	end
end

function QQGameHelper.onRechargeDelivered()
	local webViewDlg = UIManager.tryGetUI("browserDlg")

	if webViewDlg and webViewDlg:getUrl() == self._payUrl then
		webViewDlg:setVisible(false)
	end
end

function QQGameHelper.openOfficialWebsite()
	WebView.unityOpenUrl(self.OFFICIAL_URL)
end

function QQGameHelper.isAnnualVip(vip_step)
	if vip_step and (vip_step == 3 or vip_step == 4) then
		return true
	end

	return false
end

function QQGameHelper.isSuperVip(vip_step)
	if vip_step and (vip_step == 2 or vip_step == 4) then
		return true
	end

	return false
end

return QQGameHelper
