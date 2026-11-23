QinMapItem = {};

QinMapItem.__index = QinMapItem;

local objs = {
    aniRoot = { path = "Country", type = "Animator" },
    qinBtn = { path = "Qin", type = "Button" },
    chuBtn = { path = "Chu", type = "Button" },
    chuUnify = { path = "Chu/Unify", type = "GameObject" },
    hanBtn = { path = "Han", type = "Button" },
    hanUnify = { path = "Han/Unify", type = "GameObject" },
    qiBtn = { path = "Qi", type = "Button" },
    qiUnify = { path = "Qi/Unify", type = "GameObject" },
    weiBtn = { path = "Wei", type = "Button" },
    weiUnify = { path = "Wei/Unify", type = "GameObject" },
    yanBtn = { path = "Yan", type = "Button" },
    yanUnify = { path = "Yan/Unify", type = "GameObject" },
    zhaoBtn = { path = "Zhao", type = "Button" },
    zhaoUnify = { path = "Zhao/Unify", type = "GameObject" },
    countryChuGO = { path = "Country/Chu", type = "GameObject" },
    countryChuBtn = { path = "Country/Chu", type = "Button" },
    countryHanGO = { path = "Country/Han", type = "GameObject" },
    countryHanBtn = { path = "Country/Han", type = "Button" },
    countryQiGO = { path = "Country/Qi", type = "GameObject" },
    countryQiBtn = { path = "Country/Qi", type = "Button" },
    countryWeiGO = { path = "Country/Wei", type = "GameObject" },
    countryWeiBtn = { path = "Country/Wei", type = "Button" },
    countryYanGO = { path = "Country/Yan", type = "GameObject" },
    countryYanBtn = { path = "Country/Yan", type = "Button" },
    countryZhaoGO = { path = "Country/Zhao", type = "GameObject" },
    countryZhaoBtn = { path = "Country/Zhao", type = "Button" },
    countryQinBtn = { path = "Country/Qin", type = "Button" },
    countryQinGO = { path = "Country/Qin", type = "GameObject" },
    countryQinBigGO = { path = "Country/QinBig", type = "GameObject" },
    carTF = { path = "CarBox", type = "Transform" },
};

function QinMapItem.New(parent)
    local self = {};
    setmetatable(self, QinMapItem);
    self.path = "Assets/_BundleResources/UI/Qin/QinMapItem.prefab";
    self.gameObject = LuaMgr.GetPrefab(self.path);
    self.transform = self.gameObject.transform;
    LuaMgr.AddPrefabRefCount(self.path);
    self.transform:SetParent(parent, false);
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickChu = function()
        LuaMgr.ShowLuaPanel(UIName.QinBattleViewModel, false, 4);
    end
    self.OnClickHan = function()
        LuaMgr.ShowLuaPanel(UIName.QinBattleViewModel, false, 1);
    end
    self.OnClickQi = function()
        LuaMgr.ShowLuaPanel(UIName.QinBattleViewModel, false, 6);
    end
    self.OnClickWei = function()
        LuaMgr.ShowLuaPanel(UIName.QinBattleViewModel, false, 3);
    end
    self.OnClickYan = function()
        LuaMgr.ShowLuaPanel(UIName.QinBattleViewModel, false, 5);
    end
    self.OnClickZhao = function()
        LuaMgr.ShowLuaPanel(UIName.QinBattleViewModel, false, 2);
    end
    self.OnClickQin = function ()
        local cache = {}
        cache.tipslan = ConfigMgr.LangGlobal("10435")
        cache.descriptionlan = ConfigMgr.LangGlobal("10436")
        LuaMgr.ShowLuaPanel(UIName.QinResultViewModel,cache,true);
    end
    LuaMgr.AddClick(self.qinBtn, self.OnClickQin);
    LuaMgr.AddClick(self.chuBtn, self.OnClickChu);
    LuaMgr.AddClick(self.hanBtn, self.OnClickHan);
    LuaMgr.AddClick(self.qiBtn, self.OnClickQi);
    LuaMgr.AddClick(self.weiBtn, self.OnClickWei);
    LuaMgr.AddClick(self.yanBtn, self.OnClickYan);
    LuaMgr.AddClick(self.zhaoBtn, self.OnClickZhao);
    LuaMgr.AddClick(self.countryQinBtn, self.OnClickQin);
    LuaMgr.AddClick(self.countryChuBtn, self.OnClickChu);
    LuaMgr.AddClick(self.countryHanBtn, self.OnClickHan);
    LuaMgr.AddClick(self.countryQiBtn, self.OnClickQi);
    LuaMgr.AddClick(self.countryWeiBtn, self.OnClickWei);
    LuaMgr.AddClick(self.countryYanBtn, self.OnClickYan);
    LuaMgr.AddClick(self.countryZhaoBtn, self.OnClickZhao);
    return self;
