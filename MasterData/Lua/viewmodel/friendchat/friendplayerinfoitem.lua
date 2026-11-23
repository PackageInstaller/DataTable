require("ViewModel/FriendChat/FriendPlayerInfoAssistItem")
FriendPlayerInfoItem = {}

FriendPlayerInfoItem.__index = FriendPlayerInfoItem
local objs = {
    rectTransform = {path = "root", type = "RectTransform"},
    nameText = {path = "root/Left/imgBack/Info/textName",type = "Text"},
    playerAvatar = {path = "root/Left/imgBack/Info/bg/icon",type = "RawImage"},
    playerAvatarFrame = {path = "root/Left/imgBack/Info/bg/frame",type = "Image"},
    userLevel = {path = "root/Left/imgBack/Info/bg/Level",type = "Text"},
    teamName = {path = "root/Left/imgBack/Info/Team/bg/name",type = "Text"},
    teamIcon = {path = "root/Left/imgBack/Info/Team/bg/icon",type = "Image"},
    teamEffectObj = {path = "root/Left/imgBack/Info/Team/UI_Team_Sweep",type = "GameObject"},
    expSliderTr = {path = "root/Left/imgBack/Info/Image/Image",type = "RectTransform"},
    birthdayText = {path = "root/Left/imgBack/Info/birthday/Text",type = "Text"},
    uidText = {path = "root/Left/imgBack/Info/jjidBg/Text",type = "Text"},
    uidCopyBtn = {path = "root/Left/imgBack/Info/jjidBg/Button",type = "Button"},
    userMotto = {path = "root/Left/imgback2",type = "GameObject"},
    userMottoText = {path = "root/Left/imgback2/Text",type = "Text"},
    userTeamIcon = {path = "root/Middle/RawImage/icon",type = "Image"},
    unlockRawImage = {path = "root/Middle/unlockRaw",type = "RawImage"},
    unlockRawImageRect = {path = "root/Middle/unlockRaw",type = "RectTransform"},
    characterRect = {path = "root/Middle/Character",type = "RectTransform"},
    spineUICharacter = { path = "root/Middle/Character/Body", type = "UISpineCharacter" },
    drawingAdjustTool = { path = "root/Middle/Character/Body", type = "DrawingAdjustTool" },
    uiRefRawImage = { path = "root/Middle/Character/Body", type = "UIRefRawImage" },
    characterChallengeText1 = {path = "root/Left/OtherInfo/UserDevicerMapCollection/Pro/Text",type = "Text"},
    characterChallengeText2 = {path = "root/Left/OtherInfo/UserDevicerMapCollection/Pro/Text/Text",type = "Text"},
    characterChallengeSlider = {path = "root/Left/OtherInfo/UserDevicerMapCollection/Pro/grass",type = "Image"},
    equipmentChallengeText1 = {path = "root/Left/OtherInfo/UserEquipmentMapCollection/Pro/Text",type = "Text"},
    equipmentChallengeText2 = {path = "root/Left/OtherInfo/UserEquipmentMapCollection/Pro/Text/Text",type = "Text"},
    equipmentChallengeSlider = {path = "root/Left/OtherInfo/UserEquipmentMapCollection/Pro/grass",type = "Image"},
    userChallengeText = {path = "root/Left/OtherInfo/UserPassBlock/Text",type = "Text"},
    userChallengeComplete = {path = "root/Left/OtherInfo/UserPassBlock/Complete",type = "GameObject"},
    sealBtn = {path = "root/Right/seal/Image/btn",type = "Button"},
    sealRawImage_0 = {path = "root/Right/seal/seal_0",type = "RawImage"},
    sealRawImage_1 = {path = "root/Right/seal/seal_1",type = "RawImage"},
    sealRawImage_2 = {path = "root/Right/seal/seal_2",type = "RawImage"},
    sealRawImage_3 = {path = "root/Right/seal/seal_3",type = "RawImage"},
    sealRawImage_4 = {path = "root/Right/seal/seal_4",type = "RawImage"},
    sealRawImage_5 = {path = "root/Right/seal/seal_5",type = "RawImage"},
    sealRawImage_6 = {path = "root/Right/seal/seal_6",type = "RawImage"},
    subListContent = {path = "root/Right/SubList", type = "GameObject"},
    changeBtn = {path = "root/Right/SubList/changeBtn",type = "Button"},
    shareBtn = {path = "root/Right/SubList/shareBtn",type = "Button"},
    changeBtnRed = {path = "root/Right/SubList/changeBtn/Red",type = "GameObject"},
    assistContent={path = "root/Left/assistHeros/heads/ScrollView/Viewport/Content",type = "Transform"},
    dynamicAvatar = {path = "root/Left/imgBack/Info/bg/dynamicAvatar",type = "PlayerDynamicAvatar"},
    medalIcon_0 = {path = "root/Right/Medal/Icon1",type = "Image"},
    medalIcon_1 = {path = "root/Right/Medal/Icon2",type = "Image"},
    medalIcon_2 = {path = "root/Right/Medal/Icon3",type = "Image"},
    medalIcon_3 = {path = "root/Right/Medal/Icon4",type = "Image"},
    medalIcon_4 = {path = "root/Right/Medal/Icon5",type = "Image"},
    medalIcon_5 = {path = "root/Right/Medal/Icon6",type = "Image"},
    medalIcon_6 = {path = "root/Right/Medal/Icon7",type = "Image"},
    medalIcon_7 = {path = "root/Right/Medal/Icon8",type = "Image"},
    medalIcon_8 = {path = "root/Right/Medal/Icon9",type = "Image"},
    playerTitle = {path="root/Left/imgBack/Info/PlayerTitle",type="Image"},
    playerTitleText = {path="root/Left/imgBack/Info/PlayerTitle/Text",type="Text"},
    titleTextPos = {path="root/Left/imgBack/Info/PlayerTitle/Text",type="RectTransform"},
}

