local TowerDefenseCtrl = class("TowerDefenseCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local InputManager = CS.InputManager.Instance
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local barMaxLength = 200
local bar_exp_minX = -98
local bar_exp_maxX = 106
local itemBarWidth = 215
local Time = CS.UnityEngine.Time
local cardAnimCD = 0.1
local ItemType = {
  None = 0,
  CD = 1,
  Count = 2,
  Charge = 3,
  CD_And_Count = 4
}
local DragType = {
  None = 1,
  Char = 2,
  Item = 3
}
local CardDragType = {
  None = 1,
  Drag = 2,
  Pointer = 3
}
local colorWhite = Color(0.792156862745098, 0.8274509803921568, 0.8666666666666667)
local colorRed = Color(0.7411764705882353, 0.18823529411764706, 0.34901960784313724)
TowerDefenseCtrl._mapNodeConfig = {
  animator = {
    sNodeName = "----Content-----",
    sComponentName = "Animator"
  },
  canvasGroup = {
    sNodeName = "----Content-----",
    sComponentName = "CanvasGroup"
  },
  btn_pause = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Pause",
    sAction = "Map"
  },
  btn_speed = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ChangeSpeed",
    sAction = "TowerDefFast"
  },
  btn_dic = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_OpenDic",
    sAction = "Depot",
    sActionIconType = "Dark"
  },
  txt_dic = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_DicTitle"
  },
  btn_release = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Release"
  },
  txt_monster = {sComponentName = "TMP_Text"},
  txt_hp = {sComponentName = "TMP_Text"},
  down = {
    sNodeName = "-----Down------",
    sComponentName = "RectTransform"
  },
  bg_Point = {},
  bg_Point2 = {},
  txt_pointTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Text_Point"
  },
  txt_pointValue = {sComponentName = "TMP_Text"},
  txt_point = {sComponentName = "TMP_Text"},
  pointAnim = {
    sNodeName = "txt_pointValue",
    sComponentName = "Animator"
  },
  icon_point = {
    sComponentName = "RectTransform"
  },
  go_bar = {
    sComponentName = "RectTransform"
  },
  icon_item = {sComponentName = "Image", nCount = 2},
  txt_itemValue = {sComponentName = "TMP_Text"},
  drag_item = {
    sNodeName = "icon_item1",
    sComponentName = "UIDrag",
    callback = "OnDrag_Item"
  },
  drag_itemIcon = {sNodeName = "drag_item", sComponentName = "Image"},
  img_cd = {
    sComponentName = "RectTransform"
  },
  txt_cd = {sComponentName = "TMP_Text"},
  go_item = {},
  cd_mask = {},
  img_disable = {},
  bg_Itembar = {},
  item_bar = {
    sComponentName = "RectTransform"
  },
  go_cardParent = {sComponentName = "Transform", nCount = 3},
  go_card1 = {},
  drag_card1 = {
    sNodeName = "go_card1",
    sComponentName = "UIDrag",
    callback = "OnDrag_CharacterCard"
  },
  go_card2 = {},
  drag_card2 = {
    sNodeName = "go_card2",
    sComponentName = "UIDrag",
    callback = "OnDrag_CharacterCard"
  },
  go_card3 = {},
  drag_card3 = {
    sNodeName = "go_card3",
    sComponentName = "UIDrag",
    callback = "OnDrag_CharacterCard"
  },
  go_backupCard = {nCount = 3},
  drag_area = {
    sNodeName = "Char_Item",
    sComponentName = "RectTransform"
  },
  img_item_null = {},
  icon_X1 = {},
  go_X2 = {},
  go_characterFunc = {
    sNodeName = "CharacterFunc",
    sCtrlName = "Game.UI.TowerDefense.TowerDefenseCharacterFuncCtrl"
  },
  pauseCtrl = {
    sNodeName = "PausePanel",
    sCtrlName = "Game.UI.TowerDefense.TowerDefensePauseCtrl"
  },
  potentialSelectPanel = {
    sNodeName = "TowerDefensePotentialSelectPanel",
    sCtrlName = "Game.UI.TowerDefense.TowerDefensePotentialSelectCtrl"
  },
  tipsPanel = {
    sNodeName = "TipsPanel",
    sCtrlName = "Game.UI.TowerDefense.TowerDefenseLevelTipsCtrl"
  },
  ActionBarSwitch = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  btnSwitchPosNext = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_SwitchPosNext"
  },
  btnSwitchPosPrev = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_SwitchPosPrev"
  },
  btnSwitchCharNext = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_SwitchCharNext"
  },
  btnSwitchCharPrev = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_SwitchCharPrev"
  },
  btnMoveCard1 = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_MoveMouse",
    sAction = "DpadLeft"
  },
  btnMoveCard2 = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_MoveMouse",
    sAction = "DpadUp"
  },
  btnMoveCard3 = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_MoveMouse",
    sAction = "DpadRight"
  },
  btnMoveItem = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_MoveMouse",
    sAction = "DpadDown"
  },
  bg_skill = {},
  skill_anim = {sNodeName = "bg_skill", sComponentName = "Animator"},
  img_SkillHead = {sComponentName = "Image"},
  skill = {
    sComponentName = "RectTransform"
  },
  txt_skill = {sComponentName = "TMP_Text"},
  txt_skillDes = {sComponentName = "TMP_Text"}
}
TowerDefenseCtrl._mapEventConfig = {
  TOWERDEFENSE_GIVE_A_ROLE_CARD = "OnEvent_GetCharacterCard",
  TOWERDEFENSE_SET_ROLE_ON_STAGE_RESULT = "OnEvent_UseCharacterCard",
  TOWERDEFENSE_UPDATE_LEVELUP = "OnEvent_LevelUpPointChange",
  TOWERDEFENSE_UPDATE_LEVEL_DURABILITTY = "OnEvent_DurabilittyChange",
  TOWERDEFENSE_UPDATE_MONSTER_NUM = "OnEvent_MonsterNumChange",
  TOWERDEFENSE_UPDATE_EXP = "OnEvent_ExpChange",
  TOWERDEFENSE_LEVEL_RESULT = "OnEvent_FinishGame",
  TOWERDEFENSE_SHOW_ROLE_ICON = "OnEvent_ShowCharacterIcon",
  TOWERDEFENSE_UPDATE_ITEM_CARD = "OnEvent_UpdateItemCard",
  TOWERDEFENSE_USE_ITEM_CARD_RESULT = "OnEvent_UseItemCard",
  TOWERDEFENSE_HOLDCARD = "OnEvent_HoldCard",
  TOWERDEFENSE_HOLDCARDCHANGE = "OnEvent_HoldCardChange",
  TOWERDEFENSE_SHOW_OPERATE_UI = "OnEvent_ShowPointUI",
  LoadLevelRefresh = "OnEvent_LoadFinish",
  TOWERDEFENSE_SHOW_TIP = "OnEvent_ShowTips",
  TOWERDEFENSE_HAS_DIC = "OnEvent_HasDic",
  TOWERDEFENSE_SHOW_DIC_TOPBAR = "OnEvent_OpenDic",
  [EventId.ClosePanel] = "OnEvent_CloseDic",
  TOWERDEFENSE_CHAR_LEVELUP = "OnEvent_CharLevelCallback",
  ADVENTURE_LEVEL_UNLOAD_COMPLETE = "OnEvent_UnloadComplete",
  TOWERDEFENSE_SHOW_MONSTER_INFO = "OnEvent_ShowMonsterTips",
  TowerDefense_Exit_OnClick = "OnEvent_Exit",
  TowerDefense_Restart_OnClick = "OnEvent_Restart",
  TowerDefense_Continue_OnClick = "OnEvent_Continue",
  TowerDefenseCharDetailPanelClose = "OnEvent_CloseCharDetailPanel",
  ResetEnergy = "OnEvent_UpdateEnergy",
  TowerDefenseShowFullScreenPanel = "OnEvent_OnPause",
  TowerDefenseShowHideScreenPanel = "OnEvent_OnResume",
  ActivityTowerDefenseLevelSettleFailed = "OnEvent_ActivityTowerDefenseLevelSettleFailed",
  TOWERDEFENSE_SHOW_ITEM_ENERGY = "OnEvent_ShowItemEnergy",
  TOWERDEFENSE_UPDATE_ITEM_ENERGY = "OnEvent_UpdateItemEnergy"
}
TowerDefenseCtrl._mapRedDotConfig = {}

