BrilliantGift_DayItem = {};

BrilliantGift_DayItem.__index = BrilliantGift_DayItem;

local objs = {
    isOnObj={path="isOn",type="GameObject"},
    dayText={path="dayText",type="Text"},
    btnDay={path="btnDay",type="Button"},
    lockObj={path="lock",type="GameObject"},
    redListener={path="",type="RedIconListener"},
   
   
}
function BrilliantGift_DayItem.New()
    local self = {};
    setmetatable(self, BrilliantGift_DayItem);
    return self;
end

function BrilliantGift_DayItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnDay, function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index)
        end
    end)
  
end

function BrilliantGift_DayItem:SetData(pdata)
    self.data=pdata.data
    self.redListener.RedId=self.data.redId;
    SetActive(self.lockObj,self.data.isLock);
    self:SetIsOn(self.data.isCurDay)
end

function BrilliantGift_DayItem:SetIsOn(isOn)
    SetActive(self.isOnObj,isOn);
    self.dayText.text=isOn and string.format("<color=#5c574e>%s</color>",self.data.des) or self.data.des;
end

function BrilliantGift_DayItem:Clear()
   self.data=nil
end
function BrilliantGift_DayItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

