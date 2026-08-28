
------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
local cs_coroutine     = require "XLua.cs_coroutine"
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type SceneManagement
local sceneManagementIns = SceneManagement:GetInstance()
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
---@type Engine.UI.UIRaycastBlocker
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance
------------ import ------------


------------ define ------------


------------ define ------------

--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalAntiqueRestoration.prefab > name: SpringFestivalAntiqueRestoration
---@class MapDecryptionAntiqueRestorationDialog
---@field Env                           	MapDecryptionAntiqueRestorationDialog   
---@field controller                    	Engine.UI.UILuaDialog                   
---@field DescTxtTitle                  	UnityEngine.UI.Text                     
---@field TxtContent                    	UnityEngine.UI.Text                     
---@field DescribeNode                  	UnityEngine.RectTransform               
---@field TxtTips                       	UnityEngine.UI.Text                     
---@field FontStyleButton               	UnityEngine.RectTransform               
---@field CommonGoodsList               	UnityEngine.RectTransform               
---@field TxtTitle                      	UnityEngine.UI.Text                     
---@field ImgIcon                       	Engine.UI.RawImageAlterable             
---@field RepairNode                    	UnityEngine.RectTransform               
---@field TrackingPanel                 	UnityEngine.RectTransform               
---@field Container                     	UnityEngine.Animation                   
---@field Root                          	UnityEngine.RectTransform               
---@field AntiqueRestorationTips        	UnityEngine.RectTransform               
---@field AntiqueRestorationTipsRoot    	UnityEngine.RectTransform               
---@field TipsNode1                     	UnityEngine.RectTransform               
---@field TipsNode2                     	UnityEngine.RectTransform               
---@field TipsNode3                     	UnityEngine.RectTransform               
local MapDecryptionAntiqueRestorationDialog = Class('MapDecryptionAntiqueRestorationDialog')


function MapDecryptionAntiqueRestorationDialog:__init()
    self._isShowContainer    = false
    self._curSelectAntiqueId = nil
    self._antiqueLoaderCos   = {}
    self._antiqueLabelNodes  = {}
    self._antiqueId2TipsNodes  = {}
end


function MapDecryptionAntiqueRestorationDialog:__delete()
    self._antiqueLoaderCos = nil
    self._progressNodeLoaderCo = nil
    self._ProgressNode = nil
    self.controller = nil
end


function MapDecryptionAntiqueRestorationDialog:Awake()
    self:SetContainerShowState(false)
end


function MapDecryptionAntiqueRestorationDialog:OnFocus(focus)
    if focus then
        CfUtils.SetTopCommonCb(function ()
            if self._isShowContainer then
                UIRaycastBlocker:AddCondition("MapDecryptionAntiqueRestorationDialog.OnFocus")
                cs_coroutine.start(function ()
                    self._controllerComp:ResetVirtualCamera()
                    UICommonUtils.WaitBrainBlendingComplete()

                    --- 重置下标签坐标
                    if self._antiqueLabelNodes then
                        local parent     = self.Root.gameObject
                        for antiqueId, labelNode in pairs(self._antiqueLabelNodes) do
                            self:InitLabelNode(labelNode, self._controllerComp:GetAntiqueLabelPosition(antiqueId), parent)
                        end
                    end
                 
                    self:SetContainerShowState(false)
                    self._curSelectAntiqueId = nil
                    UIRaycastBlocker:RemoveCondition("MapDecryptionAntiqueRestorationDialog.OnFocus")
                end)
            else
                
                UIModule.BackDialog()
            end
        end)
    else
        
        CfUtils.ResetNavigatorCustomBackAction()
    end

end


function MapDecryptionAntiqueRestorationDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        ---@type MapDecryptionComponent
        local springFestivalComp = MapDecryptionMgr:GetComponent()
        local activityData       = springFestivalComp:GetActivityData()
        local activityContentId  = activityData.activityContentId
        ---@type MapDecryptionPlanVo
        local planVo             = MapDecryptionConfMgr:GetPlanVoById(activityContentId)
        self._planVo             = planVo
        ---@type SceneInstance
        local sceneInstance = sceneManagementIns:GetSceneInstance(self._planVo.sceneId)
        self.SceneAllCollider = sceneInstance:GetCacheObjectByName(MapDecryptionConstants.SceneDefine.SceneAllCollider, nil)
        KTool.SetActive(self.SceneAllCollider.gameObject, false)
        self:InitData()
        self._controllerComp:SetVirtualCamShowState(true)
        UICommonUtils.WaitBrainBlendingComplete()

        while not self._controllerComp:CheckIsInitComplete() do
            cs_coroutine.yield_return()
        end

        -- MapDecryptionMgr:GetControllerCompByType
        -- self:InitScene()
        self:InitAntiqueLabels()
        self:InitAction()

        
    end))
    return coWait
