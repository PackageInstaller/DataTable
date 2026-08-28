---@type ParkourGameMgr
local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
---@type ParkourInput
local parkourInput = import("Game.Activity.ParkourGame.MainGame.ParkourInput"):GetInstance()
---@type ParkourGameUtil
local ParkourGameUtil = import("Game.Activity.ParkourGame.ParkourGameUtil")
local Time = CS.UnityEngine.Time
local UIEventProxy = CS.Engine.UI.UIEventProxy
local Vector3 = CS.UnityEngine.Vector3
local Mathf = CS.UnityEngine.Mathf


-- 隐身孢子功能 ui层


--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourMainDialog12001801.prefab > name: BtnSkill
---@class ParkourGameInvisibleSkill
---@field Env                            ParkourGameInvisibleSkill
---@field controller                        Engine.Modules.LuaBehaviour
---@field UIFX_ActivateGlow                UnityEngine.RectTransform                @ 0    
---@field ImgSlider                        UnityEngine.RectTransform                @ 1    
---@field ImgSkillPoint1                    UnityEngine.RectTransform                @ 2    
---@field ImgSkillPoint2                    UnityEngine.RectTransform                @ 3    
---@field ImgSkillPoint3                    UnityEngine.RectTransform                @ 4    
---@field TextTime                        UnityEngine.RectTransform                @ 5    
---@field UIFX_Boom                        UnityEngine.RectTransform                @ 6    
local ParkourGameInvisibleSkill = Class("ParkourGameInvisibleSkill")

---@class ParkourGameInvisibleSkill.InputData
---@field energy number


function ParkourGameInvisibleSkill:__init()
    self.controller = nil
    self.energyMax = 3
    self.inUse = false
end

function ParkourGameInvisibleSkill:__delete()
    self.controller = nil
end

function ParkourGameInvisibleSkill:Awake()
    UIEventProxy.Create(self.controller.gameObject).onPointerDown = function()
        --printError("down -1-")
        if Mgr.boss.showState == ParkourGameUtil.BossShowState.CountDown then
            --printError("down -boss CountDown-")
            parkourInput.skillEvent = 1

        elseif Mgr.boss.showState == ParkourGameUtil.BossShowState.Show then
            --printError("down -boss Show-")
            parkourInput.skillEvent = 2
        end

    end
    UIEventProxy.Create(self.controller.gameObject).onPointerUp = function()
        --if Mgr.boss.showState == ParkourGameUtil.BossShowState.CountDown then
            parkourInput.skillEvent = 0 -- 3
        --end
    end
end

---@param inData ParkourGameInvisibleSkill.InputData
function ParkourGameInvisibleSkill:RefreshData(inData)
    self.inData = inData
    if self.inData == nil then
        self.inData = {}
        self.inData.energy = 0
    end
    --    self.skill = Mgr.player.invisibleSkill
    self:RegisterEvent()
    self:RefreshUI()
end

function ParkourGameInvisibleSkill:RefreshUI()
    for i = 1, self.inData.energy do
        self["ImgSkillPoint" .. i].gameObject:SetActive(true)
        CfUtils.SetUISwitchImage(self["ImgSkillPoint" .. i], 2)
    end
    
    for i = self.inData.energy + 1, self.energyMax do
        self["ImgSkillPoint" .. i].gameObject:SetActive(true)
        CfUtils.SetUISwitchImage(self["ImgSkillPoint" .. i], 1)
    end

    CfUtils.SetActive(self.UIFX_ActivateGlow, self:CanUseSkill())
    CfUtils.SetActive(self.UIFX_Boom, self.inUse)
    CfUtils.SetActive(self.TextTime, self.inUse)
    CfUtils.SetActive(self.ImgSlider, self.inUse)
end

function ParkourGameInvisibleSkill:CanUseSkill()
    return self.inData.energy >= self.energyMax
end

function ParkourGameInvisibleSkill:RegisterEvent()
    if self.events then
        CfUtils.EventsUndecorated(self.events)
    end

    self.events = CfUtils.EventsDecorated({
        [ParkourGameUtil.Events.AddSkillEnergy] = Bind(self, self.AddSkillEnergy),
        [ParkourGameUtil.Events.UseSkill] = Bind(self, self.UseSkill),
    })
end

function ParkourGameInvisibleSkill:Update()
    if self.inUse then
        self.durationTimer = self.durationTimer - Time.deltaTime
        if self.durationTimer <= 0 then
            self.inUse = false
            CfUtils.SetActive(self.UIFX_Boom, false)
            CfUtils.SetActive(self.TextTime, false)
        else
            CfUtils.FillText(self.TextTime, Mathf.Ceil(self.durationTimer))
            CfUtils.SetImageFillAmount(self.ImgSlider, self.durationTimer / self.duration)
        end
    end
end

function ParkourGameInvisibleSkill:AddSkillEnergy()
    if self.inData.energy < self.energyMax then
        self.inData.energy = self.inData.energy + 1
        self:RefreshUI()
    end
end
function ParkourGameInvisibleSkill:UseSkill(duration)
    self.duration = duration or 1
    self.durationTimer = duration
    self.inData.energy = 0
    self.inUse = true
    self:RefreshUI()
    CfUtils.PlayAnimation(self.UIFX_Boom, "OverseaParkourMainDialog_UIFX_GlowBoom")
end

function ParkourGameInvisibleSkill:OnDestroy()
    self.hpNodes = nil
    if self.events then
        CfUtils.EventsUndecorated(self.events)
    end
end

return ParkourGameInvisibleSkill