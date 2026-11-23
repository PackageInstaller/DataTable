FriendChat_FriendTypeItem = {};

FriendChat_FriendTypeItem.__index = FriendChat_FriendTypeItem;

local objs = {
    btnRoot={path="root",type="Button"},
    bgSprite={path="root",type="Image"},
    tagSprite={path="root/tag",type="Image"},
    typeName={path="root/typeName",type="Text"},
    moreSprite={path="root/more",type="Image"},
    btnMore={path="root/more",type="Button"},
    redListener={path="root",type="RedIconListener"},
}

function FriendChat_FriendTypeItem.New()
    local self = {};
    setmetatable(self, FriendChat_FriendTypeItem);
    return self;
end

function FriendChat_FriendTypeItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnRoot,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end);
    LuaMgr.AddClick(self.btnMore,function()
        if self.data.sortCallBack~=nil then
            self.data.sortCallBack(self.data.index);
        end
    end);
end

function FriendChat_FriendTypeItem:SetData(data)
    self.typeCfg=FriendChatThemeCfg.FriendType[FriendChatMgr.GetCurrentTheme()];
    self.data=data.data
    self.transform.anchoredPosition=Vector2(0,-self.data.posY);
    self.tagSprite.sprite=LuaMgr.GetSprite("FriendChat",self.typeCfg.tagName..self.data.index)
    self.redListener.RedId=tostring(self.data.redId);
    self:SetIsOn(false);
end

function FriendChat_FriendTypeItem:SetIsOn(isOn)
    self.data.isOn=isOn;
    self.bgSprite.sprite=isOn and LuaMgr.GetSprite("FriendChat",self.typeCfg.bgSpriteName1) 
            or LuaMgr.GetSprite("FriendChat",self.typeCfg.bgSpriteName2)
    if self.data.index==1 then
        self.typeName.text=isOn and string.format("<color=#%s>%s(%s)</color>",self.typeCfg.nameColor1,self.data.name,self.data.totalCount)
                or string.format("<color=#%s>%s(%s)</color>",self.typeCfg.nameColor2,self.data.name,self.data.totalCount);
    elseif self.data.index==2 then
        self.typeName.text=isOn and string.format("<color=#%s>%s(%s/%s)</color>",self.typeCfg.nameColor1,self.data.name,self.data.onlineCount,self.data.totalCount)
                or string.format("<color=#%s>%s(%s/%s)</color>",self.typeCfg.nameColor2,self.data.name,self.data.onlineCount,self.data.totalCount);
    else
        self.typeName.text=isOn and string.format("<color=#%s>%s</color>",self.typeCfg.nameColor1,self.data.name)
                or string.format("<color=#%s>%s</color>",self.typeCfg.nameColor2,self.data.name);
    end
    
    if self.data.totalCount==0 or self.data.index~=1 then
        SetActive(self.moreSprite.gameObject,false)
    else
        SetActive(self.moreSprite.gameObject,true)
        self.moreSprite.sprite=isOn and LuaMgr.GetSprite("FriendChat",self.typeCfg.moreSpriteName1) or LuaMgr.GetSprite("FriendChat",self.typeCfg.moreSpriteName2);
    end
    
end

function FriendChat_FriendTypeItem:SetPosition(posY,isAnimation)
    if isAnimation~=nil and isAnimation and math.abs(posY+self.data.posY)>2 then
        self.transform:DOLocalMoveY(posY,0.2).onComplete=function()
            self.transform.anchoredPosition=Vector2(0,posY);
        end
    else
        self.transform.anchoredPosition=Vector2(0,posY);
    end
end

function FriendChat_FriendTypeItem:UpdateFriendPro(pro,count)
    self.data.onlineCount=pro;
    self.data.totalCount=count;
    self.typeName.text=self.data.isOn and string.format("<color=#%s>%s(%s/%s)</color>",self.typeCfg.nameColor1,self.data.name,pro,count)
                  or string.format("<color=#%s>%s(%s/%s)</color>",self.typeCfg.nameColor2,self.data.name,pro,count);
end

function FriendChat_FriendTypeItem:Clear()
    self.data=nil;
end


function FriendChat_FriendTypeItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.btnRoot=nil;
    self.btnRoot=nil;
    self.bgSprite=nil;
    self.tagSprite=nil;
    self.typeName=nil;
    self.moreSprite=nil;
    self.btnMore=nil;
    self.redListener=nil;
end

