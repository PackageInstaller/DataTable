local AdminCatExploreRegionItem = class("AdminCatExploreRegionItem", ReduxView)
local var_0_1 = {
	"I",
	"II",
	"III",
	"IV",
	"V"
}

function AdminCatExploreRegionItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_2

	self:Init()
end

function AdminCatExploreRegionItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExploreRegionItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.gameObject_.transform, "state")
end

function AdminCatExploreRegionItem:AddUIListener()
	self:AddBtnListener(self.exploreBtn_, nil, function()
		local var_5_0 = self.stateController:GetSelectedState()

		if var_5_0 == "normal" then
			JumpTools.OpenPageByJump("adminCatExplorePop", {
				regionId = self.regionId
			})
		elseif var_5_0 == "finish" then
			AdminCatExploreAction.AdminCatExploreFinish(self.regionId)
		elseif var_5_0 == "exploring" then
			JumpTools.OpenPageByJump("adminCatExploringPop", {
				regionId = self.regionId
			})
		elseif var_5_0 == "lock" then
			ShowTips("ERROR_EXPLORE_LV_LIMIT")
		end
	end)
end

function AdminCatExploreRegionItem:SetData(arg_6_1, arg_6_2)
	self.getGo = arg_6_1
	self.index = arg_6_2
	self.regionId = AdminCatExploreData:GetRegionIdByIndex(self.index)
end

function AdminCatExploreRegionItem:UpdateBar()
	return
end

function AdminCatExploreRegionItem:UpdateView()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	self.level = AdminCatExploreData:GetDataByPara("level")

	local var_8_0 = ExploreAreaCfg[self.regionId]

	self.regionData = AdminCatExploreData:GetDataByPara("regionData")[self.regionId]
	self.regionUnlockLevel = AdminCatExploreData:GetDataByPara("regionUnlockLevel")

	if self.regionUnlockLevel[self.regionId] and self.level < self.regionUnlockLevel[self.regionId] then
		self.stateController:SetSelectedState("lock")

		self.lockTxt_.text = string.format(GetTips("EXPLORE_DEBLOCKING_LEVEL"), var_0_1[self.regionUnlockLevel[self.regionId]])
	elseif self.regionData then
		if self.regionData.stopTime > manager.time:GetServerTime() then
			local var_8_1 = math.max(0, self.regionData.stopTime - manager.time:GetServerTime())

			self.remainTxt_.text = manager.time:DescCDTime(var_8_1)
			self.fillImg_.fillAmount = 1 - var_8_1 / (self.regionData.stopTime - self.regionData.startTime)
			self.updateTimer_ = Timer.New(function()
				var_8_1 = math.max(0, self.regionData.stopTime - manager.time:GetServerTime())
				self.remainTxt_.text = manager.time:DescCDTime(var_8_1)
				self.fillImg_.fillAmount = 1 - var_8_1 / (self.regionData.stopTime - self.regionData.startTime)

				if var_8_1 <= 0 then
					SetActive(self.getGo, true)
					AdminCatExploreData:UpdateRegionRedPoint()
					self.stateController:SetSelectedState("finish")

					self.stateText_.text = GetTips("EXPLORE_REGION_FINISH")

					self.updateTimer_:Stop()

					self.updateTimer_ = nil
				end
			end, 1, var_8_1, 1)

			self.updateTimer_:Start()
			self.stateController:SetSelectedState("exploring")

			self.stateText_.text = GetTips("EXPLORE_REGION_EXPLORING")
		else
			self.getFill_.fillAmount = 1

			SetActive(self.getGo, true)

			self.remainTxt_.text = manager.time:DescCDTime(0)

			self.stateController:SetSelectedState("finish")

			self.stateText_.text = GetTips("EXPLORE_REGION_FINISH")
		end
	else
		self.fillImg_.fillAmount = 0

		self.stateController:SetSelectedState("normal")

		self.stateText_.text = GetTips("EXPLORE_REGION_NORMAL")
	end

	self.regionNameTxt_.text = GetI18NText(var_8_0.area_name)

	if self.regionData then
		self.adminCatImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_s/" .. ExploreMeowCfg[self.regionData.adminCatID].meow_icon)
	end
end

function AdminCatExploreRegionItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.exploreBtn_.transform, RedPointConst.EXPLORE_FINISH .. self.regionId, {
		x = 50,
		y = 50
	})
end

function AdminCatExploreRegionItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.exploreBtn_.transform, RedPointConst.EXPLORE_FINISH .. self.regionId)
end

function AdminCatExploreRegionItem:OnEnter()
	self:UpdateView()
	self:BindRedPoint()
end

function AdminCatExploreRegionItem:OnExit()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	self:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function AdminCatExploreRegionItem:Hide()
	SetActive(self.gameObject_, false)
end

function AdminCatExploreRegionItem:Show()
	SetActive(self.gameObject_, true)
end

function AdminCatExploreRegionItem:Dispose()
	AdminCatExploreRegionItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploreRegionItem
