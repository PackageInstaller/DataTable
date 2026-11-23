FriendChat_SortItem = {};

FriendChat_SortItem.__index = FriendChat_SortItem;

local objs = {
    Btn={path="Btn",type="Button"},
    goChoose={path="Choose",type="GameObject"},
    rectOrder={path="Choose/Order",type="RectTransform"},
    sortName={path="Text",type="Text"},
    chooseName={path="Choose/Text",type="Text"},
}

function FriendChat_SortItem.New()
    local self = {};
    setmetatable(self, FriendChat_SortItem);
    return self;
end


function FriendChat_SortItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.Btn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index)
        end
    end);
end





function FriendChat_SortItem:SetData(data)
    self.data=data.data
    self.sortName.text=self.data.name;
    self.chooseName.text=self.data.name;
    SetActive(self.goChoose,self.data.isOn);
    SetActive(self.rectOrder.gameObject,self.data.index==1);
    self.rectOrder.localScale=Vector3(1,self.data.sortDir,1);
end


function FriendChat_SortItem:Clear()
    self.data=nil;
end


function FriendChat_SortItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.Btn=nil;
    self.goChoose=nil;
    self.rectOrder=nil;
   
end

