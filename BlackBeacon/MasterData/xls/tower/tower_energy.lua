local t = {
  [100101]={
    {
      AttrId=10011,
      AttrMaxId=10013,
      ChangeMagicId=0,
      ChangeTime=5,
      EffectResName={  },
      Id=100101,
      MagicId=4010151,
      Type=1,
      UIResPath={ "UIFight/new/Battle_double_energy", "UIFight/new/Battle_double_energy_shixin" } 
    },
    {
      AttrId=10012,
      AttrMaxId=10014,
      ChangeMagicId=0,
      ChangeTime=5,
      EffectResName=nil,
      Id=100101,
      MagicId=4010148,
      Type=2,
      UIResPath={ "UIFight/new/Battle_double_energy", "UIFight/new/Battle_double_energy_shixin" } 
    } 
  } 
}
t[100101][2].EffectResName = t[100101][1].EffectResName
return t