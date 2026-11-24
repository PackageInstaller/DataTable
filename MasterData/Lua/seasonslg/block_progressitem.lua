
Block_ProgressItem = {};

Block_ProgressItem.__index = Block_ProgressItem;
local objs = {
    imgIcon={ path = "root/icon", type = "Image" },
    imgFillAmount={ path = "root/slider/fillAmount", type = "Image" },
    txtValue={ path = "root/sliderValue", type = "Text" },
    txtTime={ path = "root/time/Text", type = "Text" },
};

function Block_ProgressItem.New(parent)
    local self = {};
    setmetatable(self, Block_ProgressItem);
    self.parent=parent;
    self.prefabPath = "Assets/_BundleResources/UI/SeasonSLG/ProgressItem.prefab"
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath)
    self.transform=self.gameObject.transform;
    self.transform:SetParent(parent,false);
    self.transform.localScale=Vector3.one;
    self:Init();
    return self;
end

function Block_ProgressItem:Init()
    UITool.Parse(self.gameObject, self, objs);

end




function Block_ProgressItem:SetData(gridId,data)
    self.data=data;
    local isTime = false
    if self.data.showProgressTime then
        isTime = true
    else
        isTime=self.data.EventType=="8" or self.data.EventType=="9" or self.data.EventType=="10"
    end
    SetActive(self.txtTime.transform.parent.gameObject,isTime);
    if isTime then
        local endTime=0;
        if self.data.endTime~=nil and self.data.endTime>0 then
            endTime = self.data.endTime
        else
            if DataMgr.Player.SeasonalTimedEvent[gridId]~=nil then
                endTime=DataMgr.Player.SeasonalTimedEvent[gridId].ExpireTime;
            end
        end
        local remainTime=endTime-LuaMgr.Timestamp();
        remainTime=remainTime<0 and 0 or remainTime;
        local h,m,s=GetTimeHMS(remainTime)
        self.txtTime.text=string.format("%sh:%sm:%ss",h,m,s);
    end
    local maxProgress= 1
    if self.data.maxProgress ~= nil and self.data.maxProgress > 0 then
        maxProgress = self.data.maxProgress
    else
        maxProgress = SeasonSLGMapMgr.GetEventMaxProgressByEventType(self.data.EventType,self.data.FunctionId)
    end
    local proValue=self.data.Progress/maxProgress;

    self.imgFillAmount.fillAmount=proValue;
    self.txtValue.text=string.format("%.1f%%",proValue*100);
end

function Block_ProgressItem:Clear()
   self.data=nil;
end

function Block_ProgressItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end