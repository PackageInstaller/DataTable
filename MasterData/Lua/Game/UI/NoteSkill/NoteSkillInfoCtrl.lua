local NoteSkillInfoCtrl = class("NoteSkillInfoCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
NoteSkillInfoCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnCloseDatail = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  window = {},
  aniWindow = {sNodeName = "window", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Note_SkillTitle"
  },
  txtMainDiscTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Note_Skill_Name_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtSkillTitle = {sComponentName = "TMP_Text"},
  txtSkillDesc = {sComponentName = "TMP_Text"},
  txtSkillLevel = {sComponentName = "TMP_Text"},
  imgSkillIcon = {sComponentName = "Image"},
  NoteSkillBtnItem = {},
  sv = {
    sComponentName = "LoopScrollView"
  },
  goNoteContent = {
    sComponentName = "RectTransform"
  },
  goNoteSkillListContent = {
    sComponentName = "RectTransform"
  },
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  }
}
NoteSkillInfoCtrl._mapEventConfig = {
  SelectNoteListBtn = "OnEvent_SelectNoteListBtn"
}
local sNotHaveColor = "<color=#B2BFCC>"

function NoteSkillInfoCtrl:Open()
  self._mapNode.blur:SetActive(true)
  self:PlayInAni()
  self:Refresh(self.tbNote)
end

function NoteSkillInfoCtrl:Refresh(mapNote)
  for k, v in ipairsSorted(mapNote) do
    if not self.nSelectNote then
      self.nSelectNote = k
    end
    local nNoteId = tonumber(k)
    local nNoteCount = tonumber(v)
    local noteCfg = ConfigTable.GetData("SubNoteSkill", nNoteId)
    local itemObj = instantiate(self._mapNode.NoteSkillBtnItem, self._mapNode.goNoteContent)
    itemObj:SetActive(true)
    local itemCtrl = self:BindCtrlByNode(itemObj, "Game.UI.NoteSkill.NoteListBtnCtrl")
    itemCtrl:SetItem(noteCfg, nNoteCount)
  end
  EventManager.Hit("SelectNoteListBtn", self.nSelectNote, mapNote[self.nSelectNote])
end

function NoteSkillInfoCtrl:PlayInAni()
  self._mapNode.window:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function NoteSkillInfoCtrl:PlayOutAni()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, "Close", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function NoteSkillInfoCtrl:Close()
  self._mapNode.window:SetActive(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.NoteSkillInfo)
end

function NoteSkillInfoCtrl:Awake()
  self._mapNode.window:SetActive(false)
  self.nMaxLevel = ConfigTable.GetConfigNumber("DiscSubNoteSkillMaxLevel")
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.tbNote = tbParam[1]
    self.nSelectNote = tbParam[2]
  end
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

function NoteSkillInfoCtrl:OnEnable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.EnableGamepadUI("NoteSkillInfoCtrl", self:GetGamepadUINode(), nil, true)
  end
  self:Open()
end

function NoteSkillInfoCtrl:OnDisable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("NoteSkillInfoCtrl")
  end
end

function NoteSkillInfoCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

function NoteSkillInfoCtrl:OnEvent_SelectNoteListBtn(nNoteId, nLv)
  self.nLv = nLv
  self.noteCfg = ConfigTable.GetData("SubNoteSkill", nNoteId)
  if nil == self.noteCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtSkillTitle, self.noteCfg.Name)
  NovaAPI.SetTMPText(self._mapNode.txtSkillLevel, orderedFormat(ConfigTable.GetUIText("Note_Count"), nLv))
  NovaAPI.SetTMPText(self._mapNode.txtSkillDesc, self.noteCfg.BriefDesc)
  self:SetPngSprite(self._mapNode.imgSkillIcon, self.noteCfg.Icon)
  if nLv <= 0 then
    NovaAPI.SetTMPText(self._mapNode.txtSkillLevel, sNotHaveColor .. ConfigTable.GetUIText("StarTower_Depot_Potential_Lock"))
  end
  self._mapNode.sv:Init(self.nMaxLevel, self, self.RefreshSkillGrid)
  self._mapNode.sv:SetScrollGridPos(self.nLv - 1, 0.1)
end

function NoteSkillInfoCtrl:RefreshSkillGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local txtLevel = goGrid.transform:Find("AnimRoot/layout/txtLevel"):GetComponent("TMP_Text")
  local txtLevelDesc = goGrid.transform:Find("AnimRoot/layout/txtLevelDesc"):GetComponent("TMP_Text")
  local imgSelect = goGrid.transform:Find("AnimRoot/imgSelect").gameObject
  local sDesc = UTILS.ParseDesc(self.noteCfg, nil, nil, false, nIndex)
  imgSelect:SetActive(nIndex == self.nLv)
  if nIndex <= self.nLv then
    NovaAPI.SetTMPText(txtLevel, orderedFormat(ConfigTable.GetUIText("Note_Count"), nIndex))
    NovaAPI.SetTMPText(txtLevelDesc, sDesc)
  else
    sDesc = sDesc:gsub("<color[^>]+>", ""):gsub("</color>", "")
    NovaAPI.SetTMPText(txtLevel, sNotHaveColor .. orderedFormat(ConfigTable.GetUIText("Note_Count"), nIndex) .. "</color>")
    NovaAPI.SetTMPText(txtLevelDesc, sNotHaveColor .. sDesc .. "</color>")
  end
end

return NoteSkillInfoCtrl
