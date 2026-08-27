local UINLtrPoolUpHero = class("UINLtrPoolUpHero", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINLtrPoolUpHero:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
end

function UINLtrPoolUpHero:InitLtrPoolUpHero(rewardData, resLoader)
  local resCfg = ConfigData.resource_model[rewardData.heroCfg.src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring(rewardData.heroCfg.src_id))
    return
  end
  self.ui.img_Hero.texture = nil
  resLoader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(resCfg.res_Name), function(texture)
    if IsNull(texture) then
      return
    end
    self.ui.img_Hero.texture = texture
  end)
  local careerCfg = ConfigData.career[rewardData.heroCfg.career]
  self.ui.img_Carrer.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(rewardData.heroCfg.name)
  local rewardCfg = rewardData.rewardCfg
  self.rewardCfg = rewardCfg
  local lock = not CheckCondition.CheckLua(rewardCfg.pre_condition, rewardCfg.pre_para1, rewardCfg.pre_para2)
  self.ui.lock:SetActive(lock)
  self.lock = lock
  self:_IsRateUp(rewardData.upHero)
end

function UINLtrPoolUpHero:_OnClickRoot()
  if self.lock then
    local lockInfo = CheckCondition.GetUnlockInfoLua({
      self.rewardCfg.pre_condition[1]
    }, {
      self.rewardCfg.pre_para1[1]
    }, {
      self.rewardCfg.pre_para2[1]
    })
    cs_MessageCommon.ShowMessageTips(lockInfo)
  end
end

function UINLtrPoolUpHero:_IsRateUp(bool)
  self.ui.obj_rateUp:SetActive(bool)
end

function UINLtrPoolUpHero:OnDelete()
  base.OnDelete(self)
end

return UINLtrPoolUpHero
