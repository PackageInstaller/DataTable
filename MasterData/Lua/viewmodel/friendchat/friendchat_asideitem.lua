FriendChat_AsideItem = {};

FriendChat_AsideItem.__index = FriendChat_AsideItem;

local objs = {
    bgRect={path="bg",type="RectTransform"},
    des={path="des",type="Text"},
}

function FriendChat_AsideItem.New()
    local self = {};
    setmetatable(self, FriendChat_AsideItem);
    return self;
end


function FriendChat_AsideItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end





function FriendChat_AsideItem:SetData(data)
    self.data=data.data
    self.des.text=self.data.msg;
    self.bgRect.sizeDelta=Vector2(self.des.preferredWidth+40,30);
end


function FriendChat_AsideItem:Clear()
    self.data=nil;
end


function FriendChat_AsideItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.bgRect=nil;
    self.des=nil;
   
end

