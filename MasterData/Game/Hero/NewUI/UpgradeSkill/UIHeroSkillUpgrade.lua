local UIHeroSkillUpgrade = class("UIHeroSkillUpgrade", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_MessageCommon = CS.MessageCommon
local cs_Edge = CS.UnityEngine.RectTransform.Edge
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local SkinEnum = require("Game.Skin.SkinEnum")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINHeroSkillUpgradeItem = require("Game.Hero.NewUI.UpgradeSkill.UINHeroSkillUpgradeItem")
local HeroSkillUpgradeEnum = require("Game.Hero.NewUI.UpgradeSkill.HeroSkillUpgradeEnum")
local UINHeroSkillUpgradeInfo = require("Game.Hero.NewUI.UpgradeSkill.UINHeroSkillUpgradeInfo")
local UIMultiSwitchTogItem = require("Game.Setting.UI.UIMultiSwitchTogItem")

function UIHeroSkillUpgrade:OnInit()
  self.isClosing = false
  self.isHeroRefresh = false
  self.isItemRefresh = false
  self.__CloseInfoNode = BindCallback(self, self.CloseInfoNode)
  self.__CloseSelf = BindCallback(self, self.CloseSelf)
  self.upgradeInfo = UINHeroSkillUpgradeInfo.New()
  self.upgradeInfo:Init(self.ui.obj_infoNode)
  self.__onInfoCancelClick = BindCallback(self, self.__OnInfoCancelClick)
  self.upgradeInfo:SetBtnCancelAction(self.__onInfoCancelClick)
  self.__onShowIntroClick = BindCallback(self, self.__OnShowIntroClick)
  UIUtil.AddButtonListener(self.ui.btn_LeftArrow, self, self.__OnClickLeftArrow)
  UIUtil.AddButtonListener(self.ui.btn_RightArrow, self, self.__OnClickRightArrow)
  self.skillItemList = {}
  local skillGoList = {}
  table.insert(skillGoList, self.ui.obj_skillItem)
  for i = 1, 2 do
    local go = self.ui.obj_skillItem:Instantiate()
    table.insert(skillGoList, go)
  end
  for index, go in ipairs(skillGoList) do
    go.name = "obj_skillItem" .. tostring(index)
  end
  self.battelSkill1 = UINHeroSkillUpgradeItem.New()
  self.battelSkill1:Init(skillGoList[1])
  table.insert(self.skillItemList, self.battelSkill1)
  self.battelSkill2 = UINHeroSkillUpgradeItem.New()
  self.battelSkill2:Init(skillGoList[2])
  table.insert(self.skillItemList, self.battelSkill2)
  self.uniqueSkill = UINHeroSkillUpgradeItem.New()
  self.uniqueSkill:Init(skillGoList[3])
  table.insert(self.skillItemList, self.uniqueSkill)
  self.__ItemRefresh = BindCallback(self, self.ItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__ItemRefresh)
  self.onDescribeSettingChange = BindCallback(self, self._OnDescribeSettingChange)
  MsgCenter:AddListener(eMsgEventId.DescribeSettingChange, self.onDescribeSettingChange)
  self.__hideStartCDtipAction = BindCallback(self, self.__OnHideStartCdTimeTip)
  self.__OpenInfoNode = BindCallback(self, self.OpenInfoNode)
  self:InitTweens()
  self.closeEvent = nil
  self:SwitchShowSkillDetail()
end

function UIHeroSkillUpgrade:InitSkillUpgrade(heroData, resloader, hideCallBack, switchHeroFunc)
  self.isClosing = false
  self.resloader = resloader
  self.heroData = heroData
  self.heroId = heroData.dataId
  self.hideCallBack = hideCallBack
  self.switchHeroFunc = switchHeroFunc
  UIUtil.SetTopStatus(self, self.CloseSelf, nil)
  self:RefreshHeroStaticInfo()
  self:PlayAllStartTween()
  self:Refresh()
  if self.winTween ~= nil then
    self.winTween:Complete()
  end
end

function UIHeroSkillUpgrade:SwitchHero(heroData, reUseBigImgResloader)
  self.heroData = heroData
  self.heroId = heroData.dataId
  self:RefreshHeroStaticInfo(reUseBigImgResloader)
  self.openInfoSequence:Pause()
  self.closeInfoSequence:Pause()
  self:PlayAllStartTween()
  self:Refresh()
  UIUtil.RefreshTopResId(nil)
  self.ui.skillNode.interactable = true
  self.ui.obj_skillNode:SetActive(true)
  self.ui.infoNode.interactable = false
  self.ui.obj_infoNode:SetActive(false)
  self.ui.tog_DisplayGroup:SetActive(true)
end

function UIHeroSkillUpgrade:ItemRefresh()
  self:Refresh()
end

function UIHeroSkillUpgrade:Refresh()
  self.isHeroRefresh = false
  local isBattelSkill1Empty = true
  local isBattelSkill2Empty = true
  for _, item in ipairs(self.skillItemList) do
    item.isInited = false
  end
  for k, skillData in ipairs(self.heroData.skillList) do
    if skillData.type ~= eHeroSkillType.LifeSkill then
      if skillData:IsUniqueSkill() then
        self.uniqueSkill:InitSkillItem(skillData, self.resloader, HeroSkillUpgradeEnum.SkillType.uSkill, self.__OpenInfoNode)
        self.uniqueSkill:SetIntroClickAction(self.__onShowIntroClick)
      elseif not skillData:IsCommonAttack() then
        if not skillData:IsPassiveSkill() then
          if isBattelSkill2Empty then
            self.battelSkill2:InjectLongPressFunc(BindCallback(self, self.__OnShowStartCdTimeTip, self.battelSkill2), self.__hideStartCDtipAction)
            self.battelSkill2:InitSkillItem(skillData, self.resloader, HeroSkillUpgradeEnum.SkillType.active, self.__OpenInfoNode)
            self.battelSkill2:SetIntroClickAction(self.__onShowIntroClick)
            isBattelSkill2Empty = false
          else
            self.battelSkill1:InjectLongPressFunc(BindCallback(self, self.__OnShowStartCdTimeTip, self.battelSkill1), self.__hideStartCDtipAction)
            self.battelSkill1:InitSkillItem(skillData, self.resloader, HeroSkillUpgradeEnum.SkillType.active, self.__OpenInfoNode)
            self.battelSkill1:SetIntroClickAction(self.__onShowIntroClick)
          end
        elseif isBattelSkill1Empty then
          self.battelSkill1:InitSkillItem(skillData, self.resloader, HeroSkillUpgradeEnum.SkillType.passive, self.__OpenInfoNode)
          self.battelSkill1:SetIntroClickAction(self.__onShowIntroClick)
          isBattelSkill1Empty = false
        else
          self.battelSkill2:InitSkillItem(skillData, self.resloader, HeroSkillUpgradeEnum.SkillType.passive, self.__OpenInfoNode)
          self.battelSkill2:SetIntroClickAction(self.__onShowIntroClick)
        end
      end
    end
  end
  for _, item in ipairs(self.skillItemList) do
    if not item.isInited then
      item:InitSkillItem(nil)
    end
  end
end

function UIHeroSkillUpgrade:RefreshHeroStaticInfo(reUseBigImgResloader)
  local campIcon = LanguageUtil.GetLocaleText(self.heroData:GetCampCfg().icon)
  self.resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_Camp.texture = texture
  end)
  if reUseBigImgResloader ~= nil then
    self.bigImgGameObject:SetActive(false)
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

