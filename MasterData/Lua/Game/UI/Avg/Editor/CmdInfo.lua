local CmdInfo = {}
local PlayerBaseData = PlayerData.Base

local function SwitchMultiLanInput(tr)
  local tbMultiLanSurfix = {
    [AllEnum.Language.CN] = {"CnF", "CnM"},
    [AllEnum.Language.JP] = {"JpF", "JpM"}
  }
  local sVoLan = Settings.sCurrentVoLanguage
  local bIsMale = PlayerBaseData:GetPlayerSex() == true
  local tbSurfix = tbMultiLanSurfix[sVoLan]
  local sSurfix = bIsMale == true and tbSurfix[2] or tbSurfix[1]
  local trMultiLan = tr:Find("multiLan")
  local nChildCount = trMultiLan.childCount - 1
  for i = 0, nChildCount do
    local goLanInput = trMultiLan:GetChild(i).gameObject
    goLanInput:SetActive(goLanInput.name == sSurfix)
  end
end

function CmdInfo.VisualizedCmd_SetBg(ctrl, tr, param)
  if param == nil then
    return {
      0,
      ctrl.tbAllBgCg[1],
      ctrl.tbBgEftName[1],
      ctrl.listEaseType[0],
      1,
      true,
      "default",
      0
    }
  end
  ctrl:SetDDIndex(tr, "stage_bgfg/dd_Stage", param[1])
  ctrl:SetResName(tr, "input_BgResName", ctrl.tbAllBgCg, param[2])
  ctrl:SetResName(tr, "input_BgEftResName", ctrl.tbBgEftName, param[3])
  ctrl:SetDD(tr, "dd_EaseType", ctrl.listEaseType, ctrl.listEaseType:IndexOf(param[4]))
  ctrl:SetInputDuration(tr, "input_Duration", param[5])
  ctrl:SetTog(tr, "tog_Wait", param[6])
  ctrl:SetDD(tr, "dd_KeyName", ctrl.listKeyName, ctrl.listKeyName:IndexOf(param[7]))
  ctrl:SetDDIndex(tr, "stage_bgfg/dd_bg_fg", param[8] or 0)
end

function CmdInfo.TbDataToCfgStr_SetBg(ctrl, tbParam)
  return string.format("  {cmd=\"SetBg\",param={%s,\"%s\",\"%s\",\"%s\",%s,%s,\"%s\",%s}},", tostring(tbParam[1]), tbParam[2], tbParam[3], tbParam[4], tostring(tbParam[5]), tostring(tbParam[6]), tbParam[7], tostring(tbParam[8]))
end

function CmdInfo.ParseParam_SetBg(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "stage_bgfg/dd_Stage")
  tbParam[2] = ctrl:GetResName(tr, "input_BgResName")
  tbParam[3] = ctrl:GetResName(tr, "input_BgEftResName")
  tbParam[4] = ctrl:GetDD(tr, "dd_EaseType")
  tbParam[5] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[6] = ctrl:GetTog(tr, "tog_Wait")
  tbParam[7] = ctrl:GetDD(tr, "dd_KeyName")
  tbParam[8] = ctrl:GetDDIndex(tr, "stage_bgfg/dd_bg_fg")
end

function CmdInfo.VisualizedCmd_CtrlBg(ctrl, tr, param)
  if param == nil then
    return {
      0,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      ctrl.listBgShakeType[0],
      ctrl.listEaseType[0],
      1,
      true,
      0,
      nil
    }
  end
  ctrl:SetDDIndex(tr, "stage_bgfg/dd_Stage", param[1])
  ctrl:SetInputNum(tr, "pivot/input_PivotX", param[2])
  ctrl:SetInputNum(tr, "pivot/input_PivotY", param[3])
  ctrl:SetInputNum(tr, "pos/input_PosX", param[4])
  ctrl:SetInputNum(tr, "pos/input_PosY", param[5])
  ctrl:SetInputNum(tr, "scale_gray/input_Scale", param[6])
  ctrl:SetInputNum(tr, "scale_gray/input_Gray", param[7])
  ctrl:SetInputNum(tr, "alpha_brightness/input_Alpha", param[8])
  ctrl:SetInputNum(tr, "alpha_brightness/input_Brightness", param[9])
  ctrl:SetInputNum(tr, "blur_rotate/input_Blur", param[10])
  ctrl:SetDD(tr, "shake_ease/dd_ShakeType", ctrl.listBgShakeType, ctrl.listBgShakeType:IndexOf(param[11]))
  ctrl:SetDD(tr, "shake_ease/dd_EaseType", ctrl.listEaseType, ctrl.listEaseType:IndexOf(param[12]))
  ctrl:SetInputDuration(tr, "input_Duration", param[13])
  ctrl:SetTog(tr, "tog_Wait", param[14])
  ctrl:SetDDIndex(tr, "stage_bgfg/dd_bg_fg", param[15])
  ctrl:SetInputNum(tr, "blur_rotate/input_Rotate", param[16])
  ctrl:SetNoteAbsolutePos(tr, "txtNote", param[2], param[3], param[4], param[5])
end

function CmdInfo.TbDataToCfgStr_CtrlBg(ctrl, tbParam)
  if tbParam[16] == nil then
    local sCmd = "  {cmd=\"CtrlBg\",param={%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,\"%s\",\"%s\",%s,%s,%s}},"
    return string.format(sCmd, tostring(tbParam[1]), tostring(tbParam[2]), tostring(tbParam[3]), tostring(tbParam[4]), tostring(tbParam[5]), tostring(tbParam[6]), tostring(tbParam[7]), tostring(tbParam[8]), tostring(tbParam[9]), tostring(tbParam[10]), tbParam[11], tbParam[12], tostring(tbParam[13]), tostring(tbParam[14]), tostring(tbParam[15]))
  else
    local sCmd = "  {cmd=\"CtrlBg\",param={%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,\"%s\",\"%s\",%s,%s,%s,%s}},"
    return string.format(sCmd, tostring(tbParam[1]), tostring(tbParam[2]), tostring(tbParam[3]), tostring(tbParam[4]), tostring(tbParam[5]), tostring(tbParam[6]), tostring(tbParam[7]), tostring(tbParam[8]), tostring(tbParam[9]), tostring(tbParam[10]), tbParam[11], tbParam[12], tostring(tbParam[13]), tostring(tbParam[14]), tostring(tbParam[15]), tostring(tbParam[16]))
  end
end

function CmdInfo.ParseParam_CtrlBg(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "stage_bgfg/dd_Stage")
  tbParam[2] = ctrl:GetInputNum(tr, "pivot/input_PivotX")
  tbParam[3] = ctrl:GetInputNum(tr, "pivot/input_PivotY")
  tbParam[4] = ctrl:GetInputNum(tr, "pos/input_PosX")
  tbParam[5] = ctrl:GetInputNum(tr, "pos/input_PosY")
  tbParam[6] = ctrl:GetInputNum(tr, "scale_gray/input_Scale")
  tbParam[7] = ctrl:GetInputNum(tr, "scale_gray/input_Gray")
  tbParam[8] = ctrl:GetInputNum(tr, "alpha_brightness/input_Alpha")
  tbParam[9] = ctrl:GetInputNum(tr, "alpha_brightness/input_Brightness")
  tbParam[10] = ctrl:GetInputNum(tr, "blur_rotate/input_Blur")
  tbParam[11] = ctrl:GetDD(tr, "shake_ease/dd_ShakeType")
  tbParam[12] = ctrl:GetDD(tr, "shake_ease/dd_EaseType")
  tbParam[13] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[14] = ctrl:GetTog(tr, "tog_Wait")
  tbParam[15] = ctrl:GetDDIndex(tr, "stage_bgfg/dd_bg_fg")
  tbParam[16] = ctrl:GetInputNum(tr, "blur_rotate/input_Rotate")
  ctrl:SetNoteAbsolutePos(tr, "txtNote", tbParam[2], tbParam[3], tbParam[4], tbParam[5])
end

function CmdInfo.VisualizedCmd_SetStage(ctrl, tr, param)
  if param == nil then
    return {
      0,
      0,
      ctrl.listEaseType[0],
      1,
      true
    }
  end
  ctrl:SetDDIndex(tr, "dd_SplitType", param[1])
  ctrl:SetDDIndex(tr, "dd_InOut", param[2])
  ctrl:SetDD(tr, "dd_EaseType", ctrl.listEaseType, ctrl.listEaseType:IndexOf(param[3]))
  ctrl:SetInputDuration(tr, "input_Duration", param[4])
  ctrl:SetTog(tr, "tog_Wait", param[5])
end

function CmdInfo.TbDataToCfgStr_SetStage(ctrl, tbParam)
  return string.format("  {cmd=\"SetStage\",param={%s,%s,\"%s\",%s,%s}},", tostring(tbParam[1]), tostring(tbParam[2]), tbParam[3], tostring(tbParam[4]), tostring(tbParam[5]))
end

function CmdInfo.ParseParam_SetStage(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_SplitType")
  tbParam[2] = ctrl:GetDDIndex(tr, "dd_InOut")
  tbParam[3] = ctrl:GetDD(tr, "dd_EaseType")
  tbParam[4] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[5] = ctrl:GetTog(tr, "tog_Wait")
end

function CmdInfo.VisualizedCmd_CtrlStage(ctrl, tr, param)
  if param == nil then
    return {
      0,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      ctrl.listBgShakeType[0],
      ctrl.listEaseType[0],
      1,
      true
    }
  end
  ctrl:SetDDIndex(tr, "dd_Stage", param[1])
  ctrl:SetInputNum(tr, "pivot/input_PivotX", param[2])
  ctrl:SetInputNum(tr, "pivot/input_PivotY", param[3])
  ctrl:SetInputNum(tr, "pos/input_PosX", param[4])
  ctrl:SetInputNum(tr, "pos/input_PosY", param[5])
  ctrl:SetInputNum(tr, "scale_gray/input_Scale", param[6])
  ctrl:SetInputNum(tr, "scale_gray/input_Gray", param[7])
  ctrl:SetInputNum(tr, "brightness_blur/input_Brightness", param[8])
  ctrl:SetInputNum(tr, "brightness_blur/input_Blur", param[9])
  ctrl:SetDD(tr, "shake_ease/dd_ShakeType", ctrl.listBgShakeType, ctrl.listBgShakeType:IndexOf(param[10]))
  ctrl:SetDD(tr, "shake_ease/dd_EaseType", ctrl.listEaseType, ctrl.listEaseType:IndexOf(param[11]))
  ctrl:SetInputDuration(tr, "input_Duration", param[12])
  ctrl:SetTog(tr, "tog_Wait", param[13])
  ctrl:SetNoteAbsolutePos(tr, "txtNote", param[2], param[3], param[4], param[5])
end

function CmdInfo.TbDataToCfgStr_CtrlStage(ctrl, tbParam)
  local sCmd = "  {cmd=\"CtrlStage\",param={%s,%s,%s,%s,%s,%s,%s,%s,%s,\"%s\",\"%s\",%s,%s}},"
  return string.format(sCmd, tostring(tbParam[1]), tostring(tbParam[2]), tostring(tbParam[3]), tostring(tbParam[4]), tostring(tbParam[5]), tostring(tbParam[6]), tostring(tbParam[7]), tostring(tbParam[8]), tostring(tbParam[9]), tbParam[10], tbParam[11], tostring(tbParam[12]), tostring(tbParam[13]))
end

function CmdInfo.ParseParam_CtrlStage(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Stage")
  tbParam[2] = ctrl:GetInputNum(tr, "pivot/input_PivotX")
  tbParam[3] = ctrl:GetInputNum(tr, "pivot/input_PivotY")
  tbParam[4] = ctrl:GetInputNum(tr, "pos/input_PosX")
  tbParam[5] = ctrl:GetInputNum(tr, "pos/input_PosY")
  tbParam[6] = ctrl:GetInputNum(tr, "scale_gray/input_Scale")
  tbParam[7] = ctrl:GetInputNum(tr, "scale_gray/input_Gray")
  tbParam[8] = ctrl:GetInputNum(tr, "brightness_blur/input_Brightness")
  tbParam[9] = ctrl:GetInputNum(tr, "brightness_blur/input_Blur")
  tbParam[10] = ctrl:GetDD(tr, "shake_ease/dd_ShakeType")
  tbParam[11] = ctrl:GetDD(tr, "shake_ease/dd_EaseType")
  tbParam[12] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[13] = ctrl:GetTog(tr, "tog_Wait")
  ctrl:SetNoteAbsolutePos(tr, "txtNote", tbParam[2], tbParam[3], tbParam[4], tbParam[5])
end

function CmdInfo.VisualizedCmd_SetFx(ctrl, tr, param)
  if param == nil then
    return {
      0,
      ctrl.tbFxName[1],
      0,
      0,
      nil,
      nil,
      nil,
      0,
      false,
      false,
      0
    }
  end
  ctrl:SetDDIndex(tr, "dd_Stage", param[1])
  ctrl:SetResName(tr, "input_FxResName", ctrl.tbFxName, param[2])
  ctrl:SetDDIndex(tr, "create_back_or_front/dd_Create", param[3])
  ctrl:SetDDIndex(tr, "create_back_or_front/dd_BackOrFront", param[4])
  ctrl:SetInputNum(tr, "pos/input_PosX", param[5])
  ctrl:SetInputNum(tr, "pos/input_PosY", param[6])
  ctrl:SetInputNum(tr, "input_Scale", param[7])
  ctrl:SetInputDuration(tr, "input_Duration", param[8])
  ctrl:SetTog(tr, "tog_Wait", param[9])
  ctrl:SetNoteAbsolutePos(tr, "txtNote", 0.5, 0.5, (param[5] or 0) / 100, (param[6] or 0) / 100)
  ctrl:SetTog(tr, "tog_EnablePP", param[10] == false)
  ctrl:SetInputNum(tr, "input_Rotate", param[11] or 0)
end

function CmdInfo.TbDataToCfgStr_SetFx(ctrl, tbParam)
  if tbParam[11] == nil then
    local sCmd = "  {cmd=\"SetFx\",param={%s,\"%s\",%s,%s,%s,%s,%s,%s,%s,%s}},"
    return string.format(sCmd, tostring(tbParam[1]), tbParam[2], tostring(tbParam[3]), tostring(tbParam[4]), tostring(tbParam[5]), tostring(tbParam[6]), tostring(tbParam[7]), tostring(tbParam[8]), tostring(tbParam[9]), tostring(tbParam[10] == true))
  else
    local sCmd = "  {cmd=\"SetFx\",param={%s,\"%s\",%s,%s,%s,%s,%s,%s,%s,%s,%s}},"
    return string.format(sCmd, tostring(tbParam[1]), tbParam[2], tostring(tbParam[3]), tostring(tbParam[4]), tostring(tbParam[5]), tostring(tbParam[6]), tostring(tbParam[7]), tostring(tbParam[8]), tostring(tbParam[9]), tostring(tbParam[10] == true), tostring(tbParam[11]))
  end
end

function CmdInfo.ParseParam_SetFx(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Stage")
  tbParam[2] = ctrl:GetResName(tr, "input_FxResName")
  tbParam[3] = ctrl:GetDDIndex(tr, "create_back_or_front/dd_Create")
  tbParam[4] = ctrl:GetDDIndex(tr, "create_back_or_front/dd_BackOrFront")
  tbParam[5] = ctrl:GetInputNum(tr, "pos/input_PosX")
  tbParam[6] = ctrl:GetInputNum(tr, "pos/input_PosY")
  tbParam[7] = ctrl:GetInputNum(tr, "input_Scale")
  tbParam[8] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[9] = ctrl:GetTog(tr, "tog_Wait")
  tbParam[10] = ctrl:GetTog(tr, "tog_EnablePP") == false
  local nRotate = ctrl:GetInputNum(tr, "input_Rotate")
  if tbParam[11] == nil then
    if nRotate ~= 0 then
      tbParam[11] = nRotate
    end
  else
    tbParam[11] = nRotate
  end
  ctrl:SetNoteAbsolutePos(tr, "txtNote", 0.5, 0.5, (tbParam[5] or 0) / 100, (tbParam[6] or 0) / 100)
end

function CmdInfo.VisualizedCmd_SetFrontObj(ctrl, tr, param)
  if param == nil then
    return {
      0,
      0,
      "",
      nil,
      nil,
      1,
      true
    }
  end
  ctrl:SetDDIndex(tr, "create_mask/dd_Create", param[1])
  ctrl:SetDDIndex(tr, "create_mask/dd_Mask", param[2])
  local input = tr:Find("input_ResName"):GetComponent("InputField")
  NovaAPI.SetInputFieldText(input, param[3])
  ctrl:SetInputNum(tr, "pos/input_PosX", param[4])
  ctrl:SetInputNum(tr, "pos/input_PosY", param[5])
  ctrl:SetInputDuration(tr, "input_Duration", param[6])
  ctrl:SetTog(tr, "tog_Wait", param[7])
  ctrl:SetNotePercentPos(tr, "txtNote", param[4], param[5])
end

function CmdInfo.TbDataToCfgStr_SetFrontObj(ctrl, tbParam)
  return string.format("  {cmd=\"SetFrontObj\",param={%s,%s,\"%s\",%s,%s,%s,%s}},", tostring(tbParam[1]), tostring(tbParam[2]), tbParam[3], tostring(tbParam[4]), tostring(tbParam[5]), tostring(tbParam[6]), tostring(tbParam[7]))
end

function CmdInfo.ParseParam_SetFrontObj(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "create_mask/dd_Create")
  tbParam[2] = ctrl:GetDDIndex(tr, "create_mask/dd_Mask")
  tbParam[3] = NovaAPI.GetInputFieldText(tr:Find("input_ResName"):GetComponent("InputField"))
  tbParam[4] = ctrl:GetInputNum(tr, "pos/input_PosX")
  tbParam[5] = ctrl:GetInputNum(tr, "pos/input_PosY")
  tbParam[6] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[7] = ctrl:GetTog(tr, "tog_Wait")
  ctrl:SetNotePercentPos(tr, "txtNote", tbParam[4], tbParam[5])
end

function CmdInfo.VisualizedCmd_SetFilm(ctrl, tr, param)
  if param == nil then
    return {
      0,
      ctrl.listEaseType[0],
      1,
      true
    }
  end
  ctrl:SetDDIndex(tr, "dd_InOut", param[1])
  ctrl:SetDD(tr, "dd_EaseType", ctrl.listEaseType, ctrl.listEaseType:IndexOf(param[2]))
  ctrl:SetInputDuration(tr, "input_Duration", param[3])
  ctrl:SetTog(tr, "tog_Wait", param[4])
end

function CmdInfo.TbDataToCfgStr_SetFilm(ctrl, tbParam)
  return string.format("  {cmd=\"SetFilm\",param={%s,\"%s\",%s,%s}},", tostring(tbParam[1]), tbParam[2], tostring(tbParam[3]), tostring(tbParam[4]))
end

function CmdInfo.ParseParam_SetFilm(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_InOut")
  tbParam[2] = ctrl:GetDD(tr, "dd_EaseType")
  tbParam[3] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[4] = ctrl:GetTog(tr, "tog_Wait")
end

function CmdInfo.VisualizedCmd_SetTrans(ctrl, tr, param)
  if param == nil then
    return {
      0,
      0,
      ctrl.tbBgEftName[1],
      ctrl.listEaseType[0],
      false,
      false,
      1,
      true,
      "default"
    }
  end
  ctrl:SetDDIndex(tr, "dd_OpenClose", param[1])
  ctrl:SetDDIndex(tr, "dd_Style", param[2])
  ctrl:SetResName(tr, "input_EftResName", ctrl.tbBgEftName, param[3])
  ctrl:SetDD(tr, "dd_EaseType", ctrl.listEaseType, ctrl.listEaseType:IndexOf(param[4]))
  ctrl:SetTog(tr, "tog_ClearAllChar", param[5])
  ctrl:SetTog(tr, "tog_ClearAllTalk", param[6])
  ctrl:SetInputDuration(tr, "input_Duration", param[7])
  ctrl:SetTog(tr, "tog_Wait", param[8])
  ctrl:SetDD(tr, "dd_KeyName", ctrl.listKeyName, ctrl.listKeyName:IndexOf(param[9]))
  tr:Find("input_EftResName").gameObject:SetActive(1 >= param[2])
  tr:Find("dd_EaseType").gameObject:SetActive(1 >= param[2])
end

function CmdInfo.TbDataToCfgStr_SetTrans(ctrl, tbParam)
  return string.format("  {cmd=\"SetTrans\",param={%s,%s,\"%s\",\"%s\",%s,%s,%s,%s,\"%s\"}},", tostring(tbParam[1]), tostring(tbParam[2]), tbParam[3], tbParam[4], tostring(tbParam[5]), tostring(tbParam[6]), tostring(tbParam[7]), tostring(tbParam[8]), tbParam[9])
end

function CmdInfo.ParseParam_SetTrans(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_OpenClose")
  tbParam[2] = ctrl:GetDDIndex(tr, "dd_Style")
  tbParam[3] = ctrl:GetResName(tr, "input_EftResName")
  tbParam[4] = ctrl:GetDD(tr, "dd_EaseType")
  tbParam[5] = ctrl:GetTog(tr, "tog_ClearAllChar")
  tbParam[6] = ctrl:GetTog(tr, "tog_ClearAllTalk")
  tbParam[7] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[8] = ctrl:GetTog(tr, "tog_Wait")
  tbParam[9] = ctrl:GetDD(tr, "dd_KeyName")
  tr:Find("input_EftResName").gameObject:SetActive(1 >= tbParam[2])
  tr:Find("dd_EaseType").gameObject:SetActive(1 >= tbParam[2])
end

function CmdInfo.VisualizedCmd_SetWordTrans(ctrl, tr, param)
  if param == nil then
    return {
      "",
      0,
      true
    }
  end
  ctrl:SetInputTalkContent(tr, "input_WordTrans", param[1])
  ctrl:SetInputDuration(tr, "input_Duration", param[2])
  ctrl:SetTog(tr, "tog_Wait", param[3])
end

function CmdInfo.TbDataToCfgStr_SetWordTrans(ctrl, tbParam)
  local txt = Avg_ProcEnquotes(tbParam[1] or "")
  return string.format("  {cmd=\"SetWordTrans\",param={\"%s\",%s,%s}},", txt, tostring(tbParam[2]), tostring(tbParam[3]))
end

function CmdInfo.ParseParam_SetWordTrans(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetInputTalkContent(tr, "input_WordTrans")
  tbParam[2] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[3] = ctrl:GetTog(tr, "tog_Wait")
end

function CmdInfo.VisualizedCmd_SetHeartBeat(ctrl, tr, param)
  if param == nil then
    return {
      0,
      nil,
      nil,
      0.75
    }
  end
  ctrl:SetDDIndex(tr, "dd_Stage", param[1])
  ctrl:SetInputNum(tr, "pivot/input_PivotX", param[2])
  ctrl:SetInputNum(tr, "pivot/input_PivotY", param[3])
  ctrl:SetInputDuration(tr, "input_Duration", param[4])
end

function CmdInfo.TbDataToCfgStr_SetHeartBeat(ctrl, tbParam)
  return string.format("  {cmd=\"SetHeartBeat\",param={%s,%s,%s,%s}},", tostring(tbParam[1]), tostring(tbParam[2]), tostring(tbParam[3]), tostring(tbParam[4]))
end

function CmdInfo.ParseParam_SetHeartBeat(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Stage")
  tbParam[2] = ctrl:GetInputNum(tr, "pivot/input_PivotX")
  tbParam[3] = ctrl:GetInputNum(tr, "pivot/input_PivotY")
  tbParam[4] = ctrl:GetInputDuration(tr, "input_Duration")
end

function CmdInfo.VisualizedCmd_SetPP(ctrl, tr, param)
  if param == nil then
    return {0, 0}
  end
  ctrl:SetDDIndex(tr, "dd_Stage", param[1])
  ctrl:SetDDIndex(tr, "dd_Enable", param[2])
end

function CmdInfo.TbDataToCfgStr_SetPP(ctrl, tbParam)
  return string.format("  {cmd=\"SetPP\",param={%s,%s}},", tostring(tbParam[1]), tostring(tbParam[2]))
end

function CmdInfo.ParseParam_SetPP(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Stage")
  tbParam[2] = ctrl:GetDDIndex(tr, "dd_Enable")
end

function CmdInfo.VisualizedCmd_SetPPGlobal(ctrl, tr, param)
  if param == nil then
    return {0}
  end
  ctrl:SetDDIndex(tr, "dd_Enable", param[1])
end

function CmdInfo.TbDataToCfgStr_SetPPGlobal(ctrl, tbParam)
  return string.format("  {cmd=\"SetPPGlobal\",param={%s}},", tostring(tbParam[1]))
end

function CmdInfo.ParseParam_SetPPGlobal(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Enable")
end

function CmdInfo.VisualizedCmd_SetChar(ctrl, tr, param)
  if param == nil then
    return {
      0,
      0,
      "none",
      ctrl.tbAvgCharId[3],
      "a",
      "002",
      "none",
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      1,
      true,
      nil
    }
  end
  ctrl:SetDDIndex(tr, "dd_Type", param[1])
  ctrl:SetDDIndex(tr, "stage_preset/dd_Stage", param[2])
  local list = param[1] == 0 and ctrl.listCharPresetDataEnter or ctrl.listCharPresetDataExit
  ctrl:SetDD(tr, "stage_preset/dd_PresetDataKey", list, list:IndexOf(param[3]))
  ctrl:SetAvgCharId(tr, param[4])
  tr:Find("body_face").gameObject:SetActive(param[1] == 0)
  ctrl:SetDD(tr, "body_face/dd_Body", ctrl.listBody, ctrl.listBody:IndexOf(param[5]))
  ctrl:SetInputFace(tr, "body_face/input_Face", param[6])
  tr:Find("emoji_sort").gameObject:SetActive(param[1] == 0)
  ctrl:SetDD(tr, "emoji_sort/dd_Emoji", ctrl.listEmoji, ctrl:GetCharEmojiIndex(param[7]) - 1)
  ctrl:SetInputNum(tr, "emoji_sort/input_Sort", param[8])
  tr:Find("custom_data").gameObject:SetActive(list:IndexOf(param[3]) == 0)
  ctrl:SetInputNum(tr, "custom_data/input_PosX", param[9])
  ctrl:SetInputNum(tr, "custom_data/input_PosY", param[10])
  ctrl:SetInputNum(tr, "custom_data/input_Scale", param[11])
  ctrl:SetInputNum(tr, "custom_data/input_Gray", param[12])
  ctrl:SetInputNum(tr, "custom_data/input_Bright", param[13])
  ctrl:SetInputNum(tr, "custom_data/input_Alpha", param[14])
  ctrl:SetInputDuration(tr, "input_Duration", param[15])
  ctrl:SetTog(tr, "tog_Wait", param[16])
  ctrl:SetInputNum(tr, "custom_data/input_Blur", param[17])
  ctrl:SetNotePercentPos(tr, "txtNote", param[9], param[10])
end

function CmdInfo.TbDataToCfgStr_SetChar(ctrl, tbParam)
  local sCmd = "  {cmd=\"SetChar\",param={%s,%s,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",%s,%s,%s,%s,%s,%s,%s,%s,%s,%s}},"
  return string.format(sCmd, tostring(tbParam[1]), tostring(tbParam[2]), tbParam[3], tbParam[4], tbParam[5], tbParam[6], tbParam[7], tostring(tbParam[8]), tostring(tbParam[9]), tostring(tbParam[10]), tostring(tbParam[11]), tostring(tbParam[12]), tostring(tbParam[13]), tostring(tbParam[14]), tostring(tbParam[15]), tostring(tbParam[16]), tostring(tbParam[17]))
end

function CmdInfo.ParseParam_SetChar(ctrl, tr, tbParam)
  local nLastType = tbParam[1]
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Type")
  tbParam[2] = ctrl:GetDDIndex(tr, "stage_preset/dd_Stage")
  tbParam[3] = ctrl:GetDD(tr, "stage_preset/dd_PresetDataKey")
  tbParam[4] = ctrl:GetAvgCharId(tr)
  tbParam[5] = ctrl:GetDD(tr, "body_face/dd_Body")
  tbParam[6] = ctrl:GetInputFace(tr, "body_face/input_Face")
  tbParam[7] = ctrl:GetCharEmojiResName(NovaAPI.GetDropDownValue(tr:Find("emoji_sort/dd_Emoji"):GetComponent("Dropdown")) + 1)
  tbParam[8] = ctrl:GetInputNum(tr, "emoji_sort/input_Sort", true)
  tbParam[9] = ctrl:GetInputNum(tr, "custom_data/input_PosX")
  tbParam[10] = ctrl:GetInputNum(tr, "custom_data/input_PosY")
  tbParam[11] = ctrl:GetInputNum(tr, "custom_data/input_Scale")
  tbParam[12] = ctrl:GetInputNum(tr, "custom_data/input_Gray")
  tbParam[13] = ctrl:GetInputNum(tr, "custom_data/input_Bright")
  tbParam[14] = ctrl:GetInputNum(tr, "custom_data/input_Alpha")
  tbParam[15] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[16] = ctrl:GetTog(tr, "tog_Wait")
  tbParam[17] = ctrl:GetInputNum(tr, "custom_data/input_Blur")
  local list = tbParam[1] == 0 and ctrl.listCharPresetDataEnter or ctrl.listCharPresetDataExit
  if nLastType ~= tbParam[1] then
    ctrl:SetDD(tr, "stage_preset/dd_PresetDataKey", list, 0)
  end
  tr:Find("custom_data").gameObject:SetActive(list:IndexOf(tbParam[3]) == 0)
  tr:Find("body_face").gameObject:SetActive(tbParam[1] == 0)
  tr:Find("emoji_sort").gameObject:SetActive(tbParam[1] == 0)
  ctrl:SetNotePercentPos(tr, "txtNote", tbParam[9], tbParam[10])
end

function CmdInfo.VisualizedCmd_CtrlChar(ctrl, tr, param)
  if param == nil then
    return {
      ctrl.tbAvgCharId[3],
      "a",
      nil,
      "none",
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      "none",
      "none",
      ctrl.listEaseType[0],
      0,
      nil,
      false,
      1,
      true,
      nil
    }
  end
  ctrl:SetAvgCharId(tr, param[1])
  ctrl:SetDD(tr, "body_face/dd_Body", ctrl.listBody, ctrl.listBody:IndexOf(param[2]))
  ctrl:SetInputFace(tr, "body_face/input_Face", param[3])
  ctrl:SetDD(tr, "emoji_sort/dd_Emoji", ctrl.listEmoji, ctrl:GetCharEmojiIndex(param[4]) - 1)
  ctrl:SetInputNum(tr, "emoji_sort/input_Sort", param[5])
  ctrl:SetInputNum(tr, "custom_data/input_PosX", param[6])
  ctrl:SetInputNum(tr, "custom_data/input_PosY", param[7])
  ctrl:SetInputNum(tr, "custom_data/input_Scale", param[8])
  ctrl:SetInputNum(tr, "custom_data/input_Gray", param[9])
  ctrl:SetInputNum(tr, "custom_data/input_Bright", param[10])
  ctrl:SetInputNum(tr, "custom_data/input_Alpha", param[11])
  ctrl:SetDD(tr, "shake_ghost/dd_ShakeType", ctrl.listCharShakeType, ctrl.listCharShakeType:IndexOf(param[12]))
  ctrl:SetDD(tr, "shake_ghost/dd_EftName", ctrl.listCharFadeInOut, ctrl:GetCharFadeEftIndex(param[13]) - 1)
  ctrl:SetDD(tr, "ease_rotate/dd_EaseType", ctrl.listEaseType, ctrl.listEaseType:IndexOf(param[14]))
  ctrl:SetDDIndex(tr, "ease_rotate/dd_rotate", param[15])
  ctrl:SetInputNum(tr, "ease_rotate/input_rotate", param[16])
  ctrl:SetTog(tr, "exit_wait/tog_Exit", param[17])
  ctrl:SetInputDuration(tr, "exit_wait/input_Duration", param[18])
  ctrl:SetTog(tr, "exit_wait/tog_Wait", param[19])
  ctrl:SetInputNum(tr, "custom_data/input_Blur", param[20])
  ctrl:SetNotePercentPos(tr, "txtNote", param[6], param[7])
end

function CmdInfo.TbDataToCfgStr_CtrlChar(ctrl, tbParam)
  local sCmd = "  {cmd=\"CtrlChar\",param={\"%s\",\"%s\",\"%s\",\"%s\",%s,%s,%s,%s,%s,%s,%s,\"%s\",\"%s\",\"%s\",%s,%s,%s,%s,%s,%s}},"
  return string.format(sCmd, tbParam[1], tbParam[2], tbParam[3], tbParam[4], tostring(tbParam[5]), tostring(tbParam[6]), tostring(tbParam[7]), tostring(tbParam[8]), tostring(tbParam[9]), tostring(tbParam[10]), tostring(tbParam[11]), tbParam[12], tbParam[13], tbParam[14], tostring(tbParam[15]), tostring(tbParam[16]), tostring(tbParam[17]), tostring(tbParam[18]), tostring(tbParam[19]), tostring(tbParam[20]))
end

function CmdInfo.ParseParam_CtrlChar(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetAvgCharId(tr)
  tbParam[2] = ctrl:GetDD(tr, "body_face/dd_Body")
  tbParam[3] = ctrl:GetInputFace(tr, "body_face/input_Face")
  tbParam[4] = ctrl:GetCharEmojiResName(NovaAPI.GetDropDownValue(tr:Find("emoji_sort/dd_Emoji"):GetComponent("Dropdown")) + 1)
  tbParam[5] = ctrl:GetInputNum(tr, "emoji_sort/input_Sort", true)
  tbParam[6] = ctrl:GetInputNum(tr, "custom_data/input_PosX")
  tbParam[7] = ctrl:GetInputNum(tr, "custom_data/input_PosY")
  tbParam[8] = ctrl:GetInputNum(tr, "custom_data/input_Scale")
  tbParam[9] = ctrl:GetInputNum(tr, "custom_data/input_Gray")
  tbParam[10] = ctrl:GetInputNum(tr, "custom_data/input_Bright")
  tbParam[11] = ctrl:GetInputNum(tr, "custom_data/input_Alpha")
  tbParam[12] = ctrl:GetDD(tr, "shake_ghost/dd_ShakeType")
  tbParam[13] = ctrl:GetCharFadeEftResName(NovaAPI.GetDropDownValue(tr:Find("shake_ghost/dd_EftName"):GetComponent("Dropdown")) + 1)
  tbParam[14] = ctrl:GetDD(tr, "ease_rotate/dd_EaseType")
  tbParam[15] = ctrl:GetDDIndex(tr, "ease_rotate/dd_rotate")
  tbParam[16] = ctrl:GetInputNum(tr, "ease_rotate/input_rotate")
  tbParam[17] = ctrl:GetTog(tr, "exit_wait/tog_Exit")
  tbParam[18] = ctrl:GetInputDuration(tr, "exit_wait/input_Duration")
  tbParam[19] = ctrl:GetTog(tr, "exit_wait/tog_Wait")
  tbParam[20] = ctrl:GetInputNum(tr, "custom_data/input_Blur")
  ctrl:SetNotePercentPos(tr, "txtNote", tbParam[6], tbParam[7])
end

function CmdInfo.VisualizedCmd_PlayCharAnim(ctrl, tr, param)
  if param == nil then
    return {
      ctrl.tbAvgCharId[3],
      "none",
      false,
      1,
      true
    }
  end
  ctrl:SetAvgCharId(tr, param[1])
  NovaAPI.SetInputFieldText(tr:Find("input_AnimName"):GetComponent("InputField"), param[2])
  ctrl:SetTog(tr, "tog_Exit", param[3])
  ctrl:SetInputDuration(tr, "input_Duration", param[4])
  ctrl:SetTog(tr, "tog_Wait", param[5])
end

function CmdInfo.TbDataToCfgStr_PlayCharAnim(ctrl, tbParam)
  return string.format("  {cmd=\"PlayCharAnim\",param={\"%s\",\"%s\",%s,%s,%s}},", tbParam[1], tbParam[2], tostring(tbParam[3]), tostring(tbParam[4]), tostring(tbParam[5]))
end

function CmdInfo.ParseParam_PlayCharAnim(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetAvgCharId(tr)
  tbParam[2] = NovaAPI.GetInputFieldText(tr:Find("input_AnimName"):GetComponent("InputField"))
  tbParam[3] = ctrl:GetTog(tr, "tog_Exit")
  tbParam[4] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[5] = ctrl:GetTog(tr, "tog_Wait")
end

function CmdInfo.VisualizedCmd_SetCharHead(ctrl, tr, param)
  if param == nil then
    return {
      0,
      0,
      nil,
      nil,
      nil,
      ctrl.tbAvgCharId[3],
      "a",
      "002",
      "none",
      0,
      nil,
      nil,
      nil,
      nil,
      nil,
      nil,
      0,
      true,
      nil
    }
  end
  ctrl:SetDDIndex(tr, "dd_Type", param[1])
  ctrl:SetDDIndex(tr, "stage_preset/dd_StagePos", param[2])
  ctrl:SetInputNum(tr, "stage_preset/input_FramePosX", param[3])
  ctrl:SetInputNum(tr, "stage_preset/input_FramePosY", param[4])
  ctrl:SetInputNum(tr, "stage_preset/input_FrameScale", param[5])
  ctrl:SetAvgCharId(tr, param[6])
  tr:Find("body_face").gameObject:SetActive(param[1] == 0)
  ctrl:SetDD(tr, "body_face/dd_Body", ctrl.listBody, ctrl.listBody:IndexOf(param[7]))
  ctrl:SetInputFace(tr, "body_face/input_Face", param[8])
  tr:Find("emoji_sort").gameObject:SetActive(param[1] == 0)
  ctrl:SetDD(tr, "emoji_sort/dd_Emoji", ctrl.listEmoji, ctrl:GetCharEmojiIndex(param[9]) - 1)
  ctrl:SetDDIndex(tr, "emoji_sort/dd_FrameBg", param[10])
  ctrl:SetInputNum(tr, "custom_data/input_PosX", param[11])
  ctrl:SetInputNum(tr, "custom_data/input_PosY", param[12])
  ctrl:SetInputNum(tr, "custom_data/input_Scale", param[13])
  ctrl:SetInputNum(tr, "custom_data/input_Gray", param[14])
  ctrl:SetInputNum(tr, "custom_data/input_Bright", param[15])
  ctrl:SetInputNum(tr, "custom_data/input_Alpha", param[16])
  ctrl:SetInputDuration(tr, "input_Duration", param[17])
  ctrl:SetTog(tr, "tog_Wait", param[18])
  ctrl:SetInputNum(tr, "custom_data/input_Blur", param[19])
  ctrl:SetNotePercentPos(tr, "txtNote", param[3], param[4])
end

function CmdInfo.TbDataToCfgStr_SetCharHead(ctrl, tbParam)
  local sCmd = "  {cmd=\"SetCharHead\",param={%s,%s,%s,%s,%s,\"%s\",\"%s\",\"%s\",\"%s\",%s,%s,%s,%s,%s,%s,%s,%s,%s,%s}},"
  return string.format(sCmd, tostring(tbParam[1]), tostring(tbParam[2]), tostring(tbParam[3]), tostring(tbParam[4]), tostring(tbParam[5]), tbParam[6], tbParam[7], tbParam[8], tbParam[9], tostring(tbParam[10]), tostring(tbParam[11]), tostring(tbParam[12]), tostring(tbParam[13]), tostring(tbParam[14]), tostring(tbParam[15]), tostring(tbParam[16]), tostring(tbParam[17]), tostring(tbParam[18]), tostring(tbParam[19]))
end

function CmdInfo.ParseParam_SetCharHead(ctrl, tr, tbParam)
  local nLastType = tbParam[1]
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Type")
  tbParam[2] = ctrl:GetDDIndex(tr, "stage_preset/dd_StagePos")
  tbParam[3] = ctrl:GetInputNum(tr, "stage_preset/input_FramePosX")
  tbParam[4] = ctrl:GetInputNum(tr, "stage_preset/input_FramePosY")
  tbParam[5] = ctrl:GetInputNum(tr, "stage_preset/input_FrameScale")
  tbParam[6] = ctrl:GetAvgCharId(tr)
  tbParam[7] = ctrl:GetDD(tr, "body_face/dd_Body")
  tbParam[8] = ctrl:GetInputFace(tr, "body_face/input_Face")
  tbParam[9] = ctrl:GetCharEmojiResName(NovaAPI.GetDropDownValue(tr:Find("emoji_sort/dd_Emoji"):GetComponent("Dropdown")) + 1)
  tbParam[10] = ctrl:GetDDIndex(tr, "emoji_sort/dd_FrameBg")
  tbParam[11] = ctrl:GetInputNum(tr, "custom_data/input_PosX")
  tbParam[12] = ctrl:GetInputNum(tr, "custom_data/input_PosY")
  tbParam[13] = ctrl:GetInputNum(tr, "custom_data/input_Scale")
  tbParam[14] = ctrl:GetInputNum(tr, "custom_data/input_Gray")
  tbParam[15] = ctrl:GetInputNum(tr, "custom_data/input_Bright")
  tbParam[16] = ctrl:GetInputNum(tr, "custom_data/input_Alpha")
  tbParam[17] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[18] = ctrl:GetTog(tr, "tog_Wait")
  tbParam[19] = ctrl:GetInputNum(tr, "custom_data/input_Blur")
  tr:Find("body_face").gameObject:SetActive(tbParam[1] == 0)
  tr:Find("emoji_sort").gameObject:SetActive(tbParam[1] == 0)
  ctrl:SetNotePercentPos(tr, "txtNote", tbParam[3], tbParam[4])
end

function CmdInfo.VisualizedCmd_CtrlCharHead(ctrl, tr, param)
  if param == nil then
    return {
      nil,
      nil,
      nil,
      ctrl.tbAvgCharId[3],
      0,
      0,
      true
    }
  end
  ctrl:SetInputNum(tr, "input_FramePosX", param[1])
  ctrl:SetInputNum(tr, "input_FramePosY", param[2])
  ctrl:SetInputNum(tr, "input_FrameScale", param[3])
  ctrl:SetAvgCharId(tr, param[4])
  ctrl:SetDDIndex(tr, "dd_FrameBg", param[5])
  ctrl:SetInputDuration(tr, "input_Duration", param[6])
  ctrl:SetTog(tr, "tog_Wait", param[7])
end

function CmdInfo.TbDataToCfgStr_CtrlCharHead(ctrl, tbParam)
  return string.format("  {cmd=\"CtrlCharHead\",param={%s,%s,%s,\"%s\",%s,%s,%s}},", tostring(tbParam[1]), tostring(tbParam[2]), tostring(tbParam[3]), tbParam[4], tostring(tbParam[5]), tostring(tbParam[6]), tostring(tbParam[7]))
end

function CmdInfo.ParseParam_CtrlCharHead(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetInputNum(tr, "input_FramePosX")
  tbParam[2] = ctrl:GetInputNum(tr, "input_FramePosY")
  tbParam[3] = ctrl:GetInputNum(tr, "input_FrameScale")
  tbParam[4] = ctrl:GetAvgCharId(tr)
  tbParam[5] = ctrl:GetDDIndex(tr, "dd_FrameBg")
  tbParam[6] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[7] = ctrl:GetTog(tr, "tog_Wait")
end

function CmdInfo.VisualizedCmd_SetL2D(ctrl, tr, param)
  if param == nil then
    return {
      0,
      ctrl.tbAvgCharId[3],
      "a",
      0,
      true
    }
  end
  ctrl:SetDDIndex(tr, "dd_Type", param[1])
  ctrl:SetAvgCharId(tr, param[2])
  ctrl:SetDD(tr, "dd_pose", ctrl.listBody, ctrl.listBody:IndexOf(param[3]))
  ctrl:SetInputDuration(tr, "input_Duration", param[4])
  ctrl:SetTog(tr, "tog_Wait", param[5])
end

function CmdInfo.TbDataToCfgStr_SetL2D(ctrl, tbParam)
  return string.format("  {cmd=\"SetL2D\",param={%s,\"%s\",\"%s\",%s,%s}},", tostring(tbParam[1]), tbParam[2], tbParam[3], tostring(tbParam[4]), tostring(tbParam[5]))
end

function CmdInfo.ParseParam_SetL2D(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Type")
  tbParam[2] = ctrl:GetAvgCharId(tr)
  tbParam[3] = ctrl:GetDD(tr, "dd_pose")
  tbParam[4] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[5] = ctrl:GetTog(tr, "tog_Wait")
end

function CmdInfo.VisualizedCmd_CtrlL2D(ctrl, tr, param)
  if param == nil then
    return {
      ctrl.tbAvgCharId[3],
      "a",
      "",
      "",
      0,
      false
    }
  end
  ctrl:SetAvgCharId(tr, param[1])
  ctrl:SetDD(tr, "dd_pose", ctrl.listBody, ctrl.listBody:IndexOf(param[2]))
  NovaAPI.SetInputFieldText(tr:Find("input_AnimName"):GetComponent("InputField"), param[3])
  NovaAPI.SetInputFieldText(tr:Find("input_CharVoiceName"):GetComponent("InputField"), param[4])
  ctrl:SetInputDuration(tr, "input_Duration", param[5])
  ctrl:SetTog(tr, "tog_Wait", param[6])
end

function CmdInfo.TbDataToCfgStr_CtrlL2D(ctrl, tbParam)
  return string.format("  {cmd=\"CtrlL2D\",param={\"%s\",\"%s\",\"%s\",\"%s\",%s,%s}},", tostring(tbParam[1]), tbParam[2], tbParam[3], tbParam[4], tostring(tbParam[5]), tostring(tbParam[6]))
end

function CmdInfo.ParseParam_CtrlL2D(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetAvgCharId(tr)
  tbParam[2] = ctrl:GetDD(tr, "dd_pose")
  tbParam[3] = NovaAPI.GetInputFieldText(tr:Find("input_AnimName"):GetComponent("InputField"))
  tbParam[4] = NovaAPI.GetInputFieldText(tr:Find("input_CharVoiceName"):GetComponent("InputField"))
  tbParam[5] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[6] = ctrl:GetTog(tr, "tog_Wait")
end

function CmdInfo.VisualizedCmd_SetCharL2D(ctrl, tr, param)
  if param == nil then
    return {
      ctrl.tbAvgCharId[3],
      0,
      "none",
      "",
      0
    }
  end
  ctrl:SetAvgCharId(tr, param[1])
  ctrl:SetDDIndex(tr, "dd_Type", param[2])
  ctrl:SetDD(tr, "dd_Emoji", ctrl.listEmoji, ctrl:GetCharEmojiIndex(param[3]) - 1)
  NovaAPI.SetInputFieldText(tr:Find("input_L2DAnim"):GetComponent("InputField"), param[4])
  ctrl:SetInputDuration(tr, "input_Duration", param[5])
end

function CmdInfo.TbDataToCfgStr_SetCharL2D(ctrl, tbParam)
  return string.format("  {cmd=\"SetCharL2D\",param={\"%s\",%d,\"%s\",\"%s\",%s}},", tbParam[1], tbParam[2], tbParam[3], tbParam[4], tostring(tbParam[5]))
end

function CmdInfo.ParseParam_SetCharL2D(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetAvgCharId(tr)
  tbParam[2] = ctrl:GetDDIndex(tr, "dd_Type")
  tbParam[3] = ctrl:GetCharEmojiResName(NovaAPI.GetDropDownValue(tr:Find("dd_Emoji"):GetComponent("Dropdown")) + 1)
  tbParam[4] = NovaAPI.GetInputFieldText(tr:Find("input_L2DAnim"):GetComponent("InputField"))
  tbParam[5] = ctrl:GetInputDuration(tr, "input_Duration")
end

function CmdInfo.VisualizedCmd_PlayGradient2Anim(ctrl, tr, param)
  if param == nil then
    return {
      ctrl.tbAvgCharId[3],
      0,
      0,
      0,
      false
    }
  end
  ctrl:SetAvgCharId(tr, param[1])
  NovaAPI.SetInputFieldText(tr:Find("input_Start"):GetComponent("InputField"), param[2])
  NovaAPI.SetInputFieldText(tr:Find("input_End"):GetComponent("InputField"), param[3])
  ctrl:SetInputDuration(tr, "input_Duration", param[4])
  ctrl:SetTog(tr, "tog_Wait", param[5])
end

function CmdInfo.TbDataToCfgStr_PlayGradient2Anim(ctrl, tbParam)
  return string.format("  {cmd=\"PlayGradient2Anim\",param={\"%s\",%s,%s,%s,%s}},", tbParam[1], tostring(tbParam[2]), tostring(tbParam[3]), tostring(tbParam[4]), tostring(tbParam[5]))
end

function CmdInfo.ParseParam_PlayGradient2Anim(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetAvgCharId(tr)
  tbParam[2] = NovaAPI.GetInputFieldText(tr:Find("input_Start"):GetComponent("InputField"))
  tbParam[3] = NovaAPI.GetInputFieldText(tr:Find("input_End"):GetComponent("InputField"))
  tbParam[4] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[5] = ctrl:GetTog(tr, "tog_Wait")
end

function CmdInfo.VisualizedCmd_SetTalk(ctrl, tr, param)
  if param == nil then
    return {
      0,
      "avg3_100",
      "",
      1,
      "",
      false,
      "",
      "",
      ""
    }
  end
  ctrl:SetDDIndex(tr, "dd_Type", param[1])
  ctrl:SetAvgCharId(tr, param[2])
  if param[7] == nil then
    param[7] = ""
  end
  if param[8] == nil then
    param[8] = ""
  end
  if param[9] == nil then
    param[9] = ""
  end
  ctrl:SetInputTalkContent(tr, "multiLan/CnF", param[3])
  ctrl:SetInputTalkContent(tr, "multiLan/CnM", param[7])
  ctrl:SetInputTalkContent(tr, "multiLan/JpF", param[8])
  ctrl:SetInputTalkContent(tr, "multiLan/JpM", param[9])
  ctrl:SetDDIndex(tr, "dd_ClearType", param[4])
  ctrl:SetAvgTalkVoice(tr, param[5], param[6])
  tr:Find("input_AvgCharId").gameObject:SetActive(param[1] ~= 8 and param[1] ~= 10)
  SwitchMultiLanInput(tr)
end

function CmdInfo.TbDataToCfgStr_SetTalk(ctrl, tbParam)
  local avgcharid = Avg_ProcEnquotes(tbParam[2])
  local txt3 = Avg_ProcEnquotes(tbParam[3] or "")
  local txt7 = Avg_ProcEnquotes(tbParam[7] or "")
  local txt8 = Avg_ProcEnquotes(tbParam[8] or "")
  local txt9 = Avg_ProcEnquotes(tbParam[9] or "")
  return string.format("  {cmd=\"SetTalk\",param={%s,\"%s\",\"%s\",%s,\"%s\",%s,\"%s\",\"%s\",\"%s\"}},", tostring(tbParam[1]), avgcharid, txt3, tostring(tbParam[4]), tbParam[5], tbParam[6], txt7, txt8, txt9)
end

function CmdInfo.ParseParam_SetTalk(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Type")
  tbParam[2] = ctrl:GetAvgCharId(tr)
  tbParam[3] = ctrl:GetInputTalkContent(tr, "multiLan/CnF")
  tbParam[4] = ctrl:GetDDIndex(tr, "dd_ClearType")
  tbParam[5], tbParam[6] = ctrl:GetAvgTalkVoice(tr)
  tbParam[7] = ctrl:GetInputTalkContent(tr, "multiLan/CnM")
  tbParam[8] = ctrl:GetInputTalkContent(tr, "multiLan/JpF")
  tbParam[9] = ctrl:GetInputTalkContent(tr, "multiLan/JpM")
  local nType = tbParam[1]
  local bAvgCharIdVisible = nType ~= 8 and nType ~= 10
  tr:Find("input_AvgCharId").gameObject:SetActive(bAvgCharIdVisible)
  if bAvgCharIdVisible == false then
    tbParam[2] = "0"
  end
end

function CmdInfo.VisualizedCmd_SetTalkShake(ctrl, tr, param)
  if param == nil then
    return {
      0,
      "none",
      0,
      false
    }
  end
  ctrl:SetDDIndex(tr, "dd_Target", param[1])
  ctrl:SetDD(tr, "dd_ShakeType", ctrl.listBgShakeType, ctrl.listBgShakeType:IndexOf(param[2]))
  ctrl:SetInputDuration(tr, "input_Duration", param[3])
  ctrl:SetTog(tr, "tog_Wait", param[4])
end

function CmdInfo.TbDataToCfgStr_SetTalkShake(ctrl, tbParam)
  return string.format("  {cmd=\"SetTalkShake\",param={%s,\"%s\",%s,%s}},", tostring(tbParam[1]), tbParam[2], tostring(tbParam[3]), tostring(tbParam[4]))
end

function CmdInfo.ParseParam_SetTalkShake(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Target")
  tbParam[2] = ctrl:GetDD(tr, "dd_ShakeType")
  tbParam[3] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[4] = ctrl:GetTog(tr, "tog_Wait")
end

function CmdInfo.VisualizedCmd_SetGoOn(ctrl, tr, param)
  return nil
end

function CmdInfo.TbDataToCfgStr_SetGoOn(ctrl, tbParam)
  return "  {cmd=\"SetGoOn\"},"
end

function CmdInfo.ParseParam_SetGoOn(ctrl, tr, tbParam)
end

function CmdInfo.VisualizedCmd_SetMainRoleTalk(ctrl, tr, param)
  if param == nil then
    return {
      0,
      0,
      "002",
      "none",
      "none",
      "z",
      0,
      false,
      "avg3_100"
    }
  end
  ctrl:SetDDIndex(tr, "dd_AnimType", param[1])
  ctrl:SetDDIndex(tr, "dd_Mask", param[2])
  ctrl:SetDD(tr, "dd_body", ctrl.listBodyHead, ctrl.listBodyHead:IndexOf(param[6]))
  ctrl:SetInputFace(tr, "input_Face", param[3])
  ctrl:SetDD(tr, "dd_Emoji", ctrl.listEmoji, ctrl:GetCharEmojiIndex(param[4]) - 1)
  ctrl:SetDD(tr, "dd_ShakeType", ctrl.listCharShakeType, ctrl.listCharShakeType:IndexOf(param[5]))
  ctrl:SetInputDuration(tr, "input_Duration", param[7])
  ctrl:SetTog(tr, "tog_Wait", param[8])
  ctrl:SetAvgCharId(tr, param[9])
end

function CmdInfo.TbDataToCfgStr_SetMainRoleTalk(ctrl, tbParam)
  return string.format("  {cmd=\"SetMainRoleTalk\",param={%s,%s,\"%s\",\"%s\",\"%s\",\"%s\",%s,%s,\"%s\"}},", tostring(tbParam[1]), tostring(tbParam[2]), tbParam[3], tbParam[4], tbParam[5], tbParam[6], tostring(tbParam[7]), tostring(tbParam[8]), tbParam[9])
end

function CmdInfo.ParseParam_SetMainRoleTalk(ctrl, tr, tbParam)
  local nCurType = tbParam[1]
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_AnimType")
  tbParam[2] = ctrl:GetDDIndex(tr, "dd_Mask")
  tbParam[3] = ctrl:GetInputFace(tr, "input_Face")
  tbParam[4] = ctrl:GetCharEmojiResName(NovaAPI.GetDropDownValue(tr:Find("dd_Emoji"):GetComponent("Dropdown")) + 1)
  tbParam[5] = ctrl:GetDD(tr, "dd_ShakeType")
  tbParam[6] = ctrl:GetDD(tr, "dd_body")
  tbParam[7] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[8] = ctrl:GetTog(tr, "tog_Wait")
  tbParam[9] = ctrl:GetAvgCharId(tr)
  if tbParam[1] >= 3 and nCurType < 3 then
    tbParam[3] = nil
    ctrl:SetInputFace(tr, "input_Face", nil)
  end
end

function CmdInfo.VisualizedCmd_SetBubble(ctrl, tr, param)
  if param == nil then
    return {
      ctrl.tbAvgCharId[3],
      "",
      "",
      0,
      "",
      "",
      "",
      0,
      "",
      ""
    }
  end
  ctrl:SetAvgCharId(tr:Find("name"), param[1])
  local sFace = param[2] == "" and "002" or param[2]
  ctrl:SetInputFace(tr, "face/input_Face", sFace)
  if param[6] == nil then
    param[6] = ""
  end
  if param[9] == nil then
    param[9] = ""
  end
  if param[10] == nil then
    param[10] = ""
  end
  ctrl:SetInputTalkContent(tr, "multiLan/CnF", param[3])
  ctrl:SetInputTalkContent(tr, "multiLan/CnM", param[6])
  ctrl:SetInputTalkContent(tr, "multiLan/JpF", param[9])
  ctrl:SetInputTalkContent(tr, "multiLan/JpM", param[10])
  ctrl:SetDDIndex(tr, "dd_Dir", param[4])
  NovaAPI.SetInputFieldText(tr:Find("input_Voice"):GetComponent("InputField"), param[5])
  NovaAPI.SetInputFieldText(tr:Find("name/input_SpName"):GetComponent("InputField"), param[7] or "")
  ctrl:SetDDIndex(tr, "face/dd_ShowMask", param[8] or 0)
  SwitchMultiLanInput(tr)
end

function CmdInfo.TbDataToCfgStr_SetBubble(ctrl, tbParam)
  local txt3 = Avg_ProcEnquotes(tbParam[3] or "")
  local txt6 = Avg_ProcEnquotes(tbParam[6] or "")
  local txt9 = Avg_ProcEnquotes(tbParam[9] or "")
  local txt10 = Avg_ProcEnquotes(tbParam[10] or "")
  return string.format("  {cmd=\"SetBubble\",param={\"%s\",\"%s\",\"%s\",%s,\"%s\",\"%s\",\"%s\",%s,\"%s\",\"%s\"}},", tbParam[1], tostring(tbParam[2]), txt3, tbParam[4], tostring(tbParam[5]), txt6, tbParam[7] or "", tostring(tbParam[8] or 0), txt9, txt10)
end

function CmdInfo.ParseParam_SetBubble(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetAvgCharId(tr:Find("name"))
  tbParam[2] = ctrl:GetBubbleInputFace(tr, "face/input_Face")
  tbParam[3] = ctrl:GetInputTalkContent(tr, "multiLan/CnF")
  tbParam[4] = ctrl:GetDDIndex(tr, "dd_Dir")
  tbParam[5] = NovaAPI.GetInputFieldText(tr:Find("input_Voice"):GetComponent("InputField"))
  tbParam[6] = ctrl:GetInputTalkContent(tr, "multiLan/CnM")
  tbParam[7] = NovaAPI.GetInputFieldText(tr:Find("name/input_SpName"):GetComponent("InputField"))
  tbParam[8] = ctrl:GetDDIndex(tr, "face/dd_ShowMask")
  tbParam[9] = ctrl:GetInputTalkContent(tr, "multiLan/JpF")
  tbParam[10] = ctrl:GetInputTalkContent(tr, "multiLan/JpM")
end

function CmdInfo.VisualizedCmd_SetBubbleUIType(ctrl, tr, param)
  if param == nil then
    return {0}
  end
  ctrl:SetDDIndex(tr, "dd_UIType", param[1] - 1)
end

function CmdInfo.TbDataToCfgStr_SetBubbleUIType(ctrl, tbParam)
  return string.format("  {cmd=\"SetBubbleUIType\",param={%s}},", tostring(tbParam[1]))
end

function CmdInfo.ParseParam_SetBubbleUIType(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_UIType") + 1
end

function CmdInfo.VisualizedCmd_SetCameraAperture(ctrl, tr, param)
  if param == nil then
    return {false}
  end
  ctrl:SetTog(tr, "tog_Visible", param[1])
end

function CmdInfo.TbDataToCfgStr_SetCameraAperture(ctrl, tbParam)
  return string.format("  {cmd=\"SetCameraAperture\",param={%s}},", tostring(tbParam[1]))
end

function CmdInfo.ParseParam_SetCameraAperture(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetTog(tr, "tog_Visible")
end

function CmdInfo.VisualizedCmd_SetPhone(ctrl, tr, param)
  if param == nil then
    return {0, 1}
  end
  ctrl:SetDDIndex(tr, "dd_Move", param[1])
  ctrl:SetDDIndex(tr, "dd_ClearMsg", param[2])
  ctrl:SetAvgContactId(tr, param[3])
  tr:Find("input_AvgContactId").localScale = (param[1] == 0 or param[1] == 4) and Vector3.one or Vector3.zero
end

function CmdInfo.TbDataToCfgStr_SetPhone(ctrl, tbParam)
  return string.format("  {cmd=\"SetPhone\",param={%s, %s, \"%s\"}},", tostring(tbParam[1]), tostring(tbParam[2]), tbParam[3])
end

function CmdInfo.ParseParam_SetPhone(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Move")
  tbParam[2] = ctrl:GetDDIndex(tr, "dd_ClearMsg")
  tbParam[3] = ctrl:GetAvgContactId(tr)
  tr:Find("input_AvgContactId").localScale = (tbParam[1] == 0 or tbParam[1] == 4) and Vector3.one or Vector3.zero
end

function CmdInfo.VisualizedCmd_SetPhoneMsg(ctrl, tr, param)
  if param == nil then
    return {
      0,
      ctrl.tbAvgCharId[3],
      "",
      0,
      "",
      false,
      "",
      "",
      ""
    }
  end
  ctrl:SetDDIndex(tr, "dd_Reply", param[1])
  ctrl:SetAvgCharId(tr, param[2])
  if param[7] == nil then
    param[7] = ""
  end
  if param[8] == nil then
    param[8] = ""
  end
  if param[9] == nil then
    param[9] = ""
  end
  ctrl:SetInputTalkContent(tr, "multiLan/CnF", param[3])
  ctrl:SetInputTalkContent(tr, "multiLan/CnM", param[7])
  ctrl:SetInputTalkContent(tr, "multiLan/JpF", param[8])
  ctrl:SetInputTalkContent(tr, "multiLan/JpM", param[9])
  if param[1] > 2 then
    ctrl:SetDDIndex(tr, "imgMsg/dd_Type", param[4])
  end
  ctrl:SetAvgTalkVoice(tr, param[5], param[6])
  local nType = param[1]
  tr:Find("input_AvgCharId").localScale = nType == 5 and Vector3.zero or Vector3.one
  tr:Find("imgMsg").localScale = (nType == 3 or nType == 4) and Vector3.one or Vector3.zero
  SwitchMultiLanInput(tr)
end

function CmdInfo.TbDataToCfgStr_SetPhoneMsg(ctrl, tbParam)
  local txt3 = Avg_ProcEnquotes(tbParam[3] or "")
  local txt7 = Avg_ProcEnquotes(tbParam[7] or "")
  local txt8 = Avg_ProcEnquotes(tbParam[8] or "")
  local txt9 = Avg_ProcEnquotes(tbParam[9] or "")
  return string.format("  {cmd=\"SetPhoneMsg\",param={%s,\"%s\",\"%s\",\"%s\",\"%s\",%s,\"%s\",\"%s\",\"%s\"}},", tostring(tbParam[1]), tbParam[2], txt3, tostring(tbParam[4]), tbParam[5], tbParam[6], txt7, txt8, txt9)
end

function CmdInfo.ParseParam_SetPhoneMsg(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Reply")
  tbParam[2] = ctrl:GetAvgCharId(tr)
  tbParam[3] = ctrl:GetInputTalkContent(tr, "multiLan/CnF")
  tbParam[4] = ctrl:GetDDIndex(tr, "imgMsg/dd_Type")
  tbParam[5], tbParam[6] = ctrl:GetAvgTalkVoice(tr)
  tbParam[7] = ctrl:GetInputTalkContent(tr, "multiLan/CnM")
  tbParam[8] = ctrl:GetInputTalkContent(tr, "multiLan/JpF")
  tbParam[9] = ctrl:GetInputTalkContent(tr, "multiLan/JpM")
  local nType = tbParam[1]
  local bAvgCharIdVisible = nType ~= 5
  tr:Find("input_AvgCharId").localScale = bAvgCharIdVisible == true and Vector3.one or Vector3.zero
  if bAvgCharIdVisible == false then
    tbParam[2] = "0"
  end
  tr:Find("imgMsg").localScale = (nType == 3 or nType == 4) and Vector3.one or Vector3.zero
end

function CmdInfo.VisualizedCmd_SetPhoneThinking(ctrl, tr, param)
  if param == nil then
    return {
      "a",
      "002",
      "none",
      ""
    }
  end
  ctrl:SetDD(tr, "dd_Body", ctrl.listBody, ctrl.listBody:IndexOf(param[1]))
  ctrl:SetInputFace(tr, "input_Face", param[2])
  ctrl:SetDD(tr, "dd_Emoji", ctrl.listEmoji, ctrl:GetCharEmojiIndex(param[3]) - 1)
  local sContent = param[4]
  ctrl:SetInputTalkContent(tr, "inputContentOS", sContent)
end

function CmdInfo.TbDataToCfgStr_SetPhoneThinking(ctrl, tbParam)
  local sCmd = "  {cmd=\"SetPhoneThinking\",param={\"%s\",\"%s\",\"%s\",\"%s\"}},"
  local txt4 = Avg_ProcEnquotes(tbParam[4] or "")
  return string.format(sCmd, tbParam[1], tbParam[2], tbParam[3], txt4)
end

function CmdInfo.ParseParam_SetPhoneThinking(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDD(tr, "dd_Body")
  tbParam[2] = ctrl:GetInputFace(tr, "input_Face")
  tbParam[3] = ctrl:GetCharEmojiResName(NovaAPI.GetDropDownValue(tr:Find("dd_Emoji"):GetComponent("Dropdown")) + 1)
  tbParam[4] = ctrl:GetInputTalkContent(tr, "inputContentOS")
end

function CmdInfo.VisualizedCmd_SetChoiceBegin(ctrl, tr, param)
  if param == nil then
    return {
      "",
      0,
      {
        0,
        0,
        0,
        0
      },
      {
        "",
        "",
        "",
        ""
      },
      1,
      0,
      "a",
      "002",
      "none",
      "",
      {
        "",
        "",
        "",
        ""
      },
      "",
      {
        "",
        "",
        "",
        ""
      },
      {
        "",
        "",
        "",
        ""
      }
    }
  end
  NovaAPI.SetInputFieldText(tr:Find("groupId_mask/input_GroupId"):GetComponent("InputField"), param[1])
  ctrl:SetDDIndex(tr, "groupId_mask/dd_Mask", param[2])
  if param[13] == nil then
    param[13] = {
      "",
      "",
      "",
      ""
    }
  end
  if param[14] == nil then
    param[14] = {
      "",
      "",
      "",
      ""
    }
  end
  for i = 1, 4 do
    ctrl:SetDDIndex(tr, "visible_type/dd_type_" .. tostring(i), param[3][i])
    NovaAPI.SetInputFieldText(tr:Find("multiLan/CnF/input_Content_" .. tostring(i)):GetComponent("InputField"), param[4][i])
    NovaAPI.SetInputFieldText(tr:Find("multiLan/CnM/input_Content_" .. tostring(i)):GetComponent("InputField"), param[11][i])
    NovaAPI.SetInputFieldText(tr:Find("multiLan/JpF/input_Content_" .. tostring(i)):GetComponent("InputField"), param[13][i])
    NovaAPI.SetInputFieldText(tr:Find("multiLan/JpM/input_Content_" .. tostring(i)):GetComponent("InputField"), param[14][i])
  end
  if param[5] == nil then
    param[5] = 0
  end
  ctrl:SetDDIndex(tr, "type/dd_Type", param[5])
  ctrl:SetDDIndex(tr, "type/dd_MainRole", param[6])
  ctrl:SetDD(tr, "face_emoji/dd_Body", ctrl.listBody, ctrl.listBody:IndexOf(param[7]))
  ctrl:SetInputFace(tr, "face_emoji/input_Face", param[8])
  ctrl:SetDD(tr, "face_emoji/dd_Emoji", ctrl.listEmoji, ctrl:GetCharEmojiIndex(param[9]) - 1)
  local sOS = param[10]
  ctrl:SetInputTalkContent(tr, "inputContentOS", sOS)
  SwitchMultiLanInput(tr)
end

function CmdInfo.TbDataToCfgStr_SetChoiceBegin(ctrl, tbParam)
  local sCmd = "  {cmd=\"SetChoiceBegin\",param={\"%s\",%s,{%s,%s,%s,%s},{\"%s\",\"%s\",\"%s\",\"%s\"},%s,%s,\"%s\",\"%s\",\"%s\",\"%s\",{\"%s\",\"%s\",\"%s\",\"%s\"},\"%s\",{\"%s\",\"%s\",\"%s\",\"%s\"},{\"%s\",\"%s\",\"%s\",\"%s\"}}},"
  local txt4_1 = Avg_ProcEnquotes(tbParam[4][1] or "")
  local txt4_2 = Avg_ProcEnquotes(tbParam[4][2] or "")
  local txt4_3 = Avg_ProcEnquotes(tbParam[4][3] or "")
  local txt4_4 = Avg_ProcEnquotes(tbParam[4][4] or "")
  local txt11_1 = Avg_ProcEnquotes(tbParam[11][1] or "")
  local txt11_2 = Avg_ProcEnquotes(tbParam[11][2] or "")
  local txt11_3 = Avg_ProcEnquotes(tbParam[11][3] or "")
  local txt11_4 = Avg_ProcEnquotes(tbParam[11][4] or "")
  if tbParam[13] == nil then
    tbParam[13] = {}
  end
  local txt13_1 = Avg_ProcEnquotes(tbParam[13][1] or "")
  local txt13_2 = Avg_ProcEnquotes(tbParam[13][2] or "")
  local txt13_3 = Avg_ProcEnquotes(tbParam[13][3] or "")
  local txt13_4 = Avg_ProcEnquotes(tbParam[13][4] or "")
  if tbParam[14] == nil then
    tbParam[14] = {}
  end
  local txt14_1 = Avg_ProcEnquotes(tbParam[14][1] or "")
  local txt14_2 = Avg_ProcEnquotes(tbParam[14][2] or "")
  local txt14_3 = Avg_ProcEnquotes(tbParam[14][3] or "")
  local txt14_4 = Avg_ProcEnquotes(tbParam[14][4] or "")
  local txt10 = Avg_ProcEnquotes(tbParam[10])
  return string.format(sCmd, tbParam[1], tostring(tbParam[2]), tostring(tbParam[3][1]), tostring(tbParam[3][2]), tostring(tbParam[3][3]), tostring(tbParam[3][4]), txt4_1, txt4_2, txt4_3, txt4_4, tostring(tbParam[5]), tostring(tbParam[6]), tbParam[7], tbParam[8], tbParam[9], txt10, txt11_1, txt11_2, txt11_3, txt11_4, tbParam[12], txt13_1, txt13_2, txt13_3, txt13_4, txt14_1, txt14_2, txt14_3, txt14_4)
end

function CmdInfo.ParseParam_SetChoiceBegin(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("groupId_mask/input_GroupId"):GetComponent("InputField"))
  tbParam[2] = ctrl:GetDDIndex(tr, "groupId_mask/dd_Mask")
  for i = 1, 4 do
    tbParam[3][i] = ctrl:GetDDIndex(tr, "visible_type/dd_type_" .. tostring(i))
    tbParam[4][i] = ctrl:GetInputTalkContent(tr, "multiLan/CnF/input_Content_" .. tostring(i))
    tbParam[11][i] = ctrl:GetInputTalkContent(tr, "multiLan/CnM/input_Content_" .. tostring(i))
    tbParam[13][i] = ctrl:GetInputTalkContent(tr, "multiLan/JpF/input_Content_" .. tostring(i))
    tbParam[14][i] = ctrl:GetInputTalkContent(tr, "multiLan/JpM/input_Content_" .. tostring(i))
  end
  tbParam[5] = ctrl:GetDDIndex(tr, "type/dd_Type")
  tbParam[6] = ctrl:GetDDIndex(tr, "type/dd_MainRole")
  tbParam[7] = ctrl:GetDD(tr, "face_emoji/dd_Body")
  tbParam[8] = ctrl:GetInputFace(tr, "face_emoji/input_Face")
  tbParam[9] = ctrl:GetCharEmojiResName(NovaAPI.GetDropDownValue(tr:Find("face_emoji/dd_Emoji"):GetComponent("Dropdown")) + 1)
  tbParam[10] = ctrl:GetInputTalkContent(tr, "inputContentOS")
  tbParam[12] = ""
  if tbParam[6] == 0 then
    tbParam[7] = "a"
    tbParam[8] = "002"
    tbParam[9] = ""
    tbParam[10] = ""
    ctrl:SetDD(tr, "face_emoji/dd_Body", ctrl.listBody, ctrl.listBody:IndexOf(tbParam[7]))
    ctrl:SetInputFace(tr, "face_emoji/input_Face", tbParam[8])
    ctrl:SetDD(tr, "face_emoji/dd_Emoji", ctrl.listEmoji, ctrl:GetCharEmojiIndex(tbParam[9]) - 1)
    ctrl:SetInputTalkContent(tr, "inputContentOS", tbParam[10])
  end
end

function CmdInfo.VisualizedCmd_SetChoiceJumpTo(ctrl, tr, param)
  if param == nil then
    return {"", 0}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
  NovaAPI.SetInputFieldText(tr:Find("input_ChoiceIndex"):GetComponent("InputField"), param[2])
  NovaAPI.SetToggleIsOn(tr:Find("enable_in_visualize_preview"):GetComponent("Toggle"), param.enable_in_visualize_preview)
end

function CmdInfo.TbDataToCfgStr_SetChoiceJumpTo(ctrl, tbParam)
  return string.format("  {cmd=\"SetChoiceJumpTo\",param={\"%s\",\"%s\"}},", tbParam[1], tbParam[2])
end

function CmdInfo.ParseParam_SetChoiceJumpTo(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
  tbParam[2] = NovaAPI.GetInputFieldText(tr:Find("input_ChoiceIndex"):GetComponent("InputField"))
  tbParam.enable_in_visualize_preview = NovaAPI.GetToggleIsOn(tr:Find("enable_in_visualize_preview"):GetComponent("Toggle"))
end

function CmdInfo.VisualizedCmd_SetChoiceRollback(ctrl, tr, param)
  if param == nil then
    return {"", 0}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
  NovaAPI.SetDropDownValue(tr:Find("dd_CheckRollOver"):GetComponent("Dropdown"), param[2])
end

function CmdInfo.TbDataToCfgStr_SetChoiceRollback(ctrl, tbParam)
  return string.format("  {cmd=\"SetChoiceRollback\",param={\"%s\",%s}},", tbParam[1], tostring(tbParam[2]))
end

function CmdInfo.ParseParam_SetChoiceRollback(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
  tbParam[2] = NovaAPI.GetDropDownValue(tr:Find("dd_CheckRollOver"):GetComponent("Dropdown"))
end

function CmdInfo.VisualizedCmd_SetChoiceRollover(ctrl, tr, param)
  if param == nil then
    return {""}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
end

function CmdInfo.TbDataToCfgStr_SetChoiceRollover(ctrl, tbParam)
  return string.format("  {cmd=\"SetChoiceRollover\",param={\"%s\"}},", tbParam[1])
end

function CmdInfo.ParseParam_SetChoiceRollover(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_SetChoiceEnd(ctrl, tr, param)
  if param == nil then
    return {""}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
end

function CmdInfo.TbDataToCfgStr_SetChoiceEnd(ctrl, tbParam)
  return string.format("  {cmd=\"SetChoiceEnd\",param={\"%s\"}},", tbParam[1])
end

function CmdInfo.ParseParam_SetChoiceEnd(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_SetPhoneMsgChoiceBegin(ctrl, tr, param)
  if param == nil then
    return {
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "avg3_100"
    }
  end
  NovaAPI.SetInputFieldText(tr:Find("groupId_mask/input_GroupId"):GetComponent("InputField"), param[1])
  ctrl:SetAvgCharId(tr, param[8])
  local nOffset = 0
  local bIsMale = PlayerBaseData:GetPlayerSex() == true
  for i = 1, 6 do
    local trInputContent = tr:Find("content/input_Content_" .. tostring(i))
    NovaAPI.SetInputFieldText(trInputContent:GetComponent("InputField"), param[i + 1])
    if i <= 3 then
      trInputContent.gameObject:SetActive(bIsMale == false)
    else
      trInputContent.gameObject:SetActive(bIsMale == true)
    end
  end
end

function CmdInfo.TbDataToCfgStr_SetPhoneMsgChoiceBegin(ctrl, tbParam)
  local sCmd = "  {cmd=\"SetPhoneMsgChoiceBegin\",param={\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"}},"
  local txt2 = Avg_ProcEnquotes(tbParam[2] or "")
  local txt3 = Avg_ProcEnquotes(tbParam[3] or "")
  local txt4 = Avg_ProcEnquotes(tbParam[4] or "")
  local txt5 = Avg_ProcEnquotes(tbParam[5] or "")
  local txt6 = Avg_ProcEnquotes(tbParam[6] or "")
  local txt7 = Avg_ProcEnquotes(tbParam[7] or "")
  return string.format(sCmd, tbParam[1], txt2, txt3, txt4, txt5, txt6, txt7, tbParam[8])
end

function CmdInfo.ParseParam_SetPhoneMsgChoiceBegin(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("groupId_mask/input_GroupId"):GetComponent("InputField"))
  for i = 1, 6 do
    tbParam[i + 1] = ctrl:GetInputTalkContent(tr, "content/input_Content_" .. tostring(i))
  end
  tbParam[8] = ctrl:GetAvgCharId(tr)
end

function CmdInfo.VisualizedCmd_SetPhoneMsgChoiceJumpTo(ctrl, tr, param)
  if param == nil then
    return {"", 0}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
  NovaAPI.SetInputFieldText(tr:Find("input_ChoiceIndex"):GetComponent("InputField"), param[2])
  NovaAPI.SetToggleIsOn(tr:Find("enable_in_visualize_preview"):GetComponent("Toggle"), param.enable_in_visualize_preview)
end

function CmdInfo.TbDataToCfgStr_SetPhoneMsgChoiceJumpTo(ctrl, tbParam)
  return string.format("  {cmd=\"SetPhoneMsgChoiceJumpTo\",param={\"%s\",\"%s\"}},", tbParam[1], tbParam[2])
end

function CmdInfo.ParseParam_SetPhoneMsgChoiceJumpTo(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
  tbParam[2] = NovaAPI.GetInputFieldText(tr:Find("input_ChoiceIndex"):GetComponent("InputField"))
  tbParam.enable_in_visualize_preview = NovaAPI.GetToggleIsOn(tr:Find("enable_in_visualize_preview"):GetComponent("Toggle"))
end

function CmdInfo.VisualizedCmd_SetPhoneMsgChoiceEnd(ctrl, tr, param)
  if param == nil then
    return {""}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
end

function CmdInfo.TbDataToCfgStr_SetPhoneMsgChoiceEnd(ctrl, tbParam)
  return string.format("  {cmd=\"SetPhoneMsgChoiceEnd\",param={\"%s\"}},", tbParam[1])
end

function CmdInfo.ParseParam_SetPhoneMsgChoiceEnd(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_SetMajorChoice(ctrl, tr, param)
  if param == nil then
    return {
      1,
      "",
      0,
      "",
      "",
      "",
      "",
      0,
      "",
      0,
      "",
      "",
      "",
      "",
      0,
      "",
      0,
      "",
      "",
      "",
      "",
      0,
      "a",
      "002",
      "none",
      "",
      "",
      "",
      0,
      "",
      "",
      "",
      "",
      0
    }
  end
  NovaAPI.SetInputFieldText(tr:Find("content_groupId/input_GroupId"):GetComponent("InputField"), tostring(param[1]))
  local tbSurfix = {
    "A",
    "B",
    "C",
    "D"
  }
  local tbParamInputNode = {
    "%s/input_Icon_%s",
    "%s/dd_IconBg_%s",
    "%s/input_Title_%s",
    "%s/input_Desc_%s",
    "%s/input_Condition_%s",
    "%s/input_EvId_%s",
    "%s/dd_Type_%s"
  }
  local nOffset = 1
  for i, sChoice in ipairs(tbSurfix) do
    if i == 4 then
      nOffset = 6
    end
    for ii, sNodePath in ipairs(tbParamInputNode) do
      local sPath = string.format(sNodePath, sChoice, sChoice)
      local nIdx = (i - 1) * 7 + ii + nOffset
      if ii == 2 or ii == 7 then
        ctrl:SetDDIndex(tr, sPath, param[nIdx] or 0)
      else
        NovaAPI.SetInputFieldText(tr:Find(sPath):GetComponent("InputField"), param[nIdx] or "")
      end
    end
  end
  ctrl:SetDD(tr, "body_face_emoji/dd_Body", ctrl.listBody, ctrl.listBody:IndexOf(param[23]))
  ctrl:SetInputFace(tr, "body_face_emoji/input_Face", param[24])
  ctrl:SetDD(tr, "body_face_emoji/dd_Emoji", ctrl.listEmoji, ctrl:GetCharEmojiIndex(param[25]) - 1)
  ctrl:SetInputTalkContent(tr, "content_groupId/inputContentOS", param[26])
  NovaAPI.SetInputFieldText(tr:Find("content_groupId/input_ContentVoice"):GetComponent("InputField"), param[27])
end

function CmdInfo.TbDataToCfgStr_SetMajorChoice(ctrl, tbParam)
  local sCmd = "  {cmd=\"SetMajorChoice\",param={%s,\"%s\",%s,\"%s\",\"%s\",\"%s\",\"%s\",%s,\"%s\",%s,\"%s\",\"%s\",\"%s\",\"%s\",%s,\"%s\",%s,\"%s\",\"%s\",\"%s\",\"%s\",%s,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"}},"
  local txt4 = Avg_ProcEnquotes(tbParam[4] or "")
  local txt5 = Avg_ProcEnquotes(tbParam[5] or "")
  local txt11 = Avg_ProcEnquotes(tbParam[11] or "")
  local txt12 = Avg_ProcEnquotes(tbParam[12] or "")
  local txt18 = Avg_ProcEnquotes(tbParam[18] or "")
  local txt19 = Avg_ProcEnquotes(tbParam[19] or "")
  local txt26 = Avg_ProcEnquotes(tbParam[26] or "")
  if tbParam[28] == nil or tbParam[28] == "" then
    return string.format(sCmd, tostring(tbParam[1]), tbParam[2], tostring(tbParam[3]), txt4, txt5, tbParam[6], tbParam[7], tostring(tbParam[8]), tbParam[9], tostring(tbParam[10]), txt11, txt12, tbParam[13], tbParam[14], tostring(tbParam[15]), tbParam[16], tostring(tbParam[17]), txt18, txt19, tbParam[20], tbParam[21], tostring(tbParam[22]), tbParam[23], tostring(tbParam[24]), tbParam[25], txt26, tbParam[27])
  else
    local sCmdD = "  {cmd=\"SetMajorChoice\",param={%s,\"%s\",%s,\"%s\",\"%s\",\"%s\",\"%s\",%s,\"%s\",%s,\"%s\",\"%s\",\"%s\",\"%s\",%s,\"%s\",%s,\"%s\",\"%s\",\"%s\",\"%s\",%s,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",%s,\"%s\",\"%s\",\"%s\",\"%s\",%s}},"
    local txt30 = Avg_ProcEnquotes(tbParam[30] or "")
    local txt31 = Avg_ProcEnquotes(tbParam[31] or "")
    return string.format(sCmdD, tostring(tbParam[1]), tbParam[2], tostring(tbParam[3]), txt4, txt5, tbParam[6], tbParam[7], tostring(tbParam[8]), tbParam[9], tostring(tbParam[10]), txt11, txt12, tbParam[13], tbParam[14], tostring(tbParam[15]), tbParam[16], tostring(tbParam[17]), txt18, txt19, tbParam[20], tbParam[21], tostring(tbParam[22]), tbParam[23], tostring(tbParam[24]), tbParam[25], txt26, tbParam[27], tbParam[28], tostring(tbParam[29]), txt30, txt31, tbParam[32], tbParam[33], tostring(tbParam[34]))
  end
end

function CmdInfo.ParseParam_SetMajorChoice(ctrl, tr, tbParam)
  tbParam[1] = tonumber(NovaAPI.GetInputFieldText(tr:Find("content_groupId/input_GroupId"):GetComponent("InputField")))
  local tbSurfix = {
    "A",
    "B",
    "C",
    "D"
  }
  local tbParamInputNode = {
    "%s/input_Icon_%s",
    "%s/dd_IconBg_%s",
    "%s/input_Title_%s",
    "%s/input_Desc_%s",
    "%s/input_Condition_%s",
    "%s/input_EvId_%s",
    "%s/dd_Type_%s"
  }
  local nOffset = 1
  for i, sChoice in ipairs(tbSurfix) do
    if i == 4 then
      nOffset = 6
    end
    for ii, sNodePath in ipairs(tbParamInputNode) do
      local sPath = string.format(sNodePath, sChoice, sChoice)
      local nIdx = (i - 1) * 7 + ii + nOffset
      if ii == 2 or ii == 7 then
        tbParam[nIdx] = ctrl:GetDDIndex(tr, sPath)
      else
        tbParam[nIdx] = NovaAPI.GetInputFieldText(tr:Find(sPath):GetComponent("InputField"))
      end
    end
  end
  tbParam[23] = ctrl:GetDD(tr, "body_face_emoji/dd_Body")
  tbParam[24] = ctrl:GetInputFace(tr, "body_face_emoji/input_Face")
  tbParam[25] = ctrl:GetCharEmojiResName(NovaAPI.GetDropDownValue(tr:Find("body_face_emoji/dd_Emoji"):GetComponent("Dropdown")) + 1)
  tbParam[26] = ctrl:GetInputTalkContent(tr, "content_groupId/inputContentOS")
  tbParam[27] = NovaAPI.GetInputFieldText(tr:Find("content_groupId/input_ContentVoice"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_GetEvidence(ctrl, tr, param)
  if param == nil then
    return {""}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_EvId"):GetComponent("InputField"), param[1])
end

function CmdInfo.TbDataToCfgStr_GetEvidence(ctrl, tbParam)
  return string.format("  {cmd=\"GetEvidence\",param={\"%s\"}},", tbParam[1])
end

function CmdInfo.ParseParam_GetEvidence(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_EvId"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_SetMajorChoiceJumpTo(ctrl, tr, param)
  if param == nil then
    return {1, 1}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), tostring(param[1]))
  NovaAPI.SetInputFieldText(tr:Find("input_ChoiceIndex"):GetComponent("InputField"), tostring(param[2]))
  NovaAPI.SetToggleIsOn(tr:Find("enable_in_visualize_preview"):GetComponent("Toggle"), param.enable_in_visualize_preview)
end

function CmdInfo.TbDataToCfgStr_SetMajorChoiceJumpTo(ctrl, tbParam)
  return string.format("  {cmd=\"SetMajorChoiceJumpTo\",param={%s,%s}},", tostring(tbParam[1]), tostring(tbParam[2]))
end

function CmdInfo.ParseParam_SetMajorChoiceJumpTo(ctrl, tr, tbParam)
  tbParam[1] = tonumber(NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField")))
  tbParam[2] = tonumber(NovaAPI.GetInputFieldText(tr:Find("input_ChoiceIndex"):GetComponent("InputField")))
  tbParam.enable_in_visualize_preview = NovaAPI.GetToggleIsOn(tr:Find("enable_in_visualize_preview"):GetComponent("Toggle"))
end

function CmdInfo.VisualizedCmd_SetMajorChoiceRollover(ctrl, tr, param)
  if param == nil then
    return {1}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), tostring(param[1]))
end

function CmdInfo.TbDataToCfgStr_SetMajorChoiceRollover(ctrl, tbParam)
  return string.format("  {cmd=\"SetMajorChoiceRollover\",param={%s}},", tostring(tbParam[1]))
end

function CmdInfo.ParseParam_SetMajorChoiceRollover(ctrl, tr, tbParam)
  tbParam[1] = tonumber(NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField")))
end

function CmdInfo.VisualizedCmd_SetMajorChoiceEnd(ctrl, tr, param)
  if param == nil then
    return {1}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), tostring(param[1]))
end

function CmdInfo.TbDataToCfgStr_SetMajorChoiceEnd(ctrl, tbParam)
  return string.format("  {cmd=\"SetMajorChoiceEnd\",param={%s}},", tostring(tbParam[1]))
end

function CmdInfo.ParseParam_SetMajorChoiceEnd(ctrl, tr, tbParam)
  tbParam[1] = tonumber(NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField")))
end

function CmdInfo.VisualizedCmd_SetPersonalityChoice(ctrl, tr, param)
  if param == nil then
    return {
      1,
      1,
      "",
      "",
      "",
      "a",
      "002",
      "none",
      "",
      ""
    }
  end
  NovaAPI.SetInputFieldText(tr:Find("content_groupId/input_GroupId"):GetComponent("InputField"), tostring(param[1]))
  NovaAPI.SetInputFieldText(tr:Find("input_Factor"):GetComponent("InputField"), tostring(param[2]))
  NovaAPI.SetInputFieldText(tr:Find("input_Action_A"):GetComponent("InputField"), param[3])
  NovaAPI.SetInputFieldText(tr:Find("input_Action_B"):GetComponent("InputField"), param[4])
  NovaAPI.SetInputFieldText(tr:Find("input_Action_C"):GetComponent("InputField"), param[5])
  ctrl:SetDD(tr, "body_face_emoji/dd_Body", ctrl.listBody, ctrl.listBody:IndexOf(param[6]))
  ctrl:SetInputFace(tr, "body_face_emoji/input_Face", param[7])
  ctrl:SetDD(tr, "body_face_emoji/dd_Emoji", ctrl.listEmoji, ctrl:GetCharEmojiIndex(param[8]) - 1)
  ctrl:SetInputTalkContent(tr, "content_groupId/inputContentOS", param[9])
  NovaAPI.SetInputFieldText(tr:Find("content_groupId/input_ContentVoice"):GetComponent("InputField"), param[10])
end

function CmdInfo.TbDataToCfgStr_SetPersonalityChoice(ctrl, tbParam)
  local sCmd = "  {cmd=\"SetPersonalityChoice\",param={%s,%s,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"}},"
  local txt3 = Avg_ProcEnquotes(tbParam[3] or "")
  local txt4 = Avg_ProcEnquotes(tbParam[4] or "")
  local txt5 = Avg_ProcEnquotes(tbParam[5] or "")
  local txt9 = Avg_ProcEnquotes(tbParam[9] or "")
  return string.format(sCmd, tostring(tbParam[1]), tostring(tbParam[2]), txt3, txt4, txt5, tbParam[6], tbParam[7], tbParam[8], txt9, tbParam[10])
end

function CmdInfo.ParseParam_SetPersonalityChoice(ctrl, tr, tbParam)
  tbParam[1] = tonumber(NovaAPI.GetInputFieldText(tr:Find("content_groupId/input_GroupId"):GetComponent("InputField")))
  tbParam[2] = tonumber(NovaAPI.GetInputFieldText(tr:Find("input_Factor"):GetComponent("InputField")))
  tbParam[3] = ctrl:GetInputTalkContent(tr, "input_Action_A")
  tbParam[4] = ctrl:GetInputTalkContent(tr, "input_Action_B")
  tbParam[5] = ctrl:GetInputTalkContent(tr, "input_Action_C")
  tbParam[6] = ctrl:GetDD(tr, "body_face_emoji/dd_Body")
  tbParam[7] = ctrl:GetInputFace(tr, "body_face_emoji/input_Face")
  tbParam[8] = ctrl:GetCharEmojiResName(NovaAPI.GetDropDownValue(tr:Find("body_face_emoji/dd_Emoji"):GetComponent("Dropdown")) + 1)
  tbParam[9] = ctrl:GetInputTalkContent(tr, "content_groupId/inputContentOS")
  tbParam[10] = NovaAPI.GetInputFieldText(tr:Find("content_groupId/input_ContentVoice"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_SetPersonalityChoiceJumpTo(ctrl, tr, param)
  if param == nil then
    return {1, 1}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), tostring(param[1]))
  NovaAPI.SetInputFieldText(tr:Find("input_ChoiceIndex"):GetComponent("InputField"), tostring(param[2]))
  NovaAPI.SetToggleIsOn(tr:Find("enable_in_visualize_preview"):GetComponent("Toggle"), param.enable_in_visualize_preview)
end

function CmdInfo.TbDataToCfgStr_SetPersonalityChoiceJumpTo(ctrl, tbParam)
  return string.format("  {cmd=\"SetPersonalityChoiceJumpTo\",param={%s,%s}},", tostring(tbParam[1]), tostring(tbParam[2]))
end

function CmdInfo.ParseParam_SetPersonalityChoiceJumpTo(ctrl, tr, tbParam)
  tbParam[1] = tonumber(NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField")))
  tbParam[2] = tonumber(NovaAPI.GetInputFieldText(tr:Find("input_ChoiceIndex"):GetComponent("InputField")))
  tbParam.enable_in_visualize_preview = NovaAPI.GetToggleIsOn(tr:Find("enable_in_visualize_preview"):GetComponent("Toggle"))
end

function CmdInfo.VisualizedCmd_SetPersonalityChoiceRollover(ctrl, tr, param)
  if param == nil then
    return {1}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), tostring(param[1]))
end

function CmdInfo.TbDataToCfgStr_SetPersonalityChoiceRollover(ctrl, tbParam)
  return string.format("  {cmd=\"SetPersonalityChoiceRollover\",param={%s}},", tostring(tbParam[1]))
end

function CmdInfo.ParseParam_SetPersonalityChoiceRollover(ctrl, tr, tbParam)
  tbParam[1] = tonumber(NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField")))
end

function CmdInfo.VisualizedCmd_SetPersonalityChoiceEnd(ctrl, tr, param)
  if param == nil then
    return {1}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), tostring(param[1]))
end

function CmdInfo.TbDataToCfgStr_SetPersonalityChoiceEnd(ctrl, tbParam)
  return string.format("  {cmd=\"SetPersonalityChoiceEnd\",param={%s}},", tostring(tbParam[1]))
end

function CmdInfo.ParseParam_SetPersonalityChoiceEnd(ctrl, tr, tbParam)
  tbParam[1] = tonumber(NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField")))
end

function CmdInfo.VisualizedCmd_IfTrue(ctrl, tr, param)
  if param == nil then
    return {"", ""}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
  ctrl:SetDDIndex(tr, "dd_Type", param[2])
  NovaAPI.SetInputFieldText(tr:Find("input_AvgId"):GetComponent("InputField"), param[3])
  NovaAPI.SetInputFieldText(tr:Find("input_ChoiceGroupId"):GetComponent("InputField"), param[4])
  NovaAPI.SetInputFieldText(tr:Find("input_LatestChosen"):GetComponent("InputField"), param[5])
end

function CmdInfo.TbDataToCfgStr_IfTrue(ctrl, tbParam)
  return string.format("  {cmd=\"IfTrue\",param={\"%s\",%s,\"%s\",%s,\"%s\"}},", tbParam[1], tostring(tbParam[2]), tbParam[3], tostring(tbParam[4]), tbParam[5])
end

function CmdInfo.ParseParam_IfTrue(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
  tbParam[2] = ctrl:GetDDIndex(tr, "dd_Type")
  tbParam[3] = NovaAPI.GetInputFieldText(tr:Find("input_AvgId"):GetComponent("InputField"))
  tbParam[4] = tonumber(NovaAPI.GetInputFieldText(tr:Find("input_ChoiceGroupId"):GetComponent("InputField")))
  tbParam[5] = NovaAPI.GetInputFieldText(tr:Find("input_LatestChosen"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_EndIf(ctrl, tr, param)
  if param == nil then
    return {""}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
end

function CmdInfo.TbDataToCfgStr_EndIf(ctrl, tbParam)
  return string.format("  {cmd=\"EndIf\",param={\"%s\"}},", tbParam[1])
end

function CmdInfo.ParseParam_EndIf(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_IfUnlock(ctrl, tr, param)
  if param == nil then
    return {"", ""}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
  NovaAPI.SetInputFieldText(tr:Find("input_ConditionId"):GetComponent("InputField"), param[2])
end

function CmdInfo.TbDataToCfgStr_IfUnlock(ctrl, tbParam)
  return string.format("  {cmd=\"IfUnlock\",param={\"%s\",\"%s\"}},", tbParam[1], tbParam[2])
end

function CmdInfo.ParseParam_IfUnlock(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
  tbParam[2] = NovaAPI.GetInputFieldText(tr:Find("input_ConditionId"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_IfUnlockElse(ctrl, tr, param)
  if param == nil then
    return {""}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
end

function CmdInfo.TbDataToCfgStr_IfUnlockElse(ctrl, tbParam)
  return string.format("  {cmd=\"IfUnlockElse\",param={\"%s\"}},", tbParam[1])
end

function CmdInfo.ParseParam_IfUnlockElse(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_IfUnlockEnd(ctrl, tr, param)
  if param == nil then
    return {""}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
end

function CmdInfo.TbDataToCfgStr_IfUnlockEnd(ctrl, tbParam)
  return string.format("  {cmd=\"IfUnlockEnd\",param={\"%s\"}},", tbParam[1])
end

function CmdInfo.ParseParam_IfUnlockEnd(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_SetAudio(ctrl, tr, param)
  if param == nil then
    return {
      0,
      "",
      0,
      false
    }
  end
  ctrl:SetDDIndex(tr, "dd_Type", param[1])
  NovaAPI.SetInputFieldText(tr:Find("input_SoundName"):GetComponent("InputField"), param[2])
  ctrl:SetInputDuration(tr, "input_Duration", param[3])
  ctrl:SetTog(tr, "tog_Wait", param[4])
end

function CmdInfo.TbDataToCfgStr_SetAudio(ctrl, tbParam)
  return string.format("  {cmd=\"SetAudio\",param={%s,\"%s\",%s,%s}},", tostring(tbParam[1]), tbParam[2], tostring(tbParam[3]), tostring(tbParam[4]))
end

function CmdInfo.ParseParam_SetAudio(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Type")
  tbParam[2] = NovaAPI.GetInputFieldText(tr:Find("input_SoundName"):GetComponent("InputField"))
  tbParam[3] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[4] = ctrl:GetTog(tr, "tog_Wait")
end

function CmdInfo.VisualizedCmd_SetBGM(ctrl, tr, param)
  if param == nil then
    return {
      0,
      "music_avg_volume100_0s",
      0,
      "",
      "none",
      0,
      false
    }
  end
  ctrl:SetDDIndex(tr, "dd_PlayStopPauseResumeVol", param[1])
  ctrl:SetDD(tr, "dd_Volume", ctrl.listBgmVol, ctrl:GetBgmVolIndex(param[2]) - 1)
  ctrl:SetDDIndex(tr, "dd_TrackIndex", param[3])
  NovaAPI.SetInputFieldText(tr:Find("input_BGM"):GetComponent("InputField"), param[4])
  ctrl:SetDD(tr, "dd_FadeTime", ctrl.listBgmFadeTime, ctrl.listBgmFadeTime:IndexOf(param[5]))
  ctrl:SetInputDuration(tr, "input_Duration", param[6])
  ctrl:SetTog(tr, "tog_Wait", param[7])
  tr:Find("dd_Volume").gameObject:SetActive(param[1] == 0 or param[1] == 4)
  tr:Find("dd_TrackIndex").gameObject:SetActive(param[1] ~= 4)
  tr:Find("input_BGM").gameObject:SetActive(param[1] == 0)
  tr:Find("dd_FadeTime").gameObject:SetActive(param[1] ~= 4)
end

function CmdInfo.TbDataToCfgStr_SetBGM(ctrl, tbParam)
  return string.format("  {cmd=\"SetBGM\",param={%s,\"%s\",%s,\"%s\",\"%s\",%s,%s}},", tostring(tbParam[1]), tbParam[2], tostring(tbParam[3]), tbParam[4], tbParam[5], tostring(tbParam[6]), tostring(tbParam[7]))
end

function CmdInfo.ParseParam_SetBGM(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_PlayStopPauseResumeVol")
  tbParam[2] = ctrl:GetBgmVolName(ctrl:GetDDIndex(tr, "dd_Volume") + 1)
  tbParam[3] = ctrl:GetDDIndex(tr, "dd_TrackIndex")
  tbParam[4] = NovaAPI.GetInputFieldText(tr:Find("input_BGM"):GetComponent("InputField"))
  tbParam[5] = ctrl:GetDD(tr, "dd_FadeTime")
  tbParam[6] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[7] = ctrl:GetTog(tr, "tog_Wait")
  tr:Find("dd_Volume").gameObject:SetActive(tbParam[1] == 0 or tbParam[1] == 4)
  tr:Find("dd_TrackIndex").gameObject:SetActive(tbParam[1] ~= 4)
  tr:Find("input_BGM").gameObject:SetActive(tbParam[1] == 0)
  tr:Find("dd_FadeTime").gameObject:SetActive(tbParam[1] ~= 4)
end

function CmdInfo.VisualizedCmd_SetSceneHeading(ctrl, tr, param)
  if param == nil then
    return {
      "",
      "",
      "",
      "",
      ""
    }
  end
  NovaAPI.SetInputFieldText(tr:Find("inputTime"):GetComponent("InputField"), param[1])
  NovaAPI.SetInputFieldText(tr:Find("inputMonth"):GetComponent("InputField"), param[2])
  NovaAPI.SetInputFieldText(tr:Find("inputDay"):GetComponent("InputField"), param[3])
  NovaAPI.SetInputFieldText(tr:Find("inputPosMain"):GetComponent("InputField"), param[4])
  NovaAPI.SetInputFieldText(tr:Find("inputPosSub"):GetComponent("InputField"), param[5])
end

function CmdInfo.TbDataToCfgStr_SetSceneHeading(ctrl, tbParam)
  local txt1 = Avg_ProcEnquotes(tbParam[1] or "")
  local txt2 = Avg_ProcEnquotes(tbParam[2] or "")
  local txt3 = Avg_ProcEnquotes(tbParam[3] or "")
  local txt4 = Avg_ProcEnquotes(tbParam[4] or "")
  local txt5 = Avg_ProcEnquotes(tbParam[5] or "")
  return string.format("  {cmd=\"SetSceneHeading\",param={\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"}},", txt1, txt2, txt3, txt4, txt5)
end

function CmdInfo.ParseParam_SetSceneHeading(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("inputTime"):GetComponent("InputField"))
  tbParam[2] = NovaAPI.GetInputFieldText(tr:Find("inputMonth"):GetComponent("InputField"))
  tbParam[3] = NovaAPI.GetInputFieldText(tr:Find("inputDay"):GetComponent("InputField"))
  tbParam[4] = NovaAPI.GetInputFieldText(tr:Find("inputPosMain"):GetComponent("InputField"))
  tbParam[5] = NovaAPI.GetInputFieldText(tr:Find("inputPosSub"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_SetIntro(ctrl, tr, param)
  if param == nil then
    return {
      ctrl.tbIntroIcon[1],
      "第 1 话",
      "邂逅",
      "测试用文字测试用文字==RT==测试用文字测试用文字==RT==测试用文字测试用文字==RT==测试用文字测试用文字==RT==",
      0
    }
  end
  ctrl:SetResName(tr, "input_Icon", ctrl.tbIntroIcon, param[1])
  NovaAPI.SetInputFieldText(tr:Find("title_name/input_Title"):GetComponent("InputField"), param[2])
  NovaAPI.SetInputFieldText(tr:Find("title_name/input_Name"):GetComponent("InputField"), param[3])
  ctrl:SetInputTalkContent(tr, "input_Content", param[4])
  NovaAPI.SetDropDownValue(tr:Find("dd_BE"):GetComponent("Dropdown"), param[5] or 0)
end

function CmdInfo.TbDataToCfgStr_SetIntro(ctrl, tbParam)
  local txt2 = Avg_ProcEnquotes(tbParam[2] or "")
  local txt3 = Avg_ProcEnquotes(tbParam[3] or "")
  local txt4 = Avg_ProcEnquotes(tbParam[4] or "")
  return string.format("  {cmd=\"SetIntro\",param={\"%s\",\"%s\",\"%s\",\"%s\",%s}},", tbParam[1], txt2, txt3, txt4, tostring(tbParam[5] or 0))
end

function CmdInfo.ParseParam_SetIntro(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetResName(tr, "input_Icon")
  tbParam[2] = NovaAPI.GetInputFieldText(tr:Find("title_name/input_Title"):GetComponent("InputField"))
  tbParam[3] = NovaAPI.GetInputFieldText(tr:Find("title_name/input_Name"):GetComponent("InputField"))
  tbParam[4] = ctrl:GetInputTalkContent(tr, "input_Content")
  tbParam[5] = NovaAPI.GetDropDownValue(tr:Find("dd_BE"):GetComponent("Dropdown"))
end

function CmdInfo.VisualizedCmd_Wait(ctrl, tr, param)
  if param == nil then
    return {1}
  end
  NovaAPI.SetInputFieldText(tr:Find("inputWait"):GetComponent("InputField"), tostring(param[1]))
end

function CmdInfo.TbDataToCfgStr_Wait(ctrl, tbParam)
  return string.format("  {cmd=\"Wait\",param={%s}},", tostring(tbParam[1]))
end

function CmdInfo.ParseParam_Wait(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetInputDuration(tr, "inputWait")
end

function CmdInfo.VisualizedCmd_Jump(ctrl, tr, param)
  if param == nil then
    return {1}
  end
  NovaAPI.SetInputFieldText(tr:Find("inputJump"):GetComponent("InputField"), tostring(param[1]))
end

function CmdInfo.TbDataToCfgStr_Jump(ctrl, tbParam)
  return string.format("  {cmd=\"Jump\",param={%d}},", tbParam[1])
end

function CmdInfo.ParseParam_Jump(ctrl, tr, tbParam)
  local sJumpTo = NovaAPI.GetInputFieldText(tr:Find("inputJump"):GetComponent("InputField"))
  sJumpTo = sJumpTo == "" and "1" or sJumpTo
  tbParam[1] = tonumber(sJumpTo)
end

function CmdInfo.VisualizedCmd_Clear(ctrl, tr, param)
  if param == nil then
    return {
      true,
      1,
      true,
      true
    }
  end
  local bClearChar = param[1] == true
  local nClearCharDuration = param[2] or 0
  local bWait = param[3] == true
  local bClearTalk = param[4] == true
  NovaAPI.SetToggleIsOn(tr:Find("togClearAllChar"):GetComponent("Toggle"), bClearChar)
  local trInputDuration = tr:Find("inputDuration")
  NovaAPI.SetInputFieldText(trInputDuration:GetComponent("InputField"), tostring(nClearCharDuration))
  trInputDuration.gameObject:SetActive(bClearChar)
  local trWait = tr:Find("togWait")
  NovaAPI.SetToggleIsOn(trWait:GetComponent("Toggle"), bWait)
  trWait.gameObject:SetActive(bClearChar)
  NovaAPI.SetToggleIsOn(tr:Find("togClearTalk"):GetComponent("Toggle"), bClearTalk)
end

function CmdInfo.TbDataToCfgStr_Clear(ctrl, tbParam)
  return string.format("  {cmd=\"Clear\",param={%s,%s,%s,%s}},", tostring(tbParam[1]), tostring(tbParam[2]), tostring(tbParam[3]), tostring(tbParam[4]))
end

function CmdInfo.ParseParam_Clear(ctrl, tr, tbParam)
  local bClearChar = NovaAPI.GetToggleIsOn(tr:Find("togClearAllChar"):GetComponent("Toggle"))
  local nClearCharDuration
  local trInputDuration = tr:Find("inputDuration")
  if bClearChar == true then
    nClearCharDuration = ctrl:GetInputDuration(tr, "inputDuration")
  end
  trInputDuration.gameObject:SetActive(bClearChar)
  local bWait = false
  local trWait = tr:Find("togWait")
  if bClearChar == true then
    bWait = NovaAPI.GetToggleIsOn(trWait:GetComponent("Toggle"))
  end
  trWait.gameObject:SetActive(bClearChar)
  tbParam[1] = bClearChar
  tbParam[2] = nClearCharDuration or 0
  tbParam[3] = bWait
  tbParam[4] = NovaAPI.GetToggleIsOn(tr:Find("togClearTalk"):GetComponent("Toggle"))
end

function CmdInfo.VisualizedCmd_Comment(ctrl, tr, param)
  if param == nil then
    return {""}
  end
  ctrl:SetInputTalkContent(tr, "inputContent", param[1])
end

function CmdInfo.TbDataToCfgStr_Comment(ctrl, tbParam)
  return string.format("  {cmd=\"Comment\",param={\"%s\"}},", tostring(tbParam[1]))
end

function CmdInfo.ParseParam_Comment(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetInputTalkContent(tr, "inputContent")
end

function CmdInfo.VisualizedCmd_JUMP_AVG_ID(ctrl, tr, param)
  if param == nil then
    return {"", 1}
  end
  NovaAPI.SetInputFieldText(tr:Find("inputJumpAvgId"):GetComponent("InputField"), param[1])
  NovaAPI.SetInputFieldText(tr:Find("inputJumpCmdId"):GetComponent("InputField"), tostring(param[2]))
  NovaAPI.SetInputFieldText(tr:Find("inputMarkBE"):GetComponent("InputField"), tostring(param[3] or ""))
end

function CmdInfo.TbDataToCfgStr_JUMP_AVG_ID(ctrl, tbParam)
  return string.format("  {cmd=\"JUMP_AVG_ID\",param={\"%s\",%d,\"%s\"}},", tbParam[1], tbParam[2], tbParam[3] or "")
end

function CmdInfo.ParseParam_JUMP_AVG_ID(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("inputJumpAvgId"):GetComponent("InputField"))
  tbParam[2] = tonumber(NovaAPI.GetInputFieldText(tr:Find("inputJumpCmdId"):GetComponent("InputField"))) or 1
  tbParam[3] = NovaAPI.GetInputFieldText(tr:Find("inputMarkBE"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_End(ctrl, tr, param)
  return nil
end

function CmdInfo.TbDataToCfgStr_End(ctrl, tbParam)
  return "  {cmd=\"End\"},"
end

function CmdInfo.ParseParam_End(ctrl, tr, tbParam)
end

function CmdInfo.VisualizedCmd_BadEnding_Check(ctrl, tr, param)
  return nil
end

function CmdInfo.TbDataToCfgStr_BadEnding_Check(ctrl, tbParam)
  return "  {cmd=\"BadEnding_Check\"},"
end

function CmdInfo.ParseParam_BadEnding_Check(ctrl, tr, tbParam)
end

function CmdInfo.VisualizedCmd_BadEnding_Mark(ctrl, tr, param)
  return nil
end

function CmdInfo.TbDataToCfgStr_BadEnding_Mark(ctrl, tbParam)
  return "  {cmd=\"BadEnding_Mark\"},"
end

function CmdInfo.ParseParam_BadEnding_Mark(ctrl, tr, tbParam)
end

function CmdInfo.VisualizedCmd_NewCharIntro(ctrl, tr, param)
  if param == nil then
    return {
      ctrl.tbAvgCharId[3],
      "",
      "",
      "a",
      "002",
      nil,
      nil,
      nil,
      0
    }
  end
  ctrl:SetAvgCharId(tr, param[1])
  NovaAPI.SetInputFieldText(tr:Find("name_title/input_Name"):GetComponent("InputField"), param[2])
  NovaAPI.SetInputFieldText(tr:Find("name_title/input_Title"):GetComponent("InputField"), param[3])
  ctrl:SetDD(tr, "body_face/dd_Body", ctrl.listBody, ctrl.listBody:IndexOf(param[4]))
  ctrl:SetInputFace(tr, "body_face/input_Face", param[5])
  ctrl:SetInputNum(tr, "custom_data/input_PosX", param[6])
  ctrl:SetInputNum(tr, "custom_data/input_PosY", param[7])
  ctrl:SetInputNum(tr, "custom_data/input_Scale", param[8])
  ctrl:SetDDIndex(tr, "custom_data/dd_Anim", param[9])
end

function CmdInfo.TbDataToCfgStr_NewCharIntro(ctrl, tbParam)
  local txt2 = Avg_ProcEnquotes(tbParam[2] or "")
  local txt3 = Avg_ProcEnquotes(tbParam[3] or "")
  return string.format("  {cmd=\"NewCharIntro\",param={\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",%s,%s,%s,%s}},", tbParam[1], txt2, txt3, tbParam[4], tbParam[5], tostring(tbParam[6]), tostring(tbParam[7]), tostring(tbParam[8]), tostring(tbParam[9]))
end

function CmdInfo.ParseParam_NewCharIntro(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetAvgCharId(tr)
  tbParam[2] = NovaAPI.GetInputFieldText(tr:Find("name_title/input_Name"):GetComponent("InputField"))
  tbParam[3] = NovaAPI.GetInputFieldText(tr:Find("name_title/input_Title"):GetComponent("InputField"))
  tbParam[4] = ctrl:GetDD(tr, "body_face/dd_Body")
  tbParam[5] = ctrl:GetInputFace(tr, "body_face/input_Face")
  tbParam[6] = ctrl:GetInputNum(tr, "custom_data/input_PosX")
  tbParam[7] = ctrl:GetInputNum(tr, "custom_data/input_PosY")
  tbParam[8] = ctrl:GetInputNum(tr, "custom_data/input_Scale")
  tbParam[9] = ctrl:GetDDIndex(tr, "custom_data/dd_Anim")
end

function CmdInfo.VisualizedCmd_SetGroupId(ctrl, tr, param)
  if param == nil then
    return {"0"}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_Group"):GetComponent("InputField"), param[1])
end

function CmdInfo.TbDataToCfgStr_SetGroupId(ctrl, tbParam)
  return string.format("  {cmd=\"SetGroupId\",param={\"%s\"}},", tostring(tbParam[1]))
end

function CmdInfo.ParseParam_SetGroupId(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_Group"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_PlayVideo(ctrl, tr, param)
  if param == nil then
    return {
      0,
      ctrl.tbBgEftName[1],
      ctrl.listEaseType[0],
      "default",
      true,
      true,
      ""
    }
  end
  ctrl:SetDDIndex(tr, "dd_Style", param[1])
  ctrl:SetResName(tr, "input_EftResName", ctrl.tbBgEftName, param[2])
  ctrl:SetDD(tr, "dd_EaseType", ctrl.listEaseType, ctrl.listEaseType:IndexOf(param[3]))
  ctrl:SetDD(tr, "dd_KeyName", ctrl.listKeyName, ctrl.listKeyName:IndexOf(param[4]))
  ctrl:SetTog(tr, "tog_ClearAllChar", param[5])
  ctrl:SetTog(tr, "tog_ClearAllTalk", param[6])
  ctrl:SetInputDuration(tr, "input_Duration", param[7])
  NovaAPI.SetInputFieldText(tr:Find("input_VideoResName"):GetComponent("InputField"), param[8])
  tr:Find("input_EftResName").gameObject:SetActive(param[1] <= 1)
  tr:Find("dd_EaseType").gameObject:SetActive(param[1] <= 1)
end

function CmdInfo.TbDataToCfgStr_PlayVideo(ctrl, tbParam)
  return string.format("  {cmd=\"PlayVideo\",param={%s,\"%s\",\"%s\",\"%s\",%s,%s,%s,\"%s\"}},", tostring(tbParam[1]), tbParam[2], tbParam[3], tbParam[4], tostring(tbParam[5]), tostring(tbParam[6]), tostring(tbParam[7]), tbParam[8])
end

function CmdInfo.ParseParam_PlayVideo(ctrl, tr, tbParam)
  tbParam[1] = ctrl:GetDDIndex(tr, "dd_Style")
  tbParam[2] = ctrl:GetResName(tr, "input_EftResName")
  tbParam[3] = ctrl:GetDD(tr, "dd_EaseType")
  tbParam[4] = ctrl:GetDD(tr, "dd_KeyName")
  tbParam[5] = ctrl:GetTog(tr, "tog_ClearAllChar")
  tbParam[6] = ctrl:GetTog(tr, "tog_ClearAllTalk")
  tbParam[7] = ctrl:GetInputDuration(tr, "input_Duration")
  tbParam[8] = NovaAPI.GetInputFieldText(tr:Find("input_VideoResName"):GetComponent("InputField"))
  tr:Find("input_EftResName").gameObject:SetActive(tbParam[1] <= 1)
  tr:Find("dd_EaseType").gameObject:SetActive(tbParam[1] <= 1)
end

function CmdInfo.VisualizedCmd_CheckBE(ctrl, tr, param)
  if param == nil then
    return {
      "a1",
      0,
      0,
      0.5
    }
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
  NovaAPI.SetInputFieldText(tr:Find("input_From"):GetComponent("InputField"), param[2])
  NovaAPI.SetInputFieldText(tr:Find("input_To"):GetComponent("InputField"), param[3])
  NovaAPI.SetInputFieldText(tr:Find("input_Value"):GetComponent("InputField"), param[4])
end

function CmdInfo.TbDataToCfgStr_CheckBE(ctrl, tbParam)
  return string.format("  {cmd=\"CheckBE\",param={\"%s\",%s,%s,%s}},", tostring(tbParam[1]), tostring(tbParam[2]), tostring(tbParam[3]), tostring(tbParam[4]))
end

function CmdInfo.ParseParam_CheckBE(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
  tbParam[2] = NovaAPI.GetInputFieldText(tr:Find("input_From"):GetComponent("InputField"))
  tbParam[3] = NovaAPI.GetInputFieldText(tr:Find("input_To"):GetComponent("InputField"))
  tbParam[4] = NovaAPI.GetInputFieldText(tr:Find("input_Value"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_CheckBECase(ctrl, tr, param)
  if param == nil then
    return {"a1", 0}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
  NovaAPI.SetInputFieldText(tr:Find("input_Case"):GetComponent("InputField"), param[2])
end

function CmdInfo.TbDataToCfgStr_CheckBECase(ctrl, tbParam)
  return string.format("  {cmd=\"CheckBECase\",param={\"%s\",%s}},", tostring(tbParam[1]), tostring(tbParam[2]))
end

function CmdInfo.ParseParam_CheckBECase(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
  tbParam[2] = NovaAPI.GetInputFieldText(tr:Find("input_Case"):GetComponent("InputField"))
end

function CmdInfo.VisualizedCmd_CheckBEEnd(ctrl, tr, param)
  if param == nil then
    return {"a1"}
  end
  NovaAPI.SetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"), param[1])
end

function CmdInfo.TbDataToCfgStr_CheckBEEnd(ctrl, tbParam)
  return string.format("  {cmd=\"CheckBEEnd\",param={\"%s\"}},", tostring(tbParam[1]))
end

function CmdInfo.ParseParam_CheckBEEnd(ctrl, tr, tbParam)
  tbParam[1] = NovaAPI.GetInputFieldText(tr:Find("input_GroupId"):GetComponent("InputField"))
end

return CmdInfo
