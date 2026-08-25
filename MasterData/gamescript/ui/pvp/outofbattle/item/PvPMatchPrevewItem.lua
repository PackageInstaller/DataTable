local PvPMatchPrevewItem, Super = System.NewComponent("PvPMatchPrevewItem")

function PvPMatchPrevewItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_lineupResource(uiNode)
  self.awakerData = data.awakerData
  self.collectTid = data.awakerData.tid
  self.curSkin = data.awakerData.curSkin
  self.isMine = data.isMine
  if ApplicationUtils.is_debug_mode() then
    Logger.Info("[PvPMatchPrevewItem] 匹配数据 awakerData: tid=%s curSkin=%s likeLevel=%s raw=|%s|", tostring(data.awakerData.tid), tostring(data.awakerData.curSkin), tostring(data.awakerData.likeLevel), table.tostring(data.awakerData))
  end
end

function PvPMatchPrevewItem:OnBind(binder)
  self.binder = binder
  local portraitAlign = CommonDefine.PortraitAlign.Center
  local awakerId = PvpCollectCfgUtils.GetAwakerTidByCollectTid(self.collectTid)
  if awakerId then
    local skinRes = AwakerSkinUtils.GetSkinResNum(self.curSkin)
    binder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker, awakerId, skinRes, nil, portraitAlign))
  end
  if self.ui.Image_AwakerFavor then
    binder:BindToVisible(self.ui.Image_AwakerFavor, function()
      if not awakerId then
        if ApplicationUtils.is_debug_mode() then
          Logger.Info("[PvPMatchPrevewItem] 曜闪判定: awakerId=nil 不显示")
        end
        return false
      end
      if not self.isMine and not self.awakerData.likeLevel then
        if ApplicationUtils.is_debug_mode() then
          Logger.Info("[PvPMatchPrevewItem] 曜闪判定: 敌方无 likeLevel 不显示 awakerId=%s", tostring(awakerId))
        end
        return false
      end
      local awakerData = self.awakerData.likeLevel and self.awakerData or nil
      local isUnlocked = FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(awakerId, awakerData)
      if ApplicationUtils.is_debug_mode() then
        Logger.Info("[PvPMatchPrevewItem] 曜闪判定: isMine=%s awakerId=%s awakerData.likeLevel=%s isUnlocked=%s", tostring(self.isMine), tostring(awakerId), tostring(self.awakerData.likeLevel), tostring(isUnlocked))
      end
      return isUnlocked
    end)
  end
  self.ui.Image_Awaken:SetActive(false)
  binder:BindToImage(self.ui.Image_Positioning_Frame, function()
    local awakerConfig = AwakerDataUtils.GetAwakerConfig(awakerId)
    if not awakerConfig then
      return
    end
    local posConfig = PVPPositionCfgUtils.GetCfg(awakerConfig.PVPPosition)
    return posConfig and posConfig.CollectPositionColour
  end)
end

return PvPMatchPrevewItem
