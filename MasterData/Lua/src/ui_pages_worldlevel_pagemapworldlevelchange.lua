local this = class("pageMapWorldLevelChange", G_UIPageBase)
local _worldDifficultyCityTpl = L_GameTpl:getWorldDifficultyCityTpl()
local _areaTpl = L_GameTpl:getAreaTpl()
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()

function this.bind()
  return {
    txtLvBef = "",
    txtLvCur = "",
    txtMapName = "",
    txtMapName2 = "",
    txtLevel = "",
    txtLevelNew = ""
  }
end

function this.methods()
  return {}
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.bind.txtLvCur = _worldDifficultyCityTpl:getNameByMapIdAndLv(options.mapId, options.lvCur)
  local areaId = _worldAreaTpl:getCurSceneAreaList(options.mapId)[1].id
  local areaListTmp = {}
  for _, v in pairs(_areaTpl.data) do
    if v.worldAreaId == areaId then
      table.insert(areaListTmp, {
        id = v.areaId,
        worldAreaId = v.worldAreaId,
        areaName = v.areaName
      })
    end
  end
  local id = areaListTmp[1].id
  if areaListTmp and 0 < #areaListTmp then
    for _, v in pairs(areaListTmp) do
      if id > v.id then
        id = v.id
      end
    end
  end
  local tpl_area = _areaTpl:getTplById(id)
  self.bind.txtMapName = _areaTpl:getAreaName(tpl_area)
  self.bind.txtMapName2 = _areaTpl:getAreaName(tpl_area)
  self.bind.txtLevel = L_Const.Number2Roma[tonumber(options.lvBef)]
  self.bind.txtLevelNew = L_Const.Number2Roma[options.lvCur]
  L_AudioUtil.playSound("Play_SFX_System_UI_StarDifficult_Switch_Confirm")
  Timer.once(3.5, function()
    L_UI:close(self.pageName)
  end, self)
end

function this:close()
  this.super.close(self)
end

return this
