
Rank_BarItem = {};

Rank_BarItem.__index = Rank_BarItem;
local objs = {
    txtName1 = { path = "root/off/Text", type = "Text" },
    txtName2 = { path = "root/on/Text", type = "Text" },
    btnBar= { path = "root", type = "Button" },
};

function Rank_BarItem.New()
    local self = {};
    setmetatable(self, Rank_BarItem);
    return self;
end

function Rank_BarItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBar,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end


function Rank_BarItem:SetData(data)
    self.data=data.data;
    self.txtName1.text=self.data.name;
    self.txtName2.text=self.data.name;
    self:SetIsOn(self.data.isOn);
    self.transform.anchoredPosition=self.data.pos;
end

function Rank_BarItem:SetIsOn(isOn)
    SetActive(self.txtName1.transform.parent.gameObject,not isOn);
    SetActive(self.txtName2.transform.parent.gameObject,isOn);
end

function Rank_BarItem:UpdateBarState(position,isAnimation,isOn)
    self:SetIsOn(isOn);
    if not isAnimation then
        self.transform.anchoredPosition=position;
    else
        DOTWeen.To(function()return self.transform.anchoredPosition  end,function(pos)
            self.transform.anchoredPosition=pos;
        end,position,0.2);
    end
end

function Rank_BarItem:Clear()
    self.data=nil;
end

function Rank_BarItem:Destroy()

    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end