function UIHeroSkillUpgrade:InitTweens()
  local openMove = Vector3.New(200, 0, 0)
  local closeMove = Vector3.New(-200, 0, 0)
  self.openInfoSequence = cs_DoTween.Sequence():AppendCallback(function()
    self.ui.obj_infoNode:SetActive(true)
    self.ui.skillNode.interactable = false
    self.ui.tog_DisplayGroup:SetActive(false)
    for _, tween in ipairs(self.ui.AllStartTweens) do
      tween:DOComplete(false)
    end
    self:__SetTweenGoPos(self.ui.skillNode, openMove)
    self:__SetTweenGoPos(self.ui.levelNode, openMove)
    self:__SetTweenGoPos(self.ui.skillDetailNode, openMove)
  end):Append(self.ui.skillNode.transform:DOLocalMove(openMove, 0.25):SetRelative(true)):Join(self.ui.skillNode:DOFade(0, 0.25)):Join(self.ui.infoNode:DOFade(1, 0.25)):Join(self.ui.levelNode:DOLocalMove(openMove, 0.25):From(true):SetRelative(true)):Join(self.ui.skillDetailNode:DOLocalMove(openMove, 0.25):SetDelay(0.05):From(true):SetRelative(true)):AppendCallback(function()
    self.ui.obj_skillNode:SetActive(false)
    self.ui.infoNode.interactable = true
  end):Pause():SetAutoKill(false)
  self.closeInfoSequence = cs_DoTween.Sequence():AppendCallback(function()
    self.ui.obj_skillNode:SetActive(true)
    self.ui.infoNode.interactable = false
    self.ui.tog_DisplayGroup:SetActive(true)
  end):Append(self.ui.skillNode.transform:DOLocalMove(closeMove, 0.25):SetRelative(true)):Join(self.ui.skillNode:DOFade(1, 0.25)):Join(self.ui.infoNode:DOFade(0, 0.25)):Join(self.ui.levelNode:DOLocalMove(closeMove, 0.25):From(true):SetRelative(true)):Join(self.ui.skillDetailNode:DOLocalMove(closeMove, 0.25):SetDelay(0.05):From(true):SetRelative(true)):AppendCallback(function()
    self.ui.obj_infoNode:SetActive(false)
    self.ui.skillNode.interactable = true
  end):Pause():SetAutoKill(false)
end

function UIHeroSkillUpgrade:__SetTweenGoPos(go, movePos)
  local localPos = go.transform.localPosition
  go.transform.localPosition = localPos + movePos
