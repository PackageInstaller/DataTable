---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")


--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarScrapeRewardNode.prefab > name: OverseaClubCatCarScrapeRewardNode
---@class OverseaClubCatCarScrapeRewardNode
---@field Env                           	OverseaClubCatCarScrapeRewardNode       
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtTitle                      	UnityEngine.RectTransform               	@ 0    
---@field RewardList                    	UnityEngine.RectTransform               	@ 1    
local OverseaClubCatCarScrapeRewardNode = Class("OverseaClubCatCarScrapeRewardNode")

---@class OverseaClubCatCarScrapeRewardNode.InputData
---@field type number 一等奖 二等奖...
---@field rewardList OverseaClubCatCarDojo.CallConf[]

function OverseaClubCatCarScrapeRewardNode:__init()
    self.controller = nil
end

function OverseaClubCatCarScrapeRewardNode:__delete()
    self.controller = nil
end

function OverseaClubCatCarScrapeRewardNode:Awake()
end

---@param inData OverseaClubCatCarScrapeRewardNode.InputData
function OverseaClubCatCarScrapeRewardNode:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubCatCarScrapeRewardNode:RefreshUI()
    CfUtils.FillText(self.TxtTitle, OverseaClubCatCarUtils:GetRewardLevelName(self.inData.type))
    self:RefreshList()
end

function OverseaClubCatCarScrapeRewardNode:RefreshList()
    ---@type CommonList
    local poolList = CfUtils.GetLuaScr(self.RewardList, "Game.Behaviours.CommonList")
    if not poolList.inited then
        poolList:Initialize(#self.inData.rewardList, Bind(self, self.OnGetItemByIndex))
    else
        poolList:RefreshUI(#self.inData.rewardList)
    end
end

function OverseaClubCatCarScrapeRewardNode:OnGetItemByIndex(listView, go, index)
    ---@type OverseaClubCatCarScrapeRewardItem
    local itemEnv = CfUtils.GetLuaScr(go, "Game.UI.Club.CatCar.Scrape.OverseaClubCatCarScrapeRewardItem")
    itemEnv:RefreshData(self.inData.rewardList[index])
end

return OverseaClubCatCarScrapeRewardNode