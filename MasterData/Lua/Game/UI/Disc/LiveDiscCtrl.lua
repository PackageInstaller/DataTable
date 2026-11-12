local BaseCtrl = require("GameCore.UI.BaseCtrl")
local LiveDiscCtrl = class("LiveDiscCtrl", BaseCtrl)
local PathType = CS.DG.Tweening.PathType
local LoopType = CS.DG.Tweening.LoopType
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
LiveDiscCtrl._mapNodeConfig = {
  CardDrag = {
    sComponentName = "UIDrag",
    callback = "OnUIDrag_Drag"
  },
  rImgDisc = {sComponentName = "RawImage"},
  btnOpenFull = {
    sNodeName = "CardDrag",
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenFull"
  },
  btnFull = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenFull"
  }
}
LiveDiscCtrl._mapEventConfig = {}

function LiveDiscCtrl:Awake()
  self.bMobile = NovaAPI.IsMobilePlatform()
end

function LiveDiscCtrl:OnEnable()
  self.callback = nil
end

function LiveDiscCtrl:OnDisable()
  self:ClearClickCallback()
  self:ReleaseRawImage()
end

function LiveDiscCtrl:SetDiscActive(bGoActice, bBtnAcitve)
  self._mapNode.rImgDisc.gameObject:SetActive(bGoActice)
  self._mapNode.CardDrag.gameObject:SetActive(not self.bMobile)
  self._mapNode.btnFull.gameObject:SetActive(self.bMobile)
  self._mapNode.btnOpenFull.interactable = bBtnAcitve
  self._mapNode.btnFull.interactable = bBtnAcitve
end

function LiveDiscCtrl:SetClickCallback(callback)
  self.callback = callback
end

function LiveDiscCtrl:ClearClickCallback()
  self.callback = nil
end

function LiveDiscCtrl:SetRawImage(sDiscBg, nRarity)
  local bSSR = nRarity == GameEnum.itemRarity.SSR
  if self.uiRoot == nil then
    self.uiRoot = PanelManager.GetUIRoot()
  end
  if self.goRender == nil then
    local renderPrefab = self:LoadAsset("UI/Disc/Disc_OffScreen_Renderer.prefab")
    self.goRender = instantiate(renderPrefab, self.uiRoot)
    self.camera = self.goRender.transform:Find("----Renderer----/OffScreen2DCamera"):GetComponent("Camera")
    local nScale = self.bMobile and math.floor(Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT * Settings.RENDERTEXTURE_SIZE_FACTOR) or math.floor(2048 * Settings.RENDERTEXTURE_SIZE_FACTOR)
    self.rt2d = GameUIUtils.GenerateRenderTextureFor2D(nScale, nScale)
    self.rt2d.name = "LiveDisc"
    self.camera.targetTexture = self.rt2d
    NovaAPI.SetTexture(self._mapNode.rImgDisc, self.rt2d)
  end
  local discRoot = self.goRender.transform:Find("----Renderer----/Canvas")
  if discRoot.transform.childCount > 0 then
    for i = discRoot.transform.childCount, 1, -1 do
      local obj = discRoot.transform:GetChild(i - 1).gameObject
      destroyImmediate(obj)
    end
  end
  local discPrefab
  local sRootPath = Settings.AB_ROOT_PATH
  if type(sDiscBg) == "string" and sDiscBg ~= "" then
    local sPrefab = sDiscBg .. AllEnum.DiscBgSurfix.Card .. ".prefab"
    if GameResourceLoader.ExistsAsset(sRootPath .. sPrefab) == true then
      discPrefab = self:LoadAsset(sPrefab)
    end
  end
  local bNoneAsset = false
  if discPrefab == nil then
    discPrefab = self:LoadAsset("Disc/Common/Common.prefab")
    bNoneAsset = true
  end
  if discPrefab then
    local goDisc = instantiate(discPrefab, discRoot)
    if not bSSR or bNoneAsset then
      goDisc.transform.localPosition = Vector3(0, -11, 0)
      local imgIcon = goDisc.transform:Find("layer_-1/icon"):GetComponent("Image")
      local imgFrame = goDisc.transform:Find("layer_-1/frame"):GetComponent("Image")
      self:SetPngSprite(imgIcon, sDiscBg .. AllEnum.DiscBgSurfix.Image)
      self:SetSprite_FrameColor(imgFrame, nRarity, AllEnum.FrameType_New.SuperscriptDB, true)
    end
    self.trTarget = goDisc.transform:Find("Gyroscope/Target").transform
    NovaAPI.SetComponentEnable(self.trTarget:GetComponent("Image"), false)
    NovaAPI.SetComponentEnable(goDisc.transform:Find("Gyroscope/Axis"):GetComponent("Image"), false)
    if not self.bMobile then
      self.trTarget.localPosition = Vector3(-8, 0, 0)
      local tbPath = {
        [1] = Vector3(-8, 0, 0),
        [2] = Vector3(8, 0, 0)
      }
      local nTime = 8
      if self.tweener then
        self.tweener:Kill()
        self.tweener = nil
      end
      self.tweener = self.trTarget:DOLocalPath(tbPath, nTime, PathType.Linear):SetLoops(-1, LoopType.Yoyo):SetEase(Ease.InOutSine):SetUpdate(true)
    end
  end
end

function LiveDiscCtrl:ReleaseRawImage()
  if self.camera and self.camera:IsNull() == false then
    self.camera.targetTexture = nil
    self.camera = nil
  end
  NovaAPI.SetTexture(self._mapNode.rImgDisc, nil)
  if self.rt2d then
    GameUIUtils.ReleaseRenderTexture(self.rt2d)
    self.rt2d = nil
  end
  if self.goRender then
    destroy(self.goRender)
    self.goRender = nil
  end
  if self.tweener then
    self.tweener:Kill()
    self.tweener = nil
  end
end

function LiveDiscCtrl:OnUIDrag_Drag(mDrag)
  if self.bMobile then
    return
  end
  
  local function clamp(value, min, max)
    if value < min then
      value = min
    elseif max < value then
      value = max
    end
    return value
  end
  
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.bStartDrag = true
    if self.tweener then
      self.tweener:Pause()
    end
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    if true == self.bStartDrag then
      local nX = self.trTarget.localPosition.x + (mDrag.EventData.delta.x or 0)
      local nY = self.trTarget.localPosition.y + (mDrag.EventData.delta.y or 0)
      nX = clamp(nX, -100, 100)
      nY = clamp(nY, -100, 100)
      self.trTarget.localPosition = Vector3(nX, nY, 0)
    end
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    self.bStartDrag = false
    self.trTarget.localPosition = Vector3(0, 0, 0)
    if self.tweener then
      self.tweener:Play()
    end
  end
end

function LiveDiscCtrl:GetCanOpenFullState()
  return not self.bStartDrag
end

function LiveDiscCtrl:OnBtnClick_OpenFull()
  if self.bStartDrag then
    return
  end
  EventManager.Hit("ClickLiveDisc")
  if self.callback then
    self.callback()
  end
end

return LiveDiscCtrl
