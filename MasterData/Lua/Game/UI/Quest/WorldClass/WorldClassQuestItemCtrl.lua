local WorldClassQuestItemCtrl = class("WorldClassQuestItemCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
WorldClassQuestItemCtrl._mapNodeConfig = {
  txtUnComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Demon_Quest_UnComplete"
  },
  imgComplete = {},
  imgCompleteMask = {},
  imgUnOpen = {},
  txtUnOpen = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Level_Lock"
  },
  txtQuestDesc = {sComponentName = "TMP_Text", nCount = 2},
  goOpen = {},
  btnJump = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Jump"
  },
  txtBtnJump = {
    sComponentName = "TMP_Text",
    sLanguageId = "Demon_Quest_JumpTo"
  },
  imgProgressBar = {
    sComponentName = "RectTransform"
  },
  rtBarFill = {
    sComponentName = "RectTransform"
  },
  txtProgress = {sComponentName = "TMP_Text"}
}
WorldClassQuestItemCtrl._mapEventConfig = {}
WorldClassQuestItemCtrl._mapRedDotConfig = {}
local totalLength = 700
local totalHeight = 37

function WorldClassQuestItemCtrl:SetItem(questData, bUnOpen)
  self.mapQuest = questData
  self.bUnOpen = bUnOpen
  local mapQuestCfg = ConfigTable.GetData("DemonQuest", questData.nTid)
  if mapQuestCfg ~= nil then
    self.nJumpTo = mapQuestCfg.JumpTo
    for _, v in ipairs(self._mapNode.txtQuestDesc) do
      NovaAPI.SetTMPText(v, mapQuestCfg.Title)
    end
    self._mapNode.imgUnOpen.gameObject:SetActive(self.bUnOpen)
    self._mapNode.goOpen:SetActive(not self.bUnOpen)
    if not self.bUnOpen then
      self._mapNode.txtUnComplete.gameObject:SetActive(questData.nStatus == 0 and self.nJumpTo == 0)
      self._mapNode.imgComplete.gameObject:SetActive(questData.nStatus ~= 0)
      self._mapNode.imgCompleteMask.gameObject:SetActive(questData.nStatus ~= 0)
      self._mapNode.btnJump.gameObject:SetActive(questData.nStatus == 0 and self.nJumpTo ~= 0)
    end
    if questData.nStatus == 0 then
      NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%s/%s", questData.nCurProgress, questData.nGoal))
      self._mapNode.rtBarFill.sizeDelta = Vector2(questData.nCurProgress / questData.nGoal * totalLength, totalHeight)
    else
      NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%s/%s", questData.nCurProgress, questData.nGoal))
      self._mapNode.rtBarFill.sizeDelta = Vector2(totalLength, totalHeight)
    end
  end
end

function WorldClassQuestItemCtrl:Awake()
end

function WorldClassQuestItemCtrl:OnEnable()
end

function WorldClassQuestItemCtrl:OnDisable()
end

function WorldClassQuestItemCtrl:OnDestroy()
end

function WorldClassQuestItemCtrl:OnBtnClick_Jump()
  if self.nJumpTo ~= nil and self.nJumpTo ~= 0 then
    JumpUtil.JumpTo(self.nJumpTo)
  end
end

return WorldClassQuestItemCtrl
