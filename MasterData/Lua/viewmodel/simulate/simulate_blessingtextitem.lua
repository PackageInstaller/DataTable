Simulate_BlessingTextItem = {};

Simulate_BlessingTextItem.__index = Simulate_BlessingTextItem;

local objs = {
    txtInfo={path="root/info",type="Text"},
    bgBtn={path="root/bg",type="Button"},
    goSelect={path="root/select",type="GameObject"},
    goNum={path="root/num",type="GameObject"},
    txtNum={path="root/num/Text",type="Text"},
}

function Simulate_BlessingTextItem.New()
    local self = {};
    setmetatable(self, Simulate_BlessingTextItem);
    return self;
end

function Simulate_BlessingTextItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    SetActive(self.gameObject,true);
    LuaMgr.AddClick(self.bgBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end


function Simulate_BlessingTextItem:SetData(pdata)
    self.data=pdata.data
    self.txtInfo.text=self.data.num>0 and string.format("<color=#e8cc88>%s</color>",self.data.info) or self.data.info;
    self:SetSelect(self.data.isSelect)
    if self.data.num>0 then
        SetActive(self.goNum,true)
        self.txtNum.text=self.data.num;
    else
        SetActive(self.goNum,false)
    end
end

function Simulate_BlessingTextItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end

function Simulate_BlessingTextItem:Clear()
    self.data=nil
end


function Simulate_BlessingTextItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

