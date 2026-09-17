local this = class("moduleBattlePetCatchSelectSphere", G_UIModuleBase)

function this.bind()
  return {
    moduleSphereItemList = {
      moduleName = "pages/battle/moduleBattlePetCatchSphereItem"
    },
    selectedQCnt = "0",
    selectedQImg = "",
    roulettePointerRot = L_Vector3.new(0, 0, 45),
    rouletteSelect = L_Vector3.new(0, 0, 45),
    goClose = false
  }
end

function this.methods()
  return {
    moduleSphereItemList = {
      onClick_sphere = function(self, sphereId, cnt, quality, icon)
        self:emit("onClick_sphere", sphereId, cnt, quality, icon)
        local sphereData = {
          sphereId = sphereId,
          cnt = cnt,
          quality = quality,
          icon = icon
        }
        if 0 < cnt then
          self:refreshSelectedSphere(sphereData)
          local keyString = table.concat({
            tostring(L_PlayerStore:getPlayerId()),
            "_",
            "SelectedCapturePetBall"
          })
          C_PlayerPrefsUtility.SetInt(keyString, quality)
          local saveData = {
            sphereId = sphereId,
            cnt = cnt,
            quality = quality
          }
          L_BattleDataManager:setCapturePetBallData(saveData)
        end
      end
    },
    onClick_selected = function(self)
      self:onClick_selected()
    end,
    onClick_close = function(self)
      if self.selectListShow then
        self.bind.goClose = false
        self.bindComponents.selectSphereAnime:Play("anim_mountwheel_out")
      end
      self.selectListShow = false
      self.parent:set_select(self.selectListShow)
    end
  }
end

function this:onClick_selected()
  local select = not self.selectListShow
  if select then
    self.bindComponents.selectSphereAnime:Play("anim_mountwheel_in")
    self.bind.goClose = true
  else
    self.bindComponents.selectSphereAnime:Play("anim_mountwheel_out")
    self.bind.goClose = false
  end
  self.selectListShow = select
  self.parent:set_select(select)
end

function this:open()
  self.selectListShow = false
  self.cShortCutEnable = true
  local data = C_BagMgr:GetAllCapturePetBall()
  local size = data.Count
  local sphereDatas = {}
  local keyString = table.concat({
    tostring(L_PlayerStore:getPlayerId()),
    "_",
    "SelectedCapturePetBall"
  })
  if CS.Lens.Gameplay.Modules.BigWorld.Macro.IsBattleSimulator then
    local iconPath = {
      "Battle/tex_petcapture_icon_greysj.png",
      "Battle/tex_petcapture_icon_greensj.png",
      "Battle/tex_petcapture_icon_purplesj.png",
      "Battle/tex_petcapture_icon_bluesj.png",
      "Battle/tex_petcapture_icon_goldsj.png"
    }
    for i = 5, 1, -1 do
      local sphereData = {
        sphereId = 1000000 + i,
        cnt = 6 * (i - 1),
        quality = i - 1,
        icon = iconPath[i]
      }
      table.insert(sphereDatas, sphereData)
    end
    local qualityInt = C_PlayerPrefsUtility.GetInt(keyString)
    local data = {
      cnt = qualityInt * 6,
      icon = iconPath[qualityInt + 1],
      quality = qualityInt,
      sphereId = 1000001 + qualityInt
    }
    L_BattleDataManager:setCapturePetBallData(data)
    self:refreshSelectedSphere(data)
  else
    local qualityInt = C_PlayerPrefsUtility.GetInt(keyString)
    local quaCnt = 0
    local saveId = 0
    local iconPath = ""
    for i = size, 1, -1 do
      local sphereData = {
        sphereId = data[i].id,
        cnt = data[i].num,
        quality = data[i].quality,
        icon = data[i].icon
      }
      if qualityInt == data[i].quality then
        quaCnt = data[i].num
        saveId = data[i].id
        iconPath = data[i].icon
      end
      table.insert(sphereDatas, sphereData)
    end
    local data = {
      cnt = quaCnt,
      icon = iconPath,
      quality = qualityInt,
      sphereId = saveId
    }
    if saveId ~= 0 then
      L_BattleDataManager:setCapturePetBallData(data)
      self:refreshSelectedSphere(data)
    end
  end
  self.bind.moduleSphereItemList:insert_array(sphereDatas)
end

function this:close()
  L_ShortCutManager:removeShortCut(self.parent.pageName)
end

function this:refreshSelectedSphere(data)
  local cnt = tostring(data.cnt)
  local icon = data.icon
  local quality = data.quality
  self:rotArrow(quality)
  self.bind.selectedQCnt = cnt
  self.bind.selectedQImg = icon
end

function this:rotArrow(quality)
  local rot = (math.abs(quality - 4) + 1) * 45
  self.bind.roulettePointerRot = L_Vector3.new(0, 0, rot)
  self.bind.rouletteSelect = L_Vector3.new(0, 0, rot)
  self.bindComponents.rouletteSelectAnime:Stop()
  self.bindComponents.rouletteSelectAnime:Play()
end

function this:refreshSelectedSphereCnt()
  local data = C_BagMgr:GetAllCapturePetBall()
  local keyString = table.concat({
    tostring(L_PlayerStore:getPlayerId()),
    "_",
    "SelectedCapturePetBall"
  })
  local qualityInt = C_PlayerPrefsUtility.GetInt(keyString)
  local itemList = self.bind.moduleSphereItemList
  for i = 1, #itemList do
    local cnt = data[6 - i - 1].num
    itemList:getItemCls(i):refreshCnt(cnt)
    if qualityInt == data[6 - i - 1].quality then
      self.bind.selectedQCnt = tostring(cnt)
    end
  end
end

function this:setCShortCutEnable(enable)
  self.cShortCutEnable = enable
  if enable == false then
    self.methods.onClick_close(self)
  end
end

return this
