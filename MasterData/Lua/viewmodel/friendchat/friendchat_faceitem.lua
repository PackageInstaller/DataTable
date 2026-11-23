FriendChat_FaceItem = {};

FriendChat_FaceItem.__index = FriendChat_FaceItem;

local objs = {
    btnFace={path="root/face",type="Button"},
    faceSprite={path="root/face",type="Image"},
    
}

function FriendChat_FaceItem.New()
    local self = {};
    setmetatable(self, FriendChat_FaceItem);
    return self;
end


function FriendChat_FaceItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnFace,function()
        if self.data.faceCallBack~=nil then
            self.data.faceCallBack(self.data.index)
        end
    end);
end


function FriendChat_FaceItem:SetData(data)
    self.data=data.data
    self.faceSprite.sprite=self.data.faceSprite;
end




function FriendChat_FaceItem:Clear()
    self.data=nil;
end


function FriendChat_FaceItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.faceSprite=nil;
    self.btnFace=nil;
   
end

