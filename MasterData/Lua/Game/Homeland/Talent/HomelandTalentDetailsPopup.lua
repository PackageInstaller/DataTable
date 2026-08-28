
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
---@type HomelandTalentConstants
local HomelandTalentConstants = import("Game.Homeland.Talent.HomelandTalentConstants")
-- ---@type HomelandTalentConfMgr
-- local HomelandTalentConfMgr = import("Game.Homeland.Talent.HomelandTalentConfMgr")
---@type HomelandTalentUtils
local HomelandTalentUtils = import("Game.Homeland.Talent.HomelandTalentUtils")
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local Utils = CS.Engine.Tools.Utils
local RectTransformUtility = CS.UnityEngine.RectTransformUtility
local UIModule = CS.Engine.UI.UIModule
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--region define

local BlockName = "HomelandTalentDetailsPopup.SwitchAni"

--endregion

--- from: Assets/BundleResources/Prefabs/Homeland/HomelandTalentDetailsPopup.prefab > name: HomelandTalentDetailsPopup
---@class HomelandTalentDetailsPopup
---@field Env                           	HomelandTalentDetailsPopup              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ClickClose                    	UnityEngine.RectTransform               	@ 0    
---@field Root                          	UnityEngine.Animation                   	@ 1    
---@field Container                     	UnityEngine.RectTransform               	@ 2    
---@field RootCanvas                    	UnityEngine.Canvas                      	@ 3    
---@field TextTitle                     	CustomText                              	@ 4    
---@field TextNumber                    	Game.Native.Common.UISwitchTextMeshPro  	@ 5    
---@field InfoTextDesc                  	CustomText                              	@ 6    
---@field ImgSymbol                     	Game.Native.Common.UISwitchImage        	@ 7    
---@field ImgIconSwitch                 	Game.Native.Common.UISwitchImage        	@ 8    
---@field ImgIcon                       	Engine.UI.ImageAlterable                	@ 9    
---@field UIFX_HomelandTalent_Upgrade   	UnityEngine.RectTransform               	@ 10   
---@field Attribute                     	UnityEngine.RectTransform               	@ 11   
---@field Normal                        	UnityEngine.RectTransform               	@ 12   
---@field TextNumberOld                 	TMPro.TextMeshProUGUI                   	@ 13   
---@field TextNumberNew                 	Game.Native.Common.UISwitchTextMeshPro  	@ 14   
---@field BtnExplain                    	UnityEngine.RectTransform               	@ 15   
---@field TextDesc                      	CustomText                              	@ 16   
---@field StatusLock                    	UnityEngine.RectTransform               	@ 17   
---@field StatusLockTextDesc            	CustomText                              	@ 18   
---@field PreTalent                     	UnityEngine.RectTransform               	@ 19   
---@field TalentNode                    	UnityEngine.RectTransform               	@ 20   
---@field StatusCanLevelUp              	UnityEngine.RectTransform               	@ 21   
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 22   
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               	@ 23   
---@field StatusMax                     	UnityEngine.RectTransform               	@ 24   
---@field TextAttribute                 	CustomText                              	@ 25   
---@field HomelandTalentDetailsPopup    	UnityEngine.CanvasGroup                 	@ 26   
local HomelandTalentDetailsPopup = Class('HomelandTalentDetailsPopup')


function HomelandTalentDetailsPopup:__init()
end


function HomelandTalentDetailsPopup:__delete()
    self.controller = nil
end

function HomelandTalentDetailsPopup:OnDestroy()
    if self._behaviourAction then
        self._behaviourAction.UpdateAction = nil
        self._behaviourAction = nil
    end
    self:RemoveListeners()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
    self = nil
end


-- function HomelandTalentDetailsPopup:Awake()
-- end

function HomelandTalentDetailsPopup:Start()
    self:InitAction()
end


-- function HomelandTalentDetailsPopup:OnFocus(focus)

-- end


-- function HomelandTalentDetailsPopup:OnInitialize()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
--         self:OnInit()
--     end))
--     return coWait
-- end


