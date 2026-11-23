FriendChat_OtherMsgItem = {};

FriendChat_OtherMsgItem.__index = FriendChat_OtherMsgItem;

local objs = {
    avatarImg={path="headInfo/avatar",type="RawImage"},
    avatarFrameSprite={path="headInfo/avatarFrame",type="Image"},
    msgRect={path="msg",type="RectTransform"},
    nameText={path="msg/namebg/msgName",type="Text"},
    nameBgRect={path="msg/namebg",type="RectTransform"},
    msgText={path="msg/msgText",type="Text"},
    faceSprite={path="msg/face",type="Image"},
    goLink={path="msg/link",type="GameObject"},
    goRedBag={path="msg/redBag",type="GameObject"},
    goPvPreview={path="msg/PvPreview",type="GameObject"},
    linkSprite={path="msg/link/linkImage",type="Image"},
    linkDes={path="msg/link/linkImage/Text",type="Text"},
    linkBtn={path="msg/link/linkImage",type="Button"},
    redBagSprite={path="msg/redBag/redImage",type="Image"},
    redBagBtn={path="msg/redBag/redImage",type="Button"},
    pvPreviewSprite={path="msg/PvPreview/PreviewImage",type="RawImage"},
    pvPreviewBtn={path="msg/PvPreview/PreviewImage",type="Button"},
    animator={path="",type="Animator"},
    playerTitle = {path="msg/namebg/PlayerTitle",type="Image"},
    playerTitleText = {path="msg/namebg/PlayerTitle/Text",type="Text"},
    titleTextPos = {path="msg/namebg/PlayerTitle/Text",type="RectTransform"},
}

function FriendChat_OtherMsgItem.New()
    local self = {};
    setmetatable(self, FriendChat_OtherMsgItem);
    return self;
end

function FriendChat_OtherMsgItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.linkBtn,function()
        if self.data.linkCallBack~=nil then
            self.data.linkCallBack(self.data.web)
        end
    end);
    LuaMgr.AddClick(self.redBagBtn,function()
        if self.data.redBagCallBack~=nil then
            self.data.redBagCallBack(self.data.index,self.data.msgId)
        end
    end);
    LuaMgr.AddClick(self.pvPreviewBtn,function()
        if self.data.pvPreviewCallBack~=nil then
            self.data.pvPreviewCallBack(self.data.msg)
        end
    end);
end



function FriendChat_OtherMsgItem:SetData(data)
    self.data=data.data
    if self.data.animatorType==1 then

        self.animator:Play("ani_FriendChatPanel_otherMsgItem_001",0,0)
        self.data.animatorType=0;
    elseif self.data.animatorType==2 then

        self.animator:Play("ani_FriendChatPanel_otherMsgItem_002",0,0)
        self.data.animatorType=0;
    else
        self.animator:Play("ani_FriendChatPanel_otherMsgItem_003",0,0)
    end
    if self.data.isPlayer then

        local title = ConfigHelper.GetTitleConfig(FriendChatMgr.currentSelectFriendTitle)
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
    SetActive(self.playerTitle.gameObject,self.data.isPlayer)
    self.nameText.text=self.data.chName;
    self.avatarImg.texture=LuaMgr.GetTexture(self.data.avatarPath)
    if IsNullOrEmpty(self.data.avatarFrame) then
        PlayerAvatarFrameTool.ClearImage(self.avatarFrameSprite)
        SetActive(self.avatarFrameSprite.gameObject,false)
    else
        SetActive(self.avatarFrameSprite.gameObject,true)
        PlayerAvatarFrameTool.SetAvatarFrame(self.avatarFrameSprite, self.data.avatarFrame)
    end
    SetActive(self.goLink,self.data.chatType==4);
    SetActive(self.goRedBag,self.data.chatType==5);
    SetActive(self.goPvPreview,self.data.chatType==6);
    if self.data.chatType==4 then
        self:SetLink();
        return
    elseif self.data.chatType==5 then
        self:SetRedBag();
        return;
    elseif self.data.chatType==6 then
        self:SetPvPreview();
        return
    end

    if self.data.txtWidth-13<self.data.txtNameWidth then
        self.data.txtWidth=self.data.txtNameWidth+26;
    end
    self.msgRect.sizeDelta=Vector2(self.data.txtWidth,self.data.txtHeight);
    self.nameBgRect.sizeDelta=Vector2(self.data.txtNameWidth,28)
    if string.starts(self.data.msg,FriendChatMgr.faceTag) then
        self.msgText.text="";
        SetActive(self.faceSprite.gameObject,true)
        local faceNames=NumTool.split(self.data.msg,"&")
        self.faceSprite.sprite=LuaMgr.GetSprite("FriendChatFace",faceNames[2])
    else
        self.msgText.text=self.data.msg;
        SetActive(self.faceSprite.gameObject,false)
    end
end



function FriendChat_OtherMsgItem:SetLink()
    self.msgText.text="";
    SetActive(self.faceSprite.gameObject,false)
    self.msgRect.sizeDelta=Vector2(288,116);
    self.nameBgRect.sizeDelta=Vector2(self.data.txtNameWidth,28)
    self.linkSprite.sprite=LuaMgr.GetSprite("FriendChat",self.data.msg);
    self.linkDes.text="";
end


function FriendChat_OtherMsgItem:SetRedBag()
    self.msgText.text="";
    SetActive(self.faceSprite.gameObject,false)
    self.msgRect.sizeDelta=Vector2(288,116);
    self.nameBgRect.sizeDelta=Vector2(self.data.txtNameWidth,28)
    if self.data.optionIndex~=nil and self.data.optionIndex > 0 then

        self.redBagSprite.sprite=LuaMgr.GetSprite("FriendChat",self.data.msg.."_1");
    else
        self.redBagSprite.sprite=LuaMgr.GetSprite("FriendChat",self.data.msg);

    end
end

function FriendChat_OtherMsgItem:SetVoice()
    
end

function FriendChat_OtherMsgItem:SetPvPreview()
    self.msgText.text="";
    SetActive(self.faceSprite.gameObject,false)
    self.msgRect.sizeDelta=Vector2(384,192);
    self.nameBgRect.sizeDelta=Vector2(self.data.txtNameWidth,28)
    self.pvPreviewSprite.texture=LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/FriendChat/PvPreview/%s.png", self.data.msg));
end

function FriendChat_OtherMsgItem:Clear()
    PlayerAvatarFrameTool.ClearImage(self.avatarFrameSprite)
    self.data=nil;
end


function FriendChat_OtherMsgItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.avatarFrameSprite)
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.avatarImg=nil;
    self.avatarFrameSprite=nil;
    self.msgRect=nil;
    self.nameText=nil;
    self.msgText=nil;
    self.nameBgRect=nil;
    self.faceSprite=nil;
    self.goLink=nil;
    self.linkSprite=nil;
    self.linkDes=nil;
    self.linkBtn=nil;
    self.animator=nil;
    self.goRedBag=nil;
    self.redBagSprite=nil;
    self.redBagBtn=nil;
    self.goPvPreview=nil;
    self.pvPreviewSprite=nil;
    self.pvPreviewBtn=nil;
end

