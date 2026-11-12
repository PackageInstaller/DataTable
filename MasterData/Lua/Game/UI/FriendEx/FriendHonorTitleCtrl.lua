local FriendHonorTitleCtrl = class("FriendHonorTitleCtrl", BaseCtrl)
local localdata = require("GameCore.Data.LocalData")
local RapidJson = require("rapidjson")
FriendHonorTitleCtrl._mapNodeConfig = {
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  btnCurHonorTitle = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeHonorTitle"
  },
  goCurHonorTitle = {
    nCount = 3,
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  },
  imgSelect = {nCount = 3},
  svHonorTitle = {
    sComponentName = "LoopScrollView"
  },
  btnTab = {
    sNodeName = "tab",
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeHonorTitleType"
  },
  imgTab = {nCount = 4},
  txtTab = {nCount = 4},
  txtTabUnSelect = {nCount = 4},
  imgCurHonorTitleBg = {nCount = 3},
  HonorTitleContent = {},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Honor_Title"
  },
  txtBtnCancel = {sComponentName = "TMP_Text", sLanguageId = "BtnCancel"},
  txtBtnConfirm = {sComponentName = "TMP_Text", sLanguageId = "BtnConfirm"},
  txtEquipHonorTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cur_Honor_Title_Equiped"
  },
  txtTab1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Honor_Title_All"
  },
  txtTab2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Honor_Title_Achievement"
  },
  txtTab3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Honor_Title_Affinity"
  },
  txtTab4 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Honor_Title_Activity"
  },
  txtTabUnSelect1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Honor_Title_All"
  },
  txtTabUnSelect2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Honor_Title_Achievement"
  },
  txtTabUnSelect3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Honor_Title_Affinity"
  },
  txtTabUnSelect4 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Honor_Title_Activity"
  }
}
FriendHonorTitleCtrl._mapEventConfig = {}
local HonorTitleType = {
  All = 1,
  Achievement = 2,
  Affinity = 3,
  Activity = 4
}
local L2_LV = 21
local L3_LV = 41

function FriendHonorTitleCtrl:Open()
  self:PlayInAni()
  self.tbCurHonorTitle = {}
  self.tbAllHonorData = {}
  self.tbGoChosenState = {}
  self.ownHonorData = PlayerData.Base:GetPlayerHonorTitleList() or {}
  local curHononData = PlayerData.Base:GetPlayerHonorTitle() or {}
  for k, v in ipairs(curHononData) do
    table.insert(self.tbCurHonorTitle, v.Id)
  end
  local allData = ConfigTable.Get("Honor")
  local groupData = {}
  
  local function foreachHonor(mapData)
    local bHas = false
    for k, v in pairs(self.ownHonorData) do
      if v.Id == mapData.Id then
        bHas = true
        break
      end
    end
    if mapData.IsUnlock == true or self.ownHonorData ~= nil and bHas then
      if mapData.Type == GameEnum.honorType.Group then
        if groupData[mapData.Params[1]] == nil then
          groupData[mapData.Params[1]] = {}
        end
        table.insert(groupData[mapData.Params[1]], mapData)
      end
      table.insert(self.tbAllHonorData, mapData)
    end
  end
  
  ForEachTableLine(allData, foreachHonor)
  for _, group in pairs(groupData) do
    local maxPriotity = group[1]
    for k, v in ipairs(group) do
      if v.Priotity > maxPriotity.Priotity then
        table.removebyvalue(self.tbAllHonorData, maxPriotity)
        maxPriotity = v
      end
    end
  end
  self:OnBtnClick_ChangeHonorTitle(nil, 1)
  self:OnBtnClick_ChangeHonorTitleType(nil, 1)
  self:Refresh()
end

function FriendHonorTitleCtrl:Refresh()
  self:RefreshHonorTitle()
  self:RefreshHonorTitleList()
end

