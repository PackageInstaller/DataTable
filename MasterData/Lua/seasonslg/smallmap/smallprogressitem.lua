
SmallProgressItem = {};

SmallProgressItem.__index = SmallProgressItem;
local objs = {

    imgFillAmount={ path = "root/slider/fillAmount", type = "Image" },
    txtValue={ path = "root/sliderValue", type = "Text" },
    txtTime={ path = "root/time/Text", type = "Text" },
};

function SmallProgressItem.New(parent)
    local self = {};
    setmetatable(self, SmallProgressItem);
    self.parent=parent;
    self.prefabPath = "Assets/_BundleResources/UI/SeasonSLG/SmallMap/SmallProgressItem.prefab"
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath)
    self.transform=self.gameObject.transform;
    self.transform:SetParent(parent,false);
    self.transform.localScale=Vector3.one;
    self:Init();
    return self;
end

function SmallProgressItem:Init()
    UITool.Parse(self.gameObject, self, objs);

end




function SmallProgressItem:SetData(data)
    self.data=data;
    local cfgGrid=SeasonSLGMapMgr.gridMap[self.data.gridId];
    if cfgGrid==nil then
        LuaDebug.error("cfgGrid is nil");
        return
    end;
    local isTime=cfgGrid.Function[1]=="8" or cfgGrid.Function[1]=="9" or cfgGrid.Function[1]=="10";
    SetActive(self.txtTime.transform.parent.gameObject,isTime);
    if isTime then
        local endTime=0;
        if DataMgr.Player.SeasonalTimedEvent[self.data.gridId]~=nil then
            endTime=DataMgr.Player.SeasonalTimedEvent[self.data.gridId].ExpireTime;
        end
        local remainTime=endTime-LuaMgr.Timestamp();
        remainTime=remainTime<0 and 0 or remainTime;
        local d,h,m=GetTimeDHM2(remainTime)
        self.txtTime.text=string.format("%sd:%sh:%sm",d,h,m);
    end
    local maxProgress=SeasonSLGMapMgr.GetEventMaxProgressByEventType(cfgGrid.Function[1],cfgGrid.Function[2])
    if not maxProgress then
        return
    end
    local proValue=self.data.progress/maxProgress;

    self.imgFillAmount.fillAmount=proValue;
    self.txtValue.text=string.format("%.f%%",proValue*100);
end

function SmallProgressItem:Clear()
   self.data=nil;
end

function SmallProgressItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end