-- function HomelandTalentDetailsPopup:OnShow()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

--     end))
--     return coWait
-- end


-- function HomelandTalentDetailsPopup:OnFinalize()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
--         self:RemoveListeners()
--         self.controller = nil --删除lua层引⽤用到的c#对象
--         self:Delete()
--         self = nil
--     end))
--     return coWait
-- end


--region init 

function HomelandTalentDetailsPopup:InitData(data, labelType)
    --- {vo:HomelandTalentVo, status:HomelandTalentConstants.TalentNodeStatus}
    -- local data       = parameters.data
    -- local labelType  = parameters.labelType
    self._data       = data
    self._labelType  = labelType

    ---@type HomelandTalentComponent
    local component  = GameUtils.GetEntityCompByType(ECSComponentType.Constants.HomelandTalentComponent)
    local dojo       = component:GetHomelandTalentDojo()
    self._dojo       = dojo

end

function HomelandTalentDetailsPopup:InitAction()
    -- SetButtonAction(self.ClickClose,      Bind(self, self.OnClickCloseBtnAction))
    SetButtonAction(self.BtnExplain,      Bind(self, self.OnClickBtnExplainAction))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickUpLvBtnAction))

    local listenerConf = {
        [HomelandTalentConstants.EventNames.RequestSuccess] = Bind(self, self.OnRequestSuccess),
    }
    for eventName, func in pairs(listenerConf) do
        Events.AddListener(eventName, func)
    end

    self._listenerConf = listenerConf

    local behaviourAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
    if behaviourAction then
        behaviourAction.UpdateAction = Bind(self, self.Update)
        self._behaviourAction = behaviourAction
    end
end

function HomelandTalentDetailsPopup:Update()
    if self._switching or not self._isShow then
        return
    end
    if Utils.TouchCount() > 0 then
        local positionV = Utils.GetInputDownPos()
        local position = Vector2.New(positionV.x, positionV.y)
        if position ~= Vector2.zero then
            local camera = UIModule.RootCanvas.canvas.worldCamera
            local isInRect = RectTransformUtility.RectangleContainsScreenPoint(self.Container, position, camera)
            if not isInRect then
                self:OnClickCloseBtnAction()     
            end
            
        end
    end

end

function HomelandTalentDetailsPopup:RemoveListeners()
    for eventName, func in pairs(self._listenerConf) do
        Events.RemoveListener(eventName, func)
    end
end

--endregion 


--region logic 

---FreshUI
---@param data table {vo:HomelandTalentVo, status:HomelandTalentConstants.TalentNodeStatus, talentLV: number, maxLv: number}
---@param labelType number
function HomelandTalentDetailsPopup:FreshUI(data, labelType)
    self:PlayChooseAni()
    -- {vo:HomelandTalentVo, status:HomelandTalentConstants.TalentNodeStatus, talentLV: number, maxLv: number}
    if self._data == data then
        return
    end
    
    self:InitData(data, labelType)
    self:ShowUI()

end

function HomelandTalentDetailsPopup:PlayChooseAni()
    
    ---检查是否在播取消动画
    if self.Root:IsPlaying(HomelandTalentConstants.AnimNames.HomelandTalentDetailsPopup_Cancel) then
        self._switching = true
        UICommonUtils.BlockerAndStartCo(BlockName, function() 
            local CoYield = CoYield
            while self.Root:IsPlaying(HomelandTalentConstants.AnimNames.HomelandTalentDetailsPopup_Cancel) do
                CoYield()
            end
            self._switching = false
            self:FreshBlockRaycasts(true)
            CfUtils.PlayAnimation(self.Root, HomelandTalentConstants.AnimNames.HomelandTalentDetailsPopup_Choose)
        end, true)
    else
        GameUtils.PlayAndWaitForAnim(self.Root, HomelandTalentConstants.AnimNames.HomelandTalentDetailsPopup_Choose, function() 
            self:FreshBlockRaycasts(true)
        end, BlockName)

        -- CfUtils.PlayAnimation(self.Root, HomelandTalentConstants.AnimNames.HomelandTalentDetailsPopup_Choose)
        
    end
