local UINFormationBondNode = class("UINFormationBondNode", UIBaseNode)
local base = UIBaseNode
local UINFormationBondItem = require("Game.Formation.UI.Bond.UINFormationBondItem")
local UINBondFloat = require("Game.Formation.UI.Bond.UINFormationBondFloat")

function UINFormationBondNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_buff, self, self.OnClickBuff)
  UIUtil.AddButtonListener(self.ui.btn_checkDetails, self, self.OnClickBondDetail)
  self.bondInfoPool = UIItemPool.New(UINFormationBondItem, self.ui.obj_bondItem)
  self.ui.obj_bondItem:SetActive(false)
  self.resloader = CS.ResLoader.Create()
  self._floatNode = UINBondFloat.New()
  self._floatNode:Init(self.ui.obj_details)
  self.ui.obj_details:SetActive(false)
  self._clickItemFunc = BindCallback(self, self.OnBondItemClick)
end

function UINFormationBondNode:InitBondNode(fmtCtrl, enterFmtData)
  self:Show()
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
  local buffId = self.enterFmtData:GetBondBuffId()
  local buffCfg = ConfigData.activity_bond_transfer_buff[buffId]
  if buffCfg ~= nil then
    self.ui.img_buff.sprite = AtlasUtil.GetSpriteFromAtlas("BondIcon", buffCfg.buff_icon, self.resloader)
    self.ui.tex_buff.text = LanguageUtil.GetLocaleText(buffCfg.buff_name)
    self.ui.obj_protocol:SetActive(true)
  else
    self.ui.obj_protocol:SetActive(false)
  end
  self:RefreshUIBond()
end

