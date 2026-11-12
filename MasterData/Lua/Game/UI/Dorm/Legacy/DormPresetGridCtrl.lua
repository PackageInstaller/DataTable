local DormPresetGridCtrl = class("DormPresetGridCtrl", BaseCtrl)
DormPresetGridCtrl._mapNodeConfig = {
  imgSelect = {},
  TMPTempName = {sComponentName = "TMP_Text"}
}
DormPresetGridCtrl._mapEventConfig = {}
DormPresetGridCtrl._mapRedDotConfig = {}

function DormPresetGridCtrl:Awake()
  self.nItemId = 0
  self.nItemCount = 0
end

function DormPresetGridCtrl:FadeIn()
end

function DormPresetGridCtrl:FadeOut()
end

function DormPresetGridCtrl:OnEnable()
end

function DormPresetGridCtrl:OnDisable()
end

function DormPresetGridCtrl:OnDestroy()
end

function DormPresetGridCtrl:OnRelease()
end

function DormPresetGridCtrl:Refresh(sName)
  NovaAPI.SetTMPText(self._mapNode.TMPTempName, sName)
end

function DormPresetGridCtrl:SetSelect(bSelected)
  self._mapNode.imgSelect:SetActive(bSelected)
end

function DormPresetGridCtrl:SetCount(nCount)
end

return DormPresetGridCtrl
