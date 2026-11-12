local DepotDiscInfoCtrl = class("DepotDiscInfoCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
DepotDiscInfoCtrl._mapNodeConfig = {
  goBlur = {},
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  goWindow = {},
  animWindow = {sNodeName = "goWindow", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Disc_Info_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goDiscItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateDiscItemCtrl"
  },
  txtDiscName = {sComponentName = "TMP_Text"},
  txtDiscLevel = {sComponentName = "TMP_Text"},
  goDiscStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
  },
  txtPropertyTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Disc_Property_Title"
  },
  goProperty = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplatePropertyCtrl"
  },
  imgDiscEET = {sComponentName = "Image"},
  imgTag = {nCount = 3},
  txtTag = {nCount = 3, sComponentName = "TMP_Text"},
  rtTogTab = {
    sNodeName = "goTab",
    sCtrlName = "Game.UI.TemplateEx.TemplateTogTabCtrl"
  },
  btnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_left"
  },
  btnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_right"
  },
  goPassiveSkill = {
    sCtrlName = "Game.UI.StarTower.Depot.DepotDiscCoreSkillCtrl"
  },
  goCommonSkill = {
    nCount = 2,
    sCtrlName = "Game.UI.StarTower.Depot.DepotDiscCommonSkillCtrl"
  },
  goCommonNone = {nCount = 2},
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  }
}
DepotDiscInfoCtrl._mapEventConfig = {}
DepotDiscInfoCtrl._mapRedDotConfig = {}
local skill_Tab_type = {passive = 1, common = 2}

function DepotDiscInfoCtrl:RefreshDiscInfo(discData)
  self._mapNode.goDiscItem:Refresh(discData.nId)
  self.mapDisc = discData
  NovaAPI.SetTMPText(self._mapNode.txtDiscName, self.mapDisc.sName)
  NovaAPI.SetTMPText(self._mapNode.txtDiscLevel, orderedFormat(ConfigTable.GetUIText("StarTower_Disc_Info_Level"), self.mapDisc.nLevel))
  self._mapNode.goDiscStar:SetStar(self.mapDisc.nStar, self.mapDisc.nMaxStar)
  self._mapNode.goPassiveSkill:Refresh(self.mapDisc.nPassiveSkillId, false, self.tbNoteList)
  local tbCommonSkillId = self.mapDisc.tbCommonSkillId
  for i = 1, 2 do
    if tbCommonSkillId[i] then
      self._mapNode.goCommonSkill[i].gameObject:SetActive(true)
      local nCurLayer
      local mapCommonCfg = ConfigTable.GetData("DiscCommonSkill", tbCommonSkillId[i])
      if mapCommonCfg then
        nCurLayer = discData:GetCommonLayer(self.tbNoteList, mapCommonCfg)
      end
      nCurLayer = nCurLayer == 0 and 1 or nCurLayer
      self._mapNode.goCommonSkill[i]:Refresh(tbCommonSkillId[i], nCurLayer)
      self._mapNode.goCommonNone[i]:SetActive(false)
    else
      self._mapNode.goCommonSkill[i].gameObject:SetActive(false)
      self._mapNode.goCommonNone[i]:SetActive(true)
    end
  end
  local tbAttr = self.mapDisc.mapAttrBase
  local i = 1
  for _, mapAttachAttr in pairs(AllEnum.AttachAttr) do
    local mapAttr = tbAttr[mapAttachAttr.sKey]
    if 0 < mapAttr.Value then
      self._mapNode.goProperty[i]:SetItemProperty(mapAttr.Key, mapAttr.Value, nil, true)
      i = i + 1
    end
  end
  local mapCfg = ConfigTable.GetData("Disc", discData.nId)
  if not mapCfg then
    return
  end
  local sName = AllEnum.ElementIconType.Icon .. mapCfg.EET
  self:SetAtlasSprite(self._mapNode.imgDiscEET, "12_rare", sName)
  for j = 1, 3 do
    local nTag = self.mapDisc.tbTag[j]
    if nTag then
      self._mapNode.imgTag[j]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtTag[j], ConfigTable.GetData("DiscTag", nTag).Title)
    else
      self._mapNode.imgTag[j]:SetActive(false)
    end
  end
  self:SwitchTog()
end

function DepotDiscInfoCtrl:SwitchTog()
  self._mapNode.rtTogTab:SetState(self.nSkillType == skill_Tab_type.common)
  if self.nSkillType == skill_Tab_type.passive then
    for i = 1, 2 do
      self._mapNode.goCommonSkill[i].gameObject:SetActive(false)
      self._mapNode.goCommonNone[i]:SetActive(false)
    end
    self._mapNode.goPassiveSkill.gameObject:SetActive(self.mapDisc.nPassiveSkillId)
  else
    self._mapNode.goPassiveSkill.gameObject:SetActive(false)
    local tbCommonSkillId = self.mapDisc.tbCommonSkillId
    for i = 1, 2 do
      self._mapNode.goCommonSkill[i].gameObject:SetActive(tbCommonSkillId[i])
      self._mapNode.goCommonNone[i]:SetActive(not tbCommonSkillId[i])
    end
  end
end

function DepotDiscInfoCtrl:OpenDiscInfo(discData, tbNoteList)
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.EnableGamepadUI("DepotDiscInfoCtrl", self:GetGamepadUINode(), nil, true)
  end
  self.tbNoteList = tbNoteList
  self.nSkillType = skill_Tab_type.passive
  self._mapNode.goWindow.gameObject:SetActive(false)
  self._mapNode.goBlur.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goWindow.gameObject:SetActive(true)
    self._mapNode.animWindow:Play("t_window_04_t_in")
    self:RefreshDiscInfo(discData)
  end
  
  cs_coroutine.start(wait)
end

function DepotDiscInfoCtrl:Awake()
  self._mapNode.goBlur.gameObject:SetActive(false)
  self._mapNode.goWindow.gameObject:SetActive(false)
  self._mapNode.rtTogTab:SetText(ConfigTable.GetUIText("StarTower_Disc_Common_Skill"), ConfigTable.GetUIText("StarTower_Disc_Passive_Skill"))
  self._mapNode.btnShortcutClose.gameObject:SetActive(GamepadUIManager.GetInputState())
  if GamepadUIManager.GetInputState() then
    local tbConfig = {
      {
        sAction = "Back",
        sLang = "ActionBar_Back"
      }
    }
    self._mapNode.ActionBar:InitActionBar(tbConfig)
  end
end

function DepotDiscInfoCtrl:OnBtnClick_left()
  self.nSkillType = skill_Tab_type.passive
  self:SwitchTog()
end

function DepotDiscInfoCtrl:OnBtnClick_right()
  self.nSkillType = skill_Tab_type.common
  self:SwitchTog()
end

function DepotDiscInfoCtrl:OnBtnClick_Close()
  self._mapNode.goBlur.gameObject:SetActive(false)
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animWindow, {
    "t_window_04_t_out"
  })
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  self._mapNode.animWindow:Play("t_window_04_t_out")
  self:AddTimer(1, nAnimTime, function()
    self._mapNode.goWindow.gameObject:SetActive(false)
    if GamepadUIManager.GetInputState() then
      GamepadUIManager.DisableGamepadUI("DepotDiscInfoCtrl")
    end
  end, true, true, true)
end

return DepotDiscInfoCtrl
