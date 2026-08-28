---
--- Created by Eric.
--- DateTime: 2021/12/9 11:02
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local support = require 'Frame.support'
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local CatHouseMgr = import('Game.CatHouse.CatHouseMgr')
---@type ConstantsCatHouse
local ConstantsCatHouse = import("Game.CatHouse.ConstantsCatHouse")
local Yielders = CS.Engine.Lib.Yielders
local cs_coroutine = require 'XLua.cs_coroutine'
local sceneManagement = SceneManagement:GetInstance()
local URPBaseCamera = CS.Game.Native.URP.URPBaseCamera
local CatHouseComponent-- = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseComponent, Constants.CatHouseEntityId)
local QuickTap = CS.HedgehogTeam.EasyTouch.QuickTap
local Animator = CS.UnityEngine.Animator
local PlayableDirector = CS.UnityEngine.Playables.PlayableDirector
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance
local GameObject = CS.UnityEngine.GameObject
local ResourceModule = CS.Engine.Modules.ResourceModule
local PinchAndDragInputModule = CS.Engine.UI.PinchAndDragInputModule
local EasyTouch = CS.HedgehogTeam.EasyTouch.EasyTouch
local KCookie = CS.Engine.Lib.KCookie
local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
local NamedAnimancerComponent = CS.Animancer.NamedAnimancerComponent
local GachaponUtils = import('Game.Gachapon.GachaponUtils')
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

---@type ConstantsCatAction
local ConstantsCatAction = import("Game.CatHouse.ConstantsCatAction")

------------ import ------------

local DESTROY_EVENT_NAME = "DESTROY_EVENT_NAME"

------------ define ------------
local DelayTime = Yielders.GetWaitForSeconds(0.3)
local DelayTime1 = Yielders.GetWaitForSeconds(0.06)
local SwitchImageStatusCollect = {
    Normal = 1,
    Light = 2,
}
local SwitchTextStatusStage = {
    Child = 1,
    Adult = 2,
}
local UseGoodsType = {
    Food = 1,
    Toy = 2,
}
local MAX_NAME_LENGTH = 7
local CatModelLocalRotation = ConstantsCatHouse.CatModelInteractionLocalRotation
local CatEvolutionTrackIndex = {
    Gold = 2,
    Mix = 3,
    Colorful = 4,
}

local shadowVerticalOffset = 0.034 -- 原始值为 0.034
------------ define ------------


---@class CatHouseInteractionDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field BtnStrategyEntry              	UnityEngine.RectTransform
---@field BtnShare                      	UnityEngine.RectTransform
---@field TextTrain2                    	TMPro.TextMeshProUGUI
---@field TextTrain                     	UnityEngine.UI.Text
---@field BtnTrain                      	UnityEngine.RectTransform
---@field RightOpitionBtnPanel          	UnityEngine.RectTransform
---@field CatHouseCountdownNode         	UnityEngine.RectTransform
---@field BtnArrowRight                 	UnityEngine.RectTransform
---@field BtnArrowLeft                  	UnityEngine.RectTransform
---@field TextNumberCulitvation         	TMPro.TextMeshProUGUI
---@field BtnCulitvation                	UnityEngine.RectTransform
---@field CancelInteraction             	UnityEngine.RectTransform
---@field BtnNodeExplore                	UnityEngine.RectTransform
---@field CatTrainGroup                 	UnityEngine.RectTransform
---@field BtnEvolution                  	UnityEngine.RectTransform
---@field DataListgroup                 	UnityEngine.RectTransform
---@field AttributeNode                 	UnityEngine.RectTransform
---@field LayoutAtrribute               	UnityEngine.RectTransform
---@field BtnInitialization             	UnityEngine.RectTransform
---@field ImgStage                      	Game.Native.Common.UISwitchImage
---@field TextStage                     	Game.Native.Common.UISwitchText
---@field TextCatType                   	UnityEngine.UI.Text
---@field TextCatBirth                  	TMPro.TextMeshProUGUI
---@field ImgCollect                    	Game.Native.Common.UISwitchImage
---@field BtnCollect                    	UnityEngine.RectTransform
---@field BtnRename                     	UnityEngine.RectTransform
---@field TextCatName                   	UnityEngine.UI.Text
---@field Content                       	UnityEngine.RectTransform
---@field DragBg                        	UnityEngine.RectTransform
---@field AnimRoot                      	UnityEngine.Animator
local CatHouseInteractionDialog = Class("CatHouseInteractionDialog")
function CatHouseInteractionDialog:__init()
    self.toyGoodsVo = {}
    self.foodGoodsVo = {}
    self.catAttrVo = {}
    self.catAttrMap = {}
    self.selectedCatIndex = 0
    self.catHouseHomeDojo = {}
    self.catDataList = {}
    self.selectedGoodIndex = -1
    self.selectedGoodNum = 0
    self.useGoodsType = nil--1食物2玩具
    self.isUsedToy = false
    self.isInTheInteraction = false
    self.isNotChangedCamera = false
    self.catEvolutionDirector = nil
    --self.growthValueBase = nil
    self.trainTimeLimit = nil
    self.catGoMap = {} --name = gameObject
    self.attrNodeMap = {}
    self.coList = {}
    self.loaderList = {}
    self.timeLineGoList = {}
    --self.coWait = nil
    self.isFinish = false
    self.animState = ""
    self.catDataListOriginal = nil--原始的猫数据list
    self.trainConsumeId = nil
    self.trainConsumeNum = nil
end

function CatHouseInteractionDialog:__delete()
    self.toyGoodsVo = nil
    self.foodGoodsVo = nil
    self.catAttrVo = nil
    self.catAttrMap = nil
    self.selectedCatIndex = nil
    self.catHouseHomeDojo = nil
    self.catDataList = nil
    self.selectedGoodIndex = nil
    self.selectedGoodNum = nil
    self.useGoodsType = nil
    self.isUsedToy = nil
    self.isInTheInteraction = nil
    self.isNotChangedCamera = nil
    self.catEvolutionDirector = nil
    --self.growthValueBase = nil
    self.trainTimeLimit = nil
    self.catGoMap = nil
    self.attrNodeMap = nil
    self.coList = nil
    self.loaderList = nil
    self.timeLineGoList = nil
    --self.coWait = nil
    self.isFinish = nil
    self.animState = nil
    self.catDataListOriginal = nil
    self.trainConsumeId = nil
    self.trainConsumeNum = nil
    self.controller = nil
end

function CatHouseInteractionDialog:Awake()
    CfUtils.RefreshTopGoods({
        Constants.Currency.GoldId,
    })
    CatHouseComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseComponent, Constants.CatHouseEntityId)
    self.EventTrainRolesSelectJump = Events.AddListener(Constants.EventNames.CatHouseCatTrainRolesSelectJump, Bind(self, self.TrainRolesSelectJump))

    --self.EventRename = Events.AddListener(Constants.EventNames.CatHouseCatRename, Bind(self, self.FreshCatName))
    --self.EventAttrPreview = Events.AddListener(Constants.EventNames.CatHouseCatAttrPreview, Bind(self, self.FreshAttrPreview))
    --self.EventCatFatStatusChange = Events.AddListener(Constants.EventNames.CatHouseCatFatOrRecoverySwitchEventName, Bind(self, self.CatFatStatusChange))
    --self.EventTimeChange = Events.AddListener(Constants.EventNames.CatHouseTimeChange, Bind(self, self.OnCatHouseTimeChange))
    --self.growthValueBase = checkNumber(CfUtils.GetCfVo(AutoIds.IdSetting1903, "BaseArgVo", ConstantsCatHouse.Params.GrowthValueUpLimit).num)
    self.trainTimeLimit = checkNumber(CfUtils.GetCfVo(AutoIds.IdSetting1903, "BaseArgVo", ConstantsCatHouse.Params.TrainTimeLimit).num)
    self.trainConsumeId = checkNumber(CfUtils.GetCfVo(AutoIds.IdSetting1903, "BaseArgVo", ConstantsCatHouse.Params.TrainConsumeId).num)
    self.trainConsumeNum = checkNumber(CfUtils.GetCfVo(AutoIds.IdSetting1903, "BaseArgVo", ConstantsCatHouse.Params.TrainConsumeNum).num)
    KTool.SetActive(self.BtnShare, Constants.MODULE_SWITCH.SHARE)
end

function CatHouseInteractionDialog:OnFocus(focus)
    KTool.SetActive(self.controller.gameObject, focus)
    for k, v in pairs(self.catGoMap) do
        if v then
            KTool.SetActive(v, focus)
        end
    end
    if not self.isNotChangedCamera then
        KTool.SetActive(self.cameraObject, focus)
    else
        self.isNotChangedCamera = false
    end

    if not isNull(self.allowUIDetectionStatus) then
        local status = clone(self.allowUIDetectionStatus)
        EasyTouch.instance.allowUIDetection = status
        self.allowUIDetectionStatus = nil
    else
        EasyTouch.instance.allowUIDetection = not focus
    end
    if focus then
        --if not string.isEmpty(self.animState) then
        --    self.AnimRoot:Play(self.animState)
        --    if self.useGoodsType == UseGoodsType.Food then
        --        self:FreshFoodUI()
        --    elseif self.useGoodsType == UseGoodsType.Toy then
        --        self:FreshToyUI()
        --    end
        --end
        local env = CfUtils.GetLuaScr(self.CatTrainGroup, "Game.CatHouse.Interaction.CatHouseInteractionTrain")
        local rolesData = env:GetTrainCell()
        Events.Broadcast(Constants.EventNames.CatHouseCatAttrPreview, rolesData)
    end
end

function CatHouseInteractionDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        ---@type SceneInstance
        local sceneInstance = sceneManagement:GetSceneInstance(Constants.IdSceneSetting24)
        sceneManagement:SetActive(Constants.IdSceneSetting24, true)
        cs_coroutine.yield_return()
        self.cameraObject = sceneInstance:GetCacheObjectByName("Main Camera")
        KTool.GetOrAddComponent(self.cameraObject, typeof(URPBaseCamera))
        local argument = self.controller.Argument
        if not isNull(argument.parameters) then
            EasyTouch.instance.allowUIDetection = false
            KTool.SetActive(self.DragBg, true)
            local catId = argument.parameters.catId
            local catDataList = argument.parameters.catDataList
            self.catHouseHomeDojo = CatHouseComponent:GetCatHouseHomeDojo()
            if not isNull(catDataList) then
                self.catDataListOriginal = clone(catDataList)
            else
                self.catDataListOriginal = self.catHouseHomeDojo.catList
            end
            self:SetCatDataList()
            self.selectedCatIndex = self:GetCurrentCatIndex(catId)
            --self:InitFoodGoodsVo()
            --self:InitToyGoodsVo()
            self:SetBtnAction()
            self.AnimRoot:Play("Go")

            self:FreshEntranceUI()
        end
    end))
    return coWait
