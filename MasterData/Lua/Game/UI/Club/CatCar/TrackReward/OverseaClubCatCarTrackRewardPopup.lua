---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()
---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarTrackRewardPopup.prefab > name: OverseaClubCatCarTrackRewardPopup
---@class OverseaClubCatCarTrackRewardPopup
---@field Env                           	OverseaClubCatCarTrackRewardPopup       
---@field controller                    	Engine.UI.UILuaDialog                   
---@field TabToggleUp                   	UnityEngine.RectTransform               	@ 0    
---@field RewardLoopView                	SuperScrollView.LoopListView2           	@ 1    
local OverseaClubCatCarTrackRewardPopup = Class("OverseaClubCatCarTrackRewardPopup")

---@class OverseaClubCatCarTrackRewardPopup.InputData

function OverseaClubCatCarTrackRewardPopup:__init()
    self.controller = nil
end

function OverseaClubCatCarTrackRewardPopup:__delete()
    self.controller = nil
end

function OverseaClubCatCarTrackRewardPopup:Awake()
end

function OverseaClubCatCarTrackRewardPopup:OnInitialize()
    local parameters = checkTable(self.controller.Argument.parameters)
    self.selectRank = parameters.grade
    if self.selectRank == nil or self.selectRank == 0 then
        self.selectRank = 1
    end
    ---@type OverseaClubCatCarTapCell.InputData[]
    self.tabData ={}
    for i = 1, 5 do
        table.insert(self.tabData, {
            grade = i,
            func = function() 
                self:SwitchTab(i)
            end
        })
    end
    
    CoStart(function()
        CoYield(0.2)
        self:RefreshUI()
    end)
end

---@param inData OverseaClubCatCarTrackRewardPopup.InputData
function OverseaClubCatCarTrackRewardPopup:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubCatCarTrackRewardPopup:RefreshUI()
    self:RefreshTab()
    self:RefreshList()
end

function OverseaClubCatCarTrackRewardPopup:RefreshTab()
    ---@type CommonTabToggleUp
    local tabLua = CfUtils.GetLuaScr(self.TabToggleUp, "Game.Behaviours.CommonTabToggleUp")
    tabLua:CostumeCellEnvPath("Game.UI.Club.CatCar.TrackReward.OverseaClubCatCarTapCell")
    tabLua:FillToggles(self.tabData,self.selectRank)
end

---@class TrackReward
---@field title string
---@field rewards Reward[]

