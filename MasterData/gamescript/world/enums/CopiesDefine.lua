local CopiesDefine = {}
CopiesDefine.EventType = System.NewEnum({
  Relic = "Relic",
  Battle = "Battle",
  Rest = "Rest",
  Option = "Option",
  Leave = "Leave",
  Born = "Born",
  Shop = "Shop",
  Shift = "Shift",
  Plot = "Plot",
  Hint = "Hint",
  Loot = "Loot",
  Birdseye = "Birdseye",
  Gold = "Gold",
  Skill = "Skill",
  Exit = "Exit",
  Filter = "Filter",
  Bubble = "Bubble",
  Chat = "Chat"
})
CopiesDefine.MinMapShow = System.NewEnum({Hide = "Hide", Show = "Show"})
return CopiesDefine
