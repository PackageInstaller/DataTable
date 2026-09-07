local IslandSeasonTipMsgBoxWindow = class("IslandSeasonTipMsgBoxWindow", import(".IslandCommonMsgboxWindow"))

function IslandSeasonTipMsgBoxWindow:getUIName()
	return "IslandCommonMsgBoxForSeasonTip"
end

function IslandSeasonTipMsgBoxWindow:OnLoaded()
	IslandSeasonTipMsgBoxWindow.super.OnLoaded(self)

	self.tipTitleText = self._tf:Find("tipTitle/Text"):GetComponent(typeof(Text))

	return
end

function IslandSeasonTipMsgBoxWindow:OnShow()
	IslandSeasonTipMsgBoxWindow.super.OnShow(self)

	self.tipTitleText.text = self.settings.tipTitle

	return
end

function IslandSeasonTipMsgBoxWindow:FlushBtn(arg_4_1)
	return
end

return IslandSeasonTipMsgBoxWindow
