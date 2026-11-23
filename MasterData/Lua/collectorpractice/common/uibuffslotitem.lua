
UIBuffSLotItem = {}
UIBuffSLotItem.__index = UIBuffSLotItem



function UIBuffSLotItem.New(prefab, parent)
    local self = {}
    setmetatable(self, UIBuffSLotItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.animator=self.gameObject:GetComponent("Animator");
    self.imgIcon= uiLink:Get("imgIcon"):GetComponent("Image")
    self.btnClickBuff = uiLink:Get("btnClickBuff"):GetComponent("Button");
    self.goLock = uiLink:Get("goLock");
    self.originsID=nil;
    self.switchAnimationCo=nil;
    uiLink:AddClickEvent("btnClickBuff", function()
        if self.switchAnimationCo~=nil then
            return;
        end
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeShowAllTrammelsViewModel,ConfigMgr.Config.OriginsTalentMap[self.originsID].Map);
    end)
    return self
end

function UIBuffSLotItem:Destroy()
    self.gameObject = nil
    self.transform = nil
    self.btnClickBuff = nil;
    self.goLock = nil;
    self.imgIcon=nil;
    self.originsID=nil;
end

function UIBuffSLotItem:SetData(originsID,isLock,isSelectMap)
    self.originsID=originsID;
isSelectMap=isSelectMap or false;
    SetActive(self.gameObject, true);
    SetActive(self.goLock, isLock);

    if isSelectMap then
        self.imgIcon.sprite=LuaMgr.GetSprite("CollectorHome", originsID.."_ztxz");
    else
        self.imgIcon.sprite=LuaMgr.GetSprite("CollectorHome", originsID);
    end

end

function UIBuffSLotItem:PlayFirstAnimation()
    self.animator:Play("ani_CollectorPracticeSelectMapPanel_UIBuffSLotItem_born",0,0)
end

function UIBuffSLotItem:PlaySwitchAnimationAndEndSetData(originsID,isLock,isSelectMap)
self.switchAnimationCo = coroutine_runner.start(function()
        self.animator:Play("ani_CollectorPracticeSelectMapPanel_UIBuffSLotItem_switch",0,0)
        coroutine_runner.wait(0.5);
        self:SetData(originsID,isLock,isSelectMap);
        self.switchAnimationCo=nil
    end)
    
end

function UIBuffSLotItem:Hide()
if coroutine_runner.checkIsDestory() then
        return;
    end
    if self.switchAnimationCo ~= nil then
        coroutine_runner.stop(self.switchAnimationCo)
    end
    self.switchAnimationCo=nil;
    SetActive(self.gameObject, false);
end

