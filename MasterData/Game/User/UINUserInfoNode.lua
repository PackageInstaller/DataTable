local UINUserInfoNode = class("UINUserInfoNode", UIBaseNode)
local base = UIBaseNode
local UINUserInfoBottomItem = require("Game.User.UINUserInfoBottomItem")
local UINUserInfoSupportHeroNode = require("Game.User.UINUserInfoSupportHeroNode")
local RenameHelper = require("Game.CommonUI.Rename.RenameHelper")
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local UINUserTitle = require("Game.CommonUI.Title.UINNormalTitleItem")
local UINUserInfoDropdownListGroup = require("Game.User.UINUserInfoDropdownListGroup")
local UINUserInfoNodeNewNode = require("Game.User.UINUserInfoNodeNewNode")
local eFriendEnum = require("Game.Friend.eFriendEnum")
local eFriendUIState = eFriendEnum.eFriendUIState
local cs_MessageCommon = CS.MessageCommon
local newBottomItemTab = {
  [1] = {
    func = function(userInfoData)
      local totalCount = ConfigData.hero_data.totalShowHeroCount
      return tostring(userInfoData:GetHasHeroNum()) .. "<color=#777777><size=36>/" .. tostring(totalCount) .. "</size></color>"
    end
  },
  [2] = {
    func = function(userInfoData)
      local epProgress = userInfoData:GetEpProgress()
      if epProgress.sectorId == nil or epProgress.stageIndex == nil then
        return "NO PASS"
      end
      return "STAGE " .. tostring(epProgress.sectorId) .. "-" .. tostring(epProgress.stageIndex)
    end
  },
  [3] = {
    func = function(userInfoData)
      return tostring(userInfoData:GetInfinityLevelSum()) .. "m"
    end
  },
  [4] = {
    func = function(userInfoData)
      local totalLevel = userInfoData:GetBuildingTotalLevel()
      return "Lv." .. tostring(totalLevel)
    end
  },
  [5] = {
    func = function(userInfoData)
      local levelNum = userInfoData:GetDefaultTowerProgress()
      return string.format("%dC", levelNum)
    end
  }
}

function UINUserInfoNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_CopyUID, self, self._OnCopyUIDClick)
  UIUtil.AddButtonListener(self.ui.btn_ChangeName, self, self._OnChangeNameClick)
  UIUtil.AddButtonListener(self.ui.btn_ChangeTitle, self, self._OpenChangeUserTitle)
  UIUtil.AddButtonListener(self.ui.btn_titleAdd, self, self._OpenChangeUserTitle)
  UIUtil.AddButtonListener(self.ui.btn_DormVisit, self, self._OnClickDormVisit)
  self._titleBlueDotChange = BindCallback(self, self.RefreshBlueDot)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.obj_UINUserHead)
  self.userHeadNode:BindUserHeadEvent(BindCallback(self, self._OpenChangeUserHead))
  self.userTitleNode = UINUserTitle.New()
  self.userTitleNode:Init(self.ui.obj_UINUserTitle)
  self.ui.tex_PlacerHolder.text = ConfigData:GetTipContent(ConfigData.game_config.playerDefaultSignatureId)
  self:_InitGameVersion()
  self.__OnHeroUpdate = BindCallback(self, self._OnHeroUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__OnHeroUpdate)
  self.__OnSelfNameChange = BindCallback(self, self._OnSelfNameChange)
  MsgCenter:AddListener(eMsgEventId.UserNameChanged, self.__OnSelfNameChange)
  self._titleChangeCallback = BindCallback(self, self.TitleChangeCallback)
  self.characterLimit = self.ui.input_Signature.characterLimit
  if CS.ClientConsts.IsAudit then
    self.ui.input_Signature.gameObject:SetActive(false)
  end
  self.isNewNode = ConfigData.game_config.isHaveNewUserInfo4Milestone
  self.ui.obj_oldNode:SetActive(not self.isNewNode)
  self.ui.obj_newNode:SetActive(self.isNewNode)
  if self.isNewNode then
    self.newNode = UINUserInfoNodeNewNode.New()
    self.newNode:Init(self.ui.obj_newNode)
    self.ui.obj_supportHeroItem:SetActive(false)
    self.ui.obj_bottomInfoListItem:SetActive(false)
  else
    self.supportPool = UIItemPool.New(UINUserInfoSupportHeroNode, self.ui.obj_supportHeroItem, false)
    self.bottomInfoPool = UIItemPool.New(UINUserInfoBottomItem, self.ui.obj_bottomInfoListItem, false)
  end
end

function UINUserInfoNode:_InitGameVersion()
  local hasHotUpdateVer = CS.ClientConsts.GameVersionStr
  self.ui.tex_Version:SetIndex(0, hasHotUpdateVer)
end

