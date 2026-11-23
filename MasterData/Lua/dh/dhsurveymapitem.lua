DHSurveyMapItem = {};

DHSurveyMapItem.__index = DHSurveyMapItem;

local objs = {
    animator = { path = "", type = "Animator" },
    dissolveCtr = { path = "", type = "UIDissolveController" },
    button = { path = "", type = "Button" },
    bg = { path = "", type = "Image" },
    iconGO = { path = "Icon", type = "GameObject" },
    icon = { path = "Icon", type = "RawImage" },
    hpGO = { path = "Hp", type = "GameObject" },
    hpText = { path = "Hp/TextHp", type = "Text" },
    ackShow = { path = "AckShow", type = "Text" },
    ackGO = { path = "Ack", type = "GameObject" },
    textAck = { path = "Ack/TextAck", type = "Text" },
    glowEffect = { path = "fx_glow", type = "GameObject" },
    loopRedEffect = { path = "fx_loop_red", type = "GameObject" },
    loopYellowEffect = { path = "fx_loop_yellow", type = "GameObject" },
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
    loopYellow = 8,
}

local msgTable = {
    [1] = 22402,
    [2] = 22409,
    [3] = 22410,
    [4] = 22411,
    [5] = 22412,
    [6] = 22413,
    [7] = 22414,
    [8] = 22415,
    [10] = 22416,
    [11] = 22417,
    [12] = 22418,
    [13] = 22419,
    [14] = 22420,
    [15] = 22421,
    [16] = 22422,
}

function DHSurveyMapItem.New()
    local self = {};
    setmetatable(self, DHSurveyMapItem);
    return self;
end

function DHSurveyMapItem:CheckCanUseToolsOnMonster(toolsType, monsterType)
    if (toolsType.UseType ~= nil) then
        local canAct = false
        for k, v in pairs(toolsType.UseType) do
            if (v == monsterType) then
                canAct = true
                break
            end
        end
        if (not canAct) then            
            return false
        end
    end
    return true
end

function DHSurveyMapItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        local type = self.data.Typ;
        if (self.data.State == DHSurveyState.Already) then
            if (type == DHSurveyGrid.Monster or type == DHSurveyGrid.Monster1 or type == DHSurveyGrid.Monster2 or type == DHSurveyGrid.Boss) then                
                if (self.ackMonsterType ~= nil) then                  
                    if self.startDelay2 ~= nil then
                        coroutine_runner.stop(self.startDelay2)
                        self.startDelay2 = nil
                    end                    
                    self.startDelay2 = coroutine_runner.start(function()
                        local toolsType = ConfigDHMgr.GetGridType(self.ackMonsterType);
                        if not self:CheckCanUseToolsOnMonster(toolsType, type) then
                            LuaMgr.InvokeUIEventListeners(UIEventConst.DHMsgShow, 22423)
                            return
                        end                        
                        if (self.ackMonsterType == DHSurveyGrid.Kill) then
                            self:PlayEffect(effectEnum.atk2)

                            AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_06.mp3");
                        elseif (self.ackMonsterType == DHSurveyGrid.Boom) then
                            self:PlayEffect(effectEnum.atk1)
                            if (type == DHSurveyGrid.Boss) then
                                self.ackShow.text = "b+" .. toolsType.BossHurt[1]
                            else
                                self.ackShow.text = "b+" .. toolsType.MonsterHurt[1]
                            end
                            AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_05.mp3");
                        end
                        self.button.enabled = false
                        coroutine_runner.wait(0.5)
                        PlayerDHMgr.UseTools(toolsType.ItemsID, self.data.Index);
                        PlayerDHMgr.SetAckMonsterType(nil)
                        coroutine_runner.wait(0.2)
                        self.button.enabled = true
                        self.ackShow.text = ""
                    end)
                    return
                else
                    self:PlayEffect(effectEnum.once)
                    local dh = DataMgr.Player.DunHuang;
                    self:SetAckShow(dh.Ack)
                    PlayerDHMgr.Battle(self.data.Index)
                    AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_09.mp3");
                    self:ShowTypeMessage(type)
                    return;
                end
                self.animator.enabled = false
                self.animator.enabled = true
            end
        end

        if (self.ackMonsterType ~= nil) then
            LuaMgr.InvokeUIEventListeners(UIEventConst.DHMsgShow, 22423)
            return
        end
        if (self.data.State == DHSurveyState.Get or self.data.State == DHSurveyState.Already) then
            self:ShowTypeMessage(type)
        end
        if (self.data.State == DHSurveyState.Can) then
            AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_02.mp3");
            PlayerDHMgr.Explore(self.data.Index);
            local gridType = ConfigDHMgr.GetGridType(DHSurveyGrid.Step);
            if (gridType ~= nil) then
                local itemCount = PlayerDHMgr.GetToolsCount(gridType.ItemsID);
                if (itemCount <= 0) then
                    LuaMgr.InvokeUIEventListeners(UIEventConst.DHMsgShow, 22405)
                end
            end
            return;
        end
        if (self.data.State == DHSurveyState.Already) then
            if (type == DHSurveyGrid.End and PlayerDHMgr.IsUnExplore()) then
                LuaMgr.ShowLuaPanel(UIName.DHSurveyResultViewModel, DHSurveyResultType.NextLayer, self.data);
                return;
            end
            local isBoom = type == DHSurveyGrid.Boom or type == DHSurveyGrid.Kill
            local isEffect = type == DHSurveyGrid.Sacrifice or type == DHSurveyGrid
                .Critical
            local isRewrd = type == DHSurveyGrid.Box2 or type == DHSurveyGrid.Box
            if (isBoom or isEffect or isRewrd) then
                self:PlayEffect(effectEnum.fly)
            else
                PlayerDHMgr.Explore(self.data.Index);
            end
            AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_08.mp3");
        elseif (self.data.State == DHSurveyState.Stop) then
            LuaMgr.InvokeUIEventListeners(UIEventConst.DHMsgShow, 22403)
        elseif (self.data.State == DHSurveyState.Lock) then
            LuaMgr.InvokeUIEventListeners(UIEventConst.DHMsgShow, 22404)
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function DHSurveyMapItem:SetData(data, isRefresh)
    self.button.enabled = true
    if self.flyDoTween ~= nil and not isRefresh then
        self.flyDoTween.onComplete = nil
        self.flyDoTween:Kill()
        self.flyDoTween = nil
    end
    self.ackShow.text = ""
    self.data = data.data;
    self.isRefresh = isRefresh
    self.ackMonsterType = PlayerDHMgr.GetAckMonsterType()
    self:PlayEffect(effectEnum.none)
    self:SetBg();
    self:SetType();
    self.oldState = self.data.State
end

function DHSurveyMapItem:SetBg()
    self.dissolveCtr.DissolveStep = 1
    local bg = "";
    local state = self.data.State;
    if (state == DHSurveyState.Can) then
        bg = "ui_hd_dh_ch_dk_2";
        if (self.oldState == DHSurveyState.Stop) then
            self:PlayEffect(effectEnum.glow)
        end
    elseif (state == DHSurveyState.Already) then
        bg = "ui_hd_dh_ch_dk_3";
        if (self.oldState == DHSurveyState.Can) then
            if (self.data.Typ == 0) then
                self:PlayEffect(effectEnum.dissolve)
            else
                self:PlayEffect(effectEnum.once)
            end
        end
    elseif (state == DHSurveyState.Stop) then
        bg = "ui_hd_dh_ch_dk_1";
    elseif (state == DHSurveyState.Get) then
        bg = "ui_hd_dh_ch_dk_3";
        if (self.oldState == DHSurveyState.Can) then
            self:PlayEffect(effectEnum.dissolve)
        end
    elseif (state == DHSurveyState.Lock) then
        bg = "ui_hd_dh_ch_dk_4";
        self:PlayEffect(effectEnum.loopRed)
    end
    self.bg.sprite = LuaMgr.GetSprite("DunHuang", bg);
end

function DHSurveyMapItem:SetType()
    SetActive(self.hpGO, false);
    SetActive(self.ackGO, false);
    local type = self.data.Typ;
    local gridType = ConfigDHMgr.GetGridType(type);
    if (gridType == nil) then return end

    local itemId = "";
    if (type == DHSurveyGrid.Start) then
        itemId = gridType.ItemsID;
    elseif (self.data.State == DHSurveyState.Already) then
        itemId = gridType.ItemsID;
    end
    local effectType = 0
    if (itemId ~= "") then
        self.icon.texture = GetItemTexture(itemId);
        SetActive(self.iconGO, true);
        if (type == DHSurveyGrid.Monster or type == DHSurveyGrid.Monster1 or type == DHSurveyGrid.Monster2 or type == DHSurveyGrid.Boss) then
            local monster = PlayerDHMgr.GetMonster(self.data.Index);
            if (monster ~= nil) then
                self.hpText.text = monster.Hp
                self.textAck.text = monster.Ack
                SetActive(self.hpGO, true);
                SetActive(self.ackGO, true);
                if (self.ackMonsterType ~= nil) then
                    local toolsType = ConfigDHMgr.GetGridType(self.ackMonsterType);
                    if self:CheckCanUseToolsOnMonster(toolsType, type) then
                        self:PlayEffect(effectEnum.loopYellow)
                    end   
                end
            end
        end
    else
        SetActive(self.iconGO, false);
    end
end

function DHSurveyMapItem:SetAckShow(num)
    if self.startDelay2 ~= nil then
        coroutine_runner.stop(self.startDelay2)
        self.startDelay2 = nil
    end
    self.startDelay2 = coroutine_runner.start(function()
        self.ackShow.text = "b+" .. num
        coroutine_runner.wait(1)
        self.ackShow.text = ""
    end)
end

function DHSurveyMapItem:PlayEffect(effectType)
    self.glowEffect:SetActive(false)
    self.loopRedEffect:SetActive(false)
    self.loopYellowEffect:SetActive(false)
    self.onceEffect:SetActive(false)
    self.atk01Effect:SetActive(false)
    self.atk02Effect:SetActive(false)
    self.disEffect:SetActive(false)

    if (effectType == effectEnum.dissolve) then
        self.disEffect:SetActive(true)
    elseif (effectType == effectEnum.glow) then
        self.glowEffect:SetActive(true)
    elseif (effectType == effectEnum.loopRed) then
        self.loopRedEffect:SetActive(true)
    elseif (effectType == effectEnum.loopYellow) then
        self.loopYellowEffect:SetActive(true)
    elseif (effectType == effectEnum.atk1) then
        self.atk01Effect:SetActive(true)
    elseif (effectType == effectEnum.atk2) then
        self.atk02Effect:SetActive(true)
    elseif (effectType == effectEnum.once) then
        self.onceEffect:SetActive(true)
    elseif (effectType == effectEnum.fly) then
        self.flyEffectTF.localPosition = Vector3.zero
        self.flyEffectTF.gameObject:SetActive(true)
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
            if self.data.Typ == DHSurveyGrid.Box2 or self.data.Typ == DHSurveyGrid.Box then
                endPos = PlayerDHMgr.GetEffectFlyPos("reward")
            else
                endPos = PlayerDHMgr.GetEffectFlyPos("attack")
            end
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/Mission_LightFly.mp3")
            self.flyDoTween = DOTWeen.To(function() return startPos end,
                function(vector)
                    self.flyEffectTF.position = vector
                end, endPos, 0.3):SetEase(Ease.InSine)
            self.flyDoTween.onComplete = function()
                SetActive(self.flyTrailEffect, false)
                SetActive(self.flyHitEffect, true)



                PlayerDHMgr.SetSpecialExploreType(self.data.Typ)
                PlayerDHMgr.Explore(self.data.Index);
                self.button.enabled = true
            end
        end)
    end
end

function DHSurveyMapItem:Clear()
    self.data = nil;
    self.icon.texture = nil;
    self.oldState = nil
    self.hpText.text = ""
    self.textAck.text = ""
    if self.startDelay ~= nil then
        coroutine_runner.stop(self.startDelay)
        self.startDelay = nil
    end
    if self.startDelay2 ~= nil then
        coroutine_runner.stop(self.startDelay2)
        self.startDelay2 = nil
    end
    if self.flyDoTween ~= nil then
        self.flyDoTween.onComplete = nil
        self.flyDoTween:Kill()
        self.flyDoTween = nil
    end
end

function DHSurveyMapItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end


function DHSurveyMapItem:ShowTypeMessage(type)
    local msgId = msgTable[type]
    if (msgId ~= nil) then
        LuaMgr.InvokeUIEventListeners(UIEventConst.DHMsgShow, msgId)
    end
end