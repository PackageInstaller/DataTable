QinSurveyMapItem = {};

QinSurveyMapItem.__index = QinSurveyMapItem;

local objs = {
    animator = { path = "", type = "Animator" },
    dissolveCtr = { path = "", type = "UIDissolveController" },
    button = { path = "", type = "Button" },
    bg = { path = "", type = "Image" },
    iconGO = { path = "Icon", type = "GameObject" },
    icon = { path = "Icon", type = "RawImage" },
    hpGO = { path = "Hp", type = "GameObject" },
    hpBar = { path = "Hp/Bar", type = "Image" },
    glowEffect = { path = "fx_glow", type = "GameObject" },
    loopRedEffect = { path = "fx_loop_red", type = "GameObject" },
    onceEffect = { path = "fx_once", type = "GameObject" },
    atk01Effect = { path = "fx_atk01", type = "GameObject" },
    atk02Effect = { path = "fx_atk02", type = "GameObject" },
    disEffect = { path = "fx_dis", type = "GameObject" },
    flyEffectTF = { path = "fx_fly", type = "Transform" },
    flyTrailEffect = { path = "fx_fly/trail", type = "GameObject" },
    flyHitEffect = { path = "fx_fly/trail_hit", type = "GameObject" },
    flyBoxEffect = { path = "fx_fly/EquipAttr_Eff_born", type = "GameObject" },
};

local effectEnum = {
    none = 0,
    dissolve = 1,
    glow = 2,
    loopRed = 3,
    once = 4,
    atk1 = 5,
    atk2 = 6,
    fly = 7,
}

function QinSurveyMapItem.New()
    local self = {};
    setmetatable(self, QinSurveyMapItem);
    return self;
end

function QinSurveyMapItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        local gridType = ConfigQinMgr.GetGridType(self.data.Typ);        
        if (self.data.State == QinSurveyState.Can) then
            AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DaQin/DQ_YP_06.mp3");
            PlayerQinMgr.Explore(self.data.Index);
            return;
        end
        if (self.data.State == QinSurveyState.Already) then
            local type = self.data.Typ;
            if (type == QinSurveyGrid.Monster or type == QinSurveyGrid.Boss) then
                local monster = PlayerQinMgr.GetMonster(self.data.Index);
                if (monster ~= nil and monster.MonsterHurt >= 10000) then
                    PlayerQinMgr.EnterLeaveDungeon(monster.MonsterId, self.data.Index);
                else
                    LuaMgr.ShowLuaPanel(UIName.QinSurveyResultViewModel, QinSurveyResultType.Battle, self.data);
                end
                return;
            end
            if (type == QinSurveyGrid.End and PlayerQinMgr.IsUnExplore()) then
                LuaMgr.ShowLuaPanel(UIName.QinSurveyResultViewModel, QinSurveyResultType.NextLayer, self.data);
                return;
            end
            local isBoom = type == QinSurveyGrid.Boom or type == QinSurveyGrid.Kill
            local isEffect = type == QinSurveyGrid.Buff
            local isRewrd = type == QinSurveyGrid.Draw or type == QinSurveyGrid.Box2
            if( isBoom or isEffect or isRewrd )then
                self:PlayEffect(effectEnum.fly)               
            else                
                PlayerQinMgr.Explore(self.data.Index);
            end
            AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DaQin/DQ_YP_12.mp3");
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function QinSurveyMapItem:SetData(data, isRefresh)
    self.button.enabled = true    
    if self.flyDoTween ~= nil and not isRefresh then
        self.flyDoTween.onComplete = nil
        self.flyDoTween:Kill()
        self.flyDoTween = nil
    end
    self.data = data.data;
    self.isRefresh = isRefresh
    self:PlayEffect(effectEnum.none)
    self:SetBg();
    self:SetType();
    self.oldState = self.data.State
end

function QinSurveyMapItem:SetBg()
    self.dissolveCtr.DissolveStep = 1
    local bg = "";
    local state = self.data.State;   
    if (state == QinSurveyState.Can) then
        bg = "ui_hd_dq_kc_gz2";
        if (self.oldState == QinSurveyState.Stop) then            
            self:PlayEffect(effectEnum.glow)
        end
    elseif (state == QinSurveyState.Already) then
        bg = "ui_hd_dq_kc_gz3";
        if (self.oldState == QinSurveyState.Can) then
            if (self.data.Typ == 0) then
                self:PlayEffect(effectEnum.dissolve)
            else
                self:PlayEffect(effectEnum.once)
            end
        end
    elseif (state == QinSurveyState.Stop) then
        bg = "ui_hd_dq_kc_gz1";
    elseif (state == QinSurveyState.Get) then
        bg = "ui_hd_dq_kc_gz3";
        if (self.oldState == QinSurveyState.Can) then
            self:PlayEffect(effectEnum.dissolve)
        end
    elseif (state == QinSurveyState.Lock) then
        bg = "ui_hd_dq_kc_gz4";
        self:PlayEffect(effectEnum.loopRed)
    end
    self.bg.sprite = LuaMgr.GetSprite("Qin", bg);
