local UITMPAssetsMgr, Super = System.NewClass("UITMPAssetsMgr", Manager)

function UITMPAssetsMgr:ctor()
  Super.ctor(self)
end

function UITMPAssetsMgr:Awake()
  Super.Awake(self)
  CS.TMPSpriteAssetsMgr.Release()
  CS.TMPFontAssetsMgr.Release()
  CS.TMPSpriteAssetsMgr.Init("UI/SpriteAssets/")
  CS.TMPFontAssetsMgr.Init("UI/UI_Font/", "UX_Text_FZBeiWeiKaiShu")
end

function UITMPAssetsMgr:OnDestroy()
  Super.OnDestroy(self)
  CS.TMPSpriteAssetsMgr.Release()
  CS.TMPFontAssetsMgr.Release()
end

return UITMPAssetsMgr
