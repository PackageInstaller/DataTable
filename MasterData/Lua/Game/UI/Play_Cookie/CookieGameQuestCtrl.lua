local CookieGameQuestCtrl = class("CookieGameQuestCtrl", BaseCtrl)
local totalLength = 520
local totalHeight = 37
CookieGameQuestCtrl._mapNodeConfig = {
  loopSv = {
    sNodeName = "goQuest",
    sComponentName = "LoopScrollView"
  },
  rtBarFill = {
    sComponentName = "RectTransform"
  },
  btn_AllReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AllReceive"
  },
  txt_AllReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_AllReceive"
  }
}
CookieGameQuestCtrl._mapEventConfig = {}

function CookieGameQuestCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self:InitData()
end

function CookieGameQuestCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function CookieGameQuestCtrl:InitData()
  self.actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.tbQuestList = {}
  self.tbGridCtrl = {}
end

function CookieGameQuestCtrl:InitQuestData()
  self.tbQuestList = self.actData:GetAllQuestData()
  if nil == self.tbQuestList or #self.tbQuestList == 0 then
    return
  end
  table.sort(self.tbQuestList, function(a, b)
    if a.nStatus == b.nStatus then
      return a.Id < b.Id
    end
    return a.nStatus < b.nStatus
  end)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.loopSv:SetAnim(0.1)
  self._mapNode.loopSv:Init(#self.tbQuestList, self, self.OnGridRefresh)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  self._mapNode.rtBarFill.sizeDelta = Vector2(self.actData:GetCompleteCount() / #self.tbQuestList * totalLength, totalHeight)
end

function CookieGameQuestCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Play_Cookie.CookieQuestCellCtrl")
  end
  self.tbGridCtrl[nInstanceId]:SetData(self.nActId, self.tbQuestList[nIndex])
end

function CookieGameQuestCtrl:OnBtnClick_AllReceive()
  PlayerData.Activity:SendReceivePerQuest(self.nActId, 0, nil)
end

return CookieGameQuestCtrl