end

function QinSurveyMapItem:SetType()
    SetActive(self.hpGO, false);
    local type = self.data.Typ;
    local gridType = ConfigQinMgr.GetGridType(type);
    if (gridType == nil) then return end

    local itemId = "";
    if (type == QinSurveyGrid.Start) then
        itemId = gridType.ItemsID;
    elseif (self.data.State == QinSurveyState.Already) then
        itemId = gridType.ItemsID;
    end
    local effectType = 0
    if (itemId ~= "") then
        self.icon.texture = GetItemTexture(itemId);
        SetActive(self.iconGO, true);
        if (type == QinSurveyGrid.Monster or type == QinSurveyGrid.Boss) then
            local monster = PlayerQinMgr.GetMonster(self.data.Index);
            if (monster ~= nil) then
                local percent = (10000 - monster.MonsterHurt) * 0.0001;
                local cacheNumA = math.floor(percent * 10 )          
                local cacheNumB = math.floor(self.hpBar.fillAmount * 10 + 0.1)              
                if (cacheNumA ~= cacheNumB and self.isRefresh) then    
                    effectType = monster.HurtType
                    self:PlayEffect(effectEnum["atk" .. effectType])
                end
                self.hpBar.fillAmount = percent;
                self.hpBar.color = ConfigQinMgr.GetHpColor(percent);
                SetActive(self.hpGO, true);
            end
        end
    else
        SetActive(self.iconGO, false);
    end
end

function QinSurveyMapItem:PlayEffect(effectType)
    self.glowEffect:SetActive(false)
    self.loopRedEffect:SetActive(false)
    self.onceEffect:SetActive(false)
    self.atk01Effect:SetActive(false)
    self.atk02Effect:SetActive(false)
    self.disEffect:SetActive(false)    
    self.animator.enabled = false

    if (effectType == effectEnum.dissolve) then
        self.disEffect:SetActive(true)        
    elseif (effectType == effectEnum.glow) then
        self.glowEffect:SetActive(true)
    elseif (effectType == effectEnum.loopRed) then
        self.loopRedEffect:SetActive(true)
    elseif (effectType == effectEnum.atk1) then
        self.atk01Effect:SetActive(true)
    elseif (effectType == effectEnum.atk2) then
        self.atk02Effect:SetActive(true)
    elseif (effectType == effectEnum.once) then
        self.onceEffect:SetActive(true)
    elseif (effectType == effectEnum.fly) then
        self.flyEffectTF.localPosition = Vector3.zero 
        self.flyTrailEffect:SetActive(false)
        self.flyHitEffect:SetActive(false)
        self.flyBoxEffect:SetActive(false)
        self.flyTrailEffect:SetActive(true)
        self.button.enabled = false
        if self.startDelay ~= nil then
            coroutine_runner.stop(self.startDelay)
            self.startDelay = nil
        end
        self.startDelay = coroutine_runner.start(function()
            coroutine_runner.wait(0.1) 
            local startPos = self.flyEffectTF.position      
            local endPos = nil
            if self.data.Typ == QinSurveyGrid.Boom or self.data.Typ == QinSurveyGrid.Kill then                
                endPos = PlayerQinMgr.GetEffectFlyPos("attack")
            elseif self.data.Typ == QinSurveyGrid.Draw or self.data.Typ == QinSurveyGrid.Box2 then               
                endPos = PlayerQinMgr.GetEffectFlyPos("reward")
            else
                endPos = PlayerQinMgr.GetEffectFlyPos("effect")
            end               
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/Mission_LightFly.mp3")
            self.flyDoTween = DOTWeen.To(function() return startPos end,
                function(vector)
                    self.flyEffectTF.position = vector  
                end, endPos, 0.3):SetEase(Ease.InSine)
            self.flyDoTween.onComplete = function()                
                SetActive(self.flyTrailEffect, false)
                SetActive(self.flyHitEffect, true)  
                if(self.data.Typ == QinSurveyGrid.Buff)then
                    self.flyBoxEffect:SetActive(true)
                end            
                PlayerQinMgr.Explore(self.data.Index);                
                self.button.enabled = true
            end         
        end)
    end
end

function QinSurveyMapItem:Clear()
    self.data = nil;
    self.icon.texture = nil;
    self.oldState = nil     
    if self.startDelay ~= nil then
        coroutine_runner.stop(self.startDelay)
        self.startDelay = nil
    end      
    if self.flyDoTween ~= nil then
        self.flyDoTween.onComplete = nil
        self.flyDoTween:Kill()
        self.flyDoTween = nil
    end 
end

function QinSurveyMapItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end