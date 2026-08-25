local MapArticleManager, Super = System.NewClass("MapArticleManager", Manager, IUpdater)

function MapArticleManager:ctor()
  Super.ctor(self)
  self.articleList = {}
end

function MapArticleManager:Awake(binder)
  Super.Awake(self)
  self:CreatAllArticle()
end

function MapArticleManager:CreatAllArticle()
  for _, value in pairs(DT.MapArticleConfig) do
    if value.MapID == MapManager.Instance:GetMapTid() and not MapDataUtils.GetArticle(value.ID) then
      MapDataUtils.AddArticleInfo(value.ID, value.ID, true)
    end
  end
  for _, value in pairs(DataCenter.mapData.MapArticleInfos) do
    local nodeInfo = MapManager.Instance:GetNodeInfoByKeyId(DT.MapArticleConfig[value.tid].KeyID)
    if nodeInfo and value.state then
      self:CreateArticle(value.uid, value.tid)
    end
  end
end

function MapArticleManager:CreateArticle(uid, tid)
  local article = MapArticle(uid, tid)
  article:Awake()
  self.articleList[uid] = article
  Logger.Debug("article Awake articleUid = %s tid=%s", uid, tid)
  return article
end

function MapArticleManager:RemoveArticle(uid)
  if self.articleList[uid] then
    self.articleList[uid]:Destroy()
    self.articleList[uid] = nil
  end
end

function MapArticleManager:Update()
  for _, value in pairs(self.articleList) do
    if not value:isDestroyed() then
      value:Update()
    end
  end
end

function MapArticleManager:TriggerArticle(uid)
  if self.articleList[uid] then
    self.articleList[uid]:TriggerEffect(function()
      local config = DT.MapArticleConfig[self.articleList[uid].tid]
      if config.Repeat and 1 == config.Repeat then
        return
      end
      MapDataUtils.SetArticleState(uid, false)
    end)
  end
end

function MapArticleManager:RemoveAllArticle()
  for _, value in pairs(self.articleList) do
    value:Destroy()
  end
  self.articleList = {}
end

function MapArticleManager:OnDestroy()
  Super.OnDestroy(self)
  self:RemoveAllArticle()
end

return MapArticleManager
