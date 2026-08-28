--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinDialog.prefab > name: GachaponSkinDialog
---@class ActivityGachaponWithoutReplacement
---@field Env                           	ActivityGachaponWithoutReplacement      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtProbability                	UnityEngine.RectTransform               	@ 0    
---@field TxtFree                       	UnityEngine.RectTransform               	@ 1    
---@field Text2                         	TMPro.TextMeshProUGUI                   	@ 2    
---@field BtnOneNode                    	UnityEngine.RectTransform               	@ 3    
---@field BtnMember                     	UnityEngine.RectTransform               	@ 4    
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 5    
---@field Image                         	UnityEngine.RectTransform               	@ 6    
---@field ImgState                      	UnityEngine.RectTransform               	@ 7    
---@field BtnOne                        	UnityEngine.RectTransform               	@ 8    
---@field GoodItem10                    	UnityEngine.RectTransform               	@ 9    
---@field GoodItem9                     	UnityEngine.RectTransform               	@ 10   
---@field GoodItem8                     	UnityEngine.RectTransform               	@ 11   
---@field GoodItem7                     	UnityEngine.RectTransform               	@ 12   
---@field GoodItem6                     	UnityEngine.RectTransform               	@ 13   
---@field GoodItem5                     	UnityEngine.RectTransform               	@ 14   
---@field GoodItem4                     	UnityEngine.RectTransform               	@ 15   
---@field GoodItem3                     	UnityEngine.RectTransform               	@ 16   
---@field GoodItem2                     	UnityEngine.RectTransform               	@ 17   
---@field GoodItem1                     	UnityEngine.RectTransform               	@ 18   
---@field RightPanel                    	UnityEngine.RectTransform               	@ 19   
---@field redPoint                      	UnityEngine.RectTransform               	@ 20   
---@field BtnTask                       	UnityEngine.RectTransform               	@ 21   
---@field BtnInteractive                	UnityEngine.RectTransform               	@ 22   
local ActivityGachaponWithoutReplacement = Class('ActivityGachaponWithoutReplacement')
local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool 
local Yielders = CS.Engine.Lib.Yielders
local ActivityGachaponSkinNodePath =  "Game.Activity.GachaponSkin.ActivityGachaponSkinNode"
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine'
function ActivityGachaponWithoutReplacement:__init()
    self.oneSkinData = nil
    self.activity = nil
end


function ActivityGachaponWithoutReplacement:__delete()
    self.oneSkinData = nil
    self.activity = nil
    GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.MainCardSkinCallTask)
    for k,v in pairs(self.EventMap) do
        Events.RemoveListener(k, v)
    end
end


function ActivityGachaponWithoutReplacement:Awake()
    self:AddLuaBehavious()
    local redPointGo = GameUtils.GetRedPointGo(self.BtnTask, self.nTask)
    redPointGo.transform:SetScaleXYZ(0.8,0.8,1)
    GameUtils.BindRedPoint(Constants.RedPointConst.MainCardSkinCallTask,self.BtnTask , true)
    SetButtonAction(self.BtnOne.gameObject ,Bind(self, self.DrawSkinClick)) 
    SetButtonAction(self.BtnMember.gameObject, function()
        if isNotNull(self.oneSkinData) then
            UIModule.OpenDialog({id = Constants.UITypeIds.ActivityGachaponRuleDialog, parameters = {
                activityUuid = self.oneSkinData.id, ruleId = self.activity.ruleId
            } })
        end
    end)

    -- 目前 深度互动 不再支持 试玩功能; 直接把按钮隐藏; 
    CfUtils.SetActive( self.BtnInteractive, false )
    --[[
    SetButtonAction(self.BtnInteractive , function()
        if isNull(self.oneSkinData) then
            return
        end
        local rewardList = self.oneSkinData.rewardList
        local count = #rewardList 
        local rewards = rewardList[count].rewards
        local skinId = rewards[1].goodsId
        ---
        local IdolLive3D_Loader = import('Game.IdolLive3D.IdolLive3D_Loader')
        IdolLive3D_Loader.TryOpenScene( skinId, true ) -- 试玩版
    end)
    ]]--


    SetButtonAction(self.BtnTask , function()
        if isNull(self.activity) then
            return
        end
        CfUtils.DialogOpen(Constants.UITypeIds.ActivityGachaponSkinTaskDialog, {activityUuid = self.activity.id , type = self.activity.type})
    end)
    CfUtils.FillText(self.TxtProbability.gameObject,localize("每次抽取必得上方奖励之一，已获得奖励的不会重复获取。"))  
    local taskDialog = import("Game.Activity.GachaponSkin.GachaponSkinPropTaskDialog")
    self.EventMap = {}
    self.EventMap[taskDialog.CloseEvent] = Events.AddListener(taskDialog.CloseEvent, Bind(self,self.OnTaskDialogClose))
