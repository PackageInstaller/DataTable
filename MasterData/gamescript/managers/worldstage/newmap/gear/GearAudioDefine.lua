local t = {}
t.GearTypeAudio = {
  [CommonDefine.GearItemType.Door] = {
    eventId = "EXPLORE_DOORLOCK_POP"
  },
  [CommonDefine.GearItemType.Camp] = {
    eventId = "EXPLORE_CONTACT_POP"
  },
  [CommonDefine.GearItemType.Beacon] = {
    eventId = "EXPLORE_FOGCRYSTAL_POP"
  },
  [CommonDefine.GearItemType.Shop] = {
    eventId = "EXPLORE_SHOP_POP"
  },
  [CommonDefine.GearItemType.Obstacle] = {
    eventId = "EXPLORE_PHANTOM_POP"
  },
  [CommonDefine.GearItemType.Transport] = {
    eventId = "EXPLORE_PASSAGE_POP"
  },
  [CommonDefine.GearItemType.SingleTransport] = {
    eventId = {
      "EXPLORE_SECRETAISLE_POP",
      "EXPLORE_SECRETAISLEOUT_POP"
    }
  },
  [CommonDefine.GearItemType.StageGroup_1_Talent] = {
    eventId = "Play_Explore_ResonanceEvent_Popup"
  },
  [CommonDefine.GearItemType.Event] = {
    eventId = "EXPLORE_RANDOMEVENT_POP"
  }
}
return t
