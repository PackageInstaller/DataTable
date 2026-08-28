---
--- Created by Eric.
--- DateTime: 2022/8/1 16:50
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local Time               = CS.UnityEngine.Time
local DOTween = CS.DG.Tweening.DOTween

------------ import ------------

------------ define ------------
local TAG_TWEEN = "CommonExperienceUpgradeTips"
------------ define ------------


--- from: Assets/BundleResources/Prefabs/Common/CommonExperienceUpgradeTips.prefab
---@class CommonExperienceUpgradeTips
---@field Env                           	CommonExperienceUpgradeTips
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field BehaviourAction               	Engine.Lib.BehaviourAction
---@field ProgressBar                   	UnityEngine.UI.Slider
---@field TxtGroup                      	UnityEngine.Animator
---@field TxtExperience                 	TMPro.TextMeshProUGUI
---@field TxtNum                        	TMPro.TextMeshProUGUI
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform
local CommonExperienceUpgradeTips = Class("CommonExperienceUpgradeTips")
function CommonExperienceUpgradeTips:__init()
    --进度条从入场0.2s开始增加，1.1s帧结束
    self.sliderTime = 1.1 - 0.2
    self.startTime = Time.unscaledTime
    self.data = {}
    self.currentLevel = nil
    self.isFinish = nil
    self.isLevelUp = nil

end

function CommonExperienceUpgradeTips:__delete()
    self.sliderTime = nil
    self.startTime = nil
    self.data = nil
    self.currentLevel = nil
    self.isFinish = nil
    self.isLevelUp = nil


    self.controller = nil
end


function CommonExperienceUpgradeTips:Awake()
    self.EventClose = Events.AddListener(Constants.EventNames.CloseExpChangeTips, function()
        self.controller:Delete()
    end)
end

--{
--    oldLevel = oldLevel,
--    nowLevel = newLevel,
--    oldExp = self.expBefore,
--    nowExp = self.playerDojo.mainExp
--}
function CommonExperienceUpgradeTips:FreshBaseUI(data)
    self.data = data
    self.isBegin = true
    local headEnv  = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, "Game.Behaviours.CommonPlayerHeadNode")
    if headEnv then
        headEnv:FreshBaseUI()
    end
    self.TxtNum.text = data.oldLevel
    self.currentLevel = data.oldLevel
    self.oldExpData = CardConfMgr:GetInstance():GetPlayerExpByLevelId(data.oldLevel)
    local nextExpData = CardConfMgr:GetInstance():GetPlayerExpByLevelId(data.oldLevel + 1)
    self.nowExpData = CardConfMgr:GetInstance():GetPlayerExpByLevelId(data.nowLevel)
    local curExp = data.oldExp - self.oldExpData.totalExp
    self.TxtExperience.text = string.format("<color=#f953b1>%d</color>/%d", curExp, nextExpData.exp)
    local isUpgrade = data.oldLevel > 0 and data.nowLevel > data.oldLevel
    --if isUpgrade then
    --end
    self.ProgressBar.value = curExp / nextExpData.exp
    --self.BehaviourAction.UpdateAction = function()
    --    self:Update()
    --end
    self:PlayAnim()



end

function CommonExperienceUpgradeTips:PlayAnim()
    DOTween.Pause(TAG_TWEEN)
    DOTween.Kill(TAG_TWEEN)
    if self.isFinish then
        return
    end

    local levelChange = self.data.nowLevel - self.data.oldLevel
    local time = self.sliderTime / (levelChange + 1)
    local nextExpData = CardConfMgr:GetInstance():GetPlayerExpByLevelId(self.currentLevel + 1)
    local all =  nextExpData.exp
    --local startValue = self:GetSliderStartValue()
    local endValue = self:GetSliderEndValue()
    local delay = self.isBegin and 0.1 or 0
    local tween = DOTween.To(function() return self.ProgressBar.value end,
            function (value)
                if value == 1 then
                    CfUtils.PlayAnimator(self.TxtGroup, "Up")
                    self.isLevelUp = true
                end
                self.ProgressBar.value = value
                self.TxtExperience.text = string.format("<color=#f953b1>%d</color>/%d", checkInt(value * all), all)
            end,endValue,time):SetDelay(delay)
    tween.stringId = TAG_TWEEN
    tween:OnComplete(
            function ()
                if self.isLevelUp then
                    self.ProgressBar.value = 0
                    self.isLevelUp = false
                end
                self.TxtNum.text = self.currentLevel
                self.isBegin = false
                self:PlayAnim()
            end
    )


    --local tween = DOTween.To(function() return self.ProgressBar.value end,
    --        function (value)
    --            print("value---->>"..value)
    --            self.ProgressBar.value = value
    --            self.TxtExperience.text = string.format("<color=#f953b1>%d</color>/%d", math.tointeger(value * nextExpData.exp), nextExpData.exp)
    --        end,
    --        --startValue,
    --        endValue,
    --        time
    --):SetDelay(self.isBegin and 0.1 or 0):OnComplete(
    --        function ()
    --            self.TxtNum.text = self.currentLevel
    --            self.isBegin = false
    --            if self.currentLevel < self.data.nowLevel then
    --                self:PlayAnim()
    --            end
    --        end
    --)
    --tween.stringId = TAG_TWEEN

end

--当前等级的endValue
function CommonExperienceUpgradeTips:GetSliderEndValue()
    local endValue
    if self.currentLevel < self.data.nowLevel then
        endValue = 1
        self.currentLevel = self.currentLevel + 1
    else
        local nowExpData = CardConfMgr:GetInstance():GetPlayerExpByLevelId(self.data.nowLevel)
        local nextExpData = CardConfMgr:GetInstance():GetPlayerExpByLevelId(self.data.nowLevel + 1)
        local total = nextExpData.exp
        local cur = self.data.nowExp - nowExpData.totalExp
        endValue = cur / total
        self.isFinish = true
    end
    print("endValue----->>"..endValue)
    return endValue
end

--当前等级的startValue
function CommonExperienceUpgradeTips:GetSliderStartValue()
    local startValue
    if self.currentLevel == self.data.oldLevel then
        local oldExpData = CardConfMgr:GetInstance():GetPlayerExpByLevelId(self.data.oldLevel)
        local nextExpData = CardConfMgr:GetInstance():GetPlayerExpByLevelId(self.data.oldLevel + 1)
        local total = nextExpData.exp
        local cur = self.data.oldExp - oldExpData.totalExp
        startValue = cur / total
    else
        startValue = 0
    end
    print("startValue----->>"..startValue)
    return startValue
end


--function CommonExperienceUpgradeTips:Update()
--
--
--end

function CommonExperienceUpgradeTips:OnDestroy()
    --self.BehaviourAction.UpdateAction = nil
    DOTween.Pause(TAG_TWEEN)
    DOTween.Kill(TAG_TWEEN)
    Events.RemoveListener(Constants.EventNames.CloseExpChangeTips, self.EventClose)
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CommonExperienceUpgradeTips