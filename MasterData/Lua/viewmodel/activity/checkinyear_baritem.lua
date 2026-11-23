CheckInYear_BarItem = {}

CheckInYear_BarItem.__index = CheckInYear_BarItem

local objs = 
{
    name = {path = "root/name", type = "Text"},
    lockObj = {path = "root/lock", type = "GameObject"},
    checkObj={path = "root/barBg/check", type = "GameObject"},

    redObj={path = "root/red", type = "GameObject"},
    btnBG={path = "root/barBg", type = "Button"},
    animator={path = "", type = "Animator"},
}

function CheckInYear_BarItem.New()
    local obj = {}
    setmetatable(obj, CheckInYear_BarItem)
    return obj
end

function CheckInYear_BarItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    LuaMgr.AddClick(self.btnBG,function(index)
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end






function CheckInYear_BarItem:SetData(pdata)
    self.data=pdata.data;
    if self.data.lock then
        local curDate=os.date("*t",LuaMgr.Timestamp());
        local tarDate=os.date("*t",self.data.utc);
        local curTimestamp_start= os.time({ year = curDate.year, month = curDate.month, day = curDate.day, hour = tarDate.hour, min = 0, sec = 00 });
        local timer=self.data.utc-curTimestamp_start;
        if curDate.hour<tarDate.hour then

            timer=timer+24*3600;
        end
        if timer>24*3600 then
            self.name.text=os.date(LuaMgr.GetLangText("CheckInYear_BarItem_0"), self.data.utc);
        else
            self.name.text=LuaMgr.GetLangText("CheckInYear_BarItem_1")
        end
    end
    SetActive(self.redObj,self.data.isRed);
    SetActive(self.lockObj,self.data.lock);
    self:SetIsOn(self.data.isOn,true);
end

function CheckInYear_BarItem:SetIsOn(isOn,isInit)
    if isInit then
        self.animator:Play("ani_ActivityCheckInYear_barItem_born");
    else
        if isOn then
            self.animator:Play("ani_ActivityCheckInYear_barItem_switch");
        end
    end
    SetActive(self.checkObj,isOn);
    if not self.data.lock then
        self.name.text=isOn and string.format("<color=#b3722c>%s</color>",self.data.name)
                or string.format("<color=#fffddd>%s</color>",self.data.name) ;
        
    end
end

function CheckInYear_BarItem:CloseRed()
    SetActive(self.redObj,false);
end

function CheckInYear_BarItem:Clear()
    self.data=nil;
end

function CheckInYear_BarItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil
end