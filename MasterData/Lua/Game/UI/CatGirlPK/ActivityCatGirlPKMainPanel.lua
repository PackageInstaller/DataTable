
--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityCatGirlPK12003201/ActivityCatGirlPKMainPanel.prefab > name: ActivityCatGirlPKMainPanel
---@class ActivityCatGirlPKMainPanel
---@field Env                           	ActivityCatGirlPKMainPanel              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BossDrawingNode               	Game.Native.Common.DrawingNode          	@ 0    
---@field ImgSofa                       	UnityEngine.RectTransform               	@ 1    
---@field RoleDetails                   	UnityEngine.RectTransform               	@ 2    
---@field VoteTxtNum                    	UnityEngine.RectTransform               	@ 3    
---@field CardTxtName                   	UnityEngine.RectTransform               	@ 4    
---@field CardTxtNameCV                 	UnityEngine.RectTransform               	@ 5    
---@field filterlOpen                   	UnityEngine.RectTransform               	@ 6    
---@field filterFinish                  	UnityEngine.RectTransform               	@ 7    
---@field filteTimeTxt                  	UnityEngine.RectTransform               	@ 8    
---@field WeedOutLock                   	UnityEngine.RectTransform               	@ 9    
---@field WeedOutOpen                   	UnityEngine.RectTransform               	@ 10   
---@field WeedOutFinish                 	UnityEngine.RectTransform               	@ 11   
---@field WeedOutTimeTxt                	UnityEngine.RectTransform               	@ 12   
---@field FinalLock                     	UnityEngine.RectTransform               	@ 13   
---@field FinalOpen                     	UnityEngine.RectTransform               	@ 14   
---@field FinalFinish                   	UnityEngine.RectTransform               	@ 15   
---@field FinalTxtTime                  	UnityEngine.RectTransform               	@ 16   
---@field Empty                         	UnityEngine.RectTransform               	@ 17   
---@field PlaceholderGroup              	UnityEngine.RectTransform               	@ 18   
---@field ListNode1                     	UnityEngine.RectTransform               	@ 19   
---@field ListNode2                     	UnityEngine.RectTransform               	@ 20   
---@field ListNode3                     	UnityEngine.RectTransform               	@ 21   
---@field BtnVotingRewards              	UnityEngine.RectTransform               	@ 22   
---@field BtnGetTicket                  	UnityEngine.RectTransform               	@ 23   
---@field ButtonVote                    	UnityEngine.RectTransform               	@ 24   
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               	@ 25   
---@field ProgressLine                  	UnityEngine.UI.Image                    	@ 26   
---@field ImgTitleBg                    	UnityEngine.RectTransform               	@ 27   
---@field RankingGroup                  	UnityEngine.RectTransform               	@ 28   
---@field BtnChange                     	UnityEngine.RectTransform               	@ 29   
---@field Text2                         	UnityEngine.RectTransform               	@ 30   
---@field Image                         	UnityEngine.RectTransform               	@ 31   
---@field ImgGoodsIcon                  	UnityEngine.RectTransform               	@ 32   
local ActivityCatGirlPKMainPanel = Class('ActivityCatGirlPKMainPanel')
local KTool = CS.Engine.Lib.KTool
local CDTimerModule = CS.Engine.Modules.CDTimerModule
---@type ActivityMgr
local ActivityMgr = import('Game.Activity.ActivityMgr'):GetInstance()
---@type GachaponConstants
local GachaponConstants = import('Game.Gachapon.GachaponConstants')
---@field ActivityVoteComponent ActivityVoteComponent
---@field ActivityVoteDojo ActivityVoteDojo
local UIModule = CS.Engine.UI.UIModule
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine'
local Yielders = CS.Engine.Lib.Yielders
function ActivityCatGirlPKMainPanel:__init()
    ---@type ActivityVoteComponent
    self.ActivityVoteComponent = nil
    ---@type ActivityVoteDojo
    self.ActivityVoteDojo = nil
    self.screenPrefab = nil
    self.scenePrefab = nil
    self.co = nil
    self.timer = nil
    self.roleLobbyPrefab = nil

end
---@return ActivityVoteDojo
function ActivityCatGirlPKMainPanel:GetActivityVoteDojo()
    self.ActivityVoteDojo = self.ActivityVoteComponent:GetDojo()   
    return self.ActivityVoteDojo
