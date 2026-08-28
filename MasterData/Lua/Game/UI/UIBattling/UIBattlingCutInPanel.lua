------------ import ------------
local cs_coroutine = require("XLua.cs_coroutine")
local CanvasGroup = CS.UnityEngine.CanvasGroup
local NamedAnimancerComponent = CS.Animancer.NamedAnimancerComponent
------------ import ------------

------------ define ------------
local ANIMA_PATH_CUTIN_START_PLAYER = "Role_Enter"
local ANIMA_PATH_CUTIN_START_ENEMY = "Boss_Enter"
local ANIMA_PATH_CUTIN_LOOP_PLAYER = "Role_Loop"
local ANIMA_PATH_CUTIN_LOOP_ENEMY = "Boss_Loop"
local ANIMA_PATH_CUTIN_END_PLAYER = "Role_End"
local ANIMA_PATH_CUTIN_END_ENEMY = "Boss_End"
------------ define ------------

---@class UIBattlingCutInPanel
---@field TxtSkillName2                 	UnityEngine.UI.Text
---@field TxtSkillName                  	UnityEngine.UI.Text
---@field TxtRoleName2                  	UnityEngine.UI.Text
---@field TxtRoleName                   	UnityEngine.UI.Text
---@field ParticleRoot                  	UnityEngine.RectTransform
---@field ImgRole                       	Engine.UI.RawImageAlterable
---@field ImgBoss                       	Engine.UI.RawImageAlterable
---@field ImgBG                         	Engine.UI.RawImageAlterable
local UIBattlingCutInPanel = Class("UIBattlingCutInPanel")

function UIBattlingCutInPanel:__init()
    self.eventShowSkillCutInStart = nil
    self.eventShowSkillCutInEnd = nil
    self.canvasGroup = nil
    self.animatorPlayer = nil
end

function UIBattlingCutInPanel:__delete()
    self.eventShowSkillCutInStart = nil
    self.eventShowSkillCutInEnd = nil
    self.canvasGroup = nil
    self.animatorPlayer = nil
end

function UIBattlingCutInPanel:Awake()
    self.canvasGroup = self.controller.gameObject:GetComponent(typeof(CanvasGroup))
    self.animatorPlayer = self.controller.gameObject:GetComponent(typeof(NamedAnimancerComponent))
end

function UIBattlingCutInPanel:OnDestroy()
    self.controller = nil --luabehaviour 中CSharp对象
    self:Delete()
    self = nil
end

---PlayCutInEnd
---播放 CutIn 结束动画
function UIBattlingCutInPanel:PlayCutInEnd()
    local animationNameEnd = not BattleInfo:IsUserCamp(self.camp)
    and ANIMA_PATH_CUTIN_END_ENEMY
    or ANIMA_PATH_CUTIN_END_PLAYER
    --if self.animatorPlayer.CurrentAnimationName == self.animationNameStart then
    --    while self.animatorPlayer.CurrentAnimationName == self.animationNameStart  do
    --        cs_coroutine.yield_return()
    --        print("->UIBattlingCutInPanel:PlayCutInEnd_self.animatorPlayer.CurrentAnimationName == self.animationNameStart")
    --    end
    --    self.animatorPlayer:Play(animationNameEnd)
    --else
    --    self.animatorPlayer:Play(animationNameEnd)
    --    cs_coroutine.yield_return()
    --end
    --while self.animatorPlayer.IsPlaying do
    --    --print("->UIBattlingCutInPanel:PlayCutInEnd_self.animatorPlayer.IsPlaying")
    --    cs_coroutine.yield_return()
    --end
    if not isNull(self.panelAnimatorState) and checkString(self.panelAnimatorState.Key) == self.animationNameStart then
        cs_coroutine.yield_return(self.panelAnimatorState)
    end
    -- print("->TryPlay:UIBattlingCutInPanel:PlayCutInEnd", checkString(animationNameEnd))
    local animatorState = self.animatorPlayer:TryPlay(checkString(animationNameEnd))
    cs_coroutine.yield_return(animatorState)
    -- GameUtils.CommonScreenBlack(false, true, nil,nil, "FFFFFF")
end

---ShowCutIn
---展示 CutIn
---@param data table @ { roleId = 1, skillId = 1, star = 1 }
function UIBattlingCutInPanel:ShowCutIn(data)
    local roleId = checkInt(data.roleId)
    local skillId = checkInt(data.skillId)
    local star = checkInt(data.star)
    local roleData = BattleViewMgr:FindRoleView(roleId)
    if isNull(roleData) then return end
    local skinId = roleData.skinId
    local skinVo = UIBattlingTools.GetCardSkinDataBySkinId(skinId)
    self.camp = roleData.camp
    local isFriendCamp = BattleInfo:IsUserCamp(self.camp)
    if IsNull(skinVo) then return end
    local roleImg = not isFriendCamp and self.ImgBoss or self.ImgRole
    roleImg:LoadSprite(skinVo.cardDrawing)
    self.ImgBG:LoadSprite(skinVo.cardDrawing)
    if not IsNull(self.TxtRoleName) then
        self.TxtRoleName.text = checkString(skinVo.name) -- 角色名
        self.TxtRoleName2.text = checkString(skinVo.name)
    end
    if not IsNull(self.TxtSkillName) then
        self.TxtSkillName.text = checkString(skinVo.spSkillName) -- 技能名
        self.TxtSkillName2.text = checkString(skinVo.spSkillName)
    end
    self.animationNameStart = not isFriendCamp
            and ANIMA_PATH_CUTIN_START_ENEMY
            or ANIMA_PATH_CUTIN_START_PLAYER
    self.animationNameIdle = not isFriendCamp
            and ANIMA_PATH_CUTIN_LOOP_ENEMY
            or ANIMA_PATH_CUTIN_LOOP_PLAYER
    if not isNull(self.animatorPlayer) then
        -- print("->TryPlay:UIBattlingCutInPanel:ShowCutIn", checkString(self.animationNameStart))
        self.panelAnimatorState = self.animatorPlayer:TryPlay(checkString(self.animationNameStart))
        --self.panelAnimatorState.Events.OnEnd = function()
        --    self.animatorPlayer:TryPlay(self.animationNameIdle)
        --end
        --cs_coroutine.yield_return(self.panelAnimatorState)
        --while self.animatorPlayer.IsPlaying do
        --    cs_coroutine.yield_return()
        --    --print("->UIBattlingCutInPanel:ShowCutIn_self.animatorPlayer.IsPlaying")
        --end
    end
end

return UIBattlingCutInPanel
