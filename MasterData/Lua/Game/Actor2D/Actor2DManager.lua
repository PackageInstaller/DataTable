local Actor2DManager = {}
local Offset = CS.Actor2DOffsetData
local ConfigActor2DInPanel = CS.ConfigActor2DInPanel
local Path = require("path")
local RT_SUB_SKILL_SHOW = false
local sRootPath = Settings.AB_ROOT_PATH
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalData = require("GameCore.Data.LocalData")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local typeof = _ENV.typeof
local TN = AllEnum.Actor2DType.Normal
local TF = AllEnum.Actor2DType.FullScreen
local b_UseLive2D_EX = false
local RapidJson = require("rapidjson")
local Actor_Node_Path = string.format("%sUI/CommonEx/Template/----Actor2D_Node----.prefab", Settings.AB_ROOT_PATH)
local L2DType = {
  None = 0,
  Char = 1,
  Disc = 2,
  CG = 3
}
local mapPanelConfig = {}

local function CacheActor2DInPanelConfig()
  local assetConfig = GameResourceLoader.LoadAsset(ResTypeAny, "Assets/AssetBundles/UI/CommonEx/Preference/Actor2DInPanel.asset", typeof(ConfigActor2DInPanel))
  local nLen = assetConfig.arrData.Length - 1
  for i = 0, nLen do
    local data = assetConfig.arrData[i]
    local nPanelId = assetConfig:GetPanelId(i)
    local nReusePanelId = assetConfig:GetReusePanelId(i)
    local nL2DType = assetConfig:GetL2DType(i)
    if 0 <= nPanelId and 0 <= nReusePanelId and 0 <= nL2DType then
      mapPanelConfig[nPanelId] = {
        nReuse = nReusePanelId,
        v3PanelOffset = data.Offset,
        bL2D = data.PreferL2D,
        bHalf = data.PreferHalf,
        nType = nL2DType,
        bAutoAdjust = data.AutoAdjust,
        bSpBg = data.PreferActorBg,
        bHistoryType = data.HistoryType,
        sBg = data.UIBgName,
        bNoExSkin = data.NoExSkin
      }
    else
      printError("ConfigActor2DInPanel data error, index:" .. tostring(i) .. "," .. tostring(nPanelId) .. "," .. tostring(nReusePanelId) .. "," .. tostring(nL2DType))
    end
  end
end

local mapActor2DType = {}

local function LoadLocalData()
  local sJson = LocalData.GetPlayerLocalData("CharActor2DType")
  local tb = decodeJson(sJson)
  if type(tb) == "table" then
    mapActor2DType = tb
    mapActor2DType["1"] = true
  end
end

local function SaveLocalData()
  local sJson = RapidJson.encode(mapActor2DType)
  LocalData.SetPlayerLocalData("CharActor2DType", sJson)
end

local function GetActor2DType(nCharId, nPanelId, nDefaultType, bHistoryType, nSpecifyType)
  if bHistoryType ~= true then
    if nSpecifyType then
      return nSpecifyType
    end
    return nDefaultType
  end
  local nType
  local sMainKey = tostring(nCharId)
  local sSubKey = tostring(nPanelId)
  local mapData = mapActor2DType[sMainKey]
  if mapData == nil then
    mapActor2DType[sMainKey] = {}
    mapData = mapActor2DType[sMainKey]
  end
  nType = mapData[sSubKey]
  if nType == nil then
    nType = nDefaultType
    mapData[sSubKey] = nType
    SaveLocalData()
  end
  if nSpecifyType then
    nType = nSpecifyType
  end
  return nType
end

local function SaveActor2DType(nCharId, nPanelId, nType)
  local mapData = mapActor2DType[tostring(nCharId)] or {}
  mapData[tostring(nPanelId)] = nType
  mapActor2DType[tostring(nCharId)] = mapData
  SaveLocalData()
end

local function CheckL2DType(nCharId, nSkinId, nType, bAutoAdjust)
  if nType == TN then
    return true, TN
  else
    local skin_data = PlayerData.CharSkin:GetSkinDataBySkinId(nSkinId)
    if skin_data == nil then
      if bAutoAdjust == true then
        return false, TN
      else
        return false, TF
      end
    else
      local bAvailable = skin_data:CheckFavorCG()
      if bAvailable == true then
        return true, TF
      elseif bAutoAdjust == true then
        return false, TN
      else
        return false, TF
      end
    end
  end
end

local function GetFullSceneAssetPath(nCGId, bL2D)
  local cfgData = ConfigTable.GetData("CharacterCG", nCGId)
  if nil == cfgData then
    printError(string.format("读取CharacterCG配置失败！！！id = [%s]", nCGId))
  elseif bL2D then
    return cfgData.FullScreenL2D
  else
    return cfgData.FullScreenPortrait
  end
end

local function CheckNoExSkin(mapPanelCfg, mapSkinData)
  if mapPanelCfg.bNoExSkin == true and mapSkinData.Type == GameEnum.skinType.ADVANCE then
    local mapChar = ConfigTable.GetData_Character(mapSkinData.CharId)
    if mapChar ~= nil then
      mapSkinData = ConfigTable.GetData_CharacterSkin(mapChar.DefaultSkinId)
    end
  end
  return mapSkinData
end

local function GetAssetPath(mapData, bL2D, nType)
  if bL2D == true then
    if nType == TN then
      return mapData.L2D
    elseif nType == TF then
      return GetFullSceneAssetPath(mapData.CharacterCG, bL2D)
    end
  elseif nType == TN then
    return mapData.Portrait
  elseif nType == TF then
    return GetFullSceneAssetPath(mapData.CharacterCG, bL2D)
  end
end

local function LoadAsset(sPath, t)
  return GameResourceLoader.LoadAsset(ResTypeAny, Settings.AB_ROOT_PATH .. sPath, typeof(t))
end

local function LoadSprite(sPath, sName, bDisc)
  local _sPath = sPath
  if bDisc then
    _sPath = string.format("%s.png", sPath)
  else
    _sPath = string.format("%s/atlas_png/a/%s.png", Path.dirname(sPath), sName)
  end
  return LoadAsset(_sPath, typeof(Sprite))
end

local function LoadImage(sPath)
  return GameResourceLoader.LoadAsset(ResTypeAny, Settings.AB_ROOT_PATH .. sPath, typeof(Sprite))
end

local mapOffsetAsset = {}

local function GetOffset(sOffset)
  local objOffsetAsset = mapOffsetAsset[sOffset]
  if objOffsetAsset == nil then
    objOffsetAsset = LoadAsset(sOffset, Offset)
    mapOffsetAsset[sOffset] = objOffsetAsset
  end
  return objOffsetAsset
end

local function GetTargetPosScale(sOffset, sPose, nPanelId, bFull, b100)
  local objOffset = GetOffset(sOffset)
  local nX, nY = 0, 0
  local s, x, y = objOffset:GetOffsetData(nPanelId, indexOfPose(sPose), bFull ~= true, nX, nY)
  if b100 == true then
    x = x * 100
    y = y * 100
  end
  local v3Pos = Vector3(x, y, 0)
  local v3Scale = Vector3(s, s, 1)
  return v3Pos, v3Scale
end

local function SetRelativeL2DPoseScale(tr, sOffset)
  local objOffset = GetOffset(sOffset)
  local nX, nY = 0, 0
  local s, x, y = objOffset:GetL2DData(nX, nY)
  if s <= 0 then
    x, y, s = 0, 0, 1
  end
  tr.localPosition = Vector3(x, y, 0)
  tr.localScale = Vector3(s, s, 1)
end

local function SetPanelOffset(tbRenderer, nPanelId)
  if nPanelId == nil then
    tbRenderer.trPanelOffset.localPosition = Vector3.zero
    tbRenderer.trPanelOffset.localScale = Vector3.one
  else
    local data = mapPanelConfig[nPanelId]
    if data ~= nil then
      local x, y, s = 0, 0, 1
      if 0 < data.nReuse then
        x = data.v3PanelOffset.x
        y = data.v3PanelOffset.y
        s = data.v3PanelOffset.z
      end
      if s <= 0 then
        s = 1
      end
      tbRenderer.trPanelOffset.localPosition = Vector3(x, y, 0)
      tbRenderer.trPanelOffset.localScale = Vector3(s, s, 1)
    end
  end
end

local mapL2DPrefab = {}

local function GetL2DPrefab(sL2D)
  local objL2DPrefab = mapL2DPrefab[sL2D]
  if objL2DPrefab == nil then
    objL2DPrefab = LoadAsset(sL2D, Object)
    mapL2DPrefab[sL2D] = objL2DPrefab
  end
  return objL2DPrefab
end

local mapSprite = {}

local function GetSprite(sPortrait, sName, bDisc)
  local sprite
  local map = mapSprite[sPortrait]
  if map == nil then
    map = {}
    sprite = LoadSprite(sPortrait, sName, bDisc)
    map[sName] = sprite
    mapSprite[sPortrait] = map
  else
    sprite = map[sName]
    if sprite == nil then
      sprite = LoadSprite(sPortrait, sName, bDisc)
      map[sName] = sprite
    end
  end
  return sprite
end

local mapBg = {}

local function GetBg(sBg)
  local sprite = mapBg[sBg]
  if sprite == nil then
    sprite = LoadImage(sBg)
    mapBg[sBg] = sprite
  end
  return sprite
end

local function GetUIDefaultBgName(sUIDefaultBg)
  if type(sUIDefaultBg) == "string" and sUIDefaultBg ~= "" then
    return string.format("Image/UIBG/%s.png", sUIDefaultBg)
  else
    return nil
  end
end

local function Init_RT(tbRenderer)
  if tbRenderer._RenderTexture == nil then
    if RT_SUB_SKILL_SHOW == true then
      tbRenderer._cam.orthographicSize = 10.24
      local nW = math.floor(2048 * Settings.RENDERTEXTURE_SIZE_FACTOR)
      local nH = math.floor(2048 * Settings.RENDERTEXTURE_SIZE_FACTOR)
      tbRenderer._RenderTexture = GameUIUtils.GenerateRenderTextureFor2D(nW, nH)
      tbRenderer._RenderTexture.name = "Actor2DMgr(Init_RT)(SUB_SKILL_SHOW)"
      tbRenderer._cam.targetTexture = tbRenderer._RenderTexture
    else
      tbRenderer._cam.orthographicSize = Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT / 200
      local nW = math.floor(Settings.CURRENT_CANVAS_FULL_RECT_WIDTH * Settings.RENDERTEXTURE_SIZE_FACTOR)
      local nH = math.floor(Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT * Settings.RENDERTEXTURE_SIZE_FACTOR)
      tbRenderer._RenderTexture = GameUIUtils.GenerateRenderTextureFor2D(nW, nH)
      tbRenderer._RenderTexture.name = "Actor2DMgr(Init_RT)"
      tbRenderer._cam.targetTexture = tbRenderer._RenderTexture
    end
  end
end

local function UnInit_RT(tbRenderer)
  if IsNull(tbRenderer._tr) then
    return
  end
  if tbRenderer._targetRawImage ~= nil then
    NovaAPI.SetTexture(tbRenderer._targetRawImage, nil)
    tbRenderer._targetRawImage = nil
  end
  if not IsNull(tbRenderer._cam) then
    tbRenderer._cam.targetTexture = nil
  end
  if tbRenderer._RenderTexture ~= nil then
    GameUIUtils.ReleaseRenderTexture(tbRenderer._RenderTexture)
    tbRenderer._RenderTexture = nil
  end
  if tbRenderer._RenderTextureAvg ~= nil then
    GameUIUtils.ReleaseRenderTexture(tbRenderer._RenderTextureAvg)
    tbRenderer._RenderTextureAvg = nil
  end
end

local function Set_RawImg(tbRenderer, rawImg)
  Init_RT(tbRenderer)
  if rawImg ~= tbRenderer._targetRawImage then
    if tbRenderer._targetRawImage ~= nil then
      NovaAPI.SetTexture(tbRenderer._targetRawImage, nil)
    end
    tbRenderer._targetRawImage = rawImg
    NovaAPI.SetTexture(tbRenderer._targetRawImage, tbRenderer._RenderTexture)
    if RT_SUB_SKILL_SHOW then
      tbRenderer._targetRawImage.gameObject:GetComponent("RectTransform").sizeDelta = Vector2(2048, 2048)
    else
      tbRenderer._targetRawImage.gameObject:GetComponent("RectTransform").sizeDelta = Vector2(Settings.CURRENT_CANVAS_FULL_RECT_WIDTH, Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT)
    end
  end
  tbRenderer._tr.localScale = Vector3.one
  tbRenderer._cam.gameObject:SetActive(true)
end

local function UnSet_RawImg(tbRenderer)
  if tbRenderer._targetRawImage ~= nil then
    NovaAPI.SetTexture(tbRenderer._targetRawImage, nil)
    tbRenderer._targetRawImage = nil
  end
  if not IsNull(tbRenderer._tr) then
    tbRenderer._tr.localScale = Vector3.zero
  end
  if not IsNull(tbRenderer._cam) then
    tbRenderer._cam.gameObject:SetActive(false)
  end
end

local MAX_L2D_INS_COUNT = 5
local MAX_L2D_RENDERER_COUNT = 3
local trL2DInsRoot, trL2DRendererRoot
local tbL2DRenderer = {}
local nDuration = 0.5
local mapPlayedCG = {}
local mapCurrent = {
  tbChar = {},
  nPanelId = 0,
  nOffsetPanelId = 0,
  nActor2DType = 0,
  bUseL2D = false,
  bUseFull = false,
  tbDisc = {},
  tbCg = {},
  L2DType = L2DType.None
}

local function GetL2DRendererStructure(trRenderer)
  local LayerMask = CS.UnityEngine.LayerMask
  local tb = {}
  tb._tr = trRenderer
  tb._cam = trRenderer:GetChild(0):GetComponent("Camera")
  tb._RenderTexture = nil
  tb._RenderTextureAvg = nil
  tb._targetRawImage = nil
  tb.spr_bg = trRenderer:Find("customized_bg"):GetComponent("SpriteRenderer")
  tb.animator = trRenderer:Find("animator")
  tb.animatorCtrl = tb.animator:GetComponent("Animator")
  tb.trPanelOffset = trRenderer:Find("animator/panel_offset")
  tb.trFreeDrag = trRenderer:Find("animator/panel_offset/free_drag")
  tb.trOffset = trRenderer:Find("animator/panel_offset/free_drag/actor_offset")
  tb.parent_L2D = trRenderer:Find("animator/panel_offset/free_drag/actor_offset/L2D")
  tb.parent_PNG = trRenderer:Find("animator/panel_offset/free_drag/actor_offset/PNG")
  tb.trEmojiRoot = trRenderer:Find("animator/panel_offset/free_drag/----emoji----/emoji_root")
  tb.spr_body = trRenderer:Find("animator/panel_offset/free_drag/actor_offset/PNG/sp_body"):GetComponent("SpriteRenderer")
  tb.spr_face = trRenderer:Find("animator/panel_offset/free_drag/actor_offset/PNG/sp_face"):GetComponent("SpriteRenderer")
  tb.sL2D = nil
  tb.trL2DIns = nil
  tb.nLayerIndex = LayerMask.NameToLayer("Cam_Layer_4")
  return tb
end

local function GetL2DIns(sL2D)
  local trIns
  if trL2DInsRoot == nil then
    return
  end
  local nChildCount = trL2DInsRoot.childCount - 1
  for i = 0, nChildCount do
    local trChild = trL2DInsRoot:GetChild(i)
    if trChild.name == sL2D then
      trIns = trChild
      break
    end
  end
  if trIns ~= nil and trIns:IsNull() == false then
    return trIns, false
  else
    local objPrefab = GetL2DPrefab(sL2D)
    if objPrefab == nil then
      return nil, false
    end
    local goIns = instantiate(objPrefab, trL2DInsRoot)
    goIns.name = sL2D
    trIns = goIns.transform
    if trL2DInsRoot.childCount > MAX_L2D_INS_COUNT then
      destroyImmediate(trL2DInsRoot:GetChild(0).gameObject)
    end
    return trIns, true
  end
end

local function SetL2DInsParent(trIns, trParent)
  if trIns == nil then
    return
  end
  trIns:SetParent(trParent)
  trIns.localPosition = Vector3.zero
  trIns.localScale = Vector3.one
end

local function ResetRenderer(tbRenderer)
  if IsNull(tbRenderer._tr) then
    return
  end
  UnSet_RawImg(tbRenderer)
  UnInit_RT(tbRenderer)
  if not IsNull(tbRenderer.trL2DIns) then
    SetL2DInsParent(tbRenderer.trL2DIns, trL2DInsRoot)
    local trBg = tbRenderer.trL2DIns:Find("root/----bg----")
    if not IsNull(trBg) then
      trBg.localScale = Vector3.one
    end
    local trBgEft = tbRenderer.trL2DIns:Find("root/----bg_effect----")
    if not IsNull(trBgEft) then
      trBgEft.localScale = Vector3.one
    end
    tbRenderer.trL2DIns = nil
  end
  tbRenderer.sL2D = nil
  SetPanelOffset(tbRenderer)
  if not IsNull(tbRenderer.trOffset) then
    tbRenderer.trOffset.localPosition = Vector3.zero
    tbRenderer.trOffset.localScale = Vector3.one
  end
  NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_body, nil)
  NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_face, nil)
  NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_bg, nil)
  if not IsNull(tbRenderer.parent_L2D) then
    tbRenderer.parent_L2D.localScale = Vector3.zero
  end
  if not IsNull(tbRenderer.parent_PNG) then
    tbRenderer.parent_PNG.localScale = Vector3.zero
  end
  Actor2DManager.ResetActor2DAnim(tbRenderer)
end

local function GetRenderer(sL2D, bForceMatch, nIndex)
  local tbRenderer
  for i, v in ipairs(tbL2DRenderer) do
    if bForceMatch == true then
      if v.sL2D == sL2D then
        tbRenderer = v
        break
      end
    elseif nIndex == nil then
      if v.sL2D == sL2D or v.sL2D == nil then
        tbRenderer = v
        break
      end
    elseif v.sL2D == sL2D or v.sL2D == nil and i == nIndex then
      tbRenderer = v
      break
    end
  end
  return tbRenderer
end

local function SetL2D(sL2D, sOffset, rawImg, nCurPanelId, nReusePanelId, nType, bFull, sBg, tbRenderer)
  if tbRenderer == nil then
    return
  end
  local bPlaySwitchAnim = true
  if tbRenderer.sL2D == nil then
    bPlaySwitchAnim = false
    local trIns, bIsNew = GetL2DIns(sL2D)
    if trIns == nil then
      printError("未找到根节点")
    end
    tbRenderer.sL2D = sL2D
    tbRenderer.trL2DIns = trIns
    if bIsNew == true then
      if nType == TN then
        SetRelativeL2DPoseScale(trIns:Find("root"), sOffset)
      end
      trIns:SetLayerRecursively(tbRenderer.nLayerIndex)
    end
    SetL2DInsParent(trIns, tbRenderer.parent_L2D)
  end
  local v3TargetLocalPos = Vector3(0, 0, 0)
  local v3TargetLocalScale = Vector3.one
  if nType == TF then
    SetPanelOffset(tbRenderer)
    tbRenderer.trOffset.localPosition = v3TargetLocalPos
    tbRenderer.trOffset.localScale = v3TargetLocalScale
  else
    SetPanelOffset(tbRenderer, nCurPanelId)
    v3TargetLocalPos, v3TargetLocalScale = GetTargetPosScale(sOffset, "a", nReusePanelId, bFull)
    if bPlaySwitchAnim == true then
      tbRenderer.trOffset:DOLocalMove(v3TargetLocalPos, nDuration):SetUpdate(true):SetEase(Ease.OutQuint)
      tbRenderer.trOffset:DOScale(v3TargetLocalScale, nDuration):SetUpdate(true):SetEase(Ease.OutQuint)
      EventManager.Hit(EventId.TemporaryBlockInput, nDuration)
    else
      tbRenderer.trOffset.localPosition = v3TargetLocalPos
      tbRenderer.trOffset.localScale = v3TargetLocalScale
    end
  end
  if sBg == nil or sBg == "" then
    NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_bg, nil)
    tbRenderer.spr_bg.transform.localScale = Vector3.zero
  else
    NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_bg, GetBg(sBg))
    tbRenderer.spr_bg.transform.localScale = Vector3.one
  end
  tbRenderer.parent_L2D.localScale = Vector3.one
  tbRenderer.trFreeDrag.localPosition = Vector3.zero
  tbRenderer.trFreeDrag.localScale = Vector3.one
  Set_RawImg(tbRenderer, rawImg)
end

local function GetActor2DParams(nPanelId, nCharId, nSkinId, param, nSpecifyType)
  local tbConfig = mapPanelConfig[nPanelId]
  if tbConfig == nil then
    printError("此界面未定义“如何”显示2D角色，panel id:" .. tostring(nPanelId))
    return
  end
  if nSkinId == nil then
    nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
  end
  local mapSkinData = ConfigTable.GetData_CharacterSkin(nSkinId)
  mapSkinData = CheckNoExSkin(tbConfig, mapSkinData)
  if mapSkinData == nil then
    printError("未找到角色皮肤数据")
  end
  local bL = tbConfig.bL2D and LocalSettingData.mapData.UseLive2D or b_UseLive2D_EX
  if type(param) == "table" and param[1] == "TalentL2D" then
    bL = true
  end
  local bF = not tbConfig.bHalf
  if mapCurrent.nPanelId == nPanelId and mapCurrent.bUseFull ~= nil then
    bF = mapCurrent.bUseFull
  end
  local nT = GetActor2DType(nCharId, nPanelId, tbConfig.nType, tbConfig.bHistoryType, nSpecifyType)
  local bSetSuccess = true
  bSetSuccess, nT = CheckL2DType(nCharId, nSkinId, nT, tbConfig.bAutoAdjust)
  local sBg = GetUIDefaultBgName(tbConfig.sBg)
  if tbConfig.bSpBg == true then
    sBg = mapSkinData.Bg .. ".png"
  end
  if nT == TF then
    sBg = nil
  end
  local nOffsetDataPanelId = nPanelId
  if tbConfig.nReuse > 0 then
    nOffsetDataPanelId = tbConfig.nReuse
  end
  local sAssetPath = GetAssetPath(mapSkinData, bL, nT)
  local sOffset = mapSkinData.Offset
  if bL == true and type(param) == "table" and param[1] == "TalentL2D" then
    local nDefaultSkinId = ConfigTable.GetData_Character(nCharId).DefaultSkinId
    local mapDefaultSkinData = ConfigTable.GetData_CharacterSkin(nDefaultSkinId)
    sAssetPath = mapDefaultSkinData.L2D
    sAssetPath = string.gsub(sAssetPath, "_L.prefab", "_LT.prefab")
  end
  return sAssetPath, sOffset, bL, nOffsetDataPanelId, nT, bF, sBg, bSetSuccess
end

local function GetFace(nSkinId, nPanelId, param)
  local sFace, sFieldName
  if param ~= nil then
  end
  if sFace == "" or sFace == nil then
    sFace = "002"
  end
  return sFace
end

local function GetName(sPortrait, sFace)
  local sFileFullName = Path.basename(sPortrait)
  local sFileExtName = Path.extension(sPortrait)
  local sFileName = string.gsub(sFileFullName, sFileExtName, "")
  sFileName = string.gsub(sFileName, "_a", "")
  local sBodyName = string.format("%s_%s", sFileName, "001")
  local sFaceName = string.format("%s_%s", sFileName, sFace)
  return sBodyName, sFaceName
end

local function SetPortrait(sPortrait, sFace, sOffset, rawImg, nCurPanelId, nReusePanelId, nType, bFull, sBg, tbRenderer)
  if tbRenderer == nil then
    printError("未找到 Renderer")
  end
  local bPlaySwitchAnim = true
  if tbRenderer.sL2D == nil then
    bPlaySwitchAnim = false
    if nType == TN then
      local sBodyName, sFaceName = GetName(sPortrait, sFace)
      NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_body, GetSprite(sPortrait, sBodyName))
      NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_face, GetSprite(sPortrait, sFaceName))
    else
      NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_body, nil)
      NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_face, GetBg(sPortrait))
    end
    tbRenderer.sL2D = sPortrait
  end
  local v3TargetLocalPos = Vector3(0, 0, 0)
  local v3TargetLocalScale = Vector3.one
  if nType == TF then
    SetPanelOffset(tbRenderer)
    tbRenderer.trOffset.localPosition = v3TargetLocalPos
    tbRenderer.trOffset.localScale = v3TargetLocalScale
  else
    SetPanelOffset(tbRenderer, nCurPanelId)
    v3TargetLocalPos, v3TargetLocalScale = GetTargetPosScale(sOffset, "a", nReusePanelId, bFull)
    if bPlaySwitchAnim == true then
      tbRenderer.trOffset:DOLocalMove(v3TargetLocalPos, nDuration):SetUpdate(true):SetEase(Ease.OutQuint)
      tbRenderer.trOffset:DOScale(v3TargetLocalScale, nDuration):SetUpdate(true):SetEase(Ease.OutQuint)
      EventManager.Hit(EventId.TemporaryBlockInput, nDuration)
    else
      tbRenderer.trOffset.localPosition = v3TargetLocalPos
      tbRenderer.trOffset.localScale = v3TargetLocalScale
    end
  end
  if sBg == nil or sBg == "" then
    NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_bg, nil)
    tbRenderer.spr_bg.transform.localScale = Vector3.zero
  else
    NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_bg, GetBg(sBg))
    tbRenderer.spr_bg.transform.localScale = Vector3.one
  end
  tbRenderer.parent_PNG.localScale = Vector3.one
  tbRenderer.trFreeDrag.localPosition = Vector3.zero
  tbRenderer.trFreeDrag.localScale = Vector3.one
  Set_RawImg(tbRenderer, rawImg)
end

function Actor2DManager.Init()
  trL2DInsRoot = GameObject.Find("==== UI ROOT ====/----Actor2D_OffScreen_Renderer----/----CachedInstance----").transform
  trL2DRendererRoot = GameObject.Find("==== UI ROOT ====/----Actor2D_OffScreen_Renderer----/----Renderer----").transform
  local bundleGroup = GameResourceLoader.MakeBundleGroup("UI", 99999)
  local actor_node = GameResourceLoader.LoadAsset(ResTypeAny, Actor_Node_Path, typeof(Object), bundleGroup, 99999)
  for i = 1, MAX_L2D_RENDERER_COUNT do
    local trRenderer = instantiate(actor_node, trL2DRendererRoot)
    trRenderer.name = i
    local pos = trRenderer.transform.localPosition
    pos.x = pos.x + (i - 1) * 10000
    trRenderer.transform.localPosition = pos
    local tb = GetL2DRendererStructure(trRenderer.transform)
    if tb ~= nil then
      table.insert(tbL2DRenderer, tb)
      table.insert(mapCurrent.tbChar, {
        nCharId = 0,
        nSkinId = 0,
        sBg = nil,
        sAssetPath = nil,
        sFace = nil,
        sOffset = nil,
        rawImg = nil
      })
      table.insert(mapCurrent.tbDisc, {
        nDiscId = 0,
        sAssetPath = nil,
        rawImg = nil
      })
      table.insert(mapCurrent.tbCg, {
        nCgId = 0,
        sAssetPath = nil,
        rawImg = nil
      })
    end
  end
  CacheActor2DInPanelConfig()
  local mapFallbackOrder = {
    chat_b = {"chat_a"},
    chat_c = {"chat_a"},
    chat_d = {"chat_a"},
    presents_a = {"chat_a"},
    presents_b = {"chat_b", "chat_a"},
    shy_a = {"chat_a"},
    think_a = {"chat_b", "chat_a"},
    special_a = {"chat_a"},
    special_b = {"chat_b", "chat_a"}
  }
  local sJson = RapidJson.encode(mapFallbackOrder)
  NovaAPI.SetL2DAnimFallbackRules(sJson)
end

function Actor2DManager.ClearAll()
  for i, tbRenderer in ipairs(tbL2DRenderer) do
    if tbRenderer.sL2D ~= nil then
      ResetRenderer(tbRenderer)
    end
    UnInit_RT(tbRenderer)
  end
  if trL2DInsRoot ~= nil then
    delChildren(trL2DInsRoot.gameObject)
  end
  mapOffsetAsset = {}
  mapL2DPrefab = {}
  mapSprite = {}
  mapBg = {}
  GameResourceLoader.Unload("UI")
end

function Actor2DManager.SetActor2D_ForSubSKill(nPanelId, rawImg, nCharId, nSkinId, param, nIndex)
  RT_SUB_SKILL_SHOW = true
  Actor2DManager.SetActor2D(nPanelId, rawImg, nCharId, nSkinId, param, nIndex)
  RT_SUB_SKILL_SHOW = false
end

function Actor2DManager.SetActor2DWithRender(nPanelId, rawImg, nCharId, nSkinId, param, trRenderer, defaultNT)
  if mapActor2DType["1"] ~= true then
    LoadLocalData()
  end
  local mapCurChar = {}
  local sAssetPath, sOffset, bL, nOffsetDataPanelId, nT, bF, sBg, bSetSuccess = GetActor2DParams(nPanelId, nCharId, nSkinId, nil, defaultNT)
  local sFace
  local tbRenderer = GetL2DRendererStructure(trRenderer)
  if bL == true then
    SetL2D(sAssetPath, sOffset, rawImg, nPanelId, nOffsetDataPanelId, nT, bF, sBg, tbRenderer)
  else
    sFace = GetFace(nSkinId, nPanelId, param)
    SetPortrait(sAssetPath, sFace, sOffset, rawImg, nPanelId, nOffsetDataPanelId, nT, bF, sBg, tbRenderer)
  end
  local nAnimLength = 0
  if bL == true then
    if nT == TN then
      Actor2DManager.PlayL2DAnim(tbRenderer.trL2DIns, "idle", true, true)
    elseif nT ~= TF or nPanelId == PanelId.MainView then
    else
      Actor2DManager.PlayL2DAnim(tbRenderer.trL2DIns, "idle", true, true)
    end
  end
  return bSetSuccess, nT, nAnimLength, tbRenderer
end

function Actor2DManager.UnSetActor2DWithRender(tbRenderer)
  if tbRenderer == nil then
    return
  end
  if tbRenderer ~= nil then
    ResetRenderer(tbRenderer)
  end
end

function Actor2DManager.SetActor2D(nPanelId, rawImg, nCharId, nSkinId, param, nIndex)
  if mapActor2DType["1"] ~= true then
    LoadLocalData()
  end
  if nIndex == nil then
    nIndex = 1
  end
  local mapCurChar = mapCurrent.tbChar[nIndex]
  if mapCurrent.L2DType == L2DType.Char then
    Actor2DManager.UnsetActor2D(true, nIndex)
  elseif mapCurrent.L2DType == L2DType.Disc then
    Actor2DManager.UnSetDisc2D(true, nIndex)
  elseif mapCurrent.L2DType == L2DType.CG then
    Actor2DManager.UnSetCg2D(true, nIndex)
  else
    Actor2DManager.UnsetActor2D(true, nIndex)
    Actor2DManager.UnSetDisc2D(true, nIndex)
    Actor2DManager.UnSetCg2D(true, nIndex)
  end
  local sAssetPath, sOffset, bL, nOffsetDataPanelId, nT, bF, sBg, bSetSuccess = GetActor2DParams(nPanelId, nCharId, nSkinId, param)
  local sFace
  local tbRenderer = GetRenderer(sAssetPath, false, nIndex)
  if bL == true then
    SetL2D(sAssetPath, sOffset, rawImg, nPanelId, nOffsetDataPanelId, nT, bF, sBg, tbRenderer)
  else
    sFace = GetFace(nSkinId, nPanelId, param)
    SetPortrait(sAssetPath, sFace, sOffset, rawImg, nPanelId, nOffsetDataPanelId, nT, bF, sBg, tbRenderer)
  end
  mapCurChar.nCharId = nCharId
  mapCurChar.nSkinId = nSkinId
  mapCurChar.sBg = sBg
  mapCurChar.sAssetPath = sAssetPath
  mapCurChar.sFace = sFace
  mapCurChar.sOffset = sOffset
  mapCurChar.rawImg = rawImg
  mapCurrent.nPanelId = nPanelId
  mapCurrent.nOffsetPanelId = nOffsetDataPanelId
  mapCurrent.nActor2DType = nT
  mapCurrent.bUseL2D = bL
  mapCurrent.bUseFull = bF
  mapCurrent.L2DType = L2DType.Char
  mapCurChar.dragPos = Vector3.zero
  local nAnimLength = 0
  if bL == true then
    if type(param) == "table" and param[1] == "TalentL2D" then
      local nL2DStatus = param[2]
      local sAnimName = "idle_0"
      if nL2DStatus == 0 then
        sAnimName = "idle_0"
      elseif nL2DStatus == 1 then
        sAnimName = "idle_0a"
      elseif nL2DStatus == 2 then
        sAnimName = "idle_1"
      elseif 3 <= nL2DStatus then
        sAnimName = "idle_2"
      end
      Actor2DManager.PlayAnim(sAnimName, true, nIndex, true)
      local tbRule = {
        "0",
        "1",
        "2",
        "3",
        "5",
        "4"
      }
      local trIns
      if 0 < tbRenderer.parent_L2D.childCount then
        trIns = tbRenderer.parent_L2D:GetChild(0)
      end
      if trIns ~= nil then
        local trBG = trIns:Find("root/----bg_effect----")
        local trFG = trIns:Find("root/----fg_effect----")
        for nI, sNodeName in ipairs(tbRule) do
          local bVisible = nL2DStatus >= nI - 1
          local trNodeBG = trBG:Find(sNodeName)
          if trNodeBG ~= nil then
            trNodeBG.gameObject:SetActive(bVisible)
          end
          local trNodeFG = trFG:Find(sNodeName)
          if trNodeFG ~= nil then
            trNodeFG.gameObject:SetActive(bVisible)
          end
        end
      end
    elseif nT == TN then
      Actor2DManager.PlayAnim("idle", true, nIndex)
    elseif nT == TF then
      if nPanelId == PanelId.MainView then
        nAnimLength = Actor2DManager.PlayCGAnim(false, nIndex)
      else
        Actor2DManager.PlayAnim("idle", true, nIndex)
      end
    end
  end
  return bSetSuccess, nT, nAnimLength
end

function Actor2DManager.UnsetActor2D(bKeepData, nIndex, bForce, tbRenderer)
  if not mapCurrent.L2DType == L2DType.Char then
    return
  end
  if nIndex == nil then
    nIndex = 1
  end
  local mapCurChar = mapCurrent.tbChar[nIndex]
  if tbRenderer == nil and type(mapCurChar.sAssetPath) == "string" and mapCurChar.sAssetPath ~= "" then
    tbRenderer = GetRenderer(mapCurChar.sAssetPath, true)
  end
  if tbRenderer ~= nil then
    ResetRenderer(tbRenderer)
  end
  if bForce == true and nIndex ~= nil and tbL2DRenderer ~= nil and tbL2DRenderer[nIndex] ~= nil then
    UnInit_RT(tbL2DRenderer[nIndex])
  end
  if bKeepData ~= true then
    mapCurChar.nCharId = 0
    mapCurChar.nSkinId = 0
    mapCurChar.sBg = nil
    mapCurChar.sAssetPath = nil
    mapCurChar.sFace = nil
    mapCurChar.sOffset = nil
    mapCurChar.rawImg = nil
    mapCurChar.dragPos = Vector3.zero
    mapCurrent.nOffsetPanelId = 0
    mapCurrent.nActor2DType = 0
    mapCurrent.bUseL2D = false
    mapCurrent.nPanelId = 0
    mapCurrent.bUseFull = false
    mapCurrent.L2DType = L2DType.None
  end
end

function Actor2DManager.SwitchFullHalf(nIndex)
  if nIndex == nil then
    nIndex = 1
  end
  local mapCurChar = mapCurrent.tbChar[nIndex]
  local bF = not mapCurrent.bUseFull
  local tbRenderer = GetRenderer(mapCurChar.sAssetPath, false, nIndex)
  if mapCurrent.bUseL2D == true then
    SetL2D(mapCurChar.sAssetPath, mapCurChar.sOffset, mapCurChar.rawImg, mapCurrent.nPanelId, mapCurrent.nOffsetPanelId, mapCurrent.nActor2DType, bF, mapCurChar.sBg, tbRenderer)
  else
    SetPortrait(mapCurChar.sAssetPath, mapCurChar.sFace, mapCurChar.sOffset, mapCurChar.rawImg, mapCurrent.nPanelId, mapCurrent.nOffsetPanelId, mapCurrent.nActor2DType, bF, mapCurChar.sBg, tbRenderer)
  end
  mapCurrent.bUseFull = bF
end

function Actor2DManager.SwitchActor2DType(nIndex)
  if not mapCurrent.L2DType == L2DType.Char then
    return
  end
  local bSwitchSuccess = true
  if nIndex == nil then
    nIndex = 1
  end
  local mapCurChar = mapCurrent.tbChar[nIndex]
  local tbConfig = mapPanelConfig[mapCurrent.nPanelId]
  local nRenderCharId = mapCurChar.nCharId
  local nRenderSkinId = mapCurChar.nSkinId
  local nType = mapCurrent.nActor2DType
  local nTargetType
  if nType == TN then
    nTargetType = TF
  else
    nTargetType = TN
  end
  bSwitchSuccess, nTargetType = CheckL2DType(nRenderCharId, nRenderSkinId, nTargetType, tbConfig.bAutoAdjust)
  if nType == nTargetType then
    return bSwitchSuccess
  end
  nType = nTargetType
  Actor2DManager.UnsetActor2D(true, nIndex)
  local sBg = GetUIDefaultBgName(tbConfig.sBg)
  local mapSkinData = ConfigTable.GetData_CharacterSkin(nRenderSkinId)
  mapSkinData = CheckNoExSkin(tbConfig, mapSkinData)
  if mapSkinData == nil then
    printError("未找到角色皮肤数据")
  end
  if tbConfig.bSpBg == true then
    sBg = mapSkinData.Bg .. ".png"
  end
  if nType == TF then
    sBg = nil
  end
  local sAssetPath = GetAssetPath(mapSkinData, mapCurrent.bUseL2D, nType)
  local sFace
  local tbRenderer = GetRenderer(sAssetPath, false, nIndex)
  if mapCurrent.bUseL2D == true then
    SetL2D(sAssetPath, mapCurChar.sOffset, mapCurChar.rawImg, mapCurrent.nPanelId, mapCurrent.nOffsetPanelId, nType, mapCurrent.bUseFull, sBg, tbRenderer)
  else
    sFace = GetFace(nRenderSkinId, mapCurrent.nPanelId)
    SetPortrait(sAssetPath, sFace, mapCurChar.sOffset, mapCurChar.rawImg, mapCurrent.nPanelId, mapCurrent.nOffsetPanelId, nType, mapCurrent.bUseFull, sBg, tbRenderer)
  end
  mapCurChar.sBg = sBg
  mapCurChar.sAssetPath = sAssetPath
  mapCurChar.sFace = sFace
  mapCurrent.nActor2DType = nType
  SaveActor2DType(nRenderCharId, mapCurrent.nPanelId, nType)
  local nAnimLength = 0
  if mapCurrent.bUseL2D == true then
    if nType == TN then
      Actor2DManager.PlayAnim("idle", true, nIndex)
    elseif nType == TF then
      if mapCurrent.nPanelId == PanelId.MainView then
        nAnimLength = Actor2DManager.PlayCGAnim(false, nIndex)
      else
        Actor2DManager.PlayAnim("idle", true, nIndex)
      end
    end
  end
  return bSwitchSuccess, nType, nAnimLength
end

function Actor2DManager.PlayAnim(sAnimClipName, bForcePlay, nIndex, bForceLoop)
  if mapCurrent.bUseL2D ~= true then
    return
  end
  if sAnimClipName == nil then
    sAnimClipName = "idle"
  end
  if bForcePlay == nil then
    bForcePlay = false
  end
  if nIndex == nil then
    nIndex = 1
  end
  local sL2D
  if mapCurrent.L2DType == L2DType.Disc then
    local mapCurDisc = mapCurrent.tbDisc[nIndex]
    sL2D = mapCurDisc.sAssetPath
  elseif mapCurrent.L2DType == L2DType.Char then
    local mapCurChar = mapCurrent.tbChar[nIndex]
    sL2D = mapCurChar.sAssetPath
  elseif mapCurrent.L2DType == L2DType.CG then
    local mapCurDisc = mapCurrent.tbCg[nIndex]
    sL2D = mapCurDisc.sAssetPath
  end
  local tbRenderer = GetRenderer(sL2D, true)
  if tbRenderer == nil then
    printError("未找到 Renderer")
  end
  local bLoop = false
  if sAnimClipName == "idle" then
    bLoop = true
  end
  if bForceLoop == true then
    bLoop = true
  end
  Actor2DManager.PlayL2DAnim(tbRenderer.trL2DIns, sAnimClipName, bLoop, bForcePlay)
end

function Actor2DManager.PlayCGAnim(bForcePlayAnim, nIndex, trL2DIns, tbChar)
  if not mapCurrent.L2DType == L2DType.Char then
    return
  end
  if mapCurrent.nActor2DType ~= TF or mapCurrent.bUseL2D ~= true then
    return 0
  end
  if nIndex == nil then
    nIndex = 1
  end
  local mapCurChar = tbChar
  if tbChar == nil then
    mapCurChar = mapCurrent.tbChar[nIndex]
  end
  local sL2D = mapCurChar.sAssetPath
  local bHasPlayedSinceLogin = mapPlayedCG[sL2D]
  if bHasPlayedSinceLogin ~= true or bForcePlayAnim == true then
    mapPlayedCG[sL2D] = true
    if trL2DIns == nil then
      local tbRenderer = GetRenderer(sL2D, true)
      if tbRenderer == nil then
        printError("未找到 Renderer")
      end
      trL2DIns = tbRenderer.trL2DIns
    end
    local nAnimLength = NovaAPI.PlayL2DCGAnim(trL2DIns)
    return nAnimLength or 0
  else
    Actor2DManager.PlayAnim("idle", true, nIndex)
    return 0
  end
end

function Actor2DManager.SkipCGAnim(nIndex)
  if not mapCurrent.L2DType == L2DType.Char then
    return
  end
  if mapCurrent.nActor2DType ~= TF or mapCurrent.bUseL2D ~= true then
    return
  end
  if nIndex == nil then
    nIndex = 1
  end
  local mapCurChar = mapCurrent.tbChar[nIndex]
  local sL2D = mapCurChar.sAssetPath
  local tbRenderer = GetRenderer(sL2D, true)
  if tbRenderer == nil then
    printError("未找到 Renderer")
  end
  NovaAPIHotfix.SkipL2DCGAnim(tbRenderer.trL2DIns)
end

function Actor2DManager.PlayL2DAnim(tr, sAnimName, bLoop, bForcePlay)
  if tr == nil then
    return
  end
  if sAnimName == nil then
    return
  end
  if string.sub(sAnimName, 1, 3) == "vo_" then
    local sSurfix = GetLanguageSurfixByIndex(GetLanguageIndex(Settings.sCurrentVoLanguage))
    sAnimName = sAnimName .. sSurfix
  end
  NovaAPIHotfix.PlayL2DAnim(tr, sAnimName, bLoop, bForcePlay)
end

function Actor2DManager.SetActor2D_PNG(trActor2D_PNG, nPanelId, nCharId, nSkinId, param)
  local tbConfig = mapPanelConfig[nPanelId]
  if tbConfig == nil then
    printError("此界面未定义“如何”显示2D角色，panel id:" .. tostring(nPanelId))
    return
  end
  if nSkinId == nil then
    nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
  end
  local mapSkinData = ConfigTable.GetData_CharacterSkin(nSkinId)
  mapSkinData = CheckNoExSkin(tbConfig, mapSkinData)
  if mapSkinData == nil then
    printError("未找到角色皮肤数据")
  end
  local bF = not tbConfig.bHalf
  local nOffsetDataPanelId = nPanelId
  if tbConfig.nReuse > 0 then
    nOffsetDataPanelId = tbConfig.nReuse
  end
  local sAssetPath = GetAssetPath(mapSkinData, false, TN)
  local sOffset = mapSkinData.Offset
  local sFace = GetFace(nSkinId, nPanelId, param)
  local sBodyName, sFaceName = GetName(sAssetPath, sFace)
  local v3TargetLocalPos, v3TargetLocalScale = GetTargetPosScale(sOffset, "a", nOffsetDataPanelId, bF, true)
  local spBody = GetSprite(sAssetPath, sBodyName)
  local spFace = GetSprite(sAssetPath, sFaceName)
  local trPanelOffset = trActor2D_PNG:GetChild(0)
  trPanelOffset.localPosition = Vector3(tbConfig.v3PanelOffset.x * 100, tbConfig.v3PanelOffset.y * 100, 0)
  local _s = tbConfig.v3PanelOffset.z
  if _s <= 0 then
    _s = 1
  end
  trPanelOffset.localScale = Vector3(_s, _s, 1)
  local trOffset = trPanelOffset:GetChild(0)
  trOffset.localPosition = v3TargetLocalPos
  trOffset.localScale = v3TargetLocalScale
  local imgBody = trOffset:GetChild(0):GetComponent("Image")
  local imgFace = trOffset:GetChild(1):GetComponent("Image")
  NovaAPI.SetImageSpriteAsset(imgBody, spBody)
  NovaAPI.SetImageSpriteAsset(imgFace, spFace)
  NovaAPI.SetImageNativeSize(imgBody)
  NovaAPI.SetImageNativeSize(imgFace)
end

function Actor2DManager.PlayActor2DAnim(sAnimName, nIndex)
  if not mapCurrent.L2DType == L2DType.Char or not mapCurrent.L2DType == L2DType.None then
    return
  end
  if nil == nIndex then
    nIndex = 1
  end
  local tbRenderer = tbL2DRenderer[nIndex]
  local nAnimLength = NovaAPI.GetAnimClipLength(tbRenderer.animatorCtrl, {sAnimName})
  tbRenderer.animatorCtrl:Play(sAnimName)
  TimerManager.Add(1, nAnimLength, nil, function()
    Actor2DManager.ResetActor2DAnim(tbRenderer)
  end, true, true, true, nil)
end

function Actor2DManager.ResetActor2DAnim(tbRenderer)
  tbRenderer.animatorCtrl:Play("Empty")
  tbRenderer.animator.transform.localPosition = Vector3.zero
end

function Actor2DManager.SetActor2DTypeByPanel(nPanelId, nCharId, nType)
  local sMainKey = tostring(nCharId)
  local sSubKey = tostring(nPanelId)
  if mapActor2DType[sMainKey] == nil then
    mapActor2DType[sMainKey] = {}
  end
  mapActor2DType[sMainKey][sSubKey] = nType
  SaveLocalData()
end

function Actor2DManager.GetActor2DTypeByPanel(nPanelId, nCharId)
  local sMainKey = tostring(nCharId)
  local sSubKey = tostring(nPanelId)
  if mapActor2DType[sMainKey] ~= nil and mapActor2DType[sMainKey][sSubKey] ~= nil then
    return mapActor2DType[sMainKey][sSubKey]
  end
  return TF
end

function Actor2DManager.ForceUseL2D(bForce)
  b_UseLive2D_EX = bForce == true
end

function Actor2DManager.SwitchActor2DDragOffset()
  local mapCurChar = mapCurrent.tbChar[1]
  local tbRenderer = tbL2DRenderer[1]
  local v3Offset = tbRenderer.trOffset.localPosition
  mapCurChar.dragPos = v3Offset
  tbRenderer.trFreeDrag.localPosition = v3Offset
  tbRenderer.trOffset.localPosition = Vector3.zero
  return v3Offset
end

function Actor2DManager.ResetActor2DDragOffset(v3Offset)
  local mapCurChar = mapCurrent.tbChar[1]
  local tbRenderer = tbL2DRenderer[1]
  tbRenderer.trFreeDrag.localPosition = Vector3.zero
  tbRenderer.trOffset.localPosition = v3Offset
  mapCurChar.dragPos = Vector3.zero
end

function Actor2DManager.SetActor2DInUI(nPanelId, trRoot, nCharId, nSkinId, bLive2D)
  local tbConfig = mapPanelConfig[nPanelId]
  if tbConfig == nil then
    printError("此界面未定义“如何”显示2D角色立绘, panel id:" .. tostring(nPanelId))
    return
  end
  if nSkinId == nil then
    nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
  end
  local mapSkinData = ConfigTable.GetData_CharacterSkin(nSkinId)
  mapSkinData = CheckNoExSkin(tbConfig, mapSkinData)
  if mapSkinData == nil then
    printError("未找到角色皮肤数据")
  end
  local bF = not tbConfig.bHalf
  local bL2D = bLive2D == true
  local nOffsetDataPanelId = nPanelId
  if tbConfig.nReuse > 0 then
    nOffsetDataPanelId = tbConfig.nReuse
  end
  local sOffset = mapSkinData.Offset
  local trSlipInOutAnim = trRoot:GetChild(0)
  local trPanelOffset = trSlipInOutAnim:GetChild(0)
  local trRoleOffset = trPanelOffset:GetChild(0)
  local v3TargetLocalPos, v3TargetLocalScale = GetTargetPosScale(sOffset, "a", nOffsetDataPanelId, bF, false)
  local _s = tbConfig.v3PanelOffset.z
  trPanelOffset.localPosition = Vector3(tbConfig.v3PanelOffset.x, tbConfig.v3PanelOffset.y, 0)
  if _s <= 0 then
    _s = 1
  end
  trPanelOffset.localScale = Vector3(_s, _s, 1)
  trRoleOffset.localPosition = v3TargetLocalPos
  trRoleOffset.localScale = v3TargetLocalScale
  delChildren(trRoleOffset)
  local sAssetPath = GetAssetPath(mapSkinData, bL2D, TN)
  local objL2DPrefab = LoadAsset(sAssetPath, Object)
  local goIns = instantiate(objL2DPrefab, trRoleOffset)
  goIns.transform.localPosition = Vector3.zero
  goIns.transform.localScale = Vector3.one
  Actor2DManager.PlayL2DAnim(goIns.transform, "idle", true, true)
end

function Actor2DManager.PlayActor2DAnimInUI(trRoot, sAnimName)
  local trSlipInOutAnim = trRoot:GetChild(0)
  local trPanelOffset = trSlipInOutAnim:GetChild(0)
  local trRoleOffset = trPanelOffset:GetChild(0)
  Actor2DManager.PlayL2DAnim(trRoleOffset:GetChild(0), "idle", false, true)
end

local drag_rang_width = {-8, 8}
local drag_rang_height = {-9, 9}

local function getDragLimit(tbRenderer)
  local localScale = tbRenderer.trFreeDrag.localScale
  local panelOffset = tbRenderer.trPanelOffset.localPosition
  local tbWidthRage = {
    (drag_rang_width[1] - panelOffset.x) * localScale.x,
    (drag_rang_width[2] - panelOffset.x) * localScale.x
  }
  local tbHeightRage = {
    (drag_rang_height[1] - panelOffset.y) * localScale.x,
    (drag_rang_height[2] - panelOffset.y) * localScale.x
  }
  return tbWidthRage, tbHeightRage
end

local function clamp(x, min, max)
  return math.max(math.min(x, max), min)
end

function Actor2DManager.SyncLocalPos(x, y, nIndex, rect)
  if nIndex == nil then
    nIndex = 1
  end
  local mapCurChar = mapCurrent.tbChar[nIndex]
  if nil == mapCurChar then
    return
  end
  local tbRenderer = tbL2DRenderer[nIndex]
  local tbWidthRage, tbHeightRange = getDragLimit(tbRenderer)
  local deltaDragParam = 0.01
  mapCurChar.dragPos = Vector3(mapCurChar.dragPos.x + x * deltaDragParam, mapCurChar.dragPos.y + y * deltaDragParam, 0)
  mapCurChar.dragPos.x = clamp(mapCurChar.dragPos.x, tbWidthRage[1], tbWidthRage[2])
  mapCurChar.dragPos.y = clamp(mapCurChar.dragPos.y, tbHeightRange[1], tbHeightRange[2])
  tbRenderer.trFreeDrag.localPosition = mapCurChar.dragPos
end

function Actor2DManager.SyncLocalScale(s, nIndex)
  if nIndex == nil then
    nIndex = 1
  end
  local tbRenderer = tbL2DRenderer[nIndex]
  tbRenderer.trFreeDrag.localScale = Vector3(s, s, 1)
  local tbWidthRage, tbHeightRange = getDragLimit(tbRenderer)
  local localPos = tbRenderer.trFreeDrag.localPosition
  localPos.x = clamp(localPos.x, tbWidthRage[1], tbWidthRage[2])
  localPos.y = clamp(localPos.y, tbHeightRange[1], tbHeightRange[2])
  tbRenderer.trFreeDrag.localPosition = Vector3(localPos.x, localPos.y, 0)
end

function Actor2DManager.GetCurrentActor2DType()
  if nil ~= mapCurrent then
    return mapCurrent.nActor2DType
  end
end

function Actor2DManager.GetMapPanelConfig(nPanelId)
  return mapPanelConfig[nPanelId]
end

function Actor2DManager.SetBoardNPC2D(nPanelId, rawImg, nCharId, nSkinId, param, nIndex)
  if mapActor2DType["1"] ~= true then
    LoadLocalData()
  end
  if nIndex == nil then
    nIndex = 1
  end
  local mapCurChar = mapCurrent.tbChar[nIndex]
  Actor2DManager.UnsetBoardNPC2D(nIndex)
  local tbConfig = mapPanelConfig[nPanelId]
  if tbConfig == nil then
    printError("此界面未定义“如何”显示2D角色，panel id:" .. tostring(nPanelId))
    return
  end
  if nSkinId == nil then
    nSkinId = PlayerData.Board:GetNPCDefaultSkinId(nCharId)
  end
  if nSkinId == nil then
    printError("系统NPC看板 skinId 为空！！！ charId = " .. nCharId)
    return
  end
  local mapSkinData = ConfigTable.GetData("NPCSkin", nSkinId)
  if mapSkinData == nil then
    printError("未找到NPC皮肤数据")
  end
  local bL = tbConfig.bL2D and LocalSettingData.mapData.UseLive2D
  local bF = not tbConfig.bHalf
  if mapCurrent.nPanelId == nPanelId and mapCurrent.bUseFull ~= nil then
    bF = mapCurrent.bUseFull
  end
  local nT = tbConfig.nType
  local sBg = GetUIDefaultBgName(tbConfig.sBg)
  if tbConfig.bSpBg == true then
    sBg = mapSkinData.Bg .. ".png"
  end
  if nT == TF then
    sBg = nil
  end
  local nOffsetDataPanelId = nPanelId
  if tbConfig.nReuse > 0 then
    nOffsetDataPanelId = tbConfig.nReuse
  end
  local sAssetPath = GetAssetPath(mapSkinData, bL, nT)
  if sAssetPath == nil or sAssetPath == "" then
    return
  end
  local sOffset = mapSkinData.Offset
  local sFace
  local tbRenderer = GetRenderer(sAssetPath, false, nIndex)
  if bL == true then
    SetL2D(sAssetPath, sOffset, rawImg, nPanelId, nOffsetDataPanelId, nT, bF, sBg, tbRenderer)
    if tbRenderer.trL2DIns ~= nil and tbRenderer.trL2DIns:IsNull() == false then
      local trBg = tbRenderer.trL2DIns:Find("root/----bg----")
      if trBg ~= nil and trBg:IsNull() == false then
        if param == "HideBgIn_ReceivePropsNPC_Panel" then
          trBg.localScale = Vector3.zero
        else
          trBg.localScale = Vector3.one
        end
      end
      local trBgEft = tbRenderer.trL2DIns:Find("root/----bg_effect----")
      if trBgEft ~= nil and trBgEft:IsNull() == false then
        if param == "HideBgIn_ReceivePropsNPC_Panel" then
          trBgEft.localScale = Vector3.zero
        else
          trBgEft.localScale = Vector3.one
        end
      end
    end
  else
    sFace = GetFace(nSkinId, nPanelId, param)
    SetPortrait(sAssetPath, sFace, sOffset, rawImg, nPanelId, nOffsetDataPanelId, nT, bF, sBg, tbRenderer)
  end
  mapCurChar.nCharId = nCharId
  mapCurChar.nSkinId = nSkinId
  mapCurChar.sBg = sBg
  mapCurChar.sAssetPath = sAssetPath
  mapCurChar.sFace = sFace
  mapCurChar.sOffset = sOffset
  mapCurChar.rawImg = rawImg
  mapCurrent.nPanelId = nPanelId
  mapCurrent.nOffsetPanelId = nOffsetDataPanelId
  mapCurrent.nActor2DType = nT
  mapCurrent.bUseL2D = bL
  mapCurrent.bUseFull = bF
  mapCurrent.L2DType = L2DType.Char
  local tbRenderer = GetRenderer(sAssetPath, true)
  if tbRenderer == nil then
    printError("未找到 Renderer")
  end
  local sIdleAnim = "idle"
  if param == "HideBgIn_ReceivePropsNPC_Panel" then
    sIdleAnim = sIdleAnim .. "_sp"
  end
  Actor2DManager.PlayL2DAnim(tbRenderer.trL2DIns, sIdleAnim, true, true)
end

function Actor2DManager.UnsetBoardNPC2D(nIndex)
  if nIndex == nil then
    nIndex = 1
  end
  local mapCurChar = mapCurrent.tbChar[nIndex]
  if type(mapCurChar.sAssetPath) == "string" and mapCurChar.sAssetPath ~= "" then
    local tbRenderer = GetRenderer(mapCurChar.sAssetPath, true)
    if tbRenderer ~= nil then
      ResetRenderer(tbRenderer)
    end
  end
  mapCurChar.nCharId = 0
  mapCurChar.nSkinId = 0
  mapCurChar.sBg = nil
  mapCurChar.sAssetPath = nil
  mapCurChar.sFace = nil
  mapCurChar.sOffset = nil
  mapCurChar.rawImg = nil
  mapCurrent.nOffsetPanelId = 0
  mapCurrent.nActor2DType = 0
  mapCurrent.bUseL2D = false
  mapCurrent.nPanelId = 0
  mapCurrent.bUseFull = false
  mapCurrent.L2DType = L2DType.None
end

function Actor2DManager.SetBoardNPC2D_PNG(trActor2D_PNG, nPanelId, nNPCId, nSkinId, param)
  local tbConfig = mapPanelConfig[nPanelId]
  if tbConfig == nil then
    printError("此界面未定义“如何”显示2D角色，panel id:" .. tostring(nPanelId))
    return
  end
  if nSkinId == nil then
    nSkinId = PlayerData.Board:GetNPCDefaultSkinId(nNPCId)
  end
  local mapSkinData = ConfigTable.GetData("NPCSkin", nSkinId)
  if mapSkinData == nil then
    printError("未找到NPC皮肤数据")
  end
  local bF = not tbConfig.bHalf
  local nOffsetDataPanelId = nPanelId
  if tbConfig.nReuse > 0 then
    nOffsetDataPanelId = tbConfig.nReuse
  end
  local sAssetPath = GetAssetPath(mapSkinData, false, TN)
  local sOffset = mapSkinData.Offset
  local sFace = GetFace(nSkinId, nPanelId, param)
  local sBodyName, sFaceName = GetName(sAssetPath, sFace)
  local v3TargetLocalPos, v3TargetLocalScale = GetTargetPosScale(sOffset, "a", nOffsetDataPanelId, bF, true)
  local spBody = GetSprite(sAssetPath, sBodyName)
  local spFace = GetSprite(sAssetPath, sFaceName)
  local trPanelOffset = trActor2D_PNG:GetChild(0)
  trPanelOffset.localPosition = Vector3(tbConfig.v3PanelOffset.x * 100, tbConfig.v3PanelOffset.y * 100, 0)
  local _s = tbConfig.v3PanelOffset.z
  if _s <= 0 then
    _s = 1
  end
  trPanelOffset.localScale = Vector3(_s, _s, 1)
  local trOffset = trPanelOffset:GetChild(0)
  trOffset.localPosition = v3TargetLocalPos
  trOffset.localScale = v3TargetLocalScale
  local imgBody = trOffset:GetChild(0):GetComponent("Image")
  local imgFace = trOffset:GetChild(1):GetComponent("Image")
  NovaAPI.SetImageSpriteAsset(imgBody, spBody)
  NovaAPI.SetImageSpriteAsset(imgFace, spFace)
  NovaAPI.SetImageNativeSize(imgBody)
  NovaAPI.SetImageNativeSize(imgFace)
end

function Actor2DManager.SetBoardNPC2DWithRender(nPanelId, rawImg, nCharId, nSkinId, param, trRenderer)
  if mapActor2DType["1"] ~= true then
    LoadLocalData()
  end
  local mapCurChar = {}
  local tbConfig = mapPanelConfig[nPanelId]
  if tbConfig == nil then
    printError("此界面未定义“如何”显示2D角色，panel id:" .. tostring(nPanelId))
    return
  end
  if nSkinId == nil then
    nSkinId = PlayerData.Board:GetNPCDefaultSkinId(nCharId)
  end
  if nSkinId == nil then
    printError("系统NPC看板 skinId 为空！！！ charId = " .. nCharId)
    return
  end
  local mapSkinData = ConfigTable.GetData("NPCSkin", nSkinId)
  if mapSkinData == nil then
    printError("未找到NPC皮肤数据")
  end
  local bL = tbConfig.bL2D and LocalSettingData.mapData.UseLive2D
  local bF = not tbConfig.bHalf
  if mapCurrent.nPanelId == nPanelId and mapCurrent.bUseFull ~= nil then
    bF = mapCurrent.bUseFull
  end
  local nT = tbConfig.nType
  local sBg = GetUIDefaultBgName(tbConfig.sBg)
  if tbConfig.bSpBg == true then
    sBg = mapSkinData.Bg .. ".png"
  end
  if nT == TF then
    sBg = nil
  end
  local nOffsetDataPanelId = nPanelId
  if tbConfig.nReuse > 0 then
    nOffsetDataPanelId = tbConfig.nReuse
  end
  local sAssetPath = GetAssetPath(mapSkinData, bL, nT)
  if sAssetPath == nil or sAssetPath == "" then
    return
  end
  local sOffset = mapSkinData.Offset
  local sFace
  local tbRenderer = GetL2DRendererStructure(trRenderer)
  if bL == true then
    SetL2D(sAssetPath, sOffset, rawImg, nPanelId, nOffsetDataPanelId, nT, bF, sBg, tbRenderer)
  else
    sFace = GetFace(nSkinId, nPanelId, param)
    SetPortrait(sAssetPath, sFace, sOffset, rawImg, nPanelId, nOffsetDataPanelId, nT, bF, sBg, tbRenderer)
  end
  local nAnimLength = 0
  if bL == true then
    if nT == TN then
      Actor2DManager.PlayL2DAnim(tbRenderer.trL2DIns, "idle", true, true)
    elseif nT ~= TF or nPanelId == PanelId.MainView then
    else
      Actor2DManager.PlayL2DAnim(tbRenderer.trL2DIns, "idle", true, true)
    end
  end
  return true, nT, nAnimLength, tbRenderer
end

local sTempAssetPath, goTempL2DIns

function Actor2DManager.SetActor2D_ForActor2DEditor(nPanelId, rawImg, sSkinId, bFull, sFullPath, s, x, y, bL2D, nL2DX, nL2DY, nL2DS, bNpc)
  if rawImg == nil then
    return
  end
  local sFullPath_BodyPng = string.format("%s%s/atlas_png/a/%s_001.png", sFullPath, sSkinId, sSkinId)
  local sFullPath_FacePng = string.format("%s%s/atlas_png/a/%s_002.png", sFullPath, sSkinId, sSkinId)
  local mapCharSkinData
  if bNpc == true then
    mapCharSkinData = ConfigTable.GetData("NPCSkin", tonumber(sSkinId))
  else
    mapCharSkinData = ConfigTable.GetData_CharacterSkin(tonumber(sSkinId))
  end
  if mapCharSkinData == nil then
    printError("未找到皮肤数据")
  end
  local mapPanelCfgData = mapPanelConfig[nPanelId]
  local sFullPath_Bg = string.format("Assets/AssetBundles/%s", mapPanelCfgData.bSpBg == true and bNpc ~= true and mapCharSkinData ~= nil and mapCharSkinData.Bg .. ".png" or GetUIDefaultBgName(mapPanelCfgData.sBg))
  local tbRenderer = GetRenderer(sFullPath_BodyPng)
  if tbRenderer == nil then
    printError("未找到 Renderer")
  end
  Set_RawImg(tbRenderer, rawImg)
  sTempAssetPath = sFullPath_BodyPng
  tbRenderer.sL2D = sFullPath_BodyPng
  SetPanelOffset(tbRenderer, nPanelId)
  tbRenderer.trOffset.localPosition = Vector3(x, y, 0)
  tbRenderer.trOffset.localScale = Vector3(s, s, 1)
  tbRenderer.parent_PNG.localScale = Vector3.one
  NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_body, CS.UnityEditor.AssetDatabase.LoadAssetAtPath(sFullPath_BodyPng, typeof(Sprite)))
  NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_face, CS.UnityEditor.AssetDatabase.LoadAssetAtPath(sFullPath_FacePng, typeof(Sprite)))
  tbRenderer.spr_bg.transform.localScale = Vector3.one
  NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_bg, CS.UnityEditor.AssetDatabase.LoadAssetAtPath(sFullPath_Bg, typeof(Sprite)))
  local trL2D
  if bL2D == true then
    tbRenderer.parent_L2D.localScale = Vector3.one
    local sL2D = string.format("Actor2D/Character/%s/%s_L.prefab", sSkinId, sSkinId)
    local objL2DPrefab = LoadAsset(sL2D, Object)
    goTempL2DIns = instantiate(objL2DPrefab, tbRenderer.parent_L2D)
    goTempL2DIns.transform:SetLayerRecursively(CS.UnityEngine.LayerMask.NameToLayer("Cam_Layer_4"))
    trL2D = goTempL2DIns.transform:Find("root")
    if nL2DS == nil or nL2DS <= 0 then
      nL2DS = 1
    end
    trL2D.localPosition = Vector3(nL2DX or 0, nL2DY or 0, 0)
    trL2D.localScale = Vector3(nL2DS, nL2DS, 1)
    local goModel = trL2D:Find("----live2d_modle----"):GetChild(0).gameObject
    local CubismRenderController = goModel:GetComponent("CubismRenderController")
    CubismRenderController.SortingOrder = 1
    NovaAPI.SetSpriteRendererColor(tbRenderer.spr_body, Color(1, 1, 1, 0.5))
    NovaAPI.SetSPSortingOrder(tbRenderer.spr_body, 900)
    NovaAPI.SetSpriteRendererColor(tbRenderer.spr_face, Color(1, 1, 1, 0.5))
    NovaAPI.SetSPSortingOrder(tbRenderer.spr_face, 901)
    NovaAPIHotfix.PlayAnimInUI(goModel, "ultra", true, true)
  else
    NovaAPI.SetSpriteRendererColor(tbRenderer.spr_body, Color.white)
    NovaAPI.SetSPSortingOrder(tbRenderer.spr_body, 0)
    NovaAPI.SetSpriteRendererColor(tbRenderer.spr_face, Color.white)
    NovaAPI.SetSPSortingOrder(tbRenderer.spr_face, 1)
  end
  return trL2D
end

function Actor2DManager.UnsetActor2D_ForActor2DEditor()
  if sTempAssetPath == nil then
    return
  end
  local tbRenderer = GetRenderer(sTempAssetPath, true)
  ResetRenderer(tbRenderer)
  sTempAssetPath = nil
  if goTempL2DIns ~= nil then
    destroy(goTempL2DIns)
    goTempL2DIns = nil
  end
end

function Actor2DManager.SetActor2D_PNG_ForActor2DEditor(nPanelId, trActor2D_PNG, sCharId, sFullPath, s, x, y, sPose)
  local sFullPath_BodyPng, sFullPath_FacePng
  if sPose == nil then
    sFullPath_BodyPng = string.format("%s/atlas_png/a/%s_001.png", sFullPath, sCharId)
    sFullPath_FacePng = string.format("%s/atlas_png/a/%s_002.png", sFullPath, sCharId)
  else
    sFullPath_BodyPng = string.format("%s/atlas_png/%s/%s_%s_001.png", sFullPath, sPose, sCharId, sPose)
    sFullPath_FacePng = string.format("%s/atlas_png/%s/%s_%s_002.png", sFullPath, sPose, sCharId, sPose)
  end
  local spBody = CS.UnityEditor.AssetDatabase.LoadAssetAtPath(sFullPath_BodyPng, typeof(Sprite))
  local spFace = CS.UnityEditor.AssetDatabase.LoadAssetAtPath(sFullPath_FacePng, typeof(Sprite))
  local trPanelOffset = trActor2D_PNG:GetChild(0)
  local tbConfig = mapPanelConfig[nPanelId]
  local _x, _y, _s = 0, 0, 1
  if tbConfig ~= nil then
    _x = tbConfig.v3PanelOffset.x * 100
    _y = tbConfig.v3PanelOffset.y * 100
    _s = tbConfig.v3PanelOffset.z
  end
  if _s <= 0 then
    _s = 1
  end
  trPanelOffset.localPosition = Vector3(_x, _y, 0)
  trPanelOffset.localScale = Vector3(_s, _s, 1)
  local trOffset = trPanelOffset:GetChild(0)
  trOffset.localPosition = Vector3(x, y, 0)
  trOffset.localScale = Vector3(s, s, 1)
  local imgBody = trOffset:GetChild(0):GetComponent("Image")
  local imgFace = trOffset:GetChild(1):GetComponent("Image")
  NovaAPI.SetImageSpriteAsset(imgBody, spBody)
  NovaAPI.SetImageSpriteAsset(imgFace, spFace)
  NovaAPI.SetImageNativeSize(imgBody)
  NovaAPI.SetImageNativeSize(imgFace)
end

function Actor2DManager.SetL2D_InBBVEditor(rawImg, bIsNpc, nSkinId, bIsCG)
  if goTempL2DIns ~= nil then
    destroy(goTempL2DIns)
    goTempL2DIns = nil
  end
  local sL2DPath, sOffsetPath, tbRenderer
  tbRenderer = tbL2DRenderer[1]
  Set_RawImg(tbRenderer, rawImg)
  if bIsNpc == true then
    local mapSkinData = ConfigTable.GetData("NPCSkin", nSkinId)
    if mapSkinData == nil then
      printError("未找到NPC皮肤数据")
    end
    sL2DPath = mapSkinData.L2D
    sOffsetPath = mapSkinData.Offset
  else
    local mapSkinData = ConfigTable.GetData_CharacterSkin(nSkinId)
    if mapSkinData == nil then
      printError("未找到角色皮肤数据")
    end
    sL2DPath = mapSkinData.L2D
    sOffsetPath = mapSkinData.Offset
    if bIsCG == true then
      local nCGId = mapSkinData.CharacterCG
      local mapCGData = ConfigTable.GetData("CharacterCG", nCGId)
      if mapCGData == nil then
        printError("未找到角色皮肤的CG数据")
      end
      sL2DPath = mapCGData.FullScreenL2D
    end
  end
  local objL2DPrefab = LoadAsset(sL2DPath, Object)
  goTempL2DIns = instantiate(objL2DPrefab, tbRenderer.parent_L2D)
  tbRenderer.parent_L2D.localScale = Vector3.one
  goTempL2DIns.transform:SetLayerRecursively(CS.UnityEngine.LayerMask.NameToLayer("Cam_Layer_4"))
  if bIsCG ~= true then
    local objOffsetAsset = LoadAsset(sOffsetPath, Offset)
    local nX, nY = 0, 0
    local nPanelId = PanelId.MainView
    if bIsNpc == true then
      nPanelId = PanelId.ShopPanel
    end
    local s, x, y = objOffsetAsset:GetOffsetData(nPanelId, indexOfPose("a"), true, nX, nY)
    tbRenderer.trOffset.localPosition = Vector3(x, y, 0)
    tbRenderer.trOffset.localScale = Vector3(s, s, 1)
  else
    tbRenderer.trOffset.localPosition = Vector3.zero
    tbRenderer.trOffset.localScale = Vector3.one
  end
  Actor2DManager.PlayL2DAnim_InBBVEditor("idle", true)
end

function Actor2DManager.PlayL2DAnim_InBBVEditor(sAnimName, bLoop)
  if goTempL2DIns ~= nil then
    Actor2DManager.PlayL2DAnim(goTempL2DIns.transform, sAnimName, bLoop == true, true)
  end
end

function Actor2DManager.DestroyL2D_InBBVEditor()
  if goTempL2DIns ~= nil then
    destroy(goTempL2DIns)
    goTempL2DIns = nil
  end
end

local function getDisc2DAssetsPath(nDiscId, bUseL2D)
  local mapCfg = ConfigTable.GetData("Disc", nDiscId)
  if mapCfg ~= nil then
    local sPath = ""
    if bUseL2D then
      sPath = mapCfg.DiscBg .. AllEnum.DiscBgSurfix.L2d
      if GameResourceLoader.ExistsAsset(Settings.AB_ROOT_PATH .. sPath .. ".prefab") then
        return AllEnum.Disc2DType.L2D, sPath
      end
      sPath = mapCfg.DiscBg .. AllEnum.DiscBgSurfix.Main
      if GameResourceLoader.ExistsAsset(Settings.AB_ROOT_PATH .. sPath .. ".prefab") then
        return AllEnum.Disc2DType.Main, sPath
      end
    end
    sPath = mapCfg.DiscBg .. AllEnum.DiscBgSurfix.Image
    if GameResourceLoader.ExistsAsset(sRootPath .. sPath .. ".png") then
      return AllEnum.Disc2DType.Base, sPath
    end
  end
  return 0, ""
end

local function SetDiscL2D(sL2D, rawImg, nIndex)
  local tbRenderer = GetRenderer(sL2D, false, nIndex)
  if tbRenderer == nil then
    return
  end
  if tbRenderer.sL2D == nil then
    local trIns, bIsNew = GetL2DIns(sL2D)
    if trIns == nil then
      printError("未找到根节点")
    end
    tbRenderer.sL2D = sL2D
    tbRenderer.trL2DIns = trIns
    if bIsNew == true then
      trIns:SetLayerRecursively(tbRenderer.nLayerIndex)
    end
    SetL2DInsParent(trIns, tbRenderer.parent_L2D)
  end
  local v3TargetLocalPos = Vector3(0, 0, 0)
  local v3TargetLocalScale = Vector3.one
  tbRenderer.trOffset.localPosition = v3TargetLocalPos
  tbRenderer.trOffset.localScale = v3TargetLocalScale
  tbRenderer.parent_L2D.localScale = Vector3.one
  tbRenderer.trFreeDrag.localPosition = Vector3.zero
  tbRenderer.trFreeDrag.localScale = Vector3.one
  Set_RawImg(tbRenderer, rawImg)
end

local function SetDiscPortrait(sPortrait, rawImg, nIndex)
  local tbRenderer = GetRenderer(sPortrait, false, nIndex)
  if tbRenderer == nil then
    printError("未找到 Renderer")
  end
  if tbRenderer.sL2D == nil then
    NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_body, GetSprite(sPortrait, sPortrait, true))
    NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_face, nil)
    tbRenderer.sL2D = sPortrait
  end
  local v3TargetLocalPos = Vector3(0, 0, 0)
  local v3TargetLocalScale = Vector3.one
  tbRenderer.trOffset.localPosition = v3TargetLocalPos
  tbRenderer.trOffset.localScale = v3TargetLocalScale
  tbRenderer.parent_PNG.localScale = Vector3.one
  tbRenderer.trFreeDrag.localPosition = Vector3.zero
  tbRenderer.trFreeDrag.localScale = Vector3.one
  Set_RawImg(tbRenderer, rawImg)
end

function Actor2DManager.SetDisc2D(nDiscId, rawImg, bUseL2D, nIndex)
  if mapActor2DType["1"] ~= true then
    LoadLocalData()
  end
  if nIndex == nil then
    nIndex = 1
  end
  local mapCurDisc = mapCurrent.tbDisc[nIndex]
  if mapCurrent.L2DType == L2DType.Char then
    Actor2DManager.UnsetActor2D(true, nIndex)
  elseif mapCurrent.L2DType == L2DType.Disc then
    Actor2DManager.UnSetDisc2D(true, nIndex)
  elseif mapCurrent.L2DType == L2DType.CG then
    Actor2DManager.UnSetCg2D(true, nIndex)
  end
  local bL = LocalSettingData.mapData.UseLive2D and bUseL2D
  local nType, sPath = getDisc2DAssetsPath(nDiscId, bL)
  if nType == 0 then
    print("找不到星盘资源！！！nDiscId = " .. nDiscId)
    return
  end
  if nType == AllEnum.Disc2DType.Main or nType == AllEnum.Disc2DType.L2D then
    sPath = sPath .. ".prefab"
    SetDiscL2D(sPath, rawImg, nIndex)
  else
    SetDiscPortrait(sPath, rawImg, nIndex)
  end
  mapCurDisc.nDiscId = nDiscId
  mapCurDisc.sAssetPath = sPath
  mapCurDisc.rawImg = rawImg
  mapCurrent.nPanelId = 0
  mapCurrent.nOffsetPanelId = 0
  mapCurrent.nActor2DType = 0
  mapCurrent.bUseL2D = nType == AllEnum.Disc2DType.L2D
  mapCurrent.bUseFull = false
  mapCurrent.L2DType = L2DType.Disc
  if nType == AllEnum.Disc2DType.L2D then
    Actor2DManager.PlayAnim("idle", true, nIndex)
  end
end

function Actor2DManager.UnSetDisc2D(bKeepData, nIndex, bForce)
  if not mapCurrent.L2DType == L2DType.Disc then
    return
  end
  if nIndex == nil then
    nIndex = 1
  end
  local mapCurDisc = mapCurrent.tbDisc[nIndex]
  if type(mapCurDisc.sAssetPath) == "string" and mapCurDisc.sAssetPath ~= "" then
    local tbRenderer = GetRenderer(mapCurDisc.sAssetPath, true)
    if tbRenderer ~= nil then
      ResetRenderer(tbRenderer)
    end
  end
  if bForce == true and nIndex ~= nil and tbL2DRenderer ~= nil and tbL2DRenderer[nIndex] ~= nil then
    UnInit_RT(tbL2DRenderer[nIndex])
  end
  if bKeepData ~= true then
    mapCurDisc.nDiscId = 0
    mapCurDisc.sAssetPath = nil
    mapCurDisc.rawImg = nil
    mapCurrent.nType = 0
  end
  mapCurrent.L2DType = L2DType.None
end

local function getCg2DAssetsPath(nCgId, bUseL2D)
  local mapCfg = ConfigTable.GetData("MainScreenCG", nCgId)
  if mapCfg ~= nil then
    local sPath = ""
    if bUseL2D then
      sPath = mapCfg.FullScreenL2D
      if GameResourceLoader.ExistsAsset(Settings.AB_ROOT_PATH .. sPath .. ".prefab") then
        return AllEnum.Cg2DType.L2D, sPath
      end
    end
    local tbResource = PlayerData.Handbook:GetPlotResourcePath(nCgId)
    sPath = tbResource.FullScreenImg
    if GameResourceLoader.ExistsAsset(sRootPath .. sPath .. ".png") then
      return AllEnum.Cg2DType.Base, sPath
    end
  end
  return 0, ""
end

local function SetCgL2D(sL2D, rawImg, nIndex)
  local tbRenderer = GetRenderer(sL2D, false, nIndex)
  if tbRenderer == nil then
    return
  end
  if tbRenderer.sL2D == nil then
    local trIns, bIsNew = GetL2DIns(sL2D)
    if trIns == nil then
      printError("未找到根节点")
    end
    tbRenderer.sL2D = sL2D
    tbRenderer.trL2DIns = trIns
    if bIsNew == true then
      trIns:SetLayerRecursively(tbRenderer.nLayerIndex)
    end
    SetL2DInsParent(trIns, tbRenderer.parent_L2D)
  end
  local v3TargetLocalPos = Vector3(0, 0, 0)
  local v3TargetLocalScale = Vector3.one
  tbRenderer.trOffset.localPosition = v3TargetLocalPos
  tbRenderer.trOffset.localScale = v3TargetLocalScale
  tbRenderer.parent_L2D.localScale = Vector3.one
  tbRenderer.trFreeDrag.localPosition = Vector3.zero
  tbRenderer.trFreeDrag.localScale = Vector3.one
  Set_RawImg(tbRenderer, rawImg)
end

local function SetCgPortrait(sPortrait, rawImg, nIndex)
  local tbRenderer = GetRenderer(sPortrait, false, nIndex)
  if tbRenderer == nil then
    printError("未找到 Renderer")
  end
  if tbRenderer.sL2D == nil then
    NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_body, GetSprite(sPortrait, sPortrait, true))
    NovaAPI.SetSpriteRendererSprite(tbRenderer.spr_face, nil)
    tbRenderer.sL2D = sPortrait
  end
  local v3TargetLocalPos = Vector3(0, 0, 0)
  local v3TargetLocalScale = Vector3.one
  tbRenderer.trOffset.localPosition = v3TargetLocalPos
  tbRenderer.trOffset.localScale = v3TargetLocalScale
  tbRenderer.parent_PNG.localScale = Vector3.one
  tbRenderer.trFreeDrag.localPosition = Vector3.zero
  tbRenderer.trFreeDrag.localScale = Vector3.one
  Set_RawImg(tbRenderer, rawImg)
end

function Actor2DManager.SetCg2D(nCgId, rawImg, bUseL2D, nIndex)
  if mapActor2DType["1"] ~= true then
    LoadLocalData()
  end
  if nIndex == nil then
    nIndex = 1
  end
  local mapCurCg = mapCurrent.tbCg[nIndex]
  if mapCurrent.L2DType == L2DType.Char then
    Actor2DManager.UnsetActor2D(true, nIndex)
  elseif mapCurrent.L2DType == L2DType.Disc then
    Actor2DManager.UnSetDisc2D(true, nIndex)
  elseif mapCurrent.L2DType == L2DType.CG then
    Actor2DManager.UnSetCg2D(true, nIndex)
  end
  local bL = LocalSettingData.mapData.UseLive2D and bUseL2D
  local nType, sPath = getCg2DAssetsPath(nCgId, bL)
  if nType == 0 then
    print("找不到CG资源！！！nCgId = " .. nCgId)
    return
  end
  if nType == AllEnum.Cg2DType.L2D then
    sPath = sPath .. ".prefab"
    SetCgL2D(sPath, rawImg, nIndex)
  else
    SetCgPortrait(sPath, rawImg, nIndex)
  end
  mapCurCg.nCgId = nCgId
  mapCurCg.sAssetPath = sPath
  mapCurCg.rawImg = rawImg
  mapCurrent.nPanelId = 0
  mapCurrent.nOffsetPanelId = 0
  mapCurrent.nActor2DType = 0
  mapCurrent.bUseL2D = nType == AllEnum.Cg2DType.L2D
  mapCurrent.bUseFull = true
  mapCurrent.L2DType = L2DType.CG
  if nType == AllEnum.Cg2DType.L2D then
    Actor2DManager.PlayAnim("idle", true, nIndex)
  end
end

function Actor2DManager.UnSetCg2D(bKeepData, nIndex, bForce)
  if not mapCurrent.L2DType == L2DType.CG then
    return
  end
  if nIndex == nil then
    nIndex = 1
  end
  local mapCurCg = mapCurrent.tbCg[nIndex]
  if type(mapCurCg.sAssetPath) == "string" and mapCurCg.sAssetPath ~= "" then
    local tbRenderer = GetRenderer(mapCurCg.sAssetPath, true)
    if tbRenderer ~= nil then
      ResetRenderer(tbRenderer)
    end
  end
  if bForce == true and nIndex ~= nil and tbL2DRenderer ~= nil and tbL2DRenderer[nIndex] ~= nil then
    UnInit_RT(tbL2DRenderer[nIndex])
  end
  if bKeepData ~= true then
    mapCurCg.nCgId = 0
    mapCurCg.sAssetPath = nil
    mapCurCg.rawImg = nil
    mapCurrent.nType = 0
  end
  mapCurrent.L2DType = L2DType.None
end

return Actor2DManager
