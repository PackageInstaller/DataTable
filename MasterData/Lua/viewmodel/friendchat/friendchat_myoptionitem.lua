FriendChat_MyOptionItem = {};

FriendChat_MyOptionItem.__index = FriendChat_MyOptionItem;

local objs = {
    avatarImg={path="headInfo/avatar",type="RawImage"},
    avatarFrameSprite={path="headInfo/avatarFrame",type="Image"},
    msgRect={path="msg",type="RectTransform"},
    nameText={path="msg/namebg/msgName",type="Text"},
    nameBgRect={path="msg/namebg",type="RectTransform"},
    anwser1BgRect={path="msg/answerGroup/anwser1",type="RectTransform"},
    anwser1Text={path="msg/answerGroup/anwser1/Text",type="Text"},
    anwser2BgRect={path="msg/answerGroup/anwser2",type="RectTransform"},
    anwser2Text={path="msg/answerGroup/anwser2/Text",type="Text"},
    btnAnwer1={path="msg/answerGroup/anwser1",type="Button"},
    btnAnwer2={path="msg/answerGroup/anwser2",type="Button"},
    animator={path="msg",type="Animator"},
    
}

function FriendChat_MyOptionItem.New()
    local self = {};
    setmetatable(self, FriendChat_MyOptionItem);
    return self;
end

function FriendChat_MyOptionItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnAnwer1,function()
        if self.data.anwserCallBack~=nil then
            self.data.anwserCallBack(self.data.index,1)
        end
    end);
    LuaMgr.AddClick(self.btnAnwer2,function()
        if self.data.anwserCallBack~=nil then
            self.data.anwserCallBack(self.data.index,2)
        end
    end);
end












function FriendChat_MyOptionItem:SetData(data)
    local maxLen=0;
    self.data=data.data
    if self.data.animatorType>0 then
        self.animator:Play("ani_FriendChatPanel_myMsg_root",0,0)
        self.data.animatorType=0;
    end
    self.nameText.text=self.data.chName;
    self.avatarImg.texture=LuaMgr.GetTexture(self.data.avatarPath)
    if IsNullOrEmpty(self.data.avatarFrame) then
        PlayerAvatarFrameTool.ClearImage(self.avatarFrameSprite)
        SetActive(self.avatarFrameSprite.gameObject,false)
    else
        SetActive(self.avatarFrameSprite.gameObject,true)
        PlayerAvatarFrameTool.SetAvatarFrame(self.avatarFrameSprite, self.data.avatarFrame)
    end
    self.nameBgRect.sizeDelta=Vector2(self.data.txtNameWidth,28)
    local msgs=NumTool.split(self.data.msg,"_");
    self.anwser1Text.text=msgs[1];
    local len1=self.anwser1Text.preferredWidth+26;
    self.anwser2Text.text=msgs[2]
    local len2=self.anwser2Text.preferredWidth+26;
    
    self.anwser1BgRect.sizeDelta=Vector2(len1>len2 and len1 or len2,48)
    self.anwser2BgRect.sizeDelta=Vector2(len2>len1 and len2 or len1,48)
    if maxLen<len1 then
        maxLen=len1;
    end
    if maxLen<len2 then
        maxLen=len2;
    end
    if maxLen<self.data.txtNameWidth then
        maxLen=self.data.txtNameWidth
    end
    self.msgRect.sizeDelta=Vector2(maxLen+20,126);
    self:UpdateOption(self.data.optionIndex)
    
end


function FriendChat_MyOptionItem:UpdateOption(index)
    SetActive(self.anwser1BgRect.transform.gameObject,index<2);
    SetActive(self.anwser2BgRect.transform.gameObject,index~=1)
    self.msgRect.sizeDelta=Vector2(self.msgRect.sizeDelta.x,index==0 and 126 or 78);
end


function FriendChat_MyOptionItem:Clear()
    PlayerAvatarFrameTool.ClearImage(self.avatarFrameSprite)
    self.data=nil;
end


function FriendChat_MyOptionItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.avatarFrameSprite)
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.avatarImg=nil;
    self.avatarFrameSprite=nil;
    self.msgRect=nil;
    self.nameText=nil;
    self.anwser1BgRect=nil;
    self.anwser1Text=nil;
    self.anwser2BgRect=nil;
    self.anwser2Text=nil;
    self.btnAnwer1=nil;
    self.btnAnwer2=nil;
    self.animator=nil;
end

