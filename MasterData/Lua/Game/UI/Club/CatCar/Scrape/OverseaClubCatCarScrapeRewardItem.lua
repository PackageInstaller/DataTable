---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarScrapeRewardItem.prefab > name: OverseaClubCatCarScrapeRewardItem
---@class OverseaClubCatCarScrapeRewardItem
---@field Env                           	OverseaClubCatCarScrapeRewardItem       
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtNum                        	UnityEngine.RectTransform               	@ 0    
---@field ImgBg                         	UnityEngine.RectTransform               	@ 1    
---@field GoodNode                      	UnityEngine.RectTransform               	@ 2    
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               	@ 3    
local OverseaClubCatCarScrapeRewardItem = Class("OverseaClubCatCarScrapeRewardItem")

---@class OverseaClubCatCarScrapeRewardItem.InputData
---@field opened boolean
---@field num number
---@field reward Reward
---@field playerData CommonPlayerHeadNode.Data

function OverseaClubCatCarScrapeRewardItem:__init()
    self.controller = nil
    self.events = {}
    --self.events[ClubUtils.EventName.Dice_Submit] = Events.AddListener(ClubUtils.EventName.Dice_Submit,Bind(self,self.OnSubmitPoints))
end

function OverseaClubCatCarScrapeRewardItem:__delete()
    self.controller = nil
    self.inData =  nil
    for i, v in pairs(self.events) do
        Events.RemoveListener(i,v)
    end
end

function OverseaClubCatCarScrapeRewardItem:Awake()
end

---@param inData OverseaClubCatCarDojo.CallConf
function OverseaClubCatCarScrapeRewardItem:RefreshData(inData)
    self.inData = inData
    if self.inData.new then
        self:PlayOpenAnim()
    end
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubCatCarScrapeRewardItem:RefreshUI()
    if checkNumber(self.inData.avatar) == 0 then
        CfUtils.SetActive(self.ImgBg,true)
        CfUtils.SetActive(self.TxtNum.gameObject, true)
        CfUtils.SetActive(self.GoodNode.gameObject, false)
        CfUtils.SetActive(self.CommonPlayerHeadNode.gameObject, false)
        CfUtils.FillText(self.TxtNum, table.concat({"No.", self.inData.id}))
    else
        CfUtils.SetActive(self.ImgBg,false)
        CfUtils.SetActive(self.TxtNum.gameObject, false)
        CfUtils.SetActive(self.GoodNode.gameObject, true)
        CfUtils.SetActive(self.CommonPlayerHeadNode.gameObject, true)
        
        ---@type GoodNodeMB
        local goodNodeMbEnv = CfUtils.GetLuaScr(self.GoodNode,Constants.UILuaTablePath.GoodNodeMB)
        local reward = self.inData.rewards[1]
        goodNodeMbEnv:Reload({
            goodsId = reward.goodsId,
            text = string.format("x%d", reward.num),
            isShowNo = true
        })
        
        ---@type CommonPlayerHeadNode
        local commonPlayerHeadNodeEnv = CfUtils.GetLuaScr(self.CommonPlayerHeadNode,Constants.UILuaTablePath.ComPlayerHead)
        commonPlayerHeadNodeEnv:FreshAvatarFrame(self.inData.avatar, self.inData.avatarFrame)
    end
end

function OverseaClubCatCarScrapeRewardItem:PlayOpenAnim()
    CfUtils.PlayAnimation(self.controller.gameObject, "OverseaClubCatCarScrapeRewardNode_Open")
end
-----回对象池会调用此方法
--function OverseaClubCatCarScrapeRewardItem:OnReset()
--    self.inData = nil
--end

return OverseaClubCatCarScrapeRewardItem