function TowerDefenseCtrl:Awake()
  self.tbGamepadUINode = self:GetGamepadUINode()
  GamepadUIManager.AddGamepadUINode("TowerDefense", self.tbGamepadUINode)
  local tbConfig = {
    {
      sAction = "LeftPage",
      sAction2 = "RightPage",
      sLang = "TowerDef_Button_SwitchPos"
    },
    {
      sAction = "LeftTriger",
      sAction2 = "RightTriger",
      sLang = "TowerDef_Button_SwitchChar"
    }
  }
  self._mapNode.ActionBarSwitch:InitActionBar(tbConfig)
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.nLevelId = param[2]
  end
  self.TowerDefenseData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self:InitData()
  EventManager.Hit(EventId.BlockInput, true)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, false)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, false)
  self:ChangeGamepadUI(false)
  self.bInTimeLine = true
  self.bInCardCD = false
  self.tempCharCardList = {}
  self._mapNode.bg_skill:SetActive(false)
  self.bHasDic = false
  self.nDicId = 0
  self.nDragType = DragType.None
  self._mapNode.btn_dic.gameObject:SetActive(false)
end

function TowerDefenseCtrl:OnEnable()
  self:BindHander()
end

function TowerDefenseCtrl:OnDisable()
  self:UnbindHander()
end

function TowerDefenseCtrl:InitData()
  self.tbCharacterId = {}
  self.tbCardIndex = {
    [1] = self._mapNode.go_card1,
    [2] = self._mapNode.go_card2,
    [3] = self._mapNode.go_card3
  }
  self:SetCardParent(self._mapNode.go_card1, self._mapNode.go_cardParent[1], false, false)
  self:SetCardParent(self._mapNode.go_card2, self._mapNode.go_cardParent[2], false, false)
  self:SetCardParent(self._mapNode.go_card3, self._mapNode.go_cardParent[3], false, false)
  for i = 1, 3 do
    self:ShowCard(i)
  end
  for _, card in pairs(self._mapNode.go_backupCard) do
    card:SetActive(false)
  end
  self:SetTimeScale(false)
  self:UpdateSpeedIcon()
  self.dragIndex = 0
  self.tbCharacterList = {}
  self._mapNode.pauseCtrl:Close()
  self._mapNode.potentialSelectPanel:HidePanel()
  self._mapNode.txt_cd.gameObject:SetActive(false)
  self._mapNode.img_cd.gameObject:SetActive(false)
  self._mapNode.cd_mask.gameObject:SetActive(false)
  self._mapNode.go_item:SetActive(false)
  self._mapNode.go_characterFunc:SetData(self.TowerDefenseData.TowerDefenseLevelData)
  self._mapNode.potentialSelectPanel:SetData(self.nActId)
  self:InitDragAreaThreshold()
  self.point = 0
end

function TowerDefenseCtrl:InitDragAreaThreshold()
  self.DragThresholdMinX = 0
  self.DragThresholdMaxX = 0
  self.DragThresholdMinY = 0
  self.DragThresholdMaxY = 0
  local area = self._mapNode.drag_area
  self.DragThresholdMinX = -510
  self.DragThresholdMaxX = 180
  self.DragThresholdMinY = -120
  self.DragThresholdMaxY = 146
end

function TowerDefenseCtrl:CheckAddCardCD()
  if self.bInTimeLine then
    return
  end
  if self.bInCardCD then
    return
  end
  if #self.tempCharCardList <= 0 then
    return
  end
  local addData = self.tempCharCardList[1]
  table.remove(self.tempCharCardList, 1)
  self:AddCard(addData.index, addData.charId)
  self:AddTimer(1, 0.1, function()
    self:CheckAddCardCD()
  end, true, true, true)
end

function TowerDefenseCtrl:SetTimeScale(bSpeedUp)
  self.bSpeedUp = bSpeedUp
  if self.bSpeedUp then
    CS.AdventureModuleHelper.TowerDefense_SetTimeScale(150)
    WwiseAudioMgr:PostEvent("mode_TD_speedUp_setState")
  else
    CS.AdventureModuleHelper.TowerDefense_SetTimeScale(100)
    WwiseAudioMgr:PostEvent("mode_TD_speedNormal_setState")
  end
end

function TowerDefenseCtrl:SetSlowSpeed(bSlowSpeed)
  self.bSlowSpeedUp = bSlowSpeed
  if self.bSlowSpeedUp then
    CS.AdventureModuleHelper.TowerDefense_SetTimeScale(10)
    NovaAPI.DispatchEventWithData("TOWERDEFENSE_TIMESCALE_CHANGED", nil, {1})
    WwiseAudioMgr:PostEvent("mode_TD_slowDown_setState")
  else
    self:SetTimeScale(self.bSpeedUp)
    NovaAPI.DispatchEventWithData("TOWERDEFENSE_TIMESCALE_CHANGED", nil, {0})
  end
end

function TowerDefenseCtrl:SetCardParent(go_card, go_parent, bDoMove, bIsActive)
  go_card.transform:SetParent(go_parent.transform)
  local rectTransform = go_card:GetComponent("Transform")
  if bDoMove then
    rectTransform.anchoredPosition = Vector2.zero
    local animator = rectTransform:Find("AnimRoot"):GetComponent("Animator")
    animator:Play("Char_Card_move")
  else
    rectTransform.anchoredPosition = Vector2.zero
  end
  go_card:SetActive(bIsActive)
end

function TowerDefenseCtrl:AddCharacterCard(nCharacterId)
  if #self.tbCharacterId >= 6 then
    return
  end
  table.insert(self.tbCharacterList, nCharacterId)
  table.insert(self.tbCharacterId, nCharacterId)
  table.insert(self.tempCharCardList, {
    index = #self.tbCharacterId,
    charId = nCharacterId
  })
  self:CheckAddCardCD()
end

function TowerDefenseCtrl:UseCharacterCard(nCharacterId)
  local nIndex = table.indexof(self.tbCharacterId, nCharacterId)
  local nCharacterCount = #self.tbCharacterId
  table.remove(self.tbCharacterId, nIndex)
  self:UseCard(nIndex)
  if 3 < nCharacterCount then
    self:AddCard(3, self.tbCharacterId[3], true)
    self:RefreshBackupCard()
  end
