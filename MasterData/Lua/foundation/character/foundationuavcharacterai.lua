FoundationUAVCharacterAI = {};

FoundationUAVCharacterAI.__index = FoundationUAVCharacterAI;

FoundationUAVCharacterAI.New = function()
    local self = {};
    setmetatable(self, FoundationUAVCharacterAI);
    self.container = nil;
    self.character = nil;
    self.moves = nil;
    self.moveIndex = 1;
    self.pos = nil;
    self.targetPos = nil;
    self.direction = nil;
    self.distance = 0;
    self.startTime = 0;
    self.endTime = 0;
    self.aiState = 0;
    self.package = nil;
    self.packagePos = Vector3.zero;
    self.playComplete = function(aniName)
        self:CheckPackage();
    end
    return self;
end

function FoundationUAVCharacterAI:SetData(character, pos, moves, data)
    self.character = character;
    self.container = character.transform;
    self.characterConfig = character.characterConfig;
    self.moves = moves;
    self.package = data;
    self.aiState = FoundationAIState.Idle;
    self.container.localPosition = pos;
    self:SetPackagePos(pos);
    self:CheckPackage();
end

function FoundationUAVCharacterAI:Clear()
    self.container = nil;
    self.character = nil;
    self.characterConfig = nil;
    self.moves = nil;
    self.pos = nil;
    self.targetPos = nil;
    self.direction = nil;
    self.package = nil;
    self.packagePos = nil;
    self.playComplete = nil;
end

function FoundationUAVCharacterAI:Update()
    if (self.aiState == FoundationAIState.Move) then
        self:OnMove();
    end
end

function FoundationUAVCharacterAI:Play(aniName)
    self:PlayDir(aniName, false, self.playComplete);
    self.aiState = FoundationAIState.Action;
end

function FoundationUAVCharacterAI:PlayDir(aniName, loop, complete)
    aniName = aniName .. (self.isB and "_b" or "");
    self.character.character:Play(aniName, self.scaleX, loop, complete);
end

function FoundationUAVCharacterAI:CheckPackage()
    if (self.package ~= nil) then
        self.moveIndex = self.moveIndex + 1;
        if (self.moveIndex > #self.moves) then
            self.moveIndex = self.moveIndex - 1;
            self.package = nil;
            self:Play(self.characterConfig.Action);
            self.aiState = FoundationAIState.Action;
        else
            self:Move(self.moves[self.moveIndex]);
        end
    else
        self.moveIndex = self.moveIndex - 1;
        if (self.moveIndex > 0) then
            self:Move(self.moves[self.moveIndex]);
        else
            self.character.live = false;
        end
    end
end

function FoundationUAVCharacterAI:SetPackagePos(pos)
    if (self.package ~= nil) then
        self.packagePos.x = pos.x;
        self.packagePos.y = pos.y - 0.1;
        self.packagePos.z = pos.z;
        self.package.transform.localPosition = self.packagePos;
    end
end

function FoundationUAVCharacterAI:Move(targetPos)
    self.pos = self.container.localPosition;
    self.targetPos = targetPos;
    local p = self.pos - self.targetPos;
    self.direction = p.normalized;
    self.distance = p.magnitude;
    self.startTime = CS.UnityEngine.Time.realtimeSinceStartup;
    local time = self.distance;
    self.endTime = self.startTime + time;
    local isB, scaleX = FoundationCharacterMgr.CalcAnimationDirection(p.x, p.z);
    self.isB = isB;
    self.scaleX = scaleX;
    if (self.aiState ~= FoundationAIState.Move) then
        self:PlayDir(self.characterConfig.Move, true, nil);
        self.aiState = FoundationAIState.Move;
    end
end

function FoundationUAVCharacterAI:OnMove()
    local time = CS.UnityEngine.Time.realtimeSinceStartup;
    if (time < self.endTime) then
        local moveDistance = (time - self.startTime) / (self.endTime - self.startTime) * self.distance;
        local p = self.pos - (self.direction * moveDistance);
        self.container.localPosition = p;
        self:SetPackagePos(p);
    else
        self.container.localPosition = self.targetPos;
        self:SetPackagePos(self.targetPos);
        self:CheckPackage();
    end
end