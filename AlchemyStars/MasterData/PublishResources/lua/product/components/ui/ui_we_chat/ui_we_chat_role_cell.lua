_class("UIWeChatRoleCell", UICustomWidget)
UIWeChatRoleCell = UIWeChatRoleCell
local StringGet = StringTable.Get

function UIWeChatRoleCell:OnShow()
  self.trans = self:GetGameObject().transform
  self.nameTxt = self:GetUIComponent("UILocalizationText", "name")
  self.enNameTxt = self:GetUIComponent("UILocalizationText", "enname")
  self.picImg = self:GetUIComponent("RawImageLoader", "pic")
  self.friendGO = self:GetGameObject("friend")
  self.friendTxt = self:GetUIComponent("UILocalizationText", "friendtxt")
  self.friendFillImage = self:GetUIComponent("Image", "friendfill")
  self.unReadGO = self:GetGameObject("unread")
  self.unReadTxt = self:GetUIComponent("UILocalizationText", "unreadtxt")
  self.changeNameGO = self:GetGameObject("changenamebtn")
  self.changeNameGO:SetActive(false)
  self.choose1GO = self:GetGameObject("choose1")
  self.choose1GO:SetActive(false)
  self.choose2GO = self:GetGameObject("choose2")
  self.choose2GO:SetActive(false)
  self.redGO = self:GetGameObject("red")
  self._timeOut = self:GetGameObject("timeOut")
  self._timeOut:SetActive(false)
  self.atlas = self:GetAsset("UIWeChat.spriteatlas", LoadType.SpriteAtlas)
  self.module = self:GetModule(QuestChatModule)
  self.weChatProxy = self.module:GetWeChatProxy()
  self.animation2 = self:GetGameObject("choose2"):GetComponent(typeof(UnityEngine.Animation))
  self.trans = self:GetGameObject().transform
  self._spBtn = self:GetGameObject("SpBtn")
  self._spRed = self:GetGameObject("spRed")
  self._spRed:SetActive(false)
  self._spBtn:SetActive(false)
end

function UIWeChatRoleCell:CheckSpBtn()
  if self._weChatRoleList:RoleCount() > 1 then
    self._spBtn:SetActive(true)
  else
    self._spBtn:SetActive(false)
  end
end

function UIWeChatRoleCell:SpBtnOnClick(go)
  self._weChatRoleList:AddIdx()
  self.weChatRole = self._weChatRoleList:CurrentRole()
  self:OnValue()
  self:bgbtnOnClick()
end

function UIWeChatRoleCell:OnHide()
end

function UIWeChatRoleCell:OnValue()
  self.nameTxt:SetText(self.weChatRole:GetName())
  self.enNameTxt:SetText(self.weChatRole:GetEnName())
  local speakerid = self.weChatRole:GetSpeakerId()
  local cfg_quest_chat_speaker = Cfg.cfg_quest_chat_speaker[speakerid]
  if cfg_quest_chat_speaker == nil then
    Log.fatal("###[UIWeChatRoleCell] cfg_quest_chat_speaker is nil ! id --> ", speakerid)
    return
  end
  local picName
  if cfg_quest_chat_speaker.SpeakerType == 1 then
    local petid = cfg_quest_chat_speaker.TemplateID
    if petid ~= 0 then
      local petModule = GameGlobal.GetModule(PetModule)
      local matchPet = petModule:GetPetByTemplateId(petid)
      if matchPet then
        picName = matchPet:GetPetTeamBody(PetSkinEffectPath.CARD_WE_CHAT_ROLE)
      end
    end
  end
  picName = picName or cfg_quest_chat_speaker.Icon
  self.picImg:LoadImage(picName)
  local unReadCount = self.weChatRole:GetUnReadCount()
  if 0 < unReadCount then
    self.unReadGO:SetActive(true)
    self.unReadTxt:SetText(unReadCount)
    self:ShowRed(false)
  else
    self.unReadGO:SetActive(false)
    local lastTalk = self.weChatRole:GetLastTalk()
    if lastTalk and lastTalk.options then
      self:ShowRed(true)
    else
      self:ShowRed(false)
    end
  end
  local friendCount = self.weChatRole:GetFriendCount()
  if 0 <= friendCount then
    local maxCount = self.weChatRole:GetFriendMaxCount()
    self.friendGO:SetActive(true)
    self.friendTxt:SetText(friendCount)
    self.friendFillImage.fillAmount = self.weChatRole:GetFriendRate()
  else
    self.friendGO:SetActive(false)
  end
  local spRed = false
  if 1 < self._weChatRoleList:RoleCount() then
    local roleList = self._weChatRoleList:RoleList()
    for i = 1, #roleList do
      local item = roleList[i]
      if item:GetSpeakerId() ~= self.weChatRole:GetSpeakerId() then
        local count = item:GetUnReadCount()
        if 0 < count then
          spRed = true
          break
        else
          local lastTalk = item:GetLastTalk()
          if lastTalk and lastTalk.options then
            spRed = true
            break
          end
        end
      end
    end
  end
  self._spRed:SetActive(spRed)
end

function UIWeChatRoleCell:SetData(group, onClickCell, onClickChangeName, selectSpeakerId)
  if group then
    self._weChatRoleList = group
    local select = false
    local roleList = self._weChatRoleList:RoleList()
    for i = 1, #roleList do
      local role = roleList[i]
      local speakerid = role:GetSpeakerId()
      if speakerid == selectSpeakerId then
        select = true
        self.weChatRole = role
        self._weChatRoleList:SetIdx(i)
        break
      end
    end
    if not select then
      self.weChatRole = self._weChatRoleList:CurrentRole()
    end
    self:Select(select, true)
  end
  self:CheckSpBtn()
  if onClickCell then
    self.onClickCell = onClickCell
  end
  if onClickChangeName then
    self.onClickChangeName = onClickChangeName
  end
  self:OnValue()
end

function UIWeChatRoleCell:CheckTimeOut()
  local id = self.weChatRole:GetSpeakerId()
  local lastTalk = self.weChatRole:GetLastTalk()
  if lastTalk then
    local chatid = lastTalk.chatId
    local cfg = Cfg.cfg_quest_chat[chatid]
    local isRandom = false
    if cfg.TriggerType == 1 and not lastTalk.isEnd then
      isRandom = true
    end
    self:ShowItemOut(isRandom)
  end
end

function UIWeChatRoleCell:ShowItemOut(timeOut)
  self._timeOut:SetActive(timeOut)
end

function UIWeChatRoleCell:ShowRed(show)
  self.redGO:SetActive(show)
end

function UIWeChatRoleCell:Select(select, noAni)
  if self.select == select then
    return
  end
  self.select = select
  self:_Select(select)
  if noAni then
    if select then
      self.trans:DOLocalMoveX(10, 0)
    else
      self.trans:DOLocalMoveX(-10, 0)
    end
  elseif select then
    self.animation2:Play("Uieff_WeChatCell_In")
    self.trans:DOLocalMoveX(10, 0.3)
  else
    self.trans:DOLocalMoveX(-10, 0.3)
  end
end

function UIWeChatRoleCell:_Select(select)
  self.choose1GO:SetActive(select)
  self.choose2GO:SetActive(select)
  self.changeNameGO:SetActive(select)
end

function UIWeChatRoleCell:bgbtnOnClick(go)
  self.onClickCell(self.weChatRole)
end

function UIWeChatRoleCell:changenamebtnOnClick(go)
  self.onClickChangeName(self.weChatRole)
end

function UIWeChatRoleCell:ChangeName()
  self.nameTxt:SetText(self.weChatRole:GetName())
end
