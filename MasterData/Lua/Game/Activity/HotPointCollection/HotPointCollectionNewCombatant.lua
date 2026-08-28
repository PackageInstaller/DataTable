
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type HotPointCollectionConstants
local HotPointCollectionConstants = import("Game.Activity.HotPointCollection.HotPointCollectionConstants")
local GachaponUtils     = import('Game.Gachapon.GachaponUtils')
---@type HotPointCollectionComponent
local component         = GameUtils.GetEntityCompByType(ECSComponentType.Constants.HotPointCollectionComponent)
local SubPrefabLoader   = import(HotPointCollectionConstants.EnvPath.SubPrefabLoader)
---@type CardConfMgr
local cardConfMgr       = CardConfMgr:GetInstance()
local Application       = CS.UnityEngine.Application
---@type Engine.Lib.Yielders
local Yielders          = CS.Engine.Lib.Yielders
local cs_coroutine      = require 'XLua.cs_coroutine'
--endregion

--region define
local intervalTime  = 0.5
local Seconds       = Yielders.GetWaitForSeconds(intervalTime)
local TriggerSecond = 3


---@class HotPoint.CardInfo
---@field cardAssociationIds number[] 卡牌关联活动页签id
---@field sceneId string 背景
---@field rewardImg string 角色立绘
---@field cardId number 卡牌ID
---@field skinId number 皮肤id
---@field catId string 猫spine 名称
---@field catName string  猫名称
---@field line string  台词

--endregion

--- from: Assets/BundleResources/Prefabs/Hotpoint/HotpointNewCombatantDialog.prefab > name: HotpointNewCombatantDialog
---@class HotPointCollectionNewCombatant
---@field Env                           	HotPointCollectionNewCombatant          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field LoopListAssociatedHotSpot     	SuperScrollView.LoopListView2           
---@field AssociatedHotSpotGroup        	UnityEngine.RectTransform               
---@field PVTxtTitle                    	UnityEngine.UI.Text                     
---@field ImgSpread                     	UnityEngine.RectTransform               
---@field CommonWebImageGroup           	UnityEngine.RectTransform               
---@field ButtonVideo                   	UnityEngine.RectTransform               
---@field ExplanatoryTxtName            	CustomText                              
---@field HeadGroup                     	UnityEngine.RectTransform               
---@field BtnRoleNameNode               	UnityEngine.RectTransform               
---@field TxtName                       	UnityEngine.UI.Text                     
---@field CatSpineNode                  	UnityEngine.RectTransform               
---@field BG                            	UnityEngine.RectTransform               
local HotPointCollectionNewCombatant = Class('HotPointCollectionNewCombatant')

function HotPointCollectionNewCombatant:__init()
    self._seconds       = 0
    self._cardIndex     = 1
    self._sceneId2Loader = {}
    self._sceneId2Canvas = {}
    self._catSpineName2Loader  = {}
    self._catSpineName2Spine   = {}
    self._headEnvs      = {}

end


function HotPointCollectionNewCombatant:__delete()

end


-- function HotPointCollectionNewCombatant:Awake()
-- end


-- function HotPointCollectionNewCombatant:Start()
-- end


function HotPointCollectionNewCombatant:OnDestroy()
    self:StopCo()
    CfUtils.ConditionRemove("HotPointCollection.SwitchCard")
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 

function HotPointCollectionNewCombatant:OnInit(params)
    self._cardIndex = params ~= nil and params.cardIndex or self._cardIndex
    self:FreshVideo()
    -- local dataList = self:GetDataList()
end

--endregion 


--region logic 

function HotPointCollectionNewCombatant:FreshVideo()
    ---@type HotPointCollectionDojo
    local dojo = component:GetDojo()
    self.PVTxtTitle.text = dojo.pvTitle

    UICommonUtils.LoadWebTexture(self.CommonWebImageGroup, component:GetTexturePool(), dojo.hotSpotCollectionPvImage)

    SetButtonAction(self.ButtonVideo, Bind(self, self.OnClickButtonVideoAction))
end

function HotPointCollectionNewCombatant:FreshHeadGroup(dataList)
    local parent = self.HeadGroup
    local count  = parent.childCount
    for i = 1, count do
        local child = parent:GetChild(i - 1)
        local data = dataList[i]
        local isShow  = data ~= nil
        CfUtils.SetActive(child, isShow)
        if isShow then
            local env = self:FreshHead(child, data, i)
            table.insert(self._headEnvs, env)
        end

    end
end

function HotPointCollectionNewCombatant:FreshHead(node, data, i)
    ---@type HotPointCollectionNewCombatantBtnHead
    local env = CfUtils.GetLuaScr(node, HotPointCollectionConstants.EnvPath.HotPointCollectionNewCombatantBtnHead)
    if isNull(env) then return end
    env:FreshUI(data, i)
    env:FreshSelectState(i == self._cardIndex)
    env:SetCallback(function ()
        self._seconds       = 0
        self:DisableCo()
        self:SwitchCard(i)
    end)
    return env

end

