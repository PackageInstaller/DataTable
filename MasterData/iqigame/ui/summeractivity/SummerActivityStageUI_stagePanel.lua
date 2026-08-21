-- chunkname: @IQIGame\\UI\\SummerActivity\\SummerActivityStageUI_stagePanel.lua

local SummerActivityStageUI_stagePanel = {}
local stageItemClass = require("IQIGame/UI/SummerActivity/SummerActivityStageUI_stagePanel_stageItem")

function SummerActivityStageUI_stagePanel.New(go, mainView)
	local o = Clone(SummerActivityStageUI_stagePanel)

	o:Initialize(go, mainView)

	return o
end

function SummerActivityStageUI_stagePanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.stageItemCellList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function SummerActivityStageUI_stagePanel:InitComponent()
	self.transContent = self.content.transform
end

function SummerActivityStageUI_stagePanel:InitDelegate()
	function self.onNotifyStageEvent()
		self:Refresh()
	end
end

function SummerActivityStageUI_stagePanel:AddListener()
	EventDispatcher.AddEventListener(EventID.OnNotifyStage, self.onNotifyStageEvent)
end

function SummerActivityStageUI_stagePanel:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.OnNotifyStage, self.onNotifyStageEvent)
end

function SummerActivityStageUI_stagePanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function SummerActivityStageUI_stagePanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function SummerActivityStageUI_stagePanel:Refresh()
	local len = LuaUtility.GetChildCount(self.transContent)

	for i = 1, len do
		local trans = LuaUtility.GetChild(self.transContent, i - 1)

		if LuaUtility.StrIsStartWith(trans.gameObject.name, "stage_") and not self.stageItemCellList[i] then
			local cell = stageItemClass.New(trans.gameObject, self)

			cell:Refresh()
			table.insert(self.stageItemCellList, cell)
		else
			self.stageItemCellList[i]:Refresh()
		end
	end
end

function SummerActivityStageUI_stagePanel:OnStageSelected(item)
	if self.currentSelectedItem then
		self.currentSelectedItem:UnSelected()

		self.currentSelectedItem = nil
	end

	self.currentSelectedItem = item

	self.currentSelectedItem:Selected()
end

function SummerActivityStageUI_stagePanel:OnDestroy()
	self:RemoveListener()

	for _, v in pairs(self.stageItemCellList) do
		v:OnDestroy()
	end

	self.stageItemCellList = {}

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	GameObject.Destroy(self.gameObject)

	self.gameObject = nil
end

return SummerActivityStageUI_stagePanel
