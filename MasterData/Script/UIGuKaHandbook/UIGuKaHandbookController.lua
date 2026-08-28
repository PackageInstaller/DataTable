local View = require("UIGuKaHandbook/UIGuKaHandbookView")
local DataModel = require("UIGuKaHandbook/UIGuKaHandbookDataModel")
local Controller = {}

function Controller:Init()
  DataModel.Init()
  Controller:OpenType()
  View.Group_Type.Btn_GuKa:SetSprite(GetResPath(88300229))
  View.Group_Type.Btn_Fireworks:SetSprite(GetResPath(88300230))
  View.Group_Type.Btn_Event:SetSprite(GetResPath(88300231))
  View.Group_Type.Btn_GuKa.Img_RedPoint:SetActive(DataModel.GuKaUnReadCount > 0)
  View.Group_Type.Btn_GuKa.Group_Collect.Txt_Num:SetText(math.floor(DataModel.GuKaUnlockCount / DataModel.GuKaTotalCount * 100 + 0.5) .. "%")
  View.Group_Type.Btn_Event.Img_RedPoint:SetActive(0 < DataModel.EventUnReadCount)
  View.Group_Type.Btn_Event.Group_Collect.Txt_Num:SetText(math.floor(DataModel.EventUnlockCount / DataModel.EventTotalCount * 100 + 0.5) .. "%")
  View.Group_Type.Btn_Fireworks.Img_RedPoint:SetActive(0 < DataModel.SealUnReadCount)
  View.Group_Type.Btn_Fireworks.Group_Collect.Txt_Num:SetText(math.floor(DataModel.SealUnlockCount / DataModel.SealTotalCount * 100 + 0.5) .. "%")
  View.Group_Type.Btn_GuKa.Img_RedPoint:SetActive(DataModel.GuKaUnReadCount > 0)
  View.Group_Type.Btn_Fireworks.Img_RedPoint:SetActive(0 < DataModel.SealUnReadCount)
  View.Group_Type.Btn_Event.Img_RedPoint:SetActive(0 < DataModel.EventUnReadCount)
end

function Controller:OpenType()
  View.Group_Type:SetActive(true)
  View.Group_Fireworks:SetActive(false)
  View.Group_GuKa:SetActive(false)
  View.Group_Event:SetActive(false)
  View.self:PlayAnimOnce("GuKaHandbook_Group_Type")
end

function Controller:OpenGuKa()
  View.Group_Type:SetActive(false)
  View.Group_Fireworks:SetActive(false)
  View.Group_GuKa:SetActive(true)
  View.Group_Event:SetActive(false)
  Controller:RefreshGuKaElement()
  Controller:ShowGuKaInfo(1)
  View.Group_GuKa.Group_Collect.Txt_Num:SetText(math.floor(DataModel.GuKaUnlockCount / DataModel.GuKaTotalCount * 100 + 0.5) .. "%")
  View.self:PlayAnimOnce("GuKaHandbook_Group_GuKa")
end

function Controller:OpenFireworks()
  View.Group_Type:SetActive(false)
  View.Group_Fireworks:SetActive(true)
  View.Group_GuKa:SetActive(false)
  View.Group_Event:SetActive(false)
  Controller:RefreshFireworksElement()
  View.Group_Fireworks.Group_Collect.Txt_Num:SetText(math.floor(DataModel.SealUnlockCount / DataModel.SealTotalCount * 100 + 0.5) .. "%")
  View.self:PlayAnimOnce("GuKaHandbook_Group_Fireworks")
end

function Controller:OpenEvent()
  View.Group_Type:SetActive(false)
  View.Group_Fireworks:SetActive(false)
  View.Group_GuKa:SetActive(false)
  View.Group_Event:SetActive(true)
  Controller:RefreshEventElement()
  Controller:SelectEventTab(1)
  View.Group_Event.Group_Collect.Txt_Num:SetText(math.floor(DataModel.EventUnlockCount / DataModel.EventTotalCount * 100 + 0.5) .. "%")
  View.self:PlayAnimOnce("GuKaHandbook_Group_Event")
end

function Controller:SetGuKaElement(element, elementIndex)
  local data = DataModel.GuKaList[elementIndex]
  if not data then
    return
  end
  local cfg = PlayerData:GetFactoryData(data.id)
  element.Img_Select:SetActive(DataModel.CurSelectGuKaIdx == elementIndex)
  element.Img_SelectName:SetActive(DataModel.CurSelectGuKaIdx == elementIndex)
  element.Img_SelectName.Txt_Name:SetText(cfg.name)
  element.Img_:SetSprite(cfg.iconPath)
  element.Img_:SetActive(data.unlock == 1)
  element.Img_Seal:SetActive(data.unlock == 0)
  element.Img_RedPoint:SetActive(data.unlock == 1 and data.read == 0)
  element.Img_GuKaName.Txt_Name:SetText(cfg.name)
  element.Btn_:SetClickParam(elementIndex)
end

function Controller:RefreshGuKaElement()
  View.Group_GuKa.ScrollGrid_.grid.self:SetDataCount(#DataModel.GuKaList)
  View.Group_GuKa.ScrollGrid_.grid.self:RefreshAllElement()
end

function Controller:SetFireworksElement(element, elementIndex)
  local data = DataModel.SealList[elementIndex]
  element.Group_.Group_Unlock:SetActive(data.unlock == 1)
  element.Group_.Group_Lock:SetActive(data.unlock == 0)
  element.Group_.Group_Unlock.Img_RedPoint:SetActive(data.read == 0 and data.unlock == 1)
  element.Group_:SetAnchoredPositionY(elementIndex % 2 == 0 and -70 or 0)
  element.Group_.Btn_:SetClickParam(elementIndex)
  if data.unlock == 0 then
    return
  end
  local cfg = PlayerData:GetFactoryData(data.id)
  element.Group_.Group_Unlock.Group_Single:SetActive(cfg.typeInfo == "A")
  element.Group_.Group_Unlock.Group_Combination:SetActive(cfg.typeInfo ~= "A")
  element.Group_.Group_Unlock.Txt_Name:SetText(cfg.name)
  local skillCfg = PlayerData:GetFactoryData(data.skillId)
  element.Group_.Group_Unlock.Group_Attr.Group_Entry.Txt_Entry_1:SetText(skillCfg.description)
  if cfg.typeInfo ~= "A" then
    local sealList = cfg.combineSeal
    for i, v in ipairs(sealList) do
      local sealCfg = PlayerData:GetFactoryData(v.id)
      element.Group_.Group_Unlock.Group_Combination["Img_" .. i]:SetSprite(sealCfg.iconPath)
    end
  else
    local sealCfg = PlayerData:GetFactoryData(cfg.itemId)
    element.Group_.Group_Unlock.Group_Single.Img_1:SetSprite(sealCfg.iconPath)
  end
end

function Controller:RefreshFireworksElement()
  View.Group_Fireworks.ScrollGrid_.grid.self:SetDataCount(#DataModel.SealList)
  View.Group_Fireworks.ScrollGrid_.grid.self:RefreshAllElement()
end

function Controller:SetEventElement(element, elementIndex)
  local data = DataModel.EventList[elementIndex]
  element.Img_SelectBG:SetActive(DataModel.CurSelectEventIdx == elementIndex)
  element.Group_Unlock:SetActive(data.dialogList[1].unlock == 1 or data.dialogList[2].unlock == 1)
  element.Group_Unlock.Img_Mask:SetActive(DataModel.CurSelectEventIdx ~= elementIndex)
  element.Group_Lock:SetActive(data.dialogList[1].unlock == 0 and data.dialogList[2].unlock == 0)
  element.Group_Unlock.Img_RedPoint:SetActive(data.dialogList[1].unlock == 1 and data.dialogList[1].read == 0 or data.dialogList[2].unlock == 1 and data.dialogList[2].read == 0)
  element.Group_Unlock.Txt_Name:SetText(data.name)
  element.Group_Unlock.Img_Tab:SetSprite(data.tabPath)
  element.Btn_:SetClickParam(elementIndex)
end

function Controller:RefreshEventElement()
  View.Group_Event.ScrollGrid_List.grid.self:SetDataCount(#DataModel.EventList)
  View.Group_Event.ScrollGrid_List.grid.self:RefreshAllElement()
end

function Controller:SelectEventTab(idx)
  local data = DataModel.EventList[DataModel.CurSelectEventIdx]
  local dialogId = data.dialogList[idx].id
  local dialogCfg = PlayerData:GetFactoryData(dialogId)
  View.Group_Event.Group_Right.Group_Desc.ScrollView_Dec.Viewport.Txt_Desc:SetText(dialogCfg.dialogList[1].dialogContent)
  local npcId = PlayerData:GetFactoryData(data.dialogList[1].id).dialogList[1].eventNPC
  local npcCfg = PlayerData:GetFactoryData(npcId)
  local image = View.Group_Event.SoftMask_Character.Img_Source.Img_Character
  local spine = View.Group_Event.SoftMask_Character.Img_Source.Spine_Character
  if npcCfg.spineUrl == "" then
    image:SetActive(true)
    spine:SetActive(false)
    image:SetSprite(npcCfg.resUrl)
    image:SetAnchoredPositionX(npcCfg.offsetX)
    image:SetAnchoredPositionY(npcCfg.offsetY)
    image:SetMaterial(data.dialogList[idx].unlock == 1 and "" or "Shader/UI/UI-ImageGray")
  else
    image:SetActive(false)
    spine:SetActive(true)
    spine:SetData(npcCfg.spineUrl)
    spine:SetAction("idle", true, true)
    spine:SetAnchoredPositionX(npcCfg.spineOffsetX)
    spine:SetAnchoredPositionY(npcCfg.spineOffsetY)
    spine:SetLocalScale(Vector3(1, 1, 1) * npcCfg.spineScale)
    spine:SetMaterial(data.dialogList[idx].unlock == 1 and "Shader/Spine/SkeletonGraphicDefault" or "Shader/UI/UI-ImageGray")
  end
  View.Group_Event.Group_Right:SetActive(data.dialogList[idx].unlock == 1)
  View.Group_Event.Group_UnlockRight:SetActive(data.dialogList[idx].unlock == 0)
  View.Group_Event.Group_Right.Txt_FirstTitle:SetActive(idx == 1)
  View.Group_Event.Group_Right.Txt_AgainTitle:SetActive(idx == 2)
  View.Group_Event.Group_First.Img_Select:SetActive(idx == 1)
  View.Group_Event.Group_Again.Img_Select:SetActive(idx == 2)
  View.Group_Event.Group_First.Img_Lock:SetActive(data.dialogList[1].unlock == 0)
  View.Group_Event.Group_Again.Img_Lock:SetActive(data.dialogList[2].unlock == 0)
  local dialogData = data.dialogList[idx]
  if dialogData.unlock == 1 and dialogData.read == 0 then
    Net:SendProto("main.read", function(json)
      PlayerData.ServerData.user_witches.npc_handbook[tostring(dialogData.id)].read = 1
      DataModel.EventList[DataModel.CurSelectEventIdx].dialogList[idx].read = 1
      DataModel.EventUnReadCount = DataModel.EventUnReadCount - 1
      if DataModel.EventUnReadCount == 0 then
        View.Group_Type.Btn_Event.Img_RedPoint:SetActive(false)
      end
      Controller:RefreshEventElement()
    end, tostring(dialogData.id), "npc")
  end
end

function Controller:ShowGuKaInfo(idx)
  local data = DataModel.GuKaList[idx]
  if not data then
    return
  end
  DataModel.CurSelectGuKaIdx = idx
  Controller:RefreshGuKaElement()
  local cfg = PlayerData:GetFactoryData(data.id)
  View.Group_GuKa.Group_Right.Img_Tips:SetSprite(cfg.tipsPath)
  View.Group_GuKa.Group_Right.Txt_Name:SetText(cfg.name)
  View.Group_GuKa.Group_UnlockRight.Txt_Name:SetText(cfg.name)
  View.Group_GuKa.Group_Right.Group_Desc.Txt_Desc.Viewport.Content.Txt_Desc:SetText(cfg.longDes)
  if cfg.skillList and #cfg.skillList > 0 then
    local skillCfg = PlayerData:GetFactoryData(cfg.skillList[1].skillId)
    if skillCfg then
      if skillCfg.isPercent then
        local value = skillCfg.minAttrSN + skillCfg.digitSN * (data.lv - 1)
        value = value * 100
        View.Group_GuKa.Group_Right.Group_Attr.Group_Entry.Txt_Entry_1:SetText(string.format(skillCfg.description, value .. "%"))
      else
        View.Group_GuKa.Group_Right.Group_Attr.Group_Entry.Txt_Entry_1:SetText(string.format(skillCfg.description, skillCfg.minAttrSN + (data.lv - 1) * skillCfg.digitSN))
      end
    end
  else
    View.Group_GuKa.Group_Right.Group_Attr.Group_Entry.Txt_Entry_1:SetText("")
  end
  View.Group_GuKa.Group_UnlockRight:SetActive(data.unlock == 0)
  View.Group_GuKa.Group_Right:SetActive(data.unlock == 1)
  if data.read == 0 and data.unlock == 1 then
    Net:SendProto("main.read", function(json)
      PlayerData.ServerData.user_witches.guka[tostring(data.id)].read = 1
      DataModel.GuKaList[idx].read = 1
      DataModel.GuKaUnReadCount = DataModel.GuKaUnReadCount - 1
      if DataModel.GuKaUnReadCount == 0 then
        View.Group_Type.Btn_GuKa.Img_RedPoint:SetActive(false)
      end
      Controller:RefreshGuKaElement()
    end, tostring(data.id), "guka")
  end
end

function Controller:ShowEventInfo(idx)
  local data = DataModel.EventList[idx]
  if not data then
    return
  end
  DataModel.CurSelectEventIdx = idx
  Controller:RefreshEventElement()
  Controller:SelectEventTab(1)
end

function Controller:SelectFireworks(idx)
  local data = DataModel.SealList[idx]
  if not data then
    return
  end
  if data.read == 0 and data.unlock == 1 then
    Net:SendProto("main.read", function(json)
      PlayerData.ServerData.user_witches.seal_handbook[tostring(data.id)].read = 1
      DataModel.SealList[idx].read = 1
      DataModel.SealUnReadCount = DataModel.SealUnReadCount - 1
      if DataModel.SealUnReadCount == 0 then
        View.Group_Type.Btn_Fireworks.Img_RedPoint:SetActive(false)
      end
      Controller:RefreshFireworksElement()
    end, tostring(data.id), "seal")
  end
end

function Controller:ClickGuKaPrompt()
  View.Group_GuKa.Group_Collect.Img_PromptTxt:SetActive(not View.Group_GuKa.Group_Collect.Img_PromptTxt.self.IsActive)
end

function Controller:ClickFireworksPrompt()
  View.Group_Fireworks.Group_Collect.Img_PromptTxt:SetActive(not View.Group_GuKa.Group_Collect.Img_PromptTxt.self.IsActive)
end

function Controller:ClickEventPrompt()
  View.Group_Event.Group_Collect.Img_PromptTxt:SetActive(not View.Group_GuKa.Group_Collect.Img_PromptTxt.self.IsActive)
end

return Controller
