HeroDragItem = {}
HeroDragItem.__index = HeroDragItem;

HeroDragItem.New = function(content, rectSize)
    local self = {};
    setmetatable(self, HeroDragItem);
    self.prefabPath = "Assets/_BundleResources/UI/Hero/HeroDragItem.prefab";
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath);
    LuaMgr.AddPrefabRefCount(self.prefabPath);
    self.transform = self.gameObject.transform;
    self.transform:SetParent(content, false);

    self.rectTransform = self.transform:GetComponent("RectTransform")
    self.animator = self.transform:GetComponent("Animator")
    self.animator.enabled = false

    self.characterId = ""
    self.color = UnityEngine.Color.white
    self.pos = Vector3.zero
    self.body = self.transform:Find("Body")
    self.drawingAdjustTool = self.body:GetComponent("DrawingAdjustTool");
    self.spineCharacter = self.body:GetComponent("UISpineCharacter");
    self.uiRefRawImage = self.body:GetComponent("RawImage");

    self.rectSize = rectSize / 3
    
    return self;
end

function HeroDragItem:SetData(characterId, ani,isAssistHero)
    if self.characterId == characterId then
        return
    end






    self.characterId = characterId
    self.animator.enabled = ani
    local curSkin=nil;
    if isAssistHero~=nil and isAssistHero then
        local assistHero=PlayerAssistMgr.GetCurAssist_CharacterData();
        if assistHero~=nil then
            curSkin=assistHero.curSkin;
        end
    end
    local path = HeroManager.SetCharacterDrawing(self.spineCharacter, characterId,curSkin);
    if (path ~= "") then
        self.spineCharacter:Clear()
        self.drawingAdjustTool.Sprite = path;
    end

    self.gameObject:SetActive(true)
end

local RemoveTween = function(self)
    if self.tween ~= nil then
        self.tween:Kill()
        self.tween = nil
    end
end

local SetCurrentAlpha = function(self)
    local posX = math.abs(self.rectTransform.localPosition.x - 0)
    local alpha = math.max(0, 1 - posX / self.rectSize)

    self.color.a = alpha
    self.uiRefRawImage.color = self.color
    self.spineCharacter.colorA = math.floor(alpha*255)
end

function HeroDragItem:SetPosition(p, time, cb)
    RemoveTween(self)
    self.pos.x = p.x
    self.pos.y = p.y
    if time > 0 then
        self.tween=DOTWeen.To(
                function() return self.rectTransform.localPosition  end,
                function(vector)
                    self.rectTransform.localPosition = vector
                    SetCurrentAlpha(self)
                end,
                self.pos,time):SetEase(Ease.OutSine);
        self.tween:OnComplete(function()
            if cb ~= nil then
                cb()
            end
        end)
    else
        self.rectTransform.localPosition = self.pos
        SetCurrentAlpha(self)
        if cb ~= nil then
            cb()
        end
    end



end

function HeroDragItem:Move(p)
    self.animator.enabled = false
    RemoveTween(self)
    local position = Vector3.zero
    position.x = p.x + self.pos.x
    position.y = self.pos.y
    self.rectTransform.localPosition = position
    SetCurrentAlpha(self)
end


function HeroDragItem:Clear()
    RemoveTween(self)
    self.spineCharacter:Clear()
    if (self.gameObject ~= nil) then
        LuaMgr.RemovePrefabRefCount(self.prefabPath);
        self.transform = nil;
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil;
    end
end