-- chunkname: @IQIGame\\UI\\Lottery\\LotterySelectDrawResultShow.lua

local selectResultItemParentClass = require("IQIGame.UI.Lottery.SelectResultItemParent")
local m = {
	ItemParentList = {}
}
local selectEnum = {
	History = 1,
	Current = 2
}

function m.New(view, mainView)
	local obj = Clone(m)

	obj:Init(view, mainView)

	return obj
end

function m:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCancelBtn()
		self:OnClickCancelBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickConfirmRecordBtn()
		self:OnClickConfirmRecordBtn()
	end

	self.HistoryResultParent = selectResultItemParentClass.New(self.HistoryResultParent, selectEnum.History, function(selectIndex)
		self:SelectEvent(selectIndex)
	end, self.mainView)
	self.CurrentResultParent = selectResultItemParentClass.New(self.CurrentResultParent, selectEnum.Current, function(selectIndex)
		self:SelectEvent(selectIndex)
	end, self.mainView)
	self.ItemParentList[selectEnum.History] = self.HistoryResultParent
	self.ItemParentList[selectEnum.Current] = self.CurrentResultParent

	self:AddListeners()
end

function m:AddListeners()
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCancelBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.ConfrimRecordBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmRecordBtn)
end

function m:RemoveListeners()
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCancelBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.ConfrimRecordBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmRecordBtn)
end

function m:SetData(openType)
	LuaUtility.SetGameObjectShow(self.ConfrimRecordBtn, openType == 1)
	LuaUtility.SetGameObjectShow(self.ConfrimBtn, openType == 2)
	LuaUtility.SetGameObjectShow(self.replaceImg, openType == 1)
	self.ItemParentList[selectEnum.History]:SetSelectBtnState(openType == 2)
	self.ItemParentList[selectEnum.Current]:SetSelectBtnState(openType == 2)
	UGUIUtil.SetText(self.TitleText, LotteryUIApi:GetDrwaResultTitle(openType))

	local poolData = LotteryModule.GetPoolDataByType(LotteryModule.curSelectPoolType)

	self.HistoryResultParent:SetData(poolData.historyItems)
	self.CurrentResultParent:SetData(poolData.currentItems)

	if openType == 1 then
		self.ItemParentList[selectEnum.History]:SetBGState(true)
		self.ItemParentList[selectEnum.Current]:SetBGState(true)
	elseif openType == 2 then
		self.SelectIndex = selectEnum.History

		self.ItemParentList[selectEnum.History]:SetSelectState(true)
	end
end

function m:SelectEvent(selectIndex)
	self.SelectIndex = selectIndex

	for k, v in pairs(self.ItemParentList) do
		v:SetSelectState(k == selectIndex)
	end
end

function m:OnClickCancelBtn()
	self:Hide()
end

function m:OnClickConfirmBtn()
	NoticeModule.ShowNotice(21044003, function()
		if self.SelectIndex == -1 then
			log("请选择一组作为最后结果!")

			return
		end

		LotteryModule.ConfrimDraw(LotteryModule.curSelectPoolType, self.SelectIndex == selectEnum.Current)
	end)
end

function m:OnClickConfirmRecordBtn()
	LotteryModule.RecordDraw(LotteryModule.curSelectPoolType)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.HistoryResultParent:Dispose()
	self.CurrentResultParent:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
