UI2048RankItem = {}

UI2048RankItem.__index = UI2048RankItem

function UI2048RankItem.New()
    local self = {}
    setmetatable(self, UI2048RankItem)
    return self
end

function UI2048RankItem:Init()
	local uiLink = self.gameObject:GetComponent("UILink");
		self.goBG2 = uiLink:Get("goBG2");
		self.goHeadEmptyIcon = uiLink:Get("goHeadEmptyIcon");
		self.imgLevelBg = uiLink:Get("imgLevelBg"):GetComponent("Image");
		self.imgHeadBGS = uiLink:Get("imgHeadBGS"):GetComponent("Image");
		self.textLevel = uiLink:Get("textLevel"):GetComponent("Text");
		self.textScore = uiLink:Get("textScore"):GetComponent("Text");
		self.textHeroName = uiLink:Get("textHeroName"):GetComponent("Text");
		self.rawImageHeadIcon = uiLink:Get("rawImageHeadIcon"):GetComponent("RawImage");
end

local LevelBG={
    [1]="ui_jj_2048_phb_1",
    [2]="ui_jj_2048_phb_2",
    [3]="ui_jj_2048_phb_3",
}
function UI2048RankItem:SetData(data)
    SetActive(self.gameObject, true);
    self.data = data.data

    local Dataavatar, DataavatarFrame = self:OnAvatarRefresh(self.data.Avatar, self.data.CurrentAvatarFrame)
    if self.data.Index<=3 then
        SetActive(self.goBG2,true);
        self.imgLevelBg.sprite=LuaMgr.GetSprite("2048Panel",LevelBG[self.data.Index]);
    else
        SetActive(self.goBG2,false);
        self.imgLevelBg.sprite=LuaMgr.GetSprite("2048Panel","ui_jj_2048_phb_4");
    end
    self.textLevel.text=tostring(self.data.Index);
    self.textScore.text=tostring(self.data.Score)
    self.textHeroName.text=self.data.Name
    if Dataavatar==nil then
        SetActive(self.goHeadEmptyIcon,true);
        SetActive(self.rawImageHeadIcon.gameObject,false);
        SetActive(self.imgHeadBGS.gameObject,false);
    else
        SetActive(self.goHeadEmptyIcon,false);
        SetActive(self.rawImageHeadIcon.gameObject,true);
        SetActive(self.imgHeadBGS.gameObject,true);
        self.rawImageHeadIcon.texture=Dataavatar;
    end
    PlayerAvatarFrameTool.SetAvatarFrame(self.imgHeadBGS, DataavatarFrame)

end


function UI2048RankItem:OnAvatarRefresh(currentavaratr, currentframe)
    local avatarTexture = nil
    local avatarFrameId = nil
    local avatarData = nil;
    local frameData = nil;
    for i, v in ipairs(ConfigMgr.Config.avatarFrames) do
        if v.id == currentavaratr then
            avatarData = v;
        elseif v.id == currentframe then
            frameData = v;
        end
        if avatarData ~= nil and frameData ~= nil then
            break;
        end
    end
    if avatarData ~= nil then
        local avatarPath = ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId);
        avatarTexture = LuaMgr.GetTexture(avatarPath);
    end
    if frameData ~= nil then
        avatarFrameId = frameData.id;
    end
    return avatarTexture, avatarFrameId
end


function UI2048RankItem:Hide()
    SetActive(self.gameObject, false);
end

function UI2048RankItem:Clear()
    PlayerAvatarFrameTool.ClearImage(self.imgHeadBGS)
    self.data = nil
    SetActive(self.gameObject, false);
end

function UI2048RankItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.imgHeadBGS)
	self.gameObject = nil
	self.transform = nil
    self.goBG2 = nil;
    self.goHeadEmptyIcon = nil;
    self.imgLevelBg = nil;
    self.imgHeadBGS = nil;
    self.textLevel = nil;
    self.textScore = nil;
    self.textHeroName = nil;
    self.rawImageHeadIcon = nil;
    LuaMgr.DestroyImmediateGO(self.gameObject)
end