end

function MapDecryptionAntiqueRestorationDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self._controllerComp:SetClickAntiqueCallback(Bind(self, self.OnClickAntiqueAction))
           
        -- if self._antiqueId2TipsNodes then
        --     if self._tempCo == nil then
        --         self._tempCo = CoStart(function() 
        --             while true do
        --                 for antiqueId, node in pairs(self._antiqueId2TipsNodes) do
        --                     local antiqueNode, parent = self._controllerComp:GetAntiqueTipsPosition(antiqueId), self.AntiqueRestorationTipsRoot
        --                     local v2 = CfUtils.WorldPosition2UIPosition(antiqueNode.position, parent.transform)
        --                     -- local tipsNode = self[string.format("TipsNode%s", i)]
        --                     if isNotNull( node ) then
        --                         node.anchoredPosition = v2
        --                     end
        --                 end
        --                 CoYield()
        --             end
        --         end)
        --     end
        -- end
    end))
    return coWait
end

function MapDecryptionAntiqueRestorationDialog:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self.__OnRequestSuccess then
            Events.RemoveListener(MapDecryptionConstants.EventNames.RequestSuccess, self.__OnRequestSuccess)
            self.__OnRequestSuccess = nil
        end
        KTool.SetActive(self.SceneAllCollider.gameObject, true)
        self._controllerComp:SetClickAntiqueCallback(nil)

        for k, v in pairs(self._antiqueLoaderCos) do
            if not isNull(v) then
                cs_coroutine.stop(v)
            end
        end
        if not isNull(self._progressNodeLoaderCo) then
            cs_coroutine.stop(self._progressNodeLoaderCo)
        end

        -- if self._tempCo then
        --     CoStop(self._tempCo)
        --     self._tempCo = nil
        -- end
        
    end))
    return coWait
end


function MapDecryptionAntiqueRestorationDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self._controllerComp:SetVirtualCamShowState(false)
        MapDecryptionMgr:BlackEaseInAndOut(
                7.0, -- 变黑的速度
                4.0, -- 变淡的速度
                0.1, -- 黑色阶段的时长
                function() -- 进入黑色阶段后要调用的callback
                    --self._controllerComp:SwitchVCameraWhenReturn()
                end
        )

        UICommonUtils.WaitBrainBlendingComplete()

        --Events.Broadcast(MapDecryptionConstants.EventNames.RestoreNpcStatus)

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function MapDecryptionAntiqueRestorationDialog:InitData()
    local MapDecryptionMgr = MapDecryptionMgr
    ---@type MapDecryptionComponent
    local component = MapDecryptionMgr:GetComponent()
    self._component = component

    ---@type MapDecryptionAntiqueRestorationEntity[]
    self._entityList = component:GetAntiqueEntityList()

    ---@type MapDecryptionAntiqueModelController
    self._controllerComp = MapDecryptionMgr:GetControllerCompByType(MapDecryptionConstants.ControllerCompType.Antique)


    -- table.sort(self._entityList, function (a, b)
    --     local aPriority = a.isFinal and 1 or 0
    --     local bPriority = b.isFinal and 1 or 0
    --     if aPriority ~= bPriority then
    --         return aPriority < bPriority
    --     end
    --     return a.antiqueId < b.antiqueId
    -- end)

end


