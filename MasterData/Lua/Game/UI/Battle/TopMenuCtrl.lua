local TopMenuCtrl = class("TopMenuCtrl", BaseCtrl)
TopMenuCtrl._mapNodeConfig = {
  txt_boxSmallCount = {sComponentName = "TMP_Text"},
  txt_boxMediumCount = {sComponentName = "TMP_Text"}
}
TopMenuCtrl._mapEventConfig = {
  RefreshBoxCount = "OnEvent_SetBoxCount"
}

function TopMenuCtrl:Awake()
  NovaAPI.SetTMPSourceText(self._mapNode.txt_boxSmallCount, "0/0")
  NovaAPI.SetTMPSourceText(self._mapNode.txt_boxMediumCount, "0/0")
end

function TopMenuCtrl:OnEnable()
end

function TopMenuCtrl:OnDisable()
end

function TopMenuCtrl:OnDestroy()
end

function TopMenuCtrl:OnRelease()
end

function TopMenuCtrl:OnEvent_SetBoxCount(nType, nTotalCount, nCurCount)
  if nType == 1 then
    local str
    if 0 < nCurCount then
      str = string.format("<color=#70f1ce>%d</color>/%d", nCurCount, nTotalCount)
    else
      str = string.format("%d/%d", nCurCount, nTotalCount)
    end
    NovaAPI.SetTMPSourceText(self._mapNode.txt_boxSmallCount, str)
  else
    local str
    if 0 < nCurCount then
      str = string.format("<color=#70f1ce>%d</color>/%d", nCurCount, nTotalCount)
    else
      str = string.format("%d/%d", nCurCount, nTotalCount)
    end
    NovaAPI.SetTMPSourceText(self._mapNode.txt_boxMediumCount, str)
  end
end

return TopMenuCtrl