function FriendPlayerInfoItem.New()
    local self = {}
    setmetatable(self, FriendPlayerInfoItem)
    return self
end

function FriendPlayerInfoItem:Init(skinId)
    UITool.Parse(self.gameObject, self, objs)
    self.sealList = {
        self.sealRawImage_0,
        self.sealRawImage_1,
        self.sealRawImage_2,
        self.sealRawImage_3,
        self.sealRawImage_4,
        self.sealRawImage_5,
        self.sealRawImage_6,
    }
    self.medalList = {
        self.medalIcon_0,
        self.medalIcon_1,
        self.medalIcon_2,
        self.medalIcon_3,
        self.medalIcon_4,
        self.medalIcon_5,
        self.medalIcon_6,
        self.medalIcon_7,
        self.medalIcon_8,
    }
    self.skinId = skinId
    self.assistList=UIListView.New(self.assistContent);

    self.OnClickChangeSkinBtn = function()
        if self.data.OnClickChangeSkinBtn ~= nil then
            self.data.OnClickChangeSkinBtn()
        end
    end
    self.OnClickShareBtn = function()
        if self.data.OnClickShareBtn ~= nil then
            self.data.OnClickShareBtn()
        end
    end
    self.CopyToClipboard = function()
        if self.data.CopyToClipboard ~= nil then
            self.data.CopyToClipboard()
        end
    end
    self.OnClickSealBtn = function()
        if self.data.OnClickSealBtn ~= nil then
            self.data.OnClickSealBtn()
        end
    end
    LuaMgr.AddClick(self.changeBtn,self.OnClickChangeSkinBtn);
    LuaMgr.AddClick(self.shareBtn,self.OnClickShareBtn);
    LuaMgr.AddClick(self.uidCopyBtn,self.CopyToClipboard);
    LuaMgr.AddClick(self.sealBtn,self.OnClickSealBtn);
end

function FriendPlayerInfoItem:SetData(data)
    self.data = data
    self.rectTransform.localScale = self.data.localScale
    self.rectTransform.anchoredPosition = self.data.anchoredPosition
    self.rectTransform.sizeDelta = self.data.sizeDelta
    self.subListContent:SetActive(self.data.showSubList)


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
    self.nameText.text = self.data.userName
    if self.data.isDynamicAvatar then
        self.dynamicAvatar:AppointAvatar(self.data.avatarId)
    else
        self.playerAvatar.texture = self.data.playerAvatar
    end
    SetActive(self.dynamicAvatar.gameObject,self.data.isDynamicAvatar)
    SetActive(self.playerAvatar.gameObject,not self.data.isDynamicAvatar)
    PlayerAvatarFrameTool.SetAvatarFrame(self.playerAvatarFrame, self.data.playerAvatarFrameId)
    self.userLevel.text = self.data.userLevel
    self.teamName.text = self.data.userTeam
    self.teamIcon.sprite = self.data.userTeamIcon
    self.teamEffectObj:SetActive(self.data.isShowEffect)
    self.expSliderTr.localScale = self.data.expScaleData
    self.birthdayText.text = self.data.playerBirthDay
    self.uidText.text = self.data.userID
    self.userMotto:SetActive(self.data.showMotto)
    self.userMottoText.text = self.data.userMotto

    self.uidCopyBtn.gameObject:SetActive(false)

    local teamIcon = self.data.userTeamIcon_b
    if self.skinId ~= "PF01" then
        teamIcon = self.data.userTeamIcon_b .. self.skinId
    end
    self.userTeamIcon.sprite = LuaMgr.GetSprite("PlayerFigure", teamIcon)
    self.userTeamIcon.gameObject:SetActive(true)
    self.unlockRawImage.texture = self.data.unLockRawImg
    self.unlockRawImageRect.gameObject:SetActive(self.data.unLockRawImgBool)
    self.unlockRawImageRect.anchoredPosition = self.data.unLockRawAnchoredPos
    self.characterRect.anchoredPosition = self.data.characterAnchoredPos
    SetActive(self.characterRect.gameObject, true)
    local path = HeroManager.SetCharacterDrawing(self.spineUICharacter, self.data.curSkinId)
    if path ~= "" then
        self.data.bodyRawBool = true
        self.data.characterPath = path
        self.drawingAdjustTool.Sprite = self.data.characterPath
    end
    self.uiRefRawImage.enabled = self.data.bodyRawBool
    

    
    self.characterChallengeText1.text = self.data.characterCount
    self.characterChallengeText2.text = string.format("/%s", self.data.allCharacterCount)
    self.characterChallengeSlider.fillAmount = self.data.characterChallengeFill
    self.equipmentChallengeText1.text = self.data.equipmentCount
    self.equipmentChallengeText2.text = string.format("/%s", self.data.allEquipmentCount)
    self.equipmentChallengeSlider.fillAmount = self.data.equipmentChallengeFill
    self.userChallengeText.text = self.data.userChallenge
    self.userChallengeComplete:SetActive(self.data.userChallengeCompleteBool)

    self.sealBtn.gameObject:SetActive(false)
    for i, v in ipairs(self.data.sealList) do
        self.sealList[i].gameObject:SetActive(v.isOn)
        self.sealList[i].texture = v.texture
    end
    for i = 1, #self.data.medalList do
        self.medalList[i].gameObject:SetActive(self.data.medalList[i].isOn)
        self.medalList[i].sprite = self.data.medalList[i].texture
    end
    local redCount = FriendChatMgr.CheckFriendPlayerInfoRed_Badge() + FriendChatMgr.CheckFriendPlayerInfoRed_Theme()
    SetActive(self.changeBtnRed, redCount > 0)
    self:SetAssistHeros();