end

function TowerDefenseCtrl:AddCard(nIndex, nCharacterId, bPlayBackupAnima)
  if nIndex <= 3 then
    local card = self.tbCardIndex[nIndex]
    local img_head = card.transform:Find("AnimRoot/icon_char")
    local txt_name = card.transform:Find("AnimRoot/txt_name")
    local characterConfig = ConfigTable.GetData("TowerDefenseCharacter", nCharacterId)
    if characterConfig == nil then
      return
    end
    NovaAPI.SetTMPText(txt_name:GetComponent("TMP_Text"), characterConfig.Name)
    if characterConfig.Icon ~= nil and characterConfig.Icon ~= "" then
      self:SetPngSprite(img_head:GetComponent("Image"), characterConfig.Icon .. AllEnum.CharHeadIconSurfix.QM)
    end
    self:ShowCard(nIndex)
    card:SetActive(true)
    local animator = card.transform:Find("AnimRoot"):GetComponent("Animator")
    if bPlayBackupAnima then
      animator:Play("Char_Card_move1")
    else
      animator:Play("Char_Card_in")
    end
  else
    local nBackupIndex = nIndex - 3
    self:ShowBackupCard(nBackupIndex, nCharacterId)
  end
end

function TowerDefenseCtrl:UseCard(nIndex)
  local tbMoveCard = {}
  if nIndex < 3 then
    for i = nIndex + 1, 3 do
      table.insert(tbMoveCard, {
        card = self.tbCardIndex[i],
        nNewIndex = i - 1
      })
    end
  end
  local card = self.tbCardIndex[nIndex]
  table.remove(self.tbCardIndex, nIndex)
  table.insert(self.tbCardIndex, card)
  self:SetCardParent(card, self._mapNode.go_cardParent[3], false, false)
  for _, value in ipairs(tbMoveCard) do
    self:SetCardParent(value.card, self._mapNode.go_cardParent[value.nNewIndex], true, value.card.activeSelf)
  end
end

function TowerDefenseCtrl:ShowCard(nIndex, bIsPlayAnim)
  if nIndex <= 0 or nIndex > #self.tbCardIndex then
    return
  end
  local goCard = self.tbCardIndex[nIndex]
  local rectTran = goCard.transform:GetComponent("RectTransform")
  rectTran.anchoredPosition = Vector2.zero
  local canvasGroup = goCard.transform:GetComponent("CanvasGroup")
  NovaAPI.SetCanvasGroupAlpha(canvasGroup, 1)
  NovaAPI.SetCanvasGroupInteractable(canvasGroup, true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(canvasGroup, true)
  if bIsPlayAnim then
    local animator = goCard.transform:Find("AnimRoot"):GetComponent("Animator")
    animator:Play("Char_Card_out")
  end
end

function TowerDefenseCtrl:HideCard(nIndex)
  local goCard = self.tbCardIndex[nIndex]
  local canvasGroup = goCard.transform:GetComponent("CanvasGroup")
  NovaAPI.SetCanvasGroupAlpha(canvasGroup, 0)
  NovaAPI.SetCanvasGroupInteractable(canvasGroup, false)
  NovaAPI.SetCanvasGroupBlocksRaycasts(canvasGroup, false)
end

function TowerDefenseCtrl:ShowBackupCard(nIndex, nCharacterId)
  local card = self._mapNode.go_backupCard[nIndex]
  local img_head = card.transform:Find("AnimRoot/icon_char")
  local mask_head = card.transform:Find("AnimRoot/mask_char")
  local characterConfig = ConfigTable.GetData("TowerDefenseCharacter", nCharacterId)
  if characterConfig == nil then
    return
  end
  if characterConfig.Icon ~= nil and characterConfig.Icon ~= "" then
    self:SetPngSprite(img_head:GetComponent("Image"), characterConfig.Icon .. AllEnum.CharHeadIconSurfix.QM)
  end
  if characterConfig.Icon ~= nil and characterConfig.Icon ~= "" then
    self:SetPngSprite(mask_head:GetComponent("Image"), characterConfig.Icon .. AllEnum.CharHeadIconSurfix.QM)
  end
  card:SetActive(true)
  local animator = card.transform:Find("AnimRoot"):GetComponent("Animator")
  animator:Play("Char_Card_in1")
end

function TowerDefenseCtrl:RefreshBackupCard()
  for i = 1, 3 do
    self:HideBackupCard(i)
  end
  if 3 < #self.tbCharacterId then
    for i = 4, #self.tbCharacterId do
      self:ShowBackupCard(i - 3, self.tbCharacterId[i])
    end
  end
end

function TowerDefenseCtrl:HideBackupCard(nIndex)
  self._mapNode.go_backupCard[nIndex]:SetActive(false)
end

function TowerDefenseCtrl:UpdateSpeedIcon()
  self._mapNode.icon_X1:SetActive(not self.bSpeedUp)
  self._mapNode.go_X2:SetActive(self.bSpeedUp)
end

function TowerDefenseCtrl:UpdateExp(curExp, maxExp)
  self._mapNode.go_bar.anchoredPosition = Vector2(bar_exp_minX + curExp / maxExp * (bar_exp_maxX - bar_exp_minX), 0)
end

function TowerDefenseCtrl:ShowSkillDes(bIsShow, nCharId)
  if self.skillTimer ~= nil then
    self.skillTimer:_Stop()
  end
  if bIsShow then
    local config = ConfigTable.GetData("TowerDefenseCharacter", nCharId)
    if config == nil then
      return
    end
    if config.Icon ~= "" then
      self:SetPngSprite(self._mapNode.img_SkillHead, config.Icon .. AllEnum.CharHeadIconSurfix.QM)
    end
    local skillConfig = ConfigTable.GetData("Skill", config.SkillId)
    if skillConfig == nil then
      return
    end
    NovaAPI.SetTMPText(self._mapNode.txt_skill, orderedFormat(ConfigTable.GetUIText("TowerDef_SkillInfo"), config.Name))
    NovaAPI.SetTMPText(self._mapNode.txt_skillDes, skillConfig.Desc)
    self._mapNode.bg_skill:SetActive(true)
    self._mapNode.skill_anim:Play("TowerDefensePanel_bg_skill_in")
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.bg_skill.transform)
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.skill)
  else
    if self._mapNode.bg_skill.activeSelf == false then
      return
    end
    self._mapNode.skill_anim:Play("TowerDefensePanel_bg_skill_out")
    self.skillTimer = self:AddTimer(1, 0.2, function()
      self._mapNode.bg_skill:SetActive(false)
    end, true, true, true)
  end
end

function TowerDefenseCtrl:ChangeGamepadUI(bEnable)
  for _, v in pairs(self.tbGamepadUINode) do
    if v.mapNode.gameObject.name == "btn_dic" then
      v.mapNode.gameObject:SetActive(bEnable and self.nDicId ~= 0)
    else
      v.mapNode.gameObject:SetActive(bEnable)
    end
  end
end

