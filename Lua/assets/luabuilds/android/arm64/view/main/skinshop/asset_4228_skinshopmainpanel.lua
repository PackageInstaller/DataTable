local SkinShopMainPanel = class("SkinShopMainPanel")

function SkinShopMainPanel:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.nameTxt = findTF("name_bg/name", self._tf):GetComponent(typeof(Text))
	self.skinNameTxt = findTF("name_bg/skin_name", self._tf):GetComponent(typeof(Text))
	self.charParent = findTF("char/char", self._tf)
	self.paintingTF = findTF("paint", self._tf)
	self.charBg = findTF("char/char_info", self._tf)
	self.tags = findTF("char/char_info/tags", self._tf)
	self.limitTxt = findTF("name_bg/limit_time/Text", self._tf):GetComponent(typeof(Text))
	self.commonPanel = findTF("char/common", self._tf)
	self.buyBtn = findTF("buy_btn", self.commonPanel)
	self.activityBtn = findTF("activty_btn", self.commonPanel)
	self.gotBtn = findTF("got_btn", self.commonPanel)
	self.priceTxt = findTF("consume/Text", self.commonPanel):GetComponent(typeof(Text))
	self.originalPriceTxt = findTF("consume/originalprice/Text", self.commonPanel):GetComponent(typeof(Text))
	self.timelimtPanel = findTF("char/timelimt", self._tf)
	self.timelimitBtn = findTF("timelimit_btn", self.timelimtPanel)
	self.timelimitPriceTxt = findTF("consume/Text", self.timelimtPanel):GetComponent(typeof(Text))
	self.bg1 = findTF("bg/bg_1")
	self.bg2 = findTF("bg/bg_2")
	self.bgType = false
	self.defaultBg = self.bg1:GetComponent(typeof(Image)).sprite

	return
end

return SkinShopMainPanel
