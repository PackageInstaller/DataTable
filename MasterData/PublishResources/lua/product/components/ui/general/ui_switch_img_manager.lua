_class("UISwitchImgManager", Singleton)
UISwitchImgManager = UISwitchImgManager

function UISwitchImgManager.Show()
  Log.debug("[ui] UISwitchImgManager.Show")
  UISwitchImgManager:GetInstance():_Show(true)
end

function UISwitchImgManager.Hide()
  Log.debug("[ui] UISwitchImgManager.Hide")
  UISwitchImgManager:GetInstance():_Show(false)
end

function UISwitchImgManager:Init(uiRootGameObject)
  self._imageRoot = uiRootGameObject.transform:Find("UICameras/depth_high/UI/SwitchImgCanvas/RawImage").gameObject
  self._blurhelper = self._imageRoot:GetComponent("H3DUIBlurHelper")
end

function UISwitchImgManager:_Show(bshow)
  if bshow then
    self._imageRoot:SetActive(true)
    self._blurhelper:BlurTexture(UnityEngine.Screen.width, UnityEngine.Screen.height, 0)
  elseif self._imageRoot.activeSelf then
    self._imageRoot:SetActive(false)
  end
end