function TowerDefenseCtrl:BindHander()
  self.handlerEnter, self.handlerExit, self.handlerDown = {}, {}, {}
  for i = 1, 3 do
    local comp = self._mapNode["drag_card" .. i]
    self.handlerEnter[i] = ui_handler(self, self.OnPointerEnter_CharacterCard, comp, i)
    comp.onPointerEnter:AddListener(self.handlerEnter[i])
    self.handlerExit[i] = ui_handler(self, self.OnPointerExit_CharacterCard, comp, i)
    comp.onPointerExit:AddListener(self.handlerExit[i])
    self.handlerDown[i] = ui_handler(self, self.OnPointerDown_CharacterCard, comp, i)
    comp.onPointerDown:AddListener(self.handlerDown[i])
  end
  self.handlerItemEnter = ui_handler(self, self.OnPointerEnter_Item, self._mapNode.drag_item)
  self._mapNode.drag_item.onPointerEnter:AddListener(self.handlerItemEnter)
  self.handlerItemExit = ui_handler(self, self.OnPointerExit_Item, self._mapNode.drag_item)
  self._mapNode.drag_item.onPointerExit:AddListener(self.handlerItemExit)
  self.handlerItemDown = ui_handler(self, self.OnPointerDown_Item, self._mapNode.drag_item)
  self._mapNode.drag_item.onPointerDown:AddListener(self.handlerItemDown)
end

function TowerDefenseCtrl:UnbindHander()
  for i = 1, 3 do
    local comp = self._mapNode["drag_card" .. i]
    comp.onPointerEnter:RemoveListener(self.handlerEnter[i])
    comp.onPointerExit:RemoveListener(self.handlerExit[i])
    comp.onPointerDown:RemoveListener(self.handlerDown[i])
  end
  self._mapNode.drag_item.onPointerEnter:RemoveListener(self.handlerItemEnter)
  self._mapNode.drag_item.onPointerExit:RemoveListener(self.handlerItemExit)
  self._mapNode.drag_item.onPointerDown:RemoveListener(self.handlerItemDown)
end

function TowerDefenseCtrl:OnPointerEnter_CharacterCard(go, index)
  NovaAPI.DispatchEventWithData("TOWERDEFENSE_CARDPOINTENTER")
end

function TowerDefenseCtrl:OnPointerExit_CharacterCard(go, index)
  NovaAPI.DispatchEventWithData("TOWERDEFENSE_CARDPOINTEXIT")
end

function TowerDefenseCtrl:OnPointerEnter_Item(go)
  NovaAPI.DispatchEventWithData("TOWERDEFENSE_CARDPOINTENTER")
end

function TowerDefenseCtrl:OnPointerExit_Item(go)
  NovaAPI.DispatchEventWithData("TOWERDEFENSE_CARDPOINTEXIT")
end

function TowerDefenseCtrl:OnPointerDown_CharacterCard(go, nIndex)
  if self.goPointChar and self.dragCharacterId ~= 0 and self.CardDragType == CardDragType.Pointer then
    NovaAPI.DispatchEventWithData("TOWERDEFENSE_CANCEL_DRAG_STATE")
    self.goPointChar = nil
    self:SetSlowSpeed(false)
    WwiseAudioMgr:PostEvent("mode_TD_card_drag_end")
    self:ShowSkillDes(false)
    self:SetDragState(DragType.None)
    self.CardDragType = CardDragType.None
    return
  end
  self.goPointChar = go.gameObject
  self:HideFuncIcon()
  self:SetSlowSpeed(false)
end

function TowerDefenseCtrl:OnPointerDown_Item(go)
  if self.bPointItem and self.CardDragType == CardDragType.Pointer then
    self._mapNode.drag_itemIcon.gameObject:SetActive(false)
    NovaAPI.DispatchEventWithData("TOWERDEFENSE_CANCEL_DRAG_STATE")
    self.bPointItem = false
    self:SetDragState(DragType.None)
    self.CardDragType = CardDragType.None
    return
  end
  self.bPointItem = true
  self:HideFuncIcon()
  self:SetSlowSpeed(false)
end

function TowerDefenseCtrl:OnEvent_HoldCard(pos)
  if self.CardDragType ~= CardDragType.Pointer then
    return
  end
  if self.nDragType == DragType.Char and self.goPointChar then
    local go_drag = self.goPointChar
    local index = table.indexof(self.tbCardIndex, go_drag)
    self:SetDragState(DragType.Char, index)
    self.dragCharacterId = self.tbCharacterId[index]
    local uipos = GameUIUtils.ScreenPointToLocalPointInRectangle(pos, self.goPointChar.transform.parent.transform.parent.transform)
    if not self.bOutArea and (uipos.x < self.DragThresholdMinX or uipos.x > self.DragThresholdMaxX or uipos.y < self.DragThresholdMinY or uipos.y > self.DragThresholdMaxY) then
      self.bOutArea = true
      self:HideCard(index)
      NovaAPI.DispatchEventWithData("TOWERDEFENSE_CARDOUTAREA", nil, {
        self.tbCharacterId[index]
      })
    end
    local new_uipos = GameUIUtils.ScreenPointToLocalPointInRectangle(pos, self.goPointChar.transform.parent.transform)
    local rectTra = self.goPointChar:GetComponent("RectTransform")
    rectTra.anchoredPosition = Vector2(new_uipos.x, new_uipos.y)
    return
  end
  if self.nDragType == DragType.Item and self.bPointItem then
    if (self.ItemType == ItemType.Count or self.ItemType == ItemType.CD_And_Count) and self.nItemCount == 0 then
      return
    end
    self:SetDragState(DragType.Item)
    self._mapNode.drag_itemIcon.gameObject:SetActive(true)
    local uipos = GameUIUtils.ScreenPointToLocalPointInRectangle(pos, self._mapNode.drag_itemIcon.gameObject.transform.parent.transform)
    local rectTra = self._mapNode.drag_itemIcon.gameObject:GetComponent("RectTransform")
    rectTra.anchoredPosition = Vector2(uipos.x, uipos.y)
    NovaAPI.DispatchEventWithData("TOWERDEFENSE_DRAG_ITEMCARD_BEGIN")
    return
  end
end

function TowerDefenseCtrl:OnEvent_HoldCardChange(bHold)
  if bHold then
    self.bOutArea = false
    if self.nDragType == DragType.None then
      if self.goPointChar ~= nil then
        WwiseAudioMgr:PostEvent("mode_TD_card_drag")
        local index = table.indexof(self.tbCardIndex, self.goPointChar)
        self:SetDragState(DragType.Char, index)
        self:ShowSkillDes(true, self.tbCharacterId[index])
        self:SetSlowSpeed(true)
        self.CardDragType = CardDragType.Pointer
      end
      if self.bPointItem then
        WwiseAudioMgr:PostEvent("mode_TD_item_drag")
        self:SetDragState(DragType.Item)
        self:SetSlowSpeed(true)
        self.CardDragType = CardDragType.Pointer
      end
    end
  else
    if not self.bOutArea and self.nDragType == DragType.Char then
      local go_drag = self.goPointChar
      local index = table.indexof(self.tbCardIndex, go_drag)
      self:ShowCard(index)
      WwiseAudioMgr:PostEvent("mode_TD_card_drag_end")
      self:SetSlowSpeed(false)
      self:ShowSkillDes(false)
      self:SetDragState(DragType.None)
      self.CardDragType = CardDragType.None
    end
    if self.nDragType == DragType.Item then
      self._mapNode.drag_itemIcon.gameObject:SetActive(false)
      WwiseAudioMgr:PostEvent("mode_TD_item_drag_end")
      self:SetSlowSpeed(false)
      self:SetDragState(DragType.None)
      self.CardDragType = CardDragType.None
      self.bPointItem = false
      NovaAPI.DispatchEventWithData("TOWERDEFENSE_CANCEL_DRAG_STATE")
    end
  end
