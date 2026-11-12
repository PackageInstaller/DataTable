local ScoreBossReplaceBDCtrl = class("ScoreBossReplaceBDCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
ScoreBossReplaceBDCtrl._mapNodeConfig = {
  aniBlur = {},
  clearTips = {},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_ReplaceTitle"
  },
  txtContentMain = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_ReplaceOtherLvTips"
  },
  oldTeam = {},
  newTeam = {},
  goMessageBoxAni = {
    sNodeName = "goMessageBox",
    sComponentName = "Animator"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnClickCancel"
  },
  btnCancel = {
    sComponentName = "NaviButton",
    callback = "OnClickCancel",
    sAction = "Giveup",
    sActionIconType = "Dark"
  },
  txtBtnCancel = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_Btn_Cancel"
  },
  btnConfirm1 = {
    sComponentName = "NaviButton",
    callback = "OnClickConfirm",
    sAction = "Confirm",
    sActionIconType = "Dark"
  },
  txtConfirm1_ = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_Btn_Confirm"
  },
  texNewRecord = {
    sComponentName = "TMP_Text",
    sLanguageId = "ScoreBoss_New_Record"
  }
}

function ScoreBossReplaceBDCtrl:Awake()
  self._mapNode.clearTips:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function ScoreBossReplaceBDCtrl:OnEnable()
  self._mapNode.aniBlur.gameObject:SetActive(true)
  local tbParam = self:GetPanelParam()
  self.levelId = tbParam[1]
  self.ConfirmCallBack = tbParam[2]
  self.CancelCallBack = tbParam[3]
  self:AddTimer(1, 0.1, function()
    self:SetOldTeamMsg()
    self:SetNewTeamMsg()
    self._mapNode.clearTips:SetActive(true)
    self._mapNode.goMessageBoxAni:Play("t_window_04_t_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
    if GamepadUIManager.GetInputState() then
      GamepadUIManager.EnableGamepadUI("ScoreBossReplaceBDCtrl", self.tbGamepadUINode)
    else
      for _, v in pairs(self.tbGamepadUINode) do
        if v.sComponentName == "NaviButton" then
          NovaAPI.SetNaviButtonAction(v.mapNode, false)
        end
      end
    end
  end, true, true, true)
end

function ScoreBossReplaceBDCtrl:OnDisable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("ScoreBossReplaceBDCtrl")
  end
end

function ScoreBossReplaceBDCtrl:SetOldTeamMsg()
  local trans = self._mapNode.oldTeam.transform:Find("AnimRoot")
  local TMPBossName = trans:Find("TMPBossName"):GetComponent("TMP_Text")
  local imgIcon = trans:Find("goMonsterHead/--Basic--/mask/imgIcon"):GetComponent("Image")
  local texCountEnd = trans:Find("goNodeItem/texCountEnd"):GetComponent("TMP_Text")
  local ScoreCount = trans:Find("goNodeItem/ScoreCount"):GetComponent("TMP_Text")
  local texLockChar = trans:Find("LockCharBg/texLockChar"):GetComponent("TMP_Text")
  local rtElements1 = trans:Find("goElements/rtElements1")
  local levelId = self.levelId
  local bossLevelData = ConfigTable.GetData("ScoreBossLevel", levelId)
  local mData = ConfigTable.GetData("Monster", bossLevelData.MonsterId)
  local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
  local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
  local Adjust = ConfigTable.GetData("MonsterValueTempleteAdjust", mData.Templete)
  NovaAPI.SetTMPText(TMPBossName, mManual.Name)
  self:SetPngSprite(imgIcon, mManual.Icon)
  local levelData = PlayerData.ScoreBoss:GetLevelData(levelId)
  NovaAPI.SetTMPText(texCountEnd, ConfigTable.GetUIText("ScoreBoss_EndScore"))
  NovaAPI.SetTMPText(ScoreCount, levelData.Score)
  NovaAPI.SetTMPText(texLockChar, ConfigTable.GetUIText("ScoreBoss_Lock_Char"))
  for i = 1, 7 do
    local tmpStar = trans:Find("goNodeItem/rt_Targets/ScoreStar" .. i):GetComponent("Button")
    tmpStar.interactable = i <= levelData.Star
  end
  for i = 1, rtElements1.childCount do
    local imgElement = rtElements1:GetChild(i - 1):GetComponent("Image")
    if Adjust.WeakEET[i] ~= nil then
      self:SetAtlasSprite(imgElement, "12_rare", AllEnum.ElementIconType.Icon .. Adjust.WeakEET[i])
    end
    imgElement.gameObject:SetActive(Adjust.WeakEET[i] ~= nil)
  end
  local tmpCharId = levelData.CharId
  for j = 1, 3 do
    local char = trans:Find("LockCharBg/lockChar_" .. j)
    local imgItemIcon = char:Find("t_char_head/imgIconBg/imgItemIcon"):GetComponent("Image")
    local imgItemRare = char:Find("t_char_head/imgItemRare"):GetComponent("Image")
    local mapChar = ConfigTable.GetData_Character(tmpCharId[j])
    local mapCharData = PlayerData.Char:GetCharDataByTid(tmpCharId[j])
    if mapCharData ~= nil then
      local nCharSkinId = mapCharData.nSkinId
      local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
      if mapCharSkin ~= nil then
        self:SetPngSprite(imgItemIcon, mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.XXL)
      end
    end
    if mapChar ~= nil then
      local nRarity = mapChar.Grade
      local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapChar.Grade]
      self:SetAtlasSprite(imgItemRare, "12_rare", sFrame, true)
    end
    local charLeader = char:Find("charLeader")
    local charSub = char:Find("charSub")
    local txtLeader = charLeader:Find("imgLeader/txtLeader"):GetComponent("TMP_Text")
    local txtSub1 = charSub:Find("imgSub/txtSub1"):GetComponent("TMP_Text")
    charLeader.gameObject:SetActive(j == 1)
    charSub.gameObject:SetActive(j ~= 1)
    NovaAPI.SetTMPText(txtLeader, ConfigTable.GetUIText("Build_Leader"))
    NovaAPI.SetTMPText(txtSub1, ConfigTable.GetUIText("Build_Sub"))
  end
