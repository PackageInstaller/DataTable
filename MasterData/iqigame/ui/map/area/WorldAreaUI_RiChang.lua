-- chunkname: @IQIGame\\UI\\Map\\Area\\WorldAreaUI_RiChang.lua

local CommonGlobalBuffView = require("IQIGame/UI/Common/GlobalBuff/CommonGlobalBuffView")
local ButtonItem = {}

function ButtonItem.New(view, clickHandler)
	local obj = Clone(ButtonItem)

	obj:__Init(view, clickHandler)

	return obj
end

function ButtonItem:__Init(view, clickHandler)
	self.gameObject = view
	self.clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.btnCom = UIEventUtil.AddClickEventListener_Button(self, "BtnRoot", self.__OnItemClickHandler)
end

function ButtonItem:__OnItemClickHandler()
	if self.isLocked then
		NoticeModule.ShowNotice(self.lockedNoticeCid)

		return
	end

	if self.clickHandler == nil then
		return
	end

	self.clickHandler()
end

function ButtonItem:Show(isDouble, isLock, noticeCid)
	self.gameObject:SetActive(true)
	self.DoubleRoot.gameObject:SetActive(isDouble)
	self.LockedRoot.gameObject:SetActive(isLock)

	self.isLocked = isLock
	self.lockedNoticeCid = noticeCid
end

function ButtonItem:Hide()
	self.gameObject:SetActive(false)
end

function ButtonItem:Dispose()
	self.btnCom = nil

	UIEventUtil.RemoveClickEventListener_Button(self, "BtnRoot")
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local RiChangView = {}

function RiChangView.New(view)
	local obj = Clone(RiChangView)

	obj:__Init(view)

	return obj
end

function RiChangView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.buttons = {}

	self:__InitButtonItem(self.Btn1, Constant.DupTagID.BaseResource, 201)
	self:__InitButtonItem(self.Btn2, Constant.DupTagID.RoleDevelopment, 301)
	self:__InitButtonItem(self.Btn3, Constant.DupTagID.Equip, 102)
	self:__InitButtonItem(self.Btn4, Constant.DupTagID.RoleDevelopment, 302)
	self:__InitButtonItem(self.Btn5, Constant.DupTagID.Equip, 101)

	self.buffView = CommonGlobalBuffView.New(self.BuffParent)
end

function RiChangView:__InitButtonItem(btnRoot, dupTagID, dupTagCid)
	self.buttons[dupTagCid] = ButtonItem.New(btnRoot, function()
		local userData = {}

		userData.tagId = dupTagID
		userData.selectedTagId = dupTagCid

		UIModule.Open(Constant.UIControllerName.ResourceStageUI, Constant.UILayer.UI, userData)
	end)
end

function RiChangView:Show()
	self.gameObject:SetActive(true)
	ForPairs(self.buttons, function(dupTagCid, _btn)
		local dupTagCfg = CfgDupTagTable[dupTagCid]
		local isLock = not ConditionModule.CheckMultipleCondition(dupTagCfg.UnlockConditionId)

		_btn:Show(false, isLock, dupTagCfg.UnlockNoticeId)
	end)
	self:__RefreshGlobalBuffData()

	if not EventUtil.HasEventListener(self, EventID.NotifyGlobalBuffChange) then
		EventUtil.AddEventListener(self, EventID.NotifyGlobalBuffChange, self.__RefreshGlobalBuffData)
	end
end

function RiChangView:__RefreshGlobalBuffData()
	local buffCidList = GlobalBuffModule.GetBuffIDList(Constant.GlobalBuffEffectType.Gain)

	self.buffView:Show(buffCidList)
end

function RiChangView:Hide()
	EventUtil.RemoveEventListener(self, EventID.NotifyGlobalBuffChange)
	self.gameObject:SetActive(false)
	self.buffView:Hide()
end

function RiChangView:Dispose()
	EventUtil.ClearEventListener(self)
	self.buffView:Dispose()
	ForPairs(self.buttons, function(_, _btn)
		_btn:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return RiChangView