end

function TowerDefenseCtrl:OnDrag_CharacterCard(mDrag)
  if self.CardDragType == CardDragType.Pointer then
    return
  end
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.CardDragType = CardDragType.Drag
    self:HideFuncIcon()
    self.bOutArea = false
    local go_drag = mDrag.gameObject
    local index = table.indexof(self.tbCardIndex, go_drag)
    self.dragCharacterId = self.tbCharacterId[index]
    WwiseAudioMgr:PostEvent("mode_TD_card_drag")
    self:SetSlowSpeed(true)
    self:ShowSkillDes(true, self.dragCharacterId)
    self:SetDragState(DragType.Char, index)
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    local uipos = GameUIUtils.ScreenPointToLocalPointInRectangle(mDrag.EventData.position, mDrag.gameObject.transform.parent.transform.parent.transform)
    if not self.bOutArea and (uipos.x < self.DragThresholdMinX or uipos.x > self.DragThresholdMaxX or uipos.y < self.DragThresholdMinY or uipos.y > self.DragThresholdMaxY) then
      self.bOutArea = true
      local go_drag = mDrag.gameObject
      local index = table.indexof(self.tbCardIndex, go_drag)
      self:HideCard(index)
      NovaAPI.DispatchEventWithData("TOWERDEFENSE_CARDOUTAREA", nil, {
        self.tbCharacterId[index]
      })
    end
    local new_uipos = GameUIUtils.ScreenPointToLocalPointInRectangle(mDrag.EventData.position, mDrag.gameObject.transform.parent.transform)
    local rectTra = mDrag.gameObject:GetComponent("RectTransform")
    rectTra.anchoredPosition = Vector2(new_uipos.x, new_uipos.y)
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    if not self.bOutArea then
      local go_drag = mDrag.gameObject
      local index = table.indexof(self.tbCardIndex, go_drag)
      self:ShowCard(index)
      WwiseAudioMgr:PostEvent("mode_TD_card_drag_end")
    end
    self:SetSlowSpeed(false)
    self:ShowSkillDes(false)
    self:SetDragState(DragType.None)
    self.CardDragType = CardDragType.None
  end
end

function TowerDefenseCtrl:OnDrag_Item(mDrag)
  if (self.ItemType == ItemType.Count or self.ItemType == ItemType.CD_And_Count) and self.nItemCount == 0 then
    return
  end
  if self.CardDragType == CardDragType.Pointer then
    return
  end
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.CardDragType = CardDragType.Drag
    self:HideFuncIcon()
    self._mapNode.drag_itemIcon.gameObject:SetActive(true)
    local uipos = GameUIUtils.ScreenPointToLocalPointInRectangle(mDrag.EventData.position, mDrag.gameObject.transform.parent.transform)
    local rectTra = self._mapNode.drag_itemIcon.gameObject:GetComponent("RectTransform")
    rectTra.anchoredPosition = Vector2(uipos.x, uipos.y)
    NovaAPI.DispatchEventWithData("TOWERDEFENSE_DRAG_ITEMCARD_BEGIN")
    self:SetSlowSpeed(true)
    WwiseAudioMgr:PostEvent("mode_TD_item_drag")
    self:SetDragState(DragType.Item)
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    local uipos = GameUIUtils.ScreenPointToLocalPointInRectangle(mDrag.EventData.position, mDrag.gameObject.transform.parent.transform)
    local rectTra = self._mapNode.drag_itemIcon.gameObject:GetComponent("RectTransform")
    rectTra.anchoredPosition = Vector2(uipos.x, uipos.y)
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    self._mapNode.drag_itemIcon.gameObject:SetActive(false)
    self:SetSlowSpeed(false)
    self:SetDragState(DragType.None)
    self.CardDragType = CardDragType.None
  end
end

function TowerDefenseCtrl:CharacterLevelUp(characterId)
  NovaAPI.DispatchEventWithData("TowerDefenseSelectedBtn", nil, {})
  local oldLevel = self.TowerDefenseData.TowerDefenseLevelData:GetCharacterLevel(characterId)
  local config = ConfigTable.GetData("TowerDefenseCharacter", characterId)
  if config == nil then
    return
  end
  local nPointNeeded = config.PointNeeded[oldLevel]
  if nPointNeeded == nil or nPointNeeded > self.point then
    return
  end
  self.TowerDefenseData.TowerDefenseLevelData:CharacterLevelUp(characterId)
  local nLevel = self.TowerDefenseData.TowerDefenseLevelData:GetCharacterLevel(characterId)
  if config["NewPotential" .. nLevel] == nil or #config["NewPotential" .. nLevel] == 0 then
    return
  end
  local bSelectPotential = false
  if #config["NewPotential" .. nLevel] == 1 then
    bSelectPotential = false
    self.TowerDefenseData.TowerDefenseLevelData:AddPotential(characterId, config["NewPotential" .. nLevel][1])
  else
    bSelectPotential = true
    
    local function cb(potentialId)
      self.TowerDefenseData.TowerDefenseLevelData:AddPotential(characterId, potentialId)
      self._mapNode.potentialSelectPanel:HidePanel()
      self:ResumeLogic()
      NovaAPI.DispatchEventWithData("TOWERDEFENSE_SELECTED_POTENTIAL", nil, {})
    end
    
    self:PauseLogic()
    self._mapNode.potentialSelectPanel:ShowPanel()
    self._mapNode.potentialSelectPanel:Refresh(characterId, config["NewPotential" .. nLevel], nLevel, cb)
  end
  local Rect_Txt = self._mapNode.txt_pointValue:GetComponent("RectTransform")
  Rect_Txt:SetParent(self._mapNode.down)
  local screenPos = Rect_Txt.anchoredPosition
  Rect_Txt:SetParent(self._mapNode.bg_Point.transform)
  NovaAPI.DispatchEventWithData("TOWERDEFENSE_CHARACTER_LEVELUP", nil, {
    characterId,
    nLevel,
    screenPos.x,
    screenPos.y,
    bSelectPotential
  })
end

function TowerDefenseCtrl:ShowCharacterDetail(characterId)
  NovaAPI.DispatchEventWithData("TowerDefenseSelectedBtn", nil, {})
  local tbChar = {}
  for _, data in pairs(self.TowerDefenseData.TowerDefenseLevelData.tbCharacterData) do
    table.insert(tbChar, data.nCharacterId)
  end
  self:PauseLogic()
  EventManager.Hit(EventId.OpenPanel, PanelId.TowerDefenseCharacterDetailPanel, tbChar, characterId, self.TowerDefenseData.TowerDefenseLevelData)
end