function UINUserInfoNode:RefershInfoNode(userInfoData, changeNameAction, resLoader, couldEditSelf, friendUIState)
  self.userInfoData = userInfoData
  self.resLoader = resLoader
  self.couldEditSelf = couldEditSelf
  self.eFriendUIState = friendUIState
  if self.isNewNode then
    self.newNode:InitUserInfoNewNode(userInfoData)
  end
  self:_RefreshDiffWithOtherUser()
  self:SetChangeNameBtnActive(changeNameAction)
  self:_RefreshUserInfo()
  self:_RefreshExperience()
  self:RefreshSupport()
  self:RefreshOperateList()
end

function UINUserInfoNode:UpdateInfoNode()
  if self.userInfoData == nil then
    return
  end
  self:_RefreshUserInfo()
  self:_RefreshExperience()
  self:RefreshSupport()
  self:RefreshOperateList()
end

function UINUserInfoNode:_RefreshDiffWithOtherUser()
  local isSelf = self.userInfoData:GetIsSelfUserInfo()
  local enableEditor = isSelf and self.couldEditSelf
  self.ui.input_Signature.interactable = enableEditor
  self.ui.input_Signature.characterLimit = ConfigData.game_config.playerSignatureNumLimit
  self.characterLimit = self.ui.input_Signature.characterLimit
  if enableEditor then
    self:__ClearSignatureLimit()
    if CloseCustomBename or ConfigData.game_config.closePlayerSignName then
      self:__SignatureLimit(393)
    elseif ConfigData.game_config.playerSignNameLevelLimit > self.userInfoData:GetUserLevel() then
      self:__SignatureLimit(9608)
    end
  end
end

function UINUserInfoNode:__ClearSignatureLimit()
  self.ui.btn_signLimit.gameObject:SetActive(false)
end

function UINUserInfoNode:__SignatureLimit(tipCount)
  self.ui.input_Signature.interactable = false
  if self._clickSignatureAction == nil then
    function self._clickSignatureAction()
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(tipCount))
    end
    
    UIUtil.AddButtonListener(self.ui.btn_signLimit, self, BindCallback(self, self._clickSignatureAction))
  end
  self.ui.btn_signLimit.gameObject:SetActive(true)
end

function UINUserInfoNode:_RefreshUserInfo()
  local userInfoData = self.userInfoData
  self:RefreshUserName(userInfoData)
  self.ui.tex_UID.text = "UID:" .. userInfoData:GetUserUID()
  self.userHeadNode:InitUserHeadUI(userInfoData:GetAvatarId(), userInfoData:GetAvatarFrameId(), self.resLoader)
  local title = userInfoData:GetAvatarTitleId()
  self:RefreshUserTitle(title)
  self:RefreshUserSignature(userInfoData:GetAvatarSignature())
  self:RefreshDressUp(userInfoData:GetBackgroudPlateId())
  self:RefreshUserLevel(userInfoData:GetUserLevel())
  self:RefreshOnline(userInfoData:IsOnline(), userInfoData:GetIsSelfUserInfo(), userInfoData:IsRejectInvitation())
  self:RefreshBtnVisit()
  local timeDate = TimeUtil:TimestampToDate(userInfoData:GetCreateTime(), nil, true)
  self.ui.tex_CreateTime.text = timeDate.year .. "-" .. timeDate.month .. "-" .. timeDate.day
end

function UINUserInfoNode:RefreshUserTitle(title)
  if (not self.userInfoData:GetIsSelfUserInfo() or not self.couldEditSelf) and (not title or title.titlePrefix == 0) then
    self.ui.btn_titleAdd.gameObject:SetActive(false)
    self.ui.obj_UINUserTitle:SetActive(false)
    return
  end
  if self.userInfoData:GetIsSelfUserInfo() and self.couldEditSelf then
    local ok, newTitleNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Title)
    if not ok then
      newTitleNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Title)
      if 0 < PlayerDataCenter.gameSettingData:GetNewTitleItemNum() then
        newTitleNode:SetRedDotCount(1)
      end
    end
    if self.titleBlueDot == nil then
      RedDotController:AddListener(newTitleNode.nodePath, self._titleBlueDotChange)
      self.titleBlueDot = true
    end
    self:RefreshBlueDot(newTitleNode)
  end
  local realTitle = title or {
    titlePrefix = nil,
    titlePostfix = nil,
    titleBackGround = nil
  }
  if realTitle.titlePrefix and realTitle.titlePrefix ~= 0 then
    self.ui.btn_titleAdd.gameObject:SetActive(false)
    self.ui.obj_UINUserTitle:SetActive(true)
  else
    self.ui.btn_titleAdd.gameObject:SetActive(true)
    self.ui.obj_UINUserTitle:SetActive(false)
  end
  local atlasPath = PathConsts:GetSpriteAtlasPath("TitleIcon")
  self._titleBgAtlas = self.resLoader:LoadABAsset(atlasPath)
  self.userTitleNode:InitNormalTitleItem(realTitle.titlePrefix, realTitle.titlePostfix, realTitle.titleBackGround, self.resLoader, self._titleBgAtlas)
