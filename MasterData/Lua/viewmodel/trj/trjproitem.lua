TRJProItem = {};

TRJProItem.__index = TRJProItem;

local objs = {
    btnClick={ path = "root", type = "Button" },
    goComplete={ path = "root/complete", type = "GameObject" },
    goCur={ path = "root/cur", type = "GameObject" },
    goLock={ path = "root/lock", type = "GameObject" },
    txtCompleteNum={ path = "root/complete/Text", type = "Text" },
    txtCur={ path = "root/cur/Text", type = "Text" },
};

function TRJProItem.New()
    local self = {};
    setmetatable(self, TRJProItem);
    return self;
end

function TRJProItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.clickBtnCommand=function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index)
        end
    end
    LuaMgr.AddClick(self.btnClick, self.clickBtnCommand)
end






function TRJProItem:SetData(data)
    self.data = data.data;
    SetActive(self.goComplete,self.data.isComplete);
    SetActive(self.goCur,not self.data.isComplete and  self.data.isUnLock);
    SetActive(self.goLock,not self.data.isUnLock)
    if self.data.isComplete then
        self.txtCompleteNum.text=string.format("%.2d",self.data.index);
    elseif self.data.isUnLock then
        self.txtCur.text=string.format("%.2d",self.data.index);
    end
end


function TRJProItem:Clear()
    self.data = nil;
end

function TRJProItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end