end
function ActivityCatGirlPKMainPanel:__delete()
    self.ActivityVoteComponent = nil
    self.ActivityVoteDojo = nil
    self.screenPrefab = nil
    self.scenePrefab = nil
    self.co = nil
    self.roleCo = nil
    self.timer = nil
    self.roleLobbyPrefab = nil
end


function ActivityCatGirlPKMainPanel:Awake()
    -- 每日任务
    SetButtonAction(self.BtnGetTicket , Bind(self,self.DailyTaskClick))
    -- 获得投票奖励
    SetButtonAction(self.BtnVotingRewards , Bind(self,self.VoteRewardsClick))
    -- 投票
    SetButtonAction(self.ButtonVote , Bind(self,self.VoteClick))
    SetButtonAction(self.ImgTitleBg , Bind(self,self.VotePlayerRankClick))
end

function ActivityCatGirlPKMainPanel:ChangeActivityMgrRedPoint()
    if isNotNull(self.ActivityVoteComponent) then      
        ---@type ActivityDojo
        local activityDojo =  ActivityMgr:GetActivityComponent():GetDojoByActivityId(self.activityUuid)
        local isRed = self:CheckTaskRedPoint() or self:CheckVoteRedPoint()
        activityDojo.redDotHint = isRed and 0 or -1 
    end
end

function ActivityCatGirlPKMainPanel:CheckTaskRedPoint()
    ---@type ActivityVoteDojo
    local dojo =  self.ActivityVoteComponent:GetDojo()
    local dailyTask = dojo.dailyTask
    local isRed = false
    if not (dojo.currentRound == 3 and dojo.status > 1) then
        for k, v in pairs(dailyTask) do
            if v.status == 1 then
                isRed = true 
                break
            end
        end 
    end
    return isRed
end
function ActivityCatGirlPKMainPanel:CheckVoteRedPoint()
    ---@type ActivityVoteComponent
    local ActivityVoteComponent = self.ActivityVoteComponent
    local myVoteNum =  ActivityVoteComponent:GetDojo().myVoteNum
    local attendRewards =  ActivityVoteComponent:GetDojo().attendRewards
    local isRed = false
    for k, v in pairs(attendRewards) do
        if v.status == 1 then
            isRed = true
            break
        end
    end
    return isRed
end
function ActivityCatGirlPKMainPanel:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.activityUuid = initParams.activityUuid
        
        self:RequestHome()
        local activity2024pk =  GameUtils.LoadBundleAsync("Prefabs/ActivityCatGirlPK12003201/activity2024pk.prefab" , nil , false)
        self.scenePrefab = activity2024pk
    end)
end

function ActivityCatGirlPKMainPanel:DailyTaskClick()
    --- 打开每日任务
    UIModule.OpenDialog(
        { id = Constants.UITypeIds.ActivityCatGirlPKGetTicketDialog ,  parameters = { isFrom = true}}
    )
end

function ActivityCatGirlPKMainPanel:VoteRewardsClick()
    UIModule.OpenDialog(
        { id = Constants.UITypeIds.ActivityCatGirlPKVoteRewardDialog})
end

function ActivityCatGirlPKMainPanel:VoteClick()
    UIModule.OpenDialog(
        { id = Constants.UITypeIds.ActivityCatGirlPKCardAndRoleDialog},
        { 
            { id = Constants.UITypeIds.ActivityCatGirlPKMainPanel } ,
            { id = Constants.UITypeIds.UIActivityMainDialog } 
        })
end

function ActivityCatGirlPKMainPanel:VotePlayerRankClick()
    -- 打开应援排行榜
    UIModule.OpenDialog(
        { id = Constants.UITypeIds.ActivityCatGirlPKRankingDialog})
    
end

function ActivityCatGirlPKMainPanel:RequestHome()
    GameUtils.Request(Interfaces.ActivityVoteHome , {activityUuid =  self.activityUuid } ,function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        local jsonData = response.data 
        ---@type ActivityVoteComponent
        local ActivityVoteComponent =  GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityVoteComponent)
        ActivityVoteComponent:InitData( self.activityUuid , jsonData)
        self.ActivityVoteComponent = ActivityVoteComponent
        GameUtils.Request(Interfaces.ActivityVoteRank ,{activityUuid =  self.activityUuid} ,function(request, response) 
            if checkNumber(response.errCode) ~= 0 then
                return
            end
            local jsonData = response.data 
            self.ActivityVoteComponent:UpdateRank(jsonData) 
            self:InitUI()
            -- CfUtils.FillCommonBtnConsumePopNode(self.CommonBtnConsumePop, voteGoodsId, GoodsUtils.GetThingNo(voteGoodsId))
        end)
    end)
