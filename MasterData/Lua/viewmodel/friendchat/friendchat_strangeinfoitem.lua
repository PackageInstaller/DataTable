FriendChat_StrangeInfoItem = {};

FriendChat_StrangeInfoItem.__index = FriendChat_StrangeInfoItem;

local objs = {
    goUpLine={path="root/upLine",type="GameObject"},
    goDownLine={path="root/downLine",type="GameObject"},
    goOdd={path="root/isOdd",type="GameObject"},
    rawHeadIcon={path="root/rawHeadIcon",type="RawImage"},
    btnHead={path="root/rawHeadIcon",type="Button"},
    imgHeadFrame={path="root/headFrame",type="Image"},
    txtName={path="root/name",type="Text"},
    txtSummer={path="root/summer",type="Text"},
    goType1={path="root/type1",type="GameObject"},
    goType2={path="root/type2",type="GameObject"},
    goType3={path="root/type3",type="GameObject"},
    btnType1Agree={path="root/type1/btnAgreeFriend",type="Button"},
    btnType1Refuse={path="root/type1/btnRefuseFriend",type="Button"},
    goType1Agreed={path="root/type1/agreed",type="GameObject"},
    goType1Refused={path="root/type1/refused",type="GameObject"},
    goExpend={path="root/summer/expend",type="GameObject"},
    
    btnType2Add={path="root/type2/btnAddFriend",type="Button"},
    goType2Added={path="root/type2/added",type="GameObject"},
    
    btnType3Delete={path="root/type3/btnDeleteFriend",type="Button"},
    lv={path="root/LV",type="Text"},
    assistContent={path="root/type2/assistContent",type="Transform"},
    playerDynamicAvatar = { path = "root/DynamicAvatar", type = "PlayerDynamicAvatar" },
    playerTitle = {path="root/name/PlayerTitle",type="Image"},
    playerTitleText = {path="root/name/PlayerTitle/Text",type="Text"},
    titleTextPos = {path="root/name/PlayerTitle/Text",type="RectTransform"},
}

function FriendChat_StrangeInfoItem.New()
    local self = {};
    setmetatable(self, FriendChat_StrangeInfoItem);
    return self;
end

function FriendChat_StrangeInfoItem:Init()
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
    self.assistUIList=UIListView.New(self.assistContent)
end


function FriendChat_StrangeInfoItem:SetData(data)
    self.data=data.data
    SetActive(self.goUpLine,false)
    SetActive(self.goDownLine,true)
    SetActive(self.goOdd,self.data.index%2~=0)
    if self.data.isDynamicAvatar then
        self.playerDynamicAvatar:AppointAvatar(self.data.avatarId)
    else
        self.rawHeadIcon.texture=LuaMgr.GetTexture(self.data.avatarPath)
    end
    SetActive(self.playerDynamicAvatar.gameObject,self.data.isDynamicAvatar)
    SetActive(self.rawHeadIcon.gameObject,not self.data.isDynamicAvatar)
    PlayerAvatarFrameTool.SetAvatarFrame(self.imgHeadFrame, self.data.avatarFrame)

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
    self.txtName.text=self.data.name
    self.txtSummer.text=self.data.motto
    if self.txtSummer.preferredWidth>=360 then
        SetActive(self.goExpend,true);
    else
        SetActive(self.goExpend,false);
    end
    self.lv.text=self.data.lv;
    SetActive(self.goType1,self.data.type==1)
    SetActive(self.goType2,self.data.type==2)
    SetActive(self.goType3,self.data.type==3)
    
    SetActive(self.goType1Agreed,self.data.isType1Agree)
    SetActive(self.goType1Refused,self.data.isType1Refuse)
    local isType1Init=not self.data.isType1Agree and not self.data.isType1Refuse;
    SetActive(self.btnType1Agree.gameObject,isType1Init)
    SetActive(self.btnType1Refuse.gameObject,isType1Init)
    self:SetType2Added(self.data.isType2Add)
    if self.data.type==2 then
        self:SetAssistHeroList();
    end
end


function FriendChat_StrangeInfoItem:SetType1AgreeOrRefuse(isOn)
    SetActive(self.goType1Agreed,isOn)
    SetActive(self.goType1Refused,not isOn)
end

function FriendChat_StrangeInfoItem:SetType2Added(isOn)
    SetActive(self.goType2Added,isOn)
    SetActive(self.btnType2Add.gameObject,not isOn);
end

function FriendChat_StrangeInfoItem:SetType1Agree(isAgree)
    SetActive(self.btnType1Agree.gameObject,false)
    SetActive(self.btnType1Refuse.gameObject,false)
    SetActive(self.goType1Agreed,isAgree)
    SetActive(self.goType1Refused,not isAgree);
end

function FriendChat_StrangeInfoItem:SetAssistHeroList()
    local list={}
    if IsNull(self.data.characterData) or IsNull(self.data.characterData.CharacterInfoMap) then return end;
    self.ClickCallback=function(id)
        local assistData=self.data.characterData.CharacterInfoMap[id]
        assistData.uid=self.data.characterData.Name;
        PlayerAssistMgr.GoToPanel_HeroInfoStrange(assistData);
    end
    local tempRare = nil
    local imageRare = nil
    for i,v in pairs(self.data.characterData.CharacterInfoMap) do
        local cfgCharacter=ConfigMgr.Config.characterTable[v.Character.id]
        tempRare = self:GetHeroRare(v.Character)
        imageRare = tempRare >= 5 and 4 or tempRare
        local assistItem= {
            id = v.Character.id,
            imgHead = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(v.Character.id, v.Character.curSkin));
            rare = LuaMgr.GetSprite("AssistRare", "ui_sz_qzyz_tx0" .. imageRare);
            job = LuaMgr.GetSprite("JobIcon", "jobtips_" .. cfgCharacter.job);
            level = v.Character.level;
            clickCallBack = self.ClickCallback;
        }
        local dataItem=UIListData.GetData(self.data.assistObj,"FriendChat_AssistItem",assistItem);
        table.insert(list,dataItem);
    end
    self.assistUIList:SetData(list);
end

function FriendChat_StrangeInfoItem:GetHeroRare(character)
    local rare = 0
    local tempConfig = ConfigCharacterMgr.GetInfo(character.id)
    if not TableIsNull(tempConfig) then
        rare = tempConfig.rare
        if not TableIsNull(character) and type(character.brilliant) ~= "function" and not TableIsNull(character.brilliant) then
            rare = rare + character.brilliant.RareLevel
        end
    end
    return rare
end

function FriendChat_StrangeInfoItem:Clear()
    PlayerAvatarFrameTool.ClearImage(self.imgHeadFrame)
    self.data=nil;
    self.assistUIList:Clear()
end


function FriendChat_StrangeInfoItem:Destroy()
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
    self.goExpend=nil;
    self.playerDynamicAvatar = nil
end

