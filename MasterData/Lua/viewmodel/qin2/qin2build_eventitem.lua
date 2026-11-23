Qin2Build_EventItem = {};

Qin2Build_EventItem.__index = Qin2Build_EventItem;
local objs = {
    icon={ path = "root/icon", type = "Image" },
    iconBtn={ path = "root/icon", type = "Button" },
    animator={ path = "root", type = "Animator" },
}

function Qin2Build_EventItem.New()
    local self = {};
    setmetatable(self, Qin2Build_EventItem);
    self.isActive=false;
    return self;
end

function Qin2Build_EventItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.iconBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.eventId);
        end
    end)
end

function Qin2Build_EventItem:SetData(pdata)
    self.data = pdata.data
    self.icon.sprite=LuaMgr.GetSprite("Qin2","ui_hd_event_"..self.data.eventType)
    self.transform.anchoredPosition=self.data.pos;
    SetActive(self.gameObject,false);
end

function Qin2Build_EventItem:PlayAnimator(type)
    SetActive(self.gameObject,true);
    if type==1 then
        self.animator:Play("ani_Qin2BuildPanel_eventItem",0,0)
    elseif type==2 then
        self.animator:Play("ani_Qin2BuildPanel_eventItem_loopEnter",0,0)
    elseif type==3 then
        self.animator:Play("ani_Qin2BuildPanel_eventItemClose",0,0)
    end
    
end


function Qin2Build_EventItem:Clear()
    self.data = nil;
end

function Qin2Build_EventItem:Destroy()
    self.icon=nil;
    self.iconBtn=nil;
    self.animator=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end