end
--- func desc 获取当前轮动画是否播放
---@param currentRound integer @ 当前的轮数  1. 筛选赛 2.淘汰赛 3.晋级赛
function ActivityCatGirlPKMainPanel:GetCurrentRoundActionCache(currentRound)
    local activityUuid = self.ActivityVoteComponent:GetActivityUuid()
    local currentRound = self.ActivityVoteComponent:GetDojo().currentRound
    local isSave = CfUtils.GetLocalData("ActivityCatGirlPKMainPanel_".. activityUuid .. "_" .. currentRound , 0 )
    return checkInt(isSave) 
end

--- func desc 写入动画播放
---@param currentRound integer @ 当前的轮数  1. 筛选赛 2.淘汰赛 3.晋级赛
function ActivityCatGirlPKMainPanel:WriteCurrentRoundActionCache(currentRound)
    local activityUuid = self.ActivityVoteComponent:GetActivityUuid()
    local currentRound = self.ActivityVoteComponent:GetDojo().currentRound
    CfUtils.WriteLocalData("ActivityCatGirlPKMainPanel_".. activityUuid .. "_" .. currentRound , 1)
end

function ActivityCatGirlPKMainPanel:InitUI()
    local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
    CriWareUtils.PlayMusicById(self:GetActivityVoteDojo().bgm)
    self:UpdateLeftUI()
    self:UpdateRightLayout()
    local currentRound = self.ActivityVoteComponent:GetDojo().currentRound
    local isSave = self:GetCurrentRoundActionCache(currentRound)
    if isSave == 0 then
        self.co = cs_coroutine.start(function ()
            self.screenPrefab =  GameUtils.LoadBundleAsync("Prefabs/ActivityCatGirlPK12003201/ActivityCatGirlPKScreenStartsDialog.prefab",self.controller , false)
            self.screenPrefab.transform.localPosition =  Vector3.New(0, 0,0)
        end)
    end
    local voteGoodsId = self.ActivityVoteComponent:GetVoteGoodsId()
    CfUtils.RefreshTopGoods({voteGoodsId})
    self:UpdateMiddlePanel()
end

function ActivityCatGirlPKMainPanel:UpdateLeftUI()
    local prograssData = {
        {open = self.filterlOpen , finish = self.filterFinish , time = self.filteTimeTxt},
        {open = self.WeedOutOpen , finish = self.WeedOutFinish , time = self.WeedOutTimeTxt , lock = self.WeedOutLock},
        {open = self.FinalOpen , finish = self.FinalFinish , time = self.FinalTxtTime , lock = self.FinalLock }
    }
    local dojo = self.ActivityVoteComponent:GetDojo()
    local currentRound = checkInt(dojo.currentRound) 
    local status = dojo.status
    local currentStageLeftSeconds = dojo.currentStageLeftSeconds
    for i = 1 , #prograssData do
        if currentRound > i then
            local lock =  prograssData[i].lock
            if isNotNull(lock) then
                KTool.SetActive(lock , false)
            end
            local finish = prograssData[i].finish
            local open = prograssData[i].open 
            KTool.SetActive(finish , true)
            KTool.SetActive(open , false)
            KTool.SetActive(prograssData[i].time  , false) 
        elseif currentRound == i then
            local lock =  prograssData[i].lock
            if isNotNull(lock) then
                KTool.SetActive(lock.gameObject , false)
            end
            local finish = prograssData[i].finish
            local time = prograssData[i].time
            local open = prograssData[i].open 
            if status == 1 then
                KTool.SetActive(open , true)
                KTool.SetActive(finish , false)
                KTool.SetActive(time , true)
                CfUtils.FillText(time ,CfUtils.GetTimeHMS2(currentStageLeftSeconds))
                local endTime = self.ActivityVoteComponent:GetDojo().endTime
                ---@type PlayerDojo
                local playerDojo =   GameUtils.GetPlayerDojo()
                self.timer = CDTimerModule:GetInstance():AddCD(1, function(count, id)
                    local leftSecondTime = endTime - playerDojo:GetServerTime()
                    if leftSecondTime <= 0 then
                        -- 结束
                        CDTimerModule.GetInstance():RemoveCD(self.timer)
                        self.timer = nil
                        KTool.SetActive(open , false)
                        KTool.SetActive(lock , false)
                        KTool.SetActive(finish , true)
                        KTool.SetActive(time , false)
                        self:GetActivityVoteDojo().status = 2
                        local status = self:GetActivityVoteDojo().status
                        if currentRound < 3 then
                            local percent = status  == 1 and 0.25 or 0.5 
                            self.ProgressLine.fillAmount = (currentRound - 1) * 0.5 + percent
                        else 
                            KTool.SetActive(self.BtnGetTicket , false)
                            self.ProgressLine.fillAmount = 1
                        end
                    else
                        CfUtils.FillText(time, CfUtils.GetTimeHMS2(leftSecondTime))
                    end
                end,  endTime - playerDojo:GetServerTime() + 10000, false, true, true)
            else
                KTool.SetActive(open , false)
                KTool.SetActive(lock , false)
                KTool.SetActive(finish , true)
                KTool.SetActive(time , false)
            end
        else     
            local lock =  prograssData[i].lock
            local finish =  prograssData[i].finish
            local time =  prograssData[i].time
            local open = prograssData[i].open 
            if isNotNull(lock) then
                KTool.SetActive(lock , true)
            end
            KTool.SetActive(finish , false)
            KTool.SetActive(open , false)
            KTool.SetActive(time , false)
        end
    end
    if currentRound < 3 then
        local percent = status  == 1 and 0.25 or 0.5 
        self.ProgressLine.fillAmount = (currentRound - 1) * 0.5 + percent
    else 
        self.ProgressLine.fillAmount = 1
    end
