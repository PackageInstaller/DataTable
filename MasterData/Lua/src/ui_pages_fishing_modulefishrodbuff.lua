local this = class("moduleFishRodBuff", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _fishRodTpl = L_GameTpl:getFishRodTpl()
local _fishRodBuffTpl = L_GameTpl:getFishRodBuffTpl()

function this.bind()
  return {
    go_fishRodBuff = false,
    list_fishRodBuff = {
      moduleName = "pages/fishing/cellFishingRodBuff"
    }
  }
end

function this.methods()
  return {}
end

function this:setData(rodId, pondId)
  local isFromPond = not math.isEmpty(pondId)
  local tpl_commonItem = _commonItemTpl:getTplById(rodId)
  local subId = _commonItemTpl:getSubId(tpl_commonItem)
  local tpl_rod = _fishRodTpl:getTplById(subId)
  local buffInfo = _fishRodTpl:getBuffInfo(tpl_rod)
  local tmp = {}
  for i, v in pairs(buffInfo) do
    local tpl_buff = _fishRodBuffTpl:getTplById(v)
    local pondIdList = _fishRodBuffTpl:getPondId(tpl_buff)
    local needShow = true
    if isFromPond then
      local node, index = table.ipairsFind(pondIdList, function(id)
        return id == pondId
      end)
      needShow = index ~= nil
    end
    if needShow then
      table.insert(tmp, {
        img_icon = _fishRodBuffTpl:getIconDark(tpl_buff),
        txt_desc = _fishRodBuffTpl:getDesc(tpl_buff)
      })
    end
  end
  self.bind.go_fishRodBuff = not table.isEmpty(tmp)
  self.bind.list_fishRodBuff:clear()
  self.bind.list_fishRodBuff:insert_array(tmp)
end

return this
