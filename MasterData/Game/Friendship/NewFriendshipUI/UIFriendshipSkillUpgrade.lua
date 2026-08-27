local UIFriendshipSkillUpgrade = class("UIFriendshipSkillUpgrade", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween
local FriendshipEnum = require("Game.Friendship.FriendshipEnum")
local SkinEnum = require("Game.Skin.SkinEnum")
local UINFriendshipSkillUpgradeItem = require("Game.Friendship.NewFriendshipUI.UINFriendshipSkillUpgradeItem")
local UINFriendshipLevel = require("Game.Friendship.NewFriendshipUI.UINFriendshipLevel")
local UINFriendshipPresentNode = require("Game.Friendship.NewFriendshipUI.UINFriendshipPresentNode")
local UINFriendshipSkillInfoNode = require("Game.Friendship.NewFriendshipUI.UINFriendshipSkillInfoNode")
local waitRecorverNUM = 0

function UIFriendshipSkillUpgrade:OnInit()
  self.resloader = cs_ResLoader.Create()
  self.skillPool = UIItemPool.New(UINFriendshipSkillUpgradeItem, self.ui.obj_skillItem)
  self.ui.obj_skillItem:SetActive(false)
  self.friendshipLevelUI = UINFriendshipLevel.New()
  self.friendshipLevelUI:Init(self.ui.obj_friendshipLevel)
  self.friendshipPresentNode = UINFriendshipPresentNode.New()
  self.friendshipPresentNode:Init(self.ui.obj_presentNode)
  local AddExpCallback = BindCallback(self.friendshipLevelUI, self.friendshipLevelUI.AddExp)
  local MinExpCallback = BindCallback(self.friendshipLevelUI, self.friendshipLevelUI.MinExp)
  self.friendshipPresentNode:InitResloader(self.resloader, AddExpCallback, MinExpCallback, self.friendshipLevelUI)
  self.friendshipSkillInfoNode = UINFriendshipSkillInfoNode.New()
  self.friendshipSkillInfoNode:Init(self.ui.obj_infoNode)
  self.ui.obj_infoNode:SetActive(false)
  self:InitTweens()
  self.__OpenInfoNode = BindCallback(self, self.OpenInfoNode)
  self.__CloseInfoNode = BindCallback(self, self.CloseInfoNode)
  self.__SwitchHero = BindCallback(self, self.SwitchHero)
  self.__OnFriendShipDataChangeI = BindCallback(self, self.OnFriendShipDataChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__OnFriendShipDataChangeI)
  self.__OnHeroSkinChange = BindCallback(self, self.OnHeroSkinChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinChange, self.__OnHeroSkinChange)
  MsgCenter:AddListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnHeroSkinChange)
  UIUtil.AddButtonListener(self.ui.btn_LeftArrow, self, self.__OnClickLeftArrow)
  UIUtil.AddButtonListener(self.ui.btn_RightArrow, self, self.__OnClickRightArrow)
end

function UIFriendshipSkillUpgrade:InitFriendshipSkillUpgrade(heroData, reUseBigImgResloader, hideCallBack, switchHeroFunc, isJumpReturn)
  self.isClosing = false
  self.heroData = heroData
  self.heroId = heroData.dataId
  self.hideCallBack = hideCallBack
  self.switchHeroFunc = switchHeroFunc
  self.ui.obj_quickSwitch:SetActive(switchHeroFunc ~= nil)
  if not isJumpReturn then
    UIUtil.SetTopStatus(self, self.OnClickReturn, nil)
  end
  local allFriendshipData = PlayerDataCenter.allFriendshipData
  self:RefreshHeroStaticInfo(reUseBigImgResloader)
  self:RefreshSkillData(self.heroId)
  self:RefreshAllSkills()
  self:PlayAllStartTween()
  self.friendshipLevelUI:InitFriendShipPresent(self.heroId)
  self.friendshipPresentNode:InitSendGift(self.heroId)
  self.friendshipPresentNode:RefreshPresentConfirmBtn()
  if self.winTween ~= nil then
    self.winTween:Complete()
  end
end

function UIFriendshipSkillUpgrade:SwitchHero(heroData, reUseBigImgResloader)
  self.heroData = heroData
  self.heroId = heroData.dataId
  self:RefreshHeroStaticInfo(reUseBigImgResloader)
  self:RefreshSkillData(self.heroId)
  self:RefreshAllSkills()
  self:PlayAllStartTween()
  self.ui.skillNode.gameObject:SetActive(true)
  self.ui.infoNode.gameObject:SetActive(false)
  self.friendshipLevelUI:InitFriendShipPresent(self.heroId)
  self.friendshipPresentNode:InitSendGift(self.heroId)
end

function UIFriendshipSkillUpgrade:OnFriendShipDataChange()
  self.friendshipPresentNode:InitSendGift(self.heroId)
  self.friendshipLevelUI:InitFriendShipPresent(self.heroId)
  for _, item in ipairs(self.skillPool.listItem) do
    item:Refresh()
  end
end

