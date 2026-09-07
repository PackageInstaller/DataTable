local StoryCancelTipPanel = class("StoryCancelTipPanel", import(".MsgboxSubPanel"))

function StoryCancelTipPanel:getUIName()
	return "Msgbox4StoryCancelTip"
end

function StoryCancelTipPanel:OnInit()
	setText(self._tf:Find("Name"), i18n("autofight_story"))

	return
end

function StoryCancelTipPanel:PreRefresh(arg_3_1)
	arg_3_1.title = pg.MsgboxMgr.TITLE_INFORMATION

	StoryCancelTipPanel.super.PreRefresh(self, arg_3_1)

	return
end

function StoryCancelTipPanel:OnRefresh(arg_4_1)
	self:SetWindowSize(Vector2(1000, 640))

	local var_4_0 = self._tf:Find("CircleProgress")
	local var_4_1 = self._tf:Find("TimeText")
	local var_4_2 = 5

	LeanTween.value(go(var_4_0), 5, 0, 5):setOnUpdate(System.Action_float(function(arg_5_0)
		setFillAmount(var_4_0, arg_5_0 - math.floor(arg_5_0))
		setText(var_4_1, math.clamp(math.ceil(arg_5_0), 0, var_4_2))

		return
	end)):setOnComplete(System.Action(function()
		existCall(arg_4_1.onYes)
		self:closeView()

		return
	end))

	return
end

function StoryCancelTipPanel:OnHide()
	return
end

function StoryCancelTipPanel:OnDestory()
	LeanTween.cancel(self._tf:Find("CircleProgress"))

	return
end

return StoryCancelTipPanel
