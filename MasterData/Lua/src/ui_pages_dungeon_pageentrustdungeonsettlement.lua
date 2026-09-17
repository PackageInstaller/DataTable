local this = class("pageEntrustDungeonSettlement", G_UIPageBase)

function this.bind()
  return {
    txt_entrustName = "",
    txt_finishTime = "",
    img_finishStar = "",
    list_finishCondition = {
      moduleName = "pages/dungeon/cellEntrustDungeonCondition"
    },
    list_reward_chest = {
      moduleName = "pages/dungeon/cellEntrustDungeonReward"
    },
    active_entrust = true,
    list_reward_entrust = {
      moduleName = "pages/dungeon/cellEntrustDungeonCondition"
    },
    active_imgStar_1 = false,
    active_imgStar_2 = false,
    active_imgStar_3 = false,
    active_rune = false,
    active_rune_tips = false,
    img_icon_rune = "",
    img_quality_rune = "",
    txt_curNum = "",
    txt_needNum = ""
  }
end

function this.methods()
  return {
    btn_restart = function()
    end,
    btn_quit = function()
    end
  }
end

return this