end

function HomelandTalentDetailsPopup:ShowUI()
    local data = self._data
    -- print(table.toString(data))
    ---@type HomelandTalentVo
    local vo   = data.vo
    self.TextTitle.text = vo.name

    local labelType = self._labelType

    ---@type HomelandTalentConstants.TalentNodeStatus
    local status = data.status
    local isMax  = status == HomelandTalentConstants.TalentNodeStatus.Max
    local uiStatus = isMax and (labelType + 1) or 1

    self.TextNumber.text   = string.format("%s/%s", data.talentLv, data.maxLv)
    self.TextNumber.Status = uiStatus

    self.ImgSymbol.Status = uiStatus

    self.ImgIcon:LoadSprite(vo.icon)
    self.ImgIconSwitch.Status = uiStatus

    local isLock         = status == HomelandTalentConstants.TalentNodeStatus.Lock
    local isSystemLock   = status == HomelandTalentConstants.TalentNodeStatus.SystemLock
    local isActiveUnmet  = status == HomelandTalentConstants.TalentNodeStatus.ActiveUnmet
    local isActive = status == HomelandTalentConstants.TalentNodeStatus.Active
    CfUtils.SetActive(self.StatusMax, isMax)
    CfUtils.SetActive(self.StatusLock, isSystemLock or isLock)
    CfUtils.SetActive(self.StatusLockTextDesc, isSystemLock)
    CfUtils.SetActive(self.StatusCanLevelUp, isActive or isActiveUnmet)
    CfUtils.SetActive(self.TextAttribute, isMax)
    CfUtils.SetActive(self.Normal, not isMax)
    CfUtils.SetActive(self.TextDesc, not isMax)

    local maxLv = data.maxLv
    local talentLv = data.talentLv
    local talentId = vo.talentId
    -- if not (isActive or isActiveUnmet) then
    --     local attrText = HomelandTalentUtils.GetTalentAttrText(talentId, (isSystemLock or isLock) and 1 or maxLv, true)
    --     self.TextAttribute.text = attrText

    --     if isSystemLock or isLock then
    --         self:FreshPreTalent(vo)
    --     end

    --     self._consumes = nil
    -- else
    --     local consumes
    --     if talentLv > 0 then
    --         local curLvAttrText, nextLvAttrText, consumes_ = HomelandTalentUtils.GetTalentNexLvAttrText(talentId, talentLv, maxLv)
    --         consumes = consumes_

    --         self.TextNumberOld.text = curLvAttrText
    --         self.TextNumberNew.text = nextLvAttrText

    --         self.TextNumberNew.Status = (talentLv + 1 >= maxLv) and (labelType + 1) or 1
    --     else
    --         local attrText, _, consumes_ = HomelandTalentUtils.GetTalentAttrText(talentId, 1, true)
    --         consumes = consumes_
    --         self.TextAttribute.text = attrText

    --     end

    --     self._consumes = consumes

    --     local consume = table.takeFirst(consumes)
    --     UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, consume.goodsId, consume.num)

    -- end

    if isMax then
        local attrText = HomelandTalentUtils.GetTalentAttrText(talentId, maxLv)
        self.TextAttribute.text = attrText
    else
        if isSystemLock or isLock then
            self:FreshPreTalent(vo)
        end
        if isSystemLock then
            local systemId = vo.systemId
            local desc = GameUtils.GetUnlockDescrBySystemTogId(systemId)
            self.StatusLockTextDesc.text = desc
        end

        local curLvAttrText, nextLvAttrText, consumes = HomelandTalentUtils.GetTalentNexLvAttrText(talentId, talentLv, maxLv)

        self.TextNumberOld.text = curLvAttrText
        self.TextNumberNew.text = nextLvAttrText

        self.TextNumberNew.Status = (talentLv + 1 >= maxLv) and (labelType + 1) or 1

        if isActive or isActiveUnmet then
            local consume = table.takeFirst(consumes)
            self._consumes = consumes
            UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, consume.goodsId, consume.num)
        end


    end
    
    local talentLv = data.talentLv
    local isLock = talentLv == 0
    self.InfoTextDesc.text = HomelandTalentUtils.GetLvNumText(vo, isLock and 1 or talentLv, isLock)
