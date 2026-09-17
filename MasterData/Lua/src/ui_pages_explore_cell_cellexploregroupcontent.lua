local this = class("cellExploreGroupContent", G_UIModuleBase)

function this.bind()
  return {
    toggleModuleGroup = {
      type = "toggleModule",
      moduleExploreGroup_boss = {
        assetName = "UI/Pages/Explore/Group/moduleExploreGroup_boss",
        moduleName = "pages/explore/group/moduleExploreGroup_boss"
      },
      moduleExploreGroup_play = {
        assetName = "UI/Pages/Explore/Group/moduleExploreGroup_play",
        moduleName = "pages/explore/group/moduleExploreGroup_play"
      },
      moduleExploreGroup_sight = {
        assetName = "UI/Pages/Explore/Group/moduleExploreGroup_sight",
        moduleName = "pages/explore/group/moduleExploreGroup_sight"
      }
    },
    toggleModuleName = ""
  }
end

function this.methods()
  return {}
end

function this:open()
  if self.isBind then
    self:initModuleContent(self.bind)
  end
end

function this:initModuleContent(bindData)
  if table.isEmpty(bindData) then
    self.bind.toggleModuleName = ""
    return
  end
  self.bind.toggleModuleName = bindData.module
  self.modules.toggleModuleGroup[bindData.module]:initGroupContent(bindData)
end

function this:refresh()
end

function this:close()
end

return this
