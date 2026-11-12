local DoubleDropActQuestCtrl = class("DoubleDropActQuestCtrl", BaseCtrl)
DoubleDropActQuestCtrl._mapNodeConfig = {
  goBlur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  goRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Transform"
  },
  btnFullClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  aniWindow = {sNodeName = "questPopup", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Double_Drops_Quest_Reward_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  sv = {
    sComponentName = "LoopScrollView"
  },
  btn_GetAllReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GetAllReward"
  },
  btn_GetAllReward_None = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GetAllReward"
  },
  txt_GetAll = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Double_Drops_Quest_Reward_Receive"
  }
}
DoubleDropActQuestCtrl._mapEventConfig = {}
DoubleDropActQuestCtrl._mapRedDotConfig = {}
local nQuestItemWidth = 756
local nMinWidth = 32

function DoubleDropActQuestCtrl:ShowQuestList()
  self.actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  if self.actData == nil then
    return
  end
  self.tbItemCtrl = {}
  self:RefreshQuestList()
  self._mapNode.goRoot.gameObject:SetActive(false)
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goRoot.gameObject:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  end
  
  cs_coroutine.start(wait)
end

function DoubleDropActQuestCtrl:RefreshQuestList()
  self.tbQuest = self.actData:GetAllQuests()
  table.sort(self.tbQuest, function(a, b)
    if a.nStatus == b.nStatus then
      return a.nId < b.nId
    end
    return a.nStatus < b.nStatus
  end)
  self._mapNode.sv:SetAnim(0.08)
  self._mapNode.sv:Init(#self.tbQuest, self, self.OnGridQuestRefresh, nil, false)
  self.bHasComQuest = false
  for _, v in ipairs(self.tbQuest) do
    if v.nStatus == AllEnum.ActQuestStatus.Complete then
      self.bHasComQuest = true
      break
    end
  end
  self._mapNode.btn_GetAllReward.gameObject:SetActive(self.bHasComQuest)
  self._mapNode.btn_GetAllReward_None.gameObject:SetActive(not self.bHasComQuest)
end

function DoubleDropActQuestCtrl:OnGridQuestRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local instanceId = goGrid:GetInstanceID()
  local questData = self.tbQuest[nIndex]
  local goRoot = goGrid.transform:Find("btnGrid/AnimRoot/Root")
  local img_Received = goRoot.transform:Find("img_Received")
  local btn_item = goRoot.transform:Find("btn_item"):GetComponent("UIButton")
  local item = goRoot.transform:Find("btn_item/AnimRoot/item")
  if self.tbItemCtrl[instanceId] == nil then
    self.tbItemCtrl[instanceId] = self:BindCtrlByNode(item.gameObject, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  local txtTarget = goRoot.transform:Find("txt_target"):GetComponent("TMP_Text")
  local txt_com1 = goRoot.transform:Find("txt_com1"):GetComponent("TMP_Text")
  local txt_com2 = goRoot.transform:Find("txt_com2"):GetComponent("TMP_Text")
  local bar = goRoot.transform:Find("imgBarBg/rtBarFill/imgMainBarFill"):GetComponent("RectTransform")
  local img_state1 = goRoot.transform:Find("img_state1").gameObject
  local img_state2 = goRoot.transform:Find("img_state2").gameObject
  local img_state3 = goRoot.transform:Find("img_state3").gameObject
  img_state1:SetActive(questData.nStatus == AllEnum.ActQuestStatus.Complete)
  img_state2:SetActive(questData.nStatus == AllEnum.ActQuestStatus.Received)
  img_state3:SetActive(questData.nStatus == AllEnum.ActQuestStatus.UnComplete)
  img_Received.gameObject:SetActive(questData.nStatus == AllEnum.ActQuestStatus.Received)
  btn_item.onClick:RemoveAllListeners()
  local questConfig = ConfigTable.GetData("ActivityDoubleQuest", questData.nId)
  if questConfig == nil then
    return
  end
  local itemId = questConfig.ItemId
  local itemCount = questConfig.ItemQty
  btn_item.onClick:AddListener(function()
    UTILS.ClickItemGridWithTips(itemId, btn_item.transform, true, true, false)
  end)
  self.tbItemCtrl[instanceId]:SetItem(itemId, nil, itemCount, false, questData.nStatus == AllEnum.ActQuestStatus.Received, false, false)
  NovaAPI.SetTMPText(txtTarget, questConfig.Desc)
  if questData.nStatus == AllEnum.ActQuestStatus.UnComplete then
    NovaAPI.SetTMPText(txt_com1, tostring(questData.progress.Cur) .. "/" .. tostring(questData.progress.Max))
    NovaAPI.SetTMPText(txt_com2, tostring(questData.progress.Cur) .. "/" .. tostring(questData.progress.Max))
    local nWidth = 0
    if questData.progress.Cur > 0 then
      nWidth = math.max(nQuestItemWidth * (questData.progress.Cur / questData.progress.Max), nMinWidth)
    end
    bar.sizeDelta = Vector2(nWidth, bar.sizeDelta.y)
  else
    NovaAPI.SetTMPText(txt_com1, ConfigTable.GetUIText("BdConvert_QuestFinish"))
    NovaAPI.SetTMPText(txt_com2, ConfigTable.GetUIText("BdConvert_QuestFinish"))
    bar.sizeDelta = Vector2(nQuestItemWidth, bar.sizeDelta.y)
  end
  txt_com1.gameObject:SetActive(questData.nStatus ~= AllEnum.ActQuestStatus.Received)
  txt_com2.gameObject:SetActive(questData.nStatus == AllEnum.ActQuestStatus.Received)
end

function DoubleDropActQuestCtrl:Awake()
end

function DoubleDropActQuestCtrl:OnEnable()
  self.tbItemCtrl = {}
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  if self.nActId then
    self:ShowQuestList()
  end
end

function DoubleDropActQuestCtrl:OnDisable()
  if self.tbItemCtrl ~= nil then
    for _, ctrl in pairs(self.tbItemCtrl) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
end

function DoubleDropActQuestCtrl:OnDestroy()
end

function DoubleDropActQuestCtrl:OnBtnClick_Close()
  self._mapNode.aniBlur:SetTrigger("tOut")
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.DoubleDropActQuestPanel_103001)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function DoubleDropActQuestCtrl:OnBtnClick_GetAllReward()
  if self.actData == nil then
    return
  end
  if not self.bHasComQuest then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DoubleDrop_Reward_Receive_Tip"))
    return
  end
  
  local function callback()
    self:RefreshQuestList()
  end
  
  self.actData:SendReceiveQuestReward(0, callback)
end

return DoubleDropActQuestCtrl
