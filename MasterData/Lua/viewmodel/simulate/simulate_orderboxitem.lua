Simulate_OrderBoxItem = {};

Simulate_OrderBoxItem.__index = Simulate_OrderBoxItem;

local objs = {
    goEmpty={path="root/empty",type="GameObject"},
    goActive={path="root/active",type="GameObject"},
    imgIcon={path="root/active/icon",type="Image"},
    txtTime={path="root/active/time",type="Text"},
    goSelect={path="root/select",type="GameObject"},
    btnBg={path="root/BG",type="Button"},
}


function Simulate_OrderBoxItem.New()
    local self = {};
    setmetatable(self, Simulate_OrderBoxItem);
    return self;
end

function Simulate_OrderBoxItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    SetActive(self.gameObject,true);
    LuaMgr.AddClick(self.btnBg,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end

function Simulate_OrderBoxItem:SetData(pdata)
    self.data=pdata.data
    if not self.data.isActive then
        SetActive(self.goEmpty,true)
        SetActive(self.goActive,false);
    else
        SetActive(self.goEmpty,false)
        SetActive(self.goActive,true);
        self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",self.data.iconName)
        local remainTime=self.data.harvestTime-LuaMgr.Timestamp();
        if remainTime<=0 then
            self.txtTime.text=string.format(LuaMgr.GetLangText("Simulate_OrderBoxItem_0"))
        else
            remainTime=remainTime<0 and 0 or remainTime;
            local d,h,m=GetTimeDHM2(remainTime)
            if m==0 then
                self.txtTime.text=string.format(LuaMgr.GetLangText("Simulate_OrderBoxItem_1"),h)
            else
                self.txtTime.text=string.format(LuaMgr.GetLangText("Simulate_OrderBoxItem_2"),h,m)
            end
        end
    end
    self:SetSelect(self.data.isSelect)
end

function Simulate_OrderBoxItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end

function Simulate_OrderBoxItem:Clear()
    self.data=nil
end


function Simulate_OrderBoxItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end