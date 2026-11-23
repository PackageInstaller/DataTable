FoundationVendingMachineEffect = {};

FoundationVendingMachineEffect.__index = FoundationVendingMachineEffect;

local objs = {
    animator = { path = "animation", type = "ModelAnimator" },
    oneGO = { path = "animation/eff/Position/01", type = "GameObject" },
    oneGiftBox = { path = "animation/eff/Position/01/Giftbox", type = "GameObject" },
    oneAnimator = { path = "animation/eff/Position/01", type = "ModelAnimator" },
    moreGO = { path = "animation/eff/Position/02/Step02", type = "GameObject" },
    warningGO = { path = "animation/eff/Position/02/Step01_Warning", type = "GameObject" },
    moreAnimator = { path = "animation/eff/Position/02/Step02", type = "ModelAnimator" },
}

FoundationVendingMachineEffect.New = function(building)
    local self = {};
    setmetatable(self, FoundationVendingMachineEffect);
    UITool.Parse(building.group.gameObject, self, objs);
    self.data = nil;
    self.isCallback = false;
    self.oneComplete = function(aniName)
        self.animator:Stop();
        self:PlayBox();
    end
    self.oneBoxComplete = function(aniName)
        if (self.isCallback) then
            self.oneAnimator:Stop();
            SetActive(self.oneGiftBox, false);
            SetActive(self.oneGO, false);
        else
            self:Callback();
        end
    end
    self.doudongComplete = function(aniName)
        self.animator:Play("ani_Bulding30201_duoge", false, self.moreComplete);
    end
    self.moreComplete = function(aniName)
        self.animator:Stop();
        self:PlayBox();
    end
    self.moreBoxComplete = function(aniName)
        if (self.isCallback) then
            self.moreAnimator:Stop();
            SetActive(self.warningGO, false);
            SetActive(self.moreGO, false);
        else
            self:Callback();
        end
    end
    return self;
end

function FoundationVendingMachineEffect:Play(data)
    self.data = data;
    if (data.type) then
        self.animator:Play("ani_Bulding30201_doudong_duoge", false, self.doudongComplete);
    else
        self.animator:Play("ani_Bulding30201_one", false, self.oneComplete);
    end
end

function FoundationVendingMachineEffect:PlayBox()
    self.isCallback = false;
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/foundation_VMgift.mp3");
    if (self.data.type) then
        SetActive(self.warningGO, true);
        SetActive(self.moreGO, true);
        self.moreAnimator:Play("Giftbox01", false, self.moreBoxComplete, 0.5);
    else
        SetActive(self.oneGiftBox, true);
        SetActive(self.oneGO, true);
        self.oneAnimator:Play("Giftbox", false, self.oneBoxComplete, 0.3);
    end
end

function FoundationVendingMachineEffect:Callback()
    if (self.data ~= nil and self.data.callback ~= nil) then
        self.isCallback = true;
        self.data.callback();
    end
end

function FoundationVendingMachineEffect:Clear()
    self.data = nil;
    self.oneComplete = nil;
    self.oneBoxComplete = nil;
    self.doudongComplete = nil;
    self.moreComplete = nil;
    self.moreBoxComplete = nil;
    SetActive(self.oneGO, false);
    SetActive(self.warningGO, false);
    SetActive(self.moreGO, false);
end