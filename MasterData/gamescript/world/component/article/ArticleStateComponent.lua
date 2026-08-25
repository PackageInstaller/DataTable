local ArticleStateComponent, Super = System.NewClass("ArticleStateComponent", Component)

function ArticleStateComponent:ctor()
  Super.ctor(self)
end

function ArticleStateComponent:Awake(binder)
  Super.Awake(self)
  self.avatar = self.parent:GetComponent(ArticleAvatarComponent)
  binder:BindToRaw(function(own, n, o)
    if n then
      self.avatar:InitAvatar()
      if self.parent.triggerCp then
        self.parent.triggerCp:AddTriggerCondition()
      end
    else
      if self.parent.triggerCp then
        self.parent.triggerCp:DestroyTirggerCondition()
      end
      self.avatar:DestroyAvatar()
    end
  end, function()
    do return MapDataUtils.GetArticleState end
    return MapDataUtils.GetArticleState, self.parent.uid
  end)
end

function ArticleStateComponent:OnDestroy()
  Super.OnDestroy(self)
end

return ArticleStateComponent
