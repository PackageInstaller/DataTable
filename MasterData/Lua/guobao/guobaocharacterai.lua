GuoBaoCharacterAI = {};

GuoBaoCharacterAI.__index = GuoBaoCharacterAI;

GuoBaoCharacterAI.New = function()
    local self = {};
    setmetatable(self, GuoBaoCharacterAI);
    self.container = nil;
    self.character = nil;
    self.moves = nil;
    self.paths = {};
    self.pos = nil;
    self.targetPos = nil;
    self.direction = nil;
    self.distance = 0;
    self.startTime = 0;
    self.endTime = 0;
    self.aiState = 0;
    self.aiTime = 0;
    self.isB = false;
    self.scaleX = 1;
    self.lineDir = true;
    self.lineIndex = 0;
    self.data = nil;
    self.playComplete = function(aniName)
        self:PlayDir(self.characterConfig.Idle, true, nil);
        self.aiState = GuoBaoAIState.Idle;
    end
    return self;
end

function GuoBaoCharacterAI:SetData(character, data)
    self.character = character;
    self.container = character.transform;
    self.characterConfig = character.characterConfig;
    self.data = data;
    self.aiState = GuoBaoAIState.Idle;
    self.aiTime = os.time() + math.random(1, 3);
    self.lineDir = true;
    self.lineIndex = 1;
    self.container.localPosition = data.points[self.lineIndex];
end

function GuoBaoCharacterAI:FindMovePoint()
    local len = #self.data.points;
    if (len > 1) then
        if (self.lineDir) then
            local index = self.lineIndex + 1;
            if (index <= len) then
                self.lineIndex = index;
                return self.data.points[index];
            else
                self.character.live = false;


            end
        else
            local index = self.lineIndex - 1;
            if (index >= 1) then
                self.lineIndex = index;
                return self.data.points[index];
            else
                self.lineDir = true;
                self.lineIndex = 1;
            end
        end
    end
    return nil;
end

function GuoBaoCharacterAI:Clear()
    GuoBaoSceneLineMgr.RevertLine(self.data);
    self.data = nil;
    self.character = nil;
    self.container = nil;
    self.characterConfig = nil;
    self.pos = nil;
    self.targetPos = nil;
    self.direction = nil;
    self.playComplete = nil;
end

function GuoBaoCharacterAI:Update()
    local time = os.time();
    if (time < self.aiTime) then return end

    local aiState = self.aiState;
    if (aiState == GuoBaoAIState.Move) then
        self:OnMove();
    elseif (aiState == GuoBaoAIState.Action) then
    elseif (aiState == GuoBaoAIState.Idle) then
        local rand = math.random(1, 100);
        if (rand > 90) then
            if (self.characterConfig ~= nil) then
                self:Play(self.characterConfig.Action);
            end
            self.aiTime = time + 6;
        elseif (rand > 30) then
            self:CheckMove();
        else
            self.aiTime = time + math.random(2, 4);
        end
    end
end

function GuoBaoCharacterAI:Play(aniName)
    self:PlayDir(aniName, false, self.playComplete);
    self.aiState = GuoBaoAIState.Action;
end

function GuoBaoCharacterAI:PlayDir(aniName, loop, complete)
    aniName = aniName .. (self.isB and "_b" or "");
    self.character.character:Play(aniName, self.scaleX, loop, complete);
end

function GuoBaoCharacterAI:CheckMove()
    local point = self:FindMovePoint();
    if (point ~= nil) then
        self:Move(point);
    end
end

function GuoBaoCharacterAI:Move(targetPos)
    self.pos = self.container.localPosition;
    self.targetPos = targetPos;
    local p = self.pos - targetPos;
    self.direction = p.normalized;
    self.distance = p.magnitude;
    if (self.distance > 0) then
        self.startTime = CS.UnityEngine.Time.realtimeSinceStartup;
        local time = self.distance * (1 / 0.7);
        self.endTime = self.startTime + time;
        local isB, scaleX = GuoBaoCharacterMgr.CalcAnimationDirection(p.x, p.z);
        if (isB ~= self.isB or scaleX ~= self.scaleX or self.aiState ~= GuoBaoAIState.Move) then
            self.isB = isB;
            self.scaleX = scaleX;
            if (self.characterConfig ~= nil) then
                self:PlayDir(self.characterConfig.Move, true, nil);
            end
            self.aiState = GuoBaoAIState.Move;
        end
    end
end

function GuoBaoCharacterAI:OnMove()
    local time = CS.UnityEngine.Time.realtimeSinceStartup;
    if (time < self.endTime) then
        local moveDistance = (time - self.startTime) / (self.endTime - self.startTime) * self.distance;
        local p = self.pos - (self.direction * moveDistance);
        self.container.localPosition = p;
    else
        self.container.localPosition = self.targetPos;
        local rand = math.random(1, 100);
        if (rand > 30) then
            self:CheckMove();
            return;
        end
        if (self.characterConfig ~= nil) then
            self:PlayDir(self.characterConfig.Idle, true, nil);
        end
        self.aiState = GuoBaoAIState.Idle;
        self.aiTime = os.time() + math.random(0, 2);
    end
end