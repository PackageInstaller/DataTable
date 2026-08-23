local RemindTipSlgS2CityData = class("RemindTipSlgS2CityData", (require("app.view.module.home.model.remindTip.RemindTipBaseData")))

function RemindTipSlgS2CityData:ctor(arg_1_1)
	RemindTipSlgS2CityData.super.ctor(self, arg_1_1)

	if not self._uid then
		self:_initTempUid()
	end

	self._jumpFunc = arg_1_1.jumpFunc
end

function RemindTipSlgS2CityData:isHide()
	return RemindTipSlgS2CityData.super.isHide(self) or #self._params <= 0
end

function RemindTipSlgS2CityData:getJumpFunc()
	return self._jumpFunc
end

return RemindTipSlgS2CityData
