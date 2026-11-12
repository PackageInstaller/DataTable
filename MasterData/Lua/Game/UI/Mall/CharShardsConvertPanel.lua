local BasePanel = require("GameCore.UI.BasePanel")
local CharShardsConvertPanel = class("CharShardsConvertPanel", BasePanel)
CharShardsConvertPanel._bIsMainPanel = false
CharShardsConvertPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
CharShardsConvertPanel._tbDefine = {
  {
    sPrefabPath = "Mall/CharShardsConvertPanel.prefab",
    sCtrlName = "Game.UI.Mall.CharShardsConvertCtrl"
  }
}

function CharShardsConvertPanel:Awake()
end

function CharShardsConvertPanel:OnEnable()
end

function CharShardsConvertPanel:OnDisable()
end

function CharShardsConvertPanel:OnDestroy()
end

function CharShardsConvertPanel:OnRelease()
end

return CharShardsConvertPanel
