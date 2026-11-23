FriendChat_AssistItem = {};

FriendChat_AssistItem.__index = FriendChat_AssistItem;

local objs = {
    headBtn = { path = "root/imgHeadIcon", type = "Button" },
    imgHeadIcon = { path = "root/imgHeadIcon", type = "RawImage" },
    rare={ path = "root/imgHeadIcon/rare", type = "Image" },
    job={ path = "root/imgHeadIcon/job", type = "Image" },
    level = { path = "root/imgHeadIcon/level", type = "Text" },
}

function FriendChat_AssistItem.New()
    local self = {};
    setmetatable(self, FriendChat_AssistItem);
    return self;
end

function FriendChat_AssistItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.headBtn,function()
        if self.data.clickCallBack~=nil then
            self.data.clickCallBack(self.data.id);
        end
    end);
end


function FriendChat_AssistItem:SetData(data)
    self.data=data.data
    self.imgHeadIcon.texture=self.data.imgHead;
    self.rare.sprite=self.data.rare;
    self.job.sprite=self.data.job;
    self.level.text=self.data.level;
end

function FriendChat_AssistItem:Clear()
    self.data=nil;
end

function FriendChat_AssistItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
  
end

