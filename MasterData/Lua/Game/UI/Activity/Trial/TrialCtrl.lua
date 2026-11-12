local TrialCtrl = class("TrialCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local TimerManager = require("GameCore.Timer.TimerManager")
TrialCtrl._mapNodeConfig = {
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  goActTime = {},
  txtActivityTime = {sComponentName = "TMP_Text"},
  btnTrialInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TrialInfo"
  },
  txtBtnTrialInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Btn_TrialDetial"
  },
  txtReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_RewardInfo"
  },
  btnItem = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ItemTips"
  },
  item = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  sv = {
    sComponentName = "LoopScrollView"
  },
  rtChar = {},
  btnChar = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Char"
  },
  imgSelectBg = {nCount = 4},
  goSelect = {nCount = 4},
  imgHead = {nCount = 4, sComponentName = "Image"},
  goCharRoot = {},
  btnTrial = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Trial"
  },
  btnGacha = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Gacha"
  },
  txtBtnGacha = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Btn_GotoGacha"
  },
  txtBtnTrial = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Btn_GotoTrial"
  },
  goStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
  },
  txtName = {sComponentName = "TMP_Text"},
  btnCharInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CharInfo"
  },
  imgElementIcon = {sComponentName = "Image"},
  txtElement = {sComponentName = "TMP_Text"},
  txtCharClass = {sComponentName = "TMP_Text"},
  imgAttackType = {sComponentName = "Image"}
}
TrialCtrl._mapEventConfig = {}

function TrialCtrl:RefreshRemainTime()
  local endTime = self.actData:GetActEndTime()
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local remainTime = endTime - curTime
  if remainTime < 0 then
    TimerManager.Remove(self.remainTimer)
    self.remainTimer = nil
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_1"),
      callbackConfirm = function()
        EventManager.Hit(EventId.ClosePanel, PanelId.ActivityList)
      end
    })
    return
  end
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  NovaAPI.SetTMPText(self._mapNode.txtActivityTime, sTimeStr)
end

function TrialCtrl:Refresh()
  self:RefreshCharList()
  self:RefreshCharInfo()
  self:RefreshReward()
end

function TrialCtrl:RefreshCharInfo()
  local nCharId = self.tbCharId[self.nSelectIndex]
  local mapCfg = ConfigTable.GetData_Character(nCharId)
  local mapItem = ConfigTable.GetData_Item(nCharId)
  if not mapCfg or not mapItem then
    return
  end
  local nMaxStar = 6 - mapItem.Rarity
  self._mapNode.goStar:SetStar(0, nMaxStar)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  local nEET = mapCfg.EET
  self:SetAtlasSprite(self._mapNode.imgElementIcon, "12_rare", AllEnum.ElementIconType.Icon .. nEET)
  NovaAPI.SetTMPText(self._mapNode.txtElement, ConfigTable.GetUIText("T_Element_Attr_" .. nEET))
  NovaAPI.SetTMPText(self._mapNode.txtCharClass, ConfigTable.GetUIText("Char_JobClass_" .. mapCfg.Class))
  if mapCfg.CharacterAttackType == GameEnum.characterAttackType.MELEE then
    self:SetAtlasSprite(self._mapNode.imgAttackType, "10_ico", "zs_list_near")
  elseif mapCfg.CharacterAttackType == GameEnum.characterAttackType.RANGED then
    self:SetAtlasSprite(self._mapNode.imgAttackType, "10_ico", "zs_list_far")
  end
  local nCharSkinId = ConfigTable.GetData_Character(nCharId).AdvanceSkinId
  Actor2DManager.SetActor2D(PanelId.TrialActivity, self._mapNode.rawImgActor2D, nCharId, nCharSkinId)
end

function TrialCtrl:RefreshReward()
  self.tbReward = {}
  local nGroupId = self.tbGroup[self.nSelectIndex]
  local mapCfg = ConfigTable.GetData("TrialGroup", nGroupId)
  if not mapCfg then
    return
  end
  local bReceived = self.actData:CheckGroupReceived(nGroupId)
  for i = 1, 3 do
    local nId = mapCfg["RewardId" .. i]
    if 0 < nId then
      self._mapNode.btnItem[i].gameObject:SetActive(true)
      self._mapNode.item[i]:SetItem(nId, nil, mapCfg["Qty" .. i], nil, bReceived)
      table.insert(self.tbReward, nId)
    else
      self._mapNode.btnItem[i].gameObject:SetActive(false)
    end
  end
end

function TrialCtrl:RefreshCharList()
  local nCount = #self.tbCharId
  if nCount == 1 then
    self._mapNode.goCharRoot:SetActive(false)
    return
  end
  self._mapNode.goCharRoot:SetActive(true)
  self._mapNode.rtChar:SetActive(nCount <= 4)
  self._mapNode.sv.gameObject:SetActive(4 < nCount)
  if nCount <= 4 then
    for i = 1, 4 do
      self._mapNode.btnChar[i].gameObject:SetActive(i <= nCount)
      if i <= nCount then
        local nCharId = self.tbCharId[i]
        local nCharSkinId = ConfigTable.GetData_Character(nCharId).AdvanceSkinId
        local sIcon = ConfigTable.GetData_CharacterSkin(nCharSkinId).Icon
        self:SetPngSprite(self._mapNode.imgHead[i], sIcon, AllEnum.CharHeadIconSurfix.L)
        self._mapNode.goSelect[i]:SetActive(self.nSelectIndex == i)
        self._mapNode.imgSelectBg[i]:SetActive(self.nSelectIndex == i)
      end
    end
  else
    self._mapNode.sv:Init(nCount, self, self.OnGridRefresh, self.OnGridClick)
  end