end

function ActivityGachaponWithoutReplacement:OnTaskDialogClose(data)
    if checkInt(data.activityUuid) ~= checkInt(self.activity.id) then
        return
    end
    local redNum = data.redNum
    local detail = self.oneSkinData
    GameUtils.SetRedPointNum(Constants.RedPointConst.MainCardSkinCallTask, redNum)
    if redNum <= 0 then
        detail.taskRedDotHint = -1
    else
        detail.taskRedDotHint = 0
    end
    ---@type ActivityCardSkinComponent
    local ActivityCardSkinComponent =  GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityCardSkinComponent)
    local activityData = ActivityCardSkinComponent:GetActivityDataById(self.oneSkinData.id)
    if self.oneSkinData.taskRedDotHint >= 0 or checkInt(self.oneSkinData.callTimes) == 0 then
        activityData.redDotHint = 0
    else 
        activityData.redDotHint = -1  
    end
    Events.Broadcast(Constants.EventNames.ActivityCardSkinChangeEvent) 
end

function ActivityGachaponWithoutReplacement:Start()

end

function ActivityGachaponWithoutReplacement:RefreshData(data)
    self.activity = data
    GameUtils.Request(Interfaces.ActivitySkinCallDetails , {activityUuid = data.id}, 
    function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end
        if not KTool.IsActive(self.RightPanel) then
            KTool.SetActive(self.RightPanel , true)
            CfUtils.PlayAnimation(self.controller.gameObject , "GachaponSkinDialog_Entry") 
        end
        self.oneSkinData = response.data.details 
        self.oneSkinData.id = data.id 
        if self.oneSkinData.taskRedDotHint >= 0 then
            GameUtils.SetRedPointNum(Constants.RedPointConst.MainCardSkinCallTask , 1)
            GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.MainCardSkinCallTask)
        end
        CfUtils.FillImage(self.Image.gameObject , GoodsConfMgr:GetPhotoPathById(data.consumeId) ) 
        self:InitRewardList()
        self:UpddateButton()
        self:UpdateAllItems()
    end)
end


function ActivityGachaponWithoutReplacement:InitRewardList()
    local oneActivityData = self.oneSkinData
    local rewardList =  oneActivityData.rewardList
    local callRewards = oneActivityData.callRewards or {}
    for k, v in pairs(callRewards) do
        callRewards[k] = checkInt(v) 
    end
    for kk, oneRewards in pairs(rewardList) do
        local isGet = false
        for index, rewardId in pairs(callRewards) do
            if rewardId == checkInt(oneRewards.rewardId) then
                isGet = true
                break 
            end
        end
        oneRewards.isGet = isGet
    end
end

function ActivityGachaponWithoutReplacement:AddLuaBehavious()
    for i =1 , 10 do
        ---@type Engine.Modules.LuaBehaviour
       AddLuaBehaviour(self["GoodItem" .. i].gameObject  , ActivityGachaponSkinNodePath) 
    end
end

function ActivityGachaponWithoutReplacement:CheckGoodsEnough()
    local ownerData = self:GetConsumeGoodsData() 
    ---@type ActivityCardSkinComponent
    local ActivityCardSkinComponent =  GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityCardSkinComponent)
    local activityData = ActivityCardSkinComponent:GetActivityDataById(self.oneSkinData.id)
    local consumeNum = GoodsUtils.GetThingNo(activityData.consumeId) 
    if  consumeNum >=  checkInt(ownerData.num) then
        return true 
    end
    return false
end

function ActivityGachaponWithoutReplacement:UpdateAllItems()
    for i =1 , 10 do
        self:UpdateGoodItemIndex(i)
    end