function HotPointCollectionNewCombatant:FreshHeadSelectState(index, isSelect)
    ---@type HotPointCollectionNewCombatantBtnHead
    local env = self._headEnvs[index]
    if isNull(env) then return end
    env:FreshSelectState(isSelect)

end

function HotPointCollectionNewCombatant:SwitchCard(newIndex)
    if newIndex == self._cardIndex then
        return
    end
    self._isSwitching = true
    
    CfUtils.ConditionAppend("HotPointCollection.SwitchCard")
    self._switchCo = cs_coroutine.start(function ()
        local oldIndex = self._cardIndex
        self._cardIndex = newIndex
        local co = self:FreshCardInfo(newIndex)
        cs_coroutine.yield_return(co)
        CfUtils.ConditionRemove("HotPointCollection.SwitchCard")
        local dataList = self:GetDataList()
        local data      = dataList[oldIndex]
        self:FreshHeadSelectState(oldIndex, false)
        self:FreshHeadSelectState(newIndex, true)
        
        -- self:FreshBackgroundShowState(data.sceneId, false)

        self._isSwitching = false
        self._switchCo = nil
    end)

    CfUtils.PlayAnimation(self.controller, "HotpointAssociatedNode_Chang")

end

function HotPointCollectionNewCombatant:FreshUI(viewType)
    self._viewType = viewType
    self._cardIndex = 1
    return self:FreshCardInfo(self._cardIndex)

end

function HotPointCollectionNewCombatant:FreshCardInfo(cardIndex)
    return cs_coroutine.start(function() 
        local dataList = self:GetDataList()
        self:FreshHeadGroup(dataList)
    
        ---- cardAssociationIds list 卡牌关联活动页签id
        ---- sceneId str 背景
        ---- rewardImg str 角色立绘
        ---- cardId str 卡牌ID
        ---- catId str 猫spine 名称
        ---- catName str  猫名称
        ---- line str  台词
        local data = dataList[cardIndex]
        if data == nil then return end
        local cardId = data.cardId
        self:FreshBgShowState(data.sceneId)
        self:FreshRoleNameNode(data.cardId, data.id)
        self:FreshCat(data.catId, data.catName)
        self:FreshExplanatoryTxt(data)
        self:FreshAssociatedHotSpot(data)
    end)

end

function HotPointCollectionNewCombatant:FreshBgShowState(sceneId, isShow)
    ---@type SubPrefabLoader
    local loader = self:GetBackgroundLoader(sceneId)
    local isFinished = loader:GetInstance()
    local yield_return = cs_coroutine.yield_return
    while not isFinished do
        yield_return()
        isFinished = loader:IsFinished()
    end
    
    self:FreshBackgroundShowState(sceneId)
end

function HotPointCollectionNewCombatant:FreshBackgroundShowState(sceneId)
    for sceneId_, canvas in pairs(self._sceneId2Canvas) do
        if isNotNull(canvas) then 
            canvas.enabled = sceneId_ == sceneId
        end
        
    end
    
end

---@param id number cardId/skinId
function HotPointCollectionNewCombatant:FreshRoleNameNode(cardId, id)
    ---@type CommonBtnRoleNameNode
    local env = CfUtils.GetLuaScr(self.BtnRoleNameNode, "Game.UI.Common.CommonBtnRoleNameNode")
    if env then
        env:RefreshSelf(id, nil, function()
            component:SetIsDisableLoop(true)
            if self._viewType == HotPointCollectionConstants.ViewType.NewCard then
                GachaponUtils.OpenDetail(cardId, UICommonUtils.GetShowDialogArguments())

            elseif self._viewType == HotPointCollectionConstants.ViewType.NewSkin then
                CfUtils.DialogOpen(Constants.UITypeIds.CommonStylePreView, {skinId = id}, UICommonUtils.GetShowDialogArguments(), true)
            end

        end)
    end

end

function HotPointCollectionNewCombatant:FreshCat(catSpineName, catName)

    -- local catId = self:GetCatId(cardId)
    ---@type SubPrefabLoader
    local loader = self:GetCatSpineLoader(catSpineName)
    for catSpineName_, go in pairs(self._catSpineName2Spine) do
        CfUtils.SetActive(go, catSpineName_ == catSpineName)
    end
    if loader:GetInstance() then
        CfUtils.SetActive(self._catSpineName2Spine[catSpineName], true)
    end

    -- ---@type RolesVo
    -- local roleVo = cardConfMgr:GetRolesVo(catId)
    -- if roleVo == nil then
    --     return
    -- end
    -- print(table.toString(roleVo))
    self.TxtName.text = catName
    
end

function HotPointCollectionNewCombatant:FreshExplanatoryTxt(data)
    self.ExplanatoryTxtName.text = data.line
end

function HotPointCollectionNewCombatant:FreshAssociatedHotSpot(data)
    local activityList = component:GetAssociationActivityListByIds(data.cardAssociationIds)
    self._activityList = activityList
    self:FreshActivityList()
end