function FriendHonorTitleCtrl:RefreshHonorTitle()
  for i = 1, 3 do
    if self.tbCurHonorTitle[i] ~= nil and self.tbCurHonorTitle[i] ~= 0 then
      local honorData = ConfigTable.GetData("Honor", self.tbCurHonorTitle[i])
      local level
      if honorData.Type == GameEnum.honorType.Character then
        local affinityData = PlayerData.Char:GetCharAffinityData(honorData.Params[1])
        level = affinityData.Level
      elseif honorData.Type == GameEnum.honorType.Levels then
        for k, v in pairs(self.ownHonorData) do
          if v.Id == honorData.Id then
            level = v.Lv or 1
            break
          end
        end
      elseif honorData.Type == GameEnum.honorType.Dorm then
        level = PlayerData.PlayerDormData:GetHonorTitleLevel()
      end
      self._mapNode.goCurHonorTitle[i]:SetHonotTitle(honorData.Id, i == 1, level)
    end
    self._mapNode.goCurHonorTitle[i].gameObject:SetActive(self.tbCurHonorTitle[i] ~= nil and self.tbCurHonorTitle[i] ~= 0)
    self._mapNode.imgCurHonorTitleBg[i]:SetActive(self.tbCurHonorTitle[i] == nil or self.tbCurHonorTitle[i] == 0)
  end
end

function FriendHonorTitleCtrl:RefreshHonorTitleList()
  local nCount = 0
  self.tbRefreshDataList = {}
  local tbCachedGroupHonorData = {}
  if self.nSelectedType == HonorTitleType.All then
    nCount = #self.tbAllHonorData
    self.tbRefreshDataList = self.tbAllHonorData
  else
    for k, v in ipairs(self.tbAllHonorData) do
      local data = v
      if data.TabType == GameEnum.honorTabType.Achieve then
        if self.nSelectedType == HonorTitleType.Achievement then
          if tbCachedGroupHonorData[data.Id] ~= nil then
            if tbCachedGroupHonorData[data.Id] < data.Priotity then
              tbCachedGroupHonorData[data.Id] = data.Priotity
              table.insert(self.tbRefreshDataList, v)
            end
          else
            tbCachedGroupHonorData[data.Id] = data.Priotity
            table.insert(self.tbRefreshDataList, v)
          end
        end
      elseif data.TabType == GameEnum.honorTabType.Character then
        if self.nSelectedType == HonorTitleType.Affinity then
          table.insert(self.tbRefreshDataList, v)
        end
      elseif data.TabType == GameEnum.honorTabType.Activity and self.nSelectedType == HonorTitleType.Activity then
        table.insert(self.tbRefreshDataList, v)
      end
    end
    nCount = #self.tbRefreshDataList
  end
  table.sort(self.tbRefreshDataList, function(a, b)
    if a.Sort ~= b.Sort then
      return a.Sort > b.Sort
    else
      return a.Id < b.Id
    end
  end)
  self.tbHonorTitle = {}
  self.tbGridRedDot = {}
  self._mapNode.HonorTitleContent:SetActive(0 < nCount)
  if 0 < nCount then
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
    self._mapNode.svHonorTitle:Init(nCount, self, self.OnGridRefresh)
  end
end

function FriendHonorTitleCtrl:RefreshReddot(honorId)
  local sJson = localdata.GetPlayerLocalData("HonorTitle")
  local localHonorTilte = decodeJson(sJson)
  if type(localHonorTilte) ~= "table" then
    return
  end
  local bFind = false
  for k, v in pairs(localHonorTilte) do
    if tonumber(v) == honorId then
      RedDotManager.SetValid(RedDotDefine.Friend_Honor_Title_Item, honorId, false)
      table.remove(localHonorTilte, k)
      bFind = true
      break
    end
  end
  if bFind then
    localdata.SetPlayerLocalData("HonorTitle", RapidJson.encode(localHonorTilte))
  end
end

function FriendHonorTitleCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local honorData = self.tbRefreshDataList[nIndex]
  local btnGrid = goGrid.transform:Find("btnGrid"):GetComponent("UIButton")
  local animRoot = btnGrid.transform:Find("AnimRoot")
  local imgHonorTitleChooseBg = animRoot:Find("imgHonorTitleChooseBg"):GetComponent("Image")
  local goHonorTitle = animRoot:Find("goHonorTitle")
  local goChosenState = animRoot:Find("goChosenState")
  local goEquipState = animRoot:Find("goEquipState")
  local imgHonorTitleChooseBg1 = goChosenState:Find("imgHonorTitleChooseBg1"):GetComponent("Image")
  local imgHonorTitleEquipBg = goEquipState:Find("imgHonorTitleEquipBg"):GetComponent("Image")
  local txtCurChoose = goChosenState:Find("imgBg/txtCurChoose"):GetComponent("TMP_Text")
  local txtCurEquip = goEquipState:Find("imgBg/txtCurEquip"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtCurChoose, ConfigTable.GetUIText("Honor_Title_State_CurChoose"))
  NovaAPI.SetTMPText(txtCurEquip, ConfigTable.GetUIText("Honor_Title_State_CurEquip"))
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goHonorTitle, "Game.UI.FriendEx.HonorTitleCtrl")
  end
  self.tbGridRedDot[nInstanceId] = honorData.Id
  local ctrl = self.tbGridCtrl[nInstanceId]
  ctrl:RegisterRedDot(honorData.Id)
  local level
  if honorData.Type == GameEnum.honorType.Character then
    local affinityData = PlayerData.Char:GetCharAffinityData(honorData.Params[1])
    level = affinityData ~= nil and affinityData.Level or 1
  elseif honorData.Type == GameEnum.honorType.Levels then
    for k, v in pairs(self.ownHonorData) do
      if v.Id == honorData.Id then
        level = v.Lv or 1
        break
      end
    end
  elseif honorData.Type == GameEnum.honorType.Dorm then
    level = PlayerData.PlayerDormData:GetHonorTitleLevel()
  end
  local bgPath = ctrl:SetHonotTitle(honorData.Id, true, level)
  self:SetPngSprite(imgHonorTitleEquipBg, bgPath ~= "" and bgPath or honorData.MainRes)
  if bgPath ~= "" then
    NovaAPI.SetImageNativeSize(imgHonorTitleEquipBg)
  end
  local spritePath = ""
  if honorData.BGType == GameEnum.HonorTitleBgType.Ellipse then
    if level ~= nil and level >= L2_LV and level < L3_LV then
      spritePath = "db_choose_common_7"
    elseif level ~= nil and level >= L3_LV then
      spritePath = "db_choose_common_8"
    else
      spritePath = "db_choose_common_5"
    end
  elseif honorData.BGType == GameEnum.HonorTitleBgType.Parallelogram then
    spritePath = "db_choose_common_6"
  end
  self:SetAtlasSprite(imgHonorTitleChooseBg, "08_db", spritePath)
  self:SetAtlasSprite(imgHonorTitleChooseBg1, "08_db", spritePath)
  NovaAPI.SetImageNativeSize(imgHonorTitleChooseBg)
  NovaAPI.SetImageNativeSize(imgHonorTitleChooseBg1)
  local bCurChosen = self.tbCurHonorTitle[self.nSelectedIndex] == honorData.Id
  goChosenState.gameObject:SetActive(bCurChosen)
  imgHonorTitleChooseBg.gameObject:SetActive(bCurChosen)
  if self.tbCurHonorTitle[self.nSelectedIndex] == honorData.Id then
    self.tbGoChosenState[self.nSelectedIndex] = {goChosenState, imgHonorTitleChooseBg}
  end
  local bEquiped = false
  for k, v in pairs(self.tbCurHonorTitle) do
    if v == honorData.Id then
      bEquiped = true
      break
    end
  end
  goEquipState.gameObject:SetActive(not bCurChosen and bEquiped)
  btnGrid.onClick:RemoveAllListeners()
  btnGrid.onClick:AddListener(function()
    if self.tbCurHonorTitle[self.nSelectedIndex] ~= honorData.Id then
      for k, v in pairs(self.tbCurHonorTitle) do
        if v == honorData.Id then
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Honor_Title_Equiped"))
          return
        end
      end
      if self.tbGoChosenState[self.nSelectedIndex] ~= nil then
        for k, v in ipairs(self.tbGoChosenState[self.nSelectedIndex]) do
          v.gameObject:SetActive(false)
        end
      end
      self.tbCurHonorTitle[self.nSelectedIndex] = honorData.Id
      self.tbGoChosenState[self.nSelectedIndex] = {goChosenState, imgHonorTitleChooseBg}
      for k, v in ipairs(self.tbGoChosenState[self.nSelectedIndex]) do
        v.gameObject:SetActive(true)
      end
    else
      self.tbCurHonorTitle[self.nSelectedIndex] = nil
      for k, v in ipairs(self.tbGoChosenState[self.nSelectedIndex]) do
        v.gameObject:SetActive(false)
      end
      self.tbGoChosenState[self.nSelectedIndex] = nil
    end
    self:RefreshHonorTitle()
    self:RefreshReddot(honorData.Id)
  end)
