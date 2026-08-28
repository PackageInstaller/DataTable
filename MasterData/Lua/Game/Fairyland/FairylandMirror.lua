---
--- 乱流幻境场景门
--- Author: dawanfan
--- Date: 2024-1-22 14:37:18
---

local support = require 'Frame.support'
local KTool = CS.Engine.Lib.KTool
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local UIModule = CS.Engine.UI.UIModule
local ResourceModule = CS.Engine.Modules.ResourceModule
local FairylandBall = import("Game.Fairyland.FairylandBall")
local cs_coroutine = require "XLua.cs_coroutine"

---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
local LuaParametersType = LuaParametersReader.Type
local LuaParameters = CS.Engine.Modules.LuaParameters

---@type FairylandComponent
local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
local FairylandUtils = import("Game.Fairyland.FairylandUtils")
local ConstantsFairyland = import("Game.Fairyland.ConstantsFairyland")

local Animator = CS.UnityEngine.Animator
local AnimatorOverrideController = CS.UnityEngine.AnimatorOverrideController

local Vector3 = CS.UnityEngine.Vector3


--- from:  > name: Mirror
---@class FairylandMirror: FairylandBall
---@field Env                           	FairylandMirror                         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field MirroModel                    	UnityEngine.Transform                   	@ 0    
---@field MirroAnimator                 	UnityEngine.Animator                    	@ 1    
---@field VirtualCam                    	Cinemachine.CinemachineVirtualCamera    	@ 2    
---@field AutoMoveTF                    	UnityEngine.Transform                   	@ 3    
---@field FX33                          	UnityEngine.Transform                   	@ 4    
---@field FX66                          	UnityEngine.Transform                   	@ 5    
---@field FX100                         	UnityEngine.Transform                   	@ 6    
---@field FXBlue                        	UnityEngine.Transform                   	@ 7    
---@field FXGreen                       	UnityEngine.Transform                   	@ 8    
---@field FXRed                         	UnityEngine.Transform                   	@ 9    
---@field playableDirector              	UnityEngine.Playables.PlayableDirector  	@ 10   
---@field MainCamera                    	UnityEngine.Camera                      	@ 11   
---@field Cats                          	UnityEngine.Transform                   	@ 12   
---@field TimelineCats                  	UnityEngine.Transform                   	@ 13   
local FairylandMirror = Class("FairylandMirror", FairylandBall)

function FairylandMirror:__init()
    self._isInit = false
    self.cats = {}
    self.overrideControllerLoaders = {}
end

function FairylandMirror:__delete()
   self.cats = nil 
end

---@param index number 序号
function FairylandBall:Init(index)
    self.index = index

    self:InternalInit()
    cs_coroutine.yield_return(self:DoInit(true))
    if FairylandComponent.dojo:IsQuestFinished(FairylandUtils.CurrentEnterQuestId) then
        CfUtils.SetActive(self.MirroModel, false)
    end
end

function FairylandMirror:DoInit(checkSettlement)
    local energy = FairylandComponent.dojo.secretInfo[FairylandUtils.CurrentEnterQuestId].energy

    if checkSettlement and FairylandUtils.PlayLevelSettlement then
        energy = FairylandUtils.LastEnergy
    end

    if energy >= ConstantsFairyland.MirrorEnergyStage.Percent33 then
        CfUtils.SetActive(self.FX33, true)
    end

    if energy >= ConstantsFairyland.MirrorEnergyStage.Percent66 then
        CfUtils.SetActive(self.FX66, true)
    end

    if energy >= ConstantsFairyland.MirrorEnergyStage.Max then
        CfUtils.SetActive(self.FX100, true)
        CfUtils.SetActive(self.Cats, true)
        cs_coroutine.yield_return(self:LoadCats())
    end
end

function FairylandMirror:OnDestroy()
    Events.RemoveListener(Constants.EventNames.FairylandSceneBattleClick, self.__OnBattleClick)
    self.controller = nil
    self:Delete()
    self = nil
end

function FairylandMirror:GetDetailsNodePosition()
    local nodeOffset = LuaParametersReader.Read(self.params, "DetailsOffset", LuaParametersType.Vector3)
    return self.controller.gameObject.transform.position + nodeOffset
