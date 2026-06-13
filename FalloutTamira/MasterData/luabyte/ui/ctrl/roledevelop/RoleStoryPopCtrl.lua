-- RoleStoryContent
local RoleStoryPopCtrl = BaseClass("RoleStoryPopCtrl", BaseUICtrl)
local M = RoleStoryPopCtrl
local MessageId = Proto.MessageId
local sfmt = string.format

function M:Init()
    self._view.Mask:onClick(Bind(self, self.Close))
    self._view.Btn_Home:onClick(Bind(self, self.ReturnMainUI))
    self._view.itemPfb.onClick = Bind(self, self.RequestPersonalityStory)
end

function M:OnEnter(heroData, idx, closeFunc)   
    self.heroData = heroData
    self.idx = idx
    self.closeFunc = closeFunc
    self.heroPersona = ConfigHelper.GetCfg("heroPersona", heroData:GetSkinId())
    GameHelper.PlayAudioById(self.heroPersona.storyBGM[idx])
    self._view.Title:SetText(self.heroPersona.storyTitle[idx])
    local str = ConfigHelper.GetLocalStringByPlayerName(self.heroPersona.storyDes[idx])
    self._view.Text:SetText(str)
    self._view.labNum:SetText(sfmt("%02d", idx))
    if self._view.TextContent then
        self._view.TextContent:SetLocalPos(0, 0, 0)
    end
    self:_InitReward()
end

function M:_InitReward()
    local isReceive = self:_CheckItemState()
    if isReceive then
        self._view.itemPfb:SetActive(false)
        return
    end
    local itemGroupId = self.heroPersona.storyReward[self.idx]
    local itemGroup = ConfigHelper.GetCfg("itemGroup", itemGroupId)
    local rewardId = itemGroup.items[1]
    local rewardNum = itemGroup.cnts[1]
    self._view.itemPfb:SetInfo(rewardId, ItemNumberType.TOTLE, rewardNum)
    self._view.itemPfb:SetActive(true)
end

function M:_CheckItemState()
    self.storyLv = self.heroData:GetPersonalityStory()
    local limitLv = self.heroPersona.storyLimit[self.idx]
    local status = self.storyLv & (1 << limitLv)
    return status > 0
end

function M:RequestPersonalityStory()
    self._tempResponsePersonalityStoryCallback = NetPack:RegistResponse(MessageId.ResponsePersonalityStory, Bind(self, self._ResponsePersonalityStoryCallback))
    local request = {}
    request.HeroId = self.heroData:GetHeroId()
    request.Grade = self.heroPersona.storyLimit[self.idx]
    NetPack:SendMessage(MessageId.RequestPersonalityStory, request)
end

function M:_ResponsePersonalityStoryCallback(_, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponsePersonalityStory, self._tempResponsePersonalityStoryCallback)
    self._tempResponsePersonalityStoryCallback = nil
    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end
    self.heroData:SetPersonalityStory(msg.PersonalityStory)
    RedPointMgr:ForceCheck(RedPointConst.HeroStoryRedPointChecker)
    local awards = {}
    for _, item in ipairs(msg.Awards or {}) do
        awards[item.Id] = item.Cnt
    end
    GameHelper.ShowGetItems(awards)
    self:_InitReward()
    self.needRef = true
end

-- 点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:Close()
    GameHelper.DoPlayerAction(PlayerAction.OpenHero)
    if self.needRef and self.closeFunc then
        self:closeFunc()
    end
    self.closeFunc = nil
    M.super.Close(self)
end
return RoleStoryPopCtrl
