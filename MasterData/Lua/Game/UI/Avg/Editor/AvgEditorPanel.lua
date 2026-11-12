local AvgEditorPanel = class("AvgEditorPanel", BasePanel)
AvgEditorPanel._tbDefine = {
  {
    sPrefabPath = "Avg/Avg_0_Stage.prefab",
    sCtrlName = "Game.UI.Avg.Avg_0_Stage"
  },
  {
    sPrefabPath = "Avg/Avg_2_CHAR.prefab",
    sCtrlName = "Game.UI.Avg.Avg_2_CharCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_3_Transition.prefab",
    sCtrlName = "Game.UI.Avg.Avg_3_TransitionCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_4_Talk.prefab",
    sCtrlName = "Game.UI.Avg.Avg_4_TalkCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_6_Menu.prefab",
    sCtrlName = "Game.UI.Avg.Avg_6_MenuCtrl"
  },
  {
    sPrefabPath = "Avg/Avg_7_Choice.prefab",
    sCtrlName = "Game.UI.Avg.Avg_7_ChoiceCtrl"
  },
  {
    sPrefabPath = "Avg/Editor/AvgEditorUI.prefab",
    sCtrlName = "Game.UI.Avg.Editor.AvgEditorCtrl"
  },
  {
    sPrefabPath = "Avg/AvgEditorQuickPreview.prefab",
    sCtrlName = "Game.UI.Avg.AvgEditorQuickPreview"
  }
}

function AvgEditorPanel:Awake()
  self.nCurLanguageIdx = 1
end

function AvgEditorPanel:OnEnable()
  self.objAvgEditorCtrl = self:GetCtrlObj("AvgEditorCtrl")
end

function AvgEditorPanel:GetAvgCharName(sAvgCharId)
  return self.objAvgEditorCtrl:GetAvgCharName(sAvgCharId)
end

function AvgEditorPanel:PlayCharEmojiSound(sEmojiName)
  for i, v in ipairs(self.tbAvgPreset.CharEmoji) do
    if v[3] == sEmojiName then
      local sEmojiSound = v[4]
      if type(sEmojiSound) == "string" and sEmojiSound ~= "" then
        CS.WwiseAudioManager.Instance:PlaySound(sEmojiSound)
      end
      break
    end
  end
end

function AvgEditorPanel:PlayFxSound(sFxName, bPlay)
  for _, v in ipairs(self.tbAvgPreset.FxResName) do
    if v[1] == sFxName then
      local sFxSound = v[2]
      if type(sFxSound) == "string" and sFxSound ~= "" then
        if bPlay ~= true then
          sFxSound = sFxSound .. "_stop"
        end
        CS.WwiseAudioManager.Instance:PlaySound(sFxSound)
      end
      break
    end
  end
end

function AvgEditorPanel:GetBgCgFgResFullPath(sName)
  if sName == "BG_Black" then
    return "ImageAvg/AvgBg/BG_Black"
  elseif table.indexof(self.tbAvgPreset.BgResName, sName) > 0 then
    return "ImageAvg/AvgBg/" .. sName
  elseif 0 < table.indexof(self.tbAvgPreset.CgResName, sName) then
    return "ImageAvg/AvgCG/" .. sName
  elseif 0 < table.indexof(self.tbAvgPreset.FgResName, sName) then
    return "ImageAvg/AvgFg/" .. sName
  elseif 0 < table.indexof(self.tbAvgPreset.DiscResName, sName) then
    local sFolderName = string.gsub(sName, "_B", "")
    return "Disc/" .. sFolderName .. "/" .. sName
  else
    return nil
  end
end

function AvgEditorPanel:GetAvgCharReuseRes(sAvgCharId)
  return self.objAvgEditorCtrl:GetAvgCharReuseRes(sAvgCharId)
end

function AvgEditorPanel:GetCharEmojiIndex(sEmoji)
  if self.tbAvgPreset ~= nil then
    for i, v in ipairs(self.tbAvgPreset.CharEmoji) do
      if v[3] == sEmoji then
        return v[1]
      end
    end
  end
  return 0
end

function AvgEditorPanel:GetCtrlObj(sCtrlName)
  local objCtrl
  for i, v in ipairs(self._tbObjCtrl) do
    if v.__cname == sCtrlName then
      objCtrl = v
      break
    end
  end
  return objCtrl
end

return AvgEditorPanel
