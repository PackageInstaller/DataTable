FoundationBuildingCharacterAI = {};

FoundationBuildingCharacterAI.__index = FoundationBuildingCharacterAI;

FoundationBuildingCharacterAI.New = function()
    local self = {};
    setmetatable(self, FoundationBuildingCharacterAI);
    self.character = nil;
    self.container = nil;
    self.moves = nil;
    self.gridX = 0;
    self.gridY = 0;
    self.paths = {};
    self.pos = nil;
    self.targetPos = nil;
    self.direction = nil;
    self.distance = 0;
    self.startTime = 0;
    self.endTime = 0;
    self.aiState = 0;
    self.aiTime = 0;
    self.isIdle = false;
    self.isB = false;
    self.scaleX = 1;
    self.actionMap = {};
    self.playComplete = function(aniName)
        self:PlayDir(self.actionMap.idle, true, nil);
        self.aiState = FoundationAIState.Idle;
    end
    return self;
end

function FoundationBuildingCharacterAI:SetData(character, grid, moves, data)
    self.character = character;
    self.container = character.transform;
    if (character.characterConfig ~= nil) then
        self.actionMap = {move = character.characterConfig.Move,
                          idle = character.characterConfig.Idle,
                          action = character.characterConfig.Action};
    end
    self.moves = moves;
    self.aiState = FoundationAIState.Idle;
    self.aiTime = os.time() + math.random(1, 3);
    self:SetMoveGrid(grid);
    self:AddPathGrid(grid);
    self.container.localPosition = FoundationMgr.GetGridPos(grid.x, grid.y);
end

function FoundationBuildingCharacterAI:GetMoveGrid(x, y)
    local list = self.moves[y];
    if (list ~= nil) then
        return list[x];
    end
end

function FoundationBuildingCharacterAI:FindMoveGrid()
    local len = #self.paths;
    local current = self.paths[len];
    local list = {};
    local count = 0;

    local grid = self:GetMoveGrid(current.x, current.y - 1);
    if (grid ~= nil) then
        table.insert(list, grid);
        count = count + 1;
    end

    grid = self:GetMoveGrid(current.x + 1, current.y - 1);
    if (grid ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end

    grid = self:GetMoveGrid(current.x + 1, current.y);
    if (grid ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end

    grid = self:GetMoveGrid(current.x + 1, current.y + 1);
    if (grid ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end

    grid = self:GetMoveGrid(current.x, current.y + 1);
    if (grid ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end

    grid = self:GetMoveGrid(current.x - 1, current.y + 1);
    if (grid ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end

    grid = self:GetMoveGrid(current.x - 1, current.y);
    if (grid ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end

    grid = self:GetMoveGrid(current.x - 1, current.y - 1);
    if (grid ~= nil) then
        count = count + 1;
        table.insert(list, math.random(1, count), grid);
    end
    len = #list;
    if (len > 0) then
        for i = 1, len do
            grid = list[i];
            if (FoundationCharacterMgr.IsMoveGrid(grid.x, grid.y)) then
                if (not self:HasPathGrid(grid)) then
                    return grid;
                end
            end
        end


    end
    return nil;
end

function FoundationBuildingCharacterAI:AddPathGrid(grid)
    local len = #self.paths;
    if (len >= 2) then
        table.remove(self.paths, 1);
    end
    table.insert(self.paths, grid);
end

function FoundationBuildingCharacterAI:HasPathGrid(grid)
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

function FoundationBuildingCharacterAI:Clear()
    FoundationCharacterMgr.SetMoveGrid(self.gridX, self.gridY, 0);
    self.character = nil;
    self.container = nil;
    self.moves = nil;
    self.paths = nil;
    self.pos = nil;
    self.targetPos = nil;
    self.direction = nil;
    self.playComplete = nil;
end

function FoundationBuildingCharacterAI:Update()
    local time = os.time();
    if (time < self.aiTime) then return end
    
    local aiState = self.aiState;
    if (aiState == FoundationAIState.Move) then
        self:OnMove();
    elseif (aiState == FoundationAIState.Action) then
        
    elseif (aiState == FoundationAIState.Idle) then
        local rand = math.random(1, 100);
        if (rand > 90) then
            self:Play(self.actionMap.action);
            self.aiTime = time + 6;
            self.isIdle = false;
        elseif (rand > 30) then
            local grid = self:FindMoveGrid();
            if (grid ~= nil) then
                self:SetMoveGrid(grid);
                self:AddPathGrid(grid);
                local pos = FoundationMgr.GetGridPos(grid.x, grid.y);



                self.isIdle = false;
                self:Move(pos);
            end
        else
            if (not self.isIdle) then
                self.aiTime = time + math.random(2, 4);
                self.isIdle = true;
            end
        end
    end
end

function FoundationBuildingCharacterAI:SetMoveGrid(grid)
    FoundationCharacterMgr.SetMoveGrid(self.gridX, self.gridY, 0);
    self.gridX = grid.x;
    self.gridY = grid.y;
    FoundationCharacterMgr.SetMoveGrid(grid.x, grid.y, 1);
end

function FoundationBuildingCharacterAI:Play(aniName)
    self:PlayDir(aniName, false, self.playComplete);
    self.aiState = FoundationAIState.Action;
    local p = self.container.localPosition;
    local grid = FoundationMgr.GetPosGrid(p.x, p.z);
    self:SetMoveGrid(grid);
end

function FoundationBuildingCharacterAI:PlayDir(aniName, loop, complete)
    if (IsNullOrEmpty(aniName)) then return end
    aniName = aniName .. (self.isB and "_b" or "");
    if self.scaleX<0 and FoundationCharacterMgr.CheckCharacterRotation(self.character.characterId,self.character.skinId,aniName)  then
        self.scaleX=1;
    end
    self.character.character:Play(aniName, self.scaleX, loop, complete);
end

function FoundationBuildingCharacterAI:Move(targetPos)
    self.pos = self.container.localPosition;
    self.targetPos = targetPos;
    local p = self.pos - self.targetPos;
    self.direction = p.normalized;
    self.distance = p.magnitude;
    self.startTime = CS.UnityEngine.Time.realtimeSinceStartup;
    local time = self.distance * (1 / 0.7);
    self.endTime = self.startTime + time;
    local isB, scaleX = FoundationCharacterMgr.CalcAnimationDirection(p.x, p.z);
    self.isB = isB;
    self.scaleX = scaleX;
    self:PlayDir(self.actionMap.move, true, nil);
    self.aiState = FoundationAIState.Move;
end

function FoundationBuildingCharacterAI:OnMove()
    local time = CS.UnityEngine.Time.realtimeSinceStartup;
    if (time < self.endTime) then
        local moveDistance = (time - self.startTime) / (self.endTime - self.startTime) * self.distance;
        local p = self.pos - (self.direction * moveDistance);
        self.container.localPosition = p;
    else
        self.container.localPosition = self.targetPos;
        self:PlayDir(self.actionMap.idle, true, nil);
        self.aiState = FoundationAIState.Idle;
        self.aiTime = os.time() + math.random(0, 2);
    end
end