function MapDecryptionAntiqueRestorationDialog:InitAntiqueLabels()
    --- 古物加载规则 
    --- 如果 最后一个古物已修复 则前三个不需要加载
    --- 如果 最后一个古物未修复 则需要加载 MapDecryptionAntiqueRestorationProgressNode
    --- 如果 未获得前三个古物则不加载

    local entityList = self._entityList
    local parent     = self.Root.gameObject
    local count      = #entityList
    local entity     = entityList[count]
    local finalAntiqueIsUnlock     = entity.status == 2
    local finalAntiqueId = MapDecryptionMgr:GetComponent():GetFinalAntiqueId()
    for i = count, 1, -1 do
        self:LoadAntiqueLabel(entityList[i], parent, finalAntiqueIsUnlock)
        self:FreshRestoreTipsNode(entityList[i], i, finalAntiqueIsUnlock, finalAntiqueId)
    end

    --- 如果 最后一个古物未修复 则需要加载 MapDecryptionAntiqueRestorationProgressNode
    if entity.status == 1 then
        self:LoadProgressNode()
    end

end

function MapDecryptionAntiqueRestorationDialog:RefreshRestoreTipsNodes()
    local entityList = self._entityList
    local count      = #entityList
    local finalAntiqueId = MapDecryptionMgr:GetComponent():GetFinalAntiqueId()
    
    local finalAntiqueIsUnlock
    for i = count, 1, -1 do
        local entity     = entityList[i]
        if i == count then
            finalAntiqueIsUnlock = entity.status == 2
        end
        self:FreshRestoreTipsNode(entity, i, finalAntiqueIsUnlock, finalAntiqueId)
    end

end

--- LoadAntique
--- 加载古物
---@param entity MapDecryptionAntiqueRestorationEntity
function MapDecryptionAntiqueRestorationDialog:LoadAntiqueLabel(entity, parent, finalAntiqueIsUnlock)
    local antiqueId  = entity.antiqueId
    local status     = entity.status
    --- 如果 未获得古物则不加载
    if status == 0 then
        return
    end
    local isRestore  = status == 2
    if isRestore and not entity.isFinal and not finalAntiqueIsUnlock then
        local co = cs_coroutine.start(function ()
            -- local prefabPath = MapDecryptionUtils.GetPrefabPath(MapDecryptionConstants.PrefabPath.AntiqueRestorationLabelNode)
            -- local labelNode =  GameUtils.LoadBundleAsync(prefabPath, parent)
            local labelNode = MapDecryptionUtils.CreateGameObjectByPath(MapDecryptionConstants.PrefabPath.AntiqueRestorationLabelNode, parent)
            self:InitLabelNode(labelNode, self._controllerComp:GetAntiqueLabelPosition(antiqueId), parent)
            KTool.SetActive(labelNode.gameObject, not self._isShowContainer)
            self._antiqueLabelNodes[antiqueId] = labelNode
    
            self._antiqueLoaderCos[antiqueId] = nil
        end)    
        self._antiqueLoaderCos[antiqueId] = co
    end
    
end

--- InitLabelNode
---@param labelNode UnityEngine.GameObject
---@param go UnityEngine.GameObject
function MapDecryptionAntiqueRestorationDialog:InitLabelNode(labelNode, transform, parent)
    local rectTrans = labelNode.transform:rectTransform()
    if not isNull(rectTrans) then
        local v2 = CfUtils.WorldPosition2UIPosition(transform.position, parent.transform)
        rectTrans.anchoredPosition = v2
        rectTrans.localRotation    = Quaternion.Euler(0, 0, -14.3)
        rectTrans.localScale       = Vector3.New(0.4, 0.4, 0.4)
    end
end

---FreshRestoreTipsNode
---@param entity MapDecryptionAntiqueRestorationEntity
function MapDecryptionAntiqueRestorationDialog:FreshRestoreTipsNode(entity, i, finalAntiqueIsUnlock, finalAntiqueId)
    local antiqueId  = entity.antiqueId
    if antiqueId == finalAntiqueId or finalAntiqueIsUnlock then
        return
    end
    local status     = entity.status
    --- 如果 未获得古物则不加载
    if status == 0 or status == 2 then
        return
    end
    local antiqueNode, parent = self._controllerComp:GetAntiqueTipsPosition(antiqueId), self.AntiqueRestorationTipsRoot
    local v2 = CfUtils.WorldPosition2UIPosition(antiqueNode.position, parent.transform)
    local tipsNode = self[string.format("TipsNode%s", i)]
    if isNotNull( tipsNode ) then
        tipsNode.anchoredPosition = v2
        local redPoint = tipsNode:Find("redPoint")
        if isNotNull(redPoint) then
            local isCan = MapDecryptionMgr:GetComponent():CheckAntiqueIsCanRestore(entity)
            CfUtils.SetActive(redPoint, isCan)
        end
    end

    self._antiqueId2TipsNodes[antiqueId] = tipsNode
    CfUtils.SetActive(tipsNode, true)
    return true
