local ArticleEffectComponent, Super = System.NewClass("ArticleEffectComponent", Component)

function ArticleEffectComponent:ctor()
  Super.ctor(self)
  self.player = RoleManager.Instance:GetRole(DataCenter.playerData.DRole.uid)
end

function ArticleEffectComponent:Awake(binder)
  Super.Awake(self)
  self.avatar = self.parent:GetComponent(ArticleAvatarComponent)
  self.isHasTrigger = false
end

function ArticleEffectComponent:Trigger(callback)
  local obj = self.avatar:GetGameObject()
  if obj then
    local config = DT.MapArticleConfig[self.parent.tid]
    assert(config, string.format("DT.MapArticleConfig[%d] is nil", self.parent.tid))
    if 1 == config.ScriptType then
      obj:GetComponent(DT.MapArticleConfig[self.parent.tid].ScriptName):SetLuaEnd(callback)
      if self.player == nil then
        self.player = RoleManager.Instance:GetRole(DataCenter.playerData.DRole.uid)
      end
      local avatarLoc = self.avatar:GetPosition()
      local playerLoc = self.player:GetPosition()
      obj:GetComponent(DT.MapArticleConfig[self.parent.tid].ScriptName):TriggerEffect(avatarLoc, playerLoc)
    elseif 2 == config.ScriptType then
      require("World.Map.MapArticle." .. config.ScriptName):Trigger(obj)
    end
    self.isHasTrigger = true
  end
end

function ArticleEffectComponent:OnDestroy()
  Super.OnDestroy(self)
  if self.isHasTrigger then
    MapDataUtils.SetArticleState(self.parent.uid, false)
  end
end

return ArticleEffectComponent
