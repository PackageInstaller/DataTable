





AreaMapEventItem = {}
AreaMapEventItem.__index = AreaMapEventItem
local PREFAB_PATH = "Assets/_BundleResources/UI/Area/AreaMapEventItem.prefab";
function AreaMapEventItem.New(parent)
    local self = {}
    setmetatable(self, AreaMapEventItem)
    self.gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
    LuaMgr.AddPrefabRefCount(PREFAB_PATH);
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent, false);
    local uiLink                = self.gameObject:GetComponent("UILink");
    self.btnEvent               = uiLink:Get("btnEvent"):GetComponent("Button");
    self.evenTransform          = uiLink:Get("btnEvent"):GetComponent("RectTransform");
    self.imgCategory            = uiLink:Get("btnEvent"):GetComponent("Image");
    self.imgType                = uiLink:Get("imgType"):GetComponent("Image");
    self.textEventName          = uiLink:Get("textEventName"):GetComponent("Text");
    self.textTime               = uiLink:Get("textTime"):GetComponent("Text");
    self.textChaterType         = uiLink:Get("textChaterType"):GetComponent("Text");
    self.goEvaluate             = uiLink:Get("goEvaluate");
    self.imgEvaluate            = uiLink:Get("goEvaluate"):GetComponent("Image");
    self.goNotEvaluate          = uiLink:Get("goNotEvaluate");
    self.goFinish               = uiLink:Get("goFinish");
    self.goNew                  = uiLink:Get("goNew");
    self.goCompleted            = uiLink:Get("goCompleted");
    self.goClear                = uiLink:Get("goClear");
    self.goTime                 = uiLink:Get("goTime");
    self.goUiAreaMapEventItem01 = uiLink:Get("goUiAreaMapEventItem01");
    self.goCount                = uiLink:Get("goCount");
    self.textCount              = uiLink:Get("textCount"):GetComponent("Text");

    self.id                     = nil;
    self.currentArea            = nil;
    self.currentBuilding        = nil;
    self.tween                  = nil;
    self.OnClickEvent           = function()
        local areaMap = DataMgr.Player.areaMaps[self.currentArea]
        if areaMap == nil then
            return;
        end




        local areaEventConfig = ConfigMgr.Config.areaEvents[self.id];
        if areaEventConfig == nil then
            return;
        end
        if (self:IsGuideTeach(areaEventConfig)) then
            LuaMgr.ShowLuaPanel(UIName.GuideTeachViewModel, areaEventConfig.eventParam);
            return;
        end
        PlayerAreaMapMgr.ModifyAreaMapBuildingEvent(self.currentArea, self.currentBuilding, self.id, 0);
        local building = AreaMapSceneMgr.GetBuilding(self.currentBuilding);
        if building ~= nil then
            building:SetDot();
        end
        local eventType = tonumber(areaEventConfig.type);
        if eventType == AreaEventType.AVG then
            LuaMgr.ShowLuaPanel(UIName.AreaMapAVGViewModel, areaEventConfig, self.currentBuilding);
        elseif eventType == AreaEventType.Battle then
            AreaMapSceneMgr.SetBuildingId(self.currentBuilding);

            local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
            enterDungeonParams.eventId = areaEventConfig.id;
            enterDungeonParams.dungeonId = areaEventConfig.eventParam;
            BattlePrepareMgr.BattlePrepare(enterDungeonParams);
        elseif eventType == AreaEventType.Explore then
        end
    end
    uiLink:AddClickEvent("btnEvent", self.OnClickEvent)
    LuaMgr.SetFont(self.transform);
    return self
end

function AreaMapEventItem:SetData(idParm, currentAreaParm, currentBuildingParm)
    self.id              = idParm;
    self.currentArea     = currentAreaParm;
    self.currentBuilding = currentBuildingParm;
    SetActive(self.gameObject, true);
end

function AreaMapEventItem:MoveIn(delay, moveEndDelay, nextDelay)
if moveEndDelay == nil then
        moveEndDelay = 0
    end
if nextDelay == nil then
        nextDelay = 0
    end
    self:RemoveTween();
    SetActive(self.goUiAreaMapEventItem01, false);
    if moveEndDelay > 0 then
        self.evenTransform.anchoredPosition = Vector2(360, -117);
        self.tween = self.evenTransform:DOLocalMoveX(0, delay)
        self.tween:SetDelay(moveEndDelay).onComplete = function()
            self:MoveUp(nextDelay);
        end;
    else
        self.evenTransform.anchoredPosition = Vector2(360, 0);
        self.tween = self.evenTransform:DOLocalMoveX(0, delay)
    end
end

function AreaMapEventItem:DOScale(duration, moveEndDelay, nextDelay)
if moveEndDelay == nil then
        moveEndDelay = 0
    end
if nextDelay == nil then
        nextDelay = 0
    end
    self:RemoveTween();
    self.evenTransform.localScale = Vector3.zero
    self.evenTransform.anchoredPosition = Vector2(0, 0);
    local sq=DOTWeen:Sequence();
    sq:Insert(duration,self.evenTransform:DOScale(Vector3.one, 0.3):SetEase(Ease.OutBack)):OnComplete(function ()
        SetActive(self.goUiAreaMapEventItem01, true)
    end);
    sq:AppendInterval(0.3);
    SetActive(self.goUiAreaMapEventItem01, false)
end

function AreaMapEventItem:MoveUp(delay)
    self.evenTransform.anchoredPosition = Vector2(0, -117);
    self.tween = self.evenTransform:DOLocalMoveY(0, delay);
    self.tween.onComplete = function()
        SetActive(self.goUiAreaMapEventItem01, false)
    end
end

function AreaMapEventItem:RemoveTween()
    if self.tween ~= nil then
        self.tween:Kill()
        self.tween = nil
    end
end

function AreaMapEventItem:Hide()
    self:RemoveTween();
    SetActive(self.gameObject, false)
    LuaMgr.RemoveTimer(TimerConst.DelayClose)
end

function AreaMapEventItem:Destroy()
    if (self.gameObject ~= nil) then
        LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.transform = nil;
        self.gameObject = nil;
        LuaMgr.RemoveTimer(TimerConst.DelayClose)
    end
end


function AreaMapEventItem:IsGuideTeach(config)
    local guideCareer = ConfigMgr.Config.GuideCareerMap[config.eventParam];
    if (guideCareer ~= nil) then
        local record = DataMgr.Player.dungeonRecords[guideCareer.CareerId];
        if (record ~= nil and record.historyRating ~= "") then
            return false;
        end
        local key = string.format("GuideCareer_%s_%s", DataMgr.Player.uid, guideCareer.DungeonId);
        if (PlayerPrefs.GetInt(key, 0) == 0) then
            PlayerPrefs.SetInt(key, 1);
            return true;
        end
    end
    return false;
end