--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarSpeedDialog.prefab > name: ClubRewardTips
---@class ClubRewardTips
---@field Env                           	ClubRewardTips                          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ClickClose                    	UnityEngine.RectTransform               	@ 0    
---@field RewardTips                    	UnityEngine.RectTransform               	@ 1    
---@field CommonList                    	UnityEngine.RectTransform               	@ 2    
local ClubRewardTips = Class("ClubRewardTips")

---@class ClubRewardTips.InputData
---@field rewards Reward[]
---@field pos UnityEngine.Vector3

function ClubRewardTips:__init()
    self.controller = nil
end

function ClubRewardTips:__delete()
    self.controller = nil
end

function ClubRewardTips:Awake()
    SetButtonAction(self.ClickClose,function() 
        CfUtils.SetActive(self.controller.gameObject,false)
    end)
end

---@param inData ClubRewardTips.InputData
function ClubRewardTips:RefreshData(inData)
    self.inData = inData
    CfUtils.SetActive(self.controller.gameObject,true)
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function ClubRewardTips:RefreshUI()
    local targetPostion = self.controller.transform:InverseTransformPoint(self.inData.pos)
    --localPosition基点是中心,转换为左侧
    targetPostion.x = targetPostion.x + self.controller:rectTransform().rect.width / 2
    if targetPostion.x <262 then
        targetPostion.x = 262
    end
    self.RewardTips.anchoredPosition = Vector3(targetPostion.x,self.RewardTips.anchoredPosition.y,self.RewardTips.anchoredPosition.z)
    
    ---@type CommonList
    local commonList = CfUtils.GetLuaScr(self.CommonList,"Game.Behaviours.CommonList")
    if not commonList.inited then
        commonList:Initialize(#self.inData.rewards,Bind(self,self.OnGetItemByIndex))
    else
        commonList:RefreshUI(#self.inData.rewards)
    end
end

function ClubRewardTips:OnGetItemByIndex(commonList,go,index)
    local reward = self.inData.rewards[index]
    local goodNode = go.transform:Find("GoodNode")
    ---@type GoodNodeMB
    local goodNodeMB = CfUtils.GetLuaScr(goodNode,Constants.UILuaTablePath.GoodNodeMB)
    goodNodeMB:Reload({
        goodsId = reward.goodsId,
        text = string.format("x%d", reward.num),
        isShowNo = true
    })
end

return ClubRewardTips