end

function MapDecryptionAntiqueRestorationDialog:LoadProgressNode()
    if not isNull(self._ProgressNode) then
        return
    end
    self._progressNodeLoaderCo = cs_coroutine.start(function ()
        local parent = self.Root.gameObject
        self._ProgressNode = MapDecryptionUtils.CreateGameObjectByPath(MapDecryptionConstants.PrefabPath.AntiqueRestorationProgressNode, parent)
        if not isNull(parent) then
            KTool.SetActive(self._ProgressNode.gameObject, not self._isShowContainer)

            local Touch = self._ProgressNode.transform:Find("Root/Container/Touch")
            SetButtonAction(Touch.gameObject, Bind(self, self.OnClickProgressNodeAction))

        end
        -- self._ProgressNode = go
    end)
end

function MapDecryptionAntiqueRestorationDialog:InitAction()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickRestoreBtnAction))

    self.__OnRequestSuccess = Events.AddListener(MapDecryptionConstants.EventNames.RequestSuccess, Bind(self, self.OnRequestSuccess))
end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshPanel
--- 刷新古物面板数据
---@param antiqueEntity MapDecryptionAntiqueRestorationEntity
function MapDecryptionAntiqueRestorationDialog:FreshPanel(antiqueEntity)
    self._antiqueEntity = antiqueEntity

    local status = antiqueEntity.status
    local isRestore = status == 2
    KTool.SetActive(self.RepairNode.gameObject,   not isRestore)
    KTool.SetActive(self.DescribeNode.gameObject, isRestore)
    if isRestore then
        self:FreshAntiqueDesc(antiqueEntity)
    else
        self:FreshRestorationInfo(antiqueEntity)
    end

end

--- FreshRestorationInfo
--- 刷新修复信息
---@param antiqueEntity MapDecryptionAntiqueRestorationEntity
function MapDecryptionAntiqueRestorationDialog:FreshRestorationInfo(antiqueEntity)
    ---刷新icon
    ---@type MapDecryptionAntiqueRestorationVo
    local antiqueRestorationVo = antiqueEntity.antiqueRestorationVo
    self.ImgIcon:LoadSprite(antiqueRestorationVo.picture)

    ---刷新描述
    self.TxtTitle.text = antiqueRestorationVo.desc

    ---刷新奖励
    local rewards = antiqueEntity.isFinal and antiqueRestorationVo.composeGoods or antiqueRestorationVo.stuffGoods
    UICommonUtils.FillCommonGoodsList(self.CommonGoodsList, rewards, nil, nil, true, true)

    local isShowTips = antiqueEntity.status == 0 or (antiqueEntity.status == 1 and not GoodsUtils.CheckGoodConsumeCondition(rewards))
    KTool.SetActive(self.TxtTips.gameObject, isShowTips)
    KTool.SetActive(self.FontStyleButton.gameObject, not isShowTips)
    if isShowTips then
        ---@type MapDecryptionDecryptedMapsVo
        local mapVo = MapDecryptionConfMgr:GetDecryptedMapsById(antiqueRestorationVo.mapId)
        self.TxtTips.text = localize("在_name_可以收集到修复材料", {_name_ = mapVo.name})
    end
end

--- FreshRestorationInfo
--- 刷新古物详情
---@param antiqueEntity MapDecryptionAntiqueRestorationEntity
function MapDecryptionAntiqueRestorationDialog:FreshAntiqueDesc(antiqueEntity)
    ---@type MapDecryptionAntiqueRestorationVo
    local antiqueRestorationVo = antiqueEntity.antiqueRestorationVo

    self.DescTxtTitle.text = antiqueRestorationVo.name
    self.TxtContent.text   = antiqueRestorationVo.desc
    
end

