local BdConvertQuestCtrl = class("BdConvertQuestCtrl", BaseCtrl)
local barMinX = -750
local barMaxX = 0
BdConvertQuestCtrl._mapNodeConfig = {
  goBlur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  animator = {sNodeName = "quest", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_QuestTitle"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnFullClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txt_socreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_Score"
  },
  txt_score = {sComponentName = "TMP_Text"},
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
    sLanguageId = "BdConvert_GetQuestReward"
  },
  img_score = {sComponentName = "Image"}
}
BdConvertQuestCtrl._mapEventConfig = {}
BdConvertQuestCtrl._mapRedDotConfig = {}

function BdConvertQuestCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  local cfg = ConfigTable.GetData("BdConvert", self.nActId)
  if cfg ~= nil and cfg.ScoreItemId ~= 0 then
    self:SetPngSprite(self._mapNode.img_score, ConfigTable.GetData_Item(cfg.ScoreItemId).Icon2)
  end
  self:InitData()
end

function BdConvertQuestCtrl:OnEnable()
  self._mapNode.goBlur:SetActive(true)
  self._mapNode.animator:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function BdConvertQuestCtrl:OnDestroy()
  if self.tbItemCtrl ~= nil then
    for _, ctrl in pairs(self.tbItemCtrl) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
end

function BdConvertQuestCtrl:InitData()
  self.tbItemCtrl = {}
  self.actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.bdConfig = self.actData:GetBdConvertConfig()
  self:InitQuest()
  self:UpdateScore()
  local bHasComQuest = self.actData:CheckHasComQuest()
  self._mapNode.btn_GetAllReward.gameObject:SetActive(bHasComQuest)
  self._mapNode.btn_GetAllReward_None.gameObject:SetActive(not bHasComQuest)
end

function BdConvertQuestCtrl:InitQuest()
  self.questIdList = self.actData:GetQuestIdList()
  self._mapNode.sv:Init(#self.questIdList, self, self.OnGridRefresh)
end

function BdConvertQuestCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local instanceId = goGrid:GetInstanceID()
  local nId = self.questIdList[nIndex]
  local questData = self.actData:GetQuestDataById(nId)
  local img_Received = goGrid.transform:Find("GameObject/AnimRoot/Root/img_Received")
  local btn_item = goGrid.transform:Find("GameObject/AnimRoot/Root/btn_item"):GetComponent("UIButton")
  local item = goGrid.transform:Find("GameObject/AnimRoot/Root/btn_item/AnimRoot/item")
  if self.tbItemCtrl[instanceId] == nil then
    self.tbItemCtrl[instanceId] = self:BindCtrlByNode(item, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  local txtTarget = goGrid.transform:Find("GameObject/AnimRoot/Root/txt_target"):GetComponent("TMP_Text")
  local txt_com1 = goGrid.transform:Find("GameObject/AnimRoot/txt_com1"):GetComponent("TMP_Text")
  local txt_com2 = goGrid.transform:Find("GameObject/AnimRoot/txt_com2"):GetComponent("TMP_Text")
  local bar = goGrid.transform:Find("GameObject/AnimRoot/Root/imgBarBg/rtBarFill/imgMainBarFill"):GetComponent("RectTransform")
  local img_state1 = goGrid.transform:Find("GameObject/AnimRoot/Root/img_state1").gameObject
  local img_state2 = goGrid.transform:Find("GameObject/AnimRoot/Root/img_state2").gameObject
  local img_state3 = goGrid.transform:Find("GameObject/AnimRoot/Root/img_state3").gameObject
  img_state1:SetActive(questData.nState == AllEnum.ActQuestStatus.Complete)
  img_state2:SetActive(questData.nState == AllEnum.ActQuestStatus.Received)
  img_state3:SetActive(questData.nState == AllEnum.ActQuestStatus.UnComplete)
  img_Received.gameObject:SetActive(questData.nState == AllEnum.ActQuestStatus.Received)
  btn_item.onClick:RemoveAllListeners()
  local questConfig = ConfigTable.GetData("BdConvertRewardGroup", questData.nId)
  local tbReward = decodeJson(questConfig.Rewards)
  local itemId = 0
  local itemCount = 0
  for k, v in pairs(tbReward) do
    itemId = tonumber(k)
    itemCount = tonumber(v)
  end
  btn_item.onClick:AddListener(function()
    UTILS.ClickItemGridWithTips(itemId, btn_item.transform, true, false, false)
  end)
  self.tbItemCtrl[instanceId]:SetItem(itemId, nil, itemCount, false, questData.nState == AllEnum.ActQuestStatus.Received, false, false)
  NovaAPI.SetTMPText(txtTarget, questConfig.Des)
  if questData.nState == AllEnum.ActQuestStatus.UnComplete then
    NovaAPI.SetTMPText(txt_com1, tostring(questData.nCur) .. "/" .. tostring(questData.nMax))
    NovaAPI.SetTMPText(txt_com2, tostring(questData.nCur) .. "/" .. tostring(questData.nMax))
  else
    NovaAPI.SetTMPText(txt_com1, ConfigTable.GetUIText("BdConvert_QuestFinish"))
    NovaAPI.SetTMPText(txt_com2, ConfigTable.GetUIText("BdConvert_QuestFinish"))
  end
  txt_com1.gameObject:SetActive(questData.nState ~= AllEnum.ActQuestStatus.Received)
  txt_com2.gameObject:SetActive(questData.nState == AllEnum.ActQuestStatus.Received)
  bar.anchoredPosition = Vector2(barMinX + (barMaxX - barMinX) * (questData.nCur / questData.nMax), bar.anchoredPosition.y)
end

function BdConvertQuestCtrl:UpdateScore()
  local nCurScore = self.actData:GetScore()
  local nMaxScore = self.bdConfig.ScoreItemLimit
  NovaAPI.SetTMPText(self._mapNode.txt_score, string.format("<color=#D19C62>%s</color>/%s", nCurScore, nMaxScore))
end

function BdConvertQuestCtrl:OnBtnClick_Close()
  self._mapNode.animator:Play("t_window_04_t_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:AddTimer(1, 0.3, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.BdConvertQuestPanel)
  end, true, true, true, nil)
end

function BdConvertQuestCtrl:OnBtnClick_GetAllReward()
  local function callback()
    self:InitData()
  end
  
  self.actData:RequestReceiveQuest(callback)
end

return BdConvertQuestCtrl