end

function FriendPlayerInfoItem:SetActive(active)
    self.gameObject:SetActive(active)
end

function FriendPlayerInfoItem:Clear()
    PlayerAvatarFrameTool.ClearImage(self.playerAvatarFrame)
    if self.data ~= nil then
        if self.data.OnClickChangeSkinBtn ~= nil then
            LuaMgr.RemoveClick(self.changeBtn, self.data.OnClickChangeSkinBtn)
        end
        if self.data.OnClickShareBtn ~= nil then
            LuaMgr.RemoveClick(self.shareBtn, self.data.OnClickShareBtn)
        end
        if self.data.CopyToClipboard ~= nil then
            LuaMgr.RemoveClick(self.uidCopyBtn, self.data.CopyToClipboard)
        end
        if self.data.OnClickSealBtn ~= nil then
            LuaMgr.RemoveClick(self.sealBtn, self.data.OnClickSealBtn)
        end
    end
    self.data = nil
    if self.spineUICharacter ~= nil then
        self.spineUICharacter:Clear()
    end
    self.gameObject:SetActive(false)
end


function FriendPlayerInfoItem:SetAssistHeros()
    local isSelf=self.data.userID==DataMgr.Player.uid;
    local assistData={}
    if isSelf then
        for i,v in ipairs(DataMgr.Player.FriendHelp.HelpCharacterIds) do
            table.insert(assistData,DataMgr.Player.characters[v]);
        end
    else
        local assistCharacterMap=PlayerAssistMgr.GetAssistCharacters(self.data.userID)
        if assistCharacterMap~=nil then
            for i,v in pairs(assistCharacterMap) do
                table.insert(assistData,v.Character);
            end
        end
    end
    if IsNull(assistData) or #assistData==0 then
        self.assistList:Clear();
        return
    end;
    self.ClickCallback=function(index)
        local uid=nil;
        if not isSelf then
            uid=self.data.userID;
        end
        PlayerAssistMgr.GoToPanel_HeroInfo(assistData[index].id,uid)
    end
    local list={}
    local tempRare = nil
    local imageRare = nil
    for i,v in ipairs(assistData) do
        local cfgCharacter=ConfigMgr.Config.characterTable[v.id]
        tempRare = self:GetHeroRare(v)
        local assistItem={
            index=i,
            imgHead=LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(v.id,v.curSkin));
            rare=nil;
            job=LuaMgr.GetSprite("JobIcon","jobtips_"..cfgCharacter.job);
            level=v.level;
            clickCallBack=self.ClickCallback;
        }
        imageRare = tempRare >= 5 and 4 or tempRare
        assistItem.rare = LuaMgr.GetSprite("AssistRare","ui_sz_qzyz_tx0"..imageRare)
        local itemData=UIListData.GetData(self.assistItem,"FriendPlayerInfoAssistItem",assistItem);
        table.insert(list,itemData);
    end
    self.assistList:SetData(list);
end

function FriendPlayerInfoItem:GetHeroRare(character)
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


function FriendPlayerInfoItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.playerAvatarFrame)
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end