end

function ActivityCatGirlPKMainPanel:UpdateMiddlePanel()
    local voteRank = self.ActivityVoteComponent:GetVotesRoleRank()
    SetButtonAction(self.BtnChange , function ()
        if not KTool.IsActive(self.BossDrawingNode) then
            local cardVo = CardConfMgr:GetInstance():GetCardByRefId(voteRank[1].cardId)
	        self.BossDrawingNode:Execute(checkNumber(cardVo.defaultSkin))
            CfUtils.SetUISwitchImage(self.BtnChange , 2)
            KTool.SetActive(self.roleLobbyPrefab , false)
            KTool.SetActive(self.BossDrawingNode , true)
        else 
            CfUtils.SetUISwitchImage(self.BtnChange , 1)
            KTool.SetActive(self.roleLobbyPrefab.gameObject , true)
            KTool.SetActive(self.BossDrawingNode.gameObject, false)
        end
    end)
    local firstValue = voteRank[1].value 
    if firstValue == 0 then
        KTool.SetActive(self.ImgSofa , true)
        KTool.SetActive(self.RoleDetails , false)
    else 
        KTool.SetActive(self.ImgSofa , false)
        KTool.SetActive(self.RoleDetails , true)
        ---@type CardVo
        local cardVo = CfUtils.GetCfVo(AutoIds.IdSetting28, 'CardVo' , voteRank[1].cardId)
        local rolePrefabPath = string.format(GachaponConstants.RoleLobbyResPath, cardVo.cultivateRes)
        if isNotNull(self.scenePrefab) then
            ---@type UnityEngine.Transform
            local transform = self.scenePrefab.transform 
            local Chr = transform:Find("Chr")
            if isNotNull(Chr) then
                self.roleCo = cs_coroutine.start(function ()
                    self.roleLobbyPrefab = GameUtils.LoadBundleAsync(rolePrefabPath , Chr , false)    
                    self.roleLobbyPrefab.transform.localPosition = Vector3(0,0,0)
                end)
            end
        end 
        self:UpdateRoleDetail()
    end
end

function ActivityCatGirlPKMainPanel:UpdateRoleDetail()
    local voteRank = self.ActivityVoteComponent:GetVotesRoleRank()
    if #voteRank > 0 then
        ---@type CardVo
        local cardVo = CfUtils.GetCfVo(AutoIds.IdSetting28, 'CardVo' , voteRank[1].cardId)
        ---@type CardSkinVo
        local cardSkinVo = CfUtils.GetCfVo(AutoIds.IdSetting113, "CardSkinVo", cardVo.defaultSkin)
        CfUtils.FillText(self.CardTxtName , cardSkinVo.desc) 
        CfUtils.FillText(self.TxtNameArmed , cardSkinVo.name)
        CfUtils.FillText(self.CardTxtNameCV , cardVo.cv) 
        CfUtils.FillText(self.VoteTxtNum , voteRank[1].value) 
        local voteGoodsId = self.ActivityVoteComponent:GetVoteGoodsId()
        CfUtils.FillImage(self.ImgGoodsIcon ,GoodsConfMgr:GetInstance():GetPhotoPathById(voteGoodsId) )
    end