function UINFormationBondNode:RefreshUIBond()
  local actId = self.enterFmtData:GetBondActId()
  local fmtData = self.fmtCtrl:GetFmtCtrlFmtData()
  local heroDic = fmtData:GetFormationHeroDic()
  local careerTab = {}
  local campTab = {}
  for k, v in pairs(heroDic) do
    local heroData = fmtData:GetHeroDataInFmt(v)
    if heroData ~= nil then
      local career = heroData.career
      local camp = heroData.camp
      if careerTab[career] == nil then
        careerTab[career] = 0
      end
      if campTab[camp] == nil then
        campTab[camp] = 0
      end
      careerTab[career] = careerTab[career] + 1
      campTab[camp] = campTab[camp] + 1
    end
  end
  local buffId = self.enterFmtData:GetBondBuffId()
  local buffCfg = ConfigData.activity_bond_transfer_buff[buffId]
  if buffCfg ~= nil then
    local effect = buffCfg.buff_effect
    for k, v in pairs(effect) do
      if careerTab[k] ~= nil then
        local count = careerTab[v] or 0
        careerTab[v] = careerTab[k] + count
      end
    end
  end
  local bondIdDic = {}
  for k, count in pairs(careerTab) do
    local bondId = ConfigData.activity_bond_bond[actId].careerBondDic[k]
    local tempCount = bondIdDic[bondId] or 0
    bondIdDic[bondId] = count + tempCount
  end
  for k, count in pairs(campTab) do
    local bondId = ConfigData.activity_bond_bond[actId].campBondDic[k]
    local tempCount = bondIdDic[bondId] or 0
    bondIdDic[bondId] = count + tempCount
  end
  local bondStageList = {}
  local effectBondIdDic = {}
  local reduceNum = 0
  for bondId, count in pairs(bondIdDic) do
    local isEffectBond = ConfigData.activity_bond_stage.IsEffectBond[bondId]
    if isEffectBond then
      local bondStagCfgs = ConfigData.activity_bond_stage[bondId]
      local curStageCfg, nextStageCfg
      for stage, cfg in ipairs(bondStagCfgs) do
        nextStageCfg = cfg
        if count < cfg.hero_num then
          break
        end
        curStageCfg = cfg
      end
      if curStageCfg ~= nil then
        for k, bondId in pairs(curStageCfg.effect_bond_id) do
          effectBondIdDic[bondId] = true
        end
        reduceNum = curStageCfg.reduce_num
      end
      local bondStageData = {}
      bondStageData.curStageCfg = curStageCfg
      bondStageData.nextStageCfg = nextStageCfg
      bondStageData.curCount = count
      bondStageData.nextCount = bondStageData.nextStageCfg.hero_num
      bondStageData.bondId = bondId
      if curStageCfg ~= nil then
        bondStageData.stage = curStageCfg.stage
      else
        bondStageData.stage = 0
      end
      table.insert(bondStageList, bondStageData)
    end
  end
  for bondId, count in pairs(bondIdDic) do
    local isEffectBond = ConfigData.activity_bond_stage.IsEffectBond[bondId]
    if not isEffectBond then
      local realCount = count
      if effectBondIdDic[bondId] == true then
        realCount = count + reduceNum
      end
      local bondStagCfgs = ConfigData.activity_bond_stage[bondId]
      local curStageCfg, nextStageCfg
      for stage, cfg in ipairs(bondStagCfgs) do
        nextStageCfg = cfg
        if realCount < cfg.hero_num then
          break
        end
        curStageCfg = cfg
      end
      local bondStageData = {}
      bondStageData.curStageCfg = curStageCfg
      bondStageData.nextStageCfg = nextStageCfg
      bondStageData.bondId = bondId
      bondStageData.curCount = count
      bondStageData.nextCount = bondStageData.nextStageCfg.hero_num
      if effectBondIdDic[bondId] == true then
        bondStageData.nextCount = bondStageData.nextCount - reduceNum
        if 0 >= bondStageData.nextCount then
          bondStageData.nextCount = 1
        end
      end
      if curStageCfg ~= nil then
        bondStageData.stage = curStageCfg.stage
      else
        bondStageData.stage = 0
      end
      table.insert(bondStageList, bondStageData)
    end
  end
  table.sort(bondStageList, function(a, b)
    if a.stage ~= b.stage then
      return a.stage > b.stage
    elseif a.curCount ~= b.curCount then
      return a.curCount > b.curCount
    else
      return a.bondId < b.bondId
    end
  end)
  self.bondInfoPool:HideAll()
  for k, v in ipairs(bondStageList) do
    local item = self.bondInfoPool:GetOne()
    local bondCfg = ConfigData.activity_bond_bond[actId][v.bondId]
    if bondCfg ~= nil then
      item:InitBondItem(v, bondCfg.bond_icon, self.resloader, self._clickItemFunc)
    end
  end
end

function UINFormationBondNode:OnClickBuff()
  local buffId = self.enterFmtData:GetBondBuffId()
  local buffCfg = ConfigData.activity_bond_transfer_buff[buffId]
  if buffCfg ~= nil then
    local name = buffCfg.buff_name
    local des = buffCfg.buff_des
    self._floatNode:InitBondFloat(self.ui.img_buff.transform, name, des)
    self._floatNode:Show()
  end
end

function UINFormationBondNode:OnBondItemClick(bondItem, bondStageData)
  local name = bondStageData.curStageCfg.stage_name
  local des = bondStageData.curStageCfg.buff_des
  self._floatNode:InitBondFloat(bondItem.transform, name, des)
  self._floatNode:Show()
end

function UINFormationBondNode:OnClickBondDetail()
  local bondData
  local bondCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBond)
  if bondCtrl ~= nil then
    bondData = bondCtrl:GetActDataByActId(self.enterFmtData:GetBondActId())
  end
  if bondData ~= nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.ActBondDetails, function(win)
      if win == nil then
        return
      end
      win:InitBondDetail(bondData)
    end)
  end
end

function UINFormationBondNode:OnDelete()
  self.bondInfoPool:DeleteAll()
  self.fmtCtrl = nil
  self.enterFmtData = nil
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self._floatNode:Delete()
  base.OnDelete(self)
end

return UINFormationBondNode
