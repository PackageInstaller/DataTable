VoyageRichManCharacterItem = {};

VoyageRichManCharacterItem.__index = VoyageRichManCharacterItem;

local objs = {
    animator = { path = "", type = "UIAnimator" },
    head = { path = "Group/Head", type = "RawImage" },
    hpBar = { path = "Group/Hp/Bar", type = "Image" },
    hpText = { path = "Group/Hp/Text", type = "Text" },
}

function VoyageRichManCharacterItem.New(prefab, parent)
    local self = {};
    setmetatable(self, VoyageRichManCharacterItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject:GetComponent("RectTransform");
    UITool.Parse(self.gameObject, self, objs);
    self.pos = Vector2(0, 0);
    self.isLive = false;
    self.moveTween = nil;
    return self;
end

function VoyageRichManCharacterItem:SetData(data, index)
    self.data = data;
    self.isLive = true;
    self:Refresh();
    self.animator.AnimationName = "ani_VoyageRichManPanel_template_characterShow";
    self.pos.y = (1 - index) * 100;
    self.transform.anchoredPosition = self.pos;
    SetActive(self.gameObject, true);
end

function VoyageRichManCharacterItem:Refresh()
    local member = PlayerVoyageMgr.GetMember(self.data);
    if (member == nil) then return end
    
    if (member.IsActor) then
        local actorConfig = ConfigMgr.Config.actor[member.ID];
        if (actorConfig ~= nil) then
            local skinId = actorConfig.SkinParam;
            if (IsNullOrEmpty(skinId)) then
                skinId = actorConfig.CharacterId .. "001";
            end
            self.head.texture = GetCharacterTexture(actorConfig.CharacterId, skinId);
        end
    else
        local skinId = HeroManager.GetCharacterSkin(member.ID);
        self.head.texture = GetCharacterTexture(member.ID, skinId);
    end
    local ratio = member.HP / member.MaxHP;
    self.hpBar.fillAmount = ratio;
    local hpPercent = math.floor(ratio * 100);
    if (ratio > 0 and hpPercent == 0) then
        hpPercent = 1;
    end
    self.hpText.text = hpPercent .. "%";
end

function VoyageRichManCharacterItem:Hide()
    self.animator.AnimationName = "ani_VoyageRichManPanel_template_disappaer";
    self.isLive = false;
end

function VoyageRichManCharacterItem:Move()
    if (self.isLive) then
        local index = PlayerVoyageMgr.GetMemberIndex(self.data);
        if (index > 0) then
            local y = (1 - index) * 100;
            self:ClearMove();
            self.moveTween = self.transform:DOAnchorPosY(y, 0.5);
        end
    end
end

function VoyageRichManCharacterItem:ClearMove()
    if (self.moveTween ~= nil) then
        self.moveTween:Kill(false);
        self.moveTween = nil;
    end
end

function VoyageRichManCharacterItem:Clear()
    self:ClearMove();
    self.data = nil;
    self.isLive = false;
    self.head.texture = nil;
    SetActive(self.gameObject, false);
end

function VoyageRichManCharacterItem:Destroy()
    if (self.gameObject ~= nil) then
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil;
    end
end