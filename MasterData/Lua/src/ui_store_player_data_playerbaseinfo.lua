local this = class("playerBaseInfo")

function this:ctor(id)
  self.id = id
  self.name = ""
  self.sex = 0
  self.lv = 0
  self.offlinetm = 0
  self.onlinetm = 0
  self.is_busy = false
  self.wardrobe = {
    parts = {},
    sex = 0,
    height = 0,
    avatars = {}
  }
  self.little_avatar = ""
  self.sign = ""
  self.account = 0
  self.regtm = 0
  self.gold = 0
  self.diamond = 0
  self.naturel = 0
  self.exp = 0
  self.info = {
    achievement = {},
    hero = {},
    pet = {}
  }
  self.detail_info = {}
  self.lend_info = {
    can_lend_num = 0,
    last_lend_time = 0,
    rent_nums = 0,
    today_rent_num = 0,
    last_rent_time = 0
  }
  self.last_change_name_time = 0
  self.birthday = {}
  self.preffix_title = 0
  self.suffix_title = 0
  self.stand_plates = {}
  self.skip_guide = 0
  self.show_case = 0
  self.show_case_id = 0
  self.team_id = 0
  self.map_id = 0
  self.nest_star = 0
  self.nest_guide_finish = 0
end

return this
