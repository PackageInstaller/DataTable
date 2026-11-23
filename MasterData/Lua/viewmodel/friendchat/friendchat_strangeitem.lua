FriendChat_StrangeItem = {};

FriendChat_StrangeItem.__index = FriendChat_StrangeItem;

local objs = {
    btnRoot={path="root",type="Button"},
    rootSprite={path="root",type="Image"},
    tagSprite={path="root/tag",type="Image"},
    typeName={path="root/typeName",type="Text"},
    redListener={path="root",type="RedIconListener"},
}

function FriendChat_StrangeItem.New()
    local self = {};
    setmetatable(self, FriendChat_StrangeItem);
    return self;
end

function FriendChat_StrangeItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnRoot,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end);
end

function FriendChat_StrangeItem:SetData(data)
    self.strangeCfg=FriendChatThemeCfg.FriendStrange[FriendChatMgr.GetCurrentTheme()];
    self.data=data.data
    self:SetEnable(false)
    if self.data.index==1 then
        self.redListener.RedId=self.data.redId;
    else
        self.redListener.RedId="";
    end
    
end

function FriendChat_StrangeItem:SetEnable(isOn)
    self.typeName.text=isOn and string.format("<color=#%s>%s</color>",self.strangeCfg.nameColor1,self.data.name) 
            or string.format("<color=#%s>%s</color>",self.strangeCfg.nameColor2,self.data.name)
    self.tagSprite.sprite=isOn and LuaMgr.GetSprite("FriendChat",string.format(self.strangeCfg.tagName1,self.data.index))
            or LuaMgr.GetSprite("FriendChat",string.format(self.strangeCfg.tagName2,self.data.index));
    self.rootSprite.sprite=isOn and LuaMgr.GetSprite("FriendChat",self.strangeCfg.bgSpriteName1) 
            or LuaMgr.GetSprite("FriendChat",self.strangeCfg.bgSpriteName2);
    
end

function FriendChat_StrangeItem:SetPosition(posY)
    self.transform.anchoredPosition=Vector2(0,posY);
 
end


function FriendChat_StrangeItem:Clear()
    self.data=nil;
end


function FriendChat_StrangeItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.btnRoot=nil;
    self.btnRoot=nil;
    self.rootSprite=nil;
    self.tagSprite=nil;
    self.typeName=nil;
    self.redListener=nil;
end

