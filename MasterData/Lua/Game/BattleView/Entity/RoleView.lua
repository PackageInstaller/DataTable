--
-- Author:luqucheng
-- Date: 2019-12-06 14:46:53
--
local Animator = CS.UnityEngine.Animator
local cs_coroutine = import('XLua.cs_coroutine')
local WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame
local gameUtils = CS.GameUtils
local SignalReceiver = CS.UnityEngine.Timeline.SignalReceiver
local KTool = CS.Engine.Lib.KTool
local ResourceModule = CS.Engine.Modules.ResourceModule
local SkinnedMeshRenderer = CS.UnityEngine.SkinnedMeshRenderer
local Color = CS.UnityEngine.Color
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
local BoxCollider = CS.UnityEngine.BoxCollider
local AndThenType = CS.Markers.AndThenType
local AnimationCurve = CS.UnityEngine.AnimationCurve
local Keyframe = CS.UnityEngine.Keyframe
local WaitForSecondsRealtime = CS.UnityEngine.WaitForSecondsRealtime
---@class RoleView
local RoleView = {}
RoleView = Class("RoleView")

--@RefType [Game.BattleView.Data.Stand#Stand]
RoleView.defaultStand = nil
--@RefType [luaIde#CS.UnityEngine.Transform]
RoleView.transform = nil
RoleView.gameObject = nil
RoleView.animator = nil
RoleView.id = nil
RoleView.camp = nil
--@RefType [Game.Setting.Vo.ModelVo#ModelVo]
RoleView.modelVo = nil
--@RefType [Game.Battle.Core.Attribute#Attribute]
RoleView.attr = nil--保留一份数据
--@RefType [Game.BattleView.Core.BuffViewMgr#BuffViewMgr]
RoleView.buffViewMgr = nil

RoleView.animatorLayIndex = nil--动画基础层
RoleView.matcapLayIndex = nil

RoleView.standIndex = nil--站位
RoleView.monsterClass = nil--怪物类型
RoleView.roleType = nil
RoleView.ultraPoint = nil
RoleView.__ultraFXID = nil
RoleView.rootBone = nil
RoleView.defaultNode = nil
RoleView._skinnedMeshes = nil
RoleView.maxUltraPoint = nil
RoleView.showHurt = nil
RoleView.roleData = nil
RoleView.skinId = nil
RoleView.statusAbility = nil
RoleView.animationFrames = nil
RoleView.isSkillPerforming = nil
RoleView.colliderMaxEdge = nil
RoleView.isFusing = false
RoleView.performCoIds = nil -- 记录表演时候使用的协程id

RoleView.usedCard = false

RoleView.isUnhurt = false --不播受击
RoleView.isFreeze = false --动作冻结

function  RoleView:__init( id, roleData, roleType, gameObject, standIndex, camp, modelVo, nowHp, nowSp, maxSp)
    self.id = id
    self.roleType = roleType
    self.gameObject = gameObject
    self.standIndex = standIndex
    self.transform = gameObject.transform
    local animatorList = gameObject:GetComponentsInChildren(typeof(Animator))
    if animatorList.Length >= 1 then
        self.animator = animatorList[0]        
    end
    if animatorList.Length >= 2 then
        self.animatorGeometry = animatorList[1]
    end
    self.roleData = roleData
    self.isPlayer = roleData.cardId ~= nil
    self.camp = camp
    self.modelVo = modelVo
    self.typeId = roleData.cardId or roleData.enemyId
    self.monsterClass = roleData.type or 0
    self.ultraPoint = roleData.currentEnergy or 0
    self.ultraPoint = checkNumber(self.ultraPoint )
    self.__ultraFXID = -1
    self.isFloat = false
    self.maxUltraPoint = roleData.maxSP or 6
    self.maxUltraPoint = checkNumber(self.maxUltraPoint)
    self.ultraPointType = 1
    self.skinId = roleData.skinId
    self.playerId = roleData.playerId
    --镜头绑定的点，单独分离出来为了可以做一些操作
    self.cameraAttach = CS.UnityEngine.GameObject('CameraAttach').transform
    self.cameraAttach:SetParent(self.transform)

    --循环buff特效的绑点
    self.loopFXNode = CS.UnityEngine.GameObject('loopFXNode').transform
    self.loopFXNode:SetParent(self.transform)
    KTool.ResetTransform(self.loopFXNode)
    self.loopFXNode.localScale = Vector3.one * modelVo.effectScale

    self.showHurt = true
    self.animationFrames = {}
    self.isSkillPerforming = false
    self.isFusing = false
    self.isFreeze = false
    self.isUnhurt = false
    KTool.ResetTransform(self.cameraAttach)
    self.hasEnterShowed = false     -- 是否已经入场
    self.lowestHpPer = 1 -- 本次战斗最低血量百分比

    --找到根骨骼，为了绑定镜头用
    local Bip001 = KTool.DFSFindObject(self.transform, "Bip001")
    if Bip001 then
        self.rootBone = Bip001.transform
    end

    -- -- self.fxNode.transform.localRotation = Quaternion.Euler(0, 180, 0)
    -- self.fxNode.transform.localPosition = Vector3.New(0, 0, 0)
    -- self.fxNode = self.gameObject
    self.fxNode = CS.UnityEngine.GameObject('onceFXNode')
    self.fxNode.transform:SetParent(self.transform)
    KTool.ResetTransform(self.fxNode.transform)
    self.fxNode.transform.localScale = Vector3.one * modelVo.effectScale

    -----
    ---添加boxcollider的中心位置
    -----
    self.centerY = 0
    local collider = KTool.GetComponent(self.gameObject, typeof(BoxCollider))
    if not isNull(BoxCollider) then
        self.centerY = collider.center.y
        self.colliderMaxEdge = math.max(collider.size.x, collider.size.y, collider.size.z)
    end
    ---添加boxcollider的中心位置
    ------------------------------
    local Attribute = import('Game.Battle.Core.Attribute')
    self.attr = Attribute.New(roleData.attr)
    self.attr:RefreshNowValues()
    self:SetNowHp(nowHp)
    self:ChangeUltraPoint(nowSp)

    self.buffViewMgr = import('Game.BattleView.Core.BuffViewMgr').New(self)
    self.animatorLayIndex = self.animator:GetLayerIndex("BaseLayer")    -- 这里有可能因为gameObject是inactive的，导致返回的layer为-1
    self.matcapLayIndex = self.animator:GetLayerIndex("Matcap")

    self:AddAllSignals()

    self:InitAnimationFrames()
    -- self:ResetNormalColor()

    -- 专武特效
    local weaponUnlocked = checkNumber(roleData.weaponUnlocked)
    if weaponUnlocked > 0 then
        local maxLv = CardConfMgr:GetInstance():GetMaxCardExclusiveWeaponLv(self.typeId)
        self:SetUniqueWeaponEffectState(weaponUnlocked >= maxLv and maxLv > 0)
    end

    self.switchAnimatorControllerTags = {}

    self.__OnUseCard = Bind(self, self.OnUseCard)
    Events.AddListener(Constants.EventNames.BattleOnRoleUseCard, self.__OnUseCard)

    self.__OnResetCard = Bind(self, self.OnResetCard)
    Events.AddListener(Constants.EventNames.BattleInputReset, self.__OnResetCard)

    self.useSpecialHitAnim159008 = nil
    self.specialHitCount159008 = nil

    -- 特殊寄存器1
    self.register1 = 0
end

function RoleView:InitAnimationFrames(  )
    if self.animator then
        self.animationFrames = {}
        local clips = self.animator.runtimeAnimatorController.animationClips;
        local len = clips.Length
        for i=0,len-1 do
            local clip = clips[i]
            if not isNull(clip) then
                self.animationFrames[clip.name] = clip.length / AnimFrameTime
            end
            -- print("~~~~~~~~~~~~~~~~Anim:", clip.name, clip.length);
        end
    end
end

function RoleView:GetAnimationFrame( animName )
    if self.animationFrames then
        local frame = self.animationFrames[animName]
        if frame then
            return frame
        end
    end

    return 30
end

function RoleView:GetHitTime( hitType, isFloating )
    if hitType == Constants.HitType.Normal then
        return self:GetAnimationFrame("attack_hit")
    elseif hitType == Constants.HitType.Float then
        if not self:CanFloat() then
            return self:GetAnimationFrame("attack_hit")
        else
            if isFloating then
                return self:GetAnimationFrame("float_hit") + self:GetAnimationFrame("float_down") + self:GetAnimationFrame("float_getup")
            else
                return self:GetAnimationFrame("float_up") + self:GetAnimationFrame("float_down") + self:GetAnimationFrame("float_getup")
            end
        end
    elseif hitType == Constants.HitType.Left then
        return self:GetAnimationFrame("left_hit")
    elseif hitType == Constants.HitType.Right then
        return self:GetAnimationFrame("right_hit")
    elseif hitType == Constants.HitType.Tiny then
        return self:GetAnimationFrame("small_hit")
    elseif hitType == Constants.HitType.Heavy then
        return self:GetAnimationFrame("heavy_hit")
    elseif hitType == Constants.HitType.Down then
        return self:GetAnimationFrame("down_hit") + self:GetAnimationFrame("float_getup")
    end

    return 0
end

-- function RoleView:FindRoleClass(  )
--     if not self.isPlayer then
--         --获取怪物表
--         local row = tableFile:GetByPrimaryKey(self.typeId)
--         return tonumber(row:Get("class"))
--     end
-- end

function RoleView:IsEliteOrBoss( )
    return self.monsterClass >= Constants.RoleClass.Elite
end


function RoleView:GetSkillShowId( skillIndex )
    return string.format( "4%d%d", skillIndex, self.modelVo.id )
end

function RoleView:GetSkinnedMeshes(  )
    if self._skinnedMeshes == nil then
        local rendererList = self.gameObject:GetComponentsInChildren(typeof(SkinnedMeshRenderer))
        self._skinnedMeshes = rendererList
        rendererList = nil
    end

    return self._skinnedMeshes
end

function RoleView:SetModelRed(  )
    local rendererList = self:GetSkinnedMeshes()
    local render = nil
    for i = 1, rendererList.Length do
        render = rendererList[i - 1]
        render.material:SetInt("ColorToggle", 1);
        render.material:SetColor("ChangeColor", Color.red);
    end
    render = nil
    rendererList = nil

end

function RoleView:ResetNormalColor(  )
    local rendererList = self:GetSkinnedMeshes()
    local render = nil
    for i = 1, rendererList.Length do
        render = rendererList[i - 1]
        render.material:SetInt("ColorToggle", 0);
        render.material:SetColor("ChangeColor", Color.white);
    end
    render = nil
    rendererList = nil
end

function RoleView:SetStand( stand )
    if not IsNull(self.defaultNode) then
        CS.UnityEngine.GameObject.Destroy(self.defaultNode.gameObject)
    end
    self.defaultStand = stand
    self.defaultNode = CS.UnityEngine.GameObject(self.id..'_default').transform
    self.defaultNode:SetParent(BattleViewMgr.rootNode.transform)
    Tools.syncStand(self.defaultNode, self.defaultStand)
    self:SyncStand()
end

function RoleView:GetRotateNode(  )
    local node = nil
    if not Tools.isNullKey(self.modelVo.bonesLook) then
        node = self.gameObject:FindGameObjectByName(self.modelVo.bonesLook)
    end

    if not node then
        node = self.gameObject
    end

    return node
end

function RoleView:SetFreeze(isFreeze)
    self.isFreeze = isFreeze
    if isFreeze then
        self.animator.speed = 0
    else
        self.animator.speed = 1
    end
end

function RoleView:SetUnhurt(isUnhurt)
    self.isUnhurt = isUnhurt
end

function RoleView:SyncStand(  )
    Tools.syncStand(self.transform, self.defaultStand)
end

function RoleView:Hide(  )
    self.transform.position = Vector3.New(999999, 0, 0)
end

function RoleView:HideLoopFXNode(  )
    self.loopFXNode.position = Vector3.New(999999, 0, 0)
end

function RoleView:ShowLoopFXNode(  )
    -- KTool.ResetTransform(self.loopFXNode)
    self.loopFXNode.localPosition = Vector3.zero
end

function RoleView:HideOnceFXNode()
    self.fxNode.transform.position = Vector3.New(999999, 0, 0)
end

function RoleView:ShowOnceFXNode()
    -- KTool.ResetTransform(self.fxNode.transform)
    self.fxNode.transform.localPosition = Vector3.zero
end

function RoleView:PlayAnimation( name, isForce, fadeTIme )
    if not isNull(self.animator) then
        self:ResetAnimatorEvent()
        if self.animatorLayIndex == -1 then
            self.animatorLayIndex = self.animator:GetLayerIndex("BaseLayer")
            self.matcapLayIndex = self.animator:GetLayerIndex("Matcap")
        end
        if isForce then
            fadeTIme = fadeTIme or 0.15
            -- self.animator:Play(name, self.animatorLayIndex, 0)
            if fadeTIme <= 0 then
                self.animator:Play(name, self.animatorLayIndex, 0)
            else
                -- self.animator:CrossFade(name, fadeTIme, 0)
                self.animator:CrossFadeInFixedTime(name, fadeTIme /  1.5, 0) --只有CrossFadeInFixedTime能够相同动画切换做融合https://forum.unity.com/threads/crossfade-to-same-clip.520531/
            end
        else
            self.animator:SetTrigger(name)
        end
    end
end

function RoleView:SyncAnimation()
    self.animator:Update(0)
end

function RoleView:ResetAnimator(  )
    local ctrl = self.animator.runtimeAnimatorController
    self.animator.runtimeAnimatorController = nil;
    self.animator.runtimeAnimatorController = ctrl;
end

function RoleView:Enter(  )
    self.hasEnterShowed = true
    self:PlayAnimation("enter")
    if self.roleData.enterVoice then
        RoleVoiceMgr:GetInstance():PlayBattleStartVoiceByCardId(self.typeId, nil, self.skinId)
    end
    -- return cs_coroutine.start(function (  )
    --     while self.animator and not (self.animator:GetCurrentAnimatorStateInfo(0):IsName("enter") and self.animator:GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.98 )  do
    --         coroutine.yield( WaitForEndOfFrame() ) 
    --     end 
    -- end)
end


function RoleView:CanFloat( )
    return self.modelVo.canFloat
end

function RoleView:BeforeSkill()
    if self.isSkillPerforming then
        --标记为融合
        self.isFusing = true
    end
    self.isSkillPerforming = true
end

function RoleView:AfterSkill()
    if self.isFusing then
        self.isFusing = false
        return
    end
    self.isSkillPerforming = false
    -- self:OnResetCard()
end

function RoleView:PlayFloatUp(  )
    if not self:CanFloat() then
        self:PlayAnimation("attack_hit", true)
    else
        self:PlayAnimation("float_up")
        self.isFloat = true
    end
    
end

function RoleView:PlayFloatDown(  )
    if not self:CanFloat() then
        return
    end
    self:PlayAnimation("float_down")
    self.isFloat = false
end

function RoleView:PlayDeath(  )
    self:LockHurt() -- 防止已经播死亡了，又播放受击

    if self.isFreeze then
        self:SetFreeze(false)
    end
    
    self.isFloat = false
    self:PlayAnimation("death", true)
    --if self.isPlayer then
    --    RoleVoiceMgr:GetInstance():PlayBattleRoleDeathVoiceByCardId(self.typeId)
    --end
    --  --移除角色所有的Buff
    --  self.buffViewMgr:Clear()

    --怪物死亡之后会隐藏
    -- if not self.isPlayer then
        self.co = cs_coroutine.start(function (  )
            local sw = CS.System.Diagnostics.Stopwatch();
            sw:Start()
            -- local stateInfo = self.animator:GetCurrentAnimatorStateInfo(0)
            while self.animator and not ( (self.animator:GetCurrentAnimatorStateInfo(0):IsName("death") or self.animator:GetCurrentAnimatorStateInfo(0):IsName("float_death")) and self.animator:GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.98 )  do
                -- print("PlayDeath", stateInfo.length, stateInfo.normalizedTime)
                -- print(stateInfo:IsName("death"))
                -- print(stateInfo:IsName("death_loop"))
                coroutine.yield( WaitForEndOfFrame() ) 
                --超过2秒也自动消失
                if sw.ElapsedMilliseconds > 5000 then
                    sw:Stop()
                    sw = nil
                    break
                end
            end 
            
            if isNull(self.transform) then
                print("[roleview] null death", self)
                return
            end
            self:PlayDeadFX()
            -- 加载猫
            -- self:ShowCat()
            --隐藏角色
            self:Remove()
            self.co = nil
        end)
    -- end
end

function RoleView:PlayDeadFX()
    if self.isPlayer then
        BattleViewMgr.FXMgr:PlayFXOnScene(Constants.BattleCommonFX.RoleDead, false, self.transform.position)
    else
        local fxId = Constants.BattleCommonFX.MonsterDead
        -- if self.roleData.treasureType == 1 then
        --     fxId = Constants.BattleCommonFX.MonsterDeadWithCopperTreasure
        -- elseif self.roleData.treasureType == 2 then
        --     fxId = Constants.BattleCommonFX.MonsterDeadWithSilverTreasure
        -- elseif self.roleData.treasureType == 3 then
        --     fxId = Constants.BattleCommonFX.MonsterDeadWithGoldenTreasure
        -- end
        BattleViewMgr.FXMgr:PlayFXOnScene(fxId, false, self.transform.position)

        -- if self.roleData.treasureType and self.roleData.treasureType > 0 then
        --     Events.Broadcast(Constants.EventNames.BattleDropTreasureShow, {quality = self.roleData.treasureType})
        -- end
    end
end

--- 攻击表演的时候，把co记下来，万一攻击表演过程中触发结算自己死了，得把co停掉
function RoleView:AddPerformCo(coId)
    if self.performCoIds == nil then
        self.performCoIds = {}
    end
    table.insert(self.performCoIds, coId)
end

--- 攻击表演完了，把co移除
function RoleView:RemovePerformCo(coId)
    if self.performCoIds == nil then
        return
    end
    
    for i,v in fipairs(self.performCoIds) do
        if v == coId then
            table.remove(self.performCoIds, i)
            return
        end
    end
end

--- 把正在执行的表演协程停掉
function RoleView:StopPerformCo()
    if self.performCoIds == nil then
        return
    end

    for i,v in fipairs(self.performCoIds) do
        if v then
            CoManager:RemoveCoById(v)
        end
    end
    self.performCoIds = {}
end

--- 死亡之后，在原地显示一只猫
function RoleView:ShowCat()
    local skinVo = CfUtils.GetCfVo(AutoIds.IdSetting113 , "CardSkinVo" , self.skinId)
    if self.camp == BattleInfo.myCamp
    and skinVo.isMonster == 0
    and not string.isEmpty(skinVo.catPrefab) then
        local go = BattleViewMgr:GetCatGo(self.skinId)
        if isNotNull(go) then
            go.transform.position = self.transform.position
            go.transform.rotation = self.transform.rotation
            go.transform.localScale = Vector3.one * 2.25
            local animator = go:GetComponent(typeof(CS.UnityEngine.Animator))
            if isNotNull(animator) then
                animator:SetInteger("club", 3)
                animator:Play("idle_club", 0, 0)
            end
        end
    end
end

function RoleView:Remove(  )
    BattleViewMgr:MatrixEffectRemoveRole(self.id)
    self.gameObject:SetActive(false)
    self:Dispose()
    table.removebyvalue(BattleViewMgr.roleViews, self)
end

function RoleView:HeavyHit()
    self:PlayAnimation("heavy_hit")
end

function RoleView:LockHurt(  )
    self.showHurt = false
end

function RoleView:UnlockHurt(  )
    self.showHurt = true
end


function RoleView:PlayHurt(hitElementType, hitType, isForce)
    if not self.showHurt and not isForce then
        return
    end

    if self.isUnhurt then
        return
    end
    if self.isFreeze then
        return
    end
    
    
    -- self.animator:Play("attack_hit", self.animatorLayIndex, 0)
    -- self:ResetHurt()
    
    
    -- if self.isFloat then
    --     return
    -- end
    local blendTime = 0.05
    hitType = hitType or 1
    hitElementType = hitElementType or 1
    self:ForcePlayHitMatCap(hitElementType)
    -- if self:IsDead() then
    --     return
    -- end

    -- 159008特殊功能，转到idle2的时候，所有受击动作变成skill5和skill6轮流播放
    if checkBool(self.useSpecialHitAnim159008) then
        if self.specialHitCount159008 % 2 == 0 then
            self:PlayAnimation("skill5", true, blendTime)
        else
            self:PlayAnimation("skill6", true, blendTime)
        end
        self.specialHitCount159008 = self.specialHitCount159008 + 1
        return
    end
    

    local info = self.animator:GetCurrentAnimatorStateInfo(0)
    -- print("PlayHurt",  hitElementType, hitType, info:IsName("float_down"), info:IsName("float_up"), info:IsName("idle"), info:IsName("attack_hit"))

    if (info:IsName("float_down") or info:IsName("float_up") or info:IsName("float_hit")) and hitType == Constants.HitType.Normal then
        self:PlayAnimation("float_hit", true, blendTime)
    elseif hitType == Constants.HitType.Float then
        if not self:CanFloat() then
            self:PlayAnimation("attack_hit", true, blendTime)
        else
            self:PlayAnimation("float_up", true, blendTime)
        end
    elseif hitType == Constants.HitType.Normal then
        self:PlayAnimation("attack_hit", true, blendTime)
    elseif hitType == Constants.HitType.Left then
        self:PlayAnimation("left_hit", true, blendTime)
    elseif hitType == Constants.HitType.Right then
        self:PlayAnimation("right_hit", true, blendTime)
    elseif hitType == Constants.HitType.Tiny then
        self:PlayAnimation("small_hit", true, blendTime)
    elseif hitType == Constants.HitType.Heavy then
        self:PlayAnimation("heavy_hit", true, blendTime)
    elseif hitType == Constants.HitType.Down then
        self:PlayAnimation("down_hit", true, blendTime)
    end



    -- self.animator:SetInteger("hitType", hitElementType)
    -- if info:IsName("attack_hit") then
    --     -- self.animator:SetTrigger("interrupt")
    --     -- self.animator:SetTrigger("interrupt2")
    --     self.animator:Play("attack_hit", self.animatorLayIndex, 0)
    --     self:ForcePlayHitMatCap(hitElementType)
    -- elseif info:IsName("float_hit") then
    --     self.animator:Play("float_hit", self.animatorLayIndex, 0)
    --     self:ForcePlayHitMatCap(hitElementType)
    -- elseif info:IsName("float_up") then
    -- else
    --     self.animator:SetTrigger("attack_hit")
    -- end
    -- if self.animator:GetCurrentAnimatorStateInfo(0):IsName("float_hit") then
    --     -- self.animator:SetTrigger("interrupt")
    --     -- self.animator:SetTrigger("interrupt2")
    --     self.animator:Play("float_hit", self.animatorLayIndex, 0)
    -- else
    --     self.animator:SetTrigger("attack_hit")
    -- end

    --受击变红色
    -- self:SetModelRed()


    -- self.hurtCo = cs_coroutine.start(function (  )
    --     coroutine.yield( WaitForSeconds(0.1) ) 
    --     -- self:ResetNormalColor()
    --     self.hurtCo = nil
    -- end)
end

function RoleView:ForcePlayHitMatCap( hitType )
    if hitType > 1 then
        hitType  = hitType + 1
    end
    local n = "fx_matcap_0"..hitType
    self.animator:Play(n, self.matcapLayIndex, 0)
end

function RoleView:ForcePlayMatCap( n, isTrue)
    if Tools.isNullKey(n) then
        return
    end
    self.animator:SetBool(n, isTrue)
end

function RoleView:ResetHurt(  )
    self.animator:ResetTrigger("attack_hit")
    self.animator:Play("idle", self.animatorLayIndex, 0)

end

--获取根据角色前方某个偏移点的世界坐标
--@return [Frame.UnityEngine.Vector3#Vector3]
function RoleView:GetOffsetPosition( pos )
    local offset = Quaternion.MulVec3(self.transform.localRotation, pos)
    return offset:Add(self.transform.position)
end

--获取射击时候的骨骼点位置
function RoleView:GetShotPosition(  )
    local lHit = self.gameObject:FindGameObjectByName('L_hit')
    if lHit then
        return lHit.transform.position
    else
        return Vector3.New(self.transform.position.x, self.centerY, self.transform.position.z) 
    end
end


function RoleView:NormalSkillShow( target, skillId, skillStar )
end

function RoleView:ForceSetNowHp( nowHp )
    self.attr:SetValue(Constants.AttrTypeId.NowHp, nowHp)
    Events.Broadcast(Constants.EventNames.BattleHpChangeShow, 
        {roleId = self.id, per = nowHp / self.attr:GetValue(Constants.AttrTypeId.Hp)})
end

function RoleView:SetNowHp( nowHp )
    --如果死亡，就播放死亡动画
    -- if nowHp <= 0 and self.attr:GetValue(Constants.AttrTypeId.NowHp) > 0 then
    --     self:PlayDeath()
    -- end

    if not self.attr then
        return
    end
    self.attr:SetValue(Constants.AttrTypeId.NowHp, nowHp)
    self:CheckInjuredVoice(nowHp / self.attr:GetValue(Constants.AttrTypeId.Hp))
    --广播消息给ui做显示
    Events.Broadcast(Constants.EventNames.BattleHpChangeShow, 
        {roleId = self.id, per = nowHp / self.attr:GetValue(Constants.AttrTypeId.Hp)})
end

function RoleView:IsDead(  )
    return self.attr:GetValue(Constants.AttrTypeId.NowHp) <= 0
end

function RoleView:SwitchIdle( idleType )
    if idleType == Constants.IdleType.Normal and self.usedCard then
        idleType = Constants.IdleType.AttackIdle
    end
    if self.animator then
        self.animator:SetFloat("idleType", idleType)
    end

    -- 159008特殊功能，转到idle2的时候，所有受击动作变成skill5和skill6轮流播放
    if checkNumber(self.typeId) == 159008 then
        if idleType == Constants.IdleType.Normal then
            self:SetSpecialHitActive159008(false)
        elseif idleType == Constants.IdleType.SpecialIdle1 then
            self:SetSpecialHitActive159008(true)
        end
    end
end

function RoleView:UseThreeStarCamera()
    if self.roleType == Constants.RoleType.Hero and BattleViewMgr:EnableThreeStarCamera() then
        return true
    end
    if self:IsEliteOrBoss() then
        return true
    end
    return false
end

function RoleView:UseNormalSkillCamera()
    return (self.roleType == Constants.RoleType.Hero or self.roleType == Constants.RoleType.SpecialSummon ) and BattleInfo:IsUserCamp(self.camp)
end

--不会导致死亡的血量变化
function RoleView:PureChangeNowHp( damage, hitElementType, hitType )
    
    local nowHp = self.attr:GetValue(Constants.AttrTypeId.NowHp)
    nowHp = math.range(nowHp - damage, 1, self.attr:GetValue(Constants.AttrTypeId.Hp)) 
    self.attr:SetValue(Constants.AttrTypeId.NowHp, nowHp)
    self:CheckInjuredVoice(nowHp / self.attr:GetValue(Constants.AttrTypeId.Hp))
    --广播消息给ui做显示
    Events.Broadcast(Constants.EventNames.BattleHpChangeShow, 
        {roleId = self.id, per = nowHp / self.attr:GetValue(Constants.AttrTypeId.Hp)})

    if damage > 0 then
        self:PlayHurt(hitElementType, hitType)
    end
end

function RoleView:ChangeNowHp( damage, nowHp, hitElementType, hitType, isBounce )
    
    -- local nowHp = self.attr:GetValue(Constants.AttrTypeId.NowHp)
    -- nowHp = math.range(nowHp - damage, 0, self.attr:GetValue(Constants.AttrTypeId.Hp)) 
    self:SetNowHp(nowHp)

    if (damage > 0 and not isBounce) or nowHp <= 0 then
        self:PlayHurt(hitElementType, hitType)
    end
end

function RoleView:ChangeUltraPoint( point , type)
    if self.ultraPoint < self.maxUltraPoint and point >= self.maxUltraPoint then
        -- local FXID = Constants.BattleCommonFX.SPMax
        -- if self.roleData.advanceLevel and self.roleData.advanceLevel > 0 then
        --     local rare = CardConfMgr:GetInstance():GetCardRare(self.roleData.advanceLevel)
        --     if rare == Constants.RareType.UR then
        --         FXID = Constants.BattleCommonFX.SPMaxUR
        --     end
        -- end
        if not self.isPlayer and type ~= Constants.AddSPType.UnitCard then
            -- 合卡加点的时候不在这里播放特效，等UI表现合卡到SP满的时候再播放特效
            local FXID = Constants.BattleCommonFX.SPMaxUR
            self.__ultraFXID = BattleViewMgr.FXMgr:PlayFXOnRole(FXID, self, true)
        end
    elseif self.ultraPoint >= self.maxUltraPoint and point < self.maxUltraPoint then
        BattleViewMgr.FXMgr:RemoveFX(self.__ultraFXID)
        self.__ultraFXID = -1
    end
    self.ultraPoint = point
    Events.Broadcast(Constants.EventNames.BattleUltraPointChangeShow, {roleId = self.id, point = self.ultraPoint, type = type})
end

function RoleView:ChangeUltraPointMax(from, to)
    self.maxUltraPoint = to
    self.ultraPoint = math.min(self.ultraPoint, self.maxUltraPoint)
    Events.Broadcast(Constants.EventNames.BattleUltraPointMaxChangeShow, {roleId = self.id, from = from, to = to})
end

function RoleView:ChangeUltraPointType(from, to)
    self.ultraPointType = to
    Events.Broadcast(Constants.EventNames.BattleUltraPointTypeChangeShow, {roleId = self.id, from = from, to = to})
end

--- 播放SP特效
function RoleView:PlaySPFX()
    if self.__ultraFXID ~= -1 then
        return  -- 已经播出来特效了，不要重复播放，会导致id变更删不掉的旧的特效
    end
    local FXID = Constants.BattleCommonFX.SPMaxUR
    self.__ultraFXID = BattleViewMgr.FXMgr:PlayFXOnRole(FXID, self, true)
end

function RoleView:AddAllSignals(  )
    local signals = {
        {"attack_hit", "attack_hit"},
        {"float_death", "float_death"},
        {"float_down", "float_down"},
        {"float_getup", "float_getup"},
        {"float_hit", "float_hit"},
        {"float_up", "float_up"},
        {"heavy_hit", "heavy_hit"},
        {"prepare", "prepare"},
        {"skill2", "skill2"},
        {"death", "death"},
        {"down_hit", "down_hit"},
        {"left_hit", "left_hit"},
        {"right_hit", "right_hit"},
    }
    for i,v in ipairs(signals) do
        self:AddAnimSignal(v[1], v[2])
    end

    self:AddSignalHandler("disappear", function ()
        if not self.isSkillPerforming then
            self:Hide()
        end
    end)

    self:AddSignalHandler("appear", function ()
        if not self.isSkillPerforming then
            self:SyncStand()
        end
    end)

    -- 新的信号接收机制
    local receiver = KTool.GetOrAddComponent(self.gameObject, typeof(CS.NotificationReceiver))
    receiver:CustomOnNotify("+", function(origin, notification, context)
        local notificationType = notification:GetType()
        -- if notificationType == typeof(CS.UnityEngine.Timeline.SignalEmitter) then
        --     -- print("[信号] SignalEmitter ", notification.asset.name)
        --     local signalName = notification.asset.name
        --     local stateName = signal2AnimatorState[signalName]
        --     if isNotNull(stateName) then
        --         self.animator:Play(stateName, self.animatorLayIndex, 0)
        --     else
        --         if signalName == "disappear" then
        --             if not self.isSkillPerforming then
        --                 self:Hide()
        --             end
        --         elseif signalName == "appear" then
        --             if not self.isSkillPerforming then
        --                 self:SyncStand()
        --             end
        --         end
        --     end
        if notificationType == typeof(CS.Markers.AnimatorCrossMarker) then
            print("[信号] AnimatorCrossMarker ", notification.name, notification.fixedTransitionDuration, notification.layer, notification.fixedTimeOffset, notification.normalizedTransitionTime)
        elseif notificationType == typeof(CS.Markers.AnimatorParameterMarker) then
            print("[信号] AnimatorParameterMarker ", notification.parameterType, notification.name, notification.value, notification.dampTime, notification.deltaTime)
            -- if notification.parameterType == CS.Markers.AnimatorParameterType.Float then
            --     print("[信号] is float")
            -- end
        elseif notificationType == typeof(CS.Markers.AnimatorPlayAndThenMarker) then
            print("[信号] AnimatorPlayAndThenMarker ", notification.name, notification.fixedTransitionDuration, 
            notification.layer, notification.startOffset, notification.toOffset, 
            notification.andThenType, notification.thenFixedTransitionDuration,
            notification.loopStartOffset, notification.loopSpeed)
            local animStateName = notification.name
            local tran = checkNumber(notification.fixedTransitionDuration)
            local layer = checkInt(notification.layer)
            local startOffset = checkNumber(notification.startOffset)
            local toOffset = checkNumber(notification.toOffset)
            local andThen = self:ConvertAndThenType(notification.andThenType)
            local thenTran = checkNumber(notification.thenFixedTransitionDuration)
            local loopStartOffset = checkNumber(notification.loopStartOffset)
            local loopSpeed = checkNumber(notification.loopSpeed)
            self:PlayToTimeAndThen(animStateName, tran, layer, startOffset, toOffset, andThen, thenTran, loopStartOffset, loopSpeed)
        elseif notificationType == typeof(CS.Markers.AbstractMarker) then
            print("[信号] AbstractMarker ", notification.markerType, notification.parameters.Count)
            -- for i = 0, notification.parameters.Count - 1, 1 do
            --     print("[信号] ", notification.parameters[i])
            -- end
        end
    end)
end

--添加timeline的接收信号
function RoleView:AddAnimSignal( signalName, animName )
    self:AddSignalHandler(signalName, function (  )
        -- print("signal:"..signalName)
        self:ResetAnimatorEvent()
        self.animator:Play(animName, self.animatorLayIndex, 0)
    end)
end

function RoleView:AddSignalHandler(signalName, handler)
    local sr = KTool.GetOrAddComponent(self.gameObject, typeof(SignalReceiver))

    local path = gameUtils.GetTimelineSignalFullPath(signalName)
    ---@type Engine.Modules.AbstractResourceLoader
    local loader = ResourceModule.LoadBundleSync(path)--"Timeline/Timeline.prefab"
    loader:Retain(sr)
    -- print("AddSignalHandler", signalName, sr:GetReaction(loader.ResultObject))
    if not loader.IsError and isNull(sr:GetReaction(loader.ResultObject)) then
        local event = CS.UnityEngine.Events.UnityEvent();
        event:AddListener(handler)
        sr:AddReaction(loader.ResultObject, event)
    end
    loader:Release()
end

function RoleView:ConvertAndThenType(andThenType)
    if andThenType == AndThenType.None then
        return 0
    elseif andThenType == AndThenType.Idle then
        return 1
    elseif andThenType == AndThenType.Pause then
        return 2
    elseif andThenType == AndThenType.Loop then
        return 3
    end
end

function RoleView:ResetAnimatorEvent()
    if isNotNull(self.coAnimatorEvent) then
        CoStop(self.coAnimatorEvent)
        self.coAnimatorEvent = nil
    end

    self.animator.speed = 1
end

--- func desc
---@param name any
---@param tran any
---@param start any
---@param to any
function RoleView:PlayToTimeAndThen(name, tran, layer, startOffset, toOffset, andThen, thenTran, loopStartOffset, loopSpeed)
    -- tran = tran or 0
    -- startOffset = startOffset or 0
    -- toOffset = toOffset or -1
    -- andThen = andThen or 1
    -- thenTran = thenTran or 0

    if toOffset ~= -1 and (toOffset < (startOffset + tran)) then
        toOffset = startOffset + tran
    end

    if isNotNull(self.coAnimatorEvent) then
        CoStop(self.coAnimatorEvent)
        self.coAnimatorEvent = nil
    end

    self.animator.speed = 1
    self.animator:CrossFadeInFixedTime(name, tran, layer, startOffset)
    self.animator:Update(0)
    if andThen == 0 then
        -- 交换控制给controller
    elseif andThen == 1 then
        -- 返回idle状态
        self.coAnimatorEvent = CoStart(function()
            while true do
                local stateInfo = self:GetTargetStateInfo()
                if not stateInfo:IsName(name) then
                    print("[动画] GetTargetStateInfo 可能是开始从目标状态过渡到另外的状态了 ", name)
                    -- 可能是开始从目标状态过渡到另外的状态了
                    self.animator:CrossFadeInFixedTime("idle", thenTran, layer)
                    return
                end
                local to = toOffset < 0 and (stateInfo.length - 0.016) or math.min(toOffset, stateInfo.length)     -- 防止传入的toOffset大于动画最大长度
                local currentFixedTime = stateInfo.normalizedTime * stateInfo.length
                if currentFixedTime >= to then
                    self.animator:CrossFadeInFixedTime("idle", thenTran, layer)
                    return
                else
                    CoYield()
                end
            end
        end)
    elseif andThen == 2 then
        -- 暂停在当前帧
        self.coAnimatorEvent = CoStart(function()
            while true do
                local stateInfo = self:GetTargetStateInfo()
                if not stateInfo:IsName(name) then
                    print("[动画] GetTargetStateInfo 可能是开始从目标状态过渡到另外的状态了 ", name)
                    -- 可能是开始从目标状态过渡到另外的状态了
                    self.animator.speed = 0
                    return
                end
                if toOffset == -1 then
                    -- 默认行为，当完全进入到目标状态之后，就暂停住
                    local isInTransition = self.animator:IsInTransition(layer)
                    if not isInTransition then
                        self.animator.speed = 0
                        return
                    else
                        CoYield()
                    end
                else
                    local to = math.min(toOffset, stateInfo.length)     -- 防止传入的toOffset大于动画最大长度
                    local currentFixedTime = stateInfo.normalizedTime * stateInfo.length
                    if currentFixedTime >= to then
                        self.animator.speed = 0
                        return
                    else
                        CoYield()
                    end
                end
            end
        end)
    elseif andThen == 3 then
        -- 在start和to之间进行循环
        self.coAnimatorEvent = CoStart(function()
            self.animator.speed = loopSpeed
            while true do
                local stateInfo = self:GetTargetStateInfo()
                local currentFixedTime = stateInfo.normalizedTime * self.animator.speed * stateInfo.length
                if currentFixedTime >= (toOffset) then
                    self.animator:CrossFadeInFixedTime(name, tran, layer, loopStartOffset / self.animator.speed)
                    self.animator:Update(0)
                    CoYield()
                else
                    CoYield()
                end
            end
        end)
    end
end

function RoleView:TestPlay(name, tran, loopStart, loopTo, speed)
    if isNotNull(self.coAnimatorEvent) then
        CoStop(self.coAnimatorEvent)
        self.coAnimatorEvent = nil
    end

    self.animator.speed = speed
    self.animator:CrossFadeInFixedTime(name, tran, self.animatorLayIndex)
    self.animator:Update(0)

    self.coAnimatorEvent = CoStart(function()
        while true do
            local stateInfo = self:GetTargetStateInfo()
            local currentFixedTime = stateInfo.normalizedTime * self.animator.speed * stateInfo.length
            if currentFixedTime >= (loopTo) then
                self.animator:CrossFadeInFixedTime(name, tran, self.animatorLayIndex, loopStart / self.animator.speed)
                self.animator:Update(0)
                local isInTransition = self.animator:IsInTransition(self.animatorLayIndex)
                local curStateInfo = self.animator:GetCurrentAnimatorStateInfo(self.animatorLayIndex)
                local nextStateInfo = self.animator:GetNextAnimatorStateInfo(self.animatorLayIndex)
                print("[动画] start loop", curStateInfo:IsName("attack_hit"), curStateInfo.normalizedTime * curStateInfo.length, isInTransition, nextStateInfo:IsName("attack_hit"), nextStateInfo.normalizedTime * nextStateInfo.length)
                CoYield()
            else
                local isInTransition = self.animator:IsInTransition(self.animatorLayIndex)
                local curStateInfo = self.animator:GetCurrentAnimatorStateInfo(self.animatorLayIndex)
                local nextStateInfo = self.animator:GetNextAnimatorStateInfo(self.animatorLayIndex)
                print("[动画] wait", curStateInfo:IsName("attack_hit"), curStateInfo.normalizedTime * curStateInfo.length, isInTransition, nextStateInfo:IsName("attack_hit"), nextStateInfo.normalizedTime * nextStateInfo.length)
                CoYield()
            end
        end
    end)
end

function RoleView:GetTargetStateInfo()
    -- 调用animator的CrossFadeInFixedTime接口时如果传了过渡时间，那么在Update(0)之后，animator的状态会立即变成isInTransition
    local stateInfo
    local isInTransition = self.animator:IsInTransition(self.animatorLayIndex)
    if isInTransition then
        stateInfo = self.animator:GetNextAnimatorStateInfo(self.animatorLayIndex)
    else
        stateInfo = self.animator:GetCurrentAnimatorStateInfo(self.animatorLayIndex)
    end
    return stateInfo
end

function RoleView:Reset(  )
    if self.co then
        cs_coroutine.stop(self.co)
        self.co = nil
    end
    if self.hurtCo then
        cs_coroutine.stop(self.hurtCo)
        self.hurtCo = nil
    end
    self.buffViewMgr:Clear()

    self:StopPerformCo()
end

---GetLookAtState
---获取lookAt的状态值
function RoleView:GetLookAtState()
    return checkNumber(self.modelVo.whetherLookAt)
end

function RoleView:OnUseCard(data)
    -- local role = BattleViewMgr:FindRoleView(data.roleId)
    if data.roleId == self.id  then
        BattleViewMgr.FXMgr:PlayFXOnRole(Constants.BattleCommonFX.CardUse, self)
        self:PlayAnimation("useCard")
        self.usedCard = true
        self.buffViewMgr:CheckSpecialIdle()
    end
end

function RoleView:OnResetCard()
    self.usedCard = false
    self.buffViewMgr:CheckSpecialIdle()
end

function RoleView:Dispose(  )
    if isNotNull(self.coAnimatorEvent) then
        CoStop(self.coAnimatorEvent)
        self.coAnimatorEvent = nil
    end

    if self.__OnUseCard then
        Events.RemoveListener(Constants.EventNames.BattleOnRoleUseCard, self.__OnUseCard)
        self.__OnUseCard = nil
    end
    Events.RemoveListener(Constants.EventNames.BattleInputReset, self.__OnResetCard)
    self.__OnResetCard = nil
    
    self:Reset()
    if self.gameObject then
        CS.UnityEngine.GameObject.Destroy(self.gameObject)
    end
    if self.defaultNode then
        CS.UnityEngine.GameObject.Destroy(self.defaultNode.gameObject)
    end
    self.gameObject = nil
    self.transform = nil
    self.animator = nil
    self._skinnedMeshes = nil
end

--- 显示专武特效
function RoleView:SetUniqueWeaponEffectState(state)
    local comp = self.gameObject:GetComponentInChildren(typeof(CS.Game.Native.Common.ExclusiveWeaponController))
    if not isNull(comp) then
        comp.IsShow = state
    end
end

--- 获取大招timeline是否已在本地播放过的标记id
function RoleView:GetUltraTimelineMarkId()
    return self.modelVo.id
end

---检查卡牌受伤语音
---在一次战斗中，武装受到伤害后，若生命值首次低于70%高于50%或50%高于20%则播放1次轻伤语音，首次低于20%播放一次重伤语音
---@param per number 血量百分比
function RoleView:CheckInjuredVoice(per)
    if not self.isPlayer then return end
    if self.lowestHpPer <= per then return end
    
    if 0.5 <= per and per < 0.7 and self.lowestHpPer >= 0.7 then
        RoleVoiceMgr:GetInstance():PlayMinorInjuredVoiceByCardId(self.typeId)
    elseif 0.2 <= per and per < 0.5 and self.lowestHpPer >= 0.5 then
        RoleVoiceMgr:GetInstance():PlayMinorInjuredVoiceByCardId(self.typeId)
    elseif 0 < per and per < 0.2 and self.lowestHpPer >= 0.2 then
        RoleVoiceMgr:GetInstance():PlaySeriousInjuredVoiceByCardId(self.typeId)
    end
    self.lowestHpPer = per
end

function RoleView:GetLerpAudioVolumeIter(targetVolume)
    local comp = self.gameObject:GetComponent(typeof(CS.CriWare.CriAtomSource))
    if isNull(comp) then
        return
    end

    local from = comp.volume
    local to = targetVolume

    local curve = AnimationCurve.Linear(0,0,1,1)
    -- curve = AnimationCurve()
    -- curve:AddKey(Keyframe(0,0,0,0))
    -- curve:AddKey(Keyframe(1,1,1,1))

    return function(t)
        local volume = Mathf.Lerp(from, to, curve:Evaluate(t))
        comp.volume = volume
    end
end

function RoleView:LerpAudioVolume(targetVolume, duration)
    local comp = self.gameObject:GetComponent(typeof(CS.CriWare.CriAtomSource))
    if isNull(comp) then
        return
    end

    local from = comp.volume
    local to = targetVolume

    local time = duration
    local timer = 0
    local curve = AnimationCurve.Linear(0,0,1,1)

    while timer < time do
        timer = timer + 0.016
        -- CoYield(0.016)
        cs_coroutine.yield_return(WaitForSecondsRealtime(0.016))
        local volume = Mathf.Lerp(from, to, curve:Evaluate(timer / time))
        comp.volume = volume
    end
end

function RoleView:SetAudioVolume(volume)
    local comp = self.gameObject:GetComponent(typeof(CS.CriWare.CriAtomSource))
    if isNull(comp) then
        return
    end
    comp.volume = volume
end

function RoleView:PauseAudio()
    local comp = self.gameObject:GetComponent(typeof(CS.CriWare.CriAtomSource))
    if isNull(comp) then
        return
    end
    comp:Pause(true)
end

function RoleView:ResumeAudio()
    local comp = self.gameObject:GetComponent(typeof(CS.CriWare.CriAtomSource))
    if isNull(comp) then
        return
    end
    comp:Pause(false)
end

function RoleView:AddSwitchAnimatorControllerTag(tagInfo)
    table.insert(self.switchAnimatorControllerTags, tagInfo)
end

function RoleView:TrigSwitchAnimatorController(trigPoint, flagValue)
    if self.switchAnimatorControllerTags == nil then
        return
    end
    local index = -1
    for i, tagInfo in ipairs(self.switchAnimatorControllerTags) do
        if tagInfo.trigPoint == trigPoint
        and tagInfo.flagValue == flagValue then
            index = i
            break
        end
    end
    if index > 0 then
        local tagInfo = table.remove(self.switchAnimatorControllerTags, index)
        local controllerName = tagInfo.controllerName
        local initStateName = tagInfo.initStateName

        local controllerPath = "RuntimeController/Animator_trans/"..controllerName..".overrideController"
        local loader = ResMgr.roleAnimatorControllersLoader[controllerPath]
        if isNotNull(loader) then
            if loader.IsSuccess then
                self.animator.runtimeAnimatorController = loader.ResultObject
                self:PlayAnimation(initStateName, true, 0)
                self:SyncAnimation()
            end
        end
    end
end

function RoleView:SetSpecialHitActive159008(active)
    self.useSpecialHitAnim159008 = active
    self.specialHitCount159008 = 0
end

function RoleView:GetRegister1()
    return self.register1
end

function RoleView:SetRegister1(value)
    self.register1 = value
end

return  RoleView