FoundationBirdAI = {};

FoundationBirdAI.__index = FoundationBirdAI;

FoundationBirdAI.New = function(gameObject)
    local self = {};
    setmetatable(self, FoundationBirdAI);
    self.gameObject = gameObject;
    self.animator = gameObject:GetComponent("ModelAnimator");
    self.aniName = "";
    self.isPlay = false;
    self.aniCount = 0;
    self.playComplete = function(aniName)
        self.isPlay = false;
        self:CheckPlay();
    end
    return self;
end

function FoundationBirdAI:Clear()
    self.gameObject = nil;
    self.playComplete = nil;
end

function FoundationBirdAI:Update()
    if (not self.isPlay) then
        self:CheckPlay();
    end
end

function FoundationBirdAI:CheckPlay()
    if (self.aniName == "niao_idle01" and self.aniCount <= 2) then
        self.animator:Play(self.aniName, false, self.playComplete);
    elseif (self.aniName == "niao_idle03") then
        self.aniName = "niao_idle01";
        self.animator:Play(self.aniName, false, self.playComplete);
        self.aniCount = 0;
    else
        self.aniCount = 0;
        local num = math.random(1, 100);
        if (num > 70) then
            self.aniName = "niao_idle03";
        else
            self.aniName = "niao_idle01";
        end
        self.animator:Play(self.aniName, false, self.playComplete);
    end
    self.isPlay = true;
    self.aniCount = self.aniCount + 1;
end 