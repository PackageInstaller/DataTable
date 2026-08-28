
local overtakeTime = 1

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarOnRoadNode.prefab > name: OverseaClubCatCarOnRoadNode
---@class OverseaClubCatCarNode
---@field Env                           	OverseaClubCatCarNode                   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnCar                        	UnityEngine.RectTransform               	@ 0    
---@field CarSpine                      	Spine.Unity.SkeletonGraphic             	@ 1    
---@field CommonPlayerHeadNode1         	UnityEngine.RectTransform               	@ 2    
---@field CommonPlayerHeadNode2         	UnityEngine.RectTransform               	@ 3    
---@field CommonPlayerHeadNode3         	UnityEngine.RectTransform               	@ 4    
---@field TextName                      	UnityEngine.RectTransform               	@ 5    
---@field TextRank                      	UnityEngine.RectTransform               	@ 6    
---@field TextPoints                    	UnityEngine.RectTransform               	@ 7    
---@field BubbleNode                    	UnityEngine.RectTransform               	@ 8    
---@field TextBubble                    	UnityEngine.RectTransform               	@ 9    
local OverseaClubCatCarNode = Class("OverseaClubCatCarNode")

---@class OverseaClubCatCarNode.InputData
---@field playerClubScore number 玩家社团分数
---@field clubCatCatInfo OverseaClubCatCarDojo.RankInfo
---@field exit boolean 是否是退出的节点
---@field enter boolean 是否是进入的节点
---@field bubbleText string 气泡文本
---@field movePerformance boolean 是否移动表现

function OverseaClubCatCarNode:__init()
    self.controller = nil
end

function OverseaClubCatCarNode:__delete()
    self.controller = nil
end

function OverseaClubCatCarNode:Awake()
    SetButtonAction(self.BtnCar, Bind(self, self.OnCarClick))
end

---@param inData OverseaClubCatCarNode.InputData
function OverseaClubCatCarNode:RefreshData(inData)
    self.inData = inData
    CfUtils.SetActive(self.controller.gameObject, true)
    self:RefreshUI()
end

function OverseaClubCatCarNode:GetCarRankInfo()
    return self.inData.clubCatCatInfo
end

function OverseaClubCatCarNode:RefreshUI()
    CfUtils.SetActive(self.CommonPlayerHeadNode1, false)
    CfUtils.SetActive(self.CommonPlayerHeadNode2, false)
    CfUtils.SetActive(self.CommonPlayerHeadNode3, false)
    
    if self.inData.clubCatCatInfo then
        for i, v in ipairs(self.inData.clubCatCatInfo.playerInfo) do
            local commonPlayerHeadNode = self["CommonPlayerHeadNode"..i]
            if commonPlayerHeadNode then
                ---@type CommonPlayerHeadNode
                local commonPlayerHeadNodeEnv = CfUtils.GetLuaScr(commonPlayerHeadNode,Constants.UILuaTablePath.ComPlayerHead)
                CfUtils.SetActive(commonPlayerHeadNode.gameObject, true)
                commonPlayerHeadNodeEnv:FreshAvatarFrame(v.avatar ,v.avatarFrame)
                commonPlayerHeadNodeEnv:SetCallBack(function()
                    GameUtils.ShowPlayerInfo( v.playerId, nil, nil, {
                        enterType = "ClubCatCar",
                        panelMode = true,
                    })
                end)
            end
        end
        if self.inData.clubCatCatInfo.clubName then
            CfUtils.FillText(self.TextName, self.inData.clubCatCatInfo.clubName)
        else
            CfUtils.SetActive(self.TextName.gameObject, false)
        end
        CfUtils.FillText(self.TextRank, self.inData.clubCatCatInfo.ranking)
        CfUtils.FillText(self.TextPoints, self.inData.clubCatCatInfo.score)
    end

    if self.inData.bubbleText and not string.isEmpty(self.inData.bubbleText) then
        CfUtils.SetActive(self.BubbleNode.gameObject, true)
        CfUtils.FillText(self.TextBubble, self.inData.bubbleText)
    else
        CfUtils.SetActive(self.BubbleNode.gameObject, false)
    end

    if self.inData.movePerformance then
        self:CarMovePerformance()
    else
        self:SetIdle()
    end
end

function OverseaClubCatCarNode:CarMovePerformance()
    self:SetRun()
    if self.inData.exit then
        self.controller.transform:DOLocalMoveX(-1500, overtakeTime):OnComplete(function()
            CfUtils.SetActive(self.controller.gameObject, false)
        end)
        return
    end
    
    local x = (self.inData.clubCatCatInfo.score - self.inData.playerClubScore)
    local ratio = checkNumber(ClubUtils.GetParamValue(ClubUtils.ParamsId.Car_Distance_Ratio))
    if ratio == 0 then
        ratio = 10
    end
    local absFlag = 1
    if x < 0 then
        absFlag = -1
    end
    x = math.abs(x)
    if x < 15 then
        x = x * ratio
    else
        x = 15 * ratio + x * 7
    end
    
    if x > 700 then
        x = 700
    end
    
    x = x * absFlag
    if self.inData.enter then
        local pos = self.controller.transform.localPosition
        self.controller.transform.localPosition = Vector3(1500, pos.y, pos.z)
    end
    self.controller.transform:DOLocalMoveX(x, overtakeTime):OnComplete(function()
        self:SetIdle()
    end)
end

function OverseaClubCatCarNode:SetIdle()
    self.CarSpine.AnimationState:SetAnimation(0, "Idle", true)
end

function OverseaClubCatCarNode:SetRun()
    self.CarSpine.AnimationState:SetAnimation(0, "Run", true)
end

function OverseaClubCatCarNode:OnCarClick()
    if checkNumber(self.inData.clubCatCatInfo.isMyClub) == 1 then
        CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubCatCarRankDialog,{type = ClubUtils.BossRankType.ClubMember})
    else
        CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubCatCarRankDialog)
    end
    
end

return OverseaClubCatCarNode