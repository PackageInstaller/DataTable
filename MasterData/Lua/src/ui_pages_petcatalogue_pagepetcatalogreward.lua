local page = class("pagePetCatalogReward", G_UIPageBase)
local _petTpl = L_GameTpl:getPetTpl()
local _iconographyLevelTpl = L_GameTpl:getIconographyLevelTpl()
local _iconographyTypeTpl = L_GameTpl:getIconographyTypeTpl()
local _battleTpl = L_GameTpl:getBattleInfoTpl()
local _elementTpl = L_GameTpl:getElementTypeTpl()

function page:ctor(...)
  page.super.ctor(self, ...)
  self.data = {}
end

function page:created(obj, pageConfig)
  page.super.created(self, obj, pageConfig)
end

function page.bind()
  return {
    listTaskPreview = {
      moduleName = "pages/petCatalogue/cellExploreReward"
    },
    activeBtnGetAll = false
  }
end

function page.methods()
  return {
    onClickPreviewBG = function(self)
      L_UI:close(self.pageName)
    end,
    onClickGetAll = function(self)
      L_CatalogStore:tryGetReward()
    end
  }
end

function page:preOpen(options)
  self._petId = options.petId
  self.openCallback = options.openCallback
  self.closeCallback = options.closeCallback
  if self.openCallback then
    self.openCallback()
  end
  self.bind.listTaskPreview:clear()
  local petData = L_CatalogStore:getPetCatalogByPetId(self._petId) or {}
  local curLv = petData.lv or 1
  local preview = {}
  for i = 1, 10 do
    local textTip = ""
    if i == L_GameTpl:getGameConstTpl():getData("ICONOGRAPHYLEVEL_UNLOCK_HABITAT", L_Const.GameTplType.int) then
      textTip = L_Lang:get(L_WordsTpl:getValue("ui_iconography_habitat"))
    end
    local _levelTpl = _iconographyLevelTpl:getTplByLvPetId(i, self._petId)
    local petTpl = _petTpl:getTplById(self._petId)
    local petName = _petTpl:getName(petTpl)
    if _levelTpl.attrReward then
      for _, reward in ipairs(_levelTpl.attrReward) do
        if string.len(textTip) > 0 then
          textTip = textTip .. "<br>"
        end
        local typeTpl = _iconographyTypeTpl:getTplById(reward)
        for _, attr in pairs(typeTpl.abilities) do
          local attrId = attr[1]
          local attrVal = attr[2]
          if typeTpl.rewardtype and typeTpl.rewardtype == 5009 then
            textTip = textTip .. L_Lang:get(L_WordsTpl:getValue("ui_iconography_attributeaward_01"), {
              [0] = petName,
              [1] = _battleTpl:getName(_battleTpl:getTplById(attrId)),
              [2] = tostring(attrVal)
            })
          elseif typeTpl.rewardtype and typeTpl.rewardtype == 5010 then
            local eTpl = _elementTpl:getTplById(_petTpl:getFirstElement(petTpl))
            local elementName = _elementTpl:getAbbrName(eTpl)
            textTip = textTip .. L_Lang:get(L_WordsTpl:getValue("ui_iconography_attributeaward_02"), {
              [0] = elementName,
              [1] = _battleTpl:getName(_battleTpl:getTplById(attrId)),
              [2] = tostring(attrVal)
            })
          end
        end
      end
    end
    if 1 < i then
      local _prevLevelTpl = _iconographyLevelTpl:getTplByLvPetId(i - 1, self._petId)
      if _prevLevelTpl.surveycoefficient < _levelTpl.surveycoefficient then
        if string.len(textTip) > 0 then
          textTip = textTip .. "<br>"
        end
        textTip = textTip .. L_Lang:get(L_WordsTpl:getValue("ui_iconography_catchrate"), {
          [0] = petName
        })
      end
    end
    if 1 < i then
      table.insert(preview, {
        needSelect = i == 10 and i == curLv or i == curLv + 1,
        reward = _iconographyLevelTpl:getReward(_levelTpl),
        icon = _levelTpl.iconparticulars,
        iconTxt = _iconographyLevelTpl:getText(_levelTpl),
        isComplete = i <= curLv,
        text = textTip
      })
    end
  end
  self.bind.listTaskPreview:insert_array(preview)
end

function page:open()
end

function page:show()
  self:refreshRewardBtnActive()
  L_CatalogStore:listenCallFunc(L_CatalogStore.event.getCatalogReward, self.onEvent_getCatalogReward, self)
end

function page:close()
  if self.closeCallback then
    self.closeCallback()
  end
end

function page:hide()
  L_CatalogStore:unListenCallFunc(L_CatalogStore.event.getCatalogReward, self.onEvent_getCatalogReward, self)
end

function page:refreshRewardBtnActive()
  self.bind.activeBtnGetAll = L_CatalogStore:checkCanGetReward()
end

function page:onEvent_getCatalogReward()
  self:refreshRewardBtnActive()
end

return page