function TowerDefenseCtrl:CharacterHenshin(characterId)
  NovaAPI.DispatchEventWithData("TowerDefenseSelectedBtn", nil, {})
  local config = ConfigTable.GetData("TowerDefenseCharacter", characterId)
  if config == nil then
    return
  end
  if not config.IsShapeshifter then
    return
  end
  local nLevel = 4
  
  local function cb(potentialId)
    self.TowerDefenseData.TowerDefenseLevelData:RemoveCharacterPotential(characterId, nLevel)
    self.TowerDefenseData.TowerDefenseLevelData:AddPotential(characterId, potentialId)
    self._mapNode.potentialSelectPanel:HidePanel()
    self:ResumeLogic()
    NovaAPI.DispatchEventWithData("TOWERDEFENSE_SELECTED_POTENTIAL", nil, {})
  end
  
  self:PauseLogic()
  local sTitle = ConfigTable.GetUIText("TowerDef_Text_Henshin")
  self._mapNode.potentialSelectPanel:ShowPanel()
  self._mapNode.potentialSelectPanel:Refresh(characterId, config["NewPotential" .. nLevel], nLevel, cb, sTitle)
end

function TowerDefenseCtrl:PauseLogic()
  PanelManager.InputDisable()
  NovaAPI.DispatchEventWithData("TowerDefenseShowFullScreenPanel", nil, {})
  EventManager.Hit("TowerDefenseShowFullScreenPanel")
  self._mapNode.drag_card1:DoDragEnd()
  self._mapNode.drag_card2:DoDragEnd()
  self._mapNode.drag_card3:DoDragEnd()
  self._mapNode.drag_item:DoDragEnd()
  self.goPointChar = nil
  self.bPointItem = false
  WwiseAudioMgr:PostEvent("mode_TD_speedNormal_setState")
end

function TowerDefenseCtrl:ResumeLogic(bDisActiveUICombat)
  PanelManager.InputEnable(nil, bDisActiveUICombat)
  NovaAPI.DispatchEventWithData("TowerDefenseShowHideScreenPanel", nil, {})
  EventManager.Hit("TowerDefenseShowHideScreenPanel")
  if self.bSpeedUp then
    WwiseAudioMgr:PostEvent("mode_TD_speedUp_setState")
  else
    WwiseAudioMgr:PostEvent("mode_TD_speedNormal_setState")
  end
end

function TowerDefenseCtrl:SetPointText(value)
  NovaAPI.SetTMPText(self._mapNode.txt_point, tostring(value))
  if value == 0 then
    NovaAPI.SetTMPColor(self._mapNode.txt_point, colorRed)
  else
    NovaAPI.SetTMPColor(self._mapNode.txt_point, colorWhite)
  end
end

function TowerDefenseCtrl:SetDragState(nType, nCharIndex)
  self.nDragType = nType
  if nType == DragType.None then
    for _, go_card in ipairs(self.tbCardIndex) do
      local canvasGroup = go_card:GetComponent("CanvasGroup")
      NovaAPI.SetCanvasGroupBlocksRaycasts(canvasGroup, true)
    end
    local itemCanvasGroup = self._mapNode.go_item:GetComponent("CanvasGroup")
    NovaAPI.SetCanvasGroupBlocksRaycasts(itemCanvasGroup, true)
  elseif nType == DragType.Char then
    for index, go_card in ipairs(self.tbCardIndex) do
      local canvasGroup = go_card:GetComponent("CanvasGroup")
      if index == nCharIndex then
      else
        NovaAPI.SetCanvasGroupBlocksRaycasts(canvasGroup, false)
      end
    end
    local itemCanvasGroup = self._mapNode.go_item:GetComponent("CanvasGroup")
    NovaAPI.SetCanvasGroupBlocksRaycasts(itemCanvasGroup, false)
  elseif nType == DragType.Item then
    for _, go_card in ipairs(self.tbCardIndex) do
      local canvasGroup = go_card:GetComponent("CanvasGroup")
      NovaAPI.SetCanvasGroupBlocksRaycasts(canvasGroup, false)
    end
  end
end

function TowerDefenseCtrl:HideFuncIcon()
  self.ShowFuncCharId = -1
  self._mapNode.go_characterFunc:HideIcon()
  self._mapNode.btn_release.gameObject:SetActive(true)
end

function TowerDefenseCtrl:OnBtnClick_ChangeSpeed()
  self:SetTimeScale(not self.bSpeedUp)
  self:UpdateSpeedIcon()
end

function TowerDefenseCtrl:OnEvent_GetCharacterCard(nCharacterId, bShowTips)
  self:AddCharacterCard(nCharacterId)
  if bShowTips then
    self._mapNode.tipsPanel:AddQueue(nCharacterId, 1)
  end
end

function TowerDefenseCtrl:OnEvent_UseCharacterCard(bUse, nEntityId, nCharacterId, screenPos)
  print("OnEvent_UseCharacterCard:", tostring(bUse) .. "," .. "nCharacterId:" .. tostring(nCharacterId))
  self:SetSlowSpeed(false)
  self:ShowSkillDes(false)
  if bUse then
    local uiPos = GameUIUtils.ScreenPointToLocalPointInRectangle(Vector2(screenPos.x, screenPos.y), self.gameObject.transform)
    self._mapNode.go_characterFunc:BindFuncIcon(nCharacterId, uiPos, function()
      self:ShowCharacterDetail(nCharacterId)
    end, function()
      self:CharacterLevelUp(nCharacterId)
    end, function()
      self:CharacterHenshin(nCharacterId)
    end)
    self:UseCharacterCard(nCharacterId)
    self.TowerDefenseData.TowerDefenseLevelData:AddCharacter(nCharacterId, nEntityId)
    EventManager.Hit("TowerDefensePointChange", self.point)
  else
    local nIndex = table.indexof(self.tbCharacterId, self.dragCharacterId)
    self:ShowCard(nIndex, true)
    WwiseAudioMgr:PostEvent("mode_TD_card_drag_end")
  end
  self.dragCharacterId = 0
  self.bPointItem = false
  self.goPointChar = nil
  self.CardDragType = CardDragType.None
  self:SetDragState(DragType.None)
end

function TowerDefenseCtrl:OnEvent_ExpChange(curExp, maxExp)
  self:UpdateExp(curExp, maxExp)
end

function TowerDefenseCtrl:OnEvent_LevelUpPointChange(point, remainPoint)
  local bIsAdd = point > self.point
  self.point = point
  NovaAPI.SetTMPText(self._mapNode.txt_pointValue, tostring(point))
  if bIsAdd then
    self._mapNode.pointAnim:Play("txt_pointValue_in")
  end
  if remainPoint ~= nil then
    self:SetPointText(remainPoint)
  end
  EventManager.Hit("TowerDefensePointChange", point)
end

function TowerDefenseCtrl:OnEvent_DurabilittyChange(curValue, maxValue)
  self.nCurHp = curValue
  NovaAPI.SetTMPText(self._mapNode.txt_hp, tostring(curValue) .. "/" .. tostring(maxValue))
end

function TowerDefenseCtrl:OnEvent_MonsterNumChange(curValue, maxValue)
  NovaAPI.SetTMPText(self._mapNode.txt_monster, tostring(curValue) .. "/" .. tostring(maxValue))
end

