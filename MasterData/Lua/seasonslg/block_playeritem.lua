
Block_PlayerItem = {};

Block_PlayerItem.__index = Block_PlayerItem;
local objs = {
    uiSpineCharacter = { path = "root/spine", type = "UISpineCharacter" },
    spineRender={ path = "root/spine", type = "RawImage" },
    txtGuild={ path = "root/guildLable/guild", type = "Text" },
    txtName={ path = "root/nameLable/name", type = "Text" },
    tranGuildLable={ path = "root/guildLable", type = "Transform" },
    tranNameLable={ path = "root/nameLable", type = "Transform" },
    goMySelf={ path = "root/my", type = "GameObject" },
    canvasGroup={ path = "root", type = "CanvasGroup" },
    meshGradient={ path = "root/nameLable/name", type = "MeshGradient" },
    Outline={ path = "root/nameLable/name", type = "Outline" },
};

function Block_PlayerItem.New(parent)
    local self = {};
    setmetatable(self, Block_PlayerItem);
    self.parent=parent;
    self.prefabPath = "Assets/_BundleResources/UI/SeasonSLG/PlayerItem.prefab"
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath)
    self.transform=self.gameObject.transform;
    self.transform:SetParent(parent,false);
    self.transform.localScale=Vector3.one;
    self.AI=Block_PlayerAI.New(self.transform);
    self:Init();
    return self;
end

function Block_PlayerItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end





function Block_PlayerItem:SetData(data)
    self.isReturn=false;
    if self.data~=nil and self.data.characterId==data.characterId and self.gameObject.activeInHierarchy then
        self.isReturn=true;
        return;
    end
    self.data=data;
    SetActive(self.gameObject,true);
    SetActive(self.uiSpineCharacter.gameObject,true);
    SetActive(self.goMySelf,self.data.isMySelf)
    local spineSkinId=self.data.skinId
    if IsNullOrEmpty(self.data.characterId) then
        self.data.characterId="SCJ201";
    end
    if string.match(self.data.characterId,"SCJ") then
        if not self.data.isMySelf and  SeasonSLGMapMgr.isRandomOtherPlayer then
            self.data.characterId=SeasonSLGMapMgr.RandomCharacterId()
        else
            if self.data.characterId=="SCJ205" or self.data.characterId=="SCJ101" then
                self.data.characterId="SCJ201"
            elseif self.data.characterId=="SCJ206" or self.data.characterId=="SCJ102" then
                self.data.characterId="SCJ202"
            end
        end
    end
    if IsNullOrEmpty(spineSkinId) then
        spineSkinId=self.data.characterId.."001";
    end
    local renderTex=nil;
    if renderTex==nil then
        renderTex=self.uiSpineCharacter:SetBattle2(self.data.characterId,spineSkinId,"-1",0);




    else
        self.spineRender.texture=renderTex.texture;
    end
    if not self.data.isMySelf then
        self.AI:Clear();
        self.AI:SetData(self.data.gridId,self.uiSpineCharacter,self.data.characterId);
    end
    self.meshGradient.enabled=self.data.isPay
    self.Outline.enabled=self.data.isPay
    self.txtName.text=self.data.playerName;
    self.tranNameLable.sizeDelta=Vector2(self.txtName.preferredWidth+30,40)
    if IsNullOrEmpty(self.data.guildName) then
        SetActive(self.txtGuild.transform.parent.gameObject,false);
        return;
    end
    SetActive(self.txtGuild.transform.parent.gameObject,true);
    self.txtGuild.text=self.data.guildName;
    self.tranGuildLable.sizeDelta=Vector2(self.txtGuild.preferredWidth+30,40);
end

function Block_PlayerItem:DOFade(delay)
    if self.isReturn then return end;
    delay=delay==nil and 0 or delay;
    self.canvasGroup.alpha=0.0;
    DOTWeen.To(function() return 0.0  end,function(alpha)
        self.canvasGroup.alpha=alpha;
    end,1,1).SetDelay(delay);
end

function Block_PlayerItem:Clear()
    self.data=nil;
    self.AI:Clear()
    self.uiSpineCharacter:Clear();
    SetActive(self.uiSpineCharacter.gameObject,false);
    SetActive(self.gameObject,false);
end

function Block_PlayerItem:Destroy()

    self.AI:Destroy();
    self.AI=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end