function UIFriendshipSkillUpgrade:RefreshSkillData(heroId)
  self.fosterCfgs = {}
  self.fosterIds = ConfigData.friendship_hero[heroId].foster_id
  for _, fosterId in ipairs(self.fosterIds) do
    table.insert(self.fosterCfgs, ConfigData.friendship_foster[fosterId])
  end
  table.sort(self.fosterCfgs, function(a, b)
    local couldA, isUnlockA = PlayerDataCenter.allFriendshipData:GetCouldUnlockOrUpgrade(self.heroId, a[1].id)
    local couldB, isUnlockB = PlayerDataCenter.allFriendshipData:GetCouldUnlockOrUpgrade(self.heroId, b[1].id)
    if isUnlockA ~= isUnlockB then
      if isUnlockA == nil or isUnlockB == nil then
        return isUnlockA ~= nil
      else
        return not isUnlockA
      end
    elseif isUnlockA ~= nil and couldA ~= couldB then
      return couldA
    end
    return a[1].id < b[1].id
  end)
end

function UIFriendshipSkillUpgrade:RefreshAllSkills()
  self.skillPool:HideAll()
  self.itemList = {}
  for index, fosterCfg in ipairs(self.fosterCfgs) do
    local item = self.skillPool:GetOne(true)
    item:InitSkillItem(self.heroId, fosterCfg, self.__OpenInfoNode)
    table.insert(self.itemList, item)
  end
  self:InitSkillTween()
end

function UIFriendshipSkillUpgrade:RefreshHeroStaticInfo(reUseBigImgResloader)
  local campIcon = LanguageUtil.GetLocaleText(self.heroData:GetCampCfg().icon)
  self.resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_Camp.texture = texture
  end)
  if reUseBigImgResloader ~= nil then
    if self.bigImgGameObject ~= nil then
      self.bigImgGameObject:SetActive(false)
    end
    reUseBigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(self.heroData:GetResPicName(), SkinEnum.fromWhere.heroInfoAndHandbook), function(prefab)
      DestroyUnityObject(self.bigImgGameObject)
      self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder)
      local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroList")
      self.ui.tween_heroHolder:DORestart()
    end)
  else
    if self.bigImgResloader ~= nil then
      self.bigImgResloader:Put2Pool()
    end
    self.bigImgResloader = cs_ResLoader.Create()
    self.bigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(self.heroData:GetResPicName(), SkinEnum.fromWhere.heroInfoAndHandbook), function(prefab)
      DestroyUnityObject(self.bigImgGameObject)
      self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder)
      local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroList")
      self.ui.tween_heroHolder:DORestart()
    end)
  end
end

function UIFriendshipSkillUpgrade:OnHeroSkinChange(heroId, skinId)
  if self.heroData.dataId == heroId then
    self:RefreshHeroStaticInfo()
  end
end

function UIFriendshipSkillUpgrade:InitTweens()
  local openMove = Vector3.New(200, 0, 0)
  local closeMove = Vector3.New(-200, 0, 0)
  self.openInfoSequence = cs_DoTween.Sequence():AppendCallback(function()
    UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
    self.ui.infoNode.gameObject:SetActive(true)
    AudioManager:PlayAudioById(1075)
    for _, tween in ipairs(self.ui.AllStartTweens) do
      tween:DOComplete(false)
    end
    self:__SetTweenGoPos(self.ui.skillNode, openMove)
    self:__SetTweenGoPos(self.ui.levelNode, openMove)
    self:__SetTweenGoPos(self.ui.skillDetailNode, openMove)
  end):Append(self.ui.skillNode.transform:DOLocalMove(openMove, 0.25):SetRelative(true)):Join(self.ui.skillNode:DOFade(0, 0.25)):Join(self.ui.infoNode:DOFade(1, 0.25)):Join(self.ui.levelNode:DOLocalMove(openMove, 0.25):From(true):SetRelative(true)):Join(self.ui.skillDetailNode:DOLocalMove(openMove, 0.25):SetDelay(0.05):From(true):SetRelative(true)):AppendCallback(function()
    self.ui.skillNode.gameObject:SetActive(false)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end):Pause():SetAutoKill(false)
  self.closeInfoSequence = cs_DoTween.Sequence():AppendCallback(function()
    UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
    self.ui.skillNode.gameObject:SetActive(true)
    self.showSkillListSequence:Restart()
  end):Append(self.ui.skillNode.transform:DOLocalMove(closeMove, 0.25):SetRelative(true)):Join(self.ui.skillNode:DOFade(1, 0.25)):Join(self.ui.infoNode:DOFade(0, 0.25)):Join(self.ui.levelNode:DOLocalMove(closeMove, 0.25):From(true):SetRelative(true)):Join(self.ui.skillDetailNode:DOLocalMove(closeMove, 0.25):SetDelay(0.05):From(true):SetRelative(true)):AppendCallback(function()
    self.ui.infoNode.gameObject:SetActive(false)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end):Pause():SetAutoKill(false)
end