end

function UINUserInfoNode:RefreshBlueDot(node)
  if node:GetRedDotCount() > 0 then
    self.ui.obj_titleBlueDot:SetActive(true)
  else
    self.ui.obj_titleBlueDot:SetActive(false)
  end
end

function UINUserInfoNode:RefreshUserLevel(tempLv)
  local strLv = tempLv < 10 and "LV.0" .. tostring(tempLv) or "LV." .. tostring(tempLv)
  self.ui.tex_Level.text = strLv
end

function UINUserInfoNode:RefreshOnline(isOnline, isSelf, IsRejectInvitation)
end

function UINUserInfoNode:RefreshBtnVisit()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  local is_hide = ConfigData.oasis_building_dorm_visit[1].is_hide
  local isSelf = self.userInfoData:GetIsSelfUserInfo()
  local isMyFriend = self.userInfoData:GetIsFriend()
  self.ui.btn_DormVisit.gameObject:SetActive(isUnlock and not is_hide and not isSelf and isMyFriend)
end

function UINUserInfoNode:SaveUserSignature()
  local inputSignature = self.ui.input_Signature.text
  if self.userInfoData:GetAvatarSignature() == self.ui.input_Signature.text then
    return
  end
  local inputLength = RenameHelper:GetNameLength(inputSignature)
  if inputLength > self.characterLimit then
    inputSignature = RenameHelper:ClampNameInLength(inputSignature, self.characterLimit)
    self.ui.input_Signature.text = inputSignature
  end
  NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_SignatureMod(inputSignature)
end

function UINUserInfoNode:_RefreshExperience()
  if self.isNewNode then
    self.newNode:RrefreshSixPointStar(self.userInfoData)
    return
  end
  self.bottomInfoPool:HideAll()
  for index, tab in ipairs(newBottomItemTab) do
    local item = self.bottomInfoPool:GetOne()
    item:InitUserInfoBottomItem(index, tab.func, nil, self.userInfoData)
  end
end

function UINUserInfoNode:RefreshDressUp(backgroudPlateId)
  local resCfg = ConfigData.portrait_card[backgroudPlateId]
  self.ui.img_DressUp.gameObject:SetActive(false)
  if resCfg == nil then
    local defaultId = ConfigData.game_config.userInfoUIBG
    resCfg = ConfigData.portrait_card[defaultId]
  end
  if resCfg == nil then
    return
  end
  local resName = resCfg.icon
  if self.softMaskMat == nil then
    self.softMaskMat = CS.UnityEngine.Object.Instantiate(self.ui.mat_softMask)
    self.softMaskMat:SetFloat("_clipSoftX", 400)
    self.softMaskMat:SetFloat("_clipSoftY", 1)
  end
  if self.dressUpResloader ~= nil then
    self.dressUpResloader:Put2Pool()
    self.dressUpResloader = nil
  end
  self.dressUpResloader = CS.ResLoader.Create()
  local path = PathConsts:GetUserDressUpPath(resName)
  self.dressUpResloader:LoadABAssetAsync(path, function(texture)
    if not IsNull(texture) then
      self.ui.img_DressUp.texture = texture
      self.ui.img_DressUp.gameObject:SetActive(true)
      self.ui.img_DressUp.material = self.softMaskMat
    end
  end)
end

function UINUserInfoNode:RefreshUserName(userInfoData)
  if userInfoData:GetIsFriend() and userInfoData:GetIsHaveAlias() then
    self.ui.tex_Name.text = userInfoData:GetUserName() .. "<size=42>(" .. userInfoData:GetAlias() .. ")</size>"
    return
  end
  self.ui.tex_Name.text = userInfoData:GetUserName()
end

function UINUserInfoNode:RefreshUserHeadOnly(headId)
  self.userHeadNode:RefreshUserHeadOnly(headId)
end

function UINUserInfoNode:RefreshUserHeadFrameOnly(frameId)
  self.userHeadNode:RefreshUserHeadFrameOnly(frameId)
end

function UINUserInfoNode:RefreshUserSignature(strSignature)
  if strSignature == nil then
    return
  end
  self.ui.input_Signature.text = tostring(strSignature)
end

function UINUserInfoNode:RefreshSupport()
  if self.isNewNode then
    self.newNode:RrefreshAllSupporHero(self.userInfoData, self.resLoader, self.couldEditSelf)
    return
  end
  self.supportPool:HideAll()
  for index, supportHeroInfo in ipairs(self.userInfoData:GetSupportHoreInfoList()) do
    local item = self.supportPool:GetOne()
    item:InitSupportHero(index, self.userInfoData, self.resLoader, self.couldEditSelf)
  end