--- RestoreAntique
--- 恢复古物
---@param antiqueEntity MapDecryptionAntiqueRestorationEntity
function MapDecryptionAntiqueRestorationDialog:RestoreAntique(antiqueEntity)
    --- 如果当前是最后一个古物
    --- 则隐藏前面的古物

    --- 处理古物模型相关的加载
    -- self._controllerComp:RestoreAntique(antiqueEntity)
    local isFinal = antiqueEntity.isFinal
    if isFinal then
        --- 隐藏 MapDecryptionAntiqueRestorationProgressNode
        KTool.SafeDelete(self._ProgressNode)
        self._ProgressNode = nil
        -- KTool.SetActive(self._ProgressNode.gameObject, false)
        for i, v in pairs(self._antiqueLabelNodes) do
            -- KTool.SetActive(v.gameObject, false)
            KTool.SafeDelete(v)
        end
        self._antiqueLabelNodes = {}

    else
        self:LoadAntiqueLabel(antiqueEntity, self.Root.gameObject)
        ---如果触发最后一个古物解锁
        ---@type MapDecryptionAntiqueRestorationEntity
        local entity = self._entityList[#self._entityList]
        if entity.status == 1 then
            self:LoadProgressNode()
        end
        
    end
    local node = self._antiqueId2TipsNodes[antiqueEntity.antiqueId]
    if isNotNull(node) then
        self._antiqueId2TipsNodes[antiqueEntity.antiqueId] = nil
        CfUtils.SetActive(node, false)
    end

    self:FreshPanel(antiqueEntity)
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function MapDecryptionAntiqueRestorationDialog:SetContainerShowState(isShow)
    self._isShowContainer = isShow
    KTool.SetActive(self.Container.gameObject, isShow)
    
    for k, v in pairs(self._antiqueLabelNodes) do
        KTool.SetActive(v.gameObject, not isShow)
        
    end

    for index, value in pairs(self._antiqueId2TipsNodes) do
        KTool.SetActive(value.gameObject, not isShow)
    end

    if self._ProgressNode then
        KTool.SetActive(self._ProgressNode.gameObject, not self._isShowContainer)
    end
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

--- OnClickAntiqueAction
--- 点击古物事件
---@param entity MapDecryptionAntiqueRestorationEntity
function MapDecryptionAntiqueRestorationDialog:OnClickAntiqueAction(entity)
    if self._isShowContainer then
        return
    end
    local antiqueId = entity.antiqueId
    if self._curSelectAntiqueId == antiqueId then return end
    
    self._curSelectAntiqueId = antiqueId

    --- 1. 显示对应的虚拟相机
    self._controllerComp:LookAtAntique(antiqueId)

    --- 2. 显示容器
    self:SetContainerShowState(true)

    --- 3. 刷新对应的古物面板
    self:FreshPanel(entity)

end

function MapDecryptionAntiqueRestorationDialog:OnClickRestoreBtnAction()
    local antiqueEntity = self._antiqueEntity
    self:RequestRestore(antiqueEntity)

end
function MapDecryptionAntiqueRestorationDialog:RequestRestore(antiqueEntity)
    local antiqueId     = antiqueEntity.antiqueId
    local isFinal       = antiqueEntity.isFinal
    ---@type MapDecryptionAntiqueRestorationVo
    local antiqueRestorationVo = antiqueEntity.antiqueRestorationVo
    if isFinal then
        MapDecryptionMgr:RequestCompositeAntiques(antiqueId, antiqueRestorationVo.composeGoods)
    else
        MapDecryptionMgr:RequestRepairAntiques(antiqueId, antiqueRestorationVo.stuffGoods)
    end
end
function MapDecryptionAntiqueRestorationDialog:OnRequestSuccess(requestPath)
    if not (requestPath == Interfaces.ActivityMapDecryptionRepairAntiques or 
        requestPath == Interfaces.ActivityMapDecryptionCompositeAntiques) then return end
    ---------------------------------------
    --- 更新本地数据
    ---@type MapDecryptionAntiqueRestorationEntity[]
    self._entityList = self._component:GetAntiqueEntityList()

    ---------------------------------------
    --- 更新UI
    self:RestoreAntique(self._antiqueEntity)

    self:RefreshRestoreTipsNodes()

    ---------------------------------------
    --- 显示修复后的弹窗
    MapDecryptionUtils.EnterEventResultPopup({refId = self._antiqueEntity.antiqueId, eventResType = MapDecryptionConstants.EventResult.AntiqueRestore})

end

function MapDecryptionAntiqueRestorationDialog:OnClickProgressNodeAction()
    self._antiqueEntity = self._entityList[#self._entityList]
    self:RequestRestore(self._antiqueEntity)
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionAntiqueRestorationDialog
