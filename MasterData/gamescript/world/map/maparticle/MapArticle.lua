local MapArticle, Super = System.NewClass("MapArticle", ActorEntity)

function MapArticle:ctor(uid, tid)
  Super.ctor(self, uid, tid)
end

function MapArticle:Awake()
  self.AvatarCp = self:AddComponent(ArticleAvatarComponent)
  self:AddComponent(ArticleStateComponent)
end

function MapArticle:AsyncLoadEnd()
  self.triggerCp = self:AddComponent(AritcleTriggerComponent)
  self.effectCp = self:AddComponent(ArticleEffectComponent)
  Super.AsyncLoadEnd(self)
end

function MapArticle:InitError()
  if not self.AvatarCp then
    self.AvatarCp = self:GetComponent(ArticleAvatarComponent)
  end
end

function MapArticle:GetPosition()
  self:InitError()
  do return self.AvatarCp.GetPosition end
  return self.AvatarCp.GetPosition, self.AvatarCp
end

function MapArticle:GetGameObject()
  self:InitError()
  do return self.AvatarCp.GetTriggerGameObject end
  return self.AvatarCp.GetTriggerGameObject, self.AvatarCp
end

function MapArticle:TriggerEffect(callback)
  self.effectCp:OnGearClick(callback)
end

function MapArticle:Destroy()
  Super.Destroy(self)
end

return MapArticle
