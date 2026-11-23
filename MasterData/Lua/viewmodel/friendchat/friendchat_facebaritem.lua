FriendChat_FaceBarItem = {};

FriendChat_FaceBarItem.__index = FriendChat_FaceBarItem;

local objs = {
    btnFace={path="root/face",type="Button"},
    faceSprite={path="root/face",type="Image"},
    isOn={path="root/isOn",type="GameObject"},
    
}

function FriendChat_FaceBarItem.New()
    local self = {};
    setmetatable(self, FriendChat_FaceBarItem);
    return self;
end

function FriendChat_FaceBarItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnFace,function()
        if self.data.barCallBack~=nil then
            self.data.barCallBack(self.data.index)
        end
    end);
   
end

function FriendChat_FaceBarItem:SetData(data)
    self.data=data.data
    self.faceSprite.sprite=self.data.barSprite;
    self:SetIsOn(self.data.isOn);
end


function FriendChat_FaceBarItem:SetIsOn(isOn)
    SetActive(self.isOn,isOn);
end


function FriendChat_FaceBarItem:Clear()
    self.data=nil;
end


function FriendChat_FaceBarItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.btnFace=nil;
    self.faceSprite=nil;
    self.isOn=nil;
end

