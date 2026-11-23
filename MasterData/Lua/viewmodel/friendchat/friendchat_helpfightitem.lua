FriendChat_HelpFightItem = {};

FriendChat_HelpFightItem.__index = FriendChat_HelpFightItem;

local objs = {
    btnRoot={path="root",type="Button"},
    rootSprite={path="root",type="Image"},
    tagSprite={path="root/tag",type="Image"},
    typeName={path="root/typeName",type="Text"},
    redListener={path="root",type="RedIconListener"},
}

function FriendChat_HelpFightItem.New()
    local self = {};
    setmetatable(self, FriendChat_HelpFightItem);
    return self;
end

function FriendChat_HelpFightItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnRoot,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end);
end

function FriendChat_HelpFightItem:SetData(data)
    self.data=data.data
    self:SetEnable(false)
    if self.data.index==1 then
        self.redListener.RedId=self.data.redId;
    else
        self.redListener.RedId="";
    end
    
end

function FriendChat_HelpFightItem:SetEnable(isOn)
    self.typeName.text=isOn and string.format("<color=#986e00>%s</color>",self.data.name) 
            or string.format("<color=#d5d1ca>%s</color>",self.data.name)
    self.tagSprite.sprite=isOn and LuaMgr.GetSprite("FriendChat",string.format("ui_hy_ms_icon_0%s_z",self.data.index))
            or LuaMgr.GetSprite("FriendChat",string.format("ui_hy_ms_icon_0%s",self.data.index));
    self.rootSprite.sprite=isOn and LuaMgr.GetSprite("FriendChat","ui_hy_ms_icon_on") 
            or LuaMgr.GetSprite("FriendChat","ui_hy_ms_icon_off");
    
end

function FriendChat_HelpFightItem:SetPosition(posY)
    self.transform.anchoredPosition=Vector2(0,posY);
 
end


function FriendChat_HelpFightItem:Clear()
    self.data=nil;
end


function FriendChat_HelpFightItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.btnRoot=nil;
    self.btnRoot=nil;
    self.rootSprite=nil;
    self.tagSprite=nil;
    self.typeName=nil;
    self.redListener=nil;
end

