_class("UIResDetailGroupCell", UICustomWidget)
UIResDetailGroupCell = UIResDetailGroupCell
local StringGet = StringTable.Get

function UIResDetailGroupCell:OnShow()
  self.nameTxt = self:GetUIComponent("UILocalizationText", "name")
  self.descTxt = self:GetUIComponent("UILocalizationText", "desc")
  self.descTxt2 = self:GetUIComponent("UILocalizationText", "desc2")
  self.picImg = self:GetUIComponent("Image", "pic")
  self.chooseGO = self:GetGameObject("choose")
  self.chooseGO:SetActive(false)
  self.subTypeCfg = {
    [DungeonSubType.DungeonSubType_Green] = {
      name = StringGet("str_res_instance_detail_group_sen_name"),
      desc = StringGet("str_res_instance_detail_group_sen_desc"),
      pic = "map_ziyuan_hero1"
    },
    [DungeonSubType.DungeonSubType_Red] = {
      name = StringGet("str_res_instance_detail_group_huo_name"),
      desc = StringGet("str_res_instance_detail_group_huo_desc"),
      pic = "map_ziyuan_hero2"
    },
    [DungeonSubType.DungeonSubType_Blue] = {
      name = StringGet("str_res_instance_detail_group_bing_name"),
      desc = StringGet("str_res_instance_detail_group_bing_desc"),
      pic = "map_ziyuan_hero3"
    },
    [DungeonSubType.DungeonSubType_Yellow] = {
      name = StringGet("str_res_instance_detail_group_lei_name"),
      desc = StringGet("str_res_instance_detail_group_lei_desc"),
      pic = "map_ziyuan_hero4"
    }
  }
  self.atlas = self:GetAsset("UIResInstance.spriteatlas", LoadType.SpriteAtlas)
end

function UIResDetailGroupCell:OnHide()
end

function UIResDetailGroupCell:Init(subType, onClickExpCell, param)
  self.subType = subType
  self.onClickExpCell = onClickExpCell
  self.param = param
  local cfg = self.subTypeCfg[subType]
  self.nameTxt:SetText(cfg.name)
  self.descTxt:SetText(cfg.desc)
  local desc2 = StringGet("str_res_instance_detail_levelup_2")
  self.descTxt2:SetText(desc2)
  self.picImg.sprite = self.atlas:GetSprite(cfg.pic)
end

function UIResDetailGroupCell:Select(select)
  self.chooseGO:SetActive(select)
end

function UIResDetailGroupCell:bgbtnOnClick(go)
  self.onClickExpCell(self.param, self.subType)
end