end

function UIHeroSkillUpgrade:KillAllTweens()
  self.openInfoSequence:Kill()
  self.openInfoSequence = nil
  self.closeInfoSequence:Kill()
  self.closeInfoSequence = nil
end

function UIHeroSkillUpgrade:PlayAllStartTween()
  for _, tween in ipairs(self.ui.AllStartTweens) do
    tween:DORestart(false)
  end
end

function UIHeroSkillUpgrade:BackwardsAllStartTween()
  for _, tween in ipairs(self.ui.AllStartTweens) do
    tween:DOPlayBackwards()
  end
end

function UIHeroSkillUpgrade:OpenInfoNode(skillData)
  self.upgradeInfo:InitInfoNode(skillData, self.resloader, self.__CloseInfoNode)
  self.openInfoSequence:Restart()
end

function UIHeroSkillUpgrade:CloseInfoNode()
  self.closeInfoSequence:Restart()
  self:Refresh()
  UIUtil.RefreshTopResId(nil)
end

function UIHeroSkillUpgrade:CloseSelf()
  if not self.isClosing then
    self.isClosing = true
  else
    return
  end
  if self.hideCallBack ~= nil then
    self.hideCallBack()
  end
  if self.closeEvent ~= nil then
    self.closeEvent()
    self.closeEvent = nil
  end
  local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if win ~= nil and not win.active then
    win:Show()
  end
  self:BackwardsAllStartTween()
  self:Delete()
end

function UIHeroSkillUpgrade:__OnInfoCancelClick()
  self:CloseInfoNode()
end

function UIHeroSkillUpgrade:__OnClickLeftArrow()
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(-1)
    self:SwitchHero(newHeroData, reUseBigImgResloader)
  end
end

function UIHeroSkillUpgrade:__OnClickRightArrow()
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(1)
    self:SwitchHero(newHeroData, reUseBigImgResloader)
  end
end

function UIHeroSkillUpgrade:OnHide()
end

function UIHeroSkillUpgrade:__OnShowIntroClick(skillData)
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    if win ~= nil then
      win:ShowIntroBySkillData(self.ui.richIntroHolder, skillData)
      win:SetIntroListPosition(cs_Edge.Right, cs_Edge.Top)
    end
  end)
end

function UIHeroSkillUpgrade:__OnShowStartCdTimeTip(upgradeItem)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(ConfigData:GetTipContent(617), ConfigData:GetTipContent(616))
  win:FloatTo(upgradeItem.transform, HAType.left, VAType.up)
end

function UIHeroSkillUpgrade:__OnHideStartCdTimeTip()
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UIHeroSkillUpgrade:SwitchShowSkillDetail()
  local currentSkillDescCallback = BindCallback(PlayerDataCenter.gameSettingData, PlayerDataCenter.gameSettingData.GetGSIsShowDetailDescribeValue, eGameSetDescType.skill)
  local resolutionOptionName = ConfigData.game_set_describe[eGameSetDescType.skill].option_group_name
  local skillDescCallback = BindCallback(self, self.OnToogleCallback, eGameSetDescType.skill)
  self.multiSwitchTogItem = UIMultiSwitchTogItem.New()
  self.multiSwitchTogItem:Init(self.ui.tog_DisplayGroup)
  self.multiSwitchTogItem:InitUIMultiSwitchTogItem(currentSkillDescCallback, resolutionOptionName, nil, skillDescCallback, self)
end

function UIHeroSkillUpgrade:OnToogleCallback(eGameSetDescType, value, togItem)
  local isDetail = false
  if togItem.index == 0 and value then
    isDetail = false
  end
  if togItem.index == 1 and value then
    isDetail = true
  end
  if not self.__NotNeedSavingDescribeSetting then
    PlayerDataCenter.gameSettingData:SetGSDescribe(eGameSetDescType, isDetail)
  end
  self:RefreshAllSkillDes()
end

function UIHeroSkillUpgrade:RefreshAllSkillDes()
  self.battelSkill1:UpdateSkillDescription()
  self.battelSkill2:UpdateSkillDescription()
  self.uniqueSkill:UpdateSkillDescription()
end

function UIHeroSkillUpgrade:_OnDescribeSettingChange(eDescTypeId)
  if eDescTypeId ~= eGameSetDescType.skill then
    return
  end
  self.__NotNeedSavingDescribeSetting = true
  self.multiSwitchTogItem:SelectCurrentValue()
  self.__NotNeedSavingDescribeSetting = false
end

function UIHeroSkillUpgrade:OnDelete()
  self:KillAllTweens()
  self.upgradeInfo:Delete()
  self.battelSkill1:Delete()
  self.battelSkill2:Delete()
  self.uniqueSkill:Delete()
  MsgCenter:RemoveListener(eMsgEventId.DescribeSettingChange, self.onDescribeSettingChange)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__ItemRefresh)
  base.OnDelete(self)
end

function UIHeroSkillUpgrade:OnCloseTween()
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  base.OnCloseTween(self)
end

return UIHeroSkillUpgrade
