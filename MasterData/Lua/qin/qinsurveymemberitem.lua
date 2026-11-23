QinSurveyMemberItem = {};

QinSurveyMemberItem.__index = QinSurveyMemberItem;

local objs = {
    head = { path = "Head", type = "RawImage" },
    dead = { path = "Dead", type = "GameObject" },
    uiGray={path = "Head",type="UIGray"},
    job = { path = "Job/Icon", type = "Image" },
    level = { path = "Level/Text", type = "Text" },
    hpBar = { path = "Hp/Bar", type = "Image" },
    recoverEff = { path = "fx_huifu", type = "GameObject" },
    hurtEff = { path = "fx_shoushang", type = "GameObject" },
};

function QinSurveyMemberItem.New()
    local self = {};
    setmetatable(self, QinSurveyMemberItem);
    return self;
end

function QinSurveyMemberItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function QinSurveyMemberItem:GetId()
    return self.id
end

function QinSurveyMemberItem:SetData(data,isRefresh)
    local member = data.data;
    self.id = member.ID
    self.isRefresh = isRefresh
    local skinId = HeroManager.GetCharacterSkin(member.ID);
    self.head.texture = GetCharacterTexture(member.ID, skinId);
    local characterConfig = ConfigMgr.Config.characterTable[member.ID];
    if (characterConfig ~= nil) then
        self.job.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. characterConfig.job);
    end
    local characterData = DataMgr.Player.characters[member.ID];
    if (characterData ~= nil) then
        self.level.text = tostring(characterData.level);
    end
    local percent = member.HP / member.MaxHP;
    self.recoverEff:SetActive(false)
    self.hurtEff:SetActive(false)
    if(self.isRefresh)then    
        local m1 = math.floor(self.hpBar.fillAmount * 100)
        local m2 = math.floor(percent * 100)   
        if(member.HP > 0)then    
            if(m1 > m2)then
                self.hurtEff:SetActive(true)
            elseif(m1 <= m2)then
                self.recoverEff:SetActive(true)
            end
        end
    end
    self.uiGray.IsGray = member.HP <= 0
    SetActive(self.dead,member.HP <= 0)
    self.hpBar.fillAmount = percent;

    self.hpBar.color = ConfigQinMgr.GetHpColor(percent);
end

function QinSurveyMemberItem:Clear()
    self.head.texture = nil;
    self.job.sprite = nil;
    self.id = nil
end

function QinSurveyMemberItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end