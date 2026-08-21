-- chunkname: @IQIGame\\UI\\Map\\ItemCell\\TabItemCell\\MainStageTabItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickMoveTargetBtn()
		self:OnClickMoveTargetBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.ClickBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMoveTargetBtn)
end

function m:RemoveListeners()
	self.ClickBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMoveTargetBtn)
end

function m:SetData(stageCfg)
	self.stageCfg = stageCfg

	UGUIUtil.SetText(self.chapterNameText, CfgGeneralDupChapterTable[stageCfg.ChapterId].Name)
	UGUIUtil.SetText(self.presentMainlineTask, stageCfg.Name)
end

function m:OnClickMoveTargetBtn()
	EventDispatcher.Dispatch(EventID.ClickMarkItemMoveMapEvent, MapModule.TargetMapItem.transform.position, true)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
