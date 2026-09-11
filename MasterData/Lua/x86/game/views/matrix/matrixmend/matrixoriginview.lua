local MatrixTreeItemGroup = import("game.views.matrix.matrixTools.MatrixTreeItemGroup")
local MatrixOriginView = class("MatrixOriginView", ReduxView)
local var_0_2 = {
	MATRIX = 1,
	TERMINAL = 5,
	TREASURE = 3,
	SCORE = 7,
	AFFIX = 4,
	HERO = 2,
	ARTIFACT = 6
}

function MatrixOriginView:UIBackCount()
	return 2
end

function MatrixOriginView:UIName()
	return "UI/Matrix/Mend/MatrixOrigin"
end

function MatrixOriginView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixOriginView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixOriginView:InitUI()
	self:BindCfgUI()

	self.itemGroup_ = MatrixTreeItemGroup.New(self.m_itemGroup, self.m_treeItemPrefab)

	self.itemGroup_:SetSelectCallback(function(arg_6_0, arg_6_1, arg_6_2)
		if self.subIndex_ == arg_6_1 then
			return
		end

		self:ShowSubIndex(arg_6_0, arg_6_1, arg_6_2)
	end)

	self.toggles_ = {}

	for iter_5_0 = 1, self.m_switchContainer.childCount do
		table.insert(self.toggles_, self.m_switchContainer:GetChild(iter_5_0 - 1):GetComponent(typeof(Toggle)))
	end
end

function MatrixOriginView:AddUIListener()
	for iter_7_0, iter_7_1 in ipairs(self.toggles_) do
		self:AddToggleListener(iter_7_1, function(arg_8_0)
			if arg_8_0 then
				self:SelectGroup(iter_7_0)
			end
		end)
	end
end

function MatrixOriginView:SelectGroup(arg_9_1, arg_9_2)
	if var_0_2.MATRIX == arg_9_1 then
		self:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixProcess")
	elseif var_0_2.HERO == arg_9_1 then
		self.heroList = MatrixData:GetMatrixHeroTeam()

		self:ShowTreeItems(arg_9_1, arg_9_2, self.heroList)
	elseif var_0_2.TREASURE == arg_9_1 then
		self:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixTreasureMini")
	elseif var_0_2.AFFIX == arg_9_1 then
		self:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixAffixMini")
	elseif var_0_2.TERMINAL == arg_9_1 then
		self:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixTerminalTalentMini")
	elseif var_0_2.ARTIFACT == arg_9_1 then
		self:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixBeaconMini")
	elseif var_0_2.SCORE == arg_9_1 then
		self:HideTreeItems()
		JumpTools.OpenPageByJump("matrixOrigin/matrixScoreExchangeMini")
	end
end

function MatrixOriginView:ShowSubIndex(arg_10_1, arg_10_2, arg_10_3)
	JumpTools.OpenPageByJump("matrixOrigin/matrixMiniHero", {
		heroId = self.heroList[arg_10_2]
	})
	self.transform_:SetAsLastSibling()
end

function MatrixOriginView:ShowTreeItems(arg_11_1, arg_11_2, arg_11_3)
	arg_11_2 = arg_11_2 or 1
	self.itemGroup_:GetContainer().parent = self.m_switchContainer

	self.itemGroup_:SetData(arg_11_1, arg_11_2, arg_11_3)
	self.itemGroup_:GetContainer():SetSiblingIndex(arg_11_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_switchContainer)
end

function MatrixOriginView:HideTreeItems()
	self.subIndex_ = nil

	self.itemGroup_:GetContainer():SetParent(self.m_groupFreePlace)
end

function MatrixOriginView:OnEnter()
	manager.ui:SetMainCamera("hero")

	if MatrixData:GetDifficulty() == 1 then
		SetActive(self.toggles_[var_0_2.AFFIX].gameObject, false)
	else
		SetActive(self.toggles_[var_0_2.AFFIX].gameObject, true)
	end

	self.toggles_[1].isOn = true

	self:SelectGroup(1)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
	manager.redPoint:bindUIandKey(self.toggles_[var_0_2.SCORE].transform, RedPointConst.MATRIX_EXCHANGE_BONUS, {
		x = 139.6,
		y = 112.6
	})
end

function MatrixOriginView:OnTop()
	self.toggles_[1].isOn = true

	self:SelectGroup(1)
end

function MatrixOriginView:OnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	manager.redPoint:unbindUIandKey(self.toggles_[var_0_2.SCORE].transform, RedPointConst.MATRIX_EXCHANGE_BONUS)
end

function MatrixOriginView:Dispose()
	if self.itemGroup_ then
		self.itemGroup_:Dispose()

		self.itemGroup_ = nil
	end

	MatrixOriginView.super.Dispose(self)
end

function MatrixOriginView:OnMatrixUserUpdate()
	local var_18_0 = MatrixData:GetGameState()

	if MatrixConst.STATE_TYPE.NOTSTARTED == var_18_0 then
		local var_18_1 = {}

		var_18_1.isTimeOut = true

		JumpTools.GoToSystem("/matrixBlank/matrixPrepare", var_18_1)
	elseif MatrixConst.STATE_TYPE.SUCCESS == var_18_0 or MatrixConst.STATE_TYPE.FAIL == var_18_0 then
		JumpTools.GoToSystem("/matrixBlank/matrixOver")
	end
end

return MatrixOriginView