end

function ScoreBossReplaceBDCtrl:SetNewTeamMsg()
  local trans = self._mapNode.newTeam.transform:Find("AnimRoot")
  local TMPBossName = trans:Find("TMPBossName"):GetComponent("TMP_Text")
  local imgIcon = trans:Find("goMonsterHead/--Basic--/mask/imgIcon"):GetComponent("Image")
  local texCountEnd = trans:Find("goNodeItem/texCountEnd"):GetComponent("TMP_Text")
  local ScoreCount = trans:Find("goNodeItem/ScoreCount"):GetComponent("TMP_Text")
  local texLockChar = trans:Find("LockCharBg/texLockChar"):GetComponent("TMP_Text")
  local rtElements1 = trans:Find("goElements/rtElements1")
  local levelId = self.levelId
  local bossLevelData = ConfigTable.GetData("ScoreBossLevel", levelId)
  local mData = ConfigTable.GetData("Monster", bossLevelData.MonsterId)
  local mSkin = ConfigTable.GetData("MonsterSkin", mData.FAId)
  local mManual = ConfigTable.GetData("MonsterManual", mSkin.MonsterManual)
  local Adjust = ConfigTable.GetData("MonsterValueTempleteAdjust", mData.Templete)
  NovaAPI.SetTMPText(TMPBossName, mManual.Name)
  self:SetPngSprite(imgIcon, mManual.Icon)
  NovaAPI.SetTMPText(ScoreCount, PlayerData.ScoreBoss:GetTotalScore())
  NovaAPI.SetTMPText(texCountEnd, ConfigTable.GetUIText("ScoreBoss_EndScore"))
  NovaAPI.SetTMPText(texLockChar, ConfigTable.GetUIText("ScoreBoss_Lock_Char"))
  local tmpStarCount = PlayerData.ScoreBoss:ScoreToStar()
  for i = 1, 7 do
    local tmpStar = trans:Find("goNodeItem/rt_Targets/ScoreStar" .. i):GetComponent("Button")
    tmpStar.interactable = i <= tmpStarCount
  end
  for i = 1, rtElements1.childCount do
    local imgElement = rtElements1:GetChild(i - 1):GetComponent("Image")
    if Adjust.WeakEET[i] ~= nil then
      self:SetAtlasSprite(imgElement, "12_rare", AllEnum.ElementIconType.Icon .. Adjust.WeakEET[i])
    end
    imgElement.gameObject:SetActive(Adjust.WeakEET[i] ~= nil)
  end
  local tbCharId = PlayerData.ScoreBoss:GetEntryBuildCharTid()
  for j = 1, 3 do
    local char = trans:Find("LockCharBg/lockChar_" .. j)
    local imgItemIcon = char:Find("t_char_head/imgIconBg/imgItemIcon"):GetComponent("Image")
    local imgItemRare = char:Find("t_char_head/imgItemRare"):GetComponent("Image")
    local mapChar = ConfigTable.GetData_Character(tbCharId[j])
    local mapCharData = PlayerData.Char:GetCharDataByTid(tbCharId[j])
    if mapCharData ~= nil then
      local nCharSkinId = mapCharData.nSkinId
      local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
      self:SetPngSprite(imgItemIcon, mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.XXL)
    end
    if mapChar ~= nil then
      local nRarity = mapChar.Grade
      local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapChar.Grade]
      self:SetAtlasSprite(imgItemRare, "12_rare", sFrame, true)
    end
    local charLeader = char:Find("charLeader")
    local charSub = char:Find("charSub")
    local txtLeader = charLeader:Find("imgLeader/txtLeader"):GetComponent("TMP_Text")
    local txtSub1 = charSub:Find("imgSub/txtSub1"):GetComponent("TMP_Text")
    charLeader.gameObject:SetActive(j == 1)
    charSub.gameObject:SetActive(j ~= 1)
    NovaAPI.SetTMPText(txtLeader, ConfigTable.GetUIText("Build_Leader"))
    NovaAPI.SetTMPText(txtSub1, ConfigTable.GetUIText("Build_Sub"))
  end
end

function ScoreBossReplaceBDCtrl:OnClickCancel()
  self._mapNode.goMessageBoxAni:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.ScoreBossReplaceBD)
    if self.CancelCallBack ~= nil then
      self.CancelCallBack()
    end
  end, true, true, true)
end

function ScoreBossReplaceBDCtrl:OnClickConfirm()
  self._mapNode.goMessageBoxAni:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.ScoreBossReplaceBD)
    if self.ConfirmCallBack ~= nil then
      self.ConfirmCallBack()
    end
  end, true, true, true)
end

return ScoreBossReplaceBDCtrl
