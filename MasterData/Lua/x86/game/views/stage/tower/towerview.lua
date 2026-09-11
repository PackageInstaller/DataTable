local TowerView = class("TowerView", ReduxView)

function TowerView:UIName()
	return "Widget/System/Tower/TowerUI_NEW"
end

function TowerView:UIParent()
	return manager.ui.uiMain.transform
end

function TowerView:Init()
	self.selectIndex_ = -1

	self:InitUI()
	self:AddUIListener()
end

function TowerView:InitUI()
	self:BindCfgUI()

	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.currentController = ControllerUtil.GetController(self.transform_, "current")
end

function TowerView:AddUIListener()
	self:AddBtnListener(self.m_maskBtn, nil, function()
		self:CloseSectionInfo()
	end)

	for iter_5_0 = 1, 10 do
		if self["m_tower_" .. iter_5_0] then
			self:AddBtnListener(self["m_tower_" .. iter_5_0], nil, function()
				self.selectIndex_ = iter_5_0

				self.selectController:SetSelectedIndex(self.selectIndex_)
				self:RefreshUI()
			end)
		end
	end
end

function TowerView:OnEnter()
	self.chapterId = self.params_.chapterId
	self.towerList = TowerData:GetTowerList(self.params_.chapterId)
	self.curId = TowerData:GetCurId(self.params_.chapterId)

	local var_8_0 = table.indexof(self.towerList, self.curId)

	self.currentController:SetSelectedIndex(var_8_0 or 11)

	if not self.params_.showInfo or not var_8_0 then
		self.selectIndex_ = 0

		self.selectController:SetSelectedIndex(self.selectIndex_)
		self:OnTowerContentShow(false)
	else
		self.selectIndex_ = var_8_0

		self.selectController:SetSelectedIndex(self.selectIndex_)
		self:RefreshUI()
	end
end

function TowerView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("SPAWN_DESCRIPE")

	if self.showing_ then
		self:OnTowerContentShow(false)
		self.selectController:SetSelectedIndex(0)
	end
end

function TowerView:OnExit()
	manager.windowBar:HideBar()
end

function TowerView:RefreshUI()
	self:OnTowerContentShow(true, self.selectIndex_)

	local var_11_0 = (not self.curId or self.towerList[self.selectIndex_] <= self.curId) and GetTips("READY_BATTLE") or GetTips("BACK_TO_CURRENT")

	self:Go("towerSelectionInfo", {
		towerId = self.towerList[self.selectIndex_],
		curId = self.curId,
		clickBackFunc = handler(self, self.BackToCurSelect),
		btnTips = var_11_0
	})
end

function TowerView:BackToCurSelect()
	self.selectIndex_ = table.indexof(self.towerList, self.curId) or 1

	self.selectController:SetSelectedIndex(self.selectIndex_)
	self:RefreshUI()
end

function TowerView:CloseSectionInfo()
	if self:IsOpenRoute("towerSelectionInfo") then
		self:OnTowerContentShow(false)
		JumpTools.Back()
	end

	self.selectController:SetSelectedIndex(0)
end

function TowerView:OnTowerContentShow(arg_14_1, arg_14_2)
	if arg_14_1 then
		self:RemoveTween()

		self.tween_ = LeanTween.value(self.m_middleContent.gameObject, self.m_middleContent.localPosition.x, -self["m_tower_" .. arg_14_2].transform.localPosition.x - 350, 0.3):setOnUpdate(LuaHelper.FloatAction(function(arg_15_0)
			self.m_middleContent.localPosition = Vector3(arg_15_0, 0, 0)
		end))
	else
		self:RemoveTween()

		self.tween_ = LeanTween.value(self.m_middleContent.gameObject, self.m_middleContent.localPosition.x, 0, 0.3):setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
			self.m_middleContent.localPosition = Vector3(arg_16_0, 0, 0)
		end))
	end

	self.showing_ = arg_14_1
end

function TowerView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil)
		LeanTween.cancel(self.m_middleContent.gameObject)

		self.tween_ = nil
	end
end

function TowerView:Dispose()
	self:RemoveTween()
	TowerView.super.Dispose(self)
end

return TowerView