end
-- 抽皮肤
function ActivityGachaponWithoutReplacement:DrawSkinClick()
    local callFunc = function()
        GameUtils.Request(Interfaces.ActivitySkinCallCall , {activityUuid = self.oneSkinData.id } ,function(request, response)
            if checkNumber(response.errCode) ~= 0 then return end
            local data = response.data 
            local rewardId = checkInt(data.rewardId) 
            local index = self:GetIndexByRewardId(rewardId)
            local oneGoodsData = self:GetOneGoodsDataByIndex(index)
            oneGoodsData.isGet = true    
            local oneActivityData = self.oneSkinData 
            if isNull(oneActivityData.callRewards) then
                oneActivityData.callRewards = {}
            end
            local consume = clone(data.consume) or {}
            if #consume > 0  then
                for i = #consume , 1 , -1 do
                    consume[i].num = -consume[i].num 
                    if consume[i].num == 0 then
                        table.remove(consume, i)
                    end
                end
            end
            self.oneSkinData.callTimes = self.oneSkinData.callTimes + 1 
            local rewards = data.rewards
            table.insertto(consume ,rewards)
            GoodsUtils.DrawRewards(consume, true)

            table.insert(oneActivityData.callRewards ,rewardId)
            local count = #oneActivityData.callRewards 
            oneActivityData.callRewards[count] = rewardId
            CfUtils.StartCoroutineWithBlocker(function ()
                ---@type ActivityCardSkinComponent
                local ActivityCardSkinComponent =  GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityCardSkinComponent)
                local activityData = ActivityCardSkinComponent:GetActivityDataById(self.oneSkinData.id)
                if activityData.redDotHint == 0 then
                    if self.oneSkinData.taskRedDotHint >= 0 or checkInt(self.oneSkinData.callTimes) == 0 then
                        activityData.redDotHint = 0
                    else 
                        activityData.redDotHint = -1  
                    end
                    Events.Broadcast(Constants.EventNames.ActivityCardSkinChangeEvent) 
                end
                local func =  function()
                    UIModule.OpenDialog(
                        {
                            id = Constants.UITypeIds.UICommonRewardPop,
                            parameters = { rewards = data.rewards , cb = function()
                                self:PlayGettingIndex(index)           
                                self:UpddateButton()
                            end}
                        }
                    )    
                end
                local isPu = true 
                if rewards[1] and checkInt(rewards[1].goodsId) == checkInt(activityData.skinId) then
                    isPu = false
                    Events.Broadcast(Constants.EventNames.ActivityCardSkinChangeEvent)
                end
                if isPu then
                    self:PlayNormalTimeLine("gacha_clothing_pu" , func)      
                else 
                    self:PlaySpecialTimeLine("gacha_clothing_te" , activityData.skinId ,func)      
                end
            end)
           
        end)
    end
    local isAllCompleted = self:IsAllCompete()
    -- 检查是否完成
    if isAllCompleted then
        GameUtils.Toast(localize("皮肤卡池已抽完"))
        return 
    end
    ---@type ActivityCardSkinComponent
    local ActivityCardSkinComponent =  GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityCardSkinComponent)
    local activityData = ActivityCardSkinComponent:GetActivityDataById(self.oneSkinData.id)
    if os.time() > activityData.endTime then
        GameUtils.Toast(localize("活动已结束"))
        return 
    end
    -- 道具不足
    if not self:CheckGoodsEnough() then
        local OverseaStoreConstants = import('Game.OverseaStore.OverseaStoreConstants')
        local OverseaStoreUtils = import('Game.OverseaStore.OverseaStoreUtils')
        OverseaStoreUtils.OpenStore(OverseaStoreConstants.StoreType.TimeLimitTreasure  , {{id =  Constants.UITypeIds.ActivityGachaponSkinDialog}})
        return
    end
    callFunc()    
end

function ActivityGachaponWithoutReplacement:PlayNormalTimeLine(name , func)
    ---@type Engine.UI.UILuaDialog
    local luaDialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.ActivityGachaponSkinDialog)
    ---@type ActivityGachaponSkinDialog
    local Env = luaDialog.Env
    local luaPath = "Game.Activity.GachaponSkin.ActivityGachaponSkinNormaTimeLine"
    local go = self:GetGameObjectByName(name)
    if isNull(go) then
        return
    end
    local isActivte = KTool.IsActive(go)
    if not isActivte then
        KTool.SetActive(go , true)    
    end
    ---@type ActivityGachaponSkinNormaTimeLine
    local env =  CfUtils.GetLuaScr(go , luaPath)
    Env:SetCanvasEnabled(false)
    if env then
        env:SetCamera()
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(env:GetTime() - 0.1  ))
        func()
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 0.1 ))
        KTool.SetActive(go.gameObject , false)    
        env:DisableCamera()
    end
    Env:SetCanvasEnabled(true)
