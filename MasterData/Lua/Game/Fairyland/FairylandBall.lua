---
--- 乱流幻境球
--- Author: dawanfan
--- Date: 2024-1-16 17:43:04
---

local KTool = CS.Engine.Lib.KTool
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local UIModule = CS.Engine.UI.UIModule
local ResourceModule = CS.Engine.Modules.ResourceModule

---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
local LuaParametersType = LuaParametersReader.Type
local LuaParameters = CS.Engine.Modules.LuaParameters

---@type FairylandComponent
local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
local FairylandUtils = import("Game.Fairyland.FairylandUtils")
local cs_coroutine = require "XLua.cs_coroutine"



--- from: Assets/BundleResources/Prefabs/Fairyland/QuestBall.prefab > name: QuestBall1
---@class FairylandBall
---@field Env                           	FairylandBall                           
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field VirtualCam                    	Cinemachine.CinemachineVirtualCamera    
---@field Head                          	UnityEngine.RectTransform               
---@field AutoMoveTF                    	UnityEngine.Transform                   
---@field BallLocation                  	UnityEngine.Transform                   
---@field Animator                      	UnityEngine.Animator                    
local FairylandBall = Class("FairylandBall")

function FairylandBall:__init()
    self._isInit = false
    self.ballGo = nil
end

function FairylandBall:__delete()
    self.ballGo = nil
end

---@param index number 序号
function FairylandBall:Init(index)
    self.index = index

    if FairylandComponent:CanChallenge(FairylandUtils.CurrentEnterQuestId, index) then
        self:InternalInit()

        self:DoInit(true)
    end
end

function FairylandBall:InternalInit()
    self._behaviourAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
    self._behaviourAction.OnTriggerEnterAction = function (behaviourAction, other_)
        self:OnTriggerEnter(other_)
    end

    self._behaviourAction.OnTriggerExitAction = function (behaviourAction, other_)
        self:OnTriggerExit(other_)
    end

    self.__OnBattleClick = Bind(self, self.OnBattleClick)
    Events.AddListener(Constants.EventNames.FairylandSceneBattleClick, self.__OnBattleClick)

    self.params = KTool.GetComponent(self.controller.gameObject, typeof(LuaParameters))
    self.nodeOffset = LuaParametersReader.Read(self.params, "TitileOffset", LuaParametersType.Vector3)
end

function FairylandBall:DoInit(checkSettlement)
    local leveId = FairylandComponent.dojo:GetLevelId(FairylandUtils.CurrentEnterQuestId, self.index)
    
    -- 先显示之前的
    if checkSettlement and FairylandUtils.PlayLevelSettlement and self.index == FairylandUtils.LastCombatIndex then
        leveId = FairylandUtils.LastLevelId
    end

    local ballPrefabPath = FairylandUtils.GetBallPrefabPath(leveId)
    if ballPrefabPath then
        self.ballGo = self:CreateResGameObject(ballPrefabPath, self.BallLocation.gameObject)
    end

    local levelInfo = FairylandUtils.GetLevelVo(leveId)
    CfUtils.FillImage(self.Head, string.format("Arts/Icons/CardHead/m_icon_%s_1.png", levelInfo.monsterShow))

    if levelInfo.difficulty == 1 then
        CfUtils.SetScale(self.Head, Vector3.New(0.1, 0.1, 0.1))
    end
end

function FairylandBall:OnDestroy()
    Events.RemoveListener(Constants.EventNames.FairylandSceneBattleClick, self.__OnBattleClick)
    self.controller = nil
    self:Delete()
    self = nil
end

function FairylandBall:OnTriggerEnter(other_)
    -- print("Trigger Enter")
    Events.Broadcast(Constants.EventNames.FairylandSceneNearBall, true, self.index)
end

function FairylandBall:OnTriggerExit(other_)
    -- print("Trigger Exit")
    Events.Broadcast(Constants.EventNames.FairylandSceneNearBall, false, self.index)
end

function FairylandBall:OnBattleClick(index)
    if index ~= self.index then
        return
    end

    self.VirtualCam.Priority = 105
end

function FairylandBall:Reset()
    self.VirtualCam.Priority = 0
    CfUtils.SetActive(self.Head, false)
end

function FairylandBall:GetSceneNodePosition()
    return self.controller.gameObject.transform.position + self.nodeOffset
end

function FairylandBall:CreateResGameObject(resPath, rootFather, prefabName)
    local go
    local loader = ResourceModule.LoadBundleSync(resPath, nil, true)
    if loader.IsSuccess then
        -- go = GameObject.Instantiate(loader.ResultObject, rootFather)
        go = loader:Instantiate(isNull(rootFather) and nil or rootFather.transform)
        if not IsNull(go) then
            if prefabName then
                go.name = prefabName
            end
            KTool.SetActive(go, true)
        end
    end
    loader:Release()
    return go
end

function FairylandBall:GetAutoMovePosition()
    return self.AutoMoveTF.position
end

function FairylandBall:ChangeToNewBall()
    CS.UnityEngine.GameObject.Destroy(self.ballGo)

    cs_coroutine.yield_return(CfUtils.WaitPlayAnimatorTo(self.BallLocation, "QuestBall_reset"))

    local color = FairylandUtils.GetBallColor(FairylandComponent.dojo:GetLevelId(FairylandUtils.CurrentEnterQuestId, self.index))
    if color then
        self.ballGo = self:CreateResGameObject(string.format("Effect/prefab/fx_QuestBall1_reset_%s.prefab", color), self.BallLocation.gameObject)
    end

    self:DoInit(false)
    cs_coroutine.yield_return()
end

function FairylandBall:GetTitleScale()
    return 0.03
end

return FairylandBall
