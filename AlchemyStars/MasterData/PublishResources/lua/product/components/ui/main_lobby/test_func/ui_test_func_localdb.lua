_class("UITestFuncLocalDB", UICustomWidget)
UITestFuncLocalDB = UITestFuncLocalDB

function UITestFuncLocalDB:OnShow(uiParams)
  self._root = self:GetGameObject("_root")
  self._localDBIdText = self:GetUIComponent("UILocalizationText", "_localDBIdText")
  self._checkText = self:GetUIComponent("UILocalizationText", "_checkText")
  self._editText = self:GetUIComponent("UILocalizationText", "_editText")
  self:_FillGroupData()
  self:_SetGroupBtn()
end

function UITestFuncLocalDB:OnHide()
end

function UITestFuncLocalDB:_FillGroupData()
  self._btnsTitle = {}
  self._btnsCallback = {}
  self._btnsDeleteCallback = {}
  self._btnsCheckCallback = {}
  self._btnsReadCallback = {}
  self._btnsWriteCallback = {}
  local key = self:_GetCampaignFirstPlotKeyStr(1021, ECampaignN13ComponentID.ECAMPAIGN_N13_BUILD)
  self:_AddFunc("UIN13Build_FirstPlot", key, 1, 1)
  local key = self:_GetCampaignFirstPlotKeyStr(1059)
  self:_AddFunc("UIN17Main_FirstPlot", key, 1, 1)
  local key = self:_GetCampaignFirstPlotKeyStr(1059, ECampaignN17ComponentID.ECAMPAIGN_N17_MINI_GAME)
  self:_AddFunc("UIN17MiniGame_FirstPlot", key, 1, 1)
  local key = self:_GetCampaignFirstPlotKeyStr(1061)
  self:_AddFunc("AnniversaryLogin", key, 1, 1)
  local key = self:_GetCampaignFirstPlotKeyStr(1062)
  self:_AddFunc("UIN19P5_FirstPlot", key, 1, 1)
  local key = self:_GetCampaignFirstPlotKeyStr(1064)
  self:_AddFunc("UIN19Main_FirstPlot", key, 1, 1)
  local key = self:_GetCampaignFirstPlotKeyStr(1068)
  self:_AddFunc("UIN21_FirstPlot", key, 1, 1)
  local key = UIActivityHelper.GetLocalDBKeyWithPstId("QuestModule_GrowthNewPoint_")
  self:_AddFunc("QuestGrowthNew", key, 1, 1)
  local key = UIActivityHelper.GetLocalDBKeyWithPstId("QuestSeasonKey") .. 8001
  self:_AddFunc("QuestSeasonNew", key, 1, 1)
end

function UITestFuncLocalDB:_GetCampaignFirstPlotKeyStr(campaignId, componentId)
  local tb = {
    "PlayFirstPlot_Campaign_",
    "PlayFirstPlot_Component_"
  }
  local keyStr = componentId and tb[2] or tb[1]
  keyStr = keyStr .. campaignId
  keyStr = componentId and keyStr .. "_" .. componentId or keyStr
  return UIActivityHelper.GetLocalDBKeyWithPstId(keyStr .. "_")
end

function UITestFuncLocalDB:_SetGroupBtn()
  local sop = self:GetUIComponent("UISelectObjectPath", "_btnPool")
  sop:SpawnObjects("UIMainLobbyTestFuncBtn", table.count(self._btnsTitle))
  local list = sop:GetAllSpawnList()
  for i = 1, #self._btnsTitle do
    list[i]:SetData(self._btnsTitle[i], self._btnsCallback[i])
  end
end

function UITestFuncLocalDB:_AddFunc(title, text, classType, dataType)
  self:_AddFunc_Title(title, text)
  self:_AddFunc_Delete(classType)
  self:_AddFunc_Check(classType)
  self:_AddFunc_Read(classType, dataType)
  self:_AddFunc_Write(classType, dataType)
end

function UITestFuncLocalDB:_AddFunc_Title(title, text)
  table.insert(self._btnsTitle, title)
  local idx = #self._btnsCallback
  local params = {}
  params[1] = function()
    self._localDBIdText:SetText(text)
    self._btnIndex = idx + 1
  end
  table.insert(self._btnsCallback, params)
end

function UITestFuncLocalDB:_AddFunc_Delete(classType)
  local deleteFunc = {
    LocalDB.Delete,
    UnityEngine.PlayerPrefs.DeleteKey
  }
  table.insert(self._btnsDeleteCallback, function()
    local str = self._localDBIdText.text
    if string.isnullorempty(str) then
      return
    end
    local func = deleteFunc[classType]
    if func then
      func(str)
    end
  end)
end

function UITestFuncLocalDB:_AddFunc_Check(classType)
  local checkFunc = {
    LocalDB.HasKey,
    UnityEngine.PlayerPrefs.HasKey
  }
  table.insert(self._btnsCheckCallback, function()
    local str = self._localDBIdText.text
    if string.isnullorempty(str) then
      return
    end
    local func = checkFunc[classType]
    local val
    if func then
      val = func(str)
    end
    if val then
      ToastManager.ShowToast("True!")
    else
      ToastManager.ShowToast("False")
    end
  end)
end

function UITestFuncLocalDB:_AddFunc_Read(classType, dataType)
  local readFunc = {
    {
      [1] = LocalDB.GetInt,
      [2] = LocalDB.GetFloat,
      [3] = LocalDB.GetString
    },
    {
      [1] = UnityEngine.PlayerPrefs.GetInt,
      [2] = UnityEngine.PlayerPrefs.GetFloat,
      [3] = UnityEngine.PlayerPrefs.GetString
    }
  }
  table.insert(self._btnsReadCallback, function()
    local str = self._localDBIdText.text
    if string.isnullorempty(str) then
      return
    end
    local val
    local func = readFunc[classType][dataType]
    if func then
      val = func(str)
    end
    self._checkText:SetText(val)
  end)
end

function UITestFuncLocalDB:_AddFunc_Write(classType, dataType)
  local writeFunc = {
    {
      [1] = LocalDB.SetInt,
      [2] = LocalDB.SetFloat,
      [3] = LocalDB.SetString
    },
    {
      [1] = UnityEngine.PlayerPrefs.SetInt,
      [2] = UnityEngine.PlayerPrefs.SetFloat,
      [3] = UnityEngine.PlayerPrefs.SetString
    }
  }
  table.insert(self._btnsWriteCallback, function()
    local str = self._localDBIdText.text
    if string.isnullorempty(str) then
      return
    end
    local val = self._editText.text
    local func = writeFunc[classType][dataType]
    if func then
      func(str, val)
    end
  end)
end

function UITestFuncLocalDB:ExitBtnOnClick()
  self._root:SetActive(false)
end

function UITestFuncLocalDB:DeleteBtnOnClick()
  self:SafeCallback(self._btnsDeleteCallback)
end

function UITestFuncLocalDB:CheckBtnOnClick()
  self:SafeCallback(self._btnsCheckCallback)
end

function UITestFuncLocalDB:ReadBtnOnClick()
  self:SafeCallback(self._btnsReadCallback)
end

function UITestFuncLocalDB:WriteBtnOnClick()
  self:SafeCallback(self._btnsWriteCallback)
end

function UITestFuncLocalDB:SafeCallback(callback)
  if self._btnIndex and self._btnIndex > 0 and self._btnIndex <= table.count(callback) and callback[self._btnIndex] then
    callback[self._btnIndex]()
  end
end