end

function ActivityGachaponWithoutReplacement:PlaySpecialTimeLine(name, skinId , func)
    ---@type Engine.UI.UILuaDialog
    local luaDialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.ActivityGachaponSkinDialog)
    ---@type ActivityGachaponSkinDialog
    local Env = luaDialog.Env
    local luaPath = "Game.Activity.GachaponSkin.ActivityGachaponSkinSpecialTimeLine"
    local go = self:GetGameObjectByName(name)
    if isNull(go) then
        return
    end
    local isActivte = KTool.IsActive(go)
    if not isActivte then
        KTool.SetActive(go , true)    
    end
    ---@type ActivityGachaponSkinSpecialTimeLine
    local env =  CfUtils.GetLuaScr(go , luaPath)
    Env:SetCanvasEnabled(false)
    if env then
        env:AddCat(skinId)
        env:SetCamera()
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(env:GetTime() -  0.25))
        ---@type GachaponUtils
        local GachaponUtils = import('Game.Gachapon.GachaponUtils')
        coroutine.yield(GachaponUtils.OpenDialogAction(Constants.UITypeIds.CommonCardDisplayDialog, {
            cardInfo   = { { goodsId =  skinId } },     
            isSkin = true       , 
            isHideSkip = true,
            finishCb   = function()
            end,
            onCloseCb  = function()
                UIModule.CloseDialogById(Constants.UITypeIds.CommonCardDisplayDialog)
                func()
            end
        }, nil))
        
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.15))
        KTool.SetActive(go.gameObject , false)    
        env:DisableCamera()
        -- cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.02))
        env:DeletCatPrefab()
    end
    Env:SetCanvasEnabled(true)
end

function ActivityGachaponWithoutReplacement:GetLoadModelParentGo()
    local KCookie = CS.Engine.Lib.KCookie
    local MainSceneID = KCookie.Get(Constants.UICacheDataKeys.MainSceneID)
    local sceneInstance   = SceneManagement:GetInstance():GetSceneInstance(MainSceneID)
    local gachaponCacheGo = nil
    local GameObject = CS.UnityEngine.GameObject
    local SceneManager = CS.UnityEngine.SceneManagement.SceneManager
    if not isNull(sceneInstance) then
        gachaponCacheGo = sceneInstance:GetCacheObjectByName("GachaClothing")
        if isNull(gachaponCacheGo) then
            gachaponCacheGo = GameObject("GachaClothing")
            sceneInstance:AddCacheObject(gachaponCacheGo)
            SceneManager.MoveGameObjectToScene(gachaponCacheGo, sceneInstance:GetScene())
        end
    end
    if gachaponCacheGo and (not KTool.IsActive(gachaponCacheGo)) then
        KTool.SetActive(gachaponCacheGo , true)
    end
    return gachaponCacheGo
end

function ActivityGachaponWithoutReplacement:GetGameObjectByName(name)
    ---@type UnityEngine.GameObject 
    local parentGo = self:GetLoadModelParentGo()
    if parentGo then
        local go =  parentGo.transform:Find(name)
        if isNull(go) then
            go = GameUtils.LoadBundleAsync(string.format("Timeline/Prefab/gacha_clothing/%s.prefab" ,name) , parentGo, false)
        end     
        return go
    end
    return nil
end

function ActivityGachaponWithoutReplacement:DelLoadModelParentGo()
    local KCookie = CS.Engine.Lib.KCookie
    local MainSceneID = KCookie.Get(Constants.UICacheDataKeys.MainSceneID)
    local sceneInstance   = SceneManagement:GetInstance():GetSceneInstance(MainSceneID)
    if not isNull(sceneInstance) then
        local gachaponCacheGo = sceneInstance:GetCacheObjectByName("GachaClothing")
        sceneInstance:RemoveCacheObjectByName("GachaClothing")
        if not isNull(gachaponCacheGo) then
            KTool.SafeDelete(gachaponCacheGo)
        end
    end
end

-- 是否抽完
function ActivityGachaponWithoutReplacement:IsAllCompete()
    local oneActivityData = self.oneSkinData
    if isNull(oneActivityData.callRewards) then
        oneActivityData.callRewards = {}
    end
    local countNum = #oneActivityData.callRewards
    if countNum == 10 then
        return true    
    end
    return false
end