end

function FairylandMirror:GetTitleScale()
    local nodeScale = LuaParametersReader.Read(self.params, "TitleScale", LuaParametersType.Float)
    return nodeScale
end

function FairylandMirror:PlayMirrorLevelSettlement()

    if FairylandUtils.PlayMirrorOpen then
        cs_coroutine.yield_return(self:DoInit())
        CfUtils.SetActive(self.playableDirector.gameObject, true)
        
        local timelineBinder = self.playableDirector:GetComponent(typeof(CS.Game.Native.Timeline.TimelineBinder))

        for index, catGo in pairs(self.cats) do
            local location = self.TimelineCats:Find("locator" .. tostring(index))
            if location ~= nil then
                catGo.transform:SetParent(location)
                catGo.transform.localPosition = Vector3.zero
                local trackName = "cat_ani_0" .. tostring(index)
                timelineBinder:SetTrackDynamic(trackName, catGo)
                local track = timelineBinder:FindTrack(trackName)
                local clipList = support.new_list(typeof(CS.UnityEngine.Timeline.TimelineClip))
                clipList:AddRange(track:GetClips())
                local animator = catGo.transform:GetComponent(typeof(Animator))
                local animationClipList = support.new_list(typeof(CS.UnityEngine.AnimationClip))
                if animator.runtimeAnimatorController ~= nil then
                    animationClipList:AddRange(animator.runtimeAnimatorController.animationClips)
                end
                for _, clip in pairs(clipList) do
                    for _, clipAsset in pairs(animationClipList) do
                        if clipAsset.name == "jump" or clipAsset.name == "Jump" then
                            local asset = clip.asset
                            asset.clip = clipAsset
                        end
                    end
                end
                animationClipList:Clear()
                clipList:Clear()
            end
        end
        
        cs_coroutine.yield_return()
        local finish = false

        self.playableDirector:Play()
        self.playableDirector:stopped('+', function (playableDirector)
            CfUtils.SetActive(self.playableDirector.gameObject, false)
            local urpCameraComp = KTool.GetComponent(self.MainCamera.gameObject, typeof(CS.Game.Native.URP.URPBaseCamera))
            urpCameraComp:CopyCamera()
            finish = true
        end)

        while not finish do
            cs_coroutine.yield_return()
        end

        for index, catGo in pairs(self.cats) do
            local location = self.Cats:Find("locator" .. tostring(index))
            if location ~= nil then
                catGo.transform:SetParent(location)
                catGo.transform.localPosition = Vector3.zero
            end
        end
    else
        cs_coroutine.yield_return(self:DoInit())
    end

    cs_coroutine.yield_return()
end

function FairylandMirror:LoadCats()
    local catIds = FairylandComponent.dojo:GetMirrorCatIds(FairylandUtils.CurrentEnterQuestId)
    local count = 0
    local loadedCount = 0
    local path = "Arts/Prefab_cat/%s.prefab"
    local animatorPath = "AnimationController/Animator_cat/%s_lobby_cat.overrideController"
    local loadFinish = {}
    for index = 1, 4 do
        local id = catIds[index]
        if id ~= nil and self.cats[index] == nil then
            local location = self.Cats:Find("locator" .. tostring(index))
            if location ~= nil then
                loadFinish[id] = false
                count = count + 1
                ResourceModule.LoadGameObjectAsync(string.format(path, id), function (go)
                    loadFinish[id] = true
                    go.transform.localPosition = Vector3.zero

                    -- local animator = go.transform:GetComponent(typeof(Animator))
                    -- if isNull(animator) then
                    --     return
                    -- end

                    -- local overrideController = AnimatorOverrideController(animator.runtimeAnimatorController)
                    -- animator.runtimeAnimatorController = overrideController

                    self.cats[index] = go
                    -- CfUtils.PlayAnimator(go, "sit01_01")
                end, false, location.transform, true)
            end
        end
    end

    local flag = true
    while flag do
        flag = false
        for _, value in pairs(loadFinish) do
            if not value then
                flag = true
            end
        end

        cs_coroutine.yield_return()
    end

    self.MirroAnimator.enabled = true
end

return FairylandMirror