end

function QinMapItem:SetData(data)  
    local questEvent = ConfigMgr.Config.questEvent;   
    local questEvents = DataExHelper.Check_DataExByGroupId(222);
    if(data ~= nil)then
        questEvents = data
    end
    self.aniRoot.enabled = PlayerQinMgr.GetPlayAudio()
    local len = #questEvents;
    local num = 0
    local num2 = 0
    local minNum = 6
    local maxNum = 0
    local cacheObj = nil
    local cacheObj2 = nil
    local carMove = false
    local savaStr = nil
    self.carTF.position = self.countryHanGO.transform.position
    for i = 1, len do
        local questData = questEvents[i];
        local questConfig = questEvent[questData.id];
        if (#questConfig.special > 0 and questConfig.special[1] == "mainTask") then
            num2 = num2 + 1
            local finish = questData.state == 2 or questData.state == 3    
            local countryNum = tonumber(questConfig.special[2])       
            local obj,unityObj = self:SetCountryStatus(finish, questConfig.special[2]);
            local strCache = DataMgr.Player.uid.."destroyCountry"..questData.id
            if(countryNum <= minNum and questData.state == 1)then 
                savaStr = strCache   
                minNum = countryNum 
                cacheObj = obj   
            end  
            if(finish)then                
                local state = PlayerPrefs.GetInt(strCache,0);                 
                if(state == 0)then
                    if(PlayerQinMgr.GetPlayDissolve())then
                        PlayerQinMgr.SetPlayDissolve(false)
                        PlayerPrefs.SetInt(strCache,1); 
                        unityObj.transform:GetChild(0).gameObject:SetActive(true)
                        carMove = true
                        cacheObj2 = obj 
                    end
                else                    
                    unityObj.transform:GetChild(0).gameObject:SetActive(false)
                end 
                num = num + 1
                if(countryNum >= maxNum and cacheObj2 == nil)then 
                    maxNum = countryNum                    
                    cacheObj2 = obj           
                end
            end 
        end
    end
    if(cacheObj ~= nil)then
        self.carTF.gameObject:SetActive(true)       
        if(carMove)then
            self.carTF.position = cacheObj2.transform.position
            if self.tweener ~= nil then
                self.tweener:Kill()
                self.tweener = nil;
            end           
            self.tweener = DOTWeen.To(function() return self.carTF.position end,
            function(vector) self.carTF.position = vector end, cacheObj.transform.position, 1.5)
        else
            local state = false
            if(savaStr ~= nil)then
                state = PlayerPrefs.GetInt(savaStr,0) == 0;            
            end           
            if(state)then
                self.carTF.position = cacheObj.transform.position
            else
                if(cacheObj2 == nil)then
                    self.carTF.position = cacheObj.transform.position
                else
                    self.carTF.position = cacheObj2.transform.position        
                end           
            end
        end        
    else
        self.carTF.gameObject:SetActive(false)
    end
    local index = PlayerPrefs.GetInt(DataMgr.Player.uid.."qinUnity",0);    
    if(num == num2)then 
        SetActive(self.countryQinGO, false);
        SetActive(self.countryQinBigGO, false);      
        if(index == 0)then
            PlayerPrefs.SetInt(DataMgr.Player.uid.."qinUnity",1);          
        end
        if(index == 2 or index == 3)then
            PlayerPrefs.SetInt(DataMgr.Player.uid.."qinUnity",3);            
            SetActive(self.countryQinGO, false);
            SetActive(self.countryQinBigGO, true);          
        end
    else
        SetActive(self.countryQinGO, true);
        SetActive(self.countryQinBigGO, false);
    end    
end

function QinMapItem:SetCountryStatus(status, country)
if (country == "1") then
        SetActive(self.hanUnify, status);
        SetActive(self.countryHanGO, not status);
        self.hanBtn.enabled = not status 
        self.countryHanBtn.enabled = not status 
        return self.countryHanGO,self.hanUnify   
elseif (country == "2") then
        SetActive(self.zhaoUnify, status);
        SetActive(self.countryZhaoGO, not status); 
        self.zhaoBtn.enabled = not status         
        self.countryZhaoBtn.enabled = not status  
        return self.countryZhaoGO,self.zhaoUnify         
elseif (country == "3") then
        SetActive(self.weiUnify, status);
        SetActive(self.countryWeiGO, not status);    
        self.weiBtn.enabled = not status        
        self.countryWeiBtn.enabled = not status    
        return self.countryWeiGO,self.weiUnify     
elseif (country == "4") then
        SetActive(self.chuUnify, status);
        SetActive(self.countryChuGO, not status);  
        self.chuBtn.enabled = not status       
        self.countryChuBtn.enabled = not status  
        return self.countryChuGO,self.chuUnify      
elseif (country == "5") then
        SetActive(self.yanUnify, status);
        SetActive(self.countryYanGO, not status); 
        self.yanBtn.enabled = not status        
        self.countryYanBtn.enabled = not status  
        return self.countryYanGO,self.yanUnify      
elseif (country == "6") then
        SetActive(self.qiUnify, status);
        SetActive(self.countryQiGO, not status);
        self.qiBtn.enabled = not status 
        self.countryQiBtn.enabled = not status 
        return self.countryQiGO,self.qiUnify            
    end
end

function QinMapItem:Clear()
    if self.tweener ~= nil then
        self.tweener:Kill()
        self.tweener = nil;
    end
end

function QinMapItem:Destroy()
    if (self.OnClickChu ~= nil) then
        LuaMgr.RemoveClick(self.chuBtn, self.OnClickChu);
        LuaMgr.RemoveClick(self.countryChuBtn, self.OnClickChu);
        self.OnClickChu = nil;
    end
    if (self.OnClickHan ~= nil) then
        LuaMgr.RemoveClick(self.hanBtn, self.OnClickHan);
        LuaMgr.RemoveClick(self.countryHanBtn, self.OnClickHan);
        self.OnClickHan = nil;
    end
    if (self.OnClickQi ~= nil) then
        LuaMgr.RemoveClick(self.qiBtn, self.OnClickQi);
        LuaMgr.RemoveClick(self.countryQiBtn, self.OnClickQi);
        self.OnClickQi = nil;
    end
    if (self.OnClickWei ~= nil) then
        LuaMgr.RemoveClick(self.weiBtn, self.OnClickWei);
        LuaMgr.RemoveClick(self.countryWeiBtn, self.OnClickWei);
        self.OnClickWei = nil;
    end
    if (self.OnClickYan ~= nil) then
        LuaMgr.RemoveClick(self.yanBtn, self.OnClickYan);
        LuaMgr.RemoveClick(self.countryYanBtn, self.OnClickYan);
        self.OnClickYan = nil;
    end
    if (self.OnClickZhao ~= nil) then
        LuaMgr.RemoveClick(self.zhaoBtn, self.OnClickZhao);
        LuaMgr.RemoveClick(self.countryZhaoBtn, self.OnClickZhao);
        self.OnClickZhao = nil;
    end
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end