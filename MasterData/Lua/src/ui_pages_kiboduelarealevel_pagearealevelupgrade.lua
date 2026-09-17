local page = class("pageAreaLevelUpgrade", G_UIPageBase)
local _areaTypeTpl = L_GameTpl:getKiboDuelAreaTypeTpl()
local _areaLeveTpl = L_GameTpl:getKiboDuelAreaLevelTpl()

function page.bind()
  return {
    btnClose = true,
    txtAreaName = "",
    imgCurLvl = "",
    imgAreaIcon1 = "",
    imgNewLvl = "",
    imgAreaIcon = "",
    txtAreaLevelName = ""
  }
end

function page.methods()
  return {
    closeBtn = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function page:debugTestData()
  return {
    areaType = 1,
    fromLv = 1,
    toLv = 2
  }
end

function page:preOpen(options)
  options = options or self:debugTestData()
  page.super.preOpen(self, options)
  self._areaType = options.areaType
  self._fromLv = options.fromLv
  self._toLevel = options.toLv
  self._forceDuration = 3
  self:refresh()
end

function page:open()
  page.super.open(self)
end

function page:startShowTimer()
  self:newOrResetTimer(self.pageName, function()
    if self.bind then
      self.bind.btnClose = true
    end
  end, self._forceDuration)
end

function page:refresh()
  if not (self._areaType and self._fromLv) or not self._toLevel then
    return
  end
  local areaTypeTpl = _areaTypeTpl:getTplById(self._areaType)
  local areaName = _areaTypeTpl:getName(areaTypeTpl)
  local areaIcon = _areaTypeTpl:getUIIcon(areaTypeTpl)
  local fromLvNumIcon = _areaLeveTpl:getResLevelNumByType(self._areaType, self._fromLv)
  local toLvNumIcon = _areaLeveTpl:getResLevelNumByType(self._areaType, self._toLevel)
  local areaLevelName = table.concat({
    L_Lang:get(areaName),
    L_Const.Number2Roma[self._toLevel]
  })
  self.bind.txtAreaName = areaLevelName
  self.bind.txtAreaLevelName = areaLevelName
  self.bind.imgAreaIcon1 = areaIcon
  self.bind.imgAreaIcon = areaIcon
  self.bind.imgCurLvl = fromLvNumIcon
  self.bind.imgNewLvl = toLvNumIcon
  self.bind.btnClose = true
  self.bindComponents.imgNewLv:SetNativeSize()
  self.bindComponents.imgCurLv:SetNativeSize()
end

function page:close(options)
  page.super.close(self, options)
  L_PetDuelStore:toNextAreaLevelUp()
end

return page
