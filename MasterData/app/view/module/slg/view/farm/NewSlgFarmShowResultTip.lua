local NewSlgFarmShowResultTip = class("NewSlgFarmShowResultTip")

function NewSlgFarmShowResultTip:ctor()
	self._txtTitle = self:getChild("Txt_title")
	self._tpCtrl = self:getController("tp")
	self._isSuccCtrl = self:getController("isSucc")
end

function NewSlgFarmShowResultTip:_updateTitle()
	self._txtTitle:setText(self._result.title)
end

function NewSlgFarmShowResultTip:_updateReward()
	return
end

function NewSlgFarmShowResultTip:updateView(arg_4_1)
	if not arg_4_1 then
		return
	end

	self._result = arg_4_1

	self._tpCtrl:setSelectedIndex(arg_4_1.tp)
	self._isSuccCtrl:setSelectedIndex(arg_4_1.titleColorIndex - 1)
	self:_updateTitle()
end

function NewSlgFarmShowResultTip:_onClickBtnClose()
	self:dispatchCompEvent("NewSlgFarmResult_close")
end

return NewSlgFarmShowResultTip