function OverseaClubCatCarTrackRewardPopup:RefreshList()
    if not self.RewardLoopView.IsListViewInit then
        self.RewardLoopView:InitListView(#self:GetCurRankTrackRewards(), Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.RewardLoopView, #self:GetCurRankTrackRewards())
    end
end

---@param index number
function OverseaClubCatCarTrackRewardPopup:OnGetItemByIndex(listView, index)
    local data = self:GetCurRankTrackRewards()[index + 1]
    local cell = listView:NewListViewItem("OverseaClubCatCarTrackRewardNode")
    local txtTitle = cell.transform:Find("ImgTitleBg/TxtTitle")
    if txtTitle then
        CfUtils.FillText(txtTitle, data.title)
    end
    
    local ImgBg = cell.transform:Find("ImgBg")
    local ImgSmybol = cell.transform:Find("ImgSmybol")
    local TitleFirstPrize = cell.transform:Find("TitleFirstPrize")
    if index == 0 then
        local TextDesc = cell.transform:Find("TitleFirstPrize/TextDesc")
        CfUtils.SetUISwitchImage(ImgBg, 2)
        CfUtils.SetActive(ImgSmybol, true)
        CfUtils.SetActive(TitleFirstPrize, true)
        CfUtils.FillText(TextDesc, localize("_level_赛道Boss击败奖励",{_level_ = OverseaClubCatCarUtils:GetNumToLetter(self.selectRank,true)}))
    else
        CfUtils.SetUISwitchImage(ImgBg, 1)
        CfUtils.SetActive(ImgSmybol, false)
        CfUtils.SetActive(TitleFirstPrize, false)
    end

    local commonGoods = cell.transform:Find("GridLayout")
    if commonGoods then
        ---@type CommonGoodsListLight
        local cellLua = CfUtils.GetLuaScr(commonGoods, "Game.Behaviours.CommonGoodsListLight")
        cellLua:FreshBaseUI(data.rewards)
        CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(cell.transform)
    end
    return cell
end

---@return TrackReward[]
function OverseaClubCatCarTrackRewardPopup:GetCurRankTrackRewards()
    if self.trackTewards == nil then
        local result = {}
        ---@type ClubCatCarSpeedGradeVo
        local speedVo = CfUtils.GetCfVo(AutoIds.IdSetting6281,"ClubCatCarSpeedGradeVo",self.selectRank)
        local firstRewardsGroup = CfUtils.GetCfData(AutoIds.IdSetting6282,speedVo.Jackpot,"firstRewardsGroup",Constants.DataType.String)
        local secondRewardsGroup = CfUtils.GetCfData(AutoIds.IdSetting6282,speedVo.Jackpot,"secondRewardsGroup",Constants.DataType.String)
        local thirdRewardsGroup = CfUtils.GetCfData(AutoIds.IdSetting6282,speedVo.Jackpot,"thirdRewardsGroup",Constants.DataType.String)

        ---@type TrackReward
        local oneGroup = {}
        oneGroup.title = OverseaClubCatCarUtils:GetRewardLevelName(1)
        oneGroup.rewards = {}
        local poolRewardsIds = CfUtils.GetIdGroupData(AutoIds.IdSetting6283,firstRewardsGroup)
        for i = 1, #poolRewardsIds do
            local goodsId = CfUtils.GetCfData(AutoIds.IdSetting6283,poolRewardsIds[i],"roleId",Constants.DataType.Int)
            local goodNum = CfUtils.GetCfData(AutoIds.IdSetting6283,poolRewardsIds[i],"itemNum",Constants.DataType.Int)
            table.insert(oneGroup.rewards, { goodsId = goodsId, num = goodNum})
        end
        table.insert(result, oneGroup)

        oneGroup = {}
        oneGroup.title = OverseaClubCatCarUtils:GetRewardLevelName(2)
        oneGroup.rewards = {}
        poolRewardsIds = CfUtils.GetIdGroupData(AutoIds.IdSetting6283,secondRewardsGroup)
        for i = 1, #poolRewardsIds do
            local goodsId = CfUtils.GetCfData(AutoIds.IdSetting6283,poolRewardsIds[i],"roleId",Constants.DataType.Int)
            local goodNum = CfUtils.GetCfData(AutoIds.IdSetting6283,poolRewardsIds[i],"itemNum",Constants.DataType.Int)
            table.insert(oneGroup.rewards, { goodsId = goodsId, num = goodNum})
        end
        table.insert(result, oneGroup)

        oneGroup = {}
        oneGroup.title = OverseaClubCatCarUtils:GetRewardLevelName(3)
        oneGroup.rewards = {}
        poolRewardsIds = CfUtils.GetIdGroupData(AutoIds.IdSetting6283,thirdRewardsGroup)
        for i = 1, #poolRewardsIds do
            local goodsId = CfUtils.GetCfData(AutoIds.IdSetting6283,poolRewardsIds[i],"roleId",Constants.DataType.Int)
            local goodNum = CfUtils.GetCfData(AutoIds.IdSetting6283,poolRewardsIds[i],"itemNum",Constants.DataType.Int)
            table.insert(oneGroup.rewards, { goodsId = goodsId, num = goodNum})
        end
        table.insert(result, oneGroup)
        
        self.trackTewards = result
    end
    
   return self.trackTewards
end

function OverseaClubCatCarTrackRewardPopup:SwitchTab(index)
    self.selectRank = index
    self.trackTewards = nil
    self:RefreshList()
end

return OverseaClubCatCarTrackRewardPopup