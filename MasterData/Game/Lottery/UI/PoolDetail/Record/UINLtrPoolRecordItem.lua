local UINLtrPoolRecordItem = class("UINLtrPoolRecordItem", UIBaseNode)
local base = UIBaseNode

function UINLtrPoolRecordItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLtrPoolRecordItem:InitLtrPoolRecordItem(records)
  self.ui.tex_Time.text = os.date("%y/%m/%d %H:%M:%S", records.ts)
  self.ui.tex_PoolName.text = LanguageUtil.GetLocaleText(ConfigData.lottery_para[records.poolId].name)
  local item = ConfigData.item[records.itemId]
  local star = item.arg[2]
  local count = math.ceil(star / 2)
  local pre = ""
  for i = 1, count do
    pre = pre .. "★"
  end
  if count == 3 then
    self.ui.img_recordItem.color = self.ui.col_ThreeStar
  else
    self.ui.img_recordItem.color = self.ui.col_OtheStar
  end
  local post = ""
  local ltrCfg = ConfigData.lottery_para[records.poolId]
  if ltrCfg ~= nil and records.transform then
    local rankCfg = ConfigData.hero_rank[star]
    local rankItem = ConfigData.item[rankCfg.repeat_extra_trans_id[1]]
    local num = rankCfg.repeat_extra_trans_num[1]
    if ltrCfg.repeat_type == 1 then
      local heroId = item.arg[1]
      num = rankCfg.repeat_frag_trans
      rankItem = ConfigData.item[ConfigData.hero_data[heroId].fragment]
      if ltrCfg.heroUpAllDic ~= nil and ltrCfg.heroUpAllDic[heroId] then
        num = num + ltrCfg.big_prize_extra_num
      end
    end
    post = string.format(ConfigData:GetTipContent(312), LanguageUtil.GetLocaleText(rankItem.name), num)
  end
  self.ui.tex_Result.text = pre .. LanguageUtil.GetLocaleText(item.name) .. post
  if records.way == 1 then
    self.ui.tex_By.text = ConfigData:GetTipContent(313)
  elseif records.way == 2 then
    self.ui.tex_By.text = ConfigData:GetTipContent(315)
  elseif records.way == 3 then
    self.ui.tex_By.text = ConfigData:GetTipContent(314)
  end
end

return UINLtrPoolRecordItem
