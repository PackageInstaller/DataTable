





MissionItemViewModel = {}

MissionItemViewModel.__index = MissionItemViewModel
MissionItemViewModel.countFormat = "<color=#262429>/%s</color>"
local objs = {
    normal = {path = "Anim/Normal",type = "GameObject"},
    normalText = {path = "Anim/Normal/Group/Text",type = "Text"},
    normaDaily = {path = "Anim/Normal/Group/Daily",type = "GameObject"},
    normaWeekly = {path = "Anim/Normal/Group/Weekly",type = "GameObject"},
    normaCount = {path = "Anim/Normal/Group/Count",type = "Text"},
    getObj = {path = "Anim/Normal/Group/GetBtn",type = "GameObject"},
    getBtn = {path = "Anim/Normal/Group/GetBtn",type = "Button"},
    gotoObj = {path = "Anim/Normal/Group/GotoBut",type = "GameObject"},
    gotoBut = {path = "Anim/Normal/Group/GotoBut",type = "Button"},
    barText = {path = "Anim/Normal/Group/GotoBut/Text",type = "Text"},
    barImg = {path = "Anim/Normal/Group/GotoBut/Bar/BarImg",type = "Image"},

    complete = {path = "Anim/Complete",type = "GameObject"},
    completeText = {path = "Anim/Complete/Group/Text",type = "Text"},
    completeDaily = {path = "Anim/Complete/Group/Daily",type = "GameObject"},
    completeWeekly = {path = "Anim/Complete/Group/Weekly",type = "GameObject"},
    completeCount = {path = "Anim/Complete/Group/Count",type = "Text"},
    
    animatorObj = {path = "Anim",type = "GameObject"},
    daily_Effect = {path = "eff_flash_daliy",type = "GameObject"},
    weekly_Effect = {path = "eff_flash_week",type = "GameObject"},
    eff_fly_daily = {path = "eff_fly_daliy",type = "GameObject"},
    eff_fly_week = {path = "eff_fly_week",type = "GameObject"},
    bg_effImage = {path = "Anim/Normal/BG_EffImage",type = "Image"},
}

function MissionItemViewModel.New()
    local self = {}
    setmetatable(self, MissionItemViewModel)
    return self
end

function MissionItemViewModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.getCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.MissionCompleted, self.data.id,self.index)
    end
    self.gotoCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.MissionGotoPanel, self.data.id)
    end
    LuaMgr.AddClick(self.getBtn,self.getCommand)
    LuaMgr.AddClick(self.gotoBut,self.gotoCommand)
    SetActive(self.animatorObj,false)
end


function MissionItemViewModel:SetData(data)
    self:ResetEffect()
    self.type = data.data.type
    self.data = data.data.data
    self.index = data.id
    if data.data.animBool then

        SetActive(self.animatorObj,true)
    end
    self.gameObject.transform.sizeDelta = Vector2(data.data.width,80)
    self:SetState()
    self.gameObject:SetActive(true)
end

function MissionItemViewModel:SetState()
    local mission = ConfigMgr.Config.missionMap[self.data.id]
    if mission == nil then return end
    if not self.data.completed then
        self.normaCount.text = "+"..mission.rewards[1].count
        self.normalText.text = LuaMgr.GetLangText(mission.NameLan)
        local targetCount = mission.condition1[1].Count;
        if self.data.current < targetCount then
            self.barText.text = LuaMgr.NumFormat(self.data.current)..string.format(self.countFormat,LuaMgr.NumFormat(targetCount))
            self.barImg.fillAmount = self.data.current / targetCount
        end
        SetActive(self.getObj,self.data.current >= targetCount)
        SetActive(self.gotoObj,self.data.current < targetCount)
    else
        self.completeCount.text = "+"..mission.rewards[1].count
        self.completeText.text = LuaMgr.GetLangText(mission.NameLan)
    end
    SetActive(self.normaDaily,self.type == "101" and not self.data.completed)
    SetActive(self.normaWeekly,self.type == "103" and not self.data.completed)
    SetActive(self.completeDaily,self.type == "101" and self.data.completed)
    SetActive(self.completeWeekly,self.type == "103" and self.data.completed)
    SetActive(self.normal,not self.data.completed)
    SetActive(self.complete,self.data.completed)
    mission = nil
