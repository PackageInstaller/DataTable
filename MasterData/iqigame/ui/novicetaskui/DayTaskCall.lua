-- chunkname: @IQIGame\\UI\\NoviceTaskUI\\DayTaskCall.lua

local DayTaskCall = {
	objPoll = {}
}

function DayTaskCall.New(go)
	local o = Clone(DayTaskCall)

	o:Initialize(go)

	return o
end

function DayTaskCall:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.btnGet = self.getBtn:GetComponent("Button")
	self.btnGo = self.gotoBtn:GetComponent("Button")

	function self.buttonGetDelegate()
		self:OnButtonGetClick()
	end

	function self.btnGoDelegate()
		self:BtnGoOnClick()
	end

	self:AddListener()
end

function DayTaskCall:InitComponent()
	return
end

function DayTaskCall:InitDelegate()
	return
end

function DayTaskCall:OnDestroy()
	self:RemoveListener()

	for i, v in pairs(self.objPoll) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DayTaskCall:AddListener()
	self.btnGet.onClick:AddListener(self.buttonGetDelegate)
	self.btnGo.onClick:AddListener(self.btnGoDelegate)
end

function DayTaskCall:RemoveListener()
	self.btnGet.onClick:RemoveListener(self.buttonGetDelegate)
	self.btnGo.onClick:RemoveListener(self.btnGoDelegate)
end

function DayTaskCall:_OnClick()
	return
end

function DayTaskCall:Refresh(data)
	self.data = data

	UGUIUtil.SetText(self.taskDescDesc, data.cfgTaskConfig.Desc)
	UGUIUtil.SetText(self.presentSchedulenum, tostring(data.schedule))
	UGUIUtil.SetText(self.allSchedulenum, tostring(data.needSchedule))
	LuaUtility.SetGameObjectShow(self.gotoBtn.gameObject, false)
	LuaUtility.SetGameObjectShow(self.getBtn.gameObject, false)
	LuaUtility.SetGameObjectShow(self.IsFinishedState.gameObject, false)
	LuaUtility.SetGameObjectShow(self.CommonSlotUI.gameObject, false)

	if data.status == Constant.passTaskStatus.doing then
		LuaUtility.SetGameObjectShow(self.gotoBtn.gameObject, data.cfgTaskConfig.JumpType ~= 0 and true or false)
	elseif data.status == Constant.passTaskStatus.hasDone then
		LuaUtility.SetGameObjectShow(self.getBtn.gameObject, true)
	elseif data.status == Constant.passTaskStatus.hadGot then
		LuaUtility.SetGameObjectShow(self.IsFinishedState.gameObject, true)
	end

	local actionParam = UIUtil.GetConfigArr(data.cfgTaskConfig.ActionParam)
	local actionParamLength = #actionParam

	for i = 1, actionParamLength do
		if actionParam[i][1] == NoviceTaskUIApi:GetExpItemCid() then
			UGUIUtil.SetText(self.expNumText, actionParam[i][2])
		else
			local itemCell = self.objPoll[i]

			if itemCell == nil then
				local obj = UnityEngine.Object.Instantiate(self.CommonSlotUI)

				obj.transform:SetParent(self.rewardGrid.transform, false)

				itemCell = ItemCell.New(obj)
				self.objPoll[i] = itemCell
			end

			itemCell:SetItem(ItemData.CreateByCIDAndNumber(actionParam[i][1], actionParam[i][2]))
			itemCell:SetNum(actionParam[i][2])
		end
	end
end

function DayTaskCall:OnButtonGetClick()
	local SubmitTypes = {}

	table.insert(SubmitTypes, TaskSystemModule.CombineContent(self.data.cfgTaskConfig.Type, self.data.cfgTaskConfig.TypeExtend))
	TaskSystemModule.SubmitTaskForType(SubmitTypes)
end

function DayTaskCall:BtnGoOnClick()
	local cfg = ActivityPassModule.GetTaskInfoWithID(self.data.cid)

	JumpModule.Jump(cfg.JumpType)
end

return DayTaskCall