end

function CatHouseInteractionDialog:SetCatDataList()
    self.catDataList = {}
    if self.catDataListOriginal then
        for k, v in pairs(self.catDataListOriginal) do
            local catStatus = CatHouseComponent:GetCDDataById(v.id)
            if catStatus == nil or catStatus[ConstantsCatHouse.CatStatus.Hatching] == nil then
                local catData = CatHouseComponent:GetCatDataById(v.id)
                table.insert(self.catDataList, catData)
            end
        end
    end
end

---@param catData table 猫数据
function CatHouseInteractionDialog:GetCatGameObjectName(catData)
    return string.format("myCat%s_%s", catData.id, catData.age)
end

function CatHouseInteractionDialog:FreshEntranceUI()
    local co = cs_coroutine.start(function()
        UIRaycastBlocker:AddCondition("CatHouseInteractionDialogFreshEntranceUI")
        xTry(
                function()
                    local currentCatData = self.catDataList[self.selectedCatIndex]
                    print("currentCatData----->>"..table.dump(currentCatData, nil, 3))
                    local isChild = currentCatData.age == ConstantsCatHouse.BornType.Baby
                    local isAdult = currentCatData.age == ConstantsCatHouse.BornType.Adult
                    --currentCatData.age = ConstantsCatHouse.BornType.Baby
                    local name = self:GetCatGameObjectName(currentCatData)
                    local env = CfUtils.GetLuaScr(self.CatHouseCountdownNode, "Game.CatHouse.CatHouseCountdownNode")
                    if env then
                        env:FreshUI(currentCatData)
                    end
                    --if not isNull(self.catGoMap[name]) then
                    --KTool.SetActive(self.catGoMap[name], true)
                    --else
                    if isNull(self.catGoMap[name]) then
                        local geneList = CatHouseMgr:GetInstance():GetAttributes(currentCatData.genes)
                        cs_coroutine.yield_return(
                                CatHouseMgr:GetInstance():LoadCatModelAsync(currentCatData.age, currentCatData.catId, false, geneList, nil, function(go)
                                    --table.insert(self.catCaches, go)
                                    ---@type UnityEngine.Transform
                                    go.name = name
                                    self.catGoMap[name] = go
                                    local trans = go.transform
                                    trans.position = Vector3.New(0, shadowVerticalOffset, 0)
                                    trans.localRotation = isAdult and CatModelLocalRotation.Adult or CatModelLocalRotation.Child
                                end)
                        )
                    end

                    --if self.catGoMap[name] then
                    --self:CatFatStatusChange()
                    self:SetCatTouchAndDrag()
                    ----领取猫后会出现birthday为0的情况的处理
                    local p = '(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)'
                    local year, month, day, hour, min, sec = tostring(currentCatData.birthday):match(p)
                    self.TextCatName.text = currentCatData.name
                    self.TextCatBirth.text = string.format("%s-%s-%s", year, month, day)--currentCatData.birthday

                    KTool.SetActive(self.BtnCulitvation, isAdult and checkNumber(currentCatData.deliveryRemainTimes) > 0)
                    if checkNumber(currentCatData.deliveryRemainTimes) > 0 then
                        self.TextNumberCulitvation.text = currentCatData.deliveryRemainTimes
                    end

                    local catVo = CfUtils.GetCfVo(AutoIds.IdSetting1906, "CatHouseCatVo", currentCatData.petId)
                    self.TextCatType.text = catVo.name
                    if #self.catAttrVo == 0 then
                        self.catAttrVo = CfUtils.GetWholeVo(AutoIds.IdSetting1901, "CatHouseCatAttributeVo")
                        if #self.catAttrMap == 0 then
                            for i, v in pairs(self.catAttrVo) do
                                self.catAttrMap[checkString(v.id)] = v
                            end
                        end
                    end
                    --local totalGrowthValueNow = 0
                    --if isAdult then
                    --    for i, v in pairs(currentCatData.genes) do
                    --        if checkNumber(v.skillId) > 0 then
                    --            local skillVo = CfUtils.GetCfVo(AutoIds.IdSetting1900, "CatHouseCatSkillVo", v.skillId)
                    --            local subjoinAttrId = skillVo.attributeId
                    --            if currentCatData.attr[checkString(subjoinAttrId)] then
                    --                currentCatData.attr[checkString(subjoinAttrId)] = currentCatData.attr[checkString(subjoinAttrId)] + checkNumber(v.additions)
                    --            end
                    --        end
                    --    end
                    --end
                    for i, v in pairs(self.catAttrVo) do
                        --当前基础属性刷新
                        if currentCatData.attr[checkString(v.id)] then
                            --totalGrowthValueNow = totalGrowthValueNow + currentCatData.attr[checkString(v.id)]
                            local go
                            go = self.attrNodeMap[tostring(v.id)]
                            if not go then
                                go = CfUtils.InstantiateGo(self.AttributeNode, self.LayoutAtrribute)
                                go.name = "Node" .. v.id
                                self.attrNodeMap[tostring(v.id)] = go
                            end
                            local goEnv = CfUtils.GetLuaScr(go, "Game.CatHouse.Interaction.CatHouseInteractionAttributeNode")
                            local attrData = {
                                id = v.id,
                                num = currentCatData.attr[checkString(v.id)],
                                --subJoin = 0,
                                upperLimit = v.upperLimit
                            }
                            goEnv:SetCatData(currentCatData)--设置猫数据，训练技能需要用到
                            goEnv:FreshBaseUI(self.catAttrVo[i])--非数字部分
                            goEnv:FreshAttrValue(attrData)--数字部分
                            --local env = CfUtils.GetLuaScr(self.CatTrainGroup, "Game.CatHouse.Interaction.CatHouseInteractionTrain")
                            --local rolesData = env:GetTrainCell()
                            --Events.Broadcast(Constants.EventNames.CatHouseCatAttrPreview, rolesData)
                            KTool.SetActive(go, true)
                            if self.isUsedToy then
                                goEnv:ShowIncreaseEffect()
                                local env = CfUtils.GetLuaScr(self.CatTrainGroup, "Game.CatHouse.Interaction.CatHouseInteractionTrain")
                                local rolesData = env:GetTrainCell()
                                Events.Broadcast(Constants.EventNames.CatHouseCatAttrPreview, rolesData)
                            end
                        end
                    end
                    --KTool.SetActive(self.Child, isChild)
                    --KTool.SetActive(self.Adult, isAdult)
                    --KTool.SetActive(self.BtnNodeToy, isChild)
                    local canEvolution = isChild and checkNumber(currentCatData.trainingTimes) >= self.trainTimeLimit
                    local canTrain = isChild and checkNumber(currentCatData.trainingTimes) < self.trainTimeLimit
                    local isUnlockExplore = GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id237)
                    KTool.SetActive(self.BtnNodeExplore, isAdult and isUnlockExplore)
                    KTool.SetActive(self.BtnCollect.transform, isAdult)
                    KTool.SetActive(self.BtnEvolution, canEvolution)
                    if not self.isUsedToy then
                        KTool.SetActive(self.BtnTrain, canTrain)
                    end
                    KTool.SetActive(self.BtnArrowLeft, not (self.selectedCatIndex == 1))
                    KTool.SetActive(self.BtnArrowRight, not (self.selectedCatIndex == #self.catDataList))
                    --KTool.SetActive(self.GrowthValueIncrease.transform, false)
                    self.TextStage.Status = isChild and SwitchTextStatusStage.Child or SwitchTextStatusStage.Adult
                    self.ImgStage.Status = isChild and SwitchTextStatusStage.Child or SwitchTextStatusStage.Adult
                    --KTool.SetActive(self.BtnTrain, canTrain)
                    local remainTimes = self.trainTimeLimit - checkNumber(currentCatData.trainingTimes)
                    local hasRemainTime = remainTimes > 0
                    KTool.SetActive(self.TextTrain2.transform.parent, hasRemainTime and isChild)
                    if hasRemainTime then
                        self.TextTrain2.text = self.trainTimeLimit - checkNumber(currentCatData.trainingTimes)
                    end
                    if isChild then
                        --KTool.SetActive(self.IncreaseSlider.transform, false)
                        --local growthValueBase = self.growthValueBase--CfUtils.GetCfVo(AutoIds.IdSetting1903, "BaseArgVo", ConstantsCatHouse.Params.GrowthValueUpLimit).num
                        --self.GrowthValueBase.text = "/" .. growthValueBase
                        --self.GrowthValueNow.text = totalGrowthValueNow
                        --self.Slider.value = totalGrowthValueNow / growthValueBase
                        self.TextTrain.text = localize("剩余<color=#2ffff5>_num_</color>次", {_num_ = remainTimes})
                        --if self.isUsedToy then
                        --    KTool.SetActive(self.UIFX_CatHouseInteractionDialog1, false)
                        --    KTool.SetActive(self.UIFX_CatHouseInteractionDialog1, true)
                        --end
                    elseif isAdult then
                        local isPartnerCat = checkNumber(self.catDataList[self.selectedCatIndex].id) == checkNumber(self.catHouseHomeDojo.partyCatId)
                        self.ImgCollect.Status = isPartnerCat and SwitchImageStatusCollect.Light or SwitchImageStatusCollect.Normal
                        CfUtils.PlayAnimator(self.BtnCollect.transform:Find("AnimRoot"), isPartnerCat and "Activate" or "Dark")
                    end

                    local dataListEnv = CfUtils.GetLuaScr(self.DataListgroup, "Game.CatHouse.Interaction.CatHouseInteractionDataList")
                    dataListEnv:FreshBaseUI(currentCatData)
                    --self:FreshStrength()
                    --
                    --local strengthVo = CfUtils.GetCfVo(AutoIds.IdSetting1901, "CatHouseCatAttributeVo", CatHouseComponent:GetStrengthAttrId())
                    --self.ImageStrength:LoadSprite(strengthVo.picture)

                    self.isUsedToy = false
                    UIRaycastBlocker:RemoveCondition("CatHouseInteractionDialogFreshEntranceUI")
                end)
    end,
            function()
                UIRaycastBlocker:RemoveCondition("CatHouseInteractionDialogFreshEntranceUI")
            end
    )
    table.insert(self.coList, co)
end

function CatHouseInteractionDialog:SetCatTouchAndDrag()
    local currentCatData = self.catDataList[self.selectedCatIndex]
    --currentCatData.age = ConstantsCatHouse.BornType.Baby
    local name = self:GetCatGameObjectName(currentCatData)
    --点击开始交互
    local tap = self.catGoMap[name].gameObject:EnsureComponent(typeof(QuickTap))
    tap.onTap:AddListener(function(gesture)
        self:DoCatInteraction()
    end)
    --旋转
    local dragComp = self.DragBg.gameObject:EnsureComponent(typeof(PinchAndDragInputModule))
    dragComp.onSingleFingerDrag:RemoveAllListeners()
    dragComp.onSingleFingerDrag:AddListener(function(delta)
        if isNull(delta) then
            return
        end
        local y = delta.y
        local x = delta.x
        local absX = math.abs(x)
        local absY = math.abs(y)
        if math.abs(absX - absY) <= 2 then
            return
        end
        if math.abs(y) <= math.abs(x) then
            local direction = x < 0 and 1 or -1
            local eulerAngles = Vector3.New(0, 1, 0)
            eulerAngles.y = eulerAngles.y * direction * math.abs(x)
            local currentCatData = self.catDataList[self.selectedCatIndex]
            local name = self:GetCatGameObjectName(currentCatData)
            self.catGoMap[name].transform:Rotate(eulerAngles)
        end
    end)
end

function CatHouseInteractionDialog:DoCatInteraction()
    if self.isInTheInteraction then
        if not self.isFinish then
            xTry(
                    function()
                        local co = cs_coroutine.start(function()
                            self.isFinish = true
                            --已经开启了交互，再次点击播放交互动画
                            local currentCatData = self.catDataList[self.selectedCatIndex]
                            local name = self:GetCatGameObjectName(currentCatData)
                            local isBaby = checkNumber(currentCatData.age) == ConstantsCatHouse.BornType.Baby
                            --self:CatFatStatusChange()
                            ---@type UnityEngine.Animator
                            local animator = KTool.GetComponent(self.catGoMap[name], typeof(NamedAnimancerComponent))
                            if not isNull(animator) then
                                if isBaby then
                                    local animancerState = animator:TryPlay("touch3", 1.5)
                                    if animancerState then
                                        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(animancerState.Length))
                                        animator:TryPlay("idle")
                                    end
                                else
                                    CatHouseMgr:PlayRandomCatAction(
                                            self.catGoMap[name].gameObject,
                                            ConstantsCatAction.Touch,
                                            function ()
                                                animator:TryPlay("idle")
                                            end
                                    )
                                end
                                self.isFinish = false
                            end
                        end)
                        table.insert(self.coList, co)
                    end,
                    function()
                        --UIRaycastBlocker:RemoveCondition("CatHouseInteractionDialogDoCatInteraction")
                    end
            )
        end
    else
        self.isInTheInteraction = true
        local currentCatData = self.catDataList[self.selectedCatIndex]
        local name = self:GetCatGameObjectName(currentCatData)
        ---@type UnityEngine.Animator
        local animator = KTool.GetComponent(self.catGoMap[name], typeof(Animator))
        if animator then
            animator:SetInteger("touch", 0)
        end
        --self.AnimRoot:Play("PreviewEnter")
        local navigatorScr = CfUtils.GetLuaScr(CS.UINavigationBarRoot.Instance.gameObject, "Game.Main.UINavigatorBar")
        if navigatorScr then
            navigatorScr:SetCustomBackHandlerAction(function()
                self.isInTheInteraction = false
                KTool.SetActive(self.Content, true)
                --KTool.SetActive(self.StrengthGroupMain, true)
                KTool.SetActive(self.CancelInteraction, false)
                navigatorScr:SetCustomBackHandlerAction(nil)
            end)
        end
        --KTool.SetActive(self.StrengthGroupMain, false)
        KTool.SetActive(self.Content, false)
        KTool.SetActive(self.CancelInteraction, true)
    end
end

--function CatHouseInteractionDialog:FreshStrength()
--    local currentCatData = self.catDataList[self.selectedCatIndex]
--    local strengthMainEnv = CfUtils.GetLuaScr(self.StrengthGroupMain, "Game.CatHouse.Interaction.CatHouseInteractionStrengthGroup")
--    if strengthMainEnv then
--        strengthMainEnv:FreshBaseUI(currentCatData)
--    end
--    local strengthEnv = CfUtils.GetLuaScr(self.StrengthGroup, "Game.CatHouse.Interaction.CatHouseInteractionStrengthGroup")
--    if strengthEnv then
--        strengthEnv:FreshBaseUI(currentCatData)
--    end
--end

-----@param data table id,num  id为选中道具的id  num为选中的数量
--function CatHouseInteractionDialog:FreshAttrPreview(data)
--    if isNull(data) then
--        return
--    end
--    local subjoinAttrMap = CatHouseComponent:GetSubjoinAttr(data)
--    local strengthAttrId = CatHouseComponent:GetStrengthAttrId()
--    local totalGrowthValueIncrease = 0
--    local currentCatData = self.catDataList[self.selectedCatIndex]
--    --print("subjoinAttrMap=====>>"..table.dump(subjoinAttrMap))
--    for k, v in pairs(subjoinAttrMap) do
--        if k ~= strengthAttrId then
--            --玩具
--            totalGrowthValueIncrease = totalGrowthValueIncrease + math.min(currentCatData.attr[k] + v, self.catAttrMap[k].upperLimit)
--        end
--    end
--    --self.IncreaseSlider.value = totalGrowthValueIncrease / self.growthValueBase
--    if data.num <= 0 then
--        KTool.SetActive(self.CommonBtnConsumePop, false)
--    end
--    --玩具体力消耗
--    local idType = GoodsUtils.GetIdType(data.id)
--    if idType == Constants.IDType.GoodsCatPlaying then
--        local isChoose = data.num > 0
--        KTool.SetActive(self.CommonBtnConsumePop, isChoose)
--        if isChoose then
--            local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(data.id)
--            local isEnough = checkNumber(goodsVo.strengthNum) * data.num <= checkNumber(currentCatData.hp)
--            CfUtils.SetUISwitchText(self.TextToyResumeStrength, isEnough and 1 or 2)
--            self.TextToyResumeStrength.text = checkNumber(goodsVo.strengthNum) * data.num
--        end
--    end
--end

function CatHouseInteractionDialog:FreshCatName()
    local currentCatData = self.catDataList[self.selectedCatIndex]
    self.TextCatName.text = currentCatData.name
end