end
function MissionItemViewModel:PlayEffect()
    if self.barImgDoTween == nil then
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Mission_Light_001.mp3")
        self.barImgDoTween = DOTWeen.To(function() return 0 end,
                function(vector)
                    self.bg_effImage.fillAmount = vector
                end, 1, 0.5):SetEase(Ease.OutQuint)
    end
    self.barImgDoTween.onComplete = function()
        SetActive(self.daily_Effect,self.type == "101")
        SetActive(self.weekly_Effect,self.type == "103")
    end
    if self.coroutine_key ~= nil then
        coroutine_runner.stop(self.coroutine_key)
    end
    self.coroutine_key = coroutine_runner.start(function()
        coroutine_runner.wait(0.95)
        HeroParameter.SaveEffectPoint(nil,self.transform)
        local startPos = nil
        if self.type == "101" then
            SetActive(self.eff_fly_daily,true)
            startPos = self.eff_fly_daily.transform.anchoredPosition
        elseif self.type == "103" then
            SetActive(self.eff_fly_week,true)
            startPos = self.eff_fly_week.transform.anchoredPosition
        end
        if self.flyDoTween == nil then
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/Mission_LightFly.mp3")
            self.flyDoTween = DOTWeen.To(function() return startPos end,
                    function(vector)
                        if self.type == "101" then
                            self.eff_fly_daily.transform.anchoredPosition = vector
                        elseif self.type == "103" then
                            self.eff_fly_week.transform.anchoredPosition = vector
                        end
                    end, HeroParameter.effectPoint, 0.8):SetEase(Ease.InSine)
        end
        self.flyDoTween.onComplete = function()
            if self.type == "101" then
                SetActive(self.eff_fly_daily,false)
                self.eff_fly_daily.transform.anchoredPosition = startPos
            elseif self.type == "103" then
                SetActive(self.eff_fly_week,false)
                self.eff_fly_week.transform.anchoredPosition = startPos
            end
            startPos = nil
        end
    end)
end
function MissionItemViewModel:ResetEffect()
    if self.flyDoTween ~= nil then
        self.flyDoTween.onComplete = nil
        self.flyDoTween:Kill()
        self.flyDoTween = nil
    end
    if self.barImgDoTween ~= nil then
        self.barImgDoTween.onComplete = nil
        self.barImgDoTween:Kill()
        self.barImgDoTween = nil
    end
    if self.coroutine_key ~= nil then
        coroutine_runner.stop(self.coroutine_key)
    end
    self.bg_effImage.fillAmount = 0.0
    self.eff_fly_daily.transform.anchoredPosition = Vector2(-267,0)
    self.eff_fly_week.transform.anchoredPosition = Vector2(-267,0)
    SetActive(self.daily_Effect,false)
    SetActive(self.weekly_Effect,false)
    SetActive(self.eff_fly_daily,false)
    SetActive(self.eff_fly_week,false)
end

function MissionItemViewModel:Clear()
    self.data = nil
    self.type = nil
    if self.coroutine_key ~= nil then
        coroutine_runner.stop(self.coroutine_key)
    end
    SetActive(self.animatorObj,false)
    self.gameObject:SetActive(false)
end

function MissionItemViewModel:Destroy()
    if (self.getCommand ~= nil) then
        LuaMgr.RemoveClick(self.getBtn, self.getCommand)
        self.getCommand = nil
    end
    if (self.gotoCommand ~= nil) then
        LuaMgr.RemoveClick(self.gotoBut, self.gotoCommand)
        self.gotoCommand = nil
    end
    if self.coroutine_key ~= nil then
        coroutine_runner.stop(self.coroutine_key)
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end