end
function ActivityCatGirlPKMainPanel:UpdateRightLayout()
    if not (self.ActivityVoteComponent:GetDojo().currentRound == 3 and self.ActivityVoteComponent:GetDojo().status >=2) then
        KTool.SetActive(self.BtnGetTicket , true)
    end
    local redPoint =  self.BtnGetTicket.transform:Find("redPoint")
    if isNotNull(redPoint) then
        local isRed = self:CheckTaskRedPoint()
        KTool.SetActive(redPoint , isRed)
    end
    local redPoint =  self.BtnVotingRewards.transform:Find("redPoint")
    if isNotNull(redPoint) then
        local isRed = self:CheckVoteRedPoint()
        KTool.SetActive(redPoint , isRed)
    end
    local voteGoodsId = self.ActivityVoteComponent:GetVoteGoodsId()
    local currentRound = self:GetActivityVoteDojo().currentRound
    local status = self:GetActivityVoteDojo().status
    if currentRound == 3 and status > 1 then
        KTool.SetActive(self.BtnGetTicket , false)
    end
    CfUtils.FillImage(self.Image , GoodsConfMgr:GetInstance():GetPhotoPathById(voteGoodsId))
    CfUtils.FillText(self.Text2 ,  GoodsUtils.GetThingNo(voteGoodsId))
    self:UpdatPlayerRank()
end
function ActivityCatGirlPKMainPanel:UpdatPlayerRank()
    local votes =  self.ActivityVoteComponent:GetVoteRank()
    if isNull(votes) then
        return
    end
    if #votes == 0 then
        KTool.SetActive(self.Empty  , true) 
        KTool.SetActive(self.PlaceholderGroup , false)
    else 
        KTool.SetActive(self.PlaceholderGroup , true)
        KTool.SetActive(self.Empty , false)
        ---@type UnityEngine.RectTransform[]
        local listNode = {self.ListNode1 , self.ListNode2 , self.ListNode3} 
        for i = 1 , 3 do
            if votes[i] then
                local Item1 = listNode[i].transform:Find("Item1")
                if isNotNull(Item1) then
                    KTool.SetActive(Item1.gameObject , false)
                end
                local Item2 = listNode[i].transform:Find("Item2")
                if isNotNull(Item2) then
                    local CommonPlayerHeadNode =  Item2:Find("CommonPlayerHeadNode")
                    ---@type Engine.Modules.LuaStub
                    local LuaStub =  KTool.GetComponent(CommonPlayerHeadNode.gameObject , typeof(CS.Engine.Modules.LuaStub))
                    local CommonPlayerHeadNode =  LuaStub:InstantiatePrefab("CommonPlayerHeadNode")
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
                local Item1 = listNode[i].transform:Find("Item1")
                if isNotNull(Item1) then
                    KTool.SetActive(Item1.gameObject , true)
                end
                local Item2 = listNode[i].transform:Find("Item2")
                if isNotNull(Item2) then
                    KTool.SetActive(Item2.gameObject , false)
                end
            end
        end
    end
end
function ActivityCatGirlPKMainPanel:OnFocus(focus)
    if focus and isNotNull(self.ActivityVoteComponent)  then
        local voteGoodsId = self.ActivityVoteComponent:GetVoteGoodsId()
        CfUtils.RefreshTopGoods({voteGoodsId})
        self:UpdateRightLayout()
    end
end
function ActivityCatGirlPKMainPanel:OnFinalize()
    return CoWaitDo(function()
        self:ChangeActivityMgrRedPoint()
        self.controller = nil --删除lua层引⽤用到的c#对象
        if self.co then
            cs_coroutine.stop(self.co)
            self.co = nil
        end
        -- 消除所有加载到3d 模型
        if isNotNull(self.scenePrefab) then
            CS.UnityEngine.GameObject.Destroy(self.scenePrefab)
            self.scenePrefab = nil
        end
        if self.roleCo then
            cs_coroutine.stop(self.roleCo)
            self.roleCo = nil
        end
        if  isNotNull(self.timer) then
            CDTimerModule.GetInstance():RemoveCD(self.timer)
            self.timer = nil
        end
        self:Delete()
    end)
end


return ActivityCatGirlPKMainPanel