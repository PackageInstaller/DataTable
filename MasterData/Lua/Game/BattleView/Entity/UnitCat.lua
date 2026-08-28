--[[
    author:luqucheng
    time:2021-12-15 15:21:54
]]
local cs_coroutine = import('XLua.cs_coroutine')
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
local KTool = CS.Engine.Lib.KTool
local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils
local Animator = CS.UnityEngine.Animator
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance

local RoleView = import("Game.BattleView.Entity.RoleView")

local UnitCat = {}
UnitCat = Class("UnitCat", RoleView)
UnitCat.gameObject = nil
UnitCat.transform = nil
UnitCat.animator = nil
UnitCat.camp = nil
UnitCat.unitSkillId = 0

UnitCat.unitCount = 0
UnitCat.animationTimes = {}
UnitCat.co = nil
UnitCat.syncUnitCount = 0

function UnitCat:__init(catInfo, camp, gameObject)
    --@RefType [Game.Setting.Vo.BattleCatVo#BattleCatVo]
    self.data = self:GetBattleCatData(catInfo)
    self.id = catInfo.id
    self.gameObject = gameObject
    self.transform = gameObject.transform
    self.animator = gameObject:GetComponentInChildren(typeof(Animator))
    self.camp = camp
    self.unitCount = 0
    self.skinId = self.data.catSkin
    self.defaultStand = BattleViewMgr.sceneVo.catStand
    Tools.syncStand(self.transform, BattleViewMgr.sceneVo.catStand)

    self.buffViewMgr = import('Game.BattleView.Core.BuffViewMgr').New(self)

    local setting = settingMgr:GetSetting(AutoIds.IdSetting274, "ModelVo")
    self.modelVo = setting:Get(self.data.modeString)

    --镜头绑定的点，单独分离出来为了可以做一些操作
    self.cameraAttach = CS.UnityEngine.GameObject('CameraAttach').transform
    self.cameraAttach:SetParent(self.transform)
    KTool.ResetTransform(self.cameraAttach)

    --循环buff特效的绑点
    self.loopFXNode = CS.UnityEngine.GameObject('loopFXNode').transform
    self.loopFXNode:SetParent(self.transform)
    KTool.ResetTransform(self.loopFXNode)
   

    --找到根骨骼，为了绑定镜头用
    local Bip001 = KTool.DFSFindObject(self.transform, "Bip001")
    if Bip001 then
        self.rootBone = Bip001.transform
    end
    self.fxNode = self.gameObject

    self:InitAnimationTimes()
    KTool.SetActive(self.gameObject, false)


    local event = BattleInfo:IsUserCamp(self.camp) and Constants.EventNames.BattleMyCard or Constants.EventNames.BattleEnemyCard
    -- print("CardRecordReader", table.toString(record, "record"))
    self.__OnReceiveCard = Bind(self, self.OnReceiveCard)
    self.__OnRoundChange = Bind(self, self.OnRoundChange)
    self.__OnInputFinished = Bind(self, self.OnInputFinished)
    self.__OnReceveResetInput = Bind(self, self.OnReceveResetInput)

    Events.AddListener(event, self.__OnReceiveCard)
    Events.AddListener(Constants.EventNames.BattleRoundChangeShow, self.__OnRoundChange)
    Events.AddListener(Constants.EventNames.BattleInputFinished, self.__OnInputFinished)
    Events.AddListener(Constants.EventNames.BattleInputReset, self.__OnReceveResetInput)
end

function UnitCat:__delete()
    self:StopCo()
    local event = BattleInfo:IsUserCamp(self.camp) and Constants.EventNames.BattleMyCard or Constants.EventNames.BattleEnemyCard
    Events.RemoveListener(event, self.__OnReceiveCard)
    Events.RemoveListener(Constants.EventNames.BattleRoundChangeShow, self.__OnRoundChange)
    Events.RemoveListener(Constants.EventNames.BattleInputFinished, self.__OnInputFinished)
    Events.RemoveListener(Constants.EventNames.BattleInputReset, self.__OnReceveResetInput)
    self.__OnReceiveCard = nil
    self.__OnRoundChange = nil
    self.__OnInputFinished = nil
    self.__OnReceveResetInput = nil
end

function UnitCat:GetBattleCatData(catInfo)
    local setting = settingMgr:GetSetting(AutoIds.IdSetting578, "BattleCatVo")
    for i,v in ipairs(catInfo.genes) do
        local data = setting:Get(v)
        if data then
            return data
        end
    end

    return setting:Get(catInfo.catId)
end

function UnitCat:InitAnimationTimes(  )
    if self.animator then
        self.animationTimes = {}
        local clips = self.animator.runtimeAnimatorController.animationClips;
        local len = clips.Length
        for i=0,len-1 do
            local clip = clips[i];
            self.animationTimes[clip.name] = clip.length
            -- print("~~~~~~~~~~~~~~~~Anim:", clip.name, clip.length);
        end
    end
end

function UnitCat:GetAnimationTime( animName )
    if self.animationTimes then
        local time = self.animationTimes[animName]
        if time then
            return time
        end
    end

    return 1
end

function UnitCat:GetAnimationFrame(animName)
    return self:GetAnimationTime(animName) / AnimFrameTime
end

function UnitCat:Enter()
    
end

function UnitCat:BeforeSkill()
    self.isSkillPerforming = true
end

function UnitCat:AfterSkill()
    self.isSkillPerforming = false
    KTool.SetActive(self.gameObject, false)
end

function UnitCat:IsEliteOrBoss( )
    return false
end

function UnitCat:GetLookAtState()
    return 0
    -- return checkNumber(self.modelVo.whetherLookAt)
end

function UnitCat:OnResetCard()

end

function UnitCat:HideLoopFXNode(  )
    self.loopFXNode.position = Vector3.New(999999, 0, 0)
end

function UnitCat:ShowLoopFXNode(  )
    KTool.ResetTransform(self.loopFXNode)
end

function UnitCat:UseThreeStarCamera()
    return false
end

function UnitCat:UseNormalSkillCamera()
    return false
end

function UnitCat:GetSkillShowId( skillIndex )
    return string.format( "4%d%d", skillIndex, self.modelVo.id )
end

function UnitCat:OnInputFinished()
    self:PlayIdleFXEnd()
    self:PlayAnimation("cat_Departure")
    BattleViewMgr.FXMgr:PlayFXOnRole(self.data.endFx, self)
    self:StopCo()
    self.co = cs_coroutine.start(function ()
        coroutine.yield(WaitForSeconds(self:GetAnimationTime("cat_Departure")))
        

        if self.unitCount > 1 and self:HasUnitSkill() then
            Tools.syncStand(self.transform, BattleViewMgr.sceneVo.catStand)
            local shadow = self.gameObject:GetComponent(typeof(CS.PlaneShadow))
            shadow.shadowOffset = 0
        else
            KTool.SetActive(self.gameObject, false)
        end
    end)

    -- if self.unitCount <= 1 or not self:HasUnitSkill() then
    --     self:PlayAnimation("skill3_end")
    --     BattleViewMgr.FXMgr:PlayFXOnRole(self.data.endFx, self)
    --     self:StopCo()
    --     self.co = cs_coroutine.start(function ()
    --         coroutine.yield(WaitForSeconds(self:GetAnimationTime("skill3_end")))
    --         KTool.SetActive(self.gameObject, false)
    --     end)
    -- end
end

function UnitCat:OnReceveResetInput()
    self.unitCount = self.syncUnitCount
    self:StopCo()
    self:SwitchIdle()
end

function UnitCat:HasUnitSkill()
    return not Tools.isNullKey(self.unitSkillId)
end

function UnitCat:SetUnitSkillId(unitSkillId)
    self.unitSkillId = unitSkillId
end

function UnitCat:SyncUIPosititon()
    --这里现在需要获取ui的位置
    local rectTransform = BattleViewMgr.battleUI:GetBattlingDialog().catFather
    local x = rectTransform.anchorMin.x;
    local y = rectTransform.anchorMax.y;

    local wPos = rectTransform.transform.position
    local uiCamera = CS.Engine.UI.UIModule.RootCanvas.defaultCamera;
    local corners = CS.System.Array.CreateInstance(typeof(CS.UnityEngine.Vector3),4)
    rectTransform:GetWorldCorners(corners)
    
    --左下左上右上右下的顺序
    -- for i=0,3 do
    --     local v = corners[i]
    --     print("corners ", v.x, v.y, v.z)
    -- end
    -- wPos.x = wPos.x + x
    -- wPos.y = wPos.y + y
    --local wPos = Vector3.New(corners[0].x - (corners[2].x - corners[0].x) * 0.4, corners[0].y + (corners[1].y - corners[0].y) * 0.8, corners[0].z)

    local V2fromInScreen = CS.UnityEngine.RectTransformUtility.WorldToScreenPoint (uiCamera, rectTransform.transform.position)

    local renderCamera = URPCameraController.mainCamera
    --CS.UnityEngine.Camera.main;
    local ray = CS.UnityEngine.RectTransformUtility.ScreenPointToRay(renderCamera, V2fromInScreen)
    local pos = ray:GetPoint(3)

    self.transform.position = pos
    self.transform:LookAt( renderCamera.transform )
end

function UnitCat:OnRoundChange()
    self.unitCount = 0
    self:StopCo()
    self.co = cs_coroutine.start(function ()
        cs_coroutine.yield_return(WaitForSeconds(1))
        local shadow = self.gameObject:GetComponent(typeof(CS.PlaneShadow))
        shadow.shadowOffset = 1
        BattleViewMgr.FXMgr:PlayFXOnRole(self.data.enterFx, self)
        self:SyncUIPosititon()
        KTool.SetActive(self.gameObject, true)
        self:PlayAnimation("cat_enter")
        coroutine.yield(WaitForSeconds(self:GetAnimationTime("cat_enter")))
        self:SwitchIdle()
    end)
end

function UnitCat:OnReceiveCard(record)
    local recordType = record.r
    local rt = Constants.RecordType

    if recordType == rt.SyncCard then
        self.syncUnitCount = self.unitCount
    elseif recordType == rt.UnitCard then
        self.unitCount = self.unitCount + 1
        if self.unitCount > 1 then
            self:StopCo()
        end
        self:SwitchIdle()
    end
    -- return recordType == rt.DeleteCard
    --     or recordType == rt.MoveCard
    --     or recordType == rt.PushCard
    --     or recordType == rt.UnitCard
    --     or recordType == rt.UseCard
    --     or recordType == rt.SyncCard
    --     or recordType == rt.ChangeCard
end

function UnitCat:PlayAnimation( name, isForce, fadeTime )
    if not isNull(self.animator) then
        -- if isForce then
        fadeTime = fadeTime or 0.15
        -- self.animator:Play(name, self.animatorLayIndex, 0)
        if fadeTime <= 0 then
            self.animator:Play(name, 0, 0)
        else
            self.animator:CrossFade(name, fadeTime, 0)
        end
        -- else
        --     self.animator:SetTrigger(name)
        -- end
    end
end

function UnitCat:SwitchIdle()
    local animIndex = math.range(self.unitCount, 1, 4)

    self:PlayAnimation("cat_idle"..animIndex, true, 0)
    self:PlayIdleFXEnd()
    self.idleFxId = BattleViewMgr.FXMgr:PlayFXOnRole(self.data.idleFx[animIndex], self, true)
end

function UnitCat:PlayIdleFXEnd()
    if not Tools.isNullKey(self.idleFxId) then
        local obj = BattleViewMgr.FXMgr:FindFX(self.idleFxId)
        if not isNull(obj)  then
            local animator = obj:GetComponent(typeof(Animator))
            if not isNull(animator) then
                animator:SetTrigger("end")
            end
            cs_coroutine.start(function ()
                coroutine.yield(WaitForSeconds(1))
                if not isNull(obj)  then
                    CS.UnityEngine.GameObject.Destroy(obj)
                end
            end)
        end
    end
end

function UnitCat:StopCo()
    if self.co then
        cs_coroutine.stop(self.co)
        self.co = nil
    end
end

function UnitCat:PlaySkill()
    
end

function UnitCat:Leave()
    
end

return UnitCat