end

function TrialCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nCharId = self.tbCharId[nIndex]
  local nCharSkinId = ConfigTable.GetData_Character(nCharId).AdvanceSkinId
  local sIcon = ConfigTable.GetData_CharacterSkin(nCharSkinId).Icon
  local imgHead = goGrid.transform:Find("btnChar/AnimRoot/imgHead"):GetComponent("Image")
  local goSelect = goGrid.transform:Find("btnChar/AnimRoot/goSelect").gameObject
  local imgSelectBg = goGrid.transform:Find("btnChar/AnimRoot/imgSelectBg").gameObject
  self:SetPngSprite(imgHead, sIcon, AllEnum.CharHeadIconSurfix.L)
  goSelect:SetActive(self.nSelectIndex == nIndex)
  imgSelectBg:SetActive(self.nSelectIndex == nIndex)
end

function TrialCtrl:OnGridClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if self.nSelectIndex == nIndex then
    return
  end
  goGrid.transform:Find("btnChar/AnimRoot/imgSelectBg").gameObject:SetActive(true)
  goGrid.transform:Find("btnChar/AnimRoot/goSelect").gameObject:SetActive(true)
  local sPathSelectBg = "Viewport/Content/" .. tostring(self.nSelectIndex - 1) .. "/btnChar/AnimRoot/imgSelectBg"
  local sPathSelect = "Viewport/Content/" .. tostring(self.nSelectIndex - 1) .. "/btnChar/AnimRoot/goSelect"
  local goSelectBg = self._mapNode.sv.transform:Find(sPathSelectBg)
  local goSelect = self._mapNode.sv.transform:Find(sPathSelect)
  if goSelectBg then
    goSelectBg.gameObject:SetActive(false)
  end
  if goSelect then
    goSelect.gameObject:SetActive(false)
  end
  self.nSelectIndex = nIndex
  self._mapNode.sv:SetScrollGridPos(gridIndex, 0.1, 1)
  self:RefreshCharInfo()
  self:RefreshReward()
end

function TrialCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  PlayerData.Trial:SetTrialAct(self.nActId)
  self.nSelectIndex = 1
  local actCfg = self.actData:GetActCfgData()
  if actCfg.EndType == GameEnum.activityEndType.NoLimit then
    self._mapNode.goActTime.gameObject:SetActive(false)
  else
    self._mapNode.goActTime.gameObject:SetActive(true)
    self:RefreshRemainTime()
    if nil == self.remainTimer then
      self.remainTimer = self:AddTimer(0, 1, "RefreshRemainTime", true, true, false)
    end
  end
  local mapCfg = ConfigTable.GetData("TrialControl", self.nActId)
  if not mapCfg then
    return
  end
  self.tbGacha = mapCfg.Gachas
  self.tbGroup = mapCfg.GroupIds
  self.tbCharId = {}
  for _, v in ipairs(self.tbGroup) do
    local mapGroup = ConfigTable.GetData("TrialGroup", v)
    if mapGroup then
      local mapTrial = ConfigTable.GetData("TrialCharacter", mapGroup.TrialChar)
      if mapTrial then
        table.insert(self.tbCharId, mapTrial.CharId)
      end
    end
  end
  self:Refresh()
end

function TrialCtrl:ClearActivity()
  Actor2DManager.UnsetActor2D()
end

function TrialCtrl:Awake()
end

function TrialCtrl:OnEnable()
end

function TrialCtrl:OnDisable()
  Actor2DManager.UnsetActor2D()
end

function TrialCtrl:OnDestroy()
end

function TrialCtrl:OnBtnClick_Trial()
  PlayerData.Trial:SetSelectTrialGroup(self.tbGroup[self.nSelectIndex])
  EventManager.Hit(EventId.OpenPanel, PanelId.TrialLevelSelect)
end

function TrialCtrl:OnBtnClick_Gacha()
  local function getInfoCallback()
    local function func()
      EventManager.Hit(EventId.OpenPanel, PanelId.GachaSpin, self.tbGacha[self.nSelectIndex])
    end
    
    EventManager.Hit(EventId.SetTransition, 6, func, AllEnum.MainViewCorner.Recruit)
  end
  
  PlayerData.Gacha:GetGachaInfomation(getInfoCallback)
end

function TrialCtrl:OnBtnClick_CharInfo()
  EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, self.tbCharId[self.nSelectIndex])
end

function TrialCtrl:OnBtnClick_Char(btn, nIndex)
  if self.nSelectIndex == nIndex then
    return
  end
  self._mapNode.goSelect[self.nSelectIndex]:SetActive(false)
  self._mapNode.imgSelectBg[self.nSelectIndex]:SetActive(false)
  self._mapNode.goSelect[nIndex]:SetActive(true)
  self._mapNode.imgSelectBg[nIndex]:SetActive(true)
  self.nSelectIndex = nIndex
  self:RefreshCharInfo()
  self:RefreshReward()
end

function TrialCtrl:OnBtnClick_TrialInfo()
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = ConfigTable.GetUIText("Trial_DetailInfo")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function TrialCtrl:OnBtnClick_ItemTips(btn, nIndex)
  if self.tbReward[nIndex] then
    local mapData = {
      nTid = self.tbReward[nIndex],
      bShowDepot = true,
      bShowJumpto = false
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
  end
end

return TrialCtrl
