-- chunkname: @IQIGame\\UI\\ActiveActivityList\\GhostActivity\\GhostActivityTaskUI_tabItem.lua

local GhostActivityTaskUI_tabItem = {}
local dataName_tab = "tab"
local stateName_selected = "selected"
local stateName_unSelected = "unSelected"

function GhostActivityTaskUI_tabItem.New(go, mainView)
	local o = Clone(GhostActivityTaskUI_tabItem)

	o:Initialize(go, mainView)

	return o
end

function GhostActivityTaskUI_tabItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function GhostActivityTaskUI_tabItem:InitComponent()
	return
end

function GhostActivityTaskUI_tabItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function GhostActivityTaskUI_tabItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function GhostActivityTaskUI_tabItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function GhostActivityTaskUI_tabItem:OnClickButtonClick()
	self.mainView:OnTabClick(self)
end

function GhostActivityTaskUI_tabItem:Selected()
	LuaUtility.SetStateController(self.gameObject, dataName_tab, stateName_selected)
end

function GhostActivityTaskUI_tabItem:UnSelected()
	LuaUtility.SetStateController(self.gameObject, dataName_tab, stateName_unSelected)
end

function GhostActivityTaskUI_tabItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function GhostActivityTaskUI_tabItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function GhostActivityTaskUI_tabItem:Refresh(Data, index)
	self.data = Data
	self.index = index

	LuaUtility.SetText(self.textName, self.data:GetCfg().Name)
	self:UnSelected()

	local showRedDot = false

	if RedDotModule.ghostBossTaskDic and RedDotModule.ghostBossTaskDic[self.data.cid] then
		showRedDot = true
	end

	LuaUtility.SetGameObjectShow(self.RedDot, showRedDot)
end

function GhostActivityTaskUI_tabItem:OnDestroy()
	self:RemoveListener()
end

return GhostActivityTaskUI_tabItem