end

---FreshPreTalent
---@param vo HomelandTalentVo
function HomelandTalentDetailsPopup:FreshPreTalent(vo)
    local talentId2Data  = self._dojo:GetTalentId2Data()
    local list = HomelandTalentUtils.GeneratePreTalentDataList(vo, talentId2Data)
    GameUtils.ResizeContent(self.PreTalent, self.TalentNode, #list, function(index, cell) 
        ---@type HomelandTalentPositionNode
        local env = CfUtils.GetLuaScr(cell, HomelandTalentConstants.EnvPath.HomelandTalentPositionNode)
        if isNotNull(env) then
            env:FreshUI(list[index], false, self._labelType, index)
        end
    end)

end

function HomelandTalentDetailsPopup:FreshBlockRaycasts(isShow)
    self._isShow = isShow
    local canvasGroup = self.HomelandTalentDetailsPopup
    canvasGroup.interactable = isShow
    canvasGroup.blocksRaycasts = isShow
end

function HomelandTalentDetailsPopup:PlayUpgradeEffect()
    local particleSystems = self._particleSystems
    if particleSystems == nil then
        local gameObject = self.UIFX_HomelandTalent_Upgrade.gameObject
        KTool.SetActive(gameObject, true)
        self._particleSystems = gameObject:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystem))
    else
        for i = 0, particleSystems.Length - 1 do 
            ---@type UnityEngine.ParticleSystem
            local ps = particleSystems[i]
            ps:Play(true)
        end
    end
end

--endregion 


--region get/set 

---endregion 


--region handler 

function HomelandTalentDetailsPopup:OnClickCloseBtnAction()
    if not self._isShow then
        return
    end
    Events.Broadcast(HomelandTalentConstants.EventNames.CloseDetailPopup)
    CfUtils.PlayAnimation(self.Root, HomelandTalentConstants.AnimNames.HomelandTalentDetailsPopup_Cancel)
    self:FreshBlockRaycasts(false)
    -- self.RootCanvas.enabled = false

end

function HomelandTalentDetailsPopup:OnClickBtnExplainAction()
    ---@type HomelandTalentVo
    local vo = self._data.vo
    local data = HomelandTalentUtils.GetAllLvNumText(vo)
    ---@type CardProgressionUtils
    local CardProgressionUtils = import("Game.CardProgression.CardProgressionUtils")
    CardProgressionUtils.ShowCommonTipsSkill(self.Attribute, data)
    
end

function HomelandTalentDetailsPopup:OnClickUpLvBtnAction()
    local consumes = self._consumes
    if consumes == nil then
        return
    end

    local realConsume, errorTip = GoodsUtils.CheckGoodConsume(consumes)
    if errorTip then
        -- GameUtils.Toast(errorTip)
        GoodsUtils.CheckConsumeDataCondition(consumes)
        return
    end

    local data = self._data
    ---@type HomelandTalentConstants.TalentNodeStatus
    local status = data.status
    local talentId = data.vo.talentId
    
    ---@type HomelandTalentComponent
    local component                   = GameUtils.GetEntityCompByType(ECSComponentType.Constants.HomelandTalentComponent)
    if status == HomelandTalentConstants.TalentNodeStatus.ActiveUnmet then
        component:RequestTalentUnlock(talentId, realConsume)
    elseif status == HomelandTalentConstants.TalentNodeStatus.Active then
        component:RequestTalentUpgrade(talentId, realConsume)
    end

end

function HomelandTalentDetailsPopup:OnRequestSuccess(interface, resultData, requestData)
    if interface == Interfaces.TalentUnlock or interface == Interfaces.TalentUpgrade then
        self._data = HomelandTalentUtils.UpdateTalentDataStatus(self._data, resultData)
        self:ShowUI()
        
    end
end

---endregion 


return HomelandTalentDetailsPopup