--region Food&Toy
--function CatHouseInteractionDialog:FreshFoodUI()
--    self.selectedGoodIndex = -1
--    self.selectedGoodNum = 0
--    self.FontStyleButton:GetComponent("FontStyleButton"):ResetFontStyle("B3", localize("喂食"))
--    --self.AnimRoot:Play("ToysAndFeedEnter")
--    self.TextTitle.Status = 1
--    KTool.SetActive(self.RightListFeedPanel, true)
--    KTool.SetActive(self.RightListToysPanel, false)
--    KTool.SetActive(self.BottomBtnGroup, true)
--    KTool.SetActive(self.BtnArrowLeft, false)
--    KTool.SetActive(self.BtnArrowRight, false)
--    --print(table.toString(self.foodGoodsVo))
--    if not self.FeedList.IsListViewInit then
--        self.FeedList:InitGridView(#self.foodGoodsVo, Bind(self, self.OnGetItemByIndexFood))
--    else
--        GameUtils.ReloadData(self.FeedList, #self.foodGoodsVo)
--    end
--end
--
--function CatHouseInteractionDialog:FreshToyUI()
--    self.selectedGoodIndex = -1
--    self.selectedGoodNum = 0
--    self.FontStyleButton:GetComponent("FontStyleButton"):ResetFontStyle("B3", localize("玩玩具"))
--    --self.AnimRoot:Play("ToysAndFeedEnter")
--    self.TextTitle.Status = 2
--    KTool.SetActive(self.RightListToysPanel, true)
--    KTool.SetActive(self.RightListFeedPanel, false)
--    KTool.SetActive(self.BottomBtnGroup, true)
--    KTool.SetActive(self.BtnArrowLeft, false)
--    KTool.SetActive(self.BtnArrowRight, false)
--    ---库存排序
--    table.sort(self.toyGoodsVo, function(a, b)
--        local aStock = GoodsUtils.GetThingNo(a.id)
--        local bStock = GoodsUtils.GetThingNo(b.id)
--        if aStock ~= bStock then
--            return aStock > bStock
--        end
--        return false
--    end)
--    if not self.ToyList.IsListViewInit then
--        self.ToyList:InitGridView(#self.toyGoodsVo, Bind(self, self.OnGetItemByIndexToy))
--    else
--        GameUtils.ReloadData(self.ToyList, #self.toyGoodsVo)
--    end
--end
--
--function CatHouseInteractionDialog:HideFoodOrToyPanel()
--    self.AnimRoot:Play("ToysAndFeedEXit")
--    self.animState = ""
--    Events.Broadcast(Constants.EventNames.CatHouseCatAttrPreview, {
--        id = 0,
--        num = 0,
--    })
--    KTool.SetActive(self.RightListToysPanel, false)
--    KTool.SetActive(self.RightListFeedPanel, false)
--    KTool.SetActive(self.BottomBtnGroup, false)
--    KTool.SetActive(self.BtnArrowLeft, not (self.selectedCatIndex == 1))
--    KTool.SetActive(self.BtnArrowRight, not (self.selectedCatIndex == #self.catDataList))
--end
--
--function CatHouseInteractionDialog:OnGetItemByIndexToy(listView, index)
--    if index < 0 then
--        return nil
--    end
--    local cell = listView:NewListViewItem("Cell")
--    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.CatHouse.Interaction.CatHouseInteractionToyCell")
--    if nodeEnv then
--        local luaIndex = index + 1
--        local data = self.toyGoodsVo[luaIndex]
--        nodeEnv:FreshBaseUI(data, luaIndex)
--        local selectedGoodId = isNull(self.toyGoodsVo[self.selectedGoodIndex]) and -1 or self.toyGoodsVo[self.selectedGoodIndex].id
--        nodeEnv:FreshNumText(data.id == selectedGoodId and self.selectedGoodNum or 0)
--        nodeEnv:SetImgBgDownAction(Bind(self, self.OnImgBgDownAction))
--        nodeEnv:SetImgBgUpAction(Bind(self, self.OnImgBgUpAction))
--        nodeEnv:SetBtnReduceDownAction(Bind(self, self.OnBtnReduceDownAction))
--        nodeEnv:SetBtnReduceUpAction(Bind(self, self.OnBtnReduceUpAction))
--    end
--    return cell
--end
--
--function CatHouseInteractionDialog:OnGetItemByIndexFood(listView, index)
--    if index < 0 then
--        return nil
--    end
--    local cell = listView:NewListViewItem("Cell")
--    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.CatHouse.Interaction.CatHouseInteractionFoodCell")
--    if nodeEnv then
--        local luaIndex = index + 1
--        local data = self.foodGoodsVo[luaIndex]
--        nodeEnv:FreshBaseUI(data, luaIndex)
--        local selectedGoodId = isNull(self.foodGoodsVo[self.selectedGoodIndex]) and -1 or self.toyGoodsVo[self.selectedGoodIndex].id
--        nodeEnv:FreshNumText(data.id == selectedGoodId and self.selectedGoodNum or 0)
--        nodeEnv:SetImgBgDownAction(Bind(self, self.OnImgBgDownAction))
--        nodeEnv:SetImgBgUpAction(Bind(self, self.OnImgBgUpAction))
--        nodeEnv:SetBtnReduceDownAction(Bind(self, self.OnBtnReduceDownAction))
--        nodeEnv:SetBtnReduceUpAction(Bind(self, self.OnBtnReduceUpAction))
--    end
--    return cell
--end
--
--function CatHouseInteractionDialog:InitToyGoodsVo()
--    if #self.toyGoodsVo == 0 then
--        self.toyGoodsVo = CfUtils.GetWholeVo(AutoIds.IdSetting2031, "CatHouseToyGoodsVo")
--    end
--end
--
--function CatHouseInteractionDialog:InitFoodGoodsVo()
--    if #self.foodGoodsVo == 0 then
--        self.foodGoodsVo = CfUtils.GetWholeVo(AutoIds.IdSetting2030, "CatHouseFoodGoodsVo")
--    end
--end
--
--function CatHouseInteractionDialog:FreshPressChange()
--    if self.selectedGoodIndex <= 0 then
--        return
--    end
--    local value = self.isReduce and -1 or 1
--    local currentCatData = self.catDataList[self.selectedCatIndex]
--    if self.useGoodsType == UseGoodsType.Food then
--        local data = self.foodGoodsVo[self.selectedGoodIndex]
--        local stock = GoodsUtils.GetThingNo(data.id)
--        self.selectedGoodNum = Mathf.Clamp(self.selectedGoodNum + value, 0, stock)
--        --实时判断体力是否溢出
--        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(data.id)
--        local isFull = checkNumber(currentCatData.hp) + checkNumber(goodsVo.effectNum) * (self.selectedGoodNum - 1) >= checkNumber(currentCatData.hpLimit)
--        if isFull then
--            GameUtils.Toast(localize("当前猫咪体力值已满"))
--            self.isUpdateAttr = false
--            self.selectedGoodNum = Mathf.Clamp(self.selectedGoodNum - value, 0, stock)
--            if self.selectedGoodNum == 0 then
--                self.selectedGoodIndex = -1
--            end
--            return
--        end
--        local node = self.FeedList:GetShownItemByItemIndex(self.selectedGoodIndex - 1)
--        if node then
--            local env = CfUtils.GetLuaScr(node, "Game.CatHouse.Interaction.CatHouseInteractionFoodCell")
--            env:FreshNumText(self.selectedGoodNum)
--        end
--        Events.Broadcast(Constants.EventNames.CatHouseCatAttrPreview, {
--            id = data.id,
--            num = self.selectedGoodNum
--        })
--    elseif self.useGoodsType == UseGoodsType.Toy then
--        local data = self.toyGoodsVo[self.selectedGoodIndex]
--        local stock = GoodsUtils.GetThingNo(data.id)
--        self.selectedGoodNum = Mathf.Clamp(self.selectedGoodNum + value, 0, stock)
--        --实时判断成长值是否溢出
--        local subjoinAttrMap = CatHouseComponent:GetSubjoinAttr({
--            id = data.id,
--            num = self.selectedGoodNum - 1
--        })
--        local strengthAttrId = CatHouseComponent:GetStrengthAttrId()
--        local currentCatData = self.catDataList[self.selectedCatIndex]
--        local totalGrowthValue = 0
--        --print("subjoinAttrMap=====>>"..table.dump(subjoinAttrMap))
--        for k, v in pairs(subjoinAttrMap) do
--            if k ~= strengthAttrId then
--                --玩具
--                totalGrowthValue = totalGrowthValue + math.min(currentCatData.attr[k] + v, self.catAttrMap[k].upperLimit)
--            end
--        end
--        local isFull = totalGrowthValue >= self.growthValueBase
--        if isFull then
--            GameUtils.Toast(localize("当前猫咪成长值已满"))
--            self.isUpdateAttr = false
--            self.selectedGoodNum = Mathf.Clamp(self.selectedGoodNum - value, 0, stock)
--            if self.selectedGoodNum == 0 then
--                self.selectedGoodIndex = -1
--            end
--            return
--        end
--        local node = self.ToyList:GetShownItemByItemIndex(self.selectedGoodIndex - 1)
--        if node then
--            local env = CfUtils.GetLuaScr(node, "Game.CatHouse.Interaction.CatHouseInteractionToyCell")
--            env:FreshNumText(self.selectedGoodNum)
--        end
--        Events.Broadcast(Constants.EventNames.CatHouseCatAttrPreview, {
--            id = data.id,
--            num = self.selectedGoodNum
--        })
--    end
--    if self.selectedGoodNum == 0 then
--        self.selectedGoodIndex = -1
--    end
--end
--
--endregion
--region longPress
--function CatHouseInteractionDialog:CreatePressCo()
--    if self.co then
--        return
--    end
--    local yield_return = cs_coroutine.yield_return
--    self.co = cs_coroutine.start(function()
--        xTry(function()
--            while true do
--                if self.isClick then
--                    self:FreshPressChange()
--                    self.isClick = false
--                    yield_return(DelayTime)
--                end
--                if self.isUpdateAttr then
--                    self:FreshPressChange()
--                end
--                yield_return(DelayTime1)
--            end
--        end)
--    end)
--    table.insert(self.coList, self.co)
--end

--function CatHouseInteractionDialog:OnImgBgDownAction(index)
--    if self.useGoodsType == UseGoodsType.Food then
--        if self:IsHpValueFull() then
--            GameUtils.Toast(localize("当前猫咪体力值已满"))
--            return
--        end
--    else
--        if self:IsGrowthValueFull() then
--            GameUtils.Toast(localize("当前猫咪成长值已满"))
--            return
--        end
--    end
--    if self.selectedGoodIndex > 0 and self.selectedGoodNum > 0 and self.selectedGoodIndex ~= index then
--        GameUtils.Toast(localize("只能选择一种"))
--        return
--    end
--    self.selectedGoodIndex = index
--    self:CreatePressCo()
--    self.isReduce = false
--    self.isClick = true
--    self.isUpdateAttr = true
--end
--
--function CatHouseInteractionDialog:OnImgBgUpAction()
--    self.isClick = false
--    self.isUpdateAttr = false
--end
--
--function CatHouseInteractionDialog:OnBtnReduceDownAction()
--    self:CreatePressCo()
--    self.isClick = true
--    self.isUpdateAttr = true
--    self.isReduce = true
--end
--
--function CatHouseInteractionDialog:OnBtnReduceUpAction()
--    self.isClick = false
--    self.isUpdateAttr = false
--    self.isReduce = false
--end

--endregion

---成年猫吃胖状态改变
--function CatHouseInteractionDialog:CatFatStatusChange()
--    ---@type CatHouseComponent
--    local currentCatData = self.catDataList[self.selectedCatIndex]
--    local isAdult = currentCatData.age == ConstantsCatHouse.BornType.Adult
--    if isAdult then
--        local name = self:GetCatGameObjectName(currentCatData)
--        local isFat = CatHouseComponent:IsCatFatStatus(currentCatData.id)
--        self.catGoMap[name].gameObject:GetComponent(typeof(Animator)):SetBool("fat", checkBool(isFat))
--    end
--end

function CatHouseInteractionDialog:OnCatHouseTimeChange()
    local currentCatData = self.catDataList[self.selectedCatIndex]
    if not isNull(currentCatData) then
        local isAdult = currentCatData.age == ConstantsCatHouse.BornType.Adult
        if isAdult then--培育按钮状态修改
            local animName
            local catStatus = CatHouseComponent:GetCDDataById(currentCatData.id)
            --print("1111111111111-->>"..table.dump(catStatus))
            if catStatus == nil or catStatus[ConstantsCatHouse.CatStatus.Hatching] == nil then
                animName = "Free"
            else
                if catStatus[ConstantsCatHouse.CatStatus.Hatching] > 0 then
                    animName = "Cultivation"
                else
                    animName = "Hatch"
                end
            end
            self.RightOpitionBtnPanel:Play(animName)
        end
    end
end

function CatHouseInteractionDialog:SetBtnAction()
    --玩玩具和喂食按钮
    --SetButtonAction(self.FontStyleButton, function()
    --    self:OnClickUseItem()
    --end)

    SetButtonAction(self.BtnStrategyEntry, function()
        UIModule.OpenDialog({ id = Constants.UITypeIds.CatHouseTutorialDialog, parameters = { systemToggleId = Constants.SystemToggleIds.Id243}},
                {
                    --{ id = Constants.UITypeIds.UIHomeView }

                })
    end)

    SetButtonAction(self.BtnShare, function()
        CriWareUtils.PlaySe(UISheets.UI_Menu.path, UISheets.UI_Menu.ui_button_share)
        local currentCatData = self.catDataList[self.selectedCatIndex]
        GameUtils.ShareScreenShot({
            prefabPath = 'Prefabs/CatHouse/Interaction/CatHouseCatShareShow.prefab',
            prefabArgs = currentCatData,
            --isWaitCompleted = true,
            finishCB   = function(filePath)
                GachaponUtils.OpenDialogAction(Constants.UITypeIds.CommonSharePreviewDialog, {
                    filePath  = filePath,
                    shareType = Constants.ShareType.CAT_INFOMATION,
                })
            end
        })
    end)

    SetButtonAction(self.BtnCulitvation, function()
        self:OnClickCultivate()
    end)

    KTool.SetActive(self.BtnRename.gameObject, not Constants.MODULE_SWITCH.Is_Read_Only)
    SetButtonAction(self.BtnRename, function()
        self:OnClickRename()
    end)

    SetButtonAction(self.BtnCollect, function()
        local isPartnerCat = checkNumber(self.catDataList[self.selectedCatIndex].id) == checkNumber(self.catHouseHomeDojo.partyCatId)
        if not isPartnerCat then
            CatHouseMgr:GetInstance():SetPartyCat(self.catDataList[self.selectedCatIndex].id, function()
                CfUtils.PlayAnimator(self.BtnCollect.transform:Find("AnimRoot"), "Choose")
                self.ImgCollect.Status = SwitchImageStatusCollect.Light
                --GameUtils.Toast(localize("设置成功"))
            end)
        else
            GameUtils.Toast(localize("伙伴猫不能为空哦"))
        end
    end)

    SetButtonAction(self.BtnInitialization, function()
        self:OnClickInitialization()
    end)

    SetButtonAction(self.BtnEvolution, function()
        self:OnClickEvolution()
    end)

    --SetButtonAction(self.BtnNodeFeed, function()
    --    self.useGoodsType = UseGoodsType.Food
    --    self.AnimRoot:Play("ToysAndFeedEnter")
    --    self.animState = "ToysAndFeedEnter"
    --    self:FreshFoodUI()
    --end)
    --
    --SetButtonAction(self.BtnNodeToy, function()
    --    if self:IsGrowthValueFull() then
    --        GameUtils.Toast(localize("当前猫咪成长值已满"))
    --        return
    --    end
    --    self.useGoodsType = UseGoodsType.Toy
    --    self.AnimRoot:Play("ToysAndFeedEnter")
    --    self.animState = "ToysAndFeedEnter"
    --    self:FreshToyUI()
    --end)

    SetButtonAction(self.BtnNodeExplore, function()
        CatHouseExploreMgr:CatHouseExploreEntry()
    end)

    SetButtonAction(self.BtnCloseFoodToy, function()
        self:HideFoodOrToyPanel()
    end)

    --SetButtonAction(self.BtnClose, function()
    --    UIModule.BackDialog()
    --    --self.controller:Close()
    --end)

    --SetButtonAction(self.BtnBack, function()
    --    self.isInTheInteraction = false
    --    KTool.SetActive(self.Content, true)
    --    KTool.SetActive(self.StrengthGroupMain, true)
    --    KTool.SetActive(self.CancelInteraction, false)
    --end)

    SetButtonAction(self.BtnArrowLeft, function()
        if self.selectedCatIndex - 1 <= 0 then
            return
        else
            local name = self:GetCatGameObjectName(self.catDataList[self.selectedCatIndex])
            --KTool.SetActive(self.catGoMap[name], false)
            CS.UnityEngine.GameObject.Destroy(self.catGoMap[name])
            self.selectedCatIndex = self.selectedCatIndex - 1
            Events.Broadcast(Constants.EventNames.CatHouseCatTrainRolesSet, {})
            self:FreshEntranceUI()
        end
    end)

    SetButtonAction(self.BtnArrowRight, function()
        if self.selectedCatIndex >= #self.catDataList then
            return
        else
            local name = self:GetCatGameObjectName(self.catDataList[self.selectedCatIndex])
            --KTool.SetActive(self.catGoMap[name], false)
            CS.UnityEngine.GameObject.Destroy(self.catGoMap[name])
            self.selectedCatIndex = self.selectedCatIndex + 1
            Events.Broadcast(Constants.EventNames.CatHouseCatTrainRolesSet, {})
            self:FreshEntranceUI()
        end
    end)

    SetButtonAction(self.BtnTrain, function ()
        local navigatorScr = CfUtils.GetLuaScr(CS.UINavigationBarRoot.Instance.gameObject, "Game.Main.UINavigatorBar")
        if navigatorScr then
            navigatorScr:SetCustomBackHandlerAction(function()
                local currentCatData = self.catDataList[self.selectedCatIndex]
                local hasRemainTime = false
                if currentCatData then
                    hasRemainTime = (self.trainTimeLimit - checkNumber(currentCatData.trainingTimes)) > 0
                end
                self:SetTrainPanelShow(false, hasRemainTime)
                EasyTouch.instance.allowUIDetection = false
                self:ResetCurrentCatRotation()
                navigatorScr:SetCustomBackHandlerAction(nil)
            end)
        end
        EasyTouch.instance.allowUIDetection = true
        self:ResetCurrentCatRotation()
        self:SetTrainPanelShow(true)
    end)
end

function CatHouseInteractionDialog:TrainRolesSelectJump(isOpen)
    if isOpen then
        KTool.SetActive(self.controller, false)
        local navigatorScr = CfUtils.GetLuaScr(CS.UINavigationBarRoot.Instance.gameObject, "Game.Main.UINavigatorBar")
        if navigatorScr then
            navigatorScr:SetCustomBackHandlerAction(nil)
        end
    else--返回
        self.allowUIDetectionStatus = EasyTouch.instance.allowUIDetection
        KTool.SetActive(self.controller, true)
        local navigatorScr = CfUtils.GetLuaScr(CS.UINavigationBarRoot.Instance.gameObject, "Game.Main.UINavigatorBar")
        if navigatorScr then
            navigatorScr:SetCustomBackHandlerAction(function()
                self:SetTrainPanelShow(false)
                navigatorScr:SetCustomBackHandlerAction(nil)
            end)
        end
    end
end


function CatHouseInteractionDialog:SetTrainPanelShow(isShow, hasRemainTime)
    if isNull(hasRemainTime) then
        local currentCatData = self.catDataList[self.selectedCatIndex]
        hasRemainTime = false
        if currentCatData then
            hasRemainTime = (self.trainTimeLimit - checkNumber(currentCatData.trainingTimes)) > 0
        end
    end
    KTool.SetActive(self.BtnShare,(not isShow) and Constants.MODULE_SWITCH.SHARE)
    KTool.SetActive(self.BtnArrowLeft, (not isShow) and (not (self.selectedCatIndex == 1)))
    KTool.SetActive(self.BtnArrowRight, (not isShow) and (not (self.selectedCatIndex == #self.catDataList)))
    KTool.SetActive(self.BtnTrain, (not isShow) and hasRemainTime)
    KTool.SetActive(self.BtnInitialization, not isShow)
    KTool.SetActive(self.CatTrainGroup, isShow)
    KTool.SetActive(self.BtnStrategyEntry, not isShow)
    if isShow then
        local env = CfUtils.GetLuaScr(self.CatTrainGroup, "Game.CatHouse.Interaction.CatHouseInteractionTrain")
        env:SetConfirmTrainCB(Bind(self, self.OnClickConfirmTrain))
        env:SetQuickFormationCB(Bind(self, self.OnClickQuickFormation))
        local currentCatData = self.catDataList[self.selectedCatIndex]
        env:FreshBaseUI(currentCatData)
    else
        --Events.Broadcast(Constants.EventNames.CatHouseCatAttrPreview, nil)
    end
end

function CatHouseInteractionDialog:OnClickQuickFormation()
    self.isNotChangedCamera = true
    local currentCatData = self.catDataList[self.selectedCatIndex]
    UIModule.OpenDialog({id = Constants.UITypeIds.CatHouseChooseAttributePopup, parameters = { catData = currentCatData }})
end

function CatHouseInteractionDialog:OnClickConfirmTrain(rolesData)
    local isEmpty = true
    for i, v in pairs(rolesData) do
        if table.count(v) ~= 0 then
            isEmpty = false
            break
        end
    end
    if isEmpty then
        GameUtils.Toast(localize("请至少选择一个武装"))
        return
    end
    if GoodsUtils.GetThingNo(self.trainConsumeId) < self.trainConsumeNum then
        GameUtils.Toast(localize("道具不足"))
        return
    end
    local currentCatData = self.catDataList[self.selectedCatIndex]
    local firstCardData = rolesData[1]
    local playerCardIds = ""
    for i = 1, table.count(rolesData) do
        local cardDojo = cardComponent:GetCardById(cardComponent:GetIdByCardId(rolesData[i].refId))
        if cardDojo then
            playerCardIds = playerCardIds..string.format("%s,", cardDojo.id)
        end
    end
    GameUtils.Request(
            Interfaces.CatHouseTraining,
            {
                playerCatId = checkNumber(currentCatData.id),
                playerCardIds = playerCardIds
            },
            function(request, response)
                if checkInt(response.errCode) == 0 then
                    self.isUsedToy = true
                    GoodsUtils.ConsumeGoods({
                        {
                            goodsId = self.trainConsumeId,
                            num = self.trainConsumeNum
                        }
                    }, true)
                    --TODO 播放动画，刷新数据,次数为0的话返回
                    CriWareUtils.PlaySe(UISheets.UI_Menu.path, UISheets.UI_Menu.ui_xunlian)
                    local catData = CatHouseComponent:GetCatDataById(currentCatData.id)
                    catData.attr = response.data.attr
                    catData.trainingTimes = checkNumber(currentCatData.trainingTimes) + 1
                    local remainTimes = self.trainTimeLimit - checkNumber(catData.trainingTimes)
                    local hasRemainTime = remainTimes > 0
                    if hasRemainTime then
                        local env = CfUtils.GetLuaScr(self.CatTrainGroup, "Game.CatHouse.Interaction.CatHouseInteractionTrain")
                        env:FreshBaseUI(catData)
                    else
                        local env = CfUtils.GetLuaScr(self.CatTrainGroup, "Game.CatHouse.Interaction.CatHouseInteractionTrain")
                        env:SetTrainCell({})
                        local navigatorScr = CfUtils.GetLuaScr(CS.UINavigationBarRoot.Instance.gameObject, "Game.Main.UINavigatorBar")
                        if navigatorScr then
                            --self:SetTrainPanelShow(false)
                            navigatorScr:SetCustomBackHandlerAction(nil)
                        end
                    end
                    self:ShowTrainAnim(firstCardData, hasRemainTime)
                    CatHouseComponent:SetCatDataById(catData.id, catData)
                    self.catDataList[self.selectedCatIndex] = catData
                end
            end
    )

end

--function CatHouseInteractionDialog:OnClickUseItem()
--    if self.selectedGoodNum <= 0 then
--        GameUtils.Toast(localize("数量不能为空"))
--        return
--    end
--    --print("selectedGoodNum------->>"..self.selectedGoodNum)
--    if self.useGoodsType == UseGoodsType.Food then
--        self:UseFood()
--    elseif self.useGoodsType == UseGoodsType.Toy then
--        self:UseToy()
--    end
--end

--function CatHouseInteractionDialog:UseFood()
--    local currentCatData = self.catDataList[self.selectedCatIndex]
--    local goodsData = self.foodGoodsVo[self.selectedGoodIndex]
--    --喂食动作限制
--    local catStatus = CatHouseMgr:GetInstance():CheckCatActionLimit(ConstantsCatHouse.CatActionType.Meal, currentCatData.id)
--    if catStatus then
--        local text = CatHouseMgr:GetInstance():GetCatStateText(catStatus)
--        if text then
--            GameUtils.Toast(localize("该猫处于_name_,不可喂食", { _name_ = text }))
--        end
--        return
--    end
--    local confirmFunc = function()
--        GameUtils.Request(
--                Interfaces.CatHouseEat,
--                {
--                    playerCatId = currentCatData.id,
--                    foodId = self.foodGoodsVo[self.selectedGoodIndex].id,
--                    num = self.selectedGoodNum
--                },
--                function(request, response)
--                    if checkInt(response.errCode) == 0 then
--                        Events.Broadcast(Constants.EventNames.CatHouseCatAttrPreview, {
--                            id = 0,
--                            num = 0,
--                        })
--                        ---一口吃成胖喵
--                        local isAdult = checkNumber(currentCatData.age) == ConstantsCatHouse.BornType.Adult
--                        if isAdult then
--                            local eatUpStrengthLimit = checkNumber(CfUtils.GetCfVo(AutoIds.IdSetting1903, "BaseArgVo", ConstantsCatHouse.Params.EatUpStrengthLimit).num)
--                            if goodsData.effectNum * self.selectedGoodNum >= eatUpStrengthLimit then
--                                local eatUpRecoverTime = checkNumber(CfUtils.GetCfVo(AutoIds.IdSetting1903, "BaseArgVo", ConstantsCatHouse.Params.EatUpRecoverTime).num)
--                                CatHouseComponent:UpdateCDData(currentCatData.id, ConstantsCatHouse.CatStatus.EatUp, eatUpRecoverTime)
--                                Events.Broadcast(Constants.EventNames.CatHouseCatFatOrRecoverySwitchEventName)
--                                ---变胖要在喂食动画之后 TO ShowGoodsAnimation
--                            end
--                        end
--                        ---维护数据，刷新下层界面的信息
--                        local catData = CatHouseComponent:GetCatDataById(currentCatData.id)
--                        catData.hp = response.data.hp
--                        catData.nextHpSeconds = response.data.nextHpSeconds
--                        CatHouseComponent:SetCatDataById(catData.id, catData)
--                        self.catDataList[self.selectedCatIndex] = catData
--                        GoodsUtils.ConsumeGoods({
--                            {
--                                goodsId = self.foodGoodsVo[self.selectedGoodIndex].id,
--                                num = self.selectedGoodNum
--                            }
--                        })
--                        self:ShowGoodsAnim(goodsData)
--                        GameUtils.Toast(localize("体力+" .. goodsData.effectNum * self.selectedGoodNum))
--                        self:FreshStrength()
--                        self:FreshFoodUI()
--                    end
--                end
--        )
--    end
--    EasyTouch.instance.allowUIDetection = true
--    GameUtils.SecondConfirm(
--            localize("是否使用料理_m_增加体力_n_点？", { _m_ = goodsData.name, _n_ = goodsData.effectNum * self.selectedGoodNum }),
--            function()
--                confirmFunc()
--                EasyTouch.instance.allowUIDetection = false
--            end,
--            function()
--                EasyTouch.instance.allowUIDetection = false
--            end,
--            nil--localize("猫咪的属性加成不可逆，请谨慎培养"),
--    )
--end

--function CatHouseInteractionDialog:UseToy()
--    local currentCatData = self.catDataList[self.selectedCatIndex]
--    local goodsData = self.toyGoodsVo[self.selectedGoodIndex]
--    --体力限制
--    local isEnough = checkNumber(goodsData.strengthNum) * self.selectedGoodNum <= checkNumber(currentCatData.hp)
--    if not isEnough then
--        GameUtils.Toast(localize("猫咪体力不足"))
--        return
--    end
--    --玩具动作限制
--    local catStatus = CatHouseMgr:GetInstance():CheckCatActionLimit(ConstantsCatHouse.CatActionType.PlayToys, currentCatData.id)
--    if catStatus then
--        local text = CatHouseMgr:GetInstance():GetCatStateText(catStatus)
--        if text then
--            GameUtils.Toast(localize("该猫处于_name_,不可玩玩具", { _name_ = text }))
--        end
--        return
--    end
--    local confirmFunc = function()
--        GameUtils.Request(
--                Interfaces.CatHousePlay,
--                {
--                    playerCatId = checkNumber(currentCatData.id),
--                    toyId = self.toyGoodsVo[self.selectedGoodIndex].id,
--                    num = self.selectedGoodNum
--                },
--                function(request, response)
--                    if checkInt(response.errCode) == 0 then
--                        self.isUsedToy = true
--                        Events.Broadcast(Constants.EventNames.CatHouseCatAttrPreview, {
--                            id = 0,
--                            num = 0,
--                        })
--                        ---维护数据，刷新下层界面的信息
--                        local catData = CatHouseComponent:GetCatDataById(currentCatData.id)
--                        catData.attr = response.data.attr
--                        catData.hp = response.data.hp
--                        catData.nextHpSeconds = response.data.nextHpSeconds
--                        CatHouseComponent:SetCatDataById(catData.id, catData)
--                        self.catDataList[self.selectedCatIndex] = catData
--                        GoodsUtils.ConsumeGoods({
--                            {
--                                goodsId = self.toyGoodsVo[self.selectedGoodIndex].id,
--                                num = self.selectedGoodNum
--                            },
--                        })
--                        self:ShowGoodsAnim(goodsData)
--                        --self:FreshToyUI()
--                        --self:FreshEntranceUI()
--                    end
--                end
--        )
--    end
--    if self:IsShowToySecondConfirm() then
--        EasyTouch.instance.allowUIDetection = true
--        GameUtils.SecondConfirm(
--                localize("是否消耗体力_m_玩_n_？", { _m_ = goodsData.strengthNum * self.selectedGoodNum, _n_ = goodsData.name }),
--                function()
--                    confirmFunc()
--                    EasyTouch.instance.allowUIDetection = false
--                end,
--                function()
--                    EasyTouch.instance.allowUIDetection = false
--                end,
--                nil,
--                nil,
--                nil,
--                nil,
--                nil,
--                function(isConfirmTick)
--                    self:SetToySecondConfirmPlayerPrefs(isConfirmTick)
--                end
--        )
--    else
--        confirmFunc()
--    end
--end

function CatHouseInteractionDialog:OnClickCultivate()
    local currentCatData = self.catDataList[self.selectedCatIndex]
    local catStatus = CatHouseMgr:GetInstance():CheckCatActionLimit(ConstantsCatHouse.CatActionType.HatchingInvitation, currentCatData.id)
    if catStatus then
        local text = CatHouseMgr:GetInstance():GetCatStateText(catStatus)
        if text then
            GameUtils.Toast(localize("该猫处于_name_,不可培育", { _name_ = text }))
        end
        return
    end
    KCookie.Set(ConstantsCatHouse.CookieMyCatDataName, currentCatData)
    local co, isOpen = CatHouseMgr:GetInstance():BackToMatchPopup(true, false, true,
            {
                { id = Constants.UITypeIds.CatHouseInteractionDialog }
            }
    )
    KTool.SetActive(self.controller.gameObject, not isOpen)
end

function CatHouseInteractionDialog:OnClickEvolution()
    UIRaycastBlocker:AddCondition("CatHouseInteractionDialogCatEvolution")
    local currentCatData = clone(self.catDataList[self.selectedCatIndex])
    local isChild = currentCatData.age == ConstantsCatHouse.BornType.Baby
    --local isGrowthValueFull = self:IsGrowthValueFull()
    --local canEvolution = isChild and isGrowthValueFull
    local canEvolution = isChild and checkNumber(currentCatData.trainingTimes) >= self.trainTimeLimit
    if canEvolution then
        GameUtils.Request(
                Interfaces.CatHouseEvolution,
                { playerCatId = currentCatData.id },
                function(request, response)
                    if checkInt(response.errCode) == 0 then
                        local catData = CatHouseComponent:GetCatDataById(currentCatData.id)
                        catData.age = response.data.age
                        catData.attr = response.data.attr
                        catData.genes = response.data.genes
                        catData.hpLimit = response.data.hpLimit
                        CatHouseComponent:SetCatDataById(catData.id, catData)
                        self.catDataList[self.selectedCatIndex] = catData
                        local co = cs_coroutine.start(function()
                            local geneList = CatHouseMgr:GetInstance():GetAttributes(catData.genes)
                            local name = self:GetCatGameObjectName(catData)--新猫
                            local animatorAdult
                            local animatorChild = KTool.GetComponent(self.catGoMap[self:GetCatGameObjectName(currentCatData)], typeof(NamedAnimancerComponent))
                            animatorChild.enabled = false
                            cs_coroutine.yield_return(
                                    CatHouseMgr:GetInstance():LoadCatModelAsync(catData.age, catData.catId, false, geneList, nil, function(go)
                                        ---@type UnityEngine.Transform
                                        go.name = name
                                        self.catGoMap[name] = go
                                        KTool.SetActive(self.catGoMap[name], false)
                                        animatorAdult = KTool.GetComponent(self.catGoMap[name], typeof(NamedAnimancerComponent))
                                        animatorAdult.enabled = false
                                        local trans = go.transform
                                        trans.position = Vector3.New(0, shadowVerticalOffset, 0)
                                        trans.localRotation = CatModelLocalRotation.Adult
                                    end)
                            )
                            local loader = ResourceModule.LoadBundleSync("Prefabs/Runtime/cat_change_timeline.prefab", nil, true)
                            if loader.IsSuccess then
                                table.insert(self.loaderList, loader)
                                local go = GameObject.Instantiate(loader.ResultObject)
                                go.name = "catEvolutionTL"
                                table.insert(self.timeLineGoList, go)
                                self.catEvolutionDirector = go.gameObject:GetComponent(typeof(PlayableDirector))
                                local bindList = support.new_list(typeof(CS.UnityEngine.Playables.PlayableBinding))
                                bindList:AddRange(self.catEvolutionDirector.playableAsset.outputs)
                                for i = 0, bindList.Count - 1 do
                                    local bind = bindList[i]
                                    if bind.streamName == "cat_1" then
                                        self.catEvolutionDirector:SetGenericBinding(bind.sourceObject, self.catGoMap[self:GetCatGameObjectName(currentCatData)])
                                    elseif bind.streamName == "cat_2" then
                                        KTool.SetActive(self.catGoMap[name], true)
                                        self.catEvolutionDirector:SetGenericBinding(bind.sourceObject, self.catGoMap[self:GetCatGameObjectName(catData)])
                                    end
                                end
                                local catTLParent = go.gameObject.transform:Find("cat")
                                self.catGoMap[self:GetCatGameObjectName(currentCatData)].gameObject.transform:SetParent(catTLParent)
                                self.catGoMap[self:GetCatGameObjectName(catData)].gameObject.transform:SetParent(catTLParent)
                                local trackIndex
                                local variationGeneCount = 0
                                local partGeneCount = 0
                                for k, v in pairs(catData.genes) do
                                    local catGeneData = CfUtils.GetCfVo(AutoIds.IdSetting1902, "CatHouseCatDataVo", v.geneId)
                                    if catGeneData.kind == ConstantsCatHouse.ScreenCatDataType.Variation then
                                        --- 变异
                                        variationGeneCount = variationGeneCount + 1
                                    elseif catGeneData.kind == ConstantsCatHouse.ScreenCatDataType.Part then
                                        partGeneCount = partGeneCount + 1
                                    end
                                end
                                if variationGeneCount > 0 then
                                    trackIndex = CatEvolutionTrackIndex.Colorful
                                else
                                    if partGeneCount > 0 then
                                        trackIndex = CatEvolutionTrackIndex.Mix
                                    else
                                        trackIndex = CatEvolutionTrackIndex.Gold
                                    end
                                end
                                self.catEvolutionDirector.playableAsset:GetOutputTrack(trackIndex).muted = true
                                self.catEvolutionDirector.time = 0
                                self.catEvolutionDirector:Play()
                                CriWareUtils.PlaySe(UISheets.UI_Menu.path, UISheets.UI_Menu.ui_jinhua)
                                self:FreshEntranceUI()
                                self.isNotChangedCamera = true
                                UIModule.OpenDialog({ id = Constants.UITypeIds.CatHouseEvolutionSuccessDialog, parameters = { oldCatData = currentCatData, nowCatData = catData, nowCatModel = self.catGoMap[name].gameObject } },
                                        {
                                            --{id = Constants.UITypeIds.CatHouseInteractionDialog}
                                        })
                                cs_coroutine.yield_return(Yielders.GetWaitForSeconds(self.catEvolutionDirector.duration))
                                --播完后设回原有层级,清除TL
                                self.catGoMap[self:GetCatGameObjectName(currentCatData)].gameObject.transform:SetParent(go.transform.parent)
                                self.catGoMap[self:GetCatGameObjectName(catData)].gameObject.transform:SetParent(go.transform.parent)
                                CS.UnityEngine.GameObject.Destroy(self.catGoMap[self:GetCatGameObjectName(currentCatData)])
                                --KTool.SetActive(self.catGoMap[self:GetCatGameObjectName(currentCatData)], false)
                                KTool.SetActive(go, false)
                            else
                                loader:Release(true)
                            end
                            animatorAdult.enabled = true
                            animatorChild.enabled = true
                            UIRaycastBlocker:RemoveCondition("CatHouseInteractionDialogCatEvolution")
                        end)
                        table.insert(self.coList, co)
                    else
                        UIRaycastBlocker:RemoveCondition("CatHouseInteractionDialogCatEvolution")
                    end
                end
        )
    else
        UIRaycastBlocker:RemoveCondition("CatHouseInteractionDialogCatEvolution")
        GameUtils.Toast(localize("不满足进化条件"))
    end
end

function CatHouseInteractionDialog:OnClickInitialization()
    --初始化动作限制
    local catStatus = CatHouseMgr:GetInstance():CheckCatActionLimit(ConstantsCatHouse.CatActionType.Initialization, self.catDataList[self.selectedCatIndex].id)
    if catStatus then
        local text = CatHouseMgr:GetInstance():GetCatStateText(catStatus)
        if text then
            GameUtils.Toast(localize("该猫处于_name_,不可初始化", { _name_ = text }))
        end
        return
    end
    local canInit = CatHouseComponent:CanInitialCat(self.catDataList[self.selectedCatIndex].id)
    if canInit then
        EasyTouch.instance.allowUIDetection = true
        GameUtils.SecondConfirm(
                localize("是否初始化猫咪？"),
                function()
                    EasyTouch.instance.allowUIDetection = false
                    GameUtils.Request(
                            Interfaces.CatHouseInit,
                            { playerCatId = self.catDataList[self.selectedCatIndex].id },
                            function(request, response)
                                if checkInt(response.errCode) == 0 then
                                    ---维护数据，刷新下层界面的信息
                                    --local co = cs_coroutine.start(function()
                                        local currentCatData = clone(self.catDataList[self.selectedCatIndex])
                                        CatHouseComponent:SetCatDataById(self.catDataList[self.selectedCatIndex].id, nil)
                                        --print("----->>"..table.dump(response.data))
                                        if table.count(response.data.rewards) > 0 then
                                            GoodsUtils.DrawRewards(response.data.rewards)
                                            UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = {
                                                rewards = response.data.rewards,
                                                cb = function()
                                                    UIModule.BackDialog()
                                                end
                                            } })
                                        else
                                            GameUtils.Toast(localize("_name_已删除", { _name_ = currentCatData.name }))
                                            UIModule.BackDialog()
                                        end
                                    --end)
                                    --table.insert(self.coList, co)

                                    --self.controller:Close()
                                end
                            end
                    )
                end,
                function()
                    EasyTouch.instance.allowUIDetection = false
                end,
                self:GetInitializationPriceText()
        )
    else
        GameUtils.Toast(localize("伙伴猫不能进行初始化"))
    end
end

function CatHouseInteractionDialog:GetInitializationPriceText()
    local currentCatData = self.catDataList[self.selectedCatIndex]
    local isChild = currentCatData.age == ConstantsCatHouse.BornType.Baby
    if isChild then
        return localize("幼年猫被初始化后不获得任何奖励")
    end
    local priceData = CatHouseMgr:GetInstance():CalcCatPrice(self.catDataList[self.selectedCatIndex])
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(priceData[1].id)
    local priceText = string.format(localize("预计可获得奖励：%d%s"), priceData[1].num, goodsVo.name)
    local priceLength = table.count(priceData)
    if priceLength > 1 then
        for i = 2, priceLength do
            local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(priceData[i].id)
            priceText = priceText .. string.format("、%d%s", priceData[i].num, goodsVo.name)
        end
    end
    return priceText
end

function CatHouseInteractionDialog:OnClickRename()
    EasyTouch.instance.allowUIDetection = true
    CfUtils.SetTopActive(false)
    local currentCatData = self.catDataList[self.selectedCatIndex]
    GameUtils.FourConfirm(localize("变更称呼"), currentCatData.name, currentCatData.name, nil, function(value)
        local length = utf8.len(value)
        local confirmSucceed = length <= MAX_NAME_LENGTH
        if confirmSucceed then
            GameUtils.Request(
                    Interfaces.CatHouseRename,
                    {
                        playerCatId = currentCatData.id,
                        name = value
                    },
                    function(request, response)
                        if checkInt(response.errCode) == 0 then
                            ---维护数据，刷新下层界面的信息
                            local catData = CatHouseComponent:GetCatDataById(currentCatData.id)
                            catData.name = value
                            CatHouseComponent:SetCatDataById(currentCatData.id, catData)
                            self.catDataList[self.selectedCatIndex] = catData
                            self:FreshCatName()
                            GameUtils.Toast(localize("设置成功"))
                        end
                    end
            )
        else
            GameUtils.Toast(localize("昵称最长7个字"))
        end
        EasyTouch.instance.allowUIDetection = false
        CfUtils.SetTopActive(true)
    end, function()
        EasyTouch.instance.allowUIDetection = false
        CfUtils.SetTopActive(true)
    end)
end

--function CatHouseInteractionDialog:IsGrowthValueFull()
--    local currentCatData = self.catDataList[self.selectedCatIndex]
--    local totalGrowthValueNow = 0
--    for i, v in pairs(self.catAttrVo) do
--        --当前基础属性刷新
--        if currentCatData.attr[checkString(v.id)] then
--            totalGrowthValueNow = totalGrowthValueNow + currentCatData.attr[checkString(v.id)]
--        end
--    end
--    return totalGrowthValueNow >= self.growthValueBase
--end

--function CatHouseInteractionDialog:IsHpValueFull()
--    local currentCatData = self.catDataList[self.selectedCatIndex]
--    local isFull = checkNumber(currentCatData.hp) >= checkNumber(currentCatData.hpLimit)
--    return isFull
--end

function CatHouseInteractionDialog:ResetCurrentCatRotation()
    local currentCatData = self.catDataList[self.selectedCatIndex]
    local name = self:GetCatGameObjectName(currentCatData)
    local isAdult = currentCatData.age == ConstantsCatHouse.BornType.Adult
    self.catGoMap[name].transform.localRotation = isAdult and CatModelLocalRotation.Adult or CatModelLocalRotation.Child
end

---播放猫训练对应的动画表现
function CatHouseInteractionDialog:ShowTrainAnim(cardData, hasRemainTime)
    local cardVo = CfUtils.GetCfVo(AutoIds.IdSetting28, "CardVo", cardData.refId)
    local roleId = cardVo.characterId
    local ids =  string.split(CfUtils.GetIdGroupData(AutoIds.IdSetting1916, checkString(roleId), "ids")[1], ";")
    local length = table.count(ids)
    local randNum = math.random(1,length)
    local animId = ids[randNum]
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting1916, "CatTrainAnimVo", animId)
    local currentCatData = self.catDataList[self.selectedCatIndex]
    local name = self:GetCatGameObjectName(currentCatData)
    local co = cs_coroutine.start(function()
            self.AnimRoot:Play("Exit")
        Events.Broadcast(Constants.EventNames.CatHouseCatConfirmTrain, { isShowEffect = false })
        CfUtils.SetTopActive(false)
        --if self.useGoodsType == UseGoodsType.Toy then
        --    self.AnimRoot:Play("ToysEnter")
        --else
        --    self.AnimRoot:Play("FeedEnter")
        --end
        --print("goodsVo----->>"..table.dump(goodsVo, nil, 3))
        --if not string.isEmpty(goodsVo.action) then
        --    --动画状态机
        --    CfUtils.PlayAnimator(self.catGoMap[name], goodsVo.action)
            --            print("time------>>"..CfUtils.GetAnimatorTime(self.catGoMap[name], goodsVo.action))
            --cs_coroutine.yield_return(Yielders.GetWaitForSeconds(CfUtils.GetAnimatorTime(self.catGoMap[name], goodsVo.action)))
        --else
            --TL
            local loader = ResourceModule.LoadBundleSync(vo.timeLine, nil, true)
            if loader.IsSuccess then
                table.insert(self.loaderList, loader)
                local go = GameObject.Instantiate(loader.ResultObject)
                --go.name = "catEvolutionTL"
                table.insert(self.timeLineGoList, go)
                local director = go.gameObject:GetComponent(typeof(PlayableDirector))
                local bindList = support.new_list(typeof(CS.UnityEngine.Playables.PlayableBinding))
                bindList:AddRange(director.playableAsset.outputs)
                for i = 0, bindList.Count - 1 do
                    local bind = bindList[i]
                    --只设置人的节点
                    if bind.streamName == "Cat" then
                        director:SetGenericBinding(bind.sourceObject, self.catGoMap[name])
                    end
                end
                self.catGoMap[name].gameObject.transform:SetParent(go.transform)
                director.time = 0
                director:Play()
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds(director.duration))
                --播完后设回原有层级,隐藏TL，后面统一回收
                self.catGoMap[name].gameObject.transform:SetParent(go.transform.parent)
                KTool.SetActive(go, false)
            else
                loader:Release(true)
            end
        --end

        --if self.useGoodsType == UseGoodsType.Toy then
        --    self.AnimRoot:Play("ToysEXit")
        --    self:FreshToyUI()
            self:FreshEntranceUI()
            self:SetTrainPanelShow(hasRemainTime or false, hasRemainTime)
        --else
        --    self.AnimRoot:Play("FeedEXit")
        --end
        self.AnimRoot:Play("Go")
        CfUtils.SetTopActive(true)
        Events.Broadcast(Constants.EventNames.CatHouseCatConfirmTrain, { isShowEffect = true })

    end)
    table.insert(self.coList, co)
end

---播放道具对应的动画表现
--function CatHouseInteractionDialog:ShowGoodsAnim(goodsVo)
--    local currentCatData = self.catDataList[self.selectedCatIndex]
--    local name = self:GetCatGameObjectName(currentCatData)
--    local co = cs_coroutine.start(function()
--        if self.useGoodsType == UseGoodsType.Toy then
--            self.AnimRoot:Play("ToysEnter")
--        else
--            self.AnimRoot:Play("FeedEnter")
--        end
--        --print("goodsVo----->>"..table.dump(goodsVo, nil, 3))
--        if not string.isEmpty(goodsVo.action) then
--            --动画状态机
--            CfUtils.PlayAnimator(self.catGoMap[name], goodsVo.action)
--            --            print("time------>>"..CfUtils.GetAnimatorTime(self.catGoMap[name], goodsVo.action))
--            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(CfUtils.GetAnimatorTime(self.catGoMap[name], goodsVo.action)))
--        else
--            --TL
--            local loader = ResourceModule.LoadBundleSync(goodsVo.timeLine, nil, true)
--            if loader.IsSuccess then
--                table.insert(self.loaderList, loader)
--                local go = GameObject.Instantiate(loader.ResultObject)
--                --go.name = "catEvolutionTL"
--                table.insert(self.timeLineGoList, go)
--                local director = go.gameObject:GetComponent(typeof(PlayableDirector))
--                local bindList = support.new_list(typeof(CS.UnityEngine.Playables.PlayableBinding))
--                bindList:AddRange(director.playableAsset.outputs)
--                for i = 0, bindList.Count - 1 do
--                    local bind = bindList[i]
--                    --只设置人的节点
--                    if bind.streamName == "Cat" then
--                        director:SetGenericBinding(bind.sourceObject, self.catGoMap[name])
--                    end
--                end
--                self.catGoMap[name].gameObject.transform:SetParent(go.transform)
--                director.time = 0
--                director:Play()
--                cs_coroutine.yield_return(Yielders.GetWaitForSeconds(director.duration))
--                --播完后设回原有层级,隐藏TL，后面统一回收
--                self.catGoMap[name].gameObject.transform:SetParent(go.transform.parent)
--                KTool.SetActive(go, false)
--            else
--                loader:Release(true)
--            end
--        end
--        ---如果是变胖的状态下变胖
--        local isAdult = checkNumber(currentCatData.age) == ConstantsCatHouse.BornType.Adult
--        if isAdult then
--            local isFat = CatHouseComponent:IsCatFatStatus(currentCatData.id)
--            self.catGoMap[name].gameObject:GetComponent(typeof(Animator)):SetBool("fat", checkBool(isFat))
--        end
--        if self.useGoodsType == UseGoodsType.Toy then
--            self.AnimRoot:Play("ToysEXit")
--            self:FreshToyUI()
--            self:FreshEntranceUI()
--        else
--            self.AnimRoot:Play("FeedEXit")
--        end
--    end)
--    table.insert(self.coList, co)
--end
--
--function CatHouseInteractionDialog:SetToySecondConfirmPlayerPrefs(isConfirmTick)
--    --local date = require("Frame.date")
--    local PlayerPrefsUtility = CS.Engine.Tools.PlayerPrefsUtility
--    local TimeZoneUtils = CS.Engine.Http.TimeZoneUtils
--    local playerId = GameUtils.GetPlayerId()
--    local key = "CatHousePlayToySecondConfirm" .. playerId--存放的是时间戳 TimeZoneUtils.UtcSeconds
--    local value-- = isConfirmTick and checkString(TimeZoneUtils.UtcSeconds) or ""
--    if isConfirmTick then
--        value = checkNumber(TimeZoneUtils.UtcSeconds)
--    else
--        value = 0
--    end
--    PlayerPrefsUtility.SetEncryptedInt(key, value)  --使用string存放会有问题，所以改成int
--end
--
--function CatHouseInteractionDialog:IsShowToySecondConfirm()
--    local date = require("Frame.date")
--    local PlayerPrefsUtility = CS.Engine.Tools.PlayerPrefsUtility
--    local TimeZoneUtils = CS.Engine.Http.TimeZoneUtils
--    local playerId = GameUtils.GetPlayerId()
--    local key = "CatHousePlayToySecondConfirm" .. playerId--存放的是时间戳 TimeZoneUtils.UtcSeconds
--    local isShow
--    local lastTimeStamp = PlayerPrefsUtility.GetEncryptedInt(key, 0)
--    if lastTimeStamp ~= 0 then
--        local preDate = date(lastTimeStamp)
--        local preYMD = preDate:fmt("%Y%m%d")
--        local nowDate = date(TimeZoneUtils.UtcSeconds)
--        local nowYMD = nowDate:fmt("%Y%m%d")
--        isShow = checkNumber(preYMD) ~= checkNumber(nowYMD)
--    else
--        isShow = true
--    end
--    return isShow
--end

--- IsChild
--- 判断当前猫是否是幼年猫 warn:引导会使用
function CatHouseInteractionDialog:IsChild()
    local currentCatData = self.catDataList[self.selectedCatIndex]
    return currentCatData.age == ConstantsCatHouse.BornType.Baby
end

---@param currentCatId number 猫唯一id
function CatHouseInteractionDialog:GetCurrentCatIndex(currentCatId)
    currentCatId = checkString(currentCatId)
    local curCatIndex
    for k, v in pairs(self.catDataList) do
        if checkString(v.id) == currentCatId then
            curCatIndex = k
        end
    end
    return curCatIndex
end

function CatHouseInteractionDialog:DisposeLoadRes()
    for k, v in pairs(self.catGoMap) do
        CS.UnityEngine.GameObject.Destroy(v)
    end
    for k, v in pairs(self.loaderList) do
        if not isNull(v) then
            v:Release(true)
        end
    end
    for k, v in pairs(self.coList) do
        if not isNull(v) then
            cs_coroutine.stop(v)
        end
    end
    for k, v in pairs(self.timeLineGoList) do
        CS.UnityEngine.GameObject.Destroy(v)
    end
end

function CatHouseInteractionDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        EasyTouch.instance.allowUIDetection = true
        Events.Broadcast(DESTROY_EVENT_NAME)
        Events.RemoveListener(Constants.EventNames.CatHouseCatTrainRolesSelectJump, self.EventTrainRolesSelectJump)
        --Events.RemoveListener(Constants.EventNames.CatHouseCatRename, self.EventRename)
        --Events.RemoveListener(Constants.EventNames.CatHouseCatAttrPreview, self.EventAttrPreview)
        --Events.RemoveListener(Constants.EventNames.CatHouseCatFatOrRecoverySwitchEventName, self.EventCatFatStatusChange)
        --Events.RemoveListener(Constants.EventNames.CatHouseTimeChange, self.EventTimeChange)
        CatHouseComponent = nil
        self:DisposeLoadRes()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return CatHouseInteractionDialog