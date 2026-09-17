local this = class("pageSoulEssenceStarUpSuccess", G_UIPageBase)
local _soulessenceTpl = L_GameTpl:getSoulessenceTpl()

function this.bind()
  return {
    list_star = {
      moduleName = "pages/heroPanel/spirit/cellSpiritStar"
    },
    moduleSuccessTips = {
      moduleName = "modulePages/moduleSuccessTip"
    },
    txtDescribe = "",
    icon = nil
  }
end

function this.methods()
  return {
    onClick_closeUpStarSucceed = function(self)
      if self.callback then
        self.callback()
      end
      L_UI:close(self.pageName)
    end
  }
end

function this:open(...)
end

function this:close()
end

function this:preOpen(options)
  self.spiritGuid = options.spiritGuid
  self.curStar = options.curStar
  self.afterStar = options.afterStar - 1
  self:upStarSucceed()
end

function this:upStarSucceed()
  if not math.isEmpty(self.spiritGuid) then
    local currData = C_SoulEssenceMgr:getsoulessenceItem(self.spiritGuid, false)
    local tpl = _soulessenceTpl:getTplById(currData.soulEssenceId)
    self.bind.icon = _soulessenceTpl:getAvatarTexture(tpl, 1)
    printf("curStar", self.afterStar)
    local tmp = {}
    for i = 1, L_Const.SpiritronFullStar - 1 do
      local activeStar = i <= self.afterStar
      local greyStarActive = i > self.afterStar
      table.insert(tmp, {starActive = activeStar, greyStarActive = greyStarActive})
    end
    self.bind.list_star:clear()
    self.bind.list_star:insert_array(tmp)
    self.bind.txtDescribe = C_SoulEssenceMgr:getExclusiveSkill(currData.soulEssenceId, self.afterStar).skillDesc
  end
end

return this
