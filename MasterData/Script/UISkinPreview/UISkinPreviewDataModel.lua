local View = require("UISkinPreview/UISkinPreviewView")
local Controller = require("UISkinPreview/UISkinPreviewController")
local DataModel = {
  Spine2ImgPosX = 0,
  Spine2PosX = 0,
  isSkinView = false
}
DataModel.InfoInitPos = {
  isRecord = true,
  x = 0,
  y = 0,
  scale = 1,
  offsetX = 0,
  offsetY = 1
}

function DataModel:Reset()
  View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.transform.localScale = Vector3(1, 1, 1)
  View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Character.transform.localScale = Vector3(1, 1, 1)
  View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.self:SetLocalPosition(Vector3(0, 0, 0))
  View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled = false
  View.Img_Bg.Slider_Scale:SetActive(false)
  View.Group_CommonTopLeft:SetActive(true)
  View.Group_CommonTopLeft2:SetActive(false)
  DataModel.HideSliderTime = nil
  DataModel.InLook = false
end

function DataModel:ClickLeftSkin(index, isFirst)
  if DataModel.ChooseIndex == nil or index == nil or DataModel.ChooseIndex == index and isFirst == nil then
    return
  end
  local row = DataModel.SkinList[tonumber(index)]
  if DataModel.oldExtraIndex then
    DataModel.SkinList[tonumber(DataModel.ChooseIndex)].qSpineIndex = DataModel.oldExtraIndex
    DataModel.oldExtraIndex = nil
  end
  local resDir = row.ca.resDir
  if row.qSpineIndex > 0 and 0 < #row.ca.extraSpineList then
    local extraCA = PlayerData:GetFactoryData(row.ca.extraSpineList[row.qSpineIndex].id)
    if extraCA ~= nil then
      resDir = extraCA.resDir
    end
  end
  View.Img_Bg.Group_Left.Group_Spine.Img_MinionBg.Spine_MiniSize:SetData(resDir, "stand")
  local Group_Bottom = View.Img_Bg.Group_Left.Group_Bottom
  Group_Bottom.Txt_SkinName:SetText(row.SkinName)
  Group_Bottom.Txt_SkinNameEN:SetText(PlayerData:GetFactoryData(DataModel.RoleId).EnglishName)
  if row.isSpine2 == 1 then
    Group_Bottom.Txt_SkinName:SetText(row.ca.State2Name)
    View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled = false
  end
  Group_Bottom.Txt_SkinDesc:SetText(row.SkinDesc)
  View.Img_Bg.Group_Left.Group_Minion:SetActive(false)
  if DataModel.isSkinView == false then
    local showMinion = false
    for i = 1, #row.ca.extraSpineList do
      local eCA = PlayerData:GetFactoryData(row.ca.extraSpineList[i].id)
      if eCA.resDir ~= row.ca.resDir then
        showMinion = true
        break
      end
    end
    View.Img_Bg.Group_Left.Group_Minion:SetActive(row.isHave and showMinion)
    View.Img_Bg.Group_Left.Group_Minion.Btn_Select:SetActive(false)
    View.Img_Bg.Group_Left.Group_Minion.Btn_Reset:SetActive(false)
    local Btn_On = View.Img_Bg.Group_Right.Group_HoldingStatus.Btn_On
    Btn_On.Group_Bp.self:SetActive(false)
    Btn_On.Group_Buy.self:SetActive(false)
    Btn_On.Group_Wear.self:SetActive(false)
    Btn_On.Img_Off.self:SetActive(false)
    Btn_On.Img_Off.Group_InUsing.self:SetActive(false)
    Btn_On.Img_Off.Group_NotOwned.self:SetActive(false)
    Btn_On.Img_Off.Group_Awake.self:SetActive(false)
    row.Btn_Index = 0
    row.isSelect = true
    if row.isHave == true then
      if row.isWear == true then
        Btn_On.Img_Off.self:SetActive(true)
        Btn_On.Img_Off.Group_InUsing.self:SetActive(true)
      else
        Btn_On.Group_Wear.self:SetActive(true)
        row.Btn_Index = 1
      end
    else
      local getWay = row.ca.Getway[1]
      if getWay then
        Btn_On.Img_Off.self:SetActive(false)
        Btn_On.Group_Get:SetActive(true)
      else
        Btn_On.Img_Off.self:SetActive(true)
        Btn_On.Group_Get:SetActive(false)
        if row.isSpine2 == 1 then
          Btn_On.Img_Off.Group_Awake.self:SetActive(true)
        else
          Btn_On.Img_Off.Group_NotOwned.self:SetActive(true)
        end
      end
    end
  end
  local element = View.Img_Bg.Group_Right.Img_Frame.ScrollGrid_SkinList.grid.self:GetElementByIndex(index - 1)
  element.Img_Selected:SetActive(true)
  element.Img_Selected2:SetActive(true)
  local old = {}
  if DataModel.ChooseIndex and isFirst == nil then
    old = DataModel.SkinList[tonumber(DataModel.ChooseIndex)]
    old.isSelect = false
    local old_element = View.Img_Bg.Group_Right.Img_Frame.ScrollGrid_SkinList.grid.self:GetElementByIndex(DataModel.ChooseIndex - 1)
    if old_element then
      old_element.Img_Selected:SetActive(false)
      old_element.Img_Selected2:SetActive(false)
    end
  end
  local state = false
  if DataModel.NowSkin then
    if DataModel.NowSkin.portraitId ~= row.unitViewId then
      state = true
    elseif row.isSpine2 ~= DataModel.NowSkin.isSpine2 then
      state = true
    end
  end
  if (isFirst == true or state == true) and (row.isSpine2 ~= old.isSpine2 or row.unitViewId ~= old.unitViewId) then
    DataModel.CharacterLoad(row.unitViewId, row.isSpine2 == 1)
  end
  View.Group_Special.Img_SKILL:SetActive(row.ca.exchangeEffectList and 0 < table.count(row.ca.exchangeEffectList))
  View.Group_Special.Img_STATE2:SetActive(row.ca.isSpine2 == 1)
  View.Group_Special.Img_SOUND:SetActive(row.ca.ownExclusiveVoice == true)
  View.Group_Special.Img_Interactive:SetActive(0 < row.ca.SpineIdleListId)
  View.Group_Special.Img_ExtraPose:SetActive(row.ca.extraSpineList and 0 < table.count(row.ca.extraSpineList))
  View.Group_Special.self:SetActive(DataModel.isSkinView)
  if PlayerData.IsSkinHomeSkillOpen() then
    View.Group_Special.Img_HomeSkill:SetActive(row.ca.homeSkill and 0 < row.ca.homeSkill and row.isSpine2 == 0)
    View.Img_Bg.Group_Left.Group_Bottom.Group_Btn.Btn_HomeSkill:SetActive(row.ca.homeSkill and 0 < row.ca.homeSkill and row.isSpine2 == 0)
  end
  DataModel.ChooseIndex = index
  DataModel.LoadSpineBg(row.unitViewId)
end

function DataModel:RefreshMinSpine()
  local row = DataModel.SkinList[tonumber(DataModel.ChooseIndex)]
  local resDir = row.ca.resDir
  if row.qSpineIndex > 0 and 0 < #row.ca.extraSpineList then
    local extraCA = PlayerData:GetFactoryData(row.ca.extraSpineList[row.qSpineIndex].id)
    if extraCA ~= nil then
      resDir = extraCA.resDir
    end
  end
  View.Img_Bg.Group_Left.Group_Spine.Img_MinionBg.Spine_MiniSize:SetData(resDir, "stand")
end

function DataModel:RefreshGroupMinion()
  local row = DataModel.SkinList[tonumber(DataModel.ChooseIndex)]
  View.Img_Bg.Group_Left.Group_Minion:SetActive(true)
  if DataModel.oldExtraIndex == nil or row.qSpineIndex == DataModel.oldExtraIndex then
    View.Img_Bg.Group_Left.Group_Minion.Btn_Select:SetActive(false)
    View.Img_Bg.Group_Left.Group_Minion.Btn_Reset:SetActive(false)
  else
    View.Img_Bg.Group_Left.Group_Minion.Btn_Select:SetActive(true)
    View.Img_Bg.Group_Left.Group_Minion.Btn_Reset:SetActive(true)
  end
end

function DataModel:OnClickLoopExtraSpine()
  local row = DataModel.SkinList[tonumber(DataModel.ChooseIndex)]
  if DataModel.oldExtraIndex == nil then
    DataModel.oldExtraIndex = row.qSpineIndex
  end
  row.qSpineIndex = (row.qSpineIndex + 1) % (#row.ca.extraSpineList + 1)
  if row.qSpineIndex ~= 0 then
    for i = row.qSpineIndex, #row.ca.extraSpineList do
      local extraCA = PlayerData:GetFactoryData(row.ca.extraSpineList[i].id)
      if extraCA.resDir ~= row.ca.resDir then
        row.qSpineIndex = i
        break
      end
      if i == #row.ca.extraSpineList then
        row.qSpineIndex = 0
      end
    end
  end
  DataModel:OnClickSelectExtraSpine()
end

function DataModel:OnClickResetExtraSpine()
  local row = DataModel.SkinList[tonumber(DataModel.ChooseIndex)]
  row.qSpineIndex = DataModel.oldExtraIndex
  DataModel.oldExtraIndex = nil
  DataModel:RefreshMinSpine()
  DataModel:RefreshGroupMinion()
end

function DataModel:OnClickSelectExtraSpine()
  local row = DataModel.SkinList[tonumber(DataModel.ChooseIndex)]
  local spineId = ""
  if row.qSpineIndex ~= 0 then
    spineId = tostring(row.ca.extraSpineList[row.qSpineIndex].id)
  end
  Net:SendProto("hero.change_span", function(json)
    for i = 1, #DataModel.SkinList do
      if DataModel.SkinList[i].ca.id == row.ca.id and DataModel.SkinList[i].isSpine2 ~= row.isSpine2 then
        DataModel.SkinList[i].qSpineIndex = row.qSpineIndex
        break
      end
    end
    DataModel.oldExtraIndex = nil
    DataModel:RefreshMinSpine()
    DataModel:RefreshGroupMinion()
  end, tostring(DataModel.RoleCA.id), spineId)
end

function DataModel:RefreshPage()
  local old_index = 0
  for k, v in pairs(DataModel.SkinList) do
    if v.isWear == true then
      old_index = k
    end
  end
  if old_index ~= 0 then
    local old_row = DataModel.SkinList[old_index]
    old_row.isWear = false
    local old_element = View.Img_Bg.Group_Right.Img_Frame.ScrollGrid_SkinList.grid.self:GetElementByIndex(old_index - 1)
    if old_element then
      old_element.Btn_SkinBg.Img_SkinFrame.Img_InUsingBg:SetActive(false)
    end
  end
  local now_row = DataModel.SkinList[DataModel.ChooseIndex]
  now_row.isWear = true
  local element = View.Img_Bg.Group_Right.Img_Frame.ScrollGrid_SkinList.grid.self:GetElementByIndex(DataModel.ChooseIndex - 1)
  element.Btn_SkinBg.Img_SkinFrame.Img_InUsingBg:SetActive(true)
  DataModel.oldExtraIndex = nil
  DataModel:ClickLeftSkin(DataModel.ChooseIndex, true)
end

function DataModel:ClickLive2D(state)
  local Img_Live2dBg = View.Img_Bg.Group_Left.Group_Bottom.Group_Btn.Img_Live2dBg
  DataModel.live2D = not DataModel.live2D
  local state_n = 0
  if DataModel.live2D == false then
    state_n = 1
  end
  PlayerData:SetPlayerPrefs("int", DataModel.RoleId .. "live2d", state_n)
  if DataModel.live2D ~= state then
    local row = DataModel.SkinList[tonumber(DataModel.ChooseIndex)]
    DataModel.CharacterLoad(row.unitViewId, row.isSpine2 == 1)
    DataModel.LoadSpineBg(row.unitViewId)
  end
  if DataModel.live2D == true then
    DOTweenTools.DOLocalMoveXCallback(Img_Live2dBg.Img_On.transform, 24, 0.25, function()
      Img_Live2dBg.Img_BG:SetSprite("UI/CharacterInfo/Skin/onbg")
    end)
  else
    DOTweenTools.DOLocalMoveXCallback(Img_Live2dBg.Img_On.transform, -24, 0.25, function()
      Img_Live2dBg.Img_BG:SetSprite("UI/CharacterInfo/Skin/offbg")
    end)
  end
end

local function SetMissingConfig(isSpine2, receptionistData)
  local Group_CharacterSkin = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content
  if isSpine2 == true then
    Group_CharacterSkin.Group_Character2.self:SetActive(true)
    Group_CharacterSkin.Group_Character2.Img_Character2:SetSprite(receptionistData.State2Res)
    Group_CharacterSkin.Group_Character2.Img_Character2:SetNativeSize()
  else
    Group_CharacterSkin.Group_Character.self:SetActive(true)
    local resPath = receptionistData.resUrl
    if receptionistData.pngFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
      resPath = receptionistData.pngFemale
    end
    Group_CharacterSkin.Group_Character.Img_Character:SetSprite(resPath)
    Group_CharacterSkin.Group_Character.Img_Character:SetNativeSize()
  end
  DataModel.InfoInitPos.isRecord = false
  local transform = Group_CharacterSkin.transform
  DataModel.InfoInitPos.y = transform.localPosition.y
  DataModel.InfoInitPos.scale = transform.localScale.x
  DataModel.InfoInitPos.offsetX = receptionistData.offsetX
  DataModel.InfoInitPos.offsetY = receptionistData.offsetY
  local pos = DataModel.InfoInitPos
  local posX = pos.x + receptionistData.offsetX * pos.scale
  local posY = pos.y + receptionistData.offsetY * pos.scale
  if isSpine2 == true then
    posX = pos.x + receptionistData.offsetX2 * pos.scale
    posY = pos.y + receptionistData.offsetY2 * pos.scale
  end
  local imgX = -275 + receptionistData.offsetX
  local imgY = receptionistData.offsetY
  local img2X = receptionistData.offsetX2
  local img2Y = receptionistData.offsetY2
  if receptionistData.moveBoolen then
    imgX = imgX + receptionistData.offsetX2
    imgY = imgY + receptionistData.offsetY2
    img2X = -275 + receptionistData.offsetX + receptionistData.offsetX2
    img2Y = receptionistData.offsetY + receptionistData.offsetY2
  end
  Group_CharacterSkin.Group_Character.Img_Character:SetLocalPosition(Vector3(imgX, imgY, 0))
  Group_CharacterSkin.Group_Character2.Img_Character2:SetLocalPosition(Vector3(img2X, img2Y, 0))
  DataModel.Spine2ImgPosX = img2X
  Group_CharacterSkin.Group_Character.Img_Character:SetLocalScale(Vector3(receptionistData.offsetScale, receptionistData.offsetScale, receptionistData.offsetScale))
end

local function ShowVideoSkin(receptionistData)
  local Group_CharacterSkin = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content
  Group_CharacterSkin.Group_Video:SetActive(true)
  local resPath = receptionistData.videoPath
  if receptionistData.videoFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
    resPath = receptionistData.videoFemale
  end
  Group_CharacterSkin.Group_Video.Video_Character:Play(resPath, true, false, false)
  Group_CharacterSkin.Group_Video.Video_Character:SetAnchoredPosition(Vector2(receptionistData.videoX, receptionistData.videoY))
  Group_CharacterSkin.Group_Video.Video_Character:SetLocalScale(Vector3.one * receptionistData.videoScale)
  DataModel.videoX = receptionistData.videoX
  DataModel.videoY = receptionistData.videoY
  DataModel.videoScale = receptionistData.videoScale
end

local function ShowSpineSkin(isSpine2, receptionistData)
  local Group_CharacterSkin = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content
  Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetLocalScale(Vector3.one)
  Group_CharacterSkin.Group_Spine.SpineAnimation_Fade:SetActive(true)
  Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(not isSpine2)
  Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetActive(isSpine2)
  local spineUrl = receptionistData.spineUrl
  if isSpine2 then
    spineUrl = receptionistData.spine2Url
    if spineUrl ~= nil and spineUrl ~= "" then
      Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetPrefab(spineUrl)
      Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetData("")
      local spine2X = receptionistData.spine2X
      local spine2Y = receptionistData.spine2Y
      if receptionistData.moveBoolen then
        spine2X = -275 + receptionistData.spineX + receptionistData.spine2X
        spine2Y = -1200 + receptionistData.spineY + receptionistData.spine2Y
      end
      Group_CharacterSkin.Group_Spine.SpineSecondMode_Character.transform.localPosition = Vector3(spine2X, spine2Y, 0)
      if receptionistData.state2Overturn == true then
        Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetLocalScale(Vector3(-1, 1, 1))
      end
      DataModel.Spine2PosX = spine2X
    else
      SetMissingConfig(isSpine2, receptionistData)
      View.Img_Bg.Group_Left.Group_Bottom.Group_Btn.Img_Live2dBg:SetActive(false)
    end
  else
    if receptionistData.spineFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
      spineUrl = receptionistData.spineFemale
    end
    Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetPrefab("")
    Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetData(spineUrl)
    Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetLocalScale(Vector3(100, 100, 1))
    local spineX = -275 + receptionistData.spineX
    local spineY = -1200 + receptionistData.spineY
    if receptionistData.moveBoolen then
      spineX = spineX + receptionistData.spine2X
      spineY = spineY + receptionistData.spine2Y
    end
    Group_CharacterSkin.Group_Spine.SpineAnimation_Character.transform.localPosition = Vector3(spineX, spineY, 0)
  end
end

function DataModel.CharacterLoad(id, isSkin2)
  DataModel.canDrag = true
  local Group_CharacterSkin = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content
  local receptionistData = PlayerData:GetFactoryData(id, "UnitViewFactory")
  local hasLive2D = true
  local hasStaticImg = true
  if isSkin2 then
    hasLive2D = receptionistData.videoPath ~= "" or receptionistData.spine2Url ~= ""
    hasStaticImg = receptionistData.State2Res ~= ""
  else
    hasLive2D = receptionistData.videoPath ~= "" or receptionistData.spineUrl ~= ""
    hasStaticImg = receptionistData.resUrl ~= ""
  end
  local live2D = PlayerData:GetPlayerPrefs("int", DataModel.RoleId .. "live2d") == 0
  local isVideo = receptionistData.videoSpine and hasLive2D and live2D
  if not hasLive2D and not hasStaticImg then
    CommonTips.OpenTips("SkinView Config Error!")
    return
  end
  Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(false)
  Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetActive(false)
  Group_CharacterSkin.Group_Video:SetActive(false)
  Group_CharacterSkin.Group_Character:SetActive(false)
  Group_CharacterSkin.Group_Character2:SetActive(false)
  View.Img_Bg.Group_Left.Group_Bottom.Group_Btn.Img_Live2dBg:SetActive(hasLive2D and hasStaticImg)
  if not hasLive2D or not live2D then
    SetMissingConfig(isSkin2, receptionistData)
  elseif isVideo then
    ShowVideoSkin(receptionistData)
  else
    ShowSpineSkin(isSkin2, receptionistData)
  end
  View.Img_IpadBtm:SetActive(false)
  View.Img_IpadTop:SetActive(false)
  if isSkin2 or isVideo or receptionistData.moveBoolen then
    View.Img_IpadBtm:SetActive(true)
    View.Img_IpadTop:SetActive(true)
  end
  View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled = false
  DataModel.NowSkin = {}
  DataModel.NowSkin.portraitId = tonumber(id)
  DataModel.NowSkin.isSpine2 = isSkin2 == true and 1 or 0
  Controller:SetIsSpine2(isSkin2 == true and 1 or 0)
  DataModel.isVideo = isVideo
  DataModel.canDrag = not isSkin2 and not isVideo and not receptionistData.moveBoolen or (isSkin2 or isVideo) and receptionistData.moveBoolen
end

function DataModel:MoveSpine2Live2D(_type)
  if DataModel.isVideo then
    local posX = 0
    local posY = 0
    local scale = 1
    if _type ~= 1 then
      posX = DataModel.videoX
      posY = DataModel.videoY
      scale = DataModel.videoScale
    end
    DOTweenTools.DOLocalMove(View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Video.Video_Character.self.transform, posX, posY, 0, 0.25)
    DOTweenTools.DOScaleCallback(View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Video.Video_Character.self.transform, scale, 0.25, nil)
    View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled = false
  else
    View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled = false
    local posX
    local live2D = PlayerData:GetPlayerPrefs("int", DataModel.RoleId .. "live2d")
    if _type == 1 then
      posX = 0
    elseif live2D == 1 then
      posX = DataModel.Spine2ImgPosX
    else
      posX = DataModel.Spine2PosX
    end
    if live2D == 1 then
      DOTweenTools.DOLocalMoveXCallback(View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Character2.Img_Character2.transform, posX, 0.25, function()
      end)
    else
      DOTweenTools.DOLocalMoveXCallback(View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.SpineSecondMode_Character.transform, posX, 0.25, function()
      end)
    end
  end
end

function DataModel.LoadSpineBg(viewId)
  local live2D = PlayerData:GetPlayerPrefs("int", DataModel.RoleId .. "live2d")
  if live2D == 1 then
    View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.Img_SpineBG:SetActive(false)
    return
  end
  local viewCfg = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  if viewCfg.SpineBackground and viewCfg.SpineBackground ~= "" then
    View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.Img_SpineBG:SetSprite(viewCfg.SpineBackground)
    DataModel.offsetX = viewCfg.SpineBGX and viewCfg.SpineBGX or 0
    DataModel.offsetY = viewCfg.SpineBGY and viewCfg.SpineBGY or 0
    local x = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.SpineAnimation_Character.transform.localPosition.x - DataModel.offsetX
    local y = viewCfg.SpineBGY and viewCfg.SpineBGY or 0
    View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.Img_SpineBG.transform.localPosition = Vector3(x, y, 0)
    local scale = viewCfg.SpineBGScale or 1
    View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.Img_SpineBG.transform.localScale = Vector3(scale, scale, 0)
  end
  View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.Img_SpineBG:SetActive(viewCfg.SpineBackground and viewCfg.SpineBackground ~= "")
end

function DataModel.SetHideTime()
  DataModel.HideSliderTime = os.time() + 1
end

function DataModel.UpdateScaleSlider()
  if DataModel.InLook then
    if Input.GetMouseButtonDown(0) then
      if View.Img_Bg.Slider_Scale.IsActive or View.Group_CommonTopLeft2.IsActive then
        DataModel.SetHideTime()
      else
        if not View.Img_Bg.Slider_Scale.IsActive and DataModel.canDrag then
          View.Img_Bg.Slider_Scale:SetActive(true)
          View.self:SelectPlayAnim(View.Img_Bg.Slider_Scale.self, "Animation_Skin_fadein", function()
            DataModel.SetHideTime()
          end)
        end
        if not View.Group_CommonTopLeft2.IsActive then
          View.Group_CommonTopLeft2:SetActive(true)
          View.Group_CommonTopLeft2.Btn_Return:SetBtnInteractable(false)
          View.Group_CommonTopLeft2.Btn_Home:SetBtnInteractable(false)
          View.self:SelectPlayAnim(View.Group_CommonTopLeft2.self, "Animation_Skin_fadein", function()
            DataModel.SetHideTime()
            View.Group_CommonTopLeft2.Btn_Return:SetBtnInteractable(true)
            View.Group_CommonTopLeft2.Btn_Home:SetBtnInteractable(true)
          end)
        end
        Controller:FocusSkinEnd()
      end
    end
    if DataModel.HideSliderTime and os.time() > DataModel.HideSliderTime then
      if View.Img_Bg.Slider_Scale.IsActive then
        View.self:SelectPlayAnim(View.Img_Bg.Slider_Scale.self, "Animation_Skin_fadeout", function()
          View.Img_Bg.Slider_Scale:SetActive(false)
        end)
      end
      if View.Group_CommonTopLeft2.IsActive then
        View.Group_CommonTopLeft2.Btn_Return:SetBtnInteractable(false)
        View.Group_CommonTopLeft2.Btn_Home:SetBtnInteractable(false)
        View.self:SelectPlayAnim(View.Group_CommonTopLeft2.self, "Animation_Skin_fadeout", function()
          View.Group_CommonTopLeft2:SetActive(false)
        end)
      end
      DataModel.HideSliderTime = nil
      Controller:FocusSkinStart()
    end
  end
end

return DataModel