end

function FriendHonorTitleCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function FriendHonorTitleCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function FriendHonorTitleCtrl:Close()
  self.gameObject:SetActive(false)
end

function FriendHonorTitleCtrl:SetTimer()
  self.bCd = true
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  self.timer = self:AddTimer(1, 5, function()
    self.bCd = false
  end, true, true, false)
end

function FriendHonorTitleCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
  self.tbGridCtrl = {}
  self.tbGridRedDot = {}
end

function FriendHonorTitleCtrl:OnEnable()
end

function FriendHonorTitleCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function FriendHonorTitleCtrl:OnDestroy()
end

function FriendHonorTitleCtrl:OnBtnClick_Cancel(btn)
  EventManager.Hit("FriendClosePop")
end

function FriendHonorTitleCtrl:OnBtnClick_ChangeHonorTitle(btn, nIndex, bInit)
  if self.nSelectedIndex ~= nil and self.nSelectedIndex == nIndex then
    return
  end
  if self.nSelectedIndex ~= nil then
    self._mapNode.imgSelect[self.nSelectedIndex]:SetActive(false)
  end
  self._mapNode.imgSelect[nIndex]:SetActive(true)
  self.nSelectedIndex = nIndex
  if not bInit then
    self:RefreshHonorTitleList()
  end
end

function FriendHonorTitleCtrl:OnBtnClick_ChangeHonorTitleType(btn, nIndex)
  if self.nSelectedType ~= nil and self.nSelectedType == nIndex then
    return
  end
  if self.nSelectedType ~= nil then
    self._mapNode.imgTab[self.nSelectedType]:SetActive(false)
    self._mapNode.txtTab[self.nSelectedType]:SetActive(false)
    self._mapNode.txtTabUnSelect[self.nSelectedType]:SetActive(true)
  end
  self._mapNode.imgTab[nIndex]:SetActive(true)
  self._mapNode.txtTab[nIndex]:SetActive(true)
  self._mapNode.txtTabUnSelect[nIndex]:SetActive(false)
  self.nSelectedType = nIndex
  self:RefreshHonorTitleList()
end

function FriendHonorTitleCtrl:OnBtnClick_Confirm()
  local function callback()
    local mapMsg = {
      nType = AllEnum.MessageBox.Tips,
      
      bPositive = true,
      sContent = ConfigTable.GetUIText("Change_Success")
    }
    EventManager.Hit(EventId.OpenMessageBox, mapMsg)
    self:OnBtnClick_Cancel()
  end
  
  if self.tbCurHonorTitle == nil then
    self.tbhonorTitle = {}
  end
  for i = 1, 3 do
    if self.tbCurHonorTitle[i] == nil then
      self.tbCurHonorTitle[i] = 0
    end
  end
  PlayerData.Base:SendPlayerHonorTitleEditReq(self.tbCurHonorTitle, callback)
end

return FriendHonorTitleCtrl
