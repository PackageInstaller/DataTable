FriendChat_HeroItem = {};

FriendChat_HeroItem.__index = FriendChat_HeroItem;

local objs = {
    btnRoot={path="root",type="Button"},
    headBtn={path="root/headBtn",type="Button"},
    isOn={path="root/isOn",type="GameObject"},
    name={path="root/name",type="Text"},
    signature={path="root/signature",type="Text"},
    signatureOff={path="root/signatureOff",type="Text"},
    imgHeadIcon={path="root/imgHeadIcon",type="RawImage"},
    headFrameSprite={path="root/headFrame",type="Image"},
    uiGray={path="root/imgHeadIcon",type="UIGray"},
    favor={path="root/favor",type="GameObject"},
    isLike={path="root/isLike",type="GameObject"},
    redListener={path="root",type="RedIconListener"},
    playerDynamicAvatar = { path = "root/DynamicAvatar", type = "PlayerDynamicAvatar" },
    playerTitle = {path="root/PlayerTitle",type="Image"},
    playerTitleText = {path="root/PlayerTitle/Text",type="Text"},
    titleTextPos = {path="root/PlayerTitle/Text",type="RectTransform"},
}

function FriendChat_HeroItem.New()
    local self = {};
    setmetatable(self, FriendChat_HeroItem);
    return self;
end

function FriendChat_HeroItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnRoot,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
        if self.data.characterCallBack~=nil then
            self.data.characterCallBack(self.data.index);
        end
    end);
    LuaMgr.AddClick(self.headBtn,function()
        if self.data.headCallBack~=nil then
            self.data.headCallBack(self.data.index);
        end
    end);
end











function FriendChat_HeroItem:SetData(data)
    self.data=data.data
    self.redListener.RedId=self.data.redId;
    self:IsOn(self.data.isOn);
    SetActive(self.isLike,self.data.isLike);
    if self.data.isFriend then

        local title = ConfigHelper.GetTitleConfig(self.data.title)
        if not TableIsNull(title) then
            self.playerTitle.sprite = LuaMgr.GetSprite("PlayerTitle",title.img)
            self.playerTitleText.text = LuaMgr.GetLangText(title.namelan)
            if title.img == "Title_40001" then
                self.titleTextPos.anchoredPosition =  Vector2(2,1)
            else
                self.titleTextPos.anchoredPosition =  Vector2(10,1)
            end
        end
    end
    SetActive(self.playerTitle.gameObject,self.data.isFriend)
    if not IsNullOrEmpty(self.data.remark) then
        self.name.text=string.format("%s(%s)",self.data.remark,self.data.name)
    else
        self.name.text=self.data.name
    end
    self.signature.text=self.data.summary;
    self.signatureOff.text="";
    local isShow = self.data.isDynamicAvatar and self.data.isFriend and self.data.isOnline
    if isShow then
        self.playerDynamicAvatar:AppointAvatar(self.data.avatarId)
    else
        self.imgHeadIcon.texture=LuaMgr.GetTexture(self.data.avatarPath)
    end
    SetActive(self.playerDynamicAvatar.gameObject,isShow)
    SetActive(self.imgHeadIcon.gameObject,not isShow)
    
    if IsNullOrEmpty(self.data.avatarFrame) then
        PlayerAvatarFrameTool.ClearImage(self.headFrameSprite)
        SetActive(self.headFrameSprite.gameObject,false)
    else
        SetActive(self.headFrameSprite.gameObject,true)
        PlayerAvatarFrameTool.SetAvatarFrame(self.headFrameSprite, self.data.avatarFrame)
    end
    SetActive(self.favor,self.data.isFavor)
    self.uiGray.IsGray= not self.data.isOnline
    if not self.data.isFriend then
        self.signature.text=ConfigMgr.LangGlobal("17020")
        return;
    end
    if not self.data.isOnline then
        local passTime=LuaMgr.Timestamp()-self.data.lastTime
        local tip="";
        local day,hour,min=GetTimeDHM2(passTime)
        if day>=30 then
            tip=string.format(ConfigMgr.LangGlobal("17013"),day);
        elseif day>0 then
            tip=string.format(ConfigMgr.LangGlobal("17012"),day);
        elseif hour>0 then
            tip=string.format(ConfigMgr.LangGlobal("17011"),hour);
        elseif min>0 then
            tip=string.format(ConfigMgr.LangGlobal("17010"),min);
        else
            tip=string.format(ConfigMgr.LangGlobal("17009"),passTime);
        end
        self.signature.text="";
        self.signatureOff.text=tip;
    else
        self.signature.text=ConfigMgr.LangGlobal("17008")
        self.signatureOff.text="";
    end
    
end

function FriendChat_HeroItem:IsOn(isOn)
    SetActive(self.isOn,isOn);
end


function FriendChat_HeroItem:SetPosition(posY)
    self.transform.anchoredPosition=Vector2(0,posY);
 
end


function FriendChat_HeroItem:Clear()
    PlayerAvatarFrameTool.ClearImage(self.headFrameSprite)
    self.data=nil;
end


function FriendChat_HeroItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.headFrameSprite)
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.btnRoot=nil;
    self.isOn=nil;
    self.name=nil;
    self.signature=nil;
    self.signature=nil;
    self.imgHeadIcon=nil;
    self.headFrameSprite=nil;
    self.uiGray=nil;
    self.headBtn=nil;
    self.favor=nil;
    self.redListener=nil;
    self.isLike=nil;
    self.playerDynamicAvatar = nil
end