end

function UINUserInfoNode:RefreshOperateList()
  if self.userInfoData:GetIsSelfUserInfo() or self.eFriendUIState ~= eFriendUIState.friendList and self.eFriendUIState ~= eFriendUIState.chat then
    self.ui.obj_operateList:SetActive(false)
    return
  end
  self.ui.obj_operateList:SetActive(true)
  if self.dropDownList == nil then
    local dropDownList = UINUserInfoDropdownListGroup.New()
    dropDownList:Init(self.ui.obj_operateList)
    dropDownList:InitDropDownList(self.userInfoData)
    self.dropDownList = dropDownList
  end
  self.dropDownList:RefreshDropDownList(self.userInfoData)
end

function UINUserInfoNode:_OnCopyUIDClick()
  CS.UnityEngine.GUIUtility.systemCopyBuffer = self.userInfoData:GetUserUID()
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.UserInfo_CopyUIDDone))
  AudioManager:PlayAudioById(1124)
end

function UINUserInfoNode:_OnChangeNameClick()
  if not self.userInfoData:GetIsSelfUserInfo() or not self.couldEditSelf then
    return
  end
  if CloseCustomBename or ConfigData.game_config.closePlayerRename then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(393))
    return
  end
  if self._changeNameAction ~= nil then
    self._changeNameAction()
  end
end

function UINUserInfoNode:SetChangeNameBtnActive(changeNameAction)
  if changeNameAction == nil then
    self.ui.btn_ChangeName.gameObject:SetActive(false)
    return
  end
  self.ui.btn_ChangeName.gameObject:SetActive(true)
  self._changeNameAction = changeNameAction
end

function UINUserInfoNode:_OpenChangeUserHead()
  if not self.userInfoData:GetIsSelfUserInfo() or not self.couldEditSelf then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfoDialog, function(window)
    if window ~= nil then
      window:OpenChangeUserHeadDialog()
    end
  end)
end

function UINUserInfoNode:_OpenChangeUserTitle()
  if not self.userInfoData:GetIsSelfUserInfo() or not self.couldEditSelf then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfoDialog, function(window)
    if window ~= nil then
      window:OpenChangeUserTitle(self._titleChangeCallback)
    end
  end)
end

function UINUserInfoNode:TitleChangeCallback(preId, postId, bgId)
  if preId and preId ~= 0 then
    self.ui.btn_titleAdd.gameObject:SetActive(false)
    self.ui.obj_UINUserTitle:SetActive(true)
  else
    self.ui.btn_titleAdd.gameObject:SetActive(true)
    self.ui.obj_UINUserTitle:SetActive(false)
  end
  self.userTitleNode:RefreshTitle(preId, postId, bgId)
end

function UINUserInfoNode:_OnHeroUpdate()
  if self.isNewNode then
    self.newNode:OnUserInfoNewNodeHeroUpdate()
    return
  end
  for _, nodeItem in pairs(self.supportPool.listItem) do
    nodeItem:RefreshSupportHero()
  end
end

function UINUserInfoNode:_OnSelfNameChange()
  if self.userInfoData:GetIsSelfUserInfo() then
    self:RefreshUserName(self.userInfoData)
  end
end

function UINUserInfoNode:_OnClickDormVisit()
  if self.userInfoData == nil then
    return
  end
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  if isUnlock then
    local userId = self.userInfoData:GetUserUID()
    local userName = self.userInfoData:GetUserName()
    local JumpManager = require("Game.Jump.JumpManager")
    JumpManager:Jump(JumpManager.eJumpTarget.Dorm, nil, nil, {
      true,
      userId,
      userName
    })
  end
end

function UINUserInfoNode:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__OnHeroUpdate)
  MsgCenter:RemoveListener(eMsgEventId.UserNameChanged, self.__OnSelfNameChange)
  local ok, newTitleNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Title)
  if ok and self.titleBlueDot then
    RedDotController:RemoveListener(newTitleNode.nodePath, self._titleBlueDotChange)
  end
  if self.softMaskMat ~= nil then
    DestroyUnityObject(self.softMaskMat)
    self.softMaskMat = nil
  end
  if self.newNode ~= nil then
    self.newNode:Delete()
    self.newNode = nil
  end
  if self.dressUpResloader ~= nil then
    self.dressUpResloader:Put2Pool()
    self.dressUpResloader = nil
  end
  if self.bottomInfoPool ~= nil then
    self.bottomInfoPool:DeleteAll()
  end
  if self.supportPool ~= nil then
    self.supportPool:DeleteAll()
  end
  base.OnDelete(self)
end

return UINUserInfoNode
