--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityCatGirlPK12003201/ActivityCatGirlPKRankingDialog.prefab > name: ActivityCatGirlPKRankingDialog
---@class ActivityCatGirlPKRankingDialog
---@field Env                           	ActivityCatGirlPKRankingDialog          
---@field controller                    	Engine.UI.UILuaDialog                   
---@field PlayerHeadNode1               	UnityEngine.RectTransform               	@ 0    
---@field PlayerHeadNode2               	UnityEngine.RectTransform               	@ 1    
---@field PlayerHeadNode3               	UnityEngine.RectTransform               	@ 2    
---@field BtnListReward                 	UnityEngine.RectTransform               	@ 3    
---@field EmptyNode                     	UnityEngine.RectTransform               	@ 4    
---@field BtnRankingDesc                	UnityEngine.RectTransform               	@ 5    
---@field ScrollView                    	SuperScrollView.LoopListView2           	@ 6    
---@field MyRanking                     	UnityEngine.RectTransform               	@ 7    
local ActivityCatGirlPKRankingDialog = Class('ActivityCatGirlPKRankingDialog')
local UIModule = CS.Engine.UI.UIModule
local GameObject = CS.UnityEngine.GameObject
local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool
---@type ActivityVoteComponent
local ActivityVoteComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityVoteComponent)
function ActivityCatGirlPKRankingDialog:__init()
end


function ActivityCatGirlPKRankingDialog:__delete()
end


function ActivityCatGirlPKRankingDialog:Awake()
    SetButtonAction(self.BtnListReward ,Bind(self, self.ListRewardClick))
    SetButtonAction(self.BtnRankingDesc ,Bind(self, self.LookRankVoteClicK))
end
-- 打开各排名票数一览
function ActivityCatGirlPKRankingDialog:LookRankVoteClicK()
    UIModule.OpenDialog({id = Constants.UITypeIds.ActivityCatGirlPKRankingDescPopup})
end
-- 打开投票奖励一览
function ActivityCatGirlPKRankingDialog:ListRewardClick()
    UIModule.OpenDialog({id = Constants.UITypeIds.ActivityCatGirlPKRankingListRewardPopup})
end


function ActivityCatGirlPKRankingDialog:UpdatePlayerHeadNode()
    local listNode = {self.PlayerHeadNode1 , self.PlayerHeadNode2, self.PlayerHeadNode3 }
    local votes = ActivityVoteComponent:GetVoteRank()
    for i = 1 , 3 do
        if votes[i] then
            local Item2 = listNode[i]
            KTool.SetActive(listNode[i].gameObject, true)
            if isNotNull(Item2) then
                local CommonPlayerHeadNode =  Item2:Find("CommonPlayerHeadNode")
                if CommonPlayerHeadNode then
                    ---@type CommonPlayerHeadNode
                    local headEnv  = CfUtils.GetLuaScr(CommonPlayerHeadNode, "Game.Behaviours.CommonPlayerHeadNode")
                    if headEnv then
                        --种类区分：1头像2头像框3徽章4主题
                        local avatar = votes[i].avatar
                        local avatarFrame = votes[i].avatarFrame
                        headEnv:FreshHeadIcon(avatar, false)
                        headEnv:FreshFrame(avatarFrame, false)
                    end
                end
                local name = votes[i].name
                local TxtName  = Item2:Find("TxtName")
                CfUtils.FillText(TxtName ,name)
            end
        else
            KTool.SetActive(listNode[i].gameObject, false)
        end
    end
end
--region private
---刷新UI
function ActivityCatGirlPKRankingDialog:RefreshUI()
    local votes = ActivityVoteComponent:GetVoteRank()
    if #votes > 0 then
        if not self.ScrollView.IsListViewInit then
            self.ScrollView:InitListView(#votes, Bind(self, self.OnGetItemByIndex))
        else
            GameUtils.ReloadData(self.ScrollView, #votes)
        end    
        KTool.SetActive(self.MyRanking, true)
      
    else 
        KTool.SetActive(self.EmptyNode , true)
    end
    local playerPank = clone(ActivityVoteComponent:GetPlayerRank()) or {}
    if table.count(playerPank) > 0 then
        playerPank.avatar = GameUtils.GetPlayerDojo().playerAvatar
        playerPank.score = playerPank.voteNum
        playerPank.avatarFrame = GameUtils.GetPlayerDojo().playerAvatarFrame
        playerPank.name = GameUtils.GetPlayerDojo().playerName
        playerPank.level = GameUtils.GetPlayerDojo().level
        playerPank.ranking = checkInt(playerPank.ranking)
        playerPank.percentageRank = ActivityVoteComponent:GetDojo().percentageRank
        ---@type ActivityCatGirlPKRankingCell
        local nodeEnv =  CfUtils.GetLuaScr(self.MyRanking  , "Game.UI.CatGirlPK.ActivityCatGirlPKRankingCell") 
        nodeEnv:RefreshShow(playerPank , true)
    end  
end
---列表刷新
function ActivityCatGirlPKRankingDialog:OnGetItemByIndex(listView, index)
    local cell = listView:NewListViewItem("CatGirlPKRankingCell")
    ---@type ActivityCatGirlPKRankingCell
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.UI.CatGirlPK.ActivityCatGirlPKRankingCell")
    if nodeEnv then
        nodeEnv:RefreshShow(ActivityVoteComponent:GetVoteRank()[index+1])
    end
    return cell
end

function ActivityCatGirlPKRankingDialog:OnInitialize()
    return CoWaitDo(function()
        local activityUuid = ActivityVoteComponent:GetActivityUuid()
        GameUtils.Request(Interfaces.ActivityVoteRank , {activityUuid = activityUuid} ,function(request, response) 
            if checkNumber(response.errCode) ~= 0 then
                return
            end
            local jsonData = response.data 
            ActivityVoteComponent:UpdateRank(jsonData) 
        end)
        local initParams = self.controller.Argument.parameters or {}
        self:UpdatePlayerHeadNode()
        self:RefreshUI()
    end)
end


function ActivityCatGirlPKRankingDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return ActivityCatGirlPKRankingDialog
