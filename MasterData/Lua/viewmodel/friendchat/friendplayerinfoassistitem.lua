FriendPlayerInfoAssistItem = {};

FriendPlayerInfoAssistItem.__index = FriendPlayerInfoAssistItem;

local objs = {
    headBtn = { path = "root/imgHeadIcon", type = "Button" },
    imgHeadIcon = { path = "root/imgHeadIcon", type = "RawImage" },
    rare={ path = "root/imgHeadIcon/rare", type = "Image" },
    job={ path = "root/imgHeadIcon/job", type = "Image" },
    level = { path = "root/imgHeadIcon/level", type = "Text" },
}

function FriendPlayerInfoAssistItem.New()
    local self = {};
    setmetatable(self, FriendPlayerInfoAssistItem);
    return self;
end

function FriendPlayerInfoAssistItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.headBtn,function()
        if self.data.clickCallBack~=nil then
            self.data.clickCallBack(self.data.index);
        end
    end);
end


function FriendPlayerInfoAssistItem:SetData(data)
    self.data=data.data
    self.imgHeadIcon.texture=self.data.imgHead;
    self.rare.sprite=self.data.rare;
    self.job.sprite=self.data.job;
    self.level.text=self.data.level;
end

function FriendPlayerInfoAssistItem:Clear()
    self.data=nil;
end

function FriendPlayerInfoAssistItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
  
end

