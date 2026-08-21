-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\RoleStageItemView.lua

local RoleStageItemView = {}

function RoleStageItemView.New(go, mainView)
	local o = Clone(RoleStageItemView)

	o:Initialize(go, mainView)

	return o
end

function RoleStageItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function RoleStageItemView:InitComponent()
	self.stageImage = self.stageImage:GetComponent("Image")
end

function RoleStageItemView:InitDelegate()
	function self.OnItemClickDelegate()
		self:OnItemClick()
	end

	function self.delegateOnClickDetailBtn()
		self:OnClickDetailBtn()
	end
end

function RoleStageItemView:AddListener()
	self.detailBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickDetailBtn)
	self.gameObject:GetComponent("Button").onClick:AddListener(self.OnItemClickDelegate)
end

function RoleStageItemView:RemoveListener()
	self.detailBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickDetailBtn)
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.OnItemClickDelegate)
end

function RoleStageItemView:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.stageImage = nil
end

function RoleStageItemView:OnItemClick()
	self.mainView:ShowStageDetail(self.Data.Id)
end

function RoleStageItemView:OnClickDetailBtn()
	self.mainView:ShowStageAward(self.Data.FirstReward)
end

function RoleStageItemView:ResetState()
	LuaUtility.SetGameObjectShow(self.SelectedImg, false)
end

function RoleStageItemView:Refresh(Data, index)
	self:ResetState()

	self.Data = Data

	local warlockData = WarlockModule.GetHeroData(self.mainView.heroCid)

	LuaUtility.SetText(self.Name, self.Data.Name)
	LuaUtility.SetGameObjectShow(self.lockState, not ConditionModule.Check(self.Data.ShowConditionId))
	LuaUtility.SetText(self.lockText, ConditionModule.GetDesc(self.Data.ShowConditionId))
	LuaUtility.SetText(self.numText, index < 10 and "0" .. index or index)
	LuaUtility.LoadImage(self, ChapterStageMapUIApi:GetMarkImagePath(self.Data.ListImg), self.stageImage)
	LuaUtility.SetGameObjectShow(self.hadGot, warlockData:GetFavorDupIsFinished(self.Data.Id))
end

return RoleStageItemView