function ActivityGachaponWithoutReplacement:UpddateButton()
    local isAllCompleted = self:IsAllCompete()
    if isAllCompleted then
        KTool.SetActive(self.BtnOneNode.gameObject , false)
        KTool.SetActive(self.FontStyleButton.gameObject, true)
    else 
        local consumeData = self:GetConsumeGoodsData() or {}
        if checkInt(consumeData.num) == 0 then
            KTool.SetActive(self.Image.gameObject , false)
            KTool.SetActive(self.TxtFree.gameObject , true)
            -- CfUtils.FillText(self.Text2 , localize('免费'))
        else 
            local isActivite =  KTool.IsActive(self.Image.gameObject)
            KTool.SetActive(self.Image.gameObject , true)
            KTool.SetActive(self.TxtFree.gameObject , false)
            local isEnough = self:CheckGoodsEnough()
            if isEnough then
                CfUtils.SetUISwitchText(self.Text2 , 1)
            else 
                CfUtils.SetUISwitchText(self.Text2 , 3)
            end
            CfUtils.FillText(self.Text2 , consumeData.num) 
        end
    end
    local isHaveCard = self:IsHaveCard()
    local gameObject = self.ImgState.gameObject
    if (not isHaveCard) then
        if not (KTool.IsActive(gameObject)) then
            KTool.SetActive(gameObject , true)    
        end
    else 
        if (KTool.IsActive(gameObject)) then
            KTool.SetActive(gameObject, false)    
        end    
    end
    ---@type ActivityCardSkinComponent
    local ActivityCardSkinComponent =  GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityCardSkinComponent)
    local activityData = ActivityCardSkinComponent:GetActivityDataById(self.oneSkinData.id)
    if checkInt(self.oneSkinData.callTimes) == 0 then
        KTool.SetActive(self.redPoint , true)
    else 
        KTool.SetActive(self.redPoint , false)
    end
end
---获取消耗道具
function ActivityGachaponWithoutReplacement:GetConsumeGoodsData()
    local oneActivityData = self.oneSkinData
    if isNull(oneActivityData.callRewards) then
        oneActivityData.callRewards = {}
    end
    local countNum = #oneActivityData.callRewards + 1
    if countNum <= 10 then
        local consumeData = oneActivityData.consume[tostring(countNum)]
        return consumeData
    end
   return {}
end

---更新道具状态
---@param index integer @ 道具的顺讯
function ActivityGachaponWithoutReplacement:UpdateGoodItemIndex(index)
    ---@type ActivityGachaponSkinNode
    local env = CfUtils.GetLuaScr(self["GoodItem" .. index].gameObject ,ActivityGachaponSkinNodePath)
    --TODO  传输数据
    env:RefreshData(self:GetOneGoodsDataByIndex(index))
end
--- 判断是否拥有该角色
---@return boolean
function ActivityGachaponWithoutReplacement:IsHaveCard()
     ---@type ActivityCardSkinComponent
    local ActivityCardSkinComponent =  GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityCardSkinComponent)
    local activityData = ActivityCardSkinComponent:GetActivityDataById(self.oneSkinData.id)
    local skinId = activityData.skinId
    local skinVo = CfUtils.GetCfVo(AutoIds.IdSetting113 , "CardSkinVo" ,skinId)
    local cardId = skinVo.roleId
    ---@type CardComponent
    local cardComp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.CardComponent)
    local isHave = cardComp:IsHasCard(cardId)
    return isHave
end
function ActivityGachaponWithoutReplacement:GetOneGoodsDataByIndex(index)
    local oneActivityData = self.oneSkinData
    local rewardList =  oneActivityData.rewardList
    return rewardList[index]
end
--- 根据rewardId 获取index 
function ActivityGachaponWithoutReplacement:GetIndexByRewardId(rewardId)
    local oneActivityData = self.oneSkinData
    local rewardList =  oneActivityData.rewardList
    local index = 1 
    for kk, oneRewards in pairs(rewardList) do
        if rewardId == checkInt(oneRewards.rewardId) then
            index = kk 
            break 
        end
    end
    return index 
end
---播放获得动画
function ActivityGachaponWithoutReplacement:PlayGettingIndex(index)
     ---@type ActivityGachaponSkinNode
     local env = CfUtils.GetLuaScr(self["GoodItem" .. index].gameObject ,ActivityGachaponSkinNodePath)
     env:PlayGetting()
end


function ActivityGachaponWithoutReplacement:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:DelLoadModelParentGo()
    self:Delete()
end

return ActivityGachaponWithoutReplacement