function HotPointCollectionNewCombatant:FreshActivityList()
    local ScrollView = self.LoopListAssociatedHotSpot
    local count      = #self._activityList
    if not ScrollView.IsListViewInit then
        ScrollView:InitListView(count, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end

end


function HotPointCollectionNewCombatant:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(HotPointCollectionConstants.DefineName.Cell)
    local node = GetLuaBehaviour(cell.gameObject, HotPointCollectionConstants.EnvPath.CardProgressionListCell)
    
    ---@type HotPointCollectionAssociatedNode
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
        nodeEnv:InitLuaEnvPath(HotPointCollectionConstants.EnvPath.HotPointCollectionAssociatedNode)
    else
        nodeEnv = node.Env
    end
    
    if nodeEnv then
        local position = index + 1
        local data     = self._activityList[position]
        nodeEnv:FreshUI(data, os.time())

        local cellEnv = nodeEnv:GetRealEnvCell()
        if listView.DisplayItemNumber < listView.DisplayItemCount then
            cellEnv:PlayDelayAnimByShow(math.floor(listView.DisplayItemNumber * 0.5))
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            cellEnv:PlayAnimByIdle()
        end
    end

    return cell
end

function HotPointCollectionNewCombatant:SaveParameters()
    return {cardIndex = self._cardIndex}
end

--endregion 


--region get/set 

---@return HotPoint.CardInfo[]
function HotPointCollectionNewCombatant:GetDataList()
    if self._viewType == HotPointCollectionConstants.ViewType.NewCard then
        return component:GetCardInfo()
    elseif self._viewType == HotPointCollectionConstants.ViewType.NewSkin then
        return component:GetSkinInfo()
    end
end

function HotPointCollectionNewCombatant:GetBackgroundLoader(sceneId)
    ---@type SubPrefabLoader
    local loader = self._sceneId2Loader[sceneId]
    if loader == nil then
        local prefabPath = string.format(HotPointCollectionConstants.PrefabPath.HotpointRole, sceneId)
        loader = SubPrefabLoader.New(prefabPath, self.BG, function (go)
            local canvas = CfUtils.GetOrAddComponent(go, typeof(CS.UnityEngine.Canvas))
            self._sceneId2Canvas[sceneId] = canvas

            local dataList = self:GetDataList()
            local data     = dataList[self._cardIndex]
            local isShow   = data.sceneId == sceneId
            canvas.enabled = isShow

        end)
        self._sceneId2Loader[sceneId] = loader
    end
    return loader
end

function HotPointCollectionNewCombatant:GetCatSpineLoader(catSpineName)
    -- catId = checkNumber(catId)
    ---@type SubPrefabLoader
    local loader = self._catSpineName2Loader[catSpineName]
    if loader == nil then
        local prefabPath = string.format(HotPointCollectionConstants.PrefabPath.CatSpine, catSpineName)
        loader = SubPrefabLoader.New(prefabPath, self.CatSpineNode, function (go)
            self._catSpineName2Spine[catSpineName] = go
            local dataList = self:GetDataList()
            local data     = dataList[self._cardIndex]
            local isShow   = data.catId == catSpineName
            CfUtils.SetActive(go, isShow)

        end)
        self._catSpineName2Loader[catSpineName] = loader
    end
    return loader
end

-- function HotPointCollectionNewCombatant:GetCatId(cardId)
--     ---@type CardVo
--     local cardVo   = cardConfMgr:GetCardByRefId(cardId)
--     return cardVo and cardVo.characterId or nil
-- end

function HotPointCollectionNewCombatant:SetEnabled(enabled)
    if enabled then
        if component:GetIsDisableLoop() then
            self:StopCo() 
            return
        end
        self:StartCo()
    else
        self:DisableCo()
    end
end
function HotPointCollectionNewCombatant:StartCo()
    if self._co then return end
    self._co = CoStart(function () 
        local yield_return = cs_coroutine.yield_return
        while true do
            yield_return(Seconds)
            if not self._isSwitching then
                local seconds = self._seconds
                seconds = seconds + intervalTime
                if seconds == TriggerSecond then
                    seconds = 0
                    
                    local dataList = self:GetDataList()
                    local maxIndex = #dataList
                    local cardIndex = self._cardIndex
                    if cardIndex == maxIndex then
                        cardIndex = 1
                    else
                        cardIndex = cardIndex + 1
                    end
    
                    self:SwitchCard(cardIndex)
    
                end
                self._seconds = seconds
            end
            
        end
        
    end)
end
function HotPointCollectionNewCombatant:StopCo()
    if isNotNull(self._co) then
        CoStop(self._co)
        self._co = nil
    end

    if isNotNull(self._switchCo) then
        CoStop(self._switchCo)
        self._switchCo = nil
    end
   
end


function HotPointCollectionNewCombatant:DisableCo()
    component:SetIsDisableLoop(true)
    self:StopCo()
end

---endregion 


--region handler 

function HotPointCollectionNewCombatant:OnClickButtonVideoAction()
    ---@type HotPointCollectionDojo
    local dojo   = component:GetDojo()
    local link = dojo.pvLink
    if not string.isEmpty(link) then
        CfUtils.OpenURL(link)
    else
        printError("链接地址为空")
    end
end

---endregion 


return HotPointCollectionNewCombatant