function UIFriendshipSkillUpgrade:InitSkillTween()
  if self.showSkillListSequence ~= nil then
    self.showSkillListSequence:Restart()
    return
  end
  local openMove = Vector3.New(200, 0, 0)
  self.showSkillListSequence = cs_DoTween.Sequence()
  for index, item in ipairs(self.skillPool.listItem) do
    if index == 1 then
      self.showSkillListSequence:Append(item.ui.skillUpgradeItem:DOLocalMove(openMove, 0.25):SetDelay(0.05):From(true))
    else
      self.showSkillListSequence:Join(item.ui.skillUpgradeItem:DOLocalMove(openMove, 0.25):SetDelay(0.05):From(true))
    end
  end
  self.showSkillListSequence:Pause():SetAutoKill(false)
end

function UIFriendshipSkillUpgrade:__SetTweenGoPos(go, movePos)
  local localPos = go.transform.localPosition
  go.transform.localPosition = localPos + movePos
end

function UIFriendshipSkillUpgrade:KillAllTweens()
  self.openInfoSequence:Kill()
  self.openInfoSequence = nil
  self.closeInfoSequence:Kill()
  self.closeInfoSequence = nil
  if self.showSkillListSequence ~= nil then
    self.showSkillListSequence:Kill()
    self.showSkillListSequence = nil
  end
end

function UIFriendshipSkillUpgrade:PlayAllStartTween()
  self.showSkillListSequence:Restart(false)
  for _, tween in ipairs(self.ui.AllStartTweens) do
    tween:DORestart(false)
  end
end

function UIFriendshipSkillUpgrade:BackwardsAllStartTween()
  for _, tween in ipairs(self.ui.AllStartTweens) do
    tween:DOPlayBackwards()
  end
end

function UIFriendshipSkillUpgrade:OpenInfoNode(heroId, fosterCfg)
  if PlayerDataCenter.allFriendshipData:GetForestLineLevel(heroId, fosterCfg[1].id) >= #fosterCfg then
    return
  end
  self.openInfoSequence:Restart()
  self.friendshipSkillInfoNode:InitSkillInfoNode(heroId, fosterCfg, self.__CloseInfoNode)
end

function UIFriendshipSkillUpgrade:CloseInfoNode()
  self.closeInfoSequence:Restart()
end

function UIFriendshipSkillUpgrade:__OnClickLeftArrow()
  if self.showSkillListSequence ~= nil then
    self.showSkillListSequence:Kill(true)
    self.showSkillListSequence = nil
  end
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(-1, self.__SwitchHero)
    if newHeroData ~= nil then
      self:SwitchHero(newHeroData, reUseBigImgResloader)
    end
  end
end

function UIFriendshipSkillUpgrade:__OnClickRightArrow()
  if self.showSkillListSequence ~= nil then
    self.showSkillListSequence:Kill(true)
    self.showSkillListSequence = nil
  end
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(1, self.__SwitchHero)
    if newHeroData ~= nil then
      self:SwitchHero(newHeroData, reUseBigImgResloader)
    end
  end
end

function UIFriendshipSkillUpgrade:OnClickReturn()
  if not self.isClosing then
    self.isClosing = true
  else
    return
  end
  if self.hideCallBack ~= nil then
    self.hideCallBack(self.heroData, self.switchHeroFunc)
  end
  self:BackwardsAllStartTween()
  if 0 < waitRecorverNUM then
    self:Hide()
    return
  end
  self:Delete()
end

function UIFriendshipSkillUpgrade:GenCoverJumpReturnCallback()
  local dataTable = {}
  for key, value in pairs(self) do
    dataTable[key] = value
  end
  waitRecorverNUM = waitRecorverNUM + 1
  return function()
    if self.bigImgGameObject ~= nil then
      self.bigImgGameObject:SetActive(false)
      DestroyUnityObject(self.bigImgGameObject)
    end
    for key, value in pairs(dataTable) do
      self[key] = value
    end
    self:InitFriendshipSkillUpgrade(self.heroData, nil, dataTable.hideCallBack, self.switchHeroFunc, true)
    waitRecorverNUM = waitRecorverNUM - 1
  end
end

function UIFriendshipSkillUpgrade:OnHide()
  self.ui.skillNode.gameObject:SetActive(true)
  self.ui.infoNode.gameObject:SetActive(false)
  base.OnHide(self)
end

function UIFriendshipSkillUpgrade:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self:KillAllTweens()
  self.skillPool:DeleteAll()
  self.friendshipLevelUI:Delete()
  self.friendshipPresentNode:Delete()
  self.friendshipSkillInfoNode:Delete()
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__OnFriendShipDataChangeI)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinChange, self.__OnHeroSkinChange)
  MsgCenter:RemoveListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnHeroSkinChange)
  base.OnDelete(self)
end

function UIFriendshipSkillUpgrade:OnDeleteEntity()
  base.OnDeleteEntity(self)
end

function UIFriendshipSkillUpgrade:OnCloseTween()
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  base.OnCloseTween(self)
end

return UIFriendshipSkillUpgrade
