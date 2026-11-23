


SSYXSceneCharacter = {}
SSYXSceneCharacter.__index = SSYXSceneCharacter

local objs = {
    characterSpine = {path = "", type = UITool.UISpineCharacter}
}

SSYXSceneCharacter.TransScale = {
    Vector3(-1, 1, 1),
    Vector3(1, 1, 1)
}

SSYXSceneCharacter.New = function(obj)

    local self = {}
    setmetatable(self, SSYXSceneCharacter)
    self.gameObject = obj
    self.transform = obj.transform
    self:Init()
    return self
end

function SSYXSceneCharacter:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function SSYXSceneCharacter:SetData(data)
    local characterId = data.CharacterId
    local characterCfg = ConfigMgr.Config.characterTable[characterId]
    self.pathPosDatas = data.PathPosDatas
    self.pathLength = data.PathLength
    self.characterSpine:SetBattle(characterId, characterId .. "001", "-1", characterCfg.job)
    self:SetLocalPos(self.pathPosDatas[1])
    local playAnimTween = DOTWeen:Sequence()
    local func = function()
        self.characterSpine:Play("house_move", true, nil)
    end
    playAnimTween:AppendInterval(0.5):OnComplete(func)
    self.playAnimTween = playAnimTween

    local time = self.pathLength / 33
    local pathLinePos = self.pathPosDatas
    local pathTweener = self.gameObject.transform:DOLocalPath(pathLinePos, time, PathType.Linear, CS.DG.Tweening.PathMode.Sidescroller2D)
    pathTweener:SetEase(Ease.Linear)
    pathTweener:SetLoops(-1)
    self.pathTweener = pathTweener

    self.lastLocalPosX = self.transform.localPosition.x
end

function SSYXSceneCharacter:OnUpdate()
    local curLocalPosX = self.transform.localPosition.x
    if curLocalPosX > self.lastLocalPosX then
        self.transform.localScale = SSYXSceneCharacter.TransScale[1]
    elseif curLocalPosX < self.lastLocalPosX then
        self.transform.localScale = SSYXSceneCharacter.TransScale[2]
    end
    self.lastLocalPosX = curLocalPosX
end

function SSYXSceneCharacter:SetParent(parent)
    self.gameObject.transform:SetParent(parent)
end

function SSYXSceneCharacter:SetLocalPos(pos)
    self.gameObject.transform.localPosition = pos
end

function SSYXSceneCharacter:ClearItems()
    if self.playAnimTween ~= nil then
        self.playAnimTween:Kill()
    end
    if self.pathTweener ~= nil then
        self.pathTweener:Kill()
    end
end

function SSYXSceneCharacter:Clear()
    self:ClearItems()
end

function SSYXSceneCharacter:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.characterSpine:Clear()
    self.gameObject = nil
end