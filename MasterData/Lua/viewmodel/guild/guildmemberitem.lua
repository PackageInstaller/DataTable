GuildMemberItem = {};

GuildMemberItem.__index = GuildMemberItem;

require("ViewModel/Common/PlayerAvatarFrameTool")

local onLineTextColor = "#f6f3ed"
local offLineTextColor = "#f6f3ed"
local onLineOutLineColor = "#c58775"
local offLineOutLineColor = "#c58775"

local onLineStatusColor = "#3f8b79"
local offLineStatusColor = "#9f8c6d"

local objs = {
    avatar = { path="headInfo/avatar", type = "RawImage" },
    avatarFrame = { path = "headInfo/avatarFrame", type = "Image" },
    playerName = { path = "playerName", type = "Text" },
    playerLv = { path = "playerLv", type = "Text" },
    job = { path = "job", type = "Text" },
    weekContribution = { path = "weekContribution", type = "Text" },
    totalContribution = { path = "totalContribution", type = "Text"} ,
    status = { path = "status", type = "Text" },
    onLineBg = {path = "online",type = "Button"},
    offLineBg = {path = "offline",type = "Button"},
    selectImg = {path = "select",type = "GameObject"},
    playerDynamicAvatar = { path = "headInfo/DynamicAvatar", type = "PlayerDynamicAvatar" },
    playerTitle = { path="PlayerTitle", type = "Image" },
    playerTitleText = { path="PlayerTitle/Text", type = "Text" },
    titleTextPos = { path="PlayerTitle/Text", type = "RectTransform" },
}

function GuildMemberItem.New()
    local self = {};
    setmetatable(self, GuildMemberItem);
    return self;
end

function GuildMemberItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.playerAvatarFrameTool = PlayerAvatarFrameTool.New(self.avatarFrame)
    LuaMgr.AddClick(self.onLineBg,function()
        if self.data.CallBack ~= nil then
            self.data.CallBack(self);
        end
    end);
    LuaMgr.AddClick(self.offLineBg,function()
        if self.data.CallBack ~= nil then
            self.data.CallBack(self);
        end
    end);
end

function GuildMemberItem:SetData(data)
    self.data = data.data

    local title = ConfigHelper.GetTitleConfig(self.data.info.title)
    if not TableIsNull(title) then
        self.playerTitle.sprite = LuaMgr.GetSprite("PlayerTitle",title.img)
        self.playerTitleText.text = LuaMgr.GetLangText(title.namelan)
        if title.img == "Title_40001" then
           self.titleTextPos.anchoredPosition =  Vector2(2,1)
        else
           self.titleTextPos.anchoredPosition =  Vector2(10,1)
        end
    end
    self.playerName.text = self.data.info.name
    self.job.text = PlayerGuildMgr.GetJobName(self.data.info.job)
    self.playerLv.text = self.data.info.level
    self.totalContribution.text = tostring(self.data.info.totalContribution)
    self.weekContribution.text = self.data.info.weekContribution
    SetActive(self.onLineBg.gameObject,self.data.info.onLine);
    SetActive(self.offLineBg.gameObject,not self.data.info.onLine)
    if self.data.info.onLine then
        self.status.text = self:SetTextColor(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_17008"),onLineStatusColor);
    else
        local day, hour, minute = GetTimeDHM(self.data.info.offLineTime)
        local timeStr = ""

        if IsNullOrEmpty(hour) then
            timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["17010"].NameLan), minute)
        end
        if IsNullOrEmpty(day) then
            timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["17011"].NameLan), hour)
        else
            timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["17012"].NameLan), day)
        end
        self.status.text = self:SetTextColor(timeStr,offLineStatusColor)
    end
    
    
    local length = #ConfigMgr.Config.avatarFrames
    local avatarConfig = nil
    if not IsNullOrEmpty(data.data.info.avatar) then
        for i = 1, length do
            if ConfigMgr.Config.avatarFrames[i].id == data.data.info.avatar then
                avatarConfig = ConfigMgr.Config.avatarFrames[i]
                break
            end
        end
    end
    SetActive(self.avatar.gameObject,false)
    SetActive(self.playerDynamicAvatar.gameObject,false)
    if not TableIsNull(avatarConfig) then
        if avatarConfig.imgType == 1 then
            local avatarPath = ConfigHelper.GetHeadIconPath(avatarConfig.img, avatarConfig.imgId);
            self.avatar.texture = LuaMgr.GetTexture(avatarPath);
            SetActive(self.avatar.gameObject,true)
        elseif avatarConfig.imgType == 2 then
            self.playerDynamicAvatar:AppointAvatar(avatarConfig.id)
            SetActive(self.playerDynamicAvatar.gameObject,true)
        end
    end

    avatarConfig = nil
    for i = 1, length do
        if ConfigMgr.Config.avatarFrames[i].id == data.data.info.avatarFrame then
            avatarConfig = ConfigMgr.Config.avatarFrames[i]
            break
        end
    end
    if not TableIsNull(avatarConfig) then
        self.playerAvatarFrameTool:AppointAvatarFrame(avatarConfig.id);
    else
        self.playerAvatarFrameTool:Clear()
    end
    
    local outlineComponent = self.playerName.gameObject:GetComponent("OutlineEx")



    SetActive(self.selectImg,false)
end

function GuildMemberItem:HexToColorManual(hex)
    hex = string.gsub(hex, "#", "")

    local r, g, b, a = 1, 1, 1, 1

    if #hex == 6 then
        r = tonumber(string.sub(hex, 1, 2), 16) / 255
        g = tonumber(string.sub(hex, 3, 4), 16) / 255
        b = tonumber(string.sub(hex, 5, 6), 16) / 255

    else
        return CS.UnityEngine.Color.white
    end

    return CS.UnityEngine.Color(r, g, b, a)
end

function GuildMemberItem:SetTextColor(text,color)
    return "<color=" .. color .. ">" .. text .. "</color>"
end

function GuildMemberItem:Clear()
    if self.playerAvatarFrameTool ~= nil then
        self.playerAvatarFrameTool:Clear()
    end
    self.data = nil;
end

function GuildMemberItem:Select(select)
    SetActive(self.selectImg,select)
end

function GuildMemberItem:Destroy()
    if self.playerAvatarFrameTool ~= nil then
        self.playerAvatarFrameTool:Dispose()
        self.playerAvatarFrameTool = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.btn = nil
    self.avatar = nil
    self.avatarFrame = nil
    self.playerName = nil
    self.playerLv = nil
    self.job= nil
    self.weekContribution = nil
    self.totalContribution = nil
    self.status = nil
end

