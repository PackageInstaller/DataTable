local CraftingPanel = class("CraftingPanel", BasePanel)
CraftingPanel._tbDefine = {
  {
    sPrefabPath = "Crafting/CraftingPanel.prefab",
    sCtrlName = "Game.UI.Crafting.CraftingCtrl"
  }
}

function CraftingPanel:Awake()
end

function CraftingPanel:OnEnable()
end

function CraftingPanel:OnDisable()
end

function CraftingPanel:OnDestroy()
end

return CraftingPanel
