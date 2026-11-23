FriendChat_HelpFightInfoItem = {};

FriendChat_HelpFightInfoItem.__index = FriendChat_HelpFightInfoItem;

local objs = {
    goUpLine={path="root/upLine",type="GameObject"},
    goDownLine={path="root/downLine",type="GameObject"},
    goOdd={path="root/isOdd",type="GameObject"},
    rawHeadIcon={path="root/rawHeadIcon",type="RawImage"},
    btnHead={path="root/rawHeadIcon",type="Button"},
    imgHeadFrame={path="root/rawHeadIcon/headFrame",type="Image"},
    txtName={path="root/name",type="Text"},
    txtSummer={path="root/summer",type="Text"},
    goType1={path="root/type1",type="GameObject"},
    goType2={path="root/type2",type="GameObject"},
    goType3={path="root/type3",type="GameObject"},
    btnType1Agree={path="root/type1/btnAgreeFriend",type="Button"},
    btnType1Refuse={path="root/type1/btnRefuseFriend",type="Button"},
    goType1Agreed={path="root/type1/agreed",type="GameObject"},
    goType1Refused={path="root/type1/refused",type="GameObject"},
    
    btnType2Add={path="root/type2/btnAddFriend",type="Button"},
    goType2Added={path="root/type2/added",type="GameObject"},
    
    btnType3Delete={path="root/type3/btnDeleteFriend",type="Button"},
    lv={path="root/LV",type="Text"},
    
   
}

function FriendChat_HelpFightInfoItem.New()
    local self = {};
    setmetatable(self, FriendChat_HelpFightInfoItem);
    return self;
end

function FriendChat_HelpFightInfoItem:Init()
    UITool.Parse(self.gameObject, self, objs);

    LuaMgr.AddClick(self.btnHead,function()
        if self.data.headCallBack~=nil then
            self.data.headCallBack(self.data.type,self.data.index,self.transform)
        end
    end);
    LuaMgr.AddClick(self.btnType1Agree,function()
        if self.data.type1AgreeOrRefuse~=nil then
            self.data.type1AgreeOrRefuse(self.data.index,true)
        end
    end);
    LuaMgr.AddClick(self.btnType1Refuse,function()
        if self.data.type1AgreeOrRefuse~=nil then
            self.data.type1AgreeOrRefuse(self.data.index,false)
        end
    end);
    LuaMgr.AddClick(self.btnType2Add,function()
        if self.data.type2AddFriendCallBack~=nil then
            self.data.type2AddFriendCallBack(self.data.index)
        end
    end);
    LuaMgr.AddClick(self.btnType3Delete,function()
        if self.data.type3DeleteCallBack~=nil then
            self.data.type3DeleteCallBack(self.data.index);
        end
    end);
end


function FriendChat_HelpFightInfoItem:SetData(data)
    self.data=data.data
    SetActive(self.goUpLine,false)
    SetActive(self.goDownLine,true)
    SetActive(self.goOdd,self.data.index%2~=0)
    self.rawHeadIcon.texture=LuaMgr.GetTexture(self.data.avatarPath)
    PlayerAvatarFrameTool.SetAvatarFrame(self.imgHeadFrame, self.data.avatarFrame)
    self.txtName.text=self.data.name
    self.txtSummer.text=self.data.motto
    self.lv.text=self.data.lv;
    SetActive(self.goType1,self.data.type==1)
    SetActive(self.goType2,self.data.type==2)
    SetActive(self.goType3,self.data.type==3)
    
    SetActive(self.goType1Agreed,self.data.isType1Agree)
    SetActive(self.goType1Refused,self.data.isType1Refuse)
    self:SetType2Added(self.data.isType2Add)
    
end

function FriendChat_HelpFightInfoItem:SetType1AgreeOrRefuse(isOn)
    SetActive(self.goType1Agreed,isOn)
    SetActive(self.goType1Refused,not isOn)
end

function FriendChat_HelpFightInfoItem:SetType2Added(isOn)
    SetActive(self.goType2Added,isOn)
    SetActive(self.btnType2Add.gameObject,not isOn);
end

function FriendChat_HelpFightInfoItem:SetType1Agree(isAgree)
    SetActive(self.btnType1Agree.gameObject,false)
    SetActive(self.btnType1Refuse.gameObject,false)
    SetActive(self.goType1Agreed,isAgree)
    SetActive(self.goType1Refused,not isAgree);
end


function FriendChat_HelpFightInfoItem:Clear()
    PlayerAvatarFrameTool.ClearImage(self.imgHeadFrame)
    self.data=nil;
end


function FriendChat_HelpFightInfoItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.imgHeadFrame)
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.goUpLine=nil;
    self.goDownLine=nil;
    self.goOdd=nil;
    self.rawHeadIcon=nil;
    self.imgHeadFrame=nil;
    self.txtName=nil;
    self.txtSummer=nil;
    self.goType1=nil;
    self.goType2=nil;
    self.goType3=nil;
    self.btnType1Agree=nil;
    self.btnType1Refuse=nil;
    self.goType1Agreed=nil;
    self.goType1Refused=nil;

    self.btnType2Add=nil;
    self.goType2Added=nil;

    self.btnType3Delete=nil;
    self.lv=nil
end

