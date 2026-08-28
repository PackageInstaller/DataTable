
local cs_coroutine = import('XLua.cs_coroutine')
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
local KTool = CS.Engine.Lib.KTool
local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils
local Animator = CS.UnityEngine.Animator
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
local ParseUtils = CS.ParseUtils
local Yielders = CS.Engine.Lib.Yielders

local RoleView = import("Game.BattleView.Entity.RoleView")

local SkillCat = {}
SkillCat = Class("SkillCat", RoleView)
SkillCat.gameObject = nil
SkillCat.transform = nil
SkillCat.animator = nil
SkillCat.camp = nil
SkillCat.skillViewId = nil
SkillCat.catInfo = nil
SkillCat.coPassiveEnter = nil
SkillCat.coPassiveFX = nil
SkillCat.coActiveEnter = nil
SkillCat.coActiveExit = nil

function SkillCat:__init(catInfo, gameObject)
    self.catInfo = catInfo      -- 服务器下发数据
    self.catId = catInfo.catId  -- 猫球卡牌表id
    self.star = catInfo.star
    self.id = catInfo.id        -- 角色战场id
    self.type = catInfo.type    -- 主被动类型 1：主动 2：被动
    self.gameObject = gameObject
    self.transform = gameObject.transform
    self.animator = gameObject:GetComponentInChildren(typeof(Animator))
    self.camp = catInfo.camp
    self.defaultPos = self.transform.position
    self.fxNode = self.gameObject

    local tableFile = settingMgr:Get(AutoIds.IdSetting6031)     -- 猫球升星表
    local key = string.format("%d%02d", self.catId, self.star)
    local starData = tableFile:GetByPrimaryKey(key)
    self.catSkillId = parse_number(starData, "SkillId", 0)  -- 猫球技能id

    local tableFile1 = settingMgr:Get(AutoIds.IdSetting6034)    -- 猫球技能表
    local skillData = tableFile1:GetByPrimaryKey(self.catSkillId)
    self.actionType = parse_number(skillData, "actionType", 1)      -- 猫球技能表现动作类型
    if self.type == 2 then
        -- 被动技能读角色天赋表（主动技能读技能牌逻辑表）
        local giftId = parse_string(skillData, "addBuffId") -- 天赋表id
        local setting = settingMgr:GetSetting(AutoIds.IdSetting5, "TalentVo")   -- 角色天赋表
        local giftVo = setting:Get(giftId)
        self.talentVo = giftVo
        self.skillName = giftVo.name  -- 被动技能名
        self.skillDesc = giftVo.desc  -- 被动技能描述
    end
    self.skillViewId = Constants.SkillCatSkillViewIdMap[self.actionType]     -- 技能特效类型表id

    local tableFile2 = settingMgr:Get(AutoIds.IdSetting6033)    -- 猫球卡牌表
    local row = tableFile2:GetByPrimaryKey(self.catId, false)
    self.catTypeId = parse_number(row, "catId", 0)    -- 猫种id
    self.catName = parse_localizeText(row, "name", "")  -- 猫球名字
    self.subType = parse_number(row, "subtype", 1)      -- 猫球偏向
    self.rare = parse_number(row, "rare", 1)            -- 猫球稀有度
    self.catImgPath = string.format("%s.png", ParseUtils.ParsePathName(row, "picture", "")) -- 大图路径

    local setting = settingMgr:GetSetting(AutoIds.IdSetting578, "BattleCatVo")
    local battleCatVo = setting:Get(self.catTypeId)

    local setting1 = settingMgr:GetSetting(AutoIds.IdSetting274, "ModelVo")
    self.modelVo = setting1:Get(battleCatVo.modeString)
    self.skinId = battleCatVo.catSkin

    local ultraInfo = Tools.splitToNum( catInfo.finalSkills, '=')
    self.finalSkillId = ultraInfo[1]    -- 猫球技能牌id
    self.finalSkillStar = ultraInfo[2]  -- 猫球技能牌star

    local passiveInfo = Tools.splitToNum( catInfo.passiveSkills, '=')
    self.passiveSkillId = passiveInfo[1]
    self.passiveSkillStar = passiveInfo[2]

    self.isSkillCat = true      -- 表示是猫球
    self:InitAnimationTimes()

    if self.type == 1 and BattleInfo:IsUserCamp(self.camp) then
        self.eventOnInputFinished = Events.AddListener(Constants.EventNames.BattleInputFinished, Bind(self, self.OnInputFinished))
    end
end

function SkillCat:__delete()
    if self.type == 1 and BattleInfo:IsUserCamp(self.camp) then
        Events.RemoveListener(Constants.EventNames.BattleInputFinished, self.eventOnInputFinished)
    end
    
    if self.coActiveEnter then
        cs_coroutine.stop(self.coActiveEnter)
        self.coActiveEnter = nil
    end
    if self.coActiveExit then
        cs_coroutine.stop(self.coActiveExit)
        self.coActiveExit = nil
    end
    if self.coPassiveEnter then
        cs_coroutine.stop(self.coPassiveEnter)
        self.coPassiveEnter = nil
    end
    if self.coPassiveFX then
        cs_coroutine.stop(self.coPassiveFX)
        self.coPassiveFX = nil
    end
end

function SkillCat:InitAnimationTimes(  )
    if self.animator then
        self.animationTimes = {}
        local clips = self.animator.runtimeAnimatorController.animationClips;
        local len = clips.Length
        for i=0,len-1 do
            local clip = clips[i];
            self.animationTimes[clip.name] = clip.length
        end
    end
