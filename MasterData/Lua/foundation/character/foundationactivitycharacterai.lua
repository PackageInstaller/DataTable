FoundationActivityCharacterAI = {};

FoundationActivityCharacterAI.__index = FoundationActivityCharacterAI;

FoundationActivityCharacterAI.New = function()
    local self = {};
    setmetatable(self, FoundationActivityCharacterAI);
    self.container = nil;
    self.character = nil;
    self.moves = nil;
    self.paths = {};
    self.pos = nil;
    self.targetPos = nil;
    self.targetGrid = nil;
    self.direction = nil;
    self.distance = 0;
    self.startTime = 0;
    self.endTime = 0;
    self.aiState = 0;
    self.aiTime = 0;
    self.isB = false;
    self.scaleX = 1;
    self.data = nil;
    self.sitPos = nil;
    self.isSit = false;
    self.isSitAni = false;
    self.sitAlpha = 0;
    self.sitFrame = 0;
    self.interactData = nil;
    self.playComplete = function(aniName)
        if (self.aiState == FoundationAIState.Interact) then
            self.character.character:SetShadow(true);
        end
        self:PlayDir(self.characterConfig.Idle, true, nil);
        self.aiState = FoundationAIState.Idle;
    end
    return self;
end

function FoundationActivityCharacterAI:SetData(character, grid, moves, data)
    self.character = character;
    self.container = character.transform;
    self.characterConfig = character.characterConfig;
    self.moves = moves;
    self.data = data;
    self.aiState = FoundationAIState.Idle;
    self.aiTime = os.time() + math.random(1, 3);
    self:AddPathGrid(grid);
    self.container.localPosition = FoundationMgr.GetGridPos(grid.x, grid.y);
end

function FoundationActivityCharacterAI:GetMoveGrid(x, y)
    if (x > 1 or y > 1) then
        y = y + 1;
        if (y >= #self.moves) then return nil end
        local list = self.moves[y];
        if (list == nil) then return nil end

        x = x + 1;
        if (x >= #list) then return nil end
        local obj = list[x];
        if (obj ~= nil and obj.type == 0) then
            return obj;
        end
    end
    return nil;

end

function FoundationActivityCharacterAI:FindMoveGrid()
    local len = #self.paths;
    local current = self.paths[len];
    local list = {};
    local count = 0;

    local grid = self:GetMoveGrid(current.x, current.y - 1);
    if (grid ~= nil
            and self:GetMoveGrid(current.x - 1, current.y - 1) ~= nil
            and self:GetMoveGrid(current.x + 1, current.y - 1) ~= nil) then
        table.insert(list, grid);
        count = count + 1;
    end

    grid = self:GetMoveGrid(current.x + 1, current.y - 1);
    if (grid ~= nil
            and self:GetMoveGrid(current.x - 1, current.y - 1) ~= nil
            and self:GetMoveGrid(current.x - 1, current.y - 1) ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end

    grid = self:GetMoveGrid(current.x + 1, current.y);
    if (grid ~= nil
            and self:GetMoveGrid(current.x + 2, current.y) ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end

    grid = self:GetMoveGrid(current.x + 1, current.y + 1);
    if (grid ~= nil
            and self:GetMoveGrid(current.x, current.y + 1) ~= nil
            and self:GetMoveGrid(current.x + 2, current.y + 1) ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end

    grid = self:GetMoveGrid(current.x, current.y + 1);
    if (grid ~= nil
            and self:GetMoveGrid(current.x - 1, current.y + 1) ~= nil
            and self:GetMoveGrid(current.x + 1, current.y + 1) ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end

    grid = self:GetMoveGrid(current.x - 1, current.y + 1);
    if (grid ~= nil
            and self:GetMoveGrid(current.x - 2, current.y + 1) ~= nil
            and self:GetMoveGrid(current.x, current.y + 1) ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end

    grid = self:GetMoveGrid(current.x - 1, current.y);
    if (grid ~= nil
            and self:GetMoveGrid(current.x - 2, current.y) ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end

    grid = self:GetMoveGrid(current.x - 1, current.y - 1);
    if (grid ~= nil
            and self:GetMoveGrid(current.x - 2, current.y - 1) ~= nil
            and self:GetMoveGrid(current.x, current.y - 1) ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end
    len = #list;
    if (len > 0) then
        for i = 1, len do
            grid = list[i];
            if (not self:HasPathGrid(grid)) then
                return grid;
            end
        end
        local index = math.random(1, len);
        return list[index];
    end
    return nil;
end

function FoundationActivityCharacterAI:AddPathGrid(grid)
    local len = #self.paths;
    if (len >= 3) then
        table.remove(self.paths, 1);
        len = len - 1;
    end
    if (len > 0) then
        local temp = self.paths[len];
        if (temp.x ~= grid.x or temp.y ~= grid.y) then
            table.insert(self.paths, grid);
        end
    else
        table.insert(self.paths, grid);
    end
end

function FoundationActivityCharacterAI:HasPathGrid(grid)
    local temp;
    local len = #self.paths;
    for i = 1, len do
        temp = self.paths[i];
        if (temp.x == grid.x and temp.y == grid.y) then
            return true;
        end
    end
    return false;
end

function FoundationActivityCharacterAI:Clear()
    self.data = nil;
    self.character = nil;
    self.container = nil;
    self.characterConfig = nil;
    self.moves = nil;
    self.paths = nil;
    self.pos = nil;
    self.targetPos = nil;
    self.targetGrid = nil;
    self.direction = nil;
    self.playComplete = nil;
    self.sitPos = nil;
    self.interactData = nil;
end

function FoundationActivityCharacterAI:Update()
    local time = os.time();
    if (time < self.aiTime) then return end

    local aiState = self.aiState;
    if (aiState == FoundationAIState.Move) then
        self:OnMove();
    elseif (aiState == FoundationAIState.Action) then
    elseif (aiState == FoundationAIState.MoveSit) then
        if (self.isSitAni) then
            self:OnSitAni0();
        elseif (self.sitFrame > 1) then
            self.sitFrame = self.sitFrame - 1;
        else
            if (self.sitFrame == 1) then
                self.sitFrame = 0;
                self:MoveSit(self.sitPos, true, 0.2);
            end
            self:OnSitAni1();
            self:OnMoveSit();
        end
    elseif (aiState == FoundationAIState.Sit) then
        self:MoveSit(self.targetPos, false, 0.17);
    elseif (aiState == FoundationAIState.Idle) then
        local rand = math.random(1, 100);
        if (rand > 90) then
            self:Play(self.characterConfig.Action);
            self.aiTime = time + 6;
        elseif (rand > 30) then
            self:CheckMove();
        else
            self.aiTime = time + math.random(2, 4);
        end
    end
end

function FoundationActivityCharacterAI:Play(aniName)
    self:PlayDir(aniName, false, self.playComplete);
    self.aiState = FoundationAIState.Action;
end

function FoundationActivityCharacterAI:PlayDir(aniName, loop, complete)
    aniName = aniName .. (self.isB and "_b" or "");
    self.character.character:Play(aniName, self.scaleX, loop, complete);
end

function FoundationActivityCharacterAI:CheckMove()
    local grid = self:FindMoveGrid();
    if (grid ~= nil) then
        self.targetGrid = grid;
        self:AddPathGrid(grid);
        self:Move(FoundationMgr.GetGridPos(grid.x, grid.y));
    end
end

function FoundationActivityCharacterAI:Move(targetPos)
    self.pos = self.container.localPosition;
    self.targetPos = targetPos;
    local p = self.pos - targetPos;
    self.direction = p.normalized;
    self.distance = p.magnitude;
    if (self.distance > 0) then
        self.startTime = CS.UnityEngine.Time.realtimeSinceStartup;
        local time = self.distance * (1 / 0.7);
        self.endTime = self.startTime + time;
        local isB, scaleX = FoundationCharacterMgr.CalcAnimationDirection(p.x, p.z);
        if (isB ~= self.isB or scaleX ~= self.scaleX or self.aiState ~= FoundationAIState.Move) then
            self.isB = isB;
            self.scaleX = scaleX;
            self:PlayDir(self.characterConfig.Move, true, nil);
            self.aiState = FoundationAIState.Move;
        end
    end
end

function FoundationActivityCharacterAI:Sit(seatData)
    self.isB = false;
    self.scaleX = seatData.config.face;
    self.character.character:SetShadow(false);
    self.character.character:SetDistortZIntensity(false);

    local pos = FoundationMgr.GetGridPos(seatData.bx, seatData.by);
    pos.x = pos.x + seatData.config.x;
    pos.y = pos.y + seatData.config.y + 0.1;
    pos.z = pos.z + seatData.config.z;
    self.sitPos = pos;
    self.aiState = FoundationAIState.MoveSit;
    self.isSitAni = true;
    self.sitAlpha = 1;
    self.sitFrame = 5;
    self:OnSitAni0();
end

function FoundationActivityCharacterAI:MoveSit(sitPos, isSit, speed)
    self.aiState = FoundationAIState.MoveSit;
    self.pos = self.container.localPosition;
    self.sitPos = sitPos;
    self.isSit = isSit;
    local p = self.pos - sitPos;
    self.direction = p.normalized;
    self.distance = p.magnitude;
    self.startTime = CS.UnityEngine.Time.realtimeSinceStartup;
    self.endTime = self.startTime + speed;
    if (not isSit) then
        local isB, scaleX = FoundationCharacterMgr.CalcAnimationDirection(p.x, p.z);
        self.isB = isB;
        self.scaleX = scaleX;

        self:PlayDir(self.characterConfig.Move, true, nil);
    end
end

function FoundationActivityCharacterAI:OnSitAni0()
    self.sitAlpha = self.sitAlpha - 0.3;
    self.character.character:SetAlpha(self.sitAlpha);
    if (self.sitAlpha <= 0) then
        self.sitAlpha = 0;
        self.isSitAni = false;
        self.container.localPosition = self.sitPos;
        self:PlayDir("house_sit", true, nil);
        self.sitPos.y = self.sitPos.y - 0.1;
    end
end

function FoundationActivityCharacterAI:OnSitAni1()
    if (self.sitAlpha < 1) then
        self.sitAlpha = self.sitAlpha + 0.1;
        self.character.character:SetAlpha(self.sitAlpha);
    end
end

function FoundationActivityCharacterAI:OnMoveSit()
    local time = CS.UnityEngine.Time.realtimeSinceStartup;
    if (time < self.endTime) then
        local moveDistance = (time - self.startTime) / (self.endTime - self.startTime) * self.distance;
        local p = self.pos - (self.direction * moveDistance);
        self.container.localPosition = p;
    elseif (self.sitAlpha >= 1) then
        if (self.isSit) then
            self.container.localPosition = self.sitPos;
            self.aiState = FoundationAIState.Sit;
            self.aiTime = os.time() + math.random(6, 10);

        else
            self.container.localPosition = self.targetPos;
            self.character.character:SetShadow(true);
            self.character.character:SetDistortZIntensity(true);
            self:PlayDir(self.characterConfig.Idle, true, nil);
            self.aiState = FoundationAIState.Idle;
            self.aiTime = os.time() + math.random(0, 2);
            if (self.targetGrid ~= nil and self.data ~= nil and self.data.sitEnd ~= nil) then
                self.data.sitEnd(self.character.id, self.targetGrid.x, self.targetGrid.y);
            end
        end
    end
end

function FoundationActivityCharacterAI:OnMove()
    local time = CS.UnityEngine.Time.realtimeSinceStartup;
    if (time < self.endTime) then
        local moveDistance = (time - self.startTime) / (self.endTime - self.startTime) * self.distance;
        local p = self.pos - (self.direction * moveDistance);
        self.container.localPosition = p;
    else
        self.container.localPosition = self.targetPos;
        local rand = math.random(1, 100);







        if (self.data ~= nil and self.data.isInteract ~= nil) then
            if (os.time() > self.data.interactTime) then
                local interactData = self.data.isInteract(self.character);
                if (interactData ~= nil) then
                    self.data.interactTime = os.time() + interactData.config.Cooltime;
                    self.aiState = FoundationAIState.Interact;
                    if (#interactData.config.Interact >= 2) then
                        self.interactData = interactData;
                        self:PlayInteract();
                    else
                        self:Play(interactData.config.Interact[1]);
                    end
                    return;
                end
            end
        end
        if (rand > 30) then
            self:CheckMove();
            return;
        end
        self:PlayDir(self.characterConfig.Idle, true, nil);
        self.aiState = FoundationAIState.Idle;
        self.aiTime = os.time() + math.random(0, 2);
    end
end

function FoundationActivityCharacterAI:PlayInteract()
    self:Play(self.interactData.config.Interact[1]);
    self.character.character:SetShadow(false);
    if (self.interactData ~= nil and self.interactData.building ~= nil) then
        local effect = self.interactData.building.effect;
        if (effect ~= nil) then
            effect:Play();
        end
    end
end