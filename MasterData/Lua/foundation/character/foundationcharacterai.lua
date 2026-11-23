FoundationCharacterAI = {};

FoundationCharacterAI.__index = FoundationCharacterAI;

FoundationCharacterAI.New = function()
    local self = {};
    setmetatable(self, FoundationCharacterAI);
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
    self.playComplete = function(aniName)
        self:PlayDir(self.characterConfig.Idle, true, nil);
        self.aiState = FoundationAIState.Idle;
    end
    return self;
end

function FoundationCharacterAI:SetData(character, grid, moves, data)
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

function FoundationCharacterAI:GetMoveGrid(x, y)
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

function FoundationCharacterAI:FindMoveGrid()
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

function FoundationCharacterAI:AddPathGrid(grid)
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

function FoundationCharacterAI:HasPathGrid(grid)
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

function FoundationCharacterAI:Clear()
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
end

function FoundationCharacterAI:Update()
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

function FoundationCharacterAI:Play(aniName)
    self:PlayDir(aniName, false, self.playComplete);
    self.aiState = FoundationAIState.Action;
end

function FoundationCharacterAI:PlayDir(aniName, loop, complete)
    aniName = aniName .. (self.isB and "_b" or "");
    if self.scaleX<0 and FoundationCharacterMgr.CheckCharacterRotation(self.character.characterId,self.character.skinId,aniName)  then
        self.scaleX=1;
    end
    self.character.character:Play(aniName, self.scaleX, loop, complete);
end

function FoundationCharacterAI:CheckMove()
    local grid = self:FindMoveGrid();
    if (grid ~= nil) then
        self.targetGrid = grid;
        self:AddPathGrid(grid);
        self:Move(FoundationMgr.GetGridPos(grid.x, grid.y));
    end
end

function FoundationCharacterAI:Move(targetPos)
    if self.characterConfig==nil then return end;
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

function FoundationCharacterAI:Sit(seatData)
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

function FoundationCharacterAI:MoveSit(sitPos, isSit, speed)
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

function FoundationCharacterAI:OnSitAni0()
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

function FoundationCharacterAI:OnSitAni1()
    if (self.sitAlpha < 1) then
        self.sitAlpha = self.sitAlpha + 0.1;
        self.character.character:SetAlpha(self.sitAlpha);
    end
end

function FoundationCharacterAI:OnMoveSit()
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

function FoundationCharacterAI:OnMove()
    local time = CS.UnityEngine.Time.realtimeSinceStartup;
    if (time < self.endTime) then
        local moveDistance = (time - self.startTime) / (self.endTime - self.startTime) * self.distance;
        local p = self.pos - (self.direction * moveDistance);
        self.container.localPosition = p;
    else
        self.container.localPosition = self.targetPos;
        local rand = math.random(1, 100);
        if (rand > 60 and self.targetGrid ~= nil and self.data ~= nil and self.data.isTrigger ~= nil) then
            local seatData = self.data.isTrigger(self.character.id, self.targetGrid.x, self.targetGrid.y);
            if (seatData ~= nil) then
                self:Sit(seatData);
                return;
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