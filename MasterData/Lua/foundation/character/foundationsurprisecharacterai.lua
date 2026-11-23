FoundationSurpriseCharacterAI = {}

FoundationSurpriseCharacterAI.__index = FoundationSurpriseCharacterAI

FoundationSurpriseCharacterAI.New = function()
    local self = {}
    setmetatable(self, FoundationSurpriseCharacterAI)
    self.container = nil
    self.character = nil
    self.data = nil
    self.aiState = 0
    self.aiTime = 0
    self.isB = false
    self.scaleX = 1
    self.isClick = false
    self.package = nil
    self.packagePos = Vector3.zero
    self.moveIndex = 1
    self.playComplete = function(aniName)
        self:PlayDir(self.data.Action[1][1], true, nil)
        self:SetAction(1)
        self.aiTime = os.time() + math.random(6, 10)
    end
    return self
end

function FoundationSurpriseCharacterAI:SetData(container, grid, moves, data)
    self.data = data
    self.container = container.transform
    self.character = container.character
    self.scaleX = data.Direction
    self.aiTime = os.time() + math.random(6, 10)
    self.container.localPosition = grid
    self:PlayDir(data.Action[1][1], true, nil)
    self:SetBox(data.Boxs)
    self:SetAction(1)
end

function FoundationSurpriseCharacterAI:Clear()
    self.container = nil
    self.character = nil
    self.data = nil
    self.playComplete = nil
    self.package = nil
    self.packagePos = nil
end

function FoundationSurpriseCharacterAI:Update()
    if (self.aiState == FoundationAIState.Move) then
        self:OnMove()
    else
        local time = os.time()
        if (time < self.aiTime) then
            return
        end

        local aiState = self.aiState
        if (aiState == FoundationAIState.Action) then
        elseif (aiState == FoundationAIState.Idle) then
            local rand = math.random(1, 100)
            if (rand > 50) then
                self:PlayDir(self.data.Action[2][1], false, self.playComplete)
                self:SetAction(2)
                self.aiTime = time + 8
            else
                self.aiTime = time + math.random(6, 8)
            end
        end
    end
end

function FoundationSurpriseCharacterAI:PlayDir(aniName, loop, complete)
    if (IsObjectNull(self.character)) then
        return
    end
    if (IsNullOrEmpty(aniName)) then
        return
    end

    aniName = aniName .. (self.isB and "_b" or "")
    self.character:Play(aniName, self.scaleX, loop, complete)
end

function FoundationSurpriseCharacterAI:SetAction(index)
    self.isClick = self.data.Action[index][2] == "1"
    self.aiState = index == 1 and FoundationAIState.Idle or FoundationAIState.Action
end

function FoundationSurpriseCharacterAI:SetBox(boxs)
    if (#boxs == 6) then
        local box = self.container:GetComponent("BoxCollider")
        local center = Vector3(boxs[1], boxs[2], boxs[3])
        local size = Vector3(boxs[4], boxs[5], boxs[6])
        LuaMgr.SetBoxCollider(box, center, size)
    end
end

function FoundationSurpriseCharacterAI:Move(targetPos, endCallback)
    if endCallback ~= nil then
        self.MoveCallback = endCallback
    end
    self.pos = self.container.localPosition
    self.targetPos = targetPos
    local p = self.pos - self.targetPos
    self.direction = p.normalized
    self.distance = p.magnitude
    self.startTime = CS.UnityEngine.Time.realtimeSinceStartup
    local time = self.distance
    self.endTime = self.startTime + time
    local isB, scaleX = FoundationCharacterMgr.CalcAnimationDirection(p.x, p.z)
    self.isB = isB
    self.scaleX = scaleX
    if self.aiState ~= FoundationAIState.Move then
        self:PlayDir(self.data.Action[3][1], true, nil)
        self.aiState = FoundationAIState.Move
    end
end

function FoundationSurpriseCharacterAI:OnMove()
    local time = CS.UnityEngine.Time.realtimeSinceStartup
    if (time < self.endTime) then
        local moveDistance = (time - self.startTime) / (self.endTime - self.startTime) * self.distance
        local p = self.pos - (self.direction * moveDistance)
        self.container.localPosition = p
        self:Move(self.targetPos)
    else
        self.container.localPosition = self.targetPos
        self:PlayDir(self.data.Action[1][1], true, nil)
        self.aiState = FoundationAIState.Idle
        print(self.MoveCallback)
        if self.MoveCallback ~= nil then
            self.MoveCallback(self.container)
        end
    end
end