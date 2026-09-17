local this = class("pageTemplateTip", G_UIPageBase)

function this.bind()
  return {
    module_commonTipLarge = L_Const.ModuleInfo.ModuleCommonTip,
    inputName = "",
    inputMaxNum = 0,
    go_whitecut = nil
  }
end

function this.methods()
  return {
    module_commonTipLarge = {
      onClick_close = function(self)
        self:closeSelf(self.close_cb)
      end,
      onClick_cancel = function(self)
        self:closeSelf(self.cancel_cb)
      end,
      onClick_confirm = function(self)
        C_AudioManager.Play("Play_SFX_System_UI_General_Comfirm_L2")
        if self.ok_cb then
          CS.Azur.Gameplay.Core.Net.NetManager.ShowNetMask("uploadPhotoTemplate")
          local tex = self.rt:ToTexture2D()
          self.ok_cb(self.name, tex, function(succ)
            CS.Azur.Gameplay.Core.Net.NetManager.HideNetMask("uploadPhotoTemplate")
            if succ then
              self:closeSelf()
            else
            end
          end)
        else
          self:closeSelf()
        end
      end,
      onClick_bg = function(self)
        self:closeSelf(self.close_cb)
      end
    },
    onChangeName = function(self, setStr)
      if not string.isEmpty(setStr) and self.name ~= setStr then
        setStr = CS.Lens.Framework.UI.LTextMeshProUtilty.UnicodeWhiteFilter(setStr, 1)
        self.name = C_LuaUtility.StringSub(setStr, 0, L_PhotoStore.tempRenameMaxNum)
        self.bind.inputName = self.name
      end
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:initCommonTipModule()
  self.ok_cb = options.ok_cb
  self.cancel_cb = options.cancel_cb
  self.close_cb = options.close_cb
  self.rt = options.rt
  self.name = options.name or L_WordsTpl:getValue("ui_pageTemplateTip_04")
  self.openCallback = options.openCallback
  local mat = C_UnityObject.Instantiate(self.bindComponents.rawImage.material)
  mat:EnableKeyword("FIX_TO_GAMMA")
  self.bindComponents.rawImage.material = mat
  self.mat = mat
  self.bindComponents.rawImage.texture = self.rt
  self:autoFit()
  self.bind.inputName = self.name
  self.bind.go_whitecut = true
  if self.openCallback then
    self:openCallback()
  end
  self.bindComponents.blur.enabled = true
  
  local function getter()
    if self.isBind and self.bindComponents.whiteCutCanvasGroup then
      return self.bindComponents.whiteCutCanvasGroup.alpha
    end
    return 0
  end
  
  local function setter(r)
    if self.isBind and self.bindComponents.whiteCutCanvasGroup then
      self.bindComponents.whiteCutCanvasGroup.alpha = r
    end
  end
  
  self.tween = DOTween.To(getter, setter, 0, 0.2):SetEase(Tweening.Ease.Linear):OnComplete(function()
    if L_CommonUtil.isValid(self.tween) then
      self.tween:Kill()
      self.tween = nil
    end
    self.bind.go_whitecut = false
  end)
end

function this:show()
end

function this:initCommonTipModule()
  local moduleTip = self.modules.module_commonTipLarge
  moduleTip:initModule({
    txtTitle = L_WordsTpl:getValue("ui_pageTemplateTip_03"),
    txtConfirm = L_WordsTpl:getValue("ui_pageTemplateTip_01"),
    txtCancel = L_WordsTpl:getValue("ui_pageTemplateTip_02")
  })
end

function this:autoFit()
  local parentRect = self.bindComponents.imgNode
  local parentWidth = parentRect.rect.size.x
  local parentHeight = parentRect.rect.size.y
  local imgWidth = self.rt.width
  local imgHeight = self.rt.height
  local ratio = imgWidth / imgHeight
  local targetWidth, targetHeight
  if ratio < parentWidth / parentHeight then
    targetWidth = parentWidth
    targetHeight = targetWidth / ratio
  else
    targetHeight = parentHeight
    targetWidth = targetHeight * ratio
  end
  local size = C_Vector2(targetWidth, targetHeight)
  self.bindComponents.rawImage.gameObject:GetComponent(typeof(C_RectTransform)).sizeDelta = size
end

function this:close()
  if self.rt then
    L_PhotoManager:releaseCaptureRT(self.rt)
    self.rt = nil
  end
  if self.mat then
    C_UnityObject.Destroy(self.mat)
    self.mat = nil
  end
  if L_CommonUtil.isValid(self.tween) then
    self.tween:Kill()
    self.tween = nil
  end
end

function this:closeSelf(cb)
  L_UI:close(self.pageName, nil, function()
    if cb then
      cb()
    end
  end)
end

return this
