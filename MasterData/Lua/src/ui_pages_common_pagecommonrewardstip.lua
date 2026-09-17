local this = class("pageCommonRewardsTip", G_UIPageBase)

function this.bind()
  return {
    txt_titleName = "",
    module_list = {
      moduleName = "pages/common/modules/cellCommonRewardsItem"
    },
    focusItemIndex = 0
  }
end

function this.methods()
  return {
    onclick_btn_close = function()
      L_UI:close("pageCommonRewardsTip")
    end
  }
end

function this:open(options)
  L_AudioUtil.playSound("Play_SFX_System_UI_General_Frame_Award_Open")
  self.bind.txt_titleName = options.title or L_WordsTpl:getValue("ui_common_rewardlist_title_starflair")
  self:refershModule(options.module_list or {}, options.selectIndex)
end

function this:refershModule(moduleList, index)
  self.bind.module_list:clear()
  if type(moduleList) ~= "table" or #moduleList == 0 then
    print("[pageCommonRewardsTip] 奖励配置为空")
    return
  end
  local safeModuleList = {}
  for _, subItem in ipairs(moduleList) do
    local safeSubItem = table.clone(subItem)
    safeSubItem.rewardList = type(safeSubItem.rewardList) == "table" and safeSubItem.rewardList or {}
    table.insert(safeModuleList, safeSubItem)
  end
  self.bind.module_list:insert_array(safeModuleList)
  if index and type(index) == "number" then
    local targetIdx = math.max(0, index - 1)
    self.bind.focusItemIndex = targetIdx < #safeModuleList and targetIdx or 0
  else
    self.bind.focusItemIndex = 0
  end
end

return this