function TowerDefenseCtrl:OnEvent_FinishGame(bResult)
  self:SetTimeScale(false)
  self:PauseLogic()
  local bIsInActivityTime = self.TowerDefenseData:CheckActivityOpen()
  if not bIsInActivityTime then
    bResult = false
  end
  
  local function requestCb(star, newStar, msgData)
    local function cb()
      EventManager.Hit(EventId.ClosePanel, PanelId.TowerDefenseHUD)
      
      self:ResumeLogic(true)
    end
    
    local config = ConfigTable.GetData("TowerDefenseLevel", self.nLevelId)
    if config == nil then
      return
    end
    local sLevelName = config.LevelName
    local tbTarget = {}
    for i = 1, 3 do
      local result = false
      if bResult then
        result = i <= star
      end
      table.insert(tbTarget, {
        sTargetDes = config["Des" .. i],
        bResult = result
      })
    end
    EventManager.Hit(EventId.OpenPanel, PanelId.TowerDefenseResultPanel, bResult, sLevelName, tbTarget, cb, msgData, star)
  end
  
  self.TowerDefenseData:RequestFinishLevel(self.nLevelId, bResult, self.nCurHp, requestCb)
  if bResult then
    WwiseAudioMgr:PostEvent("ui_roguelike_challenge_firework")
  end
end

function TowerDefenseCtrl:OnEvent_ShowCharacterIcon(characterId, bIsShow)
  print("OnEvent_ShowCharacterIcon:", tostring(characterId) .. "  isShow:" .. tostring(bIsShow))
  local characterData = self.TowerDefenseData.TowerDefenseLevelData:GetCharacterData(characterId)
  if bIsShow and characterData == nil then
    return
  end
  if bIsShow then
    self.ShowFuncCharId = characterId
    self._mapNode.btn_release.gameObject:SetActive(false)
    self._mapNode.go_characterFunc:ShowIcon(characterId)
    self:SetSlowSpeed(true)
    WwiseAudioMgr:PostEvent("mode_TD_menu")
  else
    if self.ShowFuncCharId == -1 then
      return
    end
    self.ShowFuncCharId = 0
    self._mapNode.go_characterFunc:HideIcon()
    self._mapNode.btn_release.gameObject:SetActive(true)
    self:SetSlowSpeed(false)
  end
end

function TowerDefenseCtrl:OnEvent_UpdateItemCard(nItemId, nCount)
  self.nItemId = nItemId
  self.nItemCount = nCount
  self._mapNode.drag_itemIcon.gameObject:SetActive(false)
  self._mapNode.img_disable:SetActive(false)
  if nItemId == 0 then
    self._mapNode.go_item:SetActive(false)
    return
  end
  self._mapNode.go_item:SetActive(true)
  local itemConfig = ConfigTable.GetData("TowerDefenseItem", self.nItemId)
  if itemConfig == nil then
    return
  end
  if 0 < itemConfig.Amount and 0 < itemConfig.Cd then
    self.ItemType = ItemType.CD_And_Count
  elseif 0 < itemConfig.Amount then
    self.ItemType = ItemType.Count
  elseif 0 < itemConfig.Cd then
    self.ItemType = ItemType.CD
  else
    self.ItemType = ItemType.None
  end
  if itemConfig.CardIcon ~= nil and itemConfig.CardIcon ~= "" then
    for _, icon in pairs(self._mapNode.icon_item) do
      self:SetPngSprite(icon, itemConfig.CardIcon)
    end
  end
  if itemConfig.Head ~= nil and itemConfig.Head ~= "" then
    self:SetPngSprite(self._mapNode.drag_itemIcon, itemConfig.Head)
  end
  if self.ItemType == ItemType.CD_And_Count or self.ItemType == ItemType.Count then
    self._mapNode.txt_itemValue.gameObject:SetActive(true)
    self._mapNode.img_disable:SetActive(nCount <= 0)
    if nCount <= 0 then
      if self.tweener ~= nil then
        self.tweener:Kill()
      end
      self._mapNode.txt_cd.gameObject:SetActive(false)
      self._mapNode.img_cd.gameObject:SetActive(false)
      self._mapNode.cd_mask.gameObject:SetActive(false)
    end
  else
    self._mapNode.txt_itemValue.gameObject:SetActive(0 < nCount)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_itemValue, "x" .. tostring(nCount))
  self._mapNode.go_item:SetActive(true)
end

function TowerDefenseCtrl:OnEvent_UseItemCard(bResult)
  if bResult then
    local itemConfig = ConfigTable.GetData("TowerDefenseItem", self.nItemId)
    if itemConfig == nil then
      return
    end
    if self.tweener ~= nil then
      self.tweener:Kill()
    end
    self.nItemCD = itemConfig.Cd
    EventManager.Hit("TowerDefenseGM_QueryFastCD", self)
    if self.ItemType == ItemType.CD_And_Count or self.ItemType == ItemType.CD and self.nItemCD > 0 then
      self.tweener = DOTween.To(function()
        return self.nItemCD
      end, function(v)
        NovaAPI.SetTMPText(self._mapNode.txt_cd, string.format("%.1f", v))
        self._mapNode.img_cd.sizeDelta = Vector2(self._mapNode.img_cd.sizeDelta.x, 259 * (v / self.nItemCD))
      end, 0, self.nItemCD):OnComplete(function()
        self._mapNode.txt_cd.gameObject:SetActive(false)
        self._mapNode.img_cd.gameObject:SetActive(false)
        self._mapNode.cd_mask.gameObject:SetActive(false)
      end)
      self._mapNode.txt_cd.gameObject:SetActive(true)
      self._mapNode.img_cd.gameObject:SetActive(true)
      self._mapNode.cd_mask.gameObject:SetActive(true)
    end
  else
    WwiseAudioMgr:PostEvent("mode_TD_item_drag_end")
  end
  self:SetSlowSpeed(false)
  self:SetDragState(DragType.None)
  self.CardDragType = CardDragType.None
  self.bPointItem = false
  self.goPointChar = nil
  self._mapNode.drag_itemIcon.gameObject:SetActive(false)
end

function TowerDefenseCtrl:OnEvent_Exit()
  local function confirmCallback()
    self._mapNode.pauseCtrl:Close()
    
    self:SetTimeScale(false)
    
    local function requestCb(star, newStar, msgData)
      local function cb()
        EventManager.Hit(EventId.ClosePanel, PanelId.TowerDefenseHUD)
        
        self:ResumeLogic(true)
      end
      
      local config = ConfigTable.GetData("TowerDefenseLevel", self.nLevelId)
      if config == nil then
        return
      end
      local sLevelName = config.LevelName
      local tbTarget = {}
      for i = 1, 3 do
        table.insert(tbTarget, {
          sTargetDes = config["Des" .. i],
          bResult = false
        })
      end
      EventManager.Hit(EventId.OpenPanel, PanelId.TowerDefenseResultPanel, false, sLevelName, tbTarget, cb, nil, 0)
    end
    
    self.TowerDefenseData:RequestFinishLevel(self.nLevelId, false, 0, requestCb)
  end
  
  local sTip = ConfigTable.GetUIText("TowerDef_Exit_Confirm")
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sTip,
    callbackConfirmAfterClose = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function TowerDefenseCtrl:OnBtnClick_Pause()
  self._mapNode.pauseCtrl:Open()
  self:PauseLogic()