end

function SkillCat:GetAnimationTime( animName )
    if self.animationTimes then
        local time = self.animationTimes[animName]
        if time then
            return time
        end
    end

    return 1
end

function SkillCat:PlayAnimation( name, isForce, fadeTime )
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

function SkillCat:GetSkillShowId( skillIndex )
    return self.skillViewId
end

--- 获取大招timeline是否已在本地播放过的标记id
function SkillCat:GetUltraTimelineMarkId()
    return string.format("skillCat_%s", self.catId)
end

--- timeline大招里面会调用这个接口
function SkillCat:OnResetCard()
end

--- timeline大招里面会调用这个接口
function SkillCat:SyncStand(  )
    -- Tools.syncStand(self.transform, self.defaultStand)
end

function SkillCat:ChangeUltraPoint( point , type)
end

function SkillCat:SyncUIPosititon()
    --这里现在需要获取ui的位置
    local rectTransform = BattleViewMgr.battleUI:GetBattlingDialog().catFather
    local uiCamera = CS.Engine.UI.UIModule.RootCanvas.defaultCamera
    local V2fromInScreen = CS.UnityEngine.RectTransformUtility.WorldToScreenPoint (uiCamera, rectTransform.transform.position)
    local renderCamera = URPCameraController.mainCamera
    local ray = CS.UnityEngine.RectTransformUtility.ScreenPointToRay(renderCamera, V2fromInScreen)
    local pos = ray:GetPoint(3)

    self.transform.position = pos
    self.transform:LookAt( renderCamera.transform )
end

--- 主动猫球入场动画
function SkillCat:PlayActiveEnter()
    if self.coActiveExit then
        cs_coroutine.stop(self.coActiveExit)
        self.coActiveExit = nil
    end
    self:SyncUIPosititon()
    self.coActiveEnter = cs_coroutine.start(function()
        self.animator:CrossFadeInFixedTime("cat_enter", 0)
        -- self:PlayAnimation("cat_enter")
        local enterTime = self:GetAnimationTime("cat_enter")
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(enterTime))
        self:PlayAnimation("cat_idle1")
        self.coActiveEnter = nil
    end)
end

--- 主动猫球退场动画
function SkillCat:PlayActiveExit()
    if self.coActiveEnter then
        cs_coroutine.stop(self.coActiveEnter)
        self.coActiveEnter = nil
    end
    self.coActiveExit = cs_coroutine.start(function()
        self:PlayAnimation("cat_Departure")
        local exitTime = self:GetAnimationTime("cat_Departure")
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(exitTime))
        self.transform.position = self.defaultPos
        self.coActiveExit = nil
    end)
end

--- 被动猫球的入场动画
function SkillCat:PlayPassiveEnter()
    local sceneCenterGO = BattleViewMgr.sceneCenter
    local TF_SceneCenter = sceneCenterGO.transform

    local renderCamera = URPCameraController.mainCamera
    -- 相机位置
    local cameraPos = renderCamera.transform.position
    local cameraPosXZ = Vector3.New(cameraPos.x, 0, cameraPos.z)
    -- 场景中心位置
    local centerPos = TF_SceneCenter.position
    local centerPosXZ = Vector3.New(centerPos.x, 0, centerPos.z)
    -- 玩家视线方向
    local eyeDirection = Vector3.Normalize(centerPosXZ - cameraPosXZ)
    -- 玩家左手方向
    local leftDirection = Vector3.Cross(eyeDirection, Vector3.up):SetNormalize()

    self.transform.position = TF_SceneCenter.position + leftDirection * 5
    self.transform:LookAt(TF_SceneCenter)
    self:PlayAnimation("cat_skill2")
    

    -- 动画播放完以后把猫球归位
    self.coPassiveEnter = cs_coroutine.start(function()
        local animTime = self:GetAnimationTime("cat_skill2")
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(animTime))
        self.transform.position = self.defaultPos
        self.coPassiveEnter = nil
    end)

    -- 播放声音和特效
    local setting = settingMgr:GetSetting(AutoIds.IdSetting272, "SkillViewVo")
    local skillViewVo = setting:Get(self.skillViewId)
    local setting = settingMgr:GetSetting(AutoIds.IdSetting271, "ActionVo")
    local actionVo = setting:Get(skillViewVo.actionId)

    -- 声音
    BattleViewMgr:PlaySFX(skillViewVo.attackSFX, self)
    -- 攻击特效
    for i,v in ipairs(skillViewVo.attackFXs) do
        BattleViewMgr.FXMgr:PlayFXOnRole(v, self)
    end
    -- 受击特效
    self.coPassiveFX = cs_coroutine.start(function()
        local nowF = 0
        for i,v in ipairs(actionVo.hits) do
            local t = (v.frame - nowF) * AnimFrameTime
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(t))
            nowF = v.frame
            
            local effectName = skillViewVo.hitFX[i] or skillViewVo.hitFX[#skillViewVo.hitFX]
            local roles = BattleViewMgr:FindCampRoles(self.camp)
            for i, v in ipairs(roles) do
                BattleViewMgr.FXMgr:PlayFXOnRole(effectName, v)
            end
        end
        self.coPassiveFX = nil
    end)
end

function SkillCat:OnInputFinished()
    -- self:PlayActiveExit()
end

return SkillCat