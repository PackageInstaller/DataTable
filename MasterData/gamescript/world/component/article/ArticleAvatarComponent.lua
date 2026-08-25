local ArticleAvatarComponent, Super = System.NewClass("ArticleAvatarComponent", Component, IUpdater)

function ArticleAvatarComponent:ctor()
  Super.ctor(self)
end

function ArticleAvatarComponent:Awake(binder)
  Super.Awake(self)
end

function ArticleAvatarComponent:InitAvatar()
end

function ArticleAvatarComponent:GetPosition()
  return self.pos
end

function ArticleAvatarComponent:DestroyAvatar()
end

function ArticleAvatarComponent:GetGameObject()
  return self.gameObject
end

function ArticleAvatarComponent:GetTriggerGameObject()
  return self.triggerGameObject or self.gameObject
end

function ArticleAvatarComponent:FindGameObject(name)
  do return UIRootMgr.FindChild, self.transform end
  return UIRootMgr.FindChild, self.transform, name
end

function ArticleAvatarComponent:OnDestroy()
  Super.OnDestroy(self)
  self:DestroyAvatar()
end

return ArticleAvatarComponent