end

function TowerDefenseCtrl:OnBtnClick_OpenDic()
  if self.nDicId == 0 then
    return
  end
  self:PauseLogic()
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.nDicId, true)
end

function TowerDefenseCtrl:OnBtnClick_SwitchPosNext()
  NovaAPI.DispatchEventWithData("TOWERDEFENSE_HANDLE_CONTROL_L1R1", nil, {1})
end

function TowerDefenseCtrl:OnBtnClick_SwitchPosPrev()
  NovaAPI.DispatchEventWithData("TOWERDEFENSE_HANDLE_CONTROL_L1R1", nil, {0})
end

function TowerDefenseCtrl:OnBtnClick_SwitchCharNext()
  NovaAPI.DispatchEventWithData("TOWERDEFENSE_HANDLE_CONTROL_L2R2", nil, {1})
end

function TowerDefenseCtrl:OnBtnClick_SwitchCharPrev()
  NovaAPI.DispatchEventWithData("TOWERDEFENSE_HANDLE_CONTROL_L2R2", nil, {0})
end

function TowerDefenseCtrl:OnBtnClick_MoveMouse(btn)
  InputManager:MoveMouse_UITarget(btn.transform)
end

function TowerDefenseCtrl:OnBtnClick_Release()
  NovaAPI.DispatchEventWithData("TOWERDEFENSE_CANCEL_DRAG_STATE")
  self._mapNode.drag_card1:DoDragEnd()
  self._mapNode.drag_card2:DoDragEnd()
  self._mapNode.drag_card3:DoDragEnd()
  self._mapNode.drag_item:DoDragEnd()
  self.goPointChar = nil
  self.bPointItem = false
end

function TowerDefenseCtrl:OnEvent_Restart()
  local function confirmCallback()
    self:SetTimeScale(false)
    
    self.TowerDefenseData.TowerDefenseLevelData:Restart()
    CS.AdventureModuleHelper.LevelStateChanged(false)
    EventManager.Hit("TowerDefense_Restart")
    self:ResumeLogic()
  end
  
  local sTip = ConfigTable.GetUIText("TowerDef_Re_Confirm")
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sTip,
    callbackConfirm = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function TowerDefenseCtrl:OnEvent_Continue()
  self._mapNode.pauseCtrl:Close()
  self:ResumeLogic()
end

function TowerDefenseCtrl:OnEvent_UnloadComplete()
end

function TowerDefenseCtrl:OnEvent_LoadFinish()
  EventManager.Hit(EventId.BlockInput, false)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 1)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvasGroup, true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroup, true)
  self:ChangeGamepadUI(true)
  self.bInTimeLine = false
  self._mapNode.animator:Play("TowerDefensePanel_in")
  self:CheckAddCardCD()
  if self.bHasDic then
    EventManager.Hit(EventId.BlockInput, true)
  end
end

function TowerDefenseCtrl:OnEvent_CloseCharDetailPanel()
  self:ResumeLogic()
end

function TowerDefenseCtrl:OnEvent_ShowMonsterTips(monsterId)
  self._mapNode.tipsPanel:AddQueue(monsterId, 2)
end

function TowerDefenseCtrl:OnEvent_UpdateEnergy(entityId, characterId, skillId, curCd, maxCd, isAuto)
  maxCd = maxCd:AsFloat() or 0
  self.TowerDefenseData.TowerDefenseLevelData:RefreshCharSkillCd(characterId, maxCd)
end

function TowerDefenseCtrl:OnEvent_OnPause()
  if self.tweener == nil then
    return
  end
end

function TowerDefenseCtrl:OnEvent_OnResume()
  if self.tweener == nil then
    return
  end
end

function TowerDefenseCtrl:OnEvent_ShowPointUI(bIsShow)
  self._mapNode.bg_Point:SetActive(bIsShow)
  self._mapNode.bg_Point2:SetActive(bIsShow)
  self._mapNode.img_item_null:SetActive(bIsShow)
  self._mapNode.go_characterFunc:SetLevelBtnState(bIsShow)
end

function TowerDefenseCtrl:OnEvent_ShowTips(tipsId, Time)
  EventManager.Hit("BattlePopupTips", tipsId, Time or 0, true)
end

function TowerDefenseCtrl:OnEvent_OpenDic(dicId)
  if self.bHasDic then
    EventManager.Hit(EventId.BlockInput, false)
  end
  self:PauseLogic()
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, dicId, true)
  self.nDicId = dicId
  self._mapNode.btn_dic.gameObject:SetActive(true)
end

function TowerDefenseCtrl:OnEvent_CloseDic(panelId)
  if panelId == PanelId.DictionaryEntry then
    self:ResumeLogic()
  end
end

function TowerDefenseCtrl:OnEvent_CharLevelCallback(characterId)
  local nLevel = self.TowerDefenseData.TowerDefenseLevelData:GetCharacterLevel(characterId)
  EventManager.Hit("TowerDefense_character_levelUp", characterId, nLevel)
  EventManager.Hit("TowerDefenseCheckTips")
end

function TowerDefenseCtrl:OnEvent_HasDic()
  self.bHasDic = true
end

function TowerDefenseCtrl:OnEvent_ActivityTowerDefenseLevelSettleFailed()
  self:SetTimeScale(false)
  self:PauseLogic()
  
  local function requestCb(star, newStar, msgData)
    local function cb()
      EventManager.Hit(EventId.ClosePanel, PanelId.TowerDefenseHUD)
      
      self:ResumeLogic(true)
    end
    
    local config = ConfigTable.GetData("TowerDefenseLevel", self.nLevelId)
    if config == nil then
      return
    end
    local sLevelName = config.LevelName
    local tbTarget = {}
    for i = 1, 3 do
      table.insert(tbTarget, {
        sTargetDes = config["Des" .. i],
        bResult = false
      })
    end
    EventManager.Hit(EventId.OpenPanel, PanelId.TowerDefenseResultPanel, false, sLevelName, tbTarget, cb, msgData, 0)
  end
  
  self.TowerDefenseData:RequestFinishLevelFailed(self.nLevelId, 0, requestCb)
end

function TowerDefenseCtrl:OnEvent_UpdateItemEnergy(curValue, maxValue, nTime, bAuto)
  curValue = math.max(0, maxValue - curValue)
  if self.itemTweener ~= nil then
    self.itemTweener:Kill()
  end
  if bAuto then
    self.itemTweener = DOTween.To(function()
      return maxValue - curValue
    end, function(v)
      self._mapNode.item_bar.sizeDelta = Vector2(itemBarWidth * (v / maxValue), self._mapNode.item_bar.sizeDelta.y)
    end, maxValue, nTime):OnComplete(function()
      self._mapNode.item_bar.sizeDelta = Vector2(itemBarWidth, self._mapNode.bar.sizeDelta.y)
    end)
  else
    self._mapNode.item_bar.sizeDelta = Vector2(itemBarWidth * ((maxValue - curValue) / maxValue), self._mapNode.item_bar.sizeDelta.y)
  end
end

function TowerDefenseCtrl:OnEvent_ShowItemEnergy(bIsShow)
  self._mapNode.bg_Itembar:SetActive(bIsShow)
end

return